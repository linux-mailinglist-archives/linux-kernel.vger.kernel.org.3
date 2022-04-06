Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DC84F6E9A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 01:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237834AbiDFXjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 19:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237820AbiDFXi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 19:38:57 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5571FCD2E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 16:36:57 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id j8so3338851pll.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 16:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=21ZJRRzPBF6FcLzLA+5OerzfnCr3C60pEPJqVVBmqTY=;
        b=fKwn0tUMW047EyEj2Owp8YI5iW6CAw7fzm93kE70JaSkisqGFGRYw0WSQ995y/Ahdq
         b5/KCNurRH6P5x7lXbwcqz0zzAE+yKIziwzwdqasM8LjpbSn+FORgzLng6ddJwykKYrm
         Cd/1iatq5/fR7IkJzWYaoNcwzcgT3D5fxa1Aykz9Z4tVz0Cio1oD0tzlY1vOeULqgofo
         AwyAlp0RPJIhg+tw0v7IFvDyp/1GnWipihXFIoDrCISvL+bWWPs3XPdoOvOfNHJYmf6S
         dOw4iFaedBTqWWlN2+STe3zBU8+pRxzgGbeC5VsbDjmU7417KuUWs/Q71WxPyhQ3XfGp
         7FDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=21ZJRRzPBF6FcLzLA+5OerzfnCr3C60pEPJqVVBmqTY=;
        b=vNJRCcZe4ouSZ2dwwyIL7gsOa8TAOZK3oCMz+s38xMrcyb3vyqcb8rsKgRBBl2fbUu
         bbTd7Oz6APAawVpl+C+tLRkTEnoi/Q1L7rbPRAHVXiEPH+9xhvM96MrawfdSVt9wARct
         ORVFBCQvHwSVeH4+M3yzUupI+lFzjfftrrQZdV84FUs/7EXTT7rbm5jMssdK7Qx6DNMH
         VK4aEfdOlix45juXEG7tVPWbQ56wf6Rtd9734lhWrs1Hzy5IjcvVfJ0zzycQSwU5xYJB
         sf30wZvE4KZav2woa+aNUhUBQoSJiljByoTQ4EHsZMfYoj263UsKo4DWvp4gGggwtIxA
         H/rA==
X-Gm-Message-State: AOAM531aYqa53N0C1MhKBDTANygJhZCCSv5FqIqMRMAakext7cKNwgV9
        wNVDiDbb72g8gTd59OR+zr3XQA==
X-Google-Smtp-Source: ABdhPJw6de6LxMX24kxKqOkwU7ahEUMqpmaXcVTLkvOJdN5e2XGTxzipHvLO3QMVfxr0Ma+CwQjFTQ==
X-Received: by 2002:a17:90a:b115:b0:1ca:9d56:24f9 with SMTP id z21-20020a17090ab11500b001ca9d5624f9mr12636918pjq.130.1649288217192;
        Wed, 06 Apr 2022 16:36:57 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090a7f9500b001c97c6bcaf4sm6903667pjl.39.2022.04.06.16.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 16:36:56 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, dac2@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] Support Pensando Elba SoC
Date:   Wed,  6 Apr 2022 16:36:37 -0700
Message-Id: <20220406233648.21644-1-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables support for Pensando Elba SoC based platforms.
The Elba SoC has the following features:

- Sixteen ARM64 A72 cores
- Dual DDR 4/5 memory controllers
- 32 lanes of PCIe Gen3/4 to the Host
- Network interfaces: Dual 200GE, Quad 100GE, 50GE, 25GE, 10GE and
  also a single 1GE management port.
- Storage/crypto offloads and 144 programmable P4 cores.
- QSPI and EMMC for SoC storage
- Two SPI interfaces for peripheral management
- I2C bus for platform management

This is a respin based on review inputs.  The version of 
dtschema used is 2022.3.2.  Changes from V3:

0001-dt-bindings-arm-add-Pensando-boards.patch
- Add description and board compatible

0003-dt-bindings-mmc-Add-Pensando-Elba-SoC-binding.patch
- Change from elba-emmc to elba-sd4hc to match file convention
- Use minItems: 1 and maxItems: 2 to pass schema check

0005-dt-bindings-spi-dw-Add-Pensando-Elba-SoC-SPI-Control.patch
- Add required property pensando,syscon-spics to go with
  pensando,elba-spi

0006-MAINTAINERS-Add-entry-for-PENSANDO.patch
- Change Maintained to Supported

0007-arm64-Add-config-for-Pensando-SoC-platforms.patch
- Fix a typo on interface max speed

0008-spi-cadence-quadspi-Add-compatible-for-Pensando-Elba.patch
- Update due to spi-cadence-quadspi.c changes

0009-mmc-sdhci-cadence-Add-Pensando-Elba-SoC-support.patch
- Change from elba-emmc to elba-sd4hc to match file convention

0010-spi-dw-Add-support-for-Pensando-Elba-SoC.patch
- Use more descriptive dt property pensando,syscon-spics
- Minor changes from review input

0011-arm64-dts-Add-Pensando-Elba-SoC-support.patch
- Changed to dual copyright (GPL-2.0+ OR MIT)
- Minor changes from review input

Brad Larson (11):
  dt-bindings: arm: add Pensando boards
  dt-bindings: Add vendor prefix for Pensando Systems
  dt-bindings: mmc: Add Pensando Elba SoC binding
  dt-bindings: spi: Add compatible for Pensando Elba SoC
  dt-bindings: spi: dw: Add Pensando Elba SoC SPI Controller bindings
  MAINTAINERS: Add entry for PENSANDO
  arm64: Add config for Pensando SoC platforms
  spi: cadence-quadspi: Add compatible for Pensando Elba SoC
  mmc: sdhci-cadence: Add Pensando Elba SoC support
  spi: dw: Add support for Pensando Elba SoC
  arm64: dts: Add Pensando Elba SoC support

 .../bindings/arm/pensando,elba.yaml           |  26 +++
 .../devicetree/bindings/mmc/cdns,sdhci.yaml   |   4 +-
 .../bindings/spi/cdns,qspi-nor.yaml           |   3 +-
 .../bindings/spi/snps,dw-apb-ssi.yaml         |  17 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 arch/arm64/Kconfig.platforms                  |  12 ++
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/pensando/Makefile         |   3 +
 arch/arm64/boot/dts/pensando/elba-16core.dtsi | 189 ++++++++++++++++++
 .../boot/dts/pensando/elba-asic-common.dtsi   |  98 +++++++++
 arch/arm64/boot/dts/pensando/elba-asic.dts    |  28 +++
 .../boot/dts/pensando/elba-flash-parts.dtsi   | 106 ++++++++++
 arch/arm64/boot/dts/pensando/elba.dtsi        | 189 ++++++++++++++++++
 drivers/mmc/host/Kconfig                      |   1 +
 drivers/mmc/host/sdhci-cadence.c              | 148 ++++++++++++--
 drivers/spi/spi-cadence-quadspi.c             |  19 ++
 drivers/spi/spi-dw-mmio.c                     |  85 ++++++++
 18 files changed, 922 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/pensando,elba.yaml
 create mode 100644 arch/arm64/boot/dts/pensando/Makefile
 create mode 100644 arch/arm64/boot/dts/pensando/elba-16core.dtsi
 create mode 100644 arch/arm64/boot/dts/pensando/elba-asic-common.dtsi
 create mode 100644 arch/arm64/boot/dts/pensando/elba-asic.dts
 create mode 100644 arch/arm64/boot/dts/pensando/elba-flash-parts.dtsi
 create mode 100644 arch/arm64/boot/dts/pensando/elba.dtsi

-- 
2.17.1

