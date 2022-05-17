Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5AC52A918
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 19:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351425AbiEQRVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 13:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351409AbiEQRVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 13:21:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4331226558
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 10:21:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA07EB81AFE
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 17:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759A6C34117;
        Tue, 17 May 2022 17:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652808073;
        bh=sGI0SIwD4fAPPTdfOu7XlL38Ob5/zjrX0pvs0T8hZDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qeajyuTBFxeaxD5Ozxxca0tZU9wXyCJUta1Ts7I44JU7F+fvrH8spO7c1hfRk/811
         b/5fskW+qwnkezzOyg7CmxVFtauDrTNqAGKqcOUpzpxL0sRfYBOkrAqRCEN47RmKRW
         GAHEbcIf1DglUmWGxU3Y5VSirKOoaanvzdXwxEr0s93WvqAvMQOz//SnkUpfkHvGHP
         ONrzWn3N46xORjMPPeVhagLCLumIkZA/xwZMuGIph1pAvXHhepCQNqramvhciwtPIG
         OvwsYyuhyAxLSuRvI2MJBCvet9cpsAy0woLXImMavL7tw1PlfmGWb6Or8Fl6SSHhnb
         RpXpTaiKtbnEw==
Date:   Tue, 17 May 2022 10:21:11 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@oppo.com>
Subject: Re: [PATCH v4] f2fs: separate NOCoW and pinfile semantics
Message-ID: <YoPZh+vl68IH5loV@google.com>
References: <20220517032410.3564033-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517032410.3564033-1-chao@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/17, Chao Yu wrote:
> Pinning a file is heavy, because skipping pinned files make GC
> running with heavy load or no effect.
> 
> So that this patch proposes to separate nocow and pinfile semantics:
> - NOCoW flag can only be set on regular file.
> - NOCoW file will only trigger IPU at common writeback/flush.
> - NOCow file will do OPU during GC.

How about adding
 - NOCow file will allocate 2MB-aligned space via fallocate.

So, it'd be same as file pinning except allowing GCs. wdyt?

> 
> This flag can satisfying the demand of:
> 1) avoiding fragment of file's physical block
> 2) userspace doesn't want to pin file's physical address
> 
> After commit 5d539245cb18 ("f2fs: export FS_NOCOW_FL flag to user"),
> Pin_file and NOCoW flags have already been twined closely. e.g.
> once we set pinfile flag in file, nocow flag will be shown; and after
> clearing pinfile flag, nocow flag will disappear.
> 
> So, in order to keep backward compatibility, let use below semantics:
> 
> f2fs_ioc_set_pin_file/f2fs_fileattr_set logic:
> 		pinfile			nocow
> set		set pinfile | nocow	set nocow
> clear		clear pinfile | nocow	clear nocow
> 
> File Behaviors:
> w/ pinfile, w/ nocow:		use pinfile semantics
> w/ pinfile, w/o nocow:		use pinfile semantics
> w/o pinfile, w/ nocow:		use nocow semantics
> w/o pinfile, w/o nocow:		no pinfile or nocow semantics
> 
> NOCoW can also be set on directory, and it will have no effect on
> directory, however, new files created in nocow directory will have the
> flag set.
> 
> Signed-off-by: Chao Yu <chao.yu@oppo.com>
> ---
> v4:
> - allow IPU only for NoCowed regular inode.
>  fs/f2fs/data.c |  3 +++
>  fs/f2fs/f2fs.h | 13 +++++++++++--
>  fs/f2fs/file.c | 18 +++++++++++++++++-
>  3 files changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 54a7a8ad994d..42d95ac6b508 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2498,6 +2498,9 @@ bool f2fs_should_update_inplace(struct inode *inode, struct f2fs_io_info *fio)
>  	if (f2fs_is_pinned_file(inode))
>  		return true;
>  
> +	if (S_ISREG(inode->i_mode) && F2FS_I(inode)->i_flags & F2FS_NOCOW_FL)
> +		return true;
> +
>  	/* if this is cold file, we should overwrite to avoid fragmentation */
>  	if (file_is_cold(inode))
>  		return true;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 492af5b96de1..5c67736000a7 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2916,13 +2916,15 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
>  #define F2FS_NOCOMP_FL			0x00000400 /* Don't compress */
>  #define F2FS_INDEX_FL			0x00001000 /* hash-indexed directory */
>  #define F2FS_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
> +#define F2FS_NOCOW_FL			0x00800000 /* Do not cow file */
>  #define F2FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
>  #define F2FS_CASEFOLD_FL		0x40000000 /* Casefolded file */
>  
>  /* Flags that should be inherited by new inodes from their parent. */
>  #define F2FS_FL_INHERITED (F2FS_SYNC_FL | F2FS_NODUMP_FL | F2FS_NOATIME_FL | \
>  			   F2FS_DIRSYNC_FL | F2FS_PROJINHERIT_FL | \
> -			   F2FS_CASEFOLD_FL | F2FS_COMPR_FL | F2FS_NOCOMP_FL)
> +			   F2FS_CASEFOLD_FL | F2FS_COMPR_FL | F2FS_NOCOMP_FL | \
> +			   F2FS_NOCOW_FL)
>  
>  /* Flags that are appropriate for regular files (all but dir-specific ones). */
>  #define F2FS_REG_FLMASK		(~(F2FS_DIRSYNC_FL | F2FS_PROJINHERIT_FL | \
> @@ -2954,9 +2956,16 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
>  		fallthrough;
>  	case FI_DATA_EXIST:
>  	case FI_INLINE_DOTS:
> -	case FI_PIN_FILE:
>  	case FI_COMPRESS_RELEASED:
>  		f2fs_mark_inode_dirty_sync(inode, true);
> +		break;
> +	case FI_PIN_FILE:
> +		if (set)
> +			F2FS_I(inode)->i_flags |= F2FS_NOCOW_FL;
> +		else
> +			F2FS_I(inode)->i_flags &= ~F2FS_NOCOW_FL;
> +		f2fs_mark_inode_dirty_sync(inode, true);
> +		break;
>  	}
>  }
>  
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 216081ea8c81..9e71ce8601f9 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1851,6 +1851,20 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>  	if (IS_NOQUOTA(inode))
>  		return -EPERM;
>  
> +	if ((iflags ^ masked_flags) & F2FS_NOCOW_FL) {
> +		int ret;
> +
> +		if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
> +			return -EINVAL;
> +		if (S_ISREG(inode->i_mode)) {
> +			if (f2fs_should_update_outplace(inode, NULL))
> +				return -EINVAL;
> +			ret = f2fs_convert_inline_inode(inode);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
>  	if ((iflags ^ masked_flags) & F2FS_CASEFOLD_FL) {
>  		if (!f2fs_sb_has_casefold(F2FS_I_SB(inode)))
>  			return -EOPNOTSUPP;
> @@ -1926,6 +1940,7 @@ static const struct {
>  	{ F2FS_NOCOMP_FL,	FS_NOCOMP_FL },
>  	{ F2FS_INDEX_FL,	FS_INDEX_FL },
>  	{ F2FS_DIRSYNC_FL,	FS_DIRSYNC_FL },
> +	{ F2FS_NOCOW_FL,	FS_NOCOW_FL },
>  	{ F2FS_PROJINHERIT_FL,	FS_PROJINHERIT_FL },
>  	{ F2FS_CASEFOLD_FL,	FS_CASEFOLD_FL },
>  };
> @@ -1957,7 +1972,8 @@ static const struct {
>  		FS_NOCOMP_FL |		\
>  		FS_DIRSYNC_FL |		\
>  		FS_PROJINHERIT_FL |	\
> -		FS_CASEFOLD_FL)
> +		FS_CASEFOLD_FL |	\
> +		FS_NOCOW_FL)
>  
>  /* Convert f2fs on-disk i_flags to FS_IOC_{GET,SET}FLAGS flags */
>  static inline u32 f2fs_iflags_to_fsflags(u32 iflags)
> -- 
> 2.25.1
