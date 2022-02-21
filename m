Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A4C4BE0A5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377207AbiBUOCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:02:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356283AbiBUOB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:01:59 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF9F2BC2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:01:35 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id B0B951F4360D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645452094;
        bh=epGrvoN6O958D68LDjx6PyP4zz4QWjmBIV3ddNS3P3s=;
        h=From:To:Cc:Subject:Date:From;
        b=nK3nZIL5kiSQN2HlgSqNiu5aTPl+MgXvZ01AF/Xo0jzkO5njuH6Vljd82ALwhGcTW
         Jc6WvjENuQaMdh7QHpPCcs8wPqXCQc7TI1LSXLoSdzXNng3X6BU3VXen0e3xHtCYoW
         ikRCKjEYvDsm8NfaPMrOQj1mW15H12/YuGUin7k3543etribEBdSQz8IkZ+KmjMGW+
         6kxju7YuHyNqdaqTkSnZEQMnDFH29qsWF6C2qxJVhSEDyOxkBNHokoJwE7HFbdboeB
         965Pp+QEK3sWC+j8dTfeqmLfjAnxBRYdSRC8B4qUNi1RBSWA6D6mBGhZOs63vM7zY0
         YMqVb+9N2c+5Q==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Detlev Casanova <detlev.casanova@collabora.com>
Subject: [RFC PATCH v2 0/3] ARM: dts: Support official Raspberry Pi 7inch touchscreen
Date:   Mon, 21 Feb 2022 09:01:14 -0500
Message-Id: <20220221140117.90284-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
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
2.35.1

