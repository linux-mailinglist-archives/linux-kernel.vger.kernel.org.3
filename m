Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAFF54F003
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 06:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379879AbiFQENP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 00:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiFQENL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 00:13:11 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2C622BFF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 21:13:10 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b8so4597945edj.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 21:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jkcre2VBtMzxrZPMCfkOrbliJifXwznY6q+h4wI7Wog=;
        b=ks4gT/sjz/WSG+M5zgBy04ySeXYNutXYYTK+m3oKvm+UTsWFHoZV8YN+/uk7OnvEtx
         cWE8AppXxMsByuappwZWKZ1/yzO5k4172qqWeNux1iwTxPBLFVcXB432LsD88WrCOZWa
         UJoWq936BeiriVTzTt2Kfj2qdZRECUzGyDuqbDMte/Pwm+2hs+zb78HDqLztmlX9LwGB
         paddvZRoiD/fQBG5dyW3TFK6cmufzLK71Wpdjc1/ZnXoOWIDh9RmzuCS/wuOppl7IZ+Y
         qTlQ8rBbEQmJyhdz/Y7tgs7+GddN58IZifVaMKUzvH234WJThH5eOleuQHWWy/oZQ/Rs
         sAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jkcre2VBtMzxrZPMCfkOrbliJifXwznY6q+h4wI7Wog=;
        b=uk1PCXc28Ih6CG4PEVg3lUtR44OenMJnypPMM2e8p3SpEVQC9ANgyEWvXfKGMcEKDu
         UI/kv9qWKYe8mwSqCgKlox98/QylSsVjp0DMAd1TZKWvX3s70k0bp7VOt+jsGU/A3aUr
         7P6YnHd/EhyELXYAzui1y2aiz9EeeGMRHJsxSwvy46b90D3ZZd+MVQDUNgwBeBu6NaR7
         n59PdsOtkp4xsX7Pg4v7EC1KL0eVbVHx9IuuMzXSowe2KG4FCl7VjnJU9KIut7id484I
         TUECnDMUqiN/3Vz5NJskhDy4HXcEBepDt9XqHpHQ4yZ/5+8GixZ67AswQLa/NYoXjeus
         lOmQ==
X-Gm-Message-State: AJIora+BPpFLG6Ar83XSIPNfByphh8CBt+0O+FCDAlX5ulqyzG9qqlvJ
        5Y1hKKK7cMbVW2cNen4DJk4=
X-Google-Smtp-Source: AGRyM1vDq6JtWJzZZ4jWmMy/sOS/uWzEGjgdqQ8zfDxc/FoUMgzm2o+2uai90JO5XUJAJJlsQ9RbCw==
X-Received: by 2002:a05:6402:149:b0:431:7dde:9b59 with SMTP id s9-20020a056402014900b004317dde9b59mr10021996edu.339.1655439188935;
        Thu, 16 Jun 2022 21:13:08 -0700 (PDT)
Received: from jernej-laptop.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id i24-20020a05640200d800b0042dcac2afc6sm2874051edu.72.2022.06.16.21.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 21:13:08 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org,
        Samuel Holland <samuel@sholland.org>
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: Add DMA mask and segment size
Date:   Fri, 17 Jun 2022 06:13:06 +0200
Message-ID: <10094862.nUPlyArG6x@jernej-laptop>
In-Reply-To: <e4a73a0f-c725-fad2-021b-5b5ee5ead1b3@sholland.org>
References: <20220616213240.392041-1-jernej.skrabec@gmail.com> <e4a73a0f-c725-fad2-021b-5b5ee5ead1b3@sholland.org>
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

Dne petek, 17. junij 2022 ob 05:03:11 CEST je Samuel Holland napisal(a):
> Hi Jernej,
> 
> On 6/16/22 4:32 PM, Jernej Skrabec wrote:
> > Kernel occasionally complains that there is mismatch in segment size
> > when trying to render HW decoded videos and rendering them directly with
> > sun4i DRM driver.
> > 
> > Fix that by setting DMA mask and segment size.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > ---
> > 
> >  drivers/gpu/drm/sun4i/sun4i_drv.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c
> > b/drivers/gpu/drm/sun4i/sun4i_drv.c index 275f7e4a03ae..83f4e87f77f6
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> > @@ -7,6 +7,7 @@
> > 
> >   */
> >  
> >  #include <linux/component.h>
> > 
> > +#include <linux/dma-mapping.h>
> > 
> >  #include <linux/kfifo.h>
> >  #include <linux/module.h>
> >  #include <linux/of_graph.h>
> > 
> > @@ -367,6 +368,9 @@ static int sun4i_drv_probe(struct platform_device
> > *pdev)> 
> >  	INIT_KFIFO(list.fifo);
> > 
> > +	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> 
> Isn't this already the default, from of_dma_configure_id or
> setup_pdev_dma_masks?

Not sure, I need to check.

> > +	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
> 
> This looks like a good change. In fact, I think we need a similar change in
> some other drivers.

Should be DMA_BIT_MASK(25) as in your other patch?

Best regards,
Jernej

> 
> Regards,
> Samuel




