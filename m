Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151445081FE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359732AbiDTHZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359694AbiDTHYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:24:48 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9AF3B03B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 00:22:00 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id k23so1665345ejd.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 00:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5bhHmkNynxArCaTA/7bZ7/hQVWgPWdbqpkbJXO91I6o=;
        b=V3BsCCRe/dmD5vyspIiiwnvVRGjTw9phFS+Deblji7ZMzkzb5GRm14IBNskkzUYr6i
         koMqOflEWfWXuj7c4vmEwAZtWkhCR8hk6SuDMVs+7TNfHQAt/r5fKrBeCFcVtJPzJzl8
         jm1t2FYtqyIkzxUGEtEVq/yXcOQqqlsW1s+jOL47F3pFti0iLq5r9S28TL6vjk0Iyj8t
         xuZq3DQD2y/BQJDVo/66/I+rDTTuGNoIBNy7pSYpg2pHBq/57iG1ZjZnPecQ1LpyC6oL
         xz+h3p4HDqngQKdFN/UhCEBglc/b4Yp5guIIMAAE+pjqVeTwvUb3hhFCoy4Na0lA6eJY
         F1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5bhHmkNynxArCaTA/7bZ7/hQVWgPWdbqpkbJXO91I6o=;
        b=b4R1hYbZh2RbyjuPEIskA25JZLVawEyJYmD9w1N+FWh8TiDQMtndfKj4T3aq0wRbmC
         oxyEWatihWbjIx0igg+Ws7L62cJBziY9OgAu5M1tbwORwA1dUDSao+IrvAROkDRmT0Co
         dYsIfqR6wXYDuvitoYqE9on7jKJLX2CdcE/2vZQQIXmmHSz1/sp08+uUdquBAkYmPXYn
         5b9gca2ToiuB+csbwOaCEWRlr0phQhWRztzWBkcocNkUAd/vgB8mi7+Q8iznUDJngQpv
         a2l48o7DqJhl1U01t7nwhnyF/gY3oP5Yq7LeDy0FGxRUHznL+Cfzy6Eo9Pr/yUIcEQFj
         EPwQ==
X-Gm-Message-State: AOAM532lFqIRz/Or4UKrHeo0quBR+D2gMVboNRyJ/9EVu2t5Eyo9iWfu
        J/o9t8Zm6BLXTYPLZvVXLiFMxg==
X-Google-Smtp-Source: ABdhPJyDYc5gwpPbK9kabmfq2DveJYHoUheuzGxUxOm+QOQqAKm0THRZRPtHRpizJ2fraH1+pUxO8Q==
X-Received: by 2002:a17:906:c110:b0:6e8:3a96:996a with SMTP id do16-20020a170906c11000b006e83a96996amr17040723ejc.216.1650439318749;
        Wed, 20 Apr 2022 00:21:58 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709063e8100b006ce06ed8aa7sm6492106ejj.142.2022.04.20.00.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 00:21:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 3/3] arm64: dts: samsung: dts for v5.19
Date:   Wed, 20 Apr 2022 09:21:52 +0200
Message-Id: <20220420072152.11696-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220420072152.11696-1-krzysztof.kozlowski@linaro.org>
References: <20220420072152.11696-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-5.19

for you to fetch changes up to 22cbcb8f4a17c194d208f686fc3ea37fc860bd71:

  arm64: dts: tesla: add a specific compatible to MCT on FSD (2022-04-04 18:53:08 +0200)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v5.19

1. Cleanup: move aliases of board-related features to board in
   Exynos850.
2. Add specific compatibles to Multi Core Timer to allow stricter DT
   schema matching.

----------------------------------------------------------------
Krzysztof Kozlowski (3):
      arm64: dts: exynos: move aliases to board in Exynos850
      arm64: dts: exynos: add a specific compatible to MCT
      arm64: dts: tesla: add a specific compatible to MCT on FSD

 arch/arm64/boot/dts/exynos/exynos5433.dtsi       |  3 ++-
 arch/arm64/boot/dts/exynos/exynos850-e850-96.dts |  5 +++++
 arch/arm64/boot/dts/exynos/exynos850.dtsi        | 19 ++-----------------
 arch/arm64/boot/dts/tesla/fsd.dtsi               |  2 +-
 4 files changed, 10 insertions(+), 19 deletions(-)
