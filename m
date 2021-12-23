Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD94C47E3DD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 13:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348521AbhLWM55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 07:57:57 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:37352 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243553AbhLWM54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:57:56 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D31CF21101;
        Thu, 23 Dec 2021 12:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1640264274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hAH4LXMByuzQUZCZVsy6+oz2NtxPR9/kIjmOaz578L8=;
        b=q+R4+RqmBSLpoIHi42EBzKIhWgsD1Rf65Pc9I+S5FxegT1lLo9qc/GdMIN35uq0waEs/jU
        SDIeYx+70kobntj9bm/xdWfmoa403Wv5GZ2YQfCZsz8ryMp+Vh9ABLSi1v0EYeuM48hAZl
        FRLe2WeFrI8A/h/aS+OsT/zwmkklk5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1640264274;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hAH4LXMByuzQUZCZVsy6+oz2NtxPR9/kIjmOaz578L8=;
        b=90mu6JQlyqIaMPwLYWr416VwLJIhaB05TyAI/XRYjVksiGDW4KjOwxW+8aXIRNxgTcrAtY
        zHWOOwpA1hEq0wAw==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id ADB5CA3B83;
        Thu, 23 Dec 2021 12:57:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 891011E1328; Thu, 23 Dec 2021 13:57:54 +0100 (CET)
Date:   Thu, 23 Dec 2021 13:57:54 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     corbet@lwn.net, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>, axboe@kernel.dk,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, linfeilong <linfeilong@huawei.com>
Subject: Re: [PATCH] doc: fs: remove bdev_try_to_free_page related doc
Message-ID: <20211223125754.GC19129@quack2.suse.cz>
References: <c45e6351-b0f8-3410-787e-02c6aeb3efe6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c45e6351-b0f8-3410-787e-02c6aeb3efe6@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 23-12-21 11:51:00, Zhiqiang Liu wrote:
> 
> In commit acc6100d3ffa ("fs: remove bdev_try_to_free_page callback"),
> bdev_try_to_free_page has been removed.
> 
> We should remove its doc.
> 
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>

Indeed. Thanks. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  Documentation/filesystems/locking.rst | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index d36fe79167b3..3f9b1497ebb8 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -169,7 +169,6 @@ prototypes::
>  	int (*show_options)(struct seq_file *, struct dentry *);
>  	ssize_t (*quota_read)(struct super_block *, int, char *, size_t, loff_t);
>  	ssize_t (*quota_write)(struct super_block *, int, const char *, size_t, loff_t);
> -	int (*bdev_try_to_free_page)(struct super_block*, struct page*, gfp_t);
> 
>  locking rules:
>  	All may block [not true, see below]
> @@ -194,7 +193,6 @@ umount_begin:		no
>  show_options:		no		(namespace_sem)
>  quota_read:		no		(see below)
>  quota_write:		no		(see below)
> -bdev_try_to_free_page:	no		(see below)
>  ======================	============	========================
> 
>  ->statfs() has s_umount (shared) when called by ustat(2) (native or
> @@ -210,9 +208,6 @@ dqio_sem) (unless an admin really wants to screw up something and
>  writes to quota files with quotas on). For other details about locking
>  see also dquot_operations section.
> 
> -->bdev_try_to_free_page is called from the ->releasepage handler of
> -the block device inode.  See there for more details.
> -
>  file_system_type
>  ================
> 
> -- 
> 2.23.0
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
