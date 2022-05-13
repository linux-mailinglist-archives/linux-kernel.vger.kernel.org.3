Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CD35268DB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383207AbiEMR6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbiEMR6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:58:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5EC522C0
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:58:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C77A961B94
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 17:58:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16779C34100;
        Fri, 13 May 2022 17:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652464730;
        bh=jGfDN22SNm6l9Olp99VGq49P1EF6SURnNx6xntTGmKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NWnvrBSRuXQJFRMA36dkLiXexzwyIRUSYSyuPDLc3bWltDfPmrJ3iDtFRxAXByhNs
         Hs9bMe70Ee/OAkY/+ld5m/tvFFzPnEp8m5XVfoadsHA2zw9aJcMN3zJrM0Z/Tef6O5
         Qmm2wB22truSuC8WnYQRburiMCPmVT0/n3uS0K2tvOHOwvpGyn+EyxKZqE8iatafjw
         LPv452tJH6B+ZraHb5zmh5zAmqOj8FJSAYtdYbyIwGG3mbmArJ/Rp0lcgkoHPLx2cG
         TdlRw6l/IRIdV5Z5qpGHeJzD+U+SkkpV4ZE7pLhOsuaBwc/zSD5xppm/MbX3vxxkTu
         XRmUyWz4KUNag==
Date:   Fri, 13 May 2022 10:58:48 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@oppo.com>
Subject: Re: [PATCH] f2fs: separate NOCoW and pinfile semantics
Message-ID: <Yn6cWLC+3kh6aoHM@google.com>
References: <20220512082116.2991611-1-chao@kernel.org>
 <Yn2CztiJUY2UAjnd@google.com>
 <59d77fcb-bc82-c1d2-0a71-eef3b0140506@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59d77fcb-bc82-c1d2-0a71-eef3b0140506@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/13, Chao Yu wrote:
> On 2022/5/13 5:57, Jaegeuk Kim wrote:
> > On 05/12, Chao Yu wrote:
> > > Pinning a file is heavy, because skipping pinned files make GC
> > > running with heavy load or no effect.
> > > 
> > > So that this patch proposes to separate nocow and pinfile semantics:
> > > - NOCoW flag can only be set on regular file.
> > > - NOCoW file will only trigger IPU at common writeback/flush.
> > > - NOCow file will do OPU during GC.
> > > 
> > > This flag can satisfying the demand of:
> > > 1) avoiding fragment of file's physical block
> > > 2) userspace doesn't want to pin file's physical address
> > > 
> > > Signed-off-by: Chao Yu <chao.yu@oppo.com>
> > > ---
> > >   fs/f2fs/data.c |  3 ++-
> > >   fs/f2fs/f2fs.h |  1 +
> > >   fs/f2fs/file.c | 25 ++++++++++++++++++++++++-
> > >   3 files changed, 27 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > index 54a7a8ad994d..c8eab78f7d89 100644
> > > --- a/fs/f2fs/data.c
> > > +++ b/fs/f2fs/data.c
> > > @@ -2495,7 +2495,8 @@ bool f2fs_should_update_inplace(struct inode *inode, struct f2fs_io_info *fio)
> > >   	if (is_inode_flag_set(inode, FI_ALIGNED_WRITE))
> > >   		return false;
> > > -	if (f2fs_is_pinned_file(inode))
> > > +	if (f2fs_is_pinned_file(inode) ||
> > > +			F2FS_I(inode)->i_flags & F2FS_NOCOW_FL)
> > >   		return true;
> > >   	/* if this is cold file, we should overwrite to avoid fragmentation */
> > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > > index 492af5b96de1..e91ece55f5e8 100644
> > > --- a/fs/f2fs/f2fs.h
> > > +++ b/fs/f2fs/f2fs.h
> > > @@ -2916,6 +2916,7 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
> > >   #define F2FS_NOCOMP_FL			0x00000400 /* Don't compress */
> > >   #define F2FS_INDEX_FL			0x00001000 /* hash-indexed directory */
> > >   #define F2FS_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
> > > +#define F2FS_NOCOW_FL			0x00800000 /* Do not cow file */
> > >   #define F2FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
> > >   #define F2FS_CASEFOLD_FL		0x40000000 /* Casefolded file */
> > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > index 09287876dbb7..7f92a3a157f7 100644
> > > --- a/fs/f2fs/file.c
> > > +++ b/fs/f2fs/file.c
> > > @@ -1851,6 +1851,20 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
> > >   	if (IS_NOQUOTA(inode))
> > >   		return -EPERM;
> > > +	if ((iflags ^ masked_flags) & F2FS_NOCOW_FL) {
> > > +		int ret;
> > > +
> > > +		if (!S_ISREG(inode->i_mode))
> > > +			return -EINVAL;
> > > +		if (f2fs_should_update_outplace(inode, NULL))
> > > +			return -EINVAL;
> > > +		if (f2fs_is_pinned_file(inode))
> > > +			return -EINVAL;
> > > +		ret = f2fs_convert_inline_inode(inode);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > >   	if ((iflags ^ masked_flags) & F2FS_CASEFOLD_FL) {
> > >   		if (!f2fs_sb_has_casefold(F2FS_I_SB(inode)))
> > >   			return -EOPNOTSUPP;
> > > @@ -1926,6 +1940,7 @@ static const struct {
> > >   	{ F2FS_NOCOMP_FL,	FS_NOCOMP_FL },
> > >   	{ F2FS_INDEX_FL,	FS_INDEX_FL },
> > >   	{ F2FS_DIRSYNC_FL,	FS_DIRSYNC_FL },
> > > +	{ F2FS_NOCOW_FL,	FS_NOCOW_FL },
> > >   	{ F2FS_PROJINHERIT_FL,	FS_PROJINHERIT_FL },
> > >   	{ F2FS_CASEFOLD_FL,	FS_CASEFOLD_FL },
> > >   };
> > > @@ -1957,7 +1972,8 @@ static const struct {
> > >   		FS_NOCOMP_FL |		\
> > >   		FS_DIRSYNC_FL |		\
> > >   		FS_PROJINHERIT_FL |	\
> > > -		FS_CASEFOLD_FL)
> > > +		FS_CASEFOLD_FL |	\
> > > +		FS_NOCOW_FL)
> > >   /* Convert f2fs on-disk i_flags to FS_IOC_{GET,SET}FLAGS flags */
> > >   static inline u32 f2fs_iflags_to_fsflags(u32 iflags)
> > > @@ -3081,6 +3097,13 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
> > >   	inode_lock(inode);
> > > +	if (F2FS_I(inode)->i_flags & F2FS_NOCOW_FL) {
> > > +		f2fs_info(F2FS_I_SB(inode), "inode (%lu) is already NOCOW one",
> > > +			inode->i_ino);
> > > +		ret = -EINVAL;
> > 
> > Why rejecting this? We can pin the file to get 2MB-aligned allocation on the
> > NOCOW file.
> 
> I try to separate these two flag completely, but, seems it can't, because after
> commit 5d539245cb18 ("f2fs: export FS_NOCOW_FL flag to user"), these two flags
> have already been twined closely....
> 
> @@ -1651,6 +1651,8 @@ static int f2fs_ioc_getflags(struct file *filp, unsigned long arg)
>  		flags |= F2FS_ENCRYPT_FL;
>  	if (f2fs_has_inline_data(inode) || f2fs_has_inline_dentry(inode))
>  		flags |= F2FS_INLINE_DATA_FL;
> +	if (is_inode_flag_set(inode, FI_PIN_FILE))
> +		flags |= F2FS_NOCOW_FL;
> 
> How about:
> 
> f2fs_ioc_set_pin_file/f2fs_fileattr_set logic:
> 		pinfile			nocow
> set		set pinfile | nocow	set nocow
> clear		clear pinfile | nocow	clear nocow
> 
> Behaviors:
> w/ pinfile, w/ nocow:		use pinfile semantics
> w/ pinfile, w/o nocow:		use pinfile semantics
> w/o pinfile, w/ nocow:		use nocow semantics
> w/o pinfile, w/o nocow:		no pinfile or nocow semantics

This looks good to me. Thanks,

> 
> Thanks,
> 
> > 
> > > +		goto out;
> > > +	}
> > > +
> > >   	if (!pin) {
> > >   		clear_inode_flag(inode, FI_PIN_FILE);
> > >   		f2fs_i_gc_failures_write(inode, 0);
> > > -- 
> > > 2.25.1
