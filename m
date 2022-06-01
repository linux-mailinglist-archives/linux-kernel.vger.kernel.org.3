Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FBA53AF58
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbiFAVj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiFAVj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:39:26 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037F9522D5;
        Wed,  1 Jun 2022 14:39:26 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id f9so6434529ejc.0;
        Wed, 01 Jun 2022 14:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KdQRrKNDo19m2xpYGSP742X+VIY6LKYcB4+u45tKW1U=;
        b=AEnMo2AndmNDxu10Z4tyH3GAQLF70+buQB/9jGPKB+m1UUvYQfR8zQJmFOCBATkSsw
         jfT9YtlkKaD13r+1Kr0WHR4rrEOSpfC15JVViccurKGaZGQ5E79p1FrSj5aZ8SIZzd/+
         kC+wd1rDb0K0+ET34tIoH3+ca6tba9R5E+NZ62fSRs32R8LgDA7kDMcL+J7Q9bjpHw2b
         UTjNkZnhKqRvdgQ/ZF9u8Vn8m3MT9Q2vPZaTfqdp7rwNIn52kWN/5O/onkYOLpm1a8rk
         nYvsdYNB1F6nGV+J73SBnHhHigh+UEGjLHbBqWrQ/ZaQWW3RMfyg01by0P+J8L7lRbQF
         /Vug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KdQRrKNDo19m2xpYGSP742X+VIY6LKYcB4+u45tKW1U=;
        b=oNuzDJCEkUFbyBJHM1fNRwCk/1J+BiEW95+rdDRfP5WZnJXA2NNDyUM/N75eu+c/cp
         hzP1Z7pCgZVpfoxpNZS0K0D20SJ1PBIfu+3/IXzpns++RJtRpxmJcA4qxfN1MIOh0JCn
         Yyydfi/IJdR7H00ElMLsRzjpqd/0HaWVEeVj9ndDLYgRXKGJKcb4GKOZIgur1yp9Gtom
         h5/Rb7J4CqI2SgxHRvKrtRQ03x3EJaCiXfNnKcpJ3msNF25S66EBwU0Uiu+ldFQ1HIAp
         SUPA83vw0l0rRwbrsI68nzowVahTkClDwZvYy1kIML2la2x6Q9dJHDJDaHn+s9I98N69
         RjMg==
X-Gm-Message-State: AOAM533j28BwgVml14XyiMEehiyCV3h3v47JPRndJ3VVG2lEZecJ9MQt
        Q/yz3XgaoD2FR0V5Q+sp1oqzfZtYGhztkjvq
X-Google-Smtp-Source: ABdhPJyFr+vMn4IaLj8ptljaopu5wmDjNOyvpwokjWn6WwAgEzGdw8AqR37AImPDd+WxcBhnK0OxYA==
X-Received: by 2002:a17:907:6e29:b0:6ff:4f5d:8dc7 with SMTP id sd41-20020a1709076e2900b006ff4f5d8dc7mr1393952ejc.415.1654119564481;
        Wed, 01 Jun 2022 14:39:24 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:5d6e:322:57b6:5f03])
        by smtp.googlemail.com with ESMTPSA id a14-20020a170906368e00b006fec5cef701sm1099080ejc.197.2022.06.01.14.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 14:39:23 -0700 (PDT)
From:   David Virag <virag.david003@gmail.com>
Cc:     phone-devel@vger.kernel.org,
        David Virag <virag.david003@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Bring up internal eMMC on Samsung Galaxy A8 (2018)
Date:   Thu,  2 Jun 2022 01:37:38 +0200
Message-Id: <20220601233743.56317-1-virag.david003@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set adds support to the internal eMMC storage found on the Samsung
Galaxy A8 (2018) (jackpotlte). It seems to work reliably for reads and
writes. postmarketOS is able to boot off of it.

The original kernel from samsung sets pinctrl options at runtime
changing pin-drv levels automatically. Without this code, mmc seems to
work the best with the lv3 setting on jackpotlte.

David Virag (5):
  dt-bindings: clock: Add bindings for Exynos7885 CMU_FSYS
  dt-bindings: clock: Add indices for Exynos7885 TREX clocks
  clk: samsung: exynos7885: Implement CMU_FSYS domain
  clk: samsung: exynos7885: Add TREX clocks
  arm64: dts: exynos: Add internal eMMC support to jackpotlte

 .../clock/samsung,exynos7885-clock.yaml       |  27 +++
 .../boot/dts/exynos/exynos7885-jackpotlte.dts |  20 ++
 arch/arm64/boot/dts/exynos/exynos7885.dtsi    |  32 +++
 drivers/clk/samsung/clk-exynos7885.c          | 207 +++++++++++++++++-
 include/dt-bindings/clock/exynos7885.h        |  54 ++++-
 5 files changed, 324 insertions(+), 16 deletions(-)

-- 
2.36.1

