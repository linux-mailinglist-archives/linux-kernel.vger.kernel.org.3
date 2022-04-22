Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDFF50B997
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448404AbiDVOMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448392AbiDVOMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:12:21 -0400
Received: from relay-us1.mymailcheap.com (relay-us1.mymailcheap.com [51.81.35.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEF35A58B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:09:25 -0700 (PDT)
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
        by relay-us1.mymailcheap.com (Postfix) with ESMTPS id 5C2C02112F;
        Fri, 22 Apr 2022 14:09:24 +0000 (UTC)
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.66.161])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 6873F267CE;
        Fri, 22 Apr 2022 14:09:21 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay3.mymailcheap.com (Postfix) with ESMTPS id 21E793F15F;
        Fri, 22 Apr 2022 16:09:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 0D7382A515;
        Fri, 22 Apr 2022 14:09:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Yr8TcHWihmKf; Fri, 22 Apr 2022 14:09:17 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Fri, 22 Apr 2022 14:09:17 +0000 (UTC)
Received: from petra.. (unknown [113.67.11.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id B494640645;
        Fri, 22 Apr 2022 14:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1650636557; bh=Y29WsT3fkq/qFvF6IalSVLgRdoaWb5L858TyF5FxPxo=;
        h=From:To:Cc:Subject:Date:From;
        b=Mz0eweHGXXE1Lf5SR7SWXolgpjAD0pBar7hynnu9fIafVNqAq5Iy3fsOYYBqY6+Sz
         mvgYQSeqmtL1HOTHfbl52bBmanshmTLxRKAtEn1DDHln20GwSc894UHt0GyZtNaYwd
         OW8wHKTAdq00uqWJ6gvLu2YwnN06Dgg78ca/tZgQ=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 00/12] Initial support for Allwinner R329
Date:   Fri, 22 Apr 2022 22:08:50 +0800
Message-Id: <20220422140902.1058101-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner R329 is a SoC targeting smart audio devices, with integrated
128M or 256M DRAM.

This patchset adds initial support for it, including pinctrl, rtc
(for rtc ccu), clocks and mmc. These makes a system booting.

The demo board for this support is Sipeed MaixSense (based on Sipeed
MIIA SoM).

Icenowy Zheng (12):
  dt-bindings: pinctrl: document Allwinner R329 PIO and R-PIO
  pinctrl: sunxi: add support for R329 CPUX pin controller
  pinctrl: sunxi: add support for R329 R-PIO pin controller
  rtc: sun6i: add support for R329 RTC
  dt-bindings: clock: sunxi-ng: add bindings for R329 CCUs
  clk: sunxi=ng: add support for R329 CCUs
  dt-bindings: mmc: sunxi-mmc: add R329 MMC compatible string
  mmc: sunxi: add support for R329 MMC controllers
  dt-bindings: arm: sunxi: add compatible strings for Sipeed MaixSense
  arm64: allwinner: dts: add DTSI file for R329 SoC
  arm64: allwinner: dts: r329: add DTSI file for Sipeed Maix IIA
  arm64: allwinner: dts: r329: add support for Sipeed MaixSense

 .../devicetree/bindings/arm/sunxi.yaml        |   6 +
 .../clock/allwinner,sun4i-a10-ccu.yaml        |  62 +-
 .../bindings/mmc/allwinner,sun4i-a10-mmc.yaml |   1 +
 .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml  |   4 +
 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../dts/allwinner/sun50i-r329-maix-iia.dtsi   |  34 +
 .../dts/allwinner/sun50i-r329-maixsense.dts   |  37 ++
 .../arm64/boot/dts/allwinner/sun50i-r329.dtsi | 275 ++++++++
 drivers/clk/sunxi-ng/Kconfig                  |  10 +
 drivers/clk/sunxi-ng/Makefile                 |   4 +
 drivers/clk/sunxi-ng/ccu-sun50i-r329-r.c      | 401 ++++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-r329-r.h      |  25 +
 drivers/clk/sunxi-ng/ccu-sun50i-r329.c        | 587 ++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-r329.h        |  32 +
 drivers/mmc/host/sunxi-mmc.c                  |  10 +
 drivers/pinctrl/sunxi/Kconfig                 |  10 +
 drivers/pinctrl/sunxi/Makefile                |   2 +
 drivers/pinctrl/sunxi/pinctrl-sun50i-r329-r.c | 292 +++++++++
 drivers/pinctrl/sunxi/pinctrl-sun50i-r329.c   | 410 ++++++++++++
 drivers/rtc/rtc-sun6i.c                       |   2 +
 include/dt-bindings/clock/sun50i-r329-ccu.h   |  73 +++
 include/dt-bindings/clock/sun50i-r329-r-ccu.h |  45 ++
 include/dt-bindings/reset/sun50i-r329-ccu.h   |  45 ++
 include/dt-bindings/reset/sun50i-r329-r-ccu.h |  24 +
 24 files changed, 2384 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-r329-maix-iia.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-r329-maixsense.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-r329.dtsi
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-r329-r.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-r329-r.h
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-r329.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-r329.h
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-r329-r.c
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-r329.c
 create mode 100644 include/dt-bindings/clock/sun50i-r329-ccu.h
 create mode 100644 include/dt-bindings/clock/sun50i-r329-r-ccu.h
 create mode 100644 include/dt-bindings/reset/sun50i-r329-ccu.h
 create mode 100644 include/dt-bindings/reset/sun50i-r329-r-ccu.h

-- 
2.35.1

