Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD8C52ECEA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349719AbiETNOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236665AbiETNOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:14:15 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0EB149DB1;
        Fri, 20 May 2022 06:14:14 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id q8so9859451oif.13;
        Fri, 20 May 2022 06:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J1TqYWvInWBNVGCPH/z2pZbWfdCQqeAMqP1BbNQTqhs=;
        b=dJTZzvLoQ/LOjQgXGJKHVj1eCw3vf2YVGrT7mIWG8OX78B1yXTJTcbxbjNz/NWlMGr
         YdI+WV2E3uR/ibEb/SgCUGfY6Mqj5g5X6/nXAFEd9SkKwYSuspKOAV49eIL7uC5BfrFD
         GlxOAy2821DPIsTeIKzTZNvb5Z2Lvf9vp4U6K0bdNC7rMgBLD+u33XM4GJkgHCM4o+pb
         pN+vPywZ1Jv25E50VjhVVSZDlg9NP5CGMQDliA8HWxZ/EO1VN0mmgeJQUZdKzXSmrhwV
         QzngA/A4HJbjNmeVlRrnJx2pBMEJ9pjn5V8yMDNN6DTXpBJGONru6kP7wlLfHlEJbkbs
         3Yzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J1TqYWvInWBNVGCPH/z2pZbWfdCQqeAMqP1BbNQTqhs=;
        b=l9Lec2lylpFhRaByTGaaRN47pHGekHjQ1taNzLcAVKmfnaliNuQGEDXnzfKltJirte
         wpk+nItHCp4SUapcDYMTqJFHVtZ/UB/dDW765bN5k/3BsHfmhu/D7tVHuFq48Z0yt1A3
         H5Z8NRBVl+eab6aIJHfPQaJreBR1O8PYVUFXKf6xdZG7Hteyjqk9X8oSma5M84iCi/5q
         yqNe4v/frRmjwxJKKjmwCraRv44WBIqUTQEYgZVTep7qsjdfYiRNsYqMBsySpAGt3yL4
         wkwPkf6g0gXnkN+GFXa1exT4f19N/pb3MmFjBVbCwEz/7LFqvXwvEtvzbeMLZwoeuIeK
         qmxQ==
X-Gm-Message-State: AOAM532T2udDn2dvdxGye2LnCPoFzJa3ZzHazHAnpacIiJKIaOzPKLO4
        GLD8K75P6K7a+8opnC2l4Os=
X-Google-Smtp-Source: ABdhPJzU22VIvkGyaVF3avLKa6ozH9kxgKgJqekRfWSD7N6WH8eRCArP/5ENzxPQFqJwygJBvySwOg==
X-Received: by 2002:a05:6808:1308:b0:326:8e54:e93f with SMTP id y8-20020a056808130800b003268e54e93fmr5436156oiv.274.1653052453675;
        Fri, 20 May 2022 06:14:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id eq37-20020a056870a92500b000e686d13883sm959266oab.29.2022.05.20.06.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 06:14:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f262df9e-ae89-f961-8b5e-1f4166eb1470@roeck-us.net>
Date:   Fri, 20 May 2022 06:14:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/msm/adreno: Do not propagate void return values
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <483795c4fb7d215a3f2089c55df29a0064eb021b.1653051029.git.geert@linux-m68k.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <483795c4fb7d215a3f2089c55df29a0064eb021b.1653051029.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/22 05:53, Geert Uytterhoeven wrote:
> With sparse ("make C=2"), lots of
> 
>    error: return expression in void function
> 
> messages are seen.
> 
> Fix this by removing the return statements to propagate void return
> values.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 2 +-
>   drivers/gpu/drm/msm/adreno/a6xx_gmu.h | 4 ++--
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 3e325e2a2b1b68eb..d137136d93f3b4ca 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -504,7 +504,7 @@ static void a6xx_rpmh_stop(struct a6xx_gmu *gmu)
>   
>   static inline void pdc_write(void __iomem *ptr, u32 offset, u32 value)
>   {
> -	return msm_writel(value, ptr + (offset << 2));
> +	msm_writel(value, ptr + (offset << 2));
>   }
>   
>   static void __iomem *a6xx_gmu_get_mmio(struct platform_device *pdev,
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> index 84bd516f01e895b2..e034935b3986f9f2 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> @@ -98,7 +98,7 @@ static inline u32 gmu_read(struct a6xx_gmu *gmu, u32 offset)
>   
>   static inline void gmu_write(struct a6xx_gmu *gmu, u32 offset, u32 value)
>   {
> -	return msm_writel(value, gmu->mmio + (offset << 2));
> +	msm_writel(value, gmu->mmio + (offset << 2));
>   }
>   
>   static inline void
> @@ -138,7 +138,7 @@ static inline u32 gmu_read_rscc(struct a6xx_gmu *gmu, u32 offset)
>   
>   static inline void gmu_write_rscc(struct a6xx_gmu *gmu, u32 offset, u32 value)
>   {
> -	return msm_writel(value, gmu->rscc + (offset << 2));
> +	msm_writel(value, gmu->rscc + (offset << 2));
>   }
>   
>   #define gmu_poll_timeout_rscc(gmu, addr, val, cond, interval, timeout) \
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index ccc4fcf7a630f49a..d671b75f3289fdff 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1446,7 +1446,7 @@ static void a6xx_llc_rmw(struct a6xx_gpu *a6xx_gpu, u32 reg, u32 mask, u32 or)
>   
>   static void a6xx_llc_write(struct a6xx_gpu *a6xx_gpu, u32 reg, u32 value)
>   {
> -	return msm_writel(value, a6xx_gpu->llc_mmio + (reg << 2));
> +	msm_writel(value, a6xx_gpu->llc_mmio + (reg << 2));
>   }
>   
>   static void a6xx_llc_deactivate(struct a6xx_gpu *a6xx_gpu)

