Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBEE4FC107
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348081AbiDKPkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240237AbiDKPkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:40:07 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0054A3A5E7;
        Mon, 11 Apr 2022 08:37:52 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m33-20020a05600c3b2100b0038ec0218103so1115195wms.3;
        Mon, 11 Apr 2022 08:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZEd2NUfggsD7hgjY8ZW9Vk2tNqqVUG6JADb5kDnjH9Y=;
        b=ZOQvmS/wEUkvWeynt1+EWEaVA+W9eMPHyQEiaRq21gFbWomCufcS8tUyh7ZQPu5LwP
         eUJ1WFpwyr9Yaqft68B8Nm/C+PGGHXUuTmGoF51iyzkF3siGBMH+JbPuJgnjBYZUQ0rk
         Rcab+BNrqtIDRdL1aduuV/rJWLG6C3gqZxMSNqkBpLnMkCujJoCI1LqQFlAqfyYnWPkC
         bvWQ6Pmc5eLqexEdzFrdr3CkHrDmtXhkSU7mjU3BvZHz1uqWYGghCI2eTSdTnMfEAzTC
         H/xVAOBg32rRcMvl5vxvcfb3LXbU80yq1DS9PzCV7iURoVOOuLaKzCbcU5eq/IECPn71
         8chg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZEd2NUfggsD7hgjY8ZW9Vk2tNqqVUG6JADb5kDnjH9Y=;
        b=p5l2WD+jx4lZaYvzk8UpO0pr+l+sc5aAd7xPVoJugMp3igrdV7DYITj7e6ib/sU+nQ
         IgCbnVOIAbgJQDq/KG+2F3vOpduc7ZUPAGaVWHldnytonm4yz9wqrQjlAxZXNuPcGDf+
         +OzR4H8UcD8oRAIisy1ZnC1hCcf1ewHUylora2jDMirxZE67NDOSL3cnzs6pcFyzwnB2
         HVx1rxX37FJNRhhdTSWXcIXhFuVqfI5Rrv1tQC1EcCHVn2lKji9MRzt+uVuQqQ0vQ7Wx
         2nV1HmZD148qDcDh2HmlFugiDBZJmpXTFW0Ax/0PLVV/9J7eznL1yUOkUe1XSZUGfkBm
         9s5g==
X-Gm-Message-State: AOAM530Djq7IXXf7ygY9vscaaI7gvw+4tMfgtfbi7HxMyW43qVJZgvSk
        WIfdvvKC7UgrDx9LWO0gtzU=
X-Google-Smtp-Source: ABdhPJy/BzuwObXpGrBkuPP/B+nIiUKgXHozXUMEVJpsQ9JEfJdCGxcjcG2VRWPpqzSHJ8PxH0l9YA==
X-Received: by 2002:a7b:c7c3:0:b0:389:cbf1:fadf with SMTP id z3-20020a7bc7c3000000b00389cbf1fadfmr30248265wmk.147.1649691471387;
        Mon, 11 Apr 2022 08:37:51 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id u23-20020a7bcb17000000b0037bdfa1665asm22528252wmj.18.2022.04.11.08.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:37:51 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 03/10] drm/sun4i: Remove obsolete references to PHYS_OFFSET
Date:   Mon, 11 Apr 2022 17:37:49 +0200
Message-ID: <3167527.44csPzL39Z@kista>
In-Reply-To: <20220411043423.37333-4-samuel@sholland.org>
References: <20220411043423.37333-1-samuel@sholland.org> <20220411043423.37333-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 11. april 2022 ob 06:34:15 CEST je Samuel Holland napisal(a):
> commit b4bdc4fbf8d0 ("soc: sunxi: Deal with the MBUS DMA offsets in a
> central place") added a platform device notifier that sets the DMA
> offset for all of the display engine frontend and backend devices.
> 
> The code applying the offset to DMA buffer physical addresses was then
> removed from the backend driver in commit 756668ba682e ("drm/sun4i:
> backend: Remove the MBUS quirks"), but the code subtracting PHYS_OFFSET
> was left in the frontend driver.
> 
> As a result, the offset was applied twice in the frontend driver. This
> likely went unnoticed because it only affects specific configurations
> (scaling or certain pixel formats) where the frontend is used, on boards
> with both one of these older SoCs and more than 1 GB of DRAM.
> 
> In addition, the references to PHYS_OFFSET prevent compiling the driver
> on architectures where PHYS_OFFSET is not defined.
> 
> Fixes: b4bdc4fbf8d0 ("soc: sunxi: Deal with the MBUS DMA offsets in a central 
place")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Good catch! Actually, people complained about non-working display on 
Cubietruck IIRC, which has 2 GB of RAM.

Did you test this on HW?

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
> 
>  drivers/gpu/drm/sun4i/sun4i_frontend.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/
sun4i_frontend.c
> index 56ae38389db0..462fae73eae9 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
> @@ -222,13 +222,11 @@ void sun4i_frontend_update_buffer(struct sun4i_frontend 
*frontend,
>  
>  	/* Set the physical address of the buffer in memory */
>  	paddr = drm_fb_cma_get_gem_addr(fb, state, 0);
> -	paddr -= PHYS_OFFSET;
>  	DRM_DEBUG_DRIVER("Setting buffer #0 address to %pad\n", &paddr);
>  	regmap_write(frontend->regs, SUN4I_FRONTEND_BUF_ADDR0_REG, paddr);
>  
>  	if (fb->format->num_planes > 1) {
>  		paddr = drm_fb_cma_get_gem_addr(fb, state, swap ? 2 : 
1);
> -		paddr -= PHYS_OFFSET;
>  		DRM_DEBUG_DRIVER("Setting buffer #1 address to %pad\n", 
&paddr);
>  		regmap_write(frontend->regs, 
SUN4I_FRONTEND_BUF_ADDR1_REG,
>  			     paddr);
> @@ -236,7 +234,6 @@ void sun4i_frontend_update_buffer(struct sun4i_frontend 
*frontend,
>  
>  	if (fb->format->num_planes > 2) {
>  		paddr = drm_fb_cma_get_gem_addr(fb, state, swap ? 1 : 
2);
> -		paddr -= PHYS_OFFSET;
>  		DRM_DEBUG_DRIVER("Setting buffer #2 address to %pad\n", 
&paddr);
>  		regmap_write(frontend->regs, 
SUN4I_FRONTEND_BUF_ADDR2_REG,
>  			     paddr);
> -- 
> 2.35.1
> 
> 


