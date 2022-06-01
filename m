Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00C053A5EB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 15:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353250AbiFAN0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 09:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbiFAN0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:26:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1984FC62
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 06:26:37 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id y24so969088wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 06:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=noaGYaAS2ngUF9rHVIdsqxhgMZ5al5C5XajbVIc9isw=;
        b=U9Q37OOk4NWi1lfVMCL5nxB3ANIs4vKn/tkhmKrp4ANPiZCL7MccGApGO1NslW5urV
         VY3DyS4a3zVHfSl+H82ZxVMr5vz+nBIuGEx2a6jX0pacMGcibgvLq0wxWDSXydyynAFC
         W/hDJDd57aiuvLD+4bvNQXITPUzouz0cAir9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=noaGYaAS2ngUF9rHVIdsqxhgMZ5al5C5XajbVIc9isw=;
        b=byJBvU3QosXyjPltuHqmspw9MqoA1Uqu06O3ikRjE7Bo46CEXCmeCW4y4IhEQA17vC
         TiAiBnBD9Etba+3g7Ng6s6fr0wHoUXVQCPA5jDZSlMJolXt0DuATwL5XQtQG6esaQ7qc
         EmNk+XTJ8v0JPigLX3G8oYi1GT1Y2QmQ+LrbKJd+AMEuy78NuCBVhV9c760bEKo03Bq6
         +3zwkyiaGjMCBt3ec6g3pXv4etAruQ6ILi0tNryTzwn1ssmmePPPL3mEGvB24TqHQ8G0
         PsW+xJEvkmuvGlTztD6IQh5C3+qdZv5/08XqtilOnr4FnTAUwCC9j5A6InoQp7TwLFye
         8IGQ==
X-Gm-Message-State: AOAM530jvxIadMUujAvwS3muan/LFkNOUy7IO2B+l5RrYv5RBhZQbfkG
        ePKz5bKVA2QW/cNDwik6qzhzxw==
X-Google-Smtp-Source: ABdhPJxmblSP3nC88vFqaAjKJ7iAz+rr7pZAeiJzY+x4Fx1vknqCtD2WNZKbvxTL/xgpNn9A/fjafg==
X-Received: by 2002:a05:600c:1f18:b0:39c:2360:d824 with SMTP id bd24-20020a05600c1f1800b0039c2360d824mr2178484wmb.75.1654089996195;
        Wed, 01 Jun 2022 06:26:36 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id m30-20020a05600c3b1e00b00395f15d993fsm5809686wms.5.2022.06.01.06.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 06:26:35 -0700 (PDT)
Date:   Wed, 1 Jun 2022 15:26:33 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/v3d/v3d_drv: Fix PM disable depth imbalance
Message-ID: <YpdpCWW9+igsVydr@phenom.ffwll.local>
Mail-Followup-To: Miaoqian Lin <linmq006@gmail.com>,
        Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220601122050.1822-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601122050.1822-1-linmq006@gmail.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 04:20:50PM +0400, Miaoqian Lin wrote:
> The pm_runtime_enable will increase power disable depth.
> If the probe fails, we should use pm_runtime_disable() to balance
> pm_runtime_enable().
> Also call disable function in remove function.
> 
> Fixes: 57692c94dcbe ("drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> Changes in v3:
> - call pm_runtime_disable() in v3d_platform_drm_remove
> - update commit message
> 
> Changes in v2
> - put pm_runtime_disable before dma_free_wc
> - rename dma_free to pm_disable
> 
> v1: https://lore.kernel.org/r/20220105120442.14418-1-linmq006@gmail.com
> v2: https://lore.kernel.org/r/20220106124657.32737-1-linmq006@gmail.com

Maybe a bit late since we're at v3 already, but are there no devm_
functions here that would dtrt automatically? Or is there another reason
we can't use them?
-Daniel
> ---
>  drivers/gpu/drm/v3d/v3d_drv.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
> index 1afcd54fbbd5..f3380399fe17 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.c
> +++ b/drivers/gpu/drm/v3d/v3d_drv.c
> @@ -286,7 +286,7 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
>  
>  	ret = v3d_gem_init(drm);
>  	if (ret)
> -		goto dma_free;
> +		goto pm_disable;
>  
>  	ret = v3d_irq_init(v3d);
>  	if (ret)
> @@ -302,7 +302,8 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
>  	v3d_irq_disable(v3d);
>  gem_destroy:
>  	v3d_gem_destroy(drm);
> -dma_free:
> +pm_disable:
> +	pm_runtime_disable(dev);
>  	dma_free_wc(dev, 4096, v3d->mmu_scratch, v3d->mmu_scratch_paddr);
>  	return ret;
>  }
> @@ -316,6 +317,7 @@ static int v3d_platform_drm_remove(struct platform_device *pdev)
>  
>  	v3d_gem_destroy(drm);
>  
> +	pm_runtime_disable(&pdev->dev);
>  	dma_free_wc(v3d->drm.dev, 4096, v3d->mmu_scratch,
>  		    v3d->mmu_scratch_paddr);
>  
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
