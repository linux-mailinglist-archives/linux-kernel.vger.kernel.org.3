Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9A354C2FC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238591AbiFOHyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235339AbiFOHyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:54:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142E3427DD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 00:54:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA836B81CD2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AB9C3411C;
        Wed, 15 Jun 2022 07:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655279667;
        bh=O27LTX42zGjhpVAJo5AIuYKbxsnXBd8hXyMw7Ghakc0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gEvXaRNDwAUoA5SimDag+4176A6CI6nTUpdeN3jUHgwB6QUF4ogiQYPwzuFlUDq5q
         sUinHYkmFPHGpPjOmyl01Sfy0j3yE0LLEKwYU0Y8UF/9ebHv/lz/vZu5N+kVauu0w3
         3TzzqWEwlsyzHByydF/NOY8uMyvR95BLCeHNvF7/td29NRlNSJW76vldqSM/qwfgm8
         Dhgup808dXTJrJK4R//VIoifHgxoz3ggithpVT1Ral1cziw39Dbnz7ltD31xIzIJdk
         TNRtivl+L4qIPsJZC7sgl6aZdUBZs9x9vLeDhI9QwzjLsdQhaEI4R8FucJp7wghQLX
         GCj3CPXfxdjDg==
Message-ID: <1815f3c2-0802-5b3f-7e98-9f89c5b9e07d@kernel.org>
Date:   Wed, 15 Jun 2022 15:54:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix iostat related lock protection
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20220610183240.2269085-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220610183240.2269085-1-daeho43@gmail.com>
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

On 2022/6/11 2:32, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Made iostat related locks safe to be called from irq context again.
> 

Will be better to add a 'Fixes' line?

Thanks,

> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>   fs/f2fs/iostat.c | 31 ++++++++++++++++++-------------
>   1 file changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
> index be599f31d3c4..d84c5f6cc09d 100644
> --- a/fs/f2fs/iostat.c
> +++ b/fs/f2fs/iostat.c
> @@ -91,8 +91,9 @@ static inline void __record_iostat_latency(struct f2fs_sb_info *sbi)
>   	unsigned int cnt;
>   	struct f2fs_iostat_latency iostat_lat[MAX_IO_TYPE][NR_PAGE_TYPE];
>   	struct iostat_lat_info *io_lat = sbi->iostat_io_lat;
> +	unsigned long flags;
>   
> -	spin_lock_bh(&sbi->iostat_lat_lock);
> +	spin_lock_irqsave(&sbi->iostat_lat_lock, flags);
>   	for (idx = 0; idx < MAX_IO_TYPE; idx++) {
>   		for (io = 0; io < NR_PAGE_TYPE; io++) {
>   			cnt = io_lat->bio_cnt[idx][io];
> @@ -106,7 +107,7 @@ static inline void __record_iostat_latency(struct f2fs_sb_info *sbi)
>   			io_lat->bio_cnt[idx][io] = 0;
>   		}
>   	}
> -	spin_unlock_bh(&sbi->iostat_lat_lock);
> +	spin_unlock_irqrestore(&sbi->iostat_lat_lock, flags);
>   
>   	trace_f2fs_iostat_latency(sbi, iostat_lat);
>   }
> @@ -115,14 +116,15 @@ static inline void f2fs_record_iostat(struct f2fs_sb_info *sbi)
>   {
>   	unsigned long long iostat_diff[NR_IO_TYPE];
>   	int i;
> +	unsigned long flags;
>   
>   	if (time_is_after_jiffies(sbi->iostat_next_period))
>   		return;
>   
>   	/* Need double check under the lock */
> -	spin_lock_bh(&sbi->iostat_lock);
> +	spin_lock_irqsave(&sbi->iostat_lock, flags);
>   	if (time_is_after_jiffies(sbi->iostat_next_period)) {
> -		spin_unlock_bh(&sbi->iostat_lock);
> +		spin_unlock_irqrestore(&sbi->iostat_lock, flags);
>   		return;
>   	}
>   	sbi->iostat_next_period = jiffies +
> @@ -133,7 +135,7 @@ static inline void f2fs_record_iostat(struct f2fs_sb_info *sbi)
>   				sbi->prev_rw_iostat[i];
>   		sbi->prev_rw_iostat[i] = sbi->rw_iostat[i];
>   	}
> -	spin_unlock_bh(&sbi->iostat_lock);
> +	spin_unlock_irqrestore(&sbi->iostat_lock, flags);
>   
>   	trace_f2fs_iostat(sbi, iostat_diff);
>   
> @@ -145,25 +147,27 @@ void f2fs_reset_iostat(struct f2fs_sb_info *sbi)
>   	struct iostat_lat_info *io_lat = sbi->iostat_io_lat;
>   	int i;
>   
> -	spin_lock_bh(&sbi->iostat_lock);
> +	spin_lock_irq(&sbi->iostat_lock);
>   	for (i = 0; i < NR_IO_TYPE; i++) {
>   		sbi->rw_iostat[i] = 0;
>   		sbi->prev_rw_iostat[i] = 0;
>   	}
> -	spin_unlock_bh(&sbi->iostat_lock);
> +	spin_unlock_irq(&sbi->iostat_lock);
>   
> -	spin_lock_bh(&sbi->iostat_lat_lock);
> +	spin_lock_irq(&sbi->iostat_lat_lock);
>   	memset(io_lat, 0, sizeof(struct iostat_lat_info));
> -	spin_unlock_bh(&sbi->iostat_lat_lock);
> +	spin_unlock_irq(&sbi->iostat_lat_lock);
>   }
>   
>   void f2fs_update_iostat(struct f2fs_sb_info *sbi,
>   			enum iostat_type type, unsigned long long io_bytes)
>   {
> +	unsigned long flags;
> +
>   	if (!sbi->iostat_enable)
>   		return;
>   
> -	spin_lock_bh(&sbi->iostat_lock);
> +	spin_lock_irqsave(&sbi->iostat_lock, flags);
>   	sbi->rw_iostat[type] += io_bytes;
>   
>   	if (type == APP_BUFFERED_IO || type == APP_DIRECT_IO)
> @@ -172,7 +176,7 @@ void f2fs_update_iostat(struct f2fs_sb_info *sbi,
>   	if (type == APP_BUFFERED_READ_IO || type == APP_DIRECT_READ_IO)
>   		sbi->rw_iostat[APP_READ_IO] += io_bytes;
>   
> -	spin_unlock_bh(&sbi->iostat_lock);
> +	spin_unlock_irqrestore(&sbi->iostat_lock, flags);
>   
>   	f2fs_record_iostat(sbi);
>   }
> @@ -185,6 +189,7 @@ static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
>   	struct f2fs_sb_info *sbi = iostat_ctx->sbi;
>   	struct iostat_lat_info *io_lat = sbi->iostat_io_lat;
>   	int idx;
> +	unsigned long flags;
>   
>   	if (!sbi->iostat_enable)
>   		return;
> @@ -202,12 +207,12 @@ static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
>   			idx = WRITE_ASYNC_IO;
>   	}
>   
> -	spin_lock_bh(&sbi->iostat_lat_lock);
> +	spin_lock_irqsave(&sbi->iostat_lat_lock, flags);
>   	io_lat->sum_lat[idx][iotype] += ts_diff;
>   	io_lat->bio_cnt[idx][iotype]++;
>   	if (ts_diff > io_lat->peak_lat[idx][iotype])
>   		io_lat->peak_lat[idx][iotype] = ts_diff;
> -	spin_unlock_bh(&sbi->iostat_lat_lock);
> +	spin_unlock_irqrestore(&sbi->iostat_lat_lock, flags);
>   }
>   
>   void iostat_update_and_unbind_ctx(struct bio *bio, int rw)
