Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F114DD045
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 22:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiCQVi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 17:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiCQViZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 17:38:25 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [142.44.231.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69B81AFEBA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 14:37:07 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUxlh-00D2DF-HM; Thu, 17 Mar 2022 21:34:49 +0000
Date:   Thu, 17 Mar 2022 21:34:49 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v7 1/8] kernfs: Introduce interface to access
 global kernfs_open_file_mutex.
Message-ID: <YjOpedPDj+3KCJjk@zeniv-ca.linux.org.uk>
References: <20220317072612.163143-1-imran.f.khan@oracle.com>
 <20220317072612.163143-2-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317072612.163143-2-imran.f.khan@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 06:26:05PM +1100, Imran Khan wrote:

> @@ -570,9 +571,10 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
>  				 struct kernfs_open_file *of)
>  {
>  	struct kernfs_open_node *on = kn->attr.open;
> +	struct mutex *mutex = NULL;
>  	unsigned long flags;
>  
> -	mutex_lock(&kernfs_open_file_mutex);
> +	mutex = kernfs_open_file_mutex_lock(kn);
>  	spin_lock_irqsave(&kernfs_open_node_lock, flags);

Can that ever be reached with local interrupts disabled?  I mean, what is
that spin_lock_irqsave() about?

> @@ -745,11 +747,12 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
>  {
>  	struct kernfs_node *kn = inode->i_private;
>  	struct kernfs_open_file *of = kernfs_of(filp);
> +	struct mutex *lock = NULL;
>  
>  	if (kn->flags & KERNFS_HAS_RELEASE) {
> -		mutex_lock(&kernfs_open_file_mutex);
> +		lock = kernfs_open_file_mutex_lock(kn);
>  		kernfs_release_file(kn, of);
> -		mutex_unlock(&kernfs_open_file_mutex);
> +		mutex_unlock(lock);

Careful - you are about to remove the existing exclusion between *all*
->release() instances, same node or not.

In particular, if some driver had them manipulate a driver-local list of
some kind, relying upon the kernfs to provide the exclusion, it'd break
as soon as you turn that thing into per-node (or hashed) mutex.

It's _probably_ safe, seeing that the one and only instance of ->release()
in the entire tree (cgroup_file_release()) is rather limited in what
it's doing, and while it calls a submethod (cftype.release()) there's only
a couple of instances of that (cgroup_procs_release() and
cgroup_pressure_release(), both in kernel/cgroup/cgroup.c).  Neither
seems to rely upon the global exclusion.

However, that's a change of rules and it needs to be documented as such.

Incidentally, what's the point of having kernfs_open_node->refcnt
atomic_t?  All users are under kernfs_open_node_lock...  AFAICS,
it's simply "->files is non-empty or something is in
kernfs_drain_open_files() for the node in question", so I'm not
even sure we want a counter there...

Note that kernfs_drain_open_files() can't overlap with
kernfs_fops_open() adding to the list of files (and we seriously
rely upon that - you don't want ops->release() called while in
the middle of ops->open()).  kernfs_fops_open() starts with
grabbing an active reference; kernfs_drain_open_files() is
not called until we had
	* prevented new active references being grabbed and
	* waited for all active references to be dropped.

So kernfs_drain_open_files() can do the following:
	1) optimistically check for ->attr.open being NULL;
bugger off if it is.  We know that nobody could be currently
trying to add anything to it, mutex or no mutex.
	2) grab the mutex
	3) recheck ->attr.open; it might have become NULL.
If it had, unlock and bugger off.
	4) walk the list, doing unmaps/releases.
	5) unlock and bugger off.
The only thing doing removals from the list is
kernfs_put_open_node() and it grabs that mutex.
So it can't get to the "remove from list, free the container
of list head" until we are through.

IOW, there's no reason to hold a reference to kernfs_open_node
in kernfs_drain_open_files() at all.  And that makes ->refcnt
completely useless - kernfs_put_open_node() should do
	list_del(&of->list);
	if (list_empty(&on->files))
		kn->attr.open = NULL;
	else
		on = NULL;
and to hell with refcounting.

As the matter of fact, we can do even better - make freeing
that thing rcu-delayed, use rcu_assign_pointer() for stores,
rcu_dereference() for loads and have kernfs_notify() do
	rcu_read_lock();
	on = rcu_dereference(kn->attr.open);
	if (on) {
		atomic_inc(&on->event);
		wake_up_interruptible(&on->poll);
	}
	rcu_read_unlock();
and kernfs_open_node_lock becomes useless - all places that
grab it are under kernfs_open_file_mutex.
