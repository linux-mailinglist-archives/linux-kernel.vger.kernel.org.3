Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A01528407
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241481AbiEPMTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbiEPMTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:19:01 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB1B2CCA4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:19:00 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id c14so13882732pfn.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mauTUK/BbcN02BKF1E5WYv3nctbs4If/Xj3WrKUUUZQ=;
        b=jCliMATnCO8tjtRg2mTj+wIggrHc1Ww95M+EpFTLeHPCom0/OxF6OWD8yQPneh4AlB
         zhGjv7fVnX5G+btxOAZNayNSnKRmdGAXGw+PelbQosH/RdJ3NSYVeWEHhuYg2XJuaLTC
         spem+JzWfbThl2xtEtJ0p8EAl+dealFC0vUqr59B8DUApioU5mHWVCc4/H44XcDlxZiV
         K1aNpj/8/z0cqpQajSVsVdOktvjZePhDddDu7Cisp/HT/HzHn1capZu+tLOFWwoEkP2L
         G+fAfZ09jL2H08kOHzh+j7tUXH3X58XT7ntG6kijy4IQSbUDCH6N8aoG7Ji768cToWv7
         6JCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mauTUK/BbcN02BKF1E5WYv3nctbs4If/Xj3WrKUUUZQ=;
        b=kPbMtRwhG5Tk6TfJm6lpWY1k9pQCfAvhpvRz0VvC2slzFMWtwWjfRnmVd5+YjGTrvg
         Esm3J7K8f60y93KCAp+L1ZxiT3heZAQolqhAfc03IKevNa1CzDIvNhvwhtjP7Q4pF5pY
         fEmN0WZ6y3GBDwrkVsB7bOhGcSm3Lc8uA/yt4q/eFRBa491hWHIvfRx2Bhf++L10qijG
         566xggqluF8wMVMS3iSPQr9VPRHPHGg3QSbpS6li6kq4TbhZXcqfyelYR/rYs5FLAgGJ
         58t79KUOytbOPS2d7mWXNKjCLiyLIL8lgM/cF1hmy/L8zMLUKrFGe17noMZuop0sZJij
         JcNQ==
X-Gm-Message-State: AOAM533vHOHtI7PZMcI7I/YOZhBPszoTJyi9MXxOjsHiMTwlt4YAKxrF
        +U3LedrQp2cWT07M0jrIGnVQlw==
X-Google-Smtp-Source: ABdhPJz3jVAkhdYsDGcE7BnBGbvfMWWBjs7MKFZpG91v2is0HkVS7WMpZr64iZpw1P+w2KDN2v3+Ow==
X-Received: by 2002:a63:1e1d:0:b0:3c6:a36f:7b13 with SMTP id e29-20020a631e1d000000b003c6a36f7b13mr15195060pge.447.1652703540014;
        Mon, 16 May 2022 05:19:00 -0700 (PDT)
Received: from [10.254.222.110] ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id d17-20020a170902aa9100b0015e8d4eb218sm6929028plr.98.2022.05.16.05.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 05:18:59 -0700 (PDT)
Message-ID: <bbd8744f-d938-c4a5-cb02-145c9875ea53@bytedance.com>
Date:   Mon, 16 May 2022 20:18:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH] blk-iocos: fix inuse clamp when iocg deactivate or free
Content-Language: en-US
To:     tj@kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
References: <20220516101909.99768-1-zhouchengming@bytedance.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220516101909.99768-1-zhouchengming@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/16 18:19, Chengming Zhou wrote:
> For an active leaf node, its inuse shouldn't be zero or exceed
> its active, but it's not true when deactivate idle iocg or delete
> iocg in ioc_pd_free().
> 
> Although inuse of 1 is very small, it could cause noticeable hwi
> decrease in the long running server. So we'd better fix it.
> 
> And check iocg->child_active_sum is enough for inner iocg, remove
> the needless list_empty check by the way.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  block/blk-iocost.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 2570732b92d1..84374ebcc402 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -1073,11 +1073,11 @@ static void __propagate_weights(struct ioc_gq *iocg, u32 active, u32 inuse,
>  	 * @active. An active internal node's inuse is solely determined by the
>  	 * inuse to active ratio of its children regardless of @inuse.
>  	 */
> -	if (list_empty(&iocg->active_list) && iocg->child_active_sum) {
> +	if (iocg->child_active_sum) {
>  		inuse = DIV64_U64_ROUND_UP(active * iocg->child_inuse_sum,
>  					   iocg->child_active_sum);
>  	} else {
> -		inuse = clamp_t(u32, inuse, 1, active);
> +		inuse = clamp_t(u32, inuse, 0, active);

I found the commit message is wrong after a second look at the test data,
inuse value will be zero when active is zero, since:

#define clamp_t(type, val, lo, hi) min_t(type, max_t(type, val, lo), hi)

So clamp_t(u32, 0, 1, 0) will return 0, deactivate idle iocg or delete iocg
will set its inuse to zero correctly.

The inuse -> 1 happened in the test data turn out to be iocg_incur_debt(),
which call __propagate_weights() with active = weight, inuse = 0, so
clamp_t(u32, 0, 1, active) return 1.

Then this effect is very small, unlikely to have an impact in practice. Should
I modify the commit message to send v2 or just drop it?

Thanks.

>  	}
>  
>  	iocg->last_inuse = iocg->inuse;
