Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A4D4B51C4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354252AbiBNNhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:37:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354238AbiBNNhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:37:36 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFB14E39C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:37:27 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id i14so26847495wrc.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DVb0TjCZn7Jwz2Kvb88Txv79YRQ7aVyO7Xh13MCDcfU=;
        b=o/luYf0gyID+7LZyTrPreb7cMHrVoJghgl647Qt37SSGJyT4ry6EEACx/kQW4wLs6z
         +sKA6Rx0H4CfQlgVjAc2cSUY2rEXOrRE7zbuMu5X8QvmrvSwQVGHqJqpkP74HDMF/K1Q
         sWVtvpmyfq6keIpFaAFzKv52BP8PAdNZyxSX/DvY8EWa9wP1q9L53+icRsFTNd5jAj2M
         Nu5FoAEP7fcyuSyAxROnKDigjG7d1ddtiBHTz/Gkv29A39pbGIN21f4PlN1uixb/2R42
         w3R3AlR9EiS2RGR1hb3KZsJaNQOcfGJP/Y1HJozfyX6pTcxCs1GfVLx8jQUu460Xr8/f
         Hv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DVb0TjCZn7Jwz2Kvb88Txv79YRQ7aVyO7Xh13MCDcfU=;
        b=gBHz4U4l81wgSZlFEEZT8tuhzd/h+xunpzFxyGjrCVYgKkm4T2MIse4SwUoEQd3Xzs
         82RS5t15JoPBCleqPwokLrpuezId2dawtCFoCiGIZEtiHg2pzLhxnbnbTPr8oJrx6XIP
         h0q/wVZdDaCr1WgVaJoNYPsDM6utDu+81mxo11PR4ThWe6f8m1qaqCATPIM+MrlkuIsk
         IXhyT28mkBFHhOmrHNlFYrsrPgWwEce3qTk4vvSlse0u/OzbD5ICzxsthVakxux9vfDk
         pmwh8zoUl9Pq/RnBlQherT217ykZ4y00Km6kOa39PllFOkeffgSzzG2H1oITZNVGzHTq
         e4zw==
X-Gm-Message-State: AOAM530GMIKBt5YFQJFLj/bfdBS05Kh2G0unAdFdT4VfxZ6DsQXZM6H+
        YqBXChLWs+WeE688oYaY4SiAhw==
X-Google-Smtp-Source: ABdhPJyApp5kdwLN/OTISwHFu7CwGa8aipnhNkJvlBAgJXesku784CqUVnug80kdEUvSt8t4tke8wA==
X-Received: by 2002:a5d:46c5:: with SMTP id g5mr10974611wrs.406.1644845845568;
        Mon, 14 Feb 2022 05:37:25 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id b10sm30996044wrd.8.2022.02.14.05.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 05:37:25 -0800 (PST)
Date:   Mon, 14 Feb 2022 13:37:23 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/3] dt-bindings: mfd: samsung,exynos5433-lpass:
 Convert to dtschema
Message-ID: <YgpbE+xn/AL8R11J@google.com>
References: <20220202151310.285561-1-krzysztof.kozlowski@canonical.com>
 <20220202151310.285561-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220202151310.285561-4-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Feb 2022, Krzysztof Kozlowski wrote:

> Convert the Exynos5433 LPASS bindings to DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/mfd/samsung,exynos5433-lpass.txt |  72 -----------
>  .../mfd/samsung,exynos5433-lpass.yaml         | 117 ++++++++++++++++++
>  2 files changed, 117 insertions(+), 72 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
