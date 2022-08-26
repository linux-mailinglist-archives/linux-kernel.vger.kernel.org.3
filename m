Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D34C5A2E71
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242917AbiHZS2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiHZS23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:28:29 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410FDD2B35;
        Fri, 26 Aug 2022 11:28:27 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 12111100005;
        Fri, 26 Aug 2022 18:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661538505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ENV+xWnhw1Xw1tkxFf2nGkYLnzfgvZxgtBLFjjOImfQ=;
        b=Wh94hAggxAjkuDWbuBmtmu8vTBM2CwWql1HCqwcveJbDkpJZ2xXVT8JlS46zvZyWNoBgzk
        xLkPpSe3xzyc52aIxtSye8HCOBnMUta1BjQ7UI8pNlu+6kQzCrWZ6M36NwNPVFdOarOr6O
        DwD49q1H5QOKuQqGsy9jLBdSft17Qf7NkRiRkIE6lYABxC8UF5aNQ9oPOWAGyhv4h0cZlQ
        Vp4zlD+WIrZkffKfRLCCNrkno1w4LSO6vrvVidG9pGKeNMrbuNXmhekJlnD9gJM/rDxcv7
        qQg4+im4QY3+R6aMBgT7CrgBWAgp1di0GrW4ghvhQ+es1MzYHRFrXVzthnZW5A==
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
Subject: [PATCH v5 0/6] Allwinner A31/A83T MIPI CSI-2 and A31 ISP / Platform Support
Date:   Fri, 26 Aug 2022 20:27:57 +0200
Message-Id: <20220826182803.604563-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.1
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

This part only concerns Allwinner platform support changes.

Though some patches still need reviewing, they feel ready to go since the
MIPI CSI-2 bindings were merged, the updated CSI bindings were reviewed by
Rob and the new ISP bindings as well. Although they were not merged yet,
they seem ready to go at this point.

Since this multi-part series has been going on for a while, it would be
great to see it merged soon!

Changes since v4:
- Removed mbus bindings patch: an equivalent change was merged;
- Added collected tags;
- Rebased on latest media tree.

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

Paul Kocialkowski (5):
  clk: sunxi-ng: v3s: Export MBUS and DRAM clocks to the public header
  ARM: dts: sun8i: v3s: Add mbus node to represent the interconnect
  ARM: dts: sun8i: v3s: Add nodes for MIPI CSI-2 support
  ARM: dts: sun8i: v3s: Add support for the ISP
  ARM: dts: sun8i: a83t: Add MIPI CSI-2 controller node

 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 102 ++++++++++++++++
 arch/arm/boot/dts/sun8i-a83t.dtsi            |  26 ++++
 arch/arm/boot/dts/sun8i-v3s.dtsi             | 121 +++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.h         |   4 -
 include/dt-bindings/clock/sun8i-v3s-ccu.h    |   4 +-
 5 files changed, 251 insertions(+), 6 deletions(-)

-- 
2.37.1

