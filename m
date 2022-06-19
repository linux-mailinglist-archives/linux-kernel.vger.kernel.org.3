Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD8A5507C6
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 02:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbiFSAlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 20:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFSAlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 20:41:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8077810FE3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 17:41:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F0E360E09
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 00:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A67C3411A;
        Sun, 19 Jun 2022 00:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655599264;
        bh=7Szk84PluvaE/i1H0i4KYSWKHR6uBovmNJ8fRYEiXLc=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=YBMwtlCeRySE4VibIAG6yjvMtWZkW9ctVw5Lnilbe6p3hE3iKLqMQI+0gamwKyTss
         UGUe/fWmg7FCvJWFqi3GMTz30n0aT2po0Z+kejU+2Hm6OqIs/dU/ffF0HRNb8CY3ZD
         gHxOgPmFEy+D9QSsaoQvalSY8wqYR+mIaCnp1oU6tcDgp3JHGCACbkTDJnC3fWCTnX
         PXwUjesZe6cE+v26+M5rLz+xNah82WquuDr/A9by6JO827HcCh4pOBbfW+N+TqbVVg
         ISoedBHDOUd9uHJodPvOp3rs+qzA2fKGvKBbmyeyrbr/fBP3Xpl+q9ZvkMDEGa39Q1
         tilfzGpNccYnA==
Message-ID: <c45a9c8b-c73a-76bc-6725-5d7e48e7a3f2@kernel.org>
Date:   Sun, 19 Jun 2022 08:41:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: run GCs synchronously given user
 requests
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220617223106.3517374-1-jaegeuk@kernel.org>
 <20220617223106.3517374-2-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220617223106.3517374-2-jaegeuk@kernel.org>
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

On 2022/6/18 6:31, Jaegeuk Kim wrote:
> When users set GC_URGENT or GC_MID, they expected to do GCs right away.
> But, there's a condition to bypass it. Let's indicate we need to do now
> in the thread.

.should_migrate_blocks is used to force migrating blocks in full
section, so what is the condition here? GC should not never select
a full section, right?

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/gc.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index d5fb426e0747..f4aa3c88118b 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -37,7 +37,6 @@ static int gc_thread_func(void *data)
>   	unsigned int wait_ms;
>   	struct f2fs_gc_control gc_control = {
>   		.victim_segno = NULL_SEGNO,
> -		.should_migrate_blocks = false,
>   		.err_gc_skipped = false };
>   
>   	wait_ms = gc_th->min_sleep_time;
> @@ -113,7 +112,10 @@ static int gc_thread_func(void *data)
>   				sbi->gc_mode == GC_URGENT_MID) {
>   			wait_ms = gc_th->urgent_sleep_time;
>   			f2fs_down_write(&sbi->gc_lock);
> +			gc_control.should_migrate_blocks = true;
>   			goto do_gc;
> +		} else {
> +			gc_control.should_migrate_blocks = false;
>   		}
>   
>   		if (foreground) {
> @@ -139,7 +141,9 @@ static int gc_thread_func(void *data)
>   		if (!foreground)
>   			stat_inc_bggc_count(sbi->stat_info);
>   
> -		sync_mode = F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC;
> +		sync_mode = F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC ||
> +				sbi->gc_mode == GC_URGENT_HIGH ||
> +				sbi->gc_mode == GC_URGENT_MID;
>   
>   		/* foreground GC was been triggered via f2fs_balance_fs() */
>   		if (foreground)
