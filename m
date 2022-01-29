Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282A54A2E67
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 12:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239564AbiA2Lx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 06:53:59 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:53508
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239048AbiA2Lx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 06:53:58 -0500
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8BF1A3F32C
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 11:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643457236;
        bh=f9YarTgrIqis8mFMQrsRDvw79rXZocKvl5NeRJU919w=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=ITmwqXjM97hgnFWTRxg0dTEwCBB9idRVvnGIJURLjR2m/kOQO5RQ8ePP4+27Ev5dk
         rTTxG/2eEJhLfJJj8f4BQF3Djz1gL8BF2f4otIA3yaCmiBB8YX1NtWnV7bDy4NR3AI
         IjZtKMzwOBXZDBo3ftwup4ljlHQfihm4vaWX9PMRVpYKWbDKKVzOMBsVt8bt+opJpM
         vWFQHxJrF4KWKXSJ0NMQdWyyWepkG6DopXA/yob75cV/GUhM88bMPkI3oi5wv6YGAK
         98qzfDs8zEoQCaPp037D6yE4XGNY6s0KpP88L0OOVIqczFoUqTdShHNMvSCmRg1jPt
         U12Iboh055/tg==
Received: by mail-ej1-f72.google.com with SMTP id fx12-20020a170906b74c00b006bbeab42f06so107793ejb.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 03:53:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f9YarTgrIqis8mFMQrsRDvw79rXZocKvl5NeRJU919w=;
        b=GvL801h23nrU0YXBITb48ETSQAV1kNCAmJkSSgoblEJ7ZeElZCTC1An1VkYd9djMyt
         Te+d0sJyAlP5TIUHZwoDQQLM0FdUnK37v9ziapdvzVgBFejU5QUTMiPPxKW+lAhVazfC
         eq4WRQ2MaxawDh2mBor1D4Fgzbe7W5BL3PKR7bN+YHCvEqaO72GM8pRg7IfD5uARHBHQ
         Lk8X4GxnrhwCpzpvWm+QDJV6i0DaGTq7cadJhdMfJIihq1WhESP7GwmQN6AMC7XD/P/1
         WFPKn7GSRq9kFGtOHu3RfS6zYb3eFm9H6hVG2VN/SlwtEA8taUEiIEEJbA0+FL6Qjsfi
         0hYA==
X-Gm-Message-State: AOAM531SWQnBaXIDN3E5EIBslG+AxbasVQpVg+ywbrpNhBrZIAAaSCi+
        ojFvPjwOLjt8ctgN2ukekfRdVRSocpkFppYe7ItY8vy4NHGcUdlSayc2/HzSAXzYXawSRe1d4ns
        uHqXV06rPjNMg4t758dijo/oJFHfIPD8fxhU7ZBFvnA==
X-Received: by 2002:a05:6402:1c94:: with SMTP id cy20mr12634652edb.150.1643457235368;
        Sat, 29 Jan 2022 03:53:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxSkcHy2NlSdt2LYxLa/mdgfFxmbPLxCQiTUeVxH3opeeELyEbC7aTr1zrjwluLEcAImc0w/A==
X-Received: by 2002:a05:6402:1c94:: with SMTP id cy20mr12634634edb.150.1643457235049;
        Sat, 29 Jan 2022 03:53:55 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id qb30sm10985655ejc.27.2022.01.29.03.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 03:53:54 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [GIT PULL] ARM: dts/drivers: samsung pinctrl for v5.18
Date:   Sat, 29 Jan 2022 12:53:52 +0100
Message-Id: <20220129115352.13274-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd and Olof,

There is quite a lot of changes in Samsung these days, so I am sending this one
very early. It's also a controversial one because it combines pinctrl
driver+dts into one. I mentioned it before in [1].

The pinctrl driver changes have to go before DTS. The DTS has to go with
dtschema, so the dtschema checks won't complain with warnings.

The pinctrl driver changes are coming from my Samsung pinctrl repository and I
will send them later also to Linus Walleij.

Linus,
I will send the pinctrl driver bits in separate pull to you.

[1] https://lore.kernel.org/all/CAOesGMg2eH1B94h+etPBDW3B1LMeHBytz0v2e0GfVRDv8gU0YA@mail.gmail.com/

Best regards,
Krzysztof


The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-pinctrl-5.18

for you to fetch changes up to 41bd4354a1513afa4a9dd9940d8cd790fbd00e68:

  arm64: dts: exynos: use dedicated wake-up pinctrl compatible in ExynosAutov9 (2022-01-23 17:54:59 +0100)

----------------------------------------------------------------
Samsung pinctrl DTS and driver changes for v5.18

Conversion of Samsung pinctrl bindings to dtschema followed up with
alignment of DTS files to the dtschema.

The entire work consists of three parts but everything should be merged
at once to avoid dtschema check errors:
1. Samsung pinctrl driver change necessary to accept new DTS (driver
   depends on node names and this has to be adjusted because of dtschema).
2. Conversion to dtschema which brings requirement of different naming
   of the GPIO nodes.
3. DTS commits depending on driver (1) above, which convert all GPIO pin
   bank names to new naming, required by dtschema.
   This also includes few cleanups around DTS which are here to avoid
   any merge conflicts.

The Samsung pinctrl driver changes are backwards compatible.  However
the DTS changes (renaming nodes) could cause problems in out-of-tree or
other project implementations of the driver.

----------------------------------------------------------------
Krzysztof Kozlowski (28):
      pinctrl: samsung: drop pin banks references on error paths
      pinctrl: samsung: accept GPIO bank nodes with a suffix
      dt-bindings: pinctrl: samsung: convert to dtschema
      dt-bindings: pinctrl: samsung: describe Exynos850 and ExynosAutov9 wake-ups
      pinctrl: samsung: add support for Exynos850 and ExynosAutov9 wake-ups
      Merge tag 'samsung-pinctrl-5.18' of https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung into for-v5.18/dt-pinctrl
      ARM: dts: exynos: fix UART3 pins configuration in Exynos5250
      ARM: dts: exynos: drop unused pinctrl defines in Exynos3250
      ARM: dts: exynos: simplify PMIC DVS pin configuration in Odroid XU
      ARM: dts: exynos: override pins by label in Peach Pit
      ARM: dts: exynos: simplify PMIC DVS pin configuration in Peach Pit
      ARM: dts: exynos: override pins by label in Peach Pi
      ARM: dts: exynos: simplify PMIC DVS pin configuration in Peach Pi
      ARM: dts: s3c64xx: drop unneeded pinctrl wake-up interrupt mapping
      ARM: dts: exynos: align pinctrl with dtschema in Exynos3250
      ARM: dts: exynos: align pinctrl with dtschema in Exynos4210
      ARM: dts: exynos: align pinctrl with dtschema in Exynos4412
      ARM: dts: exynos: align pinctrl with dtschema in Exynos5250
      ARM: dts: exynos: align pinctrl with dtschema in Exynos5260
      ARM: dts: exynos: align pinctrl with dtschema in Exynos5410
      ARM: dts: exynos: align pinctrl with dtschema in Exynos542x/5800
      arm64: dts: exynos: align pinctrl with dtschema in Exynos5433
      arm64: dts: exynos: align pinctrl with dtschema in Exynos7
      arm64: dts: exynos: align pinctrl with dtschema in ExynosAutov9
      ARM: dts: s3c24xx: align pinctrl with dtschema
      ARM: dts: s3c64xx: align pinctrl with dtschema
      ARM: dts: s5pv210: align pinctrl with dtschema
      arm64: dts: exynos: use dedicated wake-up pinctrl compatible in ExynosAutov9

Sam Protsenko (1):
      pinctrl: samsung: Remove EINT handler for Exynos850 ALIVE and CMGP gpios

 .../pinctrl/samsung,pinctrl-gpio-bank.yaml         |  52 +++
 .../bindings/pinctrl/samsung,pinctrl-pins-cfg.yaml |  81 +++++
 .../pinctrl/samsung,pinctrl-wakeup-interrupt.yaml  | 106 ++++++
 .../bindings/pinctrl/samsung,pinctrl.yaml          | 392 +++++++++++++++++++++
 .../bindings/pinctrl/samsung-pinctrl.txt           | 383 --------------------
 MAINTAINERS                                        |   2 +-
 arch/arm/boot/dts/exynos3250-artik5.dtsi           |  10 +-
 arch/arm/boot/dts/exynos3250-pinctrl.dtsi          | 165 ++++-----
 arch/arm/boot/dts/exynos4210-i9100.dts             |  30 +-
 arch/arm/boot/dts/exynos4210-origen.dts            |   2 +-
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi          | 226 ++++++------
 arch/arm/boot/dts/exynos4210-smdkv310.dts          |   4 +-
 arch/arm/boot/dts/exynos4210-trats.dts             |   6 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |  12 +-
 arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi        |   4 +-
 arch/arm/boot/dts/exynos4412-itop-elite.dts        |   2 +-
 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi    |   2 +-
 arch/arm/boot/dts/exynos4412-midas.dtsi            |  30 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   8 +-
 arch/arm/boot/dts/exynos4412-odroidx.dts           |   2 +-
 arch/arm/boot/dts/exynos4412-origen.dts            |   4 +-
 arch/arm/boot/dts/exynos4412-p4note.dtsi           |  44 +--
 arch/arm/boot/dts/exynos4412-pinctrl.dtsi          | 252 ++++++-------
 arch/arm/boot/dts/exynos4412-smdk4412.dts          |   4 +-
 arch/arm/boot/dts/exynos5250-arndale.dts           |   2 +-
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi          | 222 ++++++------
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   2 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi      |  22 +-
 arch/arm/boot/dts/exynos5250-snow-rev5.dts         |   2 +-
 arch/arm/boot/dts/exynos5250-snow.dts              |   2 +-
 arch/arm/boot/dts/exynos5250-spring.dts            |  20 +-
 arch/arm/boot/dts/exynos5260-pinctrl.dtsi          | 148 ++++----
 arch/arm/boot/dts/exynos5260-xyref5260.dts         |   2 +-
 arch/arm/boot/dts/exynos5410-odroidxu.dts          |  22 +-
 arch/arm/boot/dts/exynos5410-pinctrl.dtsi          | 170 ++++-----
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |   4 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |   2 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |  89 +++--
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          | 194 +++++-----
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |   6 +-
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |   2 +-
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |   6 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |  89 +++--
 arch/arm/boot/dts/s3c2416-pinctrl.dtsi             |  60 ++--
 arch/arm/boot/dts/s3c6410-mini6410.dts             |   4 +-
 arch/arm/boot/dts/s3c64xx-pinctrl.dtsi             | 210 +++++------
 arch/arm/boot/dts/s3c64xx.dtsi                     |  16 +-
 arch/arm/boot/dts/s5pv210-aquila.dts               |   2 +-
 arch/arm/boot/dts/s5pv210-aries.dtsi               |  40 +--
 arch/arm/boot/dts/s5pv210-fascinate4g.dts          |  12 +-
 arch/arm/boot/dts/s5pv210-galaxys.dts              |  16 +-
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi             | 226 ++++++------
 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi | 211 +++++------
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 259 +++++++-------
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts    |   6 +-
 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi    | 176 ++++-----
 .../boot/dts/exynos/exynosautov9-pinctrl.dtsi      |  50 +--
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi       |   2 +-
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c     |   2 -
 drivers/pinctrl/samsung/pinctrl-exynos.c           |   4 +
 drivers/pinctrl/samsung/pinctrl-samsung.c          |  87 ++++-
 61 files changed, 2234 insertions(+), 1978 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-gpio-bank.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-pins-cfg.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
