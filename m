Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB5E5507A1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 02:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiFSALA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 20:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFSAK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 20:10:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF7EFD26
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 17:10:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 309B1B80B43
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 00:10:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1FAC3411A;
        Sun, 19 Jun 2022 00:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655597454;
        bh=pJavzBOpBup2L2XFujyF+W4cOF5r98O8lnH39scpEWM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PyhtF9Wwm/fzM9VqL4TSKYSYMr/ZpGzFqS8u1mazEehsHuuuOTISzzWLBeXibwTrd
         cMv2p9TdV7k5UUOnxyBnhfVzMuX0UuERo/UrTaPJ9mpGd0Er+KDeMeEpdRTzrU7WI1
         6X5qFY5P0dULAPEnlBU+kBtsu6DV+Lu0/zYaqN97GiNL5dzaelMLTW0MY8NW8CwWH1
         yLrP+R+0sCQAHLAME/C/E1OxBj33bdL5gcNyp5UACwWxoLkqctZ6xozqgO0r1M/7R3
         WXdM+Ait16ErrahcTmz3+jrEbrdNeVRTRXtI1FTDItaR3kcx9AxYUfLp2zHJPorAbi
         DSiStkGAIsYuw==
Message-ID: <f3fd41e1-ea76-a7d7-4890-ff66ea87b7ab@kernel.org>
Date:   Sun, 19 Jun 2022 08:10:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] f2fs-tools: fix to check free space before grow
Content-Language: en-US
To:     qixiaoyu1 <qxy65535@gmail.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, qixiaoyu1 <qixiaoyu1@xiaomi.com>
References: <20220614114929.6897-1-qixiaoyu1@xiaomi.com>
 <20220614114929.6897-2-qixiaoyu1@xiaomi.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220614114929.6897-2-qixiaoyu1@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/14 19:49, qixiaoyu1 wrote:
> Otherwise, after grow, kernel may report below error message
> when we mount the image if -o parameter is specified during resize:
> 
> F2FS-fs (loop0): invalid crc_offset: 0
> F2FS-fs (loop0): Wrong valid_user_blocks: 16404, user_block_count: 13312
> F2FS-fs (loop0): Failed to get valid F2FS checkpoint
> mount(2) system call failed: Structure needs cleaning.
> 
> Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>

It looks this patch should be merged into previous one, otherwise
-o option support is broken for resize.f2fs.

Thanks,

> ---
>   fsck/resize.c | 36 ++++++++++++++++++++++++------------
>   1 file changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/fsck/resize.c b/fsck/resize.c
> index d19c6fa..e135b66 100644
> --- a/fsck/resize.c
> +++ b/fsck/resize.c
> @@ -599,6 +599,26 @@ static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
>   	DBG(0, "Info: Done to rebuild checkpoint blocks\n");
>   }
>   
> +static int f2fs_resize_check(struct f2fs_sb_info *sbi, struct f2fs_super_block *new_sb)
> +{
> +	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
> +	block_t user_block_count;
> +	unsigned int overprov_segment_count;
> +
> +	overprov_segment_count = (get_newsb(segment_count_main) -
> +			c.new_reserved_segments) *
> +			c.new_overprovision / 100;
> +	overprov_segment_count += c.new_reserved_segments;
> +
> +	user_block_count = (get_newsb(segment_count_main) -
> +			overprov_segment_count) * c.blks_per_seg;
> +
> +	if (get_cp(valid_block_count) > user_block_count)
> +		return -1;
> +
> +	return 0;
> +}
> +
>   static int f2fs_resize_grow(struct f2fs_sb_info *sbi)
>   {
>   	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
> @@ -616,6 +636,9 @@ static int f2fs_resize_grow(struct f2fs_sb_info *sbi)
>   	if (get_new_sb(new_sb))
>   		return -1;
>   
> +	if (f2fs_resize_check(sbi, new_sb) < 0)
> +		return -1;
> +
>   	/* check nat availability */
>   	if (get_sb(segment_count_nat) > get_newsb(segment_count_nat)) {
>   		err = shrink_nats(sbi, new_sb);
> @@ -659,11 +682,8 @@ static int f2fs_resize_shrink(struct f2fs_sb_info *sbi)
>   	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
>   	struct f2fs_super_block new_sb_raw;
>   	struct f2fs_super_block *new_sb = &new_sb_raw;
> -	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
>   	block_t old_end_blkaddr, old_main_blkaddr;
>   	block_t new_end_blkaddr, new_main_blkaddr, tmp_end_blkaddr;
> -	block_t user_block_count;
> -	unsigned int overprov_segment_count;
>   	unsigned int offset;
>   	int err = -1;
>   
> @@ -674,15 +694,7 @@ static int f2fs_resize_shrink(struct f2fs_sb_info *sbi)
>   	if (get_new_sb(new_sb))
>   		return -1;
>   
> -	overprov_segment_count = (get_newsb(segment_count_main) -
> -			c.new_reserved_segments) *
> -			c.new_overprovision / 100;
> -	overprov_segment_count += c.new_reserved_segments;
> -
> -	user_block_count = (get_newsb(segment_count_main) -
> -			overprov_segment_count) * c.blks_per_seg;
> -
> -	if (get_cp(valid_block_count) > user_block_count)
> +	if (f2fs_resize_check(sbi, new_sb) < 0)
>   		return -1;
>   
>   	/* check nat availability */
