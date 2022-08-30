Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA2F5A6BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiH3SKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbiH3SKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:10:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2D717584
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:09:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 408796158D
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A82C433B5;
        Tue, 30 Aug 2022 18:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661882998;
        bh=FTf0fk3Y8UdccBmEPJWLfwBJ6gjV8U0LCPFcXhyZWtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=atVoL2keyCWWlK717vJHwSGjd44gbivT0eXbtMHWf6NT4/uudPwdfAR+8rozEXIbF
         r53dDL1CruHAeSP/YbRbruezGnFyqNsbYy+WLn6bK3DR7Bfqghie0k/3L6NuBMXWEw
         Hz8A+jzBzhAlQF/2mgEPVk0hY84uCcrtZUPcw9fMN827GNXbDVsa63hbrJNwW6qoq0
         t+VbRibt19GvDyEW5yCyp513jTOl763F5HAzZpNXVvmHY/JA0M5/lQT0oLZwZCHT2I
         Tbv6le/WYRf4zHyDyUjDX4l9Gr8fi4xhCLKznDTrLLxMTCvG8FdymTemqXNuH9+J6S
         qIwnlAFhgcySA==
Date:   Tue, 30 Aug 2022 11:09:56 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@oppo.com>
Subject: Re: [PATCH] f2fs: fix to disallow getting inner inode via f2fs_iget()
Message-ID: <Yw5SdK5ItK9P/NUj@google.com>
References: <20220830103625.79034-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830103625.79034-1-chao@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30, Chao Yu wrote:
> From: Chao Yu <chao.yu@oppo.com>
> 
> Introduce f2fs_iget_inner() for f2fs_fill_super() to get inner inode:
> meta inode, node inode or compressed inode, and add f2fs_check_nid_range()
> in f2fs_iget() to avoid getting inner inode from external interfaces.
> 
> Signed-off-by: Chao Yu <chao.yu@oppo.com>
> ---
>  fs/f2fs/compress.c |  2 +-
>  fs/f2fs/f2fs.h     |  1 +
>  fs/f2fs/inode.c    | 10 +++++++++-
>  fs/f2fs/super.c    |  4 ++--
>  4 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 730256732a9e..c38b22bb6432 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1947,7 +1947,7 @@ int f2fs_init_compress_inode(struct f2fs_sb_info *sbi)
>  	if (!test_opt(sbi, COMPRESS_CACHE))
>  		return 0;
>  
> -	inode = f2fs_iget(sbi->sb, F2FS_COMPRESS_INO(sbi));
> +	inode = f2fs_iget_inner(sbi->sb, F2FS_COMPRESS_INO(sbi));
>  	if (IS_ERR(inode))
>  		return PTR_ERR(inode);
>  	sbi->compress_inode = inode;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 408d8034ed74..35f9e1a6a1bf 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3467,6 +3467,7 @@ int f2fs_pin_file_control(struct inode *inode, bool inc);
>  void f2fs_set_inode_flags(struct inode *inode);
>  bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct page *page);
>  void f2fs_inode_chksum_set(struct f2fs_sb_info *sbi, struct page *page);
> +struct inode *f2fs_iget_inner(struct super_block *sb, unsigned long ino);
>  struct inode *f2fs_iget(struct super_block *sb, unsigned long ino);
>  struct inode *f2fs_iget_retry(struct super_block *sb, unsigned long ino);
>  int f2fs_try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink);
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 6d11c365d7b4..0ab3ae9b2110 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -480,7 +480,7 @@ static int do_read_inode(struct inode *inode)
>  	return 0;
>  }
>  
> -struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
> +struct inode *f2fs_iget_inner(struct super_block *sb, unsigned long ino)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_SB(sb);
>  	struct inode *inode;
> @@ -568,6 +568,14 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
>  	return ERR_PTR(ret);
>  }
>  
> +struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
> +{
> +	if (f2fs_check_nid_range(F2FS_SB(sb), ino))
> +		return -EINVAL;

EINVAL or EFSCORRUPTED used in f2fs_check_nid_range?
Do we have a report on this before?

> +
> +	return f2fs_iget_inner(sb, ino);
> +}
> +
>  struct inode *f2fs_iget_retry(struct super_block *sb, unsigned long ino)
>  {
>  	struct inode *inode;
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index b8e5fe244596..a5f5e7483791 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4157,7 +4157,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  		goto free_xattr_cache;
>  
>  	/* get an inode for meta space */
> -	sbi->meta_inode = f2fs_iget(sb, F2FS_META_INO(sbi));
> +	sbi->meta_inode = f2fs_iget_inner(sb, F2FS_META_INO(sbi));
>  	if (IS_ERR(sbi->meta_inode)) {
>  		f2fs_err(sbi, "Failed to read F2FS meta data inode");
>  		err = PTR_ERR(sbi->meta_inode);
> @@ -4265,7 +4265,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  		goto free_nm;
>  
>  	/* get an inode for node space */
> -	sbi->node_inode = f2fs_iget(sb, F2FS_NODE_INO(sbi));
> +	sbi->node_inode = f2fs_iget_inner(sb, F2FS_NODE_INO(sbi));
>  	if (IS_ERR(sbi->node_inode)) {
>  		f2fs_err(sbi, "Failed to read node inode");
>  		err = PTR_ERR(sbi->node_inode);
> -- 
> 2.25.1
