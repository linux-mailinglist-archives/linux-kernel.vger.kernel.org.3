Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D81050B4F5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380820AbiDVK2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbiDVK2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:28:41 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32F954BC1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:25:48 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u15so15424626ejf.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SN4drg2JTpqJsP0CH9F58BTXLr90dl8MWfA2yC+Ydps=;
        b=kgLJJCQCxmhs8OK0PP2StISQ2j+AUvWuCOxalEUF2BWpNNsp3Onq1OEZ09UaNwJ4TF
         x5/cnscx9KdiDW2rndrrcuZ1AlqT/gJRpfeY00llTvFF3f9AG24QDshxR2wM8qa5Es6Y
         yf5xnKucmyQws2060UmG3ElrTy+yDc0nAKVpFMrG46waAVyzZv3NyiSIlJfPB5WohVY8
         arT8+jC/MnUK976rXrqJtu/zES5LNkf22zViak0c6E1qWqo1gVA1hE++9rUYbIz4PpfT
         YxFa1Qkd15dP9axMKlDoFpQ40SEUvjcQg29wigNea8OI6x7JfW+EGTcFV/Clu37ytb8s
         Zcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SN4drg2JTpqJsP0CH9F58BTXLr90dl8MWfA2yC+Ydps=;
        b=wdyQHECMo/1huqR07Htms4X+jVH3r2JTG/G6zoLRCf1qqcxy3x/emS+JVmB6eR7PO2
         aN+DxcxiTUjPYuALGS2nVRGQZsr5HNA7nuvzL7NfiKxyS7vCDWgBC9bus4THkLddraHy
         Wk4JeT5VPziMekjUTytOV81XTsIReP7TWe0Tl5QmowfRSoa+XK8/w3kBO5WLBBnanBxr
         NNLucgxxbPbWoH6vHCuQsk5K6CRRSCGWuAoL9QCD7qvMgTFT8wEW9CRI0Bo/F6wllHfC
         zC+kBJUIbdpiA5o5uM0uRyPk7w8g34EsOLy2MYdFhUFHvGIFXAt8lNSK6QY6WKhYexBk
         1ryw==
X-Gm-Message-State: AOAM532NzENiZoESDiujfZGJqaoFF/554L/SYIQBi3ut4xbxkiHw1KPs
        ZrIwQQkF1ym7hGOrAJAgN5WNjA==
X-Google-Smtp-Source: ABdhPJwl+qZNM8ipTsT25L3081dhFGNSIua496QmlPCsVtwo3iseCpZh1OCXY5DAVnclK7C784PSXw==
X-Received: by 2002:a17:906:9746:b0:6e0:5c9a:1a20 with SMTP id o6-20020a170906974600b006e05c9a1a20mr3582778ejy.714.1650623147318;
        Fri, 22 Apr 2022 03:25:47 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id z8-20020a170906714800b006eff5936d60sm609754ejj.158.2022.04.22.03.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 03:25:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL fixes] pinctrl: samsung: Fixes for v5.18 (current cycle)
Date:   Fri, 22 Apr 2022 12:25:41 +0200
Message-Id: <20220422102541.33372-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Two fixes for the current cycle.

Best regards,
Krzysztof


The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git tags/samsung-pinctrl-fixes-5.18

for you to fetch changes up to ac875df4d854ab13d9c4af682a1837a1214fecec:

  pinctrl: samsung: fix missing GPIOLIB on ARM64 Exynos config (2022-04-21 08:58:54 +0200)

----------------------------------------------------------------
Samsung pinctrl drivers fixes for v5.18

1. Fix sparse warning introduced in v5.18-rc1.
2. Fix possible unmet Kconfig dependency with COMPILE_TEST, present
   since v4.3 or earlier.

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      pinctrl: samsung: staticize fsd_pin_ctrl
      pinctrl: samsung: fix missing GPIOLIB on ARM64 Exynos config

 arch/arm/mach-exynos/Kconfig                   |  1 -
 drivers/pinctrl/samsung/Kconfig                | 11 ++++-------
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c |  2 +-
 3 files changed, 5 insertions(+), 9 deletions(-)
