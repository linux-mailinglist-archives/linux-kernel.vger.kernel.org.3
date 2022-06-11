Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61EB547717
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 20:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiFKSQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 14:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiFKSQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 14:16:44 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A50A6D3BA
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 11:16:40 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-100eb6f7782so3274149fac.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 11:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kgRN1xEQcitAejCBLpzML1+JqkKMRkpU5jU1U59JtqE=;
        b=JSzeQQNZSFvyTFEakgnEEc1U3Ooj9KJ/WvCXS0bFwd92LVCZ/A/lElrk/VaSc/FbUO
         /wViRb+cDQhSRNLcI8pkoviXuMbZQz6l0Ke8ehmlTcJsupvN2jr5YvTbPL9ayvPuYtwe
         w7Bd73fXXEcKPoQJdgYcbqepmPDYT5ckwjz26eiqYmkeXytwT65GGUo8qFw0bBql6Unv
         tmy98DlvUK2XG28yo7bbnBpfaqx76zzuDQpfM0MyvrvaGoS09R8ztPNzxRKpMuCbvrJS
         vO8UpjMF7l1lOt7pW+7839VwMJdR9IqbdUne3QRkZdwMJexDFESHpA0SJaSDEIvIyzkB
         QTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kgRN1xEQcitAejCBLpzML1+JqkKMRkpU5jU1U59JtqE=;
        b=lLX+EZ8q2yhBCm0ML9sScraAoIrXgah/6I49visATqRCLWBq/0Sky7r/J+IleTwRZ/
         ZyaWEtUCpvJZ/+K10WQBaNLTpA01CcDAp0k8p9rD66hhTa4N1PvOhCtQiR66jWAt88N5
         e9XaIamzIzWYqwBDlbHam49c4b7i69BTzSNLCHNjrU2aDJXMHrXRJqWuv+z0sUEMeI2L
         Vv4Yib2dwMa3SPaUswbxuSUV5wChyVJiNzi2wFsvvrkpTMnL9CKPFwxolFZTn8VHXH91
         nSD7gZO5ysOO1cjvawkOIgaPgSgPUMG19u3KbdyK1e0w74ZOrATY8ouC99mZGauE0k4z
         jwXw==
X-Gm-Message-State: AOAM533Glsk6E3HiIUy9FR7d3g3gbtKYgkLmvcoTfB3DGj22tOmSwvAi
        vtpLvEXdRaHKCETfp9mP8qTBRg==
X-Google-Smtp-Source: ABdhPJxH6EjZpF1SBHn+LX+TQys5+EfxFofNkvijYQT6OUdvv/+GF69NEHAXWY+ttpQglZ7ZTOqnZg==
X-Received: by 2002:a05:6870:889c:b0:f2:57f0:b7ef with SMTP id m28-20020a056870889c00b000f257f0b7efmr3130568oam.243.1654971399704;
        Sat, 11 Jun 2022 11:16:39 -0700 (PDT)
Received: from [192.168.11.16] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id z3-20020a056870d68300b000f342119f41sm1352095oap.42.2022.06.11.11.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jun 2022 11:16:35 -0700 (PDT)
Message-ID: <42e52572-726b-d94d-6523-7b42dbeecff1@kali.org>
Date:   Sat, 11 Jun 2022 13:16:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH] drm/msm/gem: Drop early returns in close/purge vma
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
References: <20220610172055.2337977-1-robdclark@gmail.com>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <20220610172055.2337977-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 6/10/22 12:20 PM, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
>
> Keep the warn, but drop the early return.  If we do manage to hit this
> sort of issue, skipping the cleanup just makes things worse (dangling
> drm_mm_nodes when the msm_gem_vma is freed, etc).  Whereas the worst
> that happens if we tear down a mapping the GPU is accessing is that we
> get GPU iova faults, but otherwise the world keeps spinning.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/msm/msm_gem_vma.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
> index 3c1dc9241831..c471aebcdbab 100644
> --- a/drivers/gpu/drm/msm/msm_gem_vma.c
> +++ b/drivers/gpu/drm/msm/msm_gem_vma.c
> @@ -62,8 +62,7 @@ void msm_gem_purge_vma(struct msm_gem_address_space *aspace,
>   	unsigned size = vma->node.size;
>   
>   	/* Print a message if we try to purge a vma in use */
> -	if (GEM_WARN_ON(msm_gem_vma_inuse(vma)))
> -		return;
> +	GEM_WARN_ON(msm_gem_vma_inuse(vma));
>   
>   	/* Don't do anything if the memory isn't mapped */
>   	if (!vma->mapped)
> @@ -128,8 +127,7 @@ msm_gem_map_vma(struct msm_gem_address_space *aspace,
>   void msm_gem_close_vma(struct msm_gem_address_space *aspace,
>   		struct msm_gem_vma *vma)
>   {
> -	if (GEM_WARN_ON(msm_gem_vma_inuse(vma) || vma->mapped))
> -		return;
> +	GEM_WARN_ON(msm_gem_vma_inuse(vma) || vma->mapped);
>   
>   	spin_lock(&aspace->lock);
>   	if (vma->iova)

I've seen the splat on the Lenovo Yoga C630 here, and have tested this 
patch, and as described, the splat still happens, but the system is 
still able to be used.

Tested-by: Steev Klimaszewski <steev@kali.org>

