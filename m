Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF3B534367
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 20:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343879AbiEYS7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 14:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbiEYS7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 14:59:12 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705EC34BA7;
        Wed, 25 May 2022 11:59:10 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 47504FF808;
        Wed, 25 May 2022 18:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653505149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jnLXgeypjcLq3AOE4VuwscdmaqXfOdF/aYkjU1pKK8s=;
        b=f068iCrtUo8zoBl7SaKXGdB8kp/sTnbmkDUXR2QCN52JB9Yun5ow4YoDPVKPT1oWYPN4Gt
        NZXB2HivnUdlq3aYtNyKWdr02vurK3SWTuuwnkUbxpw1QqdPI34jPcq7YMvZb0sNl1qiH0
        ae79r/WE/y2mYtgksGcaTaLETGvjNvraiKn6n8VO8g+eDcFhux9OsUMnU8QYdk3YDxlcb9
        RM6X+/We7kToyvYP74awPHstVl2BpTzpJGbxyDXBRbufD59iOuxGIUOAN0BnRSN7ASr6wC
        iNkgZLXS3zLJIY0ctmkk9jmkUZZCzlLnq1nlfZmNCuybTDWLLI2z+fxW12LtZg==
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
Subject: [PATCH v4 0/7] Allwinner A31/A83T MIPI CSI-2 and A31 ISP / Platform Support
Date:   Wed, 25 May 2022 20:58:46 +0200
Message-Id: <20220525185853.695931-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Changes since v3:
- Reordered v3s mbus compatible in binding;
- Added collected tag;
- Removed rejected interconnects fix.

Changes since all-in-one v2:
- Corrected mbus index used for the interconnects;
- Used extended mbus binding and exported the DRAM clock for that;
- Reworked the description of the core openfirmware change to give
  more insight about the situation.

Kévin L'hôpital (1):
  ARM: dts: sun8i: a83t: bananapi-m3: Enable MIPI CSI-2 with OV8865

Paul Kocialkowski (6):
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
 include/dt-bindings/clock/sun8i-v3s-ccu.h     |   4 +-
 6 files changed, 253 insertions(+), 6 deletions(-)

-- 
2.36.1

