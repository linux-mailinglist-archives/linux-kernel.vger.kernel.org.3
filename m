Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D868586DEA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbiHAPk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiHAPk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:40:57 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6995112D25
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 08:40:55 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id i14so2347628ejg.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 08:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eAe7alzTmYY/YiuNxHp3jFfpoVXuSFHK6N9OKpdBXM4=;
        b=dqXElW12x3Nf1adve0FLN6Dupn3kHSUgN9sYbnFl8W2foA8kCRBB4Oqz3YXG1deXaj
         o9YDAMA4hmvBfemzoDBv44euEEL4C0tcGCUWrXBTUBb9rxMTTedgAUqTZyIKNPWYYev9
         PXZZ/EILKOAjF3Ap07eBe8OJtVzCPglRxSIjD+Pjoz0Jx0TYPzWVC1UFJmTno0gg/N+/
         ER8cX31HqvQVufz/Ptm+durPDQW0AHRNWGDBTexyGkot90rq4/qRINnF33axnPFrngNd
         mf/Jr5rGy+4hV+4A52lPKySYxrYFaKUFZvlT3IlgQoJL30YYudZ/2Gkqo2OUNz+70Cie
         GBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eAe7alzTmYY/YiuNxHp3jFfpoVXuSFHK6N9OKpdBXM4=;
        b=NyBj6K2C5wtSOfPTLbuAzaonQ9CvD6K0XWxQ5+yCWvYZcWg23wdYtFjDh4JbWRlBPR
         TBI1JIlTzPcy5IuZub62k+1p6Ef3Q7AenZqjEMRfp+aKKAiAKUluVwNgftdr7PEAGsmU
         IDF3t/CJfdxV/XmEKPDBI/haC9qh/DezNG2aT/LGCAGsIKycrj6Z82xQ+QFntizmMOYs
         0WhiHs8NKf5u7uMEw/tBfiKKJOwjYRlntsbCef5Jrtuag+s7wLY/XhXgzW+DCNh1Vu45
         +G46mJemXpD+gxSvvWuAnwOWOkBkzhM+TbRt0BX8Z6YKd+QpVAllO/vs30IWyHgloIMY
         qLyA==
X-Gm-Message-State: AJIora/uGHz6dzaUvUbaeP3JQO4N0VVDTx1jX+u9QmdkByAq8zeCN4Pf
        A2daBNML822fUbufUMANE7J0yA==
X-Google-Smtp-Source: AGRyM1uoM9kb4OzQLKOyKkYYZNlkvzM2RV8lA/tro3D3ap0Fiqp2LXBXSiy6IZGJCFZQibND2NCRlA==
X-Received: by 2002:a17:906:5a67:b0:72b:610d:4aa4 with SMTP id my39-20020a1709065a6700b0072b610d4aa4mr13352511ejc.294.1659368454005;
        Mon, 01 Aug 2022 08:40:54 -0700 (PDT)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id o18-20020a170906775200b006fe8c831632sm5264510ejn.73.2022.08.01.08.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 08:40:53 -0700 (PDT)
Message-ID: <4d88538d-c401-ebaf-8f63-8e8b7ad9e632@linbit.com>
Date:   Mon, 1 Aug 2022 17:40:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] lib/lru_cache: Fixed array overflow caused by incorrect
 boundary handling.
Content-Language: en-US
To:     John Sanpe <sanpeqf@gmail.com>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com
References: <20220723075931.163245-1-sanpeqf@gmail.com>
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
In-Reply-To: <20220723075931.163245-1-sanpeqf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 23.07.22 um 09:59 schrieb John Sanpe:
> This problem occurs when malloc element failed on the first time.
> At this time, the counter i is 0. When it's released, we subtract 1
> in advance without checking, which will cause i to become UINT_MAX,
> resulting in array overflow.
> 
> Signed-off-by: John Sanpe <sanpeqf@gmail.com>
> ---
>  lib/lru_cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/lru_cache.c b/lib/lru_cache.c
> index 52313acbfa62..04d95de92602 100644
> --- a/lib/lru_cache.c
> +++ b/lib/lru_cache.c
> @@ -147,7 +147,7 @@ struct lru_cache *lc_create(const char *name, struct kmem_cache *cache,
>  		return lc;
>  
>  	/* else: could not allocate all elements, give up */
> -	for (i--; i; i--) {
> +	while (i--) {
>  		void *p = element[i];
>  		kmem_cache_free(cache, p - e_off);
>  	}

Thanks for the fix, looks good to me.

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
