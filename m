Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7C250F008
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 06:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240172AbiDZEtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 00:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiDZEtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 00:49:08 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64A922B33
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 21:45:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VBJV9GX_1650948355;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VBJV9GX_1650948355)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Apr 2022 12:45:57 +0800
Date:   Tue, 26 Apr 2022 12:45:55 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Hongnan Li <hongnan.li@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 resend] erofs: make filesystem exportable
Message-ID: <Ymd5A5ZaCprBx0w9@B-P7TQMD6M-0146.local>
References: <20220424130104.102365-1-hongnan.li@linux.alibaba.com>
 <20220425040712.91685-1-hongnan.li@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220425040712.91685-1-hongnan.li@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 12:07:12PM +0800, Hongnan Li wrote:
> Implement export operations in order to make EROFS support accessing
> inodes with filehandles so that it can be exported via NFS and used
> by overlayfs.
> 
> Without this patch, 'exportfs -rv' will report:
> exportfs: /root/erofs_mp does not support NFS export
> 
> Also tested with unionmount-testsuite and the testcase below passes now:
> ./run --ov --erofs --verify hard-link
> 
> For more details about the testcase, see:
> https://github.com/amir73il/unionmount-testsuite/pull/6
> 
> Signed-off-by: Hongnan Li <hongnan.li@linux.alibaba.com>
> ---
>  fs/erofs/internal.h |  2 +-
>  fs/erofs/namei.c    |  5 ++---
>  fs/erofs/super.c    | 40 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 43 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 5298c4ee277d..12c65f647324 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -509,7 +509,7 @@ int erofs_getattr(struct user_namespace *mnt_userns, const struct path *path,
>  /* namei.c */
>  extern const struct inode_operations erofs_dir_iops;
>  
> -int erofs_namei(struct inode *dir, struct qstr *name,
> +int erofs_namei(struct inode *dir, const struct qstr *name,
>  		erofs_nid_t *nid, unsigned int *d_type);
>  
>  /* dir.c */
> diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
> index 554efa363317..fd75506799c4 100644
> --- a/fs/erofs/namei.c
> +++ b/fs/erofs/namei.c
> @@ -165,9 +165,8 @@ static void *find_target_block_classic(struct erofs_buf *target,
>  	return candidate;
>  }
>  
> -int erofs_namei(struct inode *dir,
> -		struct qstr *name,
> -		erofs_nid_t *nid, unsigned int *d_type)
> +int erofs_namei(struct inode *dir, const struct qstr *name, erofs_nid_t *nid,
> +		unsigned int *d_type)
>  {
>  	int ndirents;
>  	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 0c4b41130c2f..1c77b7acabd0 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -13,6 +13,7 @@
>  #include <linux/fs_context.h>
>  #include <linux/fs_parser.h>
>  #include <linux/dax.h>
> +#include <linux/exportfs.h>
>  #include "xattr.h"
>  
>  #define CREATE_TRACE_POINTS
> @@ -577,6 +578,44 @@ static int erofs_init_managed_cache(struct super_block *sb)
>  static int erofs_init_managed_cache(struct super_block *sb) { return 0; }
>  #endif
>  
> +static struct inode *erofs_nfs_get_inode(struct super_block *sb,
> +		u64 ino, u32 generation)
> +{
> +	return erofs_iget(sb, ino, false);
> +}
> +
> +static struct dentry *erofs_fh_to_dentry(struct super_block *sb, struct fid *fid,
> +		int fh_len, int fh_type)
> +{
> +	return generic_fh_to_dentry(sb, fid, fh_len, fh_type,
> +				    erofs_nfs_get_inode);
> +}
> +
> +static struct dentry *erofs_fh_to_parent(struct super_block *sb, struct fid *fid,
> +		int fh_len, int fh_type)
> +{
> +	return generic_fh_to_parent(sb, fid, fh_len, fh_type,
> +				    erofs_nfs_get_inode);
> +}
> +
> +static struct dentry *erofs_get_parent(struct dentry *child)
> +{
> +	erofs_nid_t nid;
> +	unsigned int d_type;
> +	int err;
> +
> +	err = erofs_namei(d_inode(child), &dotdot_name, &nid, &d_type);
> +	if (err)
> +		return ERR_PTR(err);
> +	return d_obtain_alias(erofs_iget(child->d_sb, nid, d_type == FT_DIR));
> +}
> +
> +static const struct export_operations erofs_export_ops = {
> +	.fh_to_dentry = erofs_fh_to_dentry,
> +	.fh_to_parent = erofs_fh_to_parent,
> +	.get_parent = erofs_get_parent,
> +};
> +
>  static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>  	struct inode *inode;
> @@ -618,6 +657,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_time_gran = 1;
>  
>  	sb->s_op = &erofs_sops;
> +	sb->s_export_op = &erofs_export_ops;

I might need to rearrange this part later since it has a slight conflict
with the fscache patchset. Otherwise looks good to me,

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

>  	sb->s_xattr = erofs_xattr_handlers;
>  
>  	if (test_opt(&sbi->opt, POSIX_ACL))
> -- 
> 2.19.1.6.gb485710b
