Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EED64F473E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350457AbiDEVEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447829AbiDEPrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:47:11 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1184BEBACD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6g3c5Q4Z/LFu4/Wrn12KWc9/StZCVYQpQv1kSUWt60A=; b=VwKt43XP5gw6bL5HbiyH/2sGot
        OPyWtJ8GTb4SrAqYDwSxRvzREnSaXHYxxa40hhh8pL/SPdyIRy7GKqQ53M9E3V+4TYQptsWR98OEA
        EydmtKrm8FcuEeBCNFXZSNI51Xaq7vDxxqlRi283FByw2Y22e16EDnTnR7TVupJZqoiGOMXAwJgj7
        HXkn7L5Og7eFDOfVTzfwoHJVbyJtCG3XSfEyOEa0P2BOUoDLVV3VmZj4JFVCc0lhwNzOavYR4pfEX
        zDGRoUzYTZprRusFa5rgrf9Hwl7bmL6LURY97eQ3MTAqA9TWfRL5v14YGjWPH8gwSj3cxCrB1q+Dn
        HYCeVoAA==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbk6O-002oq7-Ut; Tue, 05 Apr 2022 14:24:13 +0000
Date:   Tue, 5 Apr 2022 14:24:12 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v7 1/8] kernfs: Introduce interface to access
 global kernfs_open_file_mutex.
Message-ID: <YkxRDJ2ynEHGdjeT@zeniv-ca.linux.org.uk>
References: <20220317072612.163143-1-imran.f.khan@oracle.com>
 <20220317072612.163143-2-imran.f.khan@oracle.com>
 <YjOpedPDj+3KCJjk@zeniv-ca.linux.org.uk>
 <10b5d071-7f69-da59-6395-064550c6c6cb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10b5d071-7f69-da59-6395-064550c6c6cb@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 03:36:03PM +1000, Imran Khan wrote:
> Hello Al,
> 
> On 18/3/22 8:34 am, Al Viro wrote:
> > On Thu, Mar 17, 2022 at 06:26:05PM +1100, Imran Khan wrote:
> > 
> >> @@ -570,9 +571,10 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
> >>  				 struct kernfs_open_file *of)
> [...]
> 
> > As the matter of fact, we can do even better - make freeing
> > that thing rcu-delayed, use rcu_assign_pointer() for stores,
> > rcu_dereference() for loads and have kernfs_notify() do
> > 	rcu_read_lock();
> > 	on = rcu_dereference(kn->attr.open);
> > 	if (on) {
> > 		atomic_inc(&on->event);
> > 		wake_up_interruptible(&on->poll);
> > 	}
> > 	rcu_read_unlock();
> > and kernfs_open_node_lock becomes useless - all places that
> > grab it are under kernfs_open_file_mutex.
> 
> There are some issues in freeing ->attr.open under RCU callback.

Such as?

> There
> are some users of ->attr.open that can block and hence can't operate
> under rcu_read_lock. For example in kernfs_drain_open_files we are
> traversing list of open files corresponding to ->attr.open and unmapping
> those as well. The unmapping operation can block in i_mmap_lock_write.

Yes.

> So even after removing refcnt we will still need kernfs_open_node_lock.

What for?  Again, have kernfs_drain_open_files() do this:
{
        struct kernfs_open_node *on;
	struct kernfs_open_file *of;

	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
		return;
	if (rcu_dereference(kn->attr.open) == NULL)
		return;
	mutex_lock(&kernfs_open_file_mutex);
	// now ->attr.open is stable (all stores are under kernfs_open_file_mutex)
	on = rcu_dereference(kn->attr.open);
	if (!on) {
		mutex_unlock(&kernfs_open_file_mutex);
		return;
	}
	// on->files contents is stable
	list_for_each_entry(of, &on->files, list) {
		struct inode *inode = file_inode(of->file);

		if (kn->flags & KERNFS_HAS_MMAP)
			unmap_mapping_range(inode->i_mapping, 0, 0, 1);

		if (kn->flags & KERNFS_HAS_RELEASE)
			kernfs_release_file(kn, of);
	}
	mutex_unlock(&kernfs_open_file_mutex);
}

What's the problem?  The caller has already guaranteed that no additions will
happen.  Once we'd grabbed kernfs_open_file_mutex, we know that
	* kn->attr.open value won't change until we drop the mutex
	* nothing gets removed from kn->attr.open->files until we drop the mutex
so we can bloody well walk that list, blocking as much as we want.

We don't need rcu_read_lock() there - we are already holding the mutex used
by writers for exclusion among themselves.  RCU *allows* lockless readers,
it doesn't require all readers to be such.  kernfs_notify() can be made
lockless, this one can't and that's fine.

BTW, speaking of kernfs_notify() - can calls of that come from NMI handlers?
If not, I'd consider using llist for kernfs_notify_list...
