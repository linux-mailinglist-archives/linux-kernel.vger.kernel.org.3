Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355C350FC8B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbiDZMN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346634AbiDZMNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:13:24 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75A4140D2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 05:10:14 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e24so5292929wrc.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 05:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SBTUBalrmsGV4wHuVwnt+xQyAyi2izs2hLq/5SlDTdQ=;
        b=IPvpTqTkcE+1lXDcXWcVswppdTfsegOwZC5FfeR8mBNzk4V1+FiUwsTpMwwIY3LqWJ
         eu/9DdE8exvuKdGIYWVL3uCnUfAvpGD0doUx1Y/ye0LHarcYrMqdjfrskRTeUUyIg/tm
         8IlFo0SkYL4kQne3lbe/+bBnAtIj2R1irqbY9ZpaVQ180wd0pWxj+FRnn967XlchSvAk
         zKuvCZs/ApXVoTeaaQT8kyX4mPBQAvgXK2D64tltp/rnYzOGk1y84OjWgZ33LwrZ2WRM
         l5jIc3C3d+jKu0uWXxAxMJ2BgERMRXW1iK+H29hPZ2yAIk8xX7K/TLx6+Ai2LBG2ibll
         bUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SBTUBalrmsGV4wHuVwnt+xQyAyi2izs2hLq/5SlDTdQ=;
        b=O/9UICWvUvX+ruEgXH2l9cheBhAOwphRq8k201JKvEBz16WMn43Ds1TKtaKrmNhjEm
         g3uKP1eHae5lIQ4R7Dgo22nh1BcB7RzSAmrme77xIowyD+7QlfNDR18eJzPoVBt73uXo
         +McglqqUcXd3iUsJJdRg2YHdDIO+s4Yi8IGRKT5g2KKxTHuMSnd0dGWB9zax6PUDO18J
         31M0cCJNM1Vx+EcHdVUmLAQ/dCMJR7WZn5hcuW8XMzyFwtPgd0YbG/fBqkX5K6PH+cPS
         l5a87mPdqEy2B7JjPoxB4w5CcH1q/e79sKyqN9reoeCr+ynjBy8xjUPOy2N/5xKttcF2
         /tLA==
X-Gm-Message-State: AOAM531bh5560mJ2G5alz7FC5sL+dDRYnyIy/G3fGh+WoY9UH2Pu+qRV
        ee12bozNN/ijsTkp7R1m07SCAXnrefvDhQ==
X-Google-Smtp-Source: ABdhPJx9fs0Di5nAry45RTpJHzgxkxMgCTnkGkkrw+4C7MUY507lRNcIWaRel14QDg89AeMZOCBgXg==
X-Received: by 2002:a05:6000:1a4f:b0:20a:ccdd:c70e with SMTP id t15-20020a0560001a4f00b0020accddc70emr15839931wry.444.1650975013306;
        Tue, 26 Apr 2022 05:10:13 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:c916:9f2:ce75:976f])
        by smtp.gmail.com with ESMTPSA id m4-20020a7bcb84000000b00389efb7a5b4sm13905873wmi.17.2022.04.26.05.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 05:10:12 -0700 (PDT)
Date:   Tue, 26 Apr 2022 14:10:06 +0200
From:   Marco Elver <elver@google.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH] arm64: kcsan: Fix kcsan test_barrier fail and panic
Message-ID: <YmfhHuPDilwR/Wgp@elver.google.com>
References: <20220426081700.1376542-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426081700.1376542-1-wangkefeng.wang@huawei.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 08:17AM +0000, Kefeng Wang wrote:
> As "kcsan: Support detecting a subset of missing memory barriers"
> introduced KCSAN_STRICT which make kcsan detects more missing memory
> barrier, but arm64 don't have KCSAN instrumentation for barriers, so
> the new selftest test_barrier() will fail, then panic.

Thanks for fixing this - did kcsan_test module pass as well?

> Let's prefix all barriers with __ on arm64, as asm-generic/barriers.h
> defined the final instrumented version of these barriers, which will
> fix the above issues.
> 
> Fixes: dd03762ab608 ("arm64: Enable KCSAN")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/arm64/include/asm/barrier.h | 12 ++++++------
>  include/asm-generic/barrier.h    |  4 ++++
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> index 62217be36217..9760a8d4ed0a 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h
> @@ -46,13 +46,13 @@
>  #define pmr_sync()	do {} while (0)
>  #endif
>  
> -#define mb()		dsb(sy)
> -#define rmb()		dsb(ld)
> -#define wmb()		dsb(st)
> +#define __mb()		dsb(sy)
> +#define __rmb()		dsb(ld)
> +#define __wmb()		dsb(st)
>  
> -#define dma_mb()	dmb(osh)
> -#define dma_rmb()	dmb(oshld)
> -#define dma_wmb()	dmb(oshst)
> +#define __dma_mb()	dmb(osh)
> +#define __dma_rmb()	dmb(oshld)
> +#define __dma_wmb()	dmb(oshst)
>  
>  #define io_stop_wc()	dgh()
>  
> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index fd7e8fbaeef1..18863c50e9ce 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -38,6 +38,10 @@
>  #define wmb()	do { kcsan_wmb(); __wmb(); } while (0)
>  #endif
>  
> +#ifdef __dma_mb
> +#define dma_mb()	do { kcsan_mb(); __dma_mb(); } while (0)
> +#endif
> +

So it looks like arm64 is the only arch that defines dma_mb(). By adding
it to asm-generic, we'd almost be encouraging other architectures to add
it, which I don't know we want.

Documentation/memory-barriers.txt doesn't mention dma_mb() either - so
perhaps dma_mb() doesn't belong in asm-generic/barrier.h, and you could
only change arm64's definition of dma_mb() to add the kcsan_mb().

Preferences? Maybe arch64 maintainers have more background on why arm64
is an anomaly here.
