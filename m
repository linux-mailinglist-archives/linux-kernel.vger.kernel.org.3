Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5372D501D5E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 23:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346320AbiDNVZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 17:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345125AbiDNVZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 17:25:20 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CC1E0ADA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:22:53 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id m8so7586070ljc.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=N4HLGfvB+8+NMPcma6ojtQZuOsbor7W890ru+Wl5k+A=;
        b=Vtu2zM9TgoLp0lFsN8cZ84YFteD6ZDK8uHWYw9y4EpaMfzQIj55ErNEGzbMA6Ij+Nx
         Hdq9rICuROBOdBoBNCwt02Z47zs+QKwjYYvCrZ5VfikSNEbtsrPY7IF0Qn9s2ruKYdSV
         MqMepUNNvdia8syLrys1RUq1FFwoj6hLCpFcDjmpTpuIUP2Hl4f4PNYk/MCTeVj+vvpB
         NFtiuputIq5Kq/D1ogchg8xfjaCT3ieidhvRxZghb7BnQskt1+vS2Q/fz8TwPczcFomr
         csnScCGdu4XkhtyqfP20lKWV18tpTNxLG2Phuis/fHu/fglP2zhDI9YuNbM5dsoy9Y9d
         Yryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N4HLGfvB+8+NMPcma6ojtQZuOsbor7W890ru+Wl5k+A=;
        b=JJj5BSIX98dW0sWZcZJROtf+9sMIWWXkeBxDRWej7E5jpfw1c1C54FOWBUFYLyjVwe
         TqphoRgn1GuKKNmoRJqC/GC113UTHfwIYWGJw2GgCRZxQlTIMIsmqozoyQLI53a5MAG3
         k+VYrJmBVZD9zzNVeRrSzUSK/FyXWSNvIys2nREenmIBKb5nAeXJqEnrjuix/VF86jUJ
         ZMdqJeOJTgBGlB/PAZJuDtbyNmsYzIc/7jKGUdc86ki6vL4jikHSew1m2V60wYefgaVI
         l0yDxZtgQmCVvUexElmB11THRrHKCWscXvMEzbDdb+D8aBSsZAFEjaKFAW7ouwaYLbud
         QnxQ==
X-Gm-Message-State: AOAM531cVG/CsO+MKe9tQesLoiMN4lTOjhqcfEcSDDk7wus9nYFAvSbw
        gp+SZx3tn5TmhYF3CCpE3jDGiQ==
X-Google-Smtp-Source: ABdhPJz3h3GOjyhWlMc5Z/uIaPCL2LUsnN4ZjhJCyjF7rOnkzpRWDzc13CNpIFg3DaMvmP4G15bTeQ==
X-Received: by 2002:a05:651c:508:b0:24b:147b:161c with SMTP id o8-20020a05651c050800b0024b147b161cmr2605943ljp.459.1649971371418;
        Thu, 14 Apr 2022 14:22:51 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id k6-20020a056512330600b0046d11847ccasm112122lfe.227.2022.04.14.14.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 14:22:50 -0700 (PDT)
Message-ID: <be83952d-d411-d0c8-e05f-ad50a8ba9c0e@linaro.org>
Date:   Fri, 15 Apr 2022 00:22:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 03/10] drm/msm/gem: Convert some missed GEM_WARN_ON()s
Content-Language: en-GB
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
References: <20220411215849.297838-1-robdclark@gmail.com>
 <20220411215849.297838-4-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220411215849.297838-4-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2022 00:58, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/msm_gem_vma.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
> index f914ddbaea89..64906594fc65 100644
> --- a/drivers/gpu/drm/msm/msm_gem_vma.c
> +++ b/drivers/gpu/drm/msm/msm_gem_vma.c
> @@ -44,7 +44,7 @@ void msm_gem_purge_vma(struct msm_gem_address_space *aspace,
>   	unsigned size = vma->node.size << PAGE_SHIFT;
>   
>   	/* Print a message if we try to purge a vma in use */
> -	if (WARN_ON(vma->inuse > 0))
> +	if (GEM_WARN_ON(vma->inuse > 0))
>   		return;
>   
>   	/* Don't do anything if the memory isn't mapped */
> @@ -61,7 +61,7 @@ void msm_gem_purge_vma(struct msm_gem_address_space *aspace,
>   void msm_gem_unmap_vma(struct msm_gem_address_space *aspace,
>   		struct msm_gem_vma *vma)
>   {
> -	if (!WARN_ON(!vma->iova))
> +	if (!GEM_WARN_ON(!vma->iova))
>   		vma->inuse--;
>   }
>   
> @@ -73,7 +73,7 @@ msm_gem_map_vma(struct msm_gem_address_space *aspace,
>   	unsigned size = npages << PAGE_SHIFT;
>   	int ret = 0;
>   
> -	if (WARN_ON(!vma->iova))
> +	if (GEM_WARN_ON(!vma->iova))
>   		return -EINVAL;
>   
>   	/* Increase the usage counter */
> @@ -100,7 +100,7 @@ msm_gem_map_vma(struct msm_gem_address_space *aspace,
>   void msm_gem_close_vma(struct msm_gem_address_space *aspace,
>   		struct msm_gem_vma *vma)
>   {
> -	if (WARN_ON(vma->inuse > 0 || vma->mapped))
> +	if (GEM_WARN_ON(vma->inuse > 0 || vma->mapped))
>   		return;
>   
>   	spin_lock(&aspace->lock);
> @@ -120,7 +120,7 @@ int msm_gem_init_vma(struct msm_gem_address_space *aspace,
>   {
>   	int ret;
>   
> -	if (WARN_ON(vma->iova))
> +	if (GEM_WARN_ON(vma->iova))
>   		return -EBUSY;
>   
>   	spin_lock(&aspace->lock);


-- 
With best wishes
Dmitry
