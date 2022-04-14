Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F9B501D5F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 23:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346888AbiDNVZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 17:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346884AbiDNVZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 17:25:45 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579AEE0AE1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:23:18 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id f5so37992ljp.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VQIdnqaToAeSGi4V4hfwlWUa2yYv1KhMo/84wlTI9mM=;
        b=SqXH32j9vQgeD7fKz53XGDlqOxBaWGIGIl3mdRsppSndrFjmM2rnEZOUh84Q+fUr4b
         wqFKhykSwViGZaybyZp6SaJLlDBH36DNAkUEqEd3gP5atU7Q0HRIAgnw5F+wE8HlxIZQ
         6saNqVtAoh1lTsOKuQm9XTbu7/PMYx2OvPKRpIWsCtA2TA7nM8kmepRkNjKMHozZ6NEx
         dBtmEkAYQzj2+0fpS1kRxT1y99XKdICjn0Bc93d4wyDq7mGeMaTAR34rCgmGdVl4+vDA
         WhV5XAWj5Q4BpYvKBKGm1WH559V4WLdmT7R6romA9ejGpkW8kmioX0lkuF34y4wEGv4I
         NGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VQIdnqaToAeSGi4V4hfwlWUa2yYv1KhMo/84wlTI9mM=;
        b=qqt9oVYTqUiFUhEVZ81h+kKRn/BErWx1hpq4I4ENHWq661QcKGf1lI/BYQQelBs9md
         ykdB5WhFK+1z+0EGGuUavddSCt4KWN21k32/flWBQYbsKJYcuHMP2yOJzOglQE7HYJYG
         LaPr5db81uzIKFsxxHiiwz2AoptnsaOwhgxsgq1Vbl4Qpz/X61ffGsam71EW+uvSAQq8
         vCOUG2jU7I1xjBbiti/ulEC76eYrPbQnSABOQHdBkkWXFKZb9oXxKwOqgF+IgAoF+mjN
         qZVNIZ1CMs5aoA9r2FnfL21mGbfd7yYN/+kZuSGBuxY93f427TiFhKDTIEv7qCtaZbK8
         6GcQ==
X-Gm-Message-State: AOAM533S1Gb34yK2yuazHjFVOQIFdxz50fh7yepKULqdrWUcgY+8aAfT
        JsKjjha1paEHRGszaWtF/tayRA==
X-Google-Smtp-Source: ABdhPJz8jxuXsHCJ+G/fkprknn54Q1j8E7uXYzDfmJDesdXBgFmBraJZoVV9pXyXAc7Goo4XpLFvOA==
X-Received: by 2002:a2e:90d6:0:b0:246:e44:bcf6 with SMTP id o22-20020a2e90d6000000b002460e44bcf6mr2590313ljg.501.1649971396661;
        Thu, 14 Apr 2022 14:23:16 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id d30-20020a19385e000000b0046d16dbebebsm115076lfj.39.2022.04.14.14.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 14:23:16 -0700 (PDT)
Message-ID: <a3c87373-1b7e-7b30-3b03-7a87f517b7b3@linaro.org>
Date:   Fri, 15 Apr 2022 00:23:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 04/10] drm/msm/gem: Split out inuse helper
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
 <20220411215849.297838-5-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220411215849.297838-5-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2022 00:58, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Prep for a following patch, where it gets a bit more complicated.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/msm_gem.c     | 2 +-
>   drivers/gpu/drm/msm/msm_gem.h     | 1 +
>   drivers/gpu/drm/msm/msm_gem_vma.c | 9 +++++++--
>   3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index a4f61972667b..f96d1dc72021 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -938,7 +938,7 @@ void msm_gem_describe(struct drm_gem_object *obj, struct seq_file *m,
>   				name, comm ? ":" : "", comm ? comm : "",
>   				vma->aspace, vma->iova,
>   				vma->mapped ? "mapped" : "unmapped",
> -				vma->inuse);
> +				msm_gem_vma_inuse(vma));
>   			kfree(comm);
>   		}
>   
> diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
> index 947ff7d9b471..1b7f0f0b88bf 100644
> --- a/drivers/gpu/drm/msm/msm_gem.h
> +++ b/drivers/gpu/drm/msm/msm_gem.h
> @@ -61,6 +61,7 @@ struct msm_gem_vma {
>   int msm_gem_init_vma(struct msm_gem_address_space *aspace,
>   		struct msm_gem_vma *vma, int npages,
>   		u64 range_start, u64 range_end);
> +bool msm_gem_vma_inuse(struct msm_gem_vma *vma);
>   void msm_gem_purge_vma(struct msm_gem_address_space *aspace,
>   		struct msm_gem_vma *vma);
>   void msm_gem_unmap_vma(struct msm_gem_address_space *aspace,
> diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
> index 64906594fc65..dc2ae097805e 100644
> --- a/drivers/gpu/drm/msm/msm_gem_vma.c
> +++ b/drivers/gpu/drm/msm/msm_gem_vma.c
> @@ -37,6 +37,11 @@ msm_gem_address_space_get(struct msm_gem_address_space *aspace)
>   	return aspace;
>   }
>   
> +bool msm_gem_vma_inuse(struct msm_gem_vma *vma)
> +{
> +	return !!vma->inuse;
> +}
> +
>   /* Actually unmap memory for the vma */
>   void msm_gem_purge_vma(struct msm_gem_address_space *aspace,
>   		struct msm_gem_vma *vma)
> @@ -44,7 +49,7 @@ void msm_gem_purge_vma(struct msm_gem_address_space *aspace,
>   	unsigned size = vma->node.size << PAGE_SHIFT;
>   
>   	/* Print a message if we try to purge a vma in use */
> -	if (GEM_WARN_ON(vma->inuse > 0))
> +	if (GEM_WARN_ON(msm_gem_vma_inuse(vma)))
>   		return;
>   
>   	/* Don't do anything if the memory isn't mapped */
> @@ -100,7 +105,7 @@ msm_gem_map_vma(struct msm_gem_address_space *aspace,
>   void msm_gem_close_vma(struct msm_gem_address_space *aspace,
>   		struct msm_gem_vma *vma)
>   {
> -	if (GEM_WARN_ON(vma->inuse > 0 || vma->mapped))
> +	if (GEM_WARN_ON(msm_gem_vma_inuse(vma) || vma->mapped))
>   		return;
>   
>   	spin_lock(&aspace->lock);


-- 
With best wishes
Dmitry
