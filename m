Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318CD570FA3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 03:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbiGLBnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 21:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiGLBnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 21:43:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58F530F69
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 18:43:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0466961653
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E4AC34115;
        Tue, 12 Jul 2022 01:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657590190;
        bh=NTy2qoljQdyoHW8dSLRVcJnstddAXapdmicQhHBW9I8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OC62gfly16u8cPQWb/qgfMuwQN+FrjtQG+er2MwDauC38wMz8t3LA4S6ZfM4xu5Fu
         4qJyGikSUhgtaxP4CZJEidjp7tUff9AkOFbhuWXl/+ZIJxjiIkv4mdRSZaoFSAVwuB
         29FkaGWA46NqSX5ujtQmx+m8ilVEZnGZtW1r9V04DWNbhzXuVajr9+jwruYV/4P1Rv
         nLy7PFY5GiQ+dQfC8YPvEunhmnLqc4KifC1bfdHKnUOZ6IyHdmkcgY0ZfZl2YIqzdp
         fp0FpHHE6Zi/BxgzXy5hZNFlchil/3tUwWGaSLtzU+Iv7qkLirKbS5pqwVfck1Xj7N
         WRnG5/+PzzEWw==
Date:   Mon, 11 Jul 2022 18:43:08 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Guowei Du <duguoweisz@gmail.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, duguowei <duguowei@xiaomi.com>
Subject: Re: [PATCH] f2fs: add some sysfs nodes for segment
Message-ID: <YszRrHHqLk4My3vO@google.com>
References: <20220706020615.29938-1-duguoweisz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220706020615.29938-1-duguoweisz@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06, Guowei Du wrote:
> From: duguowei <duguowei@xiaomi.com>
> 
> There are two ways to show meta segment information,
> one is by dump.f2fs, another is by sysfs node. But,
> sometimes dump needs root privilege,So adding a
> few sysfs nodes.
> 
> The generic permission of node is 0444(S_IRUGO).
> 
> $ cd /sys/fs/f2fs/DEVICE/...
> $ ls -l
> ...
> -r--r--r-- 1 root root 4096 7月   5 23:21 reserved_segments
> -r--r--r-- 1 root root 4096 7月   5 23:21 segment_count
> -r--r--r-- 1 root root 4096 7月   5 23:21 segment_count_ckpt
> -r--r--r-- 1 root root 4096 7月   5 23:21 segment_count_main
> -r--r--r-- 1 root root 4096 7月   5 23:21 segment_count_nat
> -r--r--r-- 1 root root 4096 7月   5 23:21 segment_count_sit
> -r--r--r-- 1 root root 4096 7月   5 23:21 segment_count_ssa
> ...
> 
> $ sudo dump.f2fs -d 1 DEVICE
> ...
> Super block
> segment_count                           [0x      26 : 38]
> segment_count_ckpt                      [0x       2 : 2]
> segment_count_sit                       [0x       2 : 2]
> segment_count_nat                       [0x       2 : 2]
> segment_count_ssa                       [0x       1 : 1]
> segment_count_main                      [0x      1f : 31]
> ...
> Checkpoint
> rsvd_segment_count                      [0x       e : 14]
> ...
> 
> Signed-off-by: duguowei <duguowei@xiaomi.com>
> ---
>  fs/f2fs/sysfs.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 4c50aedd5144..05350bba2c83 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -697,6 +697,55 @@ static ssize_t f2fs_sb_feature_show(struct f2fs_attr *a,
>  	return sprintf(buf, "unsupported\n");
>  }
>  
> +static ssize_t segment_count_show(struct f2fs_attr *a,
> +		struct f2fs_sb_info *sbi, char *buf)
> +{
> +	return sprintf(buf, "%llu\n",
> +			(unsigned long long)(F2FS_RAW_SUPER(sbi)->segment_count));
> +}
> +
> +static ssize_t segment_count_ckpt_show(struct f2fs_attr *a,
> +		struct f2fs_sb_info *sbi, char *buf)
> +{
> +	return sprintf(buf, "%llu\n",
> +			(unsigned long long)(F2FS_RAW_SUPER(sbi)->segment_count_ckpt));
> +}
> +
> +static ssize_t segment_count_sit_show(struct f2fs_attr *a,
> +		struct f2fs_sb_info *sbi, char *buf)
> +{
> +	return sprintf(buf, "%llu\n",
> +			(unsigned long long)(F2FS_RAW_SUPER(sbi)->segment_count_sit));
> +}
> +
> +static ssize_t segment_count_nat_show(struct f2fs_attr *a,
> +		struct f2fs_sb_info *sbi, char *buf)
> +{
> +	return sprintf(buf, "%llu\n",
> +			(unsigned long long)(F2FS_RAW_SUPER(sbi)->segment_count_nat));
> +}
> +
> +static ssize_t segment_count_ssa_show(struct f2fs_attr *a,
> +		struct f2fs_sb_info *sbi, char *buf)
> +{
> +	return sprintf(buf, "%llu\n",
> +			(unsigned long long)(F2FS_RAW_SUPER(sbi)->segment_count_ssa));
> +}
> +
> +static ssize_t segment_count_main_show(struct f2fs_attr *a,
> +		struct f2fs_sb_info *sbi, char *buf)
> +{
> +	return sprintf(buf, "%llu\n",
> +			(unsigned long long)(F2FS_RAW_SUPER(sbi)->segment_count_main));
> +}
> +
> +static ssize_t reserved_segments_show(struct f2fs_attr *a,
> +		struct f2fs_sb_info *sbi, char *buf)
> +{
> +	return sprintf(buf, "%llu\n",
> +			(unsigned long long)(reserved_segments(sbi)));
> +}

Can we create a macro to do the above functions?

> +
>  #define F2FS_SB_FEATURE_RO_ATTR(_name, _feat)			\
>  static struct f2fs_attr f2fs_attr_sb_##_name = {		\
>  	.attr = {.name = __stringify(_name), .mode = 0444 },	\
> @@ -801,6 +850,13 @@ F2FS_GENERAL_RO_ATTR(moved_blocks_background);
>  F2FS_GENERAL_RO_ATTR(moved_blocks_foreground);
>  F2FS_GENERAL_RO_ATTR(avg_vblocks);
>  #endif
> +F2FS_GENERAL_RO_ATTR(segment_count);
> +F2FS_GENERAL_RO_ATTR(segment_count_ckpt);
> +F2FS_GENERAL_RO_ATTR(segment_count_sit);
> +F2FS_GENERAL_RO_ATTR(segment_count_nat);
> +F2FS_GENERAL_RO_ATTR(segment_count_ssa);
> +F2FS_GENERAL_RO_ATTR(segment_count_main);
> +F2FS_GENERAL_RO_ATTR(reserved_segments);
>  
>  #ifdef CONFIG_FS_ENCRYPTION
>  F2FS_FEATURE_RO_ATTR(encryption);
> @@ -934,6 +990,13 @@ static struct attribute *f2fs_attrs[] = {
>  	ATTR_LIST(gc_reclaimed_segments),
>  	ATTR_LIST(max_fragment_chunk),
>  	ATTR_LIST(max_fragment_hole),
> +	ATTR_LIST(segment_count),
> +	ATTR_LIST(segment_count_ckpt),
> +	ATTR_LIST(segment_count_sit),
> +	ATTR_LIST(segment_count_nat),
> +	ATTR_LIST(segment_count_ssa),
> +	ATTR_LIST(segment_count_main),
> +	ATTR_LIST(reserved_segments),
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(f2fs);
> -- 
> 2.36.1
