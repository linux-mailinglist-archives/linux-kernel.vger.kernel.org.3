Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9DC4B7CB7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244356AbiBPBrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:47:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbiBPBrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:47:02 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E852A267
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:46:51 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nK9P5-0028QH-Eg; Wed, 16 Feb 2022 01:46:47 +0000
Date:   Wed, 16 Feb 2022 01:46:47 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/7] kernfs: Introduce hashed rw-sem to replace per-fs
 kernfs_rwsem.
Message-ID: <YgxXh3clQqpxUPba@zeniv-ca.linux.org.uk>
References: <20220214120322.2402628-1-imran.f.khan@oracle.com>
 <20220214120322.2402628-7-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214120322.2402628-7-imran.f.khan@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 11:03:21PM +1100, Imran Khan wrote:

> +static inline void down_write_kernfs_rwsem_for_two_nodes(struct kernfs_node *kn1,
> +							 struct kernfs_node *kn2)
> +{
> +	struct rw_semaphore *rwsem1 = kernfs_rwsem_ptr(kn1);
> +	struct rw_semaphore *rwsem2 = kernfs_rwsem_ptr(kn2);
> +
> +	if (rwsem1 == rwsem2)
> +		down_write_nested(rwsem1, 0);
> +	else {
> +		if (rwsem1 < rwsem2) {
> +			down_write_nested(rwsem1, 0);
> +			down_write_nested(rwsem2, 1);
> +		} else {
> +			down_write_nested(rwsem2, 0);
> +			down_write_nested(rwsem1, 1);
> +		}
> +	}
> +	kernfs_get(kn1);
> +	kernfs_get(kn2);

	What's the last bit for?  Do you expect the caller to grab that,
then drop references, then pass the same references to up_write_.....?
Explain, please.  Is there any caller that would *not* have the matching
up_write_... in the same function, BTW?

Just in case - "defensive programming" is not a good answer (to just about any
question, TBH)...

> +static inline void down_write_kernfs_rwsem(struct kernfs_node *kn,
> +				      enum kernfs_rwsem_lock_pattern ptrn)
> +{
> +	struct rw_semaphore *p_rwsem = NULL;
> +	struct rw_semaphore *rwsem = kernfs_rwsem_ptr(kn);
> +	int lock_parent = 0;
> +
> +	if (ptrn == KERNFS_RWSEM_LOCK_SELF_AND_PARENT && kn->parent)
> +		lock_parent = 1;
> +
> +	if (lock_parent)
> +		p_rwsem = kernfs_rwsem_ptr(kn->parent);

Er...  And what's to prevent ->parent changing right under you?  For that
matter, why bother with that at all - what's wrong with your "lock two
nodes" primitive?  AFAICS, your current series has only one caller passing
that flag, so...

Note that ->unlock_parent thing is also dubious - the matching up_write_...
for that sole caller is in the same function, so it could bloody well
choose between single-up and double-up on its own.  Would make the whole
thing simpler...

> +/**
> + * down_read_kernfs_rwsem() - Acquire hashed rwsem
> + *
> + * @kn: kernfs_node for which hashed rwsem needs to be taken
> + * @ptrn: locking pattern i.e whether to lock only given node or to lock
> + *	  node and its parent as well
> + *
> + * In case of nested locking, rwsem with lower address is acquired first.
> + *
> + * Return: void
> + */

... and this one, AFAICS, doesn't need ptrn at all - no callers that would ask to
lock parent.

> +static inline void kernfs_swap_rwsems(struct rw_semaphore **array, int i, int j)
> +{
> +	struct rw_semaphore *tmp;
> +
> +	tmp = array[i];
> +	array[i] = array[j];
> +	array[j] = tmp;
> +}
> +
> +static inline void kernfs_sort_rwsems(struct rw_semaphore **array)
> +{
> +	if (array[0] > array[1])
> +		kernfs_swap_rwsems(array, 0, 1);
> +
> +	if (array[0] > array[2])
> +		kernfs_swap_rwsems(array, 0, 2);
> +
> +	if (array[1] > array[2])
> +		kernfs_swap_rwsems(array, 1, 2);
> +}
> +
> +/**
> + * down_write_kernfs_rwsem_rename_ns() - take hashed rwsem during
> + * rename or similar operations.
> + *
> + * @kn: kernfs_node of interest
> + * @current_parent: current parent of kernfs_node of interest
> + * @new_parent: about to become new parent of kernfs_node
> + *
> + * During rename or similar operations the parent of a node changes,
> + * and this means we will see different parents of a kernfs_node at
> + * the time of taking and releasing its or its parent's hashed rwsem.
> + * This function separately takes locks corresponding to node, and
> + * corresponding to its current and future parents (if needed).
> + *
> + * Return: void
> + */
> +static inline void down_write_kernfs_rwsem_rename_ns(struct kernfs_node *kn,
> +					struct kernfs_node *current_parent,
> +					struct kernfs_node *new_parent)
> +{
> +	struct rw_semaphore *array[3];
> +
> +	array[0] = kernfs_rwsem_ptr(kn);
> +	array[1] = kernfs_rwsem_ptr(current_parent);
> +	array[2] = kernfs_rwsem_ptr(new_parent);
> +
> +	if (array[0] == array[1] && array[0] == array[2]) {
> +		/* All 3 nodes hash to same rwsem */
> +		down_write_nested(array[0], 0);
> +	} else {
> +		/**
> +		 * All 3 nodes are not hashing to the same rwsem, so sort the
> +		 * array.
> +		 */
> +		kernfs_sort_rwsems(array);
> +
> +		if (array[0] == array[1] || array[1] == array[2]) {
> +			/**
> +			 * Two nodes hash to same rwsem, and these
> +			 * will occupy consecutive places in array after
> +			 * sorting.
> +			 */
> +			down_write_nested(array[0], 0);
> +			down_write_nested(array[2], 1);
> +		} else {
> +			/* All 3 nodes hashe to different rwsems */
> +			down_write_nested(array[0], 0);
> +			down_write_nested(array[1], 1);
> +			down_write_nested(array[2], 2);
> +		}
> +	}
> +
> +	kernfs_get(kn);
> +	kernfs_get(current_parent);
> +	kernfs_get(new_parent);
> +}

Holy shit...  And _that_ is supposed to be inlined?  Complete with sorting the
array, etc.?

<looks at the callers in the next patch>

-       root = kernfs_root(kn);
-       down_write(&root->kernfs_rwsem);
+       down_write_kernfs_rwsem_rename_ns(kn, kn->parent, new_parent);

This is rename.  The very thing that changes kn->parent.  Just what would
stop *ANOTHER* rename from modifying said kn->parent while you'd been
sleeping waiting for that rwsem?  It's not even a narrow race window...

I could believe that similar question about stability of ->parent in
case of KERNFS_RWSEM_LOCK_SELF_AND_PARENT handling might be dealt with
by something along the lines of "nothing is supposed to rename a node
while it's fed to kernfs_remove_self(), which is the only user of that",
but here we definitely *can* have racing renames.

> +/**
> + * down_read_kernfs_rwsem_rename_ns() - take hashed rwsem during
> + * rename or similar operations.
> + *
> + * @kn: kernfs_node of interest
> + * @current_parent: current parent of kernfs_node of interest
> + * @new_parent: about to become new parent of kernfs_node
> + *
> + * During rename or similar operations the parent of a node changes,
> + * and this means we will see different parents of a kernfs_node at
> + * the time of taking and releasing its or its parent's hashed rwsem.
> + * This function separately takes locks corresponding to node, and
> + * corresponding to its current and future parents (if needed).
> + *
> + * Return: void
> + */
> +static inline void down_read_kernfs_rwsem_rename_ns(struct kernfs_node *kn,
> +					struct kernfs_node *current_parent,
> +					struct kernfs_node *new_parent)

<tries to guess what use could *that* possibly have>
<fails>
<looks for callers (in a different mail, damnit)>
<none>
...

TBH, this is rather uninspiring.  I can easily believe that you've got
contention visibly reduced on a benchmark.  That'd only be interesting
if we had a clear proof of correctness.  And you don't even bother to
discuss your locking rules anywhere I can see in the series, cover letter
included...

I agree that sysfs locking had always been an atrocity - "serialize
everything, we can't be arsed to think of that" approach had been there
from the day one.  However, that's precisely the reason why replacement
needs a very careful analysis.  For all I know, you might've done just
that, but you are asking reviewers to reproduce that work independently.
Or to hope that you've gotten it right and nod through the entire thing.
Pardon me, but I know how easy it is to miss something while doing that
kind of work - been there, done that.

*That* is the part that needs review.
