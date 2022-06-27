Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736F455D0E6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbiF0OHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236707AbiF0OH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:07:27 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B53F12AE4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:07:25 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s1so13222203wra.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gsgc6DIOzArZPsUhaJm6TQBUqT+cOuEtKePYXM55dn8=;
        b=RwHx2DUc+zQdZoM/fppv9uMqeCAsq+OTGc/uLrz+5I2GWcjSb+HNw7JV4svTtEhUy7
         vIFfvyGeQMDZyn3ImibEdKS/PIZ63/tO5OCzlNTZhFo1Vfo96vu2exkNVAVWPKeof0N8
         0Xu3lAWYFac0xwHZL5TSyegckajoASkwSSjl2HAGRLtOx4jZ3SS/gGt1JuEYfTGfE5r7
         CfAeuR2t91wZvVhojT3UVBbHVMkvmi5uytl/EmCfOYw1azGp9xArgKPoVQwAZNtbZAqs
         TYIFnFm/FWbbSQPZTSwobvd1SzOXoFJxmGpy6ujesCML//e9Al0NiJzMqwlc60Uz/OOc
         G1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gsgc6DIOzArZPsUhaJm6TQBUqT+cOuEtKePYXM55dn8=;
        b=4Ab+MLR2hV5iXqd7h4kdwVAWPg83N4LVygJtAj3AWGyOPZ5p6k+omkNeU1FRatVs+j
         fTeFap43mYzG5jPLZvBcQp7uf8IDKZGMzRGoJKKkfr4O5tYOxIxftiiOVHDRbOpDnXcS
         QreEVX8LEzprYYPbT1RtgXswC2ecvpoY7jYd0o+PJlAr6X7zKhrwiCigAH+olg1e7ZWV
         jnM9svFG0WRGl6DP8nfB96wcpnO0nwkhf0bLGDOH7r63wniowmXaQWWtxCbt+lqTCjIg
         FnzjK5I7HRxzL5RoyOFJh1cA3JoLMPqQhrDTAtgJE374625mzCJ1g9etQDQsdEsh5PvM
         YYUA==
X-Gm-Message-State: AJIora+gnhcLc18JnhQUh0olqc+BoWvz6j99pZxyWxJFRqyEO8jXeA0Z
        saEeH/rKTzyVTw2H0UVznGSesg==
X-Google-Smtp-Source: AGRyM1tqOffr5P69k2JXSjDJ26X0SHzGuAeWDAQMALNpO6JuPQMieD2zfhpuXvwpbHW0niVy/fmg2g==
X-Received: by 2002:a05:6000:80f:b0:21b:927a:16b1 with SMTP id bt15-20020a056000080f00b0021b927a16b1mr12143982wrb.440.1656338843969;
        Mon, 27 Jun 2022 07:07:23 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id f17-20020a7bcd11000000b0039c811077d3sm13142680wmj.22.2022.06.27.07.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 07:07:23 -0700 (PDT)
Date:   Mon, 27 Jun 2022 15:07:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        deller@gmx.de, cy_huang@richtek.com, lucas_tsai@richtek.com,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: backlight: rt4831: Add the new ocp
 level property
Message-ID: <Yrm5mRvVm2yl7zKc@google.com>
References: <1655807788-24511-1-git-send-email-u0084500@gmail.com>
 <1655807788-24511-2-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1655807788-24511-2-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2022, cy_huang wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add 'richtek,bled-ocp-microamp' property to make it chooseable.
> 
> The wrong backlight ocp level may affect the backlight channel output
> current smaller than configured.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Since v3:
> - Refine the description for backlight ocp property.
> - Use the enum to list the supported value.
> 
> Since v2:
> - Change the property name from 'richtek,bled-ocp-sel' to 'richtek,bled-ocp-microamp'.
> 
> ---
>  .../devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml | 5 +++++
>  1 file changed, 5 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
