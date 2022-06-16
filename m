Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5FB54EA84
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378467AbiFPUFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238989AbiFPUFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:05:50 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C8B5A2DC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:05:50 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id d123so2559724iof.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sXfBZO9ZRn0KOfuHBoTG+TELVXjQhauO7xL7gMi8B0Y=;
        b=C7AWpVwAilbv008PKE48q4h2NgYag8QQzF4yb085/ArkYwWUiI2poVqCP/YopmIYBY
         vc09Xo0K2sMbw4stLKOAtLGPQzaqD+h+9+Q5uibYTSzVbBWmBWhWPwngUKfd+NFsTUvu
         BG89yOcxtyfn7fW8p7WysoWWll6mduo16WgjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sXfBZO9ZRn0KOfuHBoTG+TELVXjQhauO7xL7gMi8B0Y=;
        b=tM4xUPRANbviSXjfUhokSm+NM0It5MJBiTYMJJsywiCwCJ/s6FB90Tn2MAiiNurZxm
         EFl1/QdDIL6Kiecg+U6n5dPDHGXevez6LhD5fsIKGuJ8tjse7F9NEwYYrOsMS5hZWMUk
         omkuscTDG3IM0QJR7Oru+1hgC3ldYaLJ649Ho5KAzCCZIslk7fiT4DqQKKntr4D4qXJ1
         YXVTZqovnqtRHXlSe+FulPeIyCIXDDFVa4VVlC0fTy/Qp7ww3Ico8VGiD1bnwJ3xP8nb
         YXZH+5vRuh3y0zsYoOIKZcxCM23ffhk44WkqGOGusLNRksBuj/Smj8cbJWbJrTjG3sDH
         DfXA==
X-Gm-Message-State: AJIora8ObxwzBYuAF82u27ZW1s4d+dt8Dcm7izHSN43QC9li2MlGAEKN
        nJ1tcVHD/vd0g6lUT5Kc5KU3+g==
X-Google-Smtp-Source: AGRyM1s3MhiJK28iDE6KTeTBg8unerh1aIfshtClc3lpEHOuu9zX9BgUvBIFiiAHPkvxPXci/aL5sA==
X-Received: by 2002:a05:6638:dc3:b0:333:ef3c:ba02 with SMTP id m3-20020a0566380dc300b00333ef3cba02mr3652087jaj.245.1655409949407;
        Thu, 16 Jun 2022 13:05:49 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id x71-20020a0294cd000000b003314830ab40sm1292039jah.6.2022.06.16.13.05.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 13:05:49 -0700 (PDT)
Subject: Re: [PATCH] selftests dma: fix compile error for dma_map_benchmark
To:     Yu Liao <liaoyu15@huawei.com>, chenxiang66@hisilicon.com,
        song.bao.hua@hisilicon.com, tiantao6@hisilicon.com,
        shuah@kernel.org
Cc:     liwei391@huawei.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220614120235.1557825-1-liaoyu15@huawei.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0e109d9a-e2e3-b3fd-a2cc-6f05abe90e0c@linuxfoundation.org>
Date:   Thu, 16 Jun 2022 14:05:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220614120235.1557825-1-liaoyu15@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/22 6:02 AM, Yu Liao wrote:
> When building selftests/dma:
> $ make -C tools/testing/selftests TARGETS=dma
> I hit the following compilation error:
> 
> dma_map_benchmark.c:13:10: fatal error: linux/map_benchmark.h: No such file or directory
>   #include <linux/map_benchmark.h>
>            ^~~~~~~~~~~~~~~~~~~~~~~
> 
> dma/Makefile does not include the map_benchmark.h path, so add
> more including path, and fix include order in dma_map_benchmark.c
> 
> Fixes: 8ddde07a3d28 ("dma-mapping: benchmark: extract a common header file for map_benchmark definition")
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
> ---
>   tools/testing/selftests/dma/Makefile            | 1 +
>   tools/testing/selftests/dma/dma_map_benchmark.c | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/dma/Makefile b/tools/testing/selftests/dma/Makefile
> index aa8e8b5b3864..cd8c5ece1cba 100644
> --- a/tools/testing/selftests/dma/Makefile
> +++ b/tools/testing/selftests/dma/Makefile
> @@ -1,5 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   CFLAGS += -I../../../../usr/include/
> +CFLAGS += -I../../../../include/
>   
>   TEST_GEN_PROGS := dma_map_benchmark
>   
> diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
> index c3b3c09e995e..5c997f17fcbd 100644
> --- a/tools/testing/selftests/dma/dma_map_benchmark.c
> +++ b/tools/testing/selftests/dma/dma_map_benchmark.c
> @@ -10,8 +10,8 @@
>   #include <unistd.h>
>   #include <sys/ioctl.h>
>   #include <sys/mman.h>
> -#include <linux/map_benchmark.h>
>   #include <linux/types.h>
> +#include <linux/map_benchmark.h>
>   
>   #define NSEC_PER_MSEC	1000000L
>   
> 

Thank you for the fix. Applied to linux-kselftest fixes branch for
Linux 5.19-rc3 or rc4

thanks,
-- Shuah
