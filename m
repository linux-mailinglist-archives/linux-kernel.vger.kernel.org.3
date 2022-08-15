Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F0D592848
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 05:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiHODwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 23:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiHODwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 23:52:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AB913F47
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 20:52:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 815C3B80CF1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 03:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E67C433D6;
        Mon, 15 Aug 2022 03:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660535552;
        bh=x8mswgoGqL/z1c3stv7WymTX1bkbDAeAwck9N1MfYS0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cGj6y/eJLhf7nsTgC7aSqktLSsEdswIC18PEZUrpeELK4uChjmCRTernzEtYJfczD
         zcHGxIqyIOG2DR6+Q+z0gLM6QVMw0rUr8u88f6eHt4wdD8G9cpojJ78ij2/FJs1bDG
         42xq8vbVpILU76o+m/NyGbp/WSuj/u5AiM36GFh5ucLLqsvycpPnx0DJKtlyp/OgDA
         OjiczQKGG/PHQO6VI2SW8AZxe90myMJSW8YJBvZRqfspOog0IFKC2gqJxaEfNMdYnN
         /I1YHBOecfiDbZ1qktoNtAvZiirc4Z05vXkDlGYL5TrOxwxgNuhfZH0j0vCPhvQmTh
         KK4lfYKUt1pfw==
Message-ID: <65562b32-505f-796e-305a-d1b03baeb388@kernel.org>
Date:   Mon, 15 Aug 2022 11:52:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix wrong continue condition in GC
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     stable@kernel.org
References: <20220813143709.11909-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220813143709.11909-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/13 22:37, Jaegeuk Kim wrote:
> We should decrease the frozen counter.
> 
> Cc: stable@kernel.org
> Fixes: 325163e9892b ("f2fs: add gc_urgent_high_remaining sysfs node")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/gc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 6da21d405ce1..7e4b41240d59 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -102,7 +102,7 @@ static int gc_thread_func(void *data)
>   					sbi->gc_urgent_high_limited = false;
>   					spin_unlock(&sbi->gc_urgent_high_lock);
>   					sbi->gc_mode = GC_NORMAL;
> -					continue;
> +					goto next;
>   				}
>   				sbi->gc_urgent_high_remaining--;
>   			}

Why not:

	if (!sbi->gc_urgent_high_remaining) {
		sbi->gc_urgent_high_limited = false;
		spin_unlock(&sbi->gc_urgent_high_lock);
		sbi->gc_mode = GC_NORMAL;
	} else {
		sbi->gc_urgent_high_remaining--;
	}

Thanks,
