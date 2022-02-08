Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC854AD79E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359420AbiBHLgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358831AbiBHL1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:27:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17471C03FEEA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 03:27:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A293D615C2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF72C004E1;
        Tue,  8 Feb 2022 11:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644319648;
        bh=CGQqY63qbTyT2OHCC+vjreP6q7CXq083TbLUBIE3Ys4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kjpJt2OsYIINrFQNdlgDkPgBgtcrP3piCf+lio35QnYefp7hORiCgi4zQcWWj/gv2
         ENk345IS7+ZFd3tOaLrMM1rsBluQQ7xWW1vnEoQVK5IdnkX+LmJvd7/8vFz6NHyAVL
         DHWYZaci5OnbDbzidTk3ITZfAk09yhrvL2XYfmoA=
Date:   Tue, 8 Feb 2022 12:27:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] kernfs: use hashed mutex and spinlock in place of
 global ones.
Message-ID: <YgJTndUA7iK/UIao@kroah.com>
References: <20220206010925.1033990-1-imran.f.khan@oracle.com>
 <20220206010925.1033990-2-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220206010925.1033990-2-imran.f.khan@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2022 at 12:09:24PM +1100, Imran Khan wrote:
> diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
> index f9cc912c31e1b..cc49a6cd94154 100644
> --- a/fs/kernfs/kernfs-internal.h
> +++ b/fs/kernfs/kernfs-internal.h
> @@ -31,6 +31,7 @@ struct kernfs_iattrs {
>  	atomic_t		user_xattr_size;
>  };
>  
> +
>  /* +1 to avoid triggering overflow warning when negating it */
>  #define KN_DEACTIVATED_BIAS		(INT_MIN + 1)
>  

Nit, the above change isn't needed :)

> @@ -147,4 +148,54 @@ void kernfs_drain_open_files(struct kernfs_node *kn);
>   */
>  extern const struct inode_operations kernfs_symlink_iops;
>  
> +static inline spinlock_t *kernfs_open_node_lock_ptr(struct kernfs_node *kn)
> +{
> +	struct kernfs_root *root;
> +	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
> +
> +	root = kernfs_root(kn);
> +
> +	return &root->open_node_locks[idx].lock;
> +}
> +
> +static inline spinlock_t *kernfs_open_node_lock(struct kernfs_node *kn)
> +{
> +	struct kernfs_root *root;
> +	spinlock_t *lock;
> +	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
> +
> +	root = kernfs_root(kn);
> +
> +	lock = &root->open_node_locks[idx].lock;
> +
> +	spin_lock_irq(lock);
> +
> +	return lock;
> +}

Can't you use kernfs_open_node_lock_ptr() in kernfs_open_node_lock() to
make this use less duplicated code?


> +
> +static inline struct mutex *kernfs_open_file_mutex_ptr(struct kernfs_node *kn)
> +{
> +	struct kernfs_root *root;
> +	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
> +
> +	root = kernfs_root(kn);
> +
> +	return &root->open_file_mutex[idx].lock;
> +}
> +
> +static inline struct mutex *kernfs_open_file_mutex_lock(struct kernfs_node *kn)
> +{
> +	struct kernfs_root *root;
> +	struct mutex *lock;
> +	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
> +
> +	root = kernfs_root(kn);
> +
> +	lock = &root->open_file_mutex[idx].lock;
> +
> +	mutex_lock(lock);
> +
> +	return lock;
> +}

Same thing here.



> +
>  #endif	/* __KERNFS_INTERNAL_H */
> diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> index 861c4f0f8a29f..5bf9f02ce9dce 100644
> --- a/include/linux/kernfs.h
> +++ b/include/linux/kernfs.h
> @@ -18,6 +18,8 @@
>  #include <linux/uidgid.h>
>  #include <linux/wait.h>
>  #include <linux/rwsem.h>
> +#include <linux/spinlock.h>
> +#include <linux/cache.h>
>  
>  struct file;
>  struct dentry;
> @@ -34,6 +36,40 @@ struct kernfs_fs_context;
>  struct kernfs_open_node;
>  struct kernfs_iattrs;
>  
> +/*
> + * NR_KERNFS_LOCK_BITS determines size (NR_KERNFS_LOCKS) of hash
> + * table of locks.
> + * Having a small hash table would impact scalability, since
> + * more and more kernfs_node objects will end up using same lock
> + * and having a very large hash table would waste memory.
> + *
> + * At the moment size of hash table of locks is being set based on
> + * the number of CPUs as follows:
> + *
> + * NR_CPU      NR_KERNFS_LOCK_BITS      NR_KERNFS_LOCKS
> + *   1                  1                       2
> + *  2-3                 2                       4
> + *  4-7                 4                       16
> + *  8-15                6                       64
> + *  16-31               8                       256
> + *  32 and more         10                      1024
> + */
> +#ifdef CONFIG_SMP
> +#define NR_KERNFS_LOCK_BITS (2 * (ilog2(NR_CPUS < 32 ? NR_CPUS : 32)))
> +#else
> +#define NR_KERNFS_LOCK_BITS     1
> +#endif
> +
> +#define NR_KERNFS_LOCKS     (1 << NR_KERNFS_LOCK_BITS)
> +
> +struct kernfs_open_node_lock {
> +	spinlock_t lock;
> +} ____cacheline_aligned_in_smp;
> +
> +struct kernfs_open_file_mutex {
> +	struct mutex lock;
> +} ____cacheline_aligned_in_smp;
> +
>  enum kernfs_node_type {
>  	KERNFS_DIR		= 0x0001,
>  	KERNFS_FILE		= 0x0002,
> @@ -90,6 +126,7 @@ enum kernfs_root_flag {
>  	KERNFS_ROOT_SUPPORT_USER_XATTR		= 0x0008,
>  };
>  
> +
>  /* type-specific structures for kernfs_node union members */
>  struct kernfs_elem_dir {
>  	unsigned long		subdirs;
> @@ -201,6 +238,8 @@ struct kernfs_root {
>  
>  	wait_queue_head_t	deactivate_waitq;
>  	struct rw_semaphore	kernfs_rwsem;
> +	struct kernfs_open_node_lock open_node_locks[NR_KERNFS_LOCKS];
> +	struct kernfs_open_file_mutex open_file_mutex[NR_KERNFS_LOCKS];
>  };

I think struct kernfs_root can be declared locally inside fs/kernfs/ to
keep other subsystems/files from having to see this structure, right?
That would make this a bit less of a "rebuild the world" type of change
and could be done in a patch before this one.

Overall, this looks sane to me, nice work.

Tejun, any comments?

thanks,

greg k-h
