Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF3F5312E7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbiEWOOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236931AbiEWONz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:13:55 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890B64BB93
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:13:53 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id y24so1120713wmq.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mXZRehr7T9hWIefevRI5GrRN2Nm99r9FuQutOqdll7s=;
        b=VgKux45ApDYTG+hKlJeo/k4lhbNzXK3jF1yD9TeQYYdIvrXX2Q5E5Ex5zhQBlZdNos
         sqJE+1dVfMX1fsT0Bnzm7VEO/GTzEpLWqqmJhY0xlYfFj4kcY4hSEffp7e2n6Q4Qs8ic
         etQaGBOwetoAngs6gN9PZLg/V9OYwP2Q8q/CMuLQGpe1nW6dbT5vS6NRdK4HSAkUYYEy
         zykbkA28SKl9c+9OhMnDHuzsSsI17+gdM05wMSFCRoerCyarhyFGM8YuGsRUV5YLjXVl
         YZJ7mcX2+hnX/Dv8HEKAYWI7PvYYKC5pla2jpKbTdhHHmLloAs4Yk/hFWlK8mwNB5ov6
         9jOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mXZRehr7T9hWIefevRI5GrRN2Nm99r9FuQutOqdll7s=;
        b=TkTpgpgNLNWBJ+5rNcEnmbJL+mkp1KOhJjXMwTtACF8rKXVT5BQv6Nh4hGRyBTals4
         ZiZ+DnFBkgBKCVpTAdL0twm2MZrEQHlR9GeWH0Ewq4Enh6GF+REJT43ESYlJ0lJvSZiu
         2dWycHtMkT2PEubQL7scJl0cXzj/ANPxdZGR4aAcY7/FqDKGpcFDPyttvWAKZAkhAIuP
         QIlq3d7zWDf7Pd/hVTn/JtLZD/mQgLMolT0jbR6mbVgTcfINYXmzN1YWuslIXMRTQ80T
         BDliSplw4T3+dfZz0COZBA16KiVtZplSuLaYvWq27U8GaJVQbFmoe0pxALXXShOZLyKK
         GBlw==
X-Gm-Message-State: AOAM533XdcEx02orMyR7WrZwFy29ZcK/OmPTyPars1Y0aUJKQmR7dlnx
        dmtmw9+tGkJ3b0aF83Dc98+gNTnfmTbpqw==
X-Google-Smtp-Source: ABdhPJx9YvmtRcBqZ06BkToXm5RyuKl0Z2/PU9GP0ZiNiKl+wrWmBvjElj6fK5W1ayz3UEGRrXy+ZQ==
X-Received: by 2002:a05:600c:3c99:b0:392:b49c:7b79 with SMTP id bg25-20020a05600c3c9900b00392b49c7b79mr20060163wmb.199.1653315232128;
        Mon, 23 May 2022 07:13:52 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id r3-20020a7bc083000000b003974d0d981dsm2323296wmh.35.2022.05.23.07.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 07:13:51 -0700 (PDT)
Date:   Mon, 23 May 2022 15:13:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <patches@opensource.cirrus.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: mfd: wlf,arizona: Add spi-max-frequency
Message-ID: <YouWnXCcbLFW5p+B@google.com>
References: <20220504084304.46173-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220504084304.46173-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 May 2022, Krzysztof Kozlowski wrote:

> The Wolfson Microelectronics Arizona audio can be connected via SPI bus
> (e.g. WM5110 on Exynos5433 TM2 board), so allow SPI peripheral
> properties.
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Allow all SPI properties, not only max-frequency.
> ---
>  Documentation/devicetree/bindings/mfd/wlf,arizona.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
