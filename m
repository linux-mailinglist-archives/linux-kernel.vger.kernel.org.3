Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC634B51B9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbiBNNg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:36:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiBNNg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:36:58 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6DB25E89
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:36:50 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so5634436wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lKeI0xAX+MJ5UPtqGLEtftF5bHWftWRiLnV6Tt/MzTM=;
        b=seaFR5mE6UeUlDwgEVe5uNxczBGDBzhMm1NdnL6dXGgHSzthduClQ04Mq4lW6gVo+z
         qvGcaodQubzN0Nlyb5q593nlEeB+brCWOzYsldS8ioZCOFosCxZgAvbUAAfhhazS2Jl0
         7tKiib6z7m48RxTFoEVYCYObrJO893RJdN4jsNiHlt84S759gQObLhcC93/4H8qwX5K/
         6zLMwwgM0LHxlL9MUxk79ZAmO00dgE4f6Iw2xhcJfDBr1nJk2X4W8X/NeVZ/U6yXUqiU
         1/G7UlGHAt50dTLm78CxTYgwuNwU0acO4DV5L1HyVGllheCnbf/a8iAxLaY6+g9vXj9O
         VF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lKeI0xAX+MJ5UPtqGLEtftF5bHWftWRiLnV6Tt/MzTM=;
        b=dHdCca+ZoM+3isnBEJz2HvgXfDzG/V1f5FOPJ7RO/iWYu6Xta/SyOU2nCvFiztDwm5
         hpN6tHVO2EXPob13OVM72vBaQtjDxbeeM7N6SVG3Vy5p/16YRnFE0K4aJXqcj2OMCm9r
         DkIR4f58Ub3XU7pdgb1yQfgSTagE/aAObWhZE6xnKLLHeAOdmlUrCygTmQfqqz7T68yw
         nCgWfqE1vdvBXbor2s6c2f6l0po7TIypMSDjclTSzf49UWtxr9iRkcl03p1NMUFzGpsV
         Q8sPjnksQ5pcUthVUf4yc3X+3d++B7XMDR5b+HN8Ox/4v4I1AKraOSiIHUQGlyCKgZwA
         Ge7Q==
X-Gm-Message-State: AOAM532DZYpdAn9vPvtY5EJ9elRdHqT2qnyCda7YDFpirgKw9s8zoP3/
        zXGPvK/HCUjaYR5kvV+/MKgGeQ==
X-Google-Smtp-Source: ABdhPJzPgfN6THQVQkirjhcrFcZYu8B9ytLmMvuFr7AtRhobgF+ZrZdh6SXK+ud2uXZgUQt/zNpRYw==
X-Received: by 2002:a05:600c:1506:: with SMTP id b6mr11390115wmg.30.1644845808701;
        Mon, 14 Feb 2022 05:36:48 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id z3sm14439479wmp.42.2022.02.14.05.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 05:36:48 -0800 (PST)
Date:   Mon, 14 Feb 2022 13:36:46 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mfd: exynos-lpass: Drop unneeded syscon.h include
Message-ID: <Ygpa7kiDp9tHmKry@google.com>
References: <20220202151310.285561-1-krzysztof.kozlowski@canonical.com>
 <20220202151310.285561-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220202151310.285561-3-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Feb 2022, Krzysztof Kozlowski wrote:

> syscon regmap is not used since commit addebf1588ab ("mfd: exynos-lpass:
> Remove pad retention control").
> 
> Fixes: addebf1588ab ("mfd: exynos-lpass: Remove pad retention control")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  drivers/mfd/exynos-lpass.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
