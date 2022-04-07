Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5104F7922
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbiDGIKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242997AbiDGIIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:08:04 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F681AE63B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 01:05:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a6so9264153ejk.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 01:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4mBqmv7n4vaPJNzqJP9XRBObc2z1tM4karynGs0Phtk=;
        b=Qq1qfnd9npA9nHTudyH/BT6S+kcCLVHNf9FrbefprUkxea94X8hHKsnDNg+5ccEGxg
         r87XTfa5dzAOXyeJTgAkuMot3slOlmPogMwQ8ucdoxREihf/skk2LM/xagYN39q3PdRf
         xBbsjsQsh5y4SbVMM59UZ4mUCez68EVSWLHdq50/ZCHxPZb32E21a4WnjkPJG2VwSd/s
         HVI6IEgv2O7gO+NAkdITQg9KnvdviEUjAMCF9rnluidnZIwPSBSTPlbvMllHW9oBbxfD
         fQHxbmFsSaxJ3f64QMIHsEpnJsN+s/IN5/MUdLDcT3Dn3QzfAgwadsnppVAHALW1JUnY
         Vtew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4mBqmv7n4vaPJNzqJP9XRBObc2z1tM4karynGs0Phtk=;
        b=IhhoG7hCLfYFz42payZ325S2nikrYFHebAozkSFXTftPsb1+e5tVfeQKZ1PCOCAJza
         QYj4s0ua7Hje+e5y/vlBCeZn3bYl/JdIJCY6TxZxK6glSACTP7QcAFy7kVkTSo82KuEc
         1qf5gGZAUqgxYP6gE1D3VYQ7aweJrhLTgGu5DyyvqXC3nhWybS9Q/zTNQwaHPmbtrz6s
         ShT61+lEzOtukJa3jbIzOEn41DEkkUqubPptZXXaHDILVA6zPzJQN9W5KI5EPYp/X26J
         B/LE+dNlGEhq6nn+u8BzQBDHuRwaAPek8Cr28WZ1fDWZD0QJtBjvnOzwUoFjZMiS/+Jp
         mqow==
X-Gm-Message-State: AOAM532gT8UaL4Hv40rtxzX+0CL7mldqXaGdPGboZ9rtLmR7jrka8sef
        yEMQIt87qyeS21cRQxijb8+nuQ==
X-Google-Smtp-Source: ABdhPJyHdAGSEzniLyxDIIzfiDZCPSJ8ph+g9N9poqt0EGINfDqa0e4lfi/998p+LVKaG22T2l1KCA==
X-Received: by 2002:a17:907:7255:b0:6e7:e853:73b8 with SMTP id ds21-20020a170907725500b006e7e85373b8mr12655082ejc.172.1649318748546;
        Thu, 07 Apr 2022 01:05:48 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id m14-20020a056402510e00b0041d0c0942adsm217575edd.52.2022.04.07.01.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 01:05:48 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] ARM: samsung: Fixes for v5.18 (current cycle)
Date:   Thu,  7 Apr 2022 10:05:45 +0200
Message-Id: <20220407080545.112290-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Hi,

For the v5.18, please.

Best regards,
Krzysztof


The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-fixes-5.18

for you to fetch changes up to 1a9f338f9cf96f8338d5592dee5fce222929e4f7:

  MAINTAINERS: update Krzysztof Kozlowski's email to Linaro (2022-04-04 15:43:20 +0200)

----------------------------------------------------------------
Samsung fixes for v5.18

Update Krzysztof Kozlowski's email address in multiple maintainer
entries.  The old one @canonical.com bounces already.

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      dt-bindings: update Krzysztof Kozlowski's email
      MAINTAINERS: update Krzysztof Kozlowski's email to Linaro

 .../bindings/clock/samsung,exynos-audss-clock.yaml |  2 +-
 .../bindings/clock/samsung,exynos-clock.yaml       |  2 +-
 .../bindings/clock/samsung,exynos-ext-clock.yaml   |  2 +-
 .../clock/samsung,exynos4412-isp-clock.yaml        |  2 +-
 .../bindings/clock/samsung,exynos5260-clock.yaml   |  2 +-
 .../bindings/clock/samsung,exynos5410-clock.yaml   |  2 +-
 .../bindings/clock/samsung,exynos5433-clock.yaml   |  2 +-
 .../bindings/clock/samsung,exynos7-clock.yaml      |  2 +-
 .../bindings/clock/samsung,exynos7885-clock.yaml   |  2 +-
 .../bindings/clock/samsung,exynos850-clock.yaml    |  2 +-
 .../devicetree/bindings/clock/samsung,s2mps11.yaml |  2 +-
 .../clock/samsung,s5pv210-audss-clock.yaml         |  2 +-
 .../bindings/clock/samsung,s5pv210-clock.yaml      |  2 +-
 .../devfreq/event/samsung,exynos-nocp.yaml         |  2 +-
 .../devfreq/event/samsung,exynos-ppmu.yaml         |  2 +-
 .../display/samsung/samsung,exynos-hdmi-ddc.yaml   |  2 +-
 .../display/samsung/samsung,exynos-hdmi.yaml       |  2 +-
 .../display/samsung/samsung,exynos-mixer.yaml      |  2 +-
 .../display/samsung/samsung,exynos5433-decon.yaml  |  2 +-
 .../display/samsung/samsung,exynos5433-mic.yaml    |  2 +-
 .../display/samsung/samsung,exynos7-decon.yaml     |  2 +-
 .../bindings/display/samsung/samsung,fimd.yaml     |  2 +-
 .../devicetree/bindings/extcon/maxim,max77843.yaml |  2 +-
 .../devicetree/bindings/hwmon/lltc,ltc4151.yaml    |  2 +-
 .../bindings/hwmon/microchip,mcp3021.yaml          |  2 +-
 .../devicetree/bindings/hwmon/sensirion,sht15.yaml |  2 +-
 .../devicetree/bindings/hwmon/ti,tmp102.yaml       |  2 +-
 .../devicetree/bindings/hwmon/ti,tmp108.yaml       |  2 +-
 .../devicetree/bindings/i2c/i2c-exynos5.yaml       |  2 +-
 .../bindings/i2c/samsung,s3c2410-i2c.yaml          |  2 +-
 .../samsung,exynos4210-combiner.yaml               |  2 +-
 .../devicetree/bindings/leds/maxim,max77693.yaml   |  2 +-
 .../bindings/memory-controllers/brcm,dpfe-cpu.yaml |  2 +-
 .../ddr/jedec,lpddr2-timings.yaml                  |  2 +-
 .../memory-controllers/ddr/jedec,lpddr2.yaml       |  2 +-
 .../ddr/jedec,lpddr3-timings.yaml                  |  2 +-
 .../memory-controllers/ddr/jedec,lpddr3.yaml       |  2 +-
 .../marvell,mvebu-sdram-controller.yaml            |  2 +-
 .../qca,ath79-ddr-controller.yaml                  |  2 +-
 .../memory-controllers/renesas,h8300-bsc.yaml      |  2 +-
 .../memory-controllers/samsung,exynos5422-dmc.yaml |  2 +-
 .../memory-controllers/synopsys,ddrc-ecc.yaml      |  2 +-
 .../memory-controllers/ti,da8xx-ddrctl.yaml        |  2 +-
 .../devicetree/bindings/mfd/maxim,max14577.yaml    |  2 +-
 .../devicetree/bindings/mfd/maxim,max77686.yaml    |  2 +-
 .../devicetree/bindings/mfd/maxim,max77693.yaml    |  2 +-
 .../devicetree/bindings/mfd/maxim,max77802.yaml    |  2 +-
 .../devicetree/bindings/mfd/maxim,max77843.yaml    |  2 +-
 .../bindings/mfd/samsung,exynos5433-lpass.yaml     |  2 +-
 .../devicetree/bindings/mfd/samsung,s2mpa01.yaml   |  2 +-
 .../devicetree/bindings/mfd/samsung,s2mps11.yaml   |  2 +-
 .../devicetree/bindings/mfd/samsung,s5m8767.yaml   |  2 +-
 .../devicetree/bindings/net/nfc/marvell,nci.yaml   |  2 +-
 .../devicetree/bindings/net/nfc/nxp,nci.yaml       |  2 +-
 .../devicetree/bindings/net/nfc/nxp,pn532.yaml     |  2 +-
 .../devicetree/bindings/net/nfc/nxp,pn544.yaml     |  2 +-
 .../devicetree/bindings/net/nfc/st,st-nci.yaml     |  2 +-
 .../devicetree/bindings/net/nfc/st,st21nfca.yaml   |  2 +-
 .../devicetree/bindings/net/nfc/st,st95hf.yaml     |  2 +-
 .../devicetree/bindings/net/nfc/ti,trf7970a.yaml   |  2 +-
 .../bindings/phy/samsung,dp-video-phy.yaml         |  2 +-
 .../bindings/phy/samsung,exynos-hdmi-phy.yaml      |  2 +-
 .../bindings/phy/samsung,exynos5250-sata-phy.yaml  |  2 +-
 .../bindings/phy/samsung,mipi-video-phy.yaml       |  2 +-
 .../devicetree/bindings/phy/samsung,usb2-phy.yaml  |  2 +-
 .../bindings/phy/samsung,usb3-drd-phy.yaml         |  2 +-
 .../pinctrl/samsung,pinctrl-gpio-bank.yaml         |  2 +-
 .../bindings/pinctrl/samsung,pinctrl-pins-cfg.yaml |  2 +-
 .../pinctrl/samsung,pinctrl-wakeup-interrupt.yaml  |  2 +-
 .../bindings/pinctrl/samsung,pinctrl.yaml          |  2 +-
 .../bindings/power/supply/maxim,max14577.yaml      |  2 +-
 .../bindings/power/supply/maxim,max77693.yaml      |  2 +-
 .../bindings/regulator/maxim,max14577.yaml         |  2 +-
 .../bindings/regulator/maxim,max77686.yaml         |  2 +-
 .../bindings/regulator/maxim,max77693.yaml         |  2 +-
 .../bindings/regulator/maxim,max77802.yaml         |  2 +-
 .../bindings/regulator/maxim,max77843.yaml         |  2 +-
 .../bindings/regulator/maxim,max8952.yaml          |  2 +-
 .../bindings/regulator/maxim,max8973.yaml          |  2 +-
 .../bindings/regulator/maxim,max8997.yaml          |  2 +-
 .../bindings/regulator/samsung,s2mpa01.yaml        |  2 +-
 .../bindings/regulator/samsung,s2mps11.yaml        |  2 +-
 .../bindings/regulator/samsung,s2mps13.yaml        |  2 +-
 .../bindings/regulator/samsung,s2mps14.yaml        |  2 +-
 .../bindings/regulator/samsung,s2mps15.yaml        |  2 +-
 .../bindings/regulator/samsung,s2mpu02.yaml        |  2 +-
 .../bindings/regulator/samsung,s5m8767.yaml        |  2 +-
 .../bindings/rng/samsung,exynos5250-trng.yaml      |  2 +-
 .../devicetree/bindings/rng/timeriomem_rng.yaml    |  2 +-
 .../bindings/soc/samsung/exynos-usi.yaml           |  2 +-
 .../devicetree/bindings/sound/samsung,arndale.yaml |  2 +-
 .../bindings/sound/samsung,smdk5250.yaml           |  2 +-
 .../devicetree/bindings/sound/samsung,snow.yaml    |  2 +-
 .../devicetree/bindings/sound/samsung,tm2.yaml     |  2 +-
 .../bindings/spi/samsung,spi-peripheral-props.yaml |  2 +-
 .../devicetree/bindings/spi/samsung,spi.yaml       |  2 +-
 .../bindings/thermal/samsung,exynos-thermal.yaml   |  2 +-
 .../bindings/usb/samsung,exynos-dwc3.yaml          |  2 +-
 .../bindings/usb/samsung,exynos-usb2.yaml          |  2 +-
 MAINTAINERS                                        | 36 +++++++++++-----------
 100 files changed, 117 insertions(+), 117 deletions(-)
