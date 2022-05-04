Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA48D51A2E2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351676AbiEDPE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351659AbiEDPEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:04:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62892AE23
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 08:01:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A8DCB825F8
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:01:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E9AC385AA;
        Wed,  4 May 2022 15:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651676476;
        bh=hsb9BD/AU1MN+uA25YZeRTjDbC9XD7vw8yxTGz+0JYA=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=o4dn9ADSKLFj4Ka6j5C8RJoR7BJakNMSyTWjQg5fK2Tzi85sgProzAjuuqYEfbFPy
         /GMIz8C9FBnu/BVVAaRMpq01uwNE03URajY0jPlOsehuXfNuf7zHdbjOYj8qUv69dp
         DiZnWH72LQKgmPesxxu5/AzPC35I5I9YuwmAy57wiOcVrraAbgDI1TR91BuLPplu0D
         9vteAJupCJ9SEwl2w8KrFlPYfMetqHUO/l8jVVKC3aheNp5gU8wfSfCCrdJfdbnYMB
         ok4tagakp6LUdAF17YxDWc7iHmTuORVqrmdiv8vgYRcvZc6K6TsbF2RVwFUTHpZAnk
         7RQ4AFeYoFqUw==
Message-ID: <cf5d3814-073f-df3c-a16d-33161140fe6f@kernel.org>
Date:   Wed, 4 May 2022 23:01:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: avoid to select pinned section
 during checkpoint=disable
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220503203040.365028-1-jaegeuk@kernel.org>
 <20220503203040.365028-2-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220503203040.365028-2-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/4 4:30, Jaegeuk Kim wrote:
> The f2fs_gc uses a bitmap to indicate pinned sections, but when disabling
> chckpoint, we call f2fs_gc() with NULL_SEGNO which selects the same dirty
> segment as a victim all the time, resulting in checkpoint=disable failure.
> Let's pick another one, if we fail to collect it.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/gc.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 4d47723523c3..5ba8104e138b 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1838,10 +1838,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>   	if (gc_type == FG_GC)
>   		sbi->cur_victim_sec = NULL_SEGNO;
>   
> -	if (sync)
> -		goto stop;

Semantics of 'sync' parameter should be: migrate one section at least before
exit?

So, should it be?

if (seg_freed && (sync || !has_not_enough_free_secs(sbi, sec_freed, 0)))
	goto stop;

Thanks,

> -
> -	if (!has_not_enough_free_secs(sbi, sec_freed, 0))
> +	if (!has_not_enough_free_secs(sbi, sec_freed, 0) && seg_freed)
>   		goto stop;
>   
>   	if (skipped_round <= MAX_SKIP_GC_COUNT || skipped_round * 2 < round) {
