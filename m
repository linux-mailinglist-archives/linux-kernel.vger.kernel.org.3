Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7A54CB0C3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245059AbiCBVL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbiCBVLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:11:54 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092DAB7146;
        Wed,  2 Mar 2022 13:11:08 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A9C3C1C0005;
        Wed,  2 Mar 2022 21:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646255466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=itH78pPfoQ6UhbplnnBJkFGPYw1yUjwOppLHajcMFfQ=;
        b=PJBpm/gO8KB6e00LHTjZVoEHKJ+1osZ7S0kwRXAIu76EhaL/iTe+znrsAFPAFNfoJ4GsWS
        YAWn6j3R7skPVF9q+XsGWx3gvsLhkSU6N3fBFDy1Xu0E5Sm4dAJhA1SZkNwBcK5XcarmMG
        AiesJ0JuyNuIzV8Xd8OpoSGP1aeK5xKiz7fRCQL8hZEIBBzYEZCkKj+PGBmbtiwjzTtwPa
        1TgpIPYROFbTIeXQayFwp0gd1wlGcsEq7U9my883onJcJKpyhZKvZdXsd/lT+8N1JuuRRt
        ZPZ8gyAM5x5BoDycZGeePmBKf294e4y5ZAd0zUSe0frTEsZljFu440C0sYRxeg==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v3 0/8] Allwinner A31/A83T MIPI CSI-2 and A31 ISP / Platform Support
Date:   Wed,  2 Mar 2022 22:10:52 +0100
Message-Id: <20220302211100.65264-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new version is an offspring from the big "Allwinner A31/A83T
MIPI CSI-2 Support and A31 ISP Support" series, which was split into
individual series for better clarity and handling.

This part only concerns Allwinner platform support changes.
Note that the device-tree bindings for the MIPI CSI-2 controller
and ISP are still under review in their dedicated series, so these
patches should probably not be merged yet, although feedback about
them is welcome.

Changes since all-in-one v2:
- Corrected mbus index used for the interconnects;
- Used extended mbus binding and exported the DRAM clock for that;
- Reworked the description of the core openfirmware change to give
  more insight about the situation.

Kévin L'hôpital (1):
  ARM: dts: sun8i: a83t: bananapi-m3: Enable MIPI CSI-2 with OV8865

Paul Kocialkowski (7):
  of: Mark interconnects property supplier as optional
  dt-bindings: interconnect: sunxi: Add V3s mbus compatible
  clk: sunxi-ng: v3s: Export MBUS and DRAM clocks to the public header
  ARM: dts: sun8i: v3s: Add mbus node to represent the interconnect
  ARM: dts: sun8i: v3s: Add nodes for MIPI CSI-2 support
  ARM: dts: sun8i: v3s: Add support for the ISP
  ARM: dts: sun8i: a83t: Add MIPI CSI-2 controller node

 .../arm/sunxi/allwinner,sun4i-a10-mbus.yaml   |   2 +
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts  | 102 +++++++++++++++
 arch/arm/boot/dts/sun8i-a83t.dtsi             |  26 ++++
 arch/arm/boot/dts/sun8i-v3s.dtsi              | 121 ++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.h          |   4 -
 drivers/of/property.c                         |   2 +-
 include/dt-bindings/clock/sun8i-v3s-ccu.h     |   4 +-
 7 files changed, 254 insertions(+), 7 deletions(-)

-- 
2.35.1

