Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A4A567FAB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiGFHTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiGFHTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:19:10 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF25012ADD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 00:19:09 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 01AA46732D; Wed,  6 Jul 2022 09:19:05 +0200 (CEST)
Date:   Wed, 6 Jul 2022 09:19:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, leo.yan@linaro.org, acme@kernel.org,
        james.clark@arm.com, Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 7/7] configfs: Fix LOCKDEP nesting issues with
 fragment semaphores
Message-ID: <20220706071905.GA28897@lst.de>
References: <20220704154249.11501-1-mike.leach@linaro.org> <20220704154249.11501-8-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704154249.11501-8-mike.leach@linaro.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you send me the whole series?  Reviewing a patch 7 out of 7 without
context is basically impossible.

On Mon, Jul 04, 2022 at 04:42:49PM +0100, Mike Leach wrote:
> CoreSight uses configfs to represent the user interface to programmed
> configurations, which can be loaded and unloaded dynamically via configfs.
> 
> These add and remove configurations using register/unregister group
> calls.
> 
> It has been found that if CONFIG_LOCKDEP is enabled, then it appears to
> be confused by the nesting inherent in the fragment semaphores used
> by groups and the underlying subsystem.
> 
> This patch sets up a mechanism to use separate classes for the fragment
> semaphores, in a similar way to that already in place to fix nesting
> issues with the i_mutexes.
> 
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>  fs/configfs/configfs_internal.h |  3 +++
>  fs/configfs/dir.c               | 45 +++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
> index c0395363eab9..736c74ec4b7a 100644
> --- a/fs/configfs/configfs_internal.h
> +++ b/fs/configfs/configfs_internal.h
> @@ -22,6 +22,9 @@ struct configfs_fragment {
>  	atomic_t frag_count;
>  	struct rw_semaphore frag_sem;
>  	bool frag_dead;
> +#ifdef CONFIG_LOCKDEP
> +	int frag_depth;
> +#endif
>  };
>  
>  void put_fragment(struct configfs_fragment *);
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index d1f9d2632202..6ecd8961afc3 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -133,6 +133,41 @@ configfs_adjust_dir_dirent_depth_after_populate(struct configfs_dirent *sd)
>  	sd->s_depth = -1;
>  }
>  
> +/* fragment semaphore needs some lockdep handling */
> +static struct lock_class_key default_frag_class[MAX_LOCK_DEPTH];
> +
> +/*
> + * Set the lockdep depth for a new fragment based on the parent frag depth.
> + * Called from register_subsystem() with NULL parent group to set root subsystem
> + * depth which defaults to 0 in a new fragment, and from register_group() with the
> + * parent group to set a new group fragment based on the parent fragment depth.
> + *
> + * Prevents lockdep getting upset on the unregister_group() call if it cannot
> + * understand the hierarchy of fragments.
> + */
> +static void configfs_adjust_frag_depth(struct configfs_fragment *frag,
> +				       struct config_group *parent_group)
> +{
> +	struct configfs_dirent *parent_dirent;
> +
> +	if (parent_group) {
> +		// find parent frag
> +		parent_dirent = parent_group->cg_item.ci_dentry->d_fsdata;
> +		frag->frag_depth = parent_dirent->s_frag->frag_depth + 1;
> +	}
> +
> +	if (frag->frag_depth < ARRAY_SIZE(default_frag_class)) {
> +		lockdep_set_class(&frag->frag_sem,
> +				  &default_frag_class[frag->frag_depth]);
> +	} else {
> +		/*
> +		 * In practice the maximum level of locking depth is
> +		 * already reached. Just inform about possible reasons.
> +		 */
> +		pr_info("Too many levels of fragments for the locking correctness validator.\n");
> +	}
> +}
> +
>  #else /* CONFIG_LOCKDEP */
>  
>  static void configfs_init_dirent_depth(struct configfs_dirent *sd)
> @@ -154,6 +189,11 @@ configfs_adjust_dir_dirent_depth_after_populate(struct configfs_dirent *sd)
>  {
>  }
>  
> +static void configfs_adjust_frag_depth(struct configfs_fragment *frag,
> +				       struct config_group *parent_group)
> +{
> +}
> +
>  #endif /* CONFIG_LOCKDEP */
>  
>  static struct configfs_fragment *new_fragment(void)
> @@ -165,6 +205,9 @@ static struct configfs_fragment *new_fragment(void)
>  		atomic_set(&p->frag_count, 1);
>  		init_rwsem(&p->frag_sem);
>  		p->frag_dead = false;
> +#ifdef CONFIG_LOCKDEP
> +		p->frag_depth = 0;
> +#endif
>  	}
>  	return p;
>  }
> @@ -1742,6 +1785,7 @@ int configfs_register_group(struct config_group *parent_group,
>  	parent = parent_group->cg_item.ci_dentry;
>  
>  	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
> +	configfs_adjust_frag_depth(frag, parent_group);
>  	ret = create_default_group(parent_group, group, frag);
>  	if (ret)
>  		goto err_out;
> @@ -1872,6 +1916,7 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
>  	mutex_unlock(&configfs_subsystem_mutex);
>  
>  	inode_lock_nested(d_inode(root), I_MUTEX_PARENT);
> +	configfs_adjust_frag_depth(frag, NULL);
>  
>  	err = -ENOMEM;
>  	dentry = d_alloc_name(root, group->cg_item.ci_name);
> -- 
> 2.17.1
---end quoted text---
