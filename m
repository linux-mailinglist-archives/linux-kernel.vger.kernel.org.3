Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3A9512202
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbiD0TGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiD0TF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:05:56 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201C090CE8;
        Wed, 27 Apr 2022 11:53:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id 70F871F44C76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651085578;
        bh=OV0Z+SXN5LTYQytPf5y0kDwTuGPnGohLGzr4axQ+7yw=;
        h=From:To:Cc:Subject:Date:From;
        b=AY6LsKCA/lI55xWW2jetqHmqlqE0JMO7i5IAIbxL2lRP+b1zh69hkwb7ptIHxTCfU
         3FdEN21owDZZLmhrOowfjMTzqZPh6yetG8IUxry7w7Ow9kHTPCj9PhDN3MnjJPOzl6
         1W+YZJ5HmVotKypHriO5kFEuxQZtRG/GplyNGEM3WEdlhvGtP7bP9a5GTYVky22kWH
         w91t7BXVh1Ukc2aHGr4EdEHBqHIifnKJ4m7ej8mNWoEggYTuJXzB7RdA5+bV7/1J+V
         TPxuJUBtOz0u4X4f1nObiflnwu43pyNseFexaHJXxe1yB/SuUlriNTEtb2DRuOYloP
         4TZ4tKkj7tc4w==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, bcm-kernel-feedback-list@broadcom.com,
        devicetree@vger.kernel.org, f.fainelli@gmail.com,
        frowand.list@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com,
        nsaenz@kernel.org, olof@lixom.net, rjui@broadcom.com,
        robh+dt@kernel.org, sbranden@broadcom.com, soc@kernel.org,
        stefan.wahren@i2se.com,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [RFC PATCH v2 0/3] ARM: dts: Support official Raspberry Pi 7inch touchscreen
Date:   Wed, 27 Apr 2022 14:52:40 -0400
Message-Id: <20220427185243.173594-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a devicetree overlay to support the official Raspberry Pi 7inch touchscreen.

This also demuxes the i2c0 controller to support both pinctrls.

Changes in v2:
 * The device tree in now an overlay
 * The i2c demux patch is kept for now to have a working patch set. It has
   not been merged yet in [1].
 * The device tree overlay doesn't use fragments. It is working as is 
   but not enough literature was found to go one way or the other.

[1] https://www.spinics.net/lists/arm-kernel/msg944330.html

Detlev Casanova (3):
  ARM: dts: bcm2*: Demux i2c0 with a pinctrl
  of: Add support for -@ when compiling overlays
  ARM: dto: Add bcm2711-rpi-7-inches-ts.dts overlay

 arch/arm/boot/dts/Makefile                    |   4 +
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts         |   1 +
 arch/arm/boot/dts/bcm2711.dtsi                |   2 +-
 arch/arm/boot/dts/bcm2835-rpi.dtsi            |   9 +-
 .../boot/dts/bcm283x-rpi-i2c0mux_0_44.dtsi    |   4 +
 arch/arm/boot/dts/bcm283x.dtsi                |  26 +++-
 arch/arm/boot/dts/overlays/Makefile           |   3 +
 .../dts/overlays/bcm2711-rpi-7-inches-ts.dts  | 125 ++++++++++++++++++
 arch/arm64/boot/dts/broadcom/Makefile         |   4 +
 .../arm64/boot/dts/broadcom/overlays/Makefile |   3 +
 .../overlays/bcm2711-rpi-7-inches-ts.dts      |   2 +
 drivers/of/Kconfig                            |   8 ++
 scripts/Makefile.lib                          |   9 +-
 13 files changed, 193 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-i2c0mux_0_44.dtsi
 create mode 100644 arch/arm/boot/dts/overlays/Makefile
 create mode 100644 arch/arm/boot/dts/overlays/bcm2711-rpi-7-inches-ts.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/overlays/Makefile
 create mode 100644 arch/arm64/boot/dts/broadcom/overlays/bcm2711-rpi-7-inches-ts.dts

-- 
2.36.0

