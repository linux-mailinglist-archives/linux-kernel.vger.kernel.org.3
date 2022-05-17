Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FDA529D7F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244381AbiEQJIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244156AbiEQJHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:07:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03518220FF;
        Tue, 17 May 2022 02:06:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DBC6B8167A;
        Tue, 17 May 2022 09:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB64C385B8;
        Tue, 17 May 2022 09:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652778387;
        bh=ENqi3aLkqn49mx4+rl49Xw8BDX34aNuG7l7yN93Q+Qg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EWC0+VWwbdgQkqHToSIj7jZ8r1BPxUwTp6MojD4/n79S52TyFFcb+h/+J9EgjCctv
         ckLoFf4IXxit9pRlb9GGMt0VcRaJUjp0lc1jLmAMyrXYza3N0xfkEtwlo6hhTrmIr4
         K7Z1SSNkSKbLiDFQEqYLDdeitQGAyFxhJD03TqiOZ02s7YrR0J/9Mn9lcnmGOuLw1F
         r/hEZ91LJmO6mxb2Zf0gIk4m/AWfMZ6gzb2OPNFau3Nv7XWhopBzRV0+SX6lHFqqjP
         EHPlVXD2OCXke+7vcMDmxcx3Hd0fUgOmRtx4EfnrMcVIqv4j+YjurnhrutMXBMj1Mq
         SwyFKFIMK4uqg==
Date:   Tue, 17 May 2022 11:06:22 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     xiang@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@oppo.com>,
        fsdevel@vger.kernel.org
Subject: Re: [PATCH] erofs: support idmapped mounts
Message-ID: <20220517090622.4wrtrjmzknh66bci@wittgenstein>
References: <20220517073210.3569589-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220517073210.3569589-1-chao@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 03:32:10PM +0800, Chao Yu wrote:
> This patch enables idmapped mounts for erofs, since all dedicated helpers
> for this functionality existsm, so, in this patch we just pass down the
> user_namespace argument from the VFS methods to the relevant helpers.
> 
> Simple idmap example on erofs image:
> 
> 1. mkdir dir
> 2. touch dir/file
> 3. mkfs.erofs erofs.img dir
> 4. mount -t erofs -o loop erofs.img  /mnt/erofs/
> 
> 5. ls -ln /mnt/erofs/
> total 0
> -rw-rw-r-- 1 1000 1000 0 May 17 15:26 file
> 
> 6. mount-idmapped --map-mount b:0:1001:1 /mnt/erofs/ /mnt/scratch_erofs/
> 
> 7. ls -ln /mnt/scratch_erofs/
> total 0
> -rw-rw-r-- 1 65534 65534 0 May 17 15:26 file

Your current example maps id 0 in the filesystem to id 1001 in the
mount. But since no files with id 0 exist in the filesystem you're
illustrating that unmapped ids are correctly reported as overflow{g,u}id.

I think what you'd rather want to show is something like this:

5. ls -ln /mnt/erofs/
total 0
-rw-rw-r-- 1 1000 1000 0 May 17 15:26 file

6. mount-idmapped --map-mount b:1000:1001:1 /mnt/erofs/ /mnt/scratch_erofs/

7. ls -ln /mnt/scratch_erofs/
total 0
-rw-rw-r-- 1 1001 1001 0 May 17 15:26 file

where id 1000 in the filesystem maps to id 1001 in the mount.

> 
> Signed-off-by: Chao Yu <chao.yu@oppo.com>
> ---

Overall this is currently the smallest patch to support idmapped mounts.

Is erofs integrated with xfstests in any way?
For read-only filesystems we probably only need to verify that {g,u}id
are correctly reported. All the writable aspects are irrelevant.

Looks good,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>

>  fs/erofs/inode.c | 2 +-
>  fs/erofs/super.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index e8b37ba5e9ad..5320bf52c1ce 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -370,7 +370,7 @@ int erofs_getattr(struct user_namespace *mnt_userns, const struct path *path,
>  	stat->attributes_mask |= (STATX_ATTR_COMPRESSED |
>  				  STATX_ATTR_IMMUTABLE);
>  
> -	generic_fillattr(&init_user_ns, inode, stat);
> +	generic_fillattr(mnt_userns, inode, stat);
>  	return 0;
>  }
>  
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 0c4b41130c2f..7dc5f2e8ddee 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -781,7 +781,7 @@ static struct file_system_type erofs_fs_type = {
>  	.name           = "erofs",
>  	.init_fs_context = erofs_init_fs_context,
>  	.kill_sb        = erofs_kill_sb,
> -	.fs_flags       = FS_REQUIRES_DEV,
> +	.fs_flags       = FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
>  };
>  MODULE_ALIAS_FS("erofs");
>  
> -- 
> 2.25.1
> 
