Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEDE509879
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385521AbiDUHDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385525AbiDUHCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:02:35 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B962F165AE
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:59:40 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z12so5275870edl.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8+/qXaP3Rn2VMBa9pP1mhLJpNqkiglYV3CYIlra+cK0=;
        b=Se0rkq5+hT7wBGvuFUxhmgvSMymSuRPSiXodX/zQoYYw2lPnXSYsMkCJ5WgJ2kQT2Q
         mBvjYEK3Ow+cxkuxIGujjzSVnld87ZU49iWeSr7Yf1FVLCi3OJJT/WAXZeJfYJz+6zCp
         vKRRcMFNAN3lDmSsDWip53WZu5kKIcZdWn872gXe0bD771YNLNmQOZeUAM+wQawPIO+s
         p48XItLdkpued2GTIHovKJLCZErf43Et0rrTPkhvFTkDKuNbYMKSYjJPHEmYi8m9RsKX
         MI/vKP49sR6SeLAydobv4kqeI+sXkoqSJe1f0+DByPuKoA4YWorma5d0fcy4R8uIKYpG
         bF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8+/qXaP3Rn2VMBa9pP1mhLJpNqkiglYV3CYIlra+cK0=;
        b=YzoVVVYMsynmMjnn3tjsfLoGdTWsowq1ODveDVerTOtFlAE/jzqMgMyCRUfKtjCdSg
         ZsGyiR2pp54do/zvB50/jukEWtsz90gnAFtkxCEXcN1IrAEySRntWUKxZ+OK33F7c1+b
         yqWj960qjljbtWjETYKHduQ9NW173wcKHhHd6dbQuTVGZzPk8K1KFpScOyoG6wIg135y
         DHUJpyVsYL2sVrWK9PnBvUrJsRSGE+GHls07LVukgknNelwg4qolzbAjVzmVYcTOiH/X
         7QqFuPhkY707GsC4nij/YE/3R5fgsEUZACbRkayiRHU3omfUTmFD6XSVab+nlveWeaas
         psaw==
X-Gm-Message-State: AOAM5331BCWwA2caSNcSFBI/XL8NMKbuzP/LetjUjEtGxjfCaTRd2H7V
        tuwuWjtAioBsL38ItOIWmQzI7n0dRZDDxA==
X-Google-Smtp-Source: ABdhPJz8w0fwC1ZBlr4j/TglLpPwjT/0e9rFCTTIXH0RDOXEbm6TC8FbPjjWHOSMIFB8xokk6lL7nw==
X-Received: by 2002:a05:6402:27c6:b0:423:e599:e49e with SMTP id c6-20020a05640227c600b00423e599e49emr20683339ede.180.1650524379120;
        Wed, 20 Apr 2022 23:59:39 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ah13-20020a1709069acd00b006e8a0b3e071sm7544949ejc.110.2022.04.20.23.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 23:59:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org
Subject: Re: [PATCH v2] pinctrl: samsung: fix missing GPIOLIB on ARM64 Exynos config
Date:   Thu, 21 Apr 2022 08:59:35 +0200
Message-Id: <165052437270.10147.2588603616348039313.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220420141407.470955-1-krzysztof.kozlowski@linaro.org>
References: <20220420141407.470955-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 16:14:07 +0200, Krzysztof Kozlowski wrote:
> The Samsung pinctrl drivers depend on OF_GPIO, which is part of GPIOLIB.
> ARMv7 Exynos platform selects GPIOLIB and Samsung pinctrl drivers. ARMv8
> Exynos selects only the latter leading to possible wrong configuration
> on ARMv8 build:
> 
>   WARNING: unmet direct dependencies detected for PINCTRL_EXYNOS
>     Depends on [n]: PINCTRL [=y] && OF_GPIO [=n] && (ARCH_EXYNOS [=y] || ARCH_S5PV210 || COMPILE_TEST [=y])
>     Selected by [y]:
>     - ARCH_EXYNOS [=y]
> 
> [...]

Applied, thanks!

[1/1] pinctrl: samsung: fix missing GPIOLIB on ARM64 Exynos config
      commit: ac875df4d854ab13d9c4af682a1837a1214fecec

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
