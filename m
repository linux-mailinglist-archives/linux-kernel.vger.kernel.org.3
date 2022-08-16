Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C27594F23
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 05:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiHPDjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 23:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiHPDjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 23:39:07 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7DE31FF85;
        Mon, 15 Aug 2022 17:10:41 -0700 (PDT)
Received: from apollo.. (unknown [IPv6:2a02:810b:4340:4c9d:4685:ff:fe12:5967])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 904202223D;
        Tue, 16 Aug 2022 02:10:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1660608636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=STGQVtq+8nAltSBU+rS2THY1t5PQzKni78N07VtqrIo=;
        b=pcpfs6feB0d74oUYscLlGC7rPvebScaU5X/vU2igcJGXqqcjnnZcQ0HcrvXtI4TRgdI6yh
        VLXnVmMpcMtXFOjfR7kOd56RZsKvThKfyr0Li6nLsHQXH41Ke4MBxBLqU5YB11ZoIHTqWr
        vZ0tB14U1R95+a1luL3sUt+fRBJjn88=
From:   Michael Walle <michael@walle.cc>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH 1/2] ARM: dts: kirkwood: lsxl: fix serial line
Date:   Tue, 16 Aug 2022 02:10:24 +0200
Message-Id: <20220816001026.830127-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 327e15428977 ("ARM: dts: kirkwood: consolidate common pinctrl
settings") unknowingly broke the serial output on this board. Before
this commit, the pinmux was still configured by the bootloader and the
kernel didn't reconfigured it again. This was an oversight by the
initial board support where the pinmux for the serial line was never
configured by the kernel. But with this commit, the serial line will be
reconfigured to the wrong pins. This is especially confusing, because
the output still works, but the input doesn't. Presumingly, the input is
reconfigured to MPP10, but the output is connected to both MPP11 and
MPP5.

Override the pinmux in the board device tree.

Fixes: 327e15428977 ("ARM: dts: kirkwood: consolidate common pinctrl settings")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm/boot/dts/kirkwood-lsxl.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-lsxl.dtsi b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
index 7b151acb9984..321a40a98ed2 100644
--- a/arch/arm/boot/dts/kirkwood-lsxl.dtsi
+++ b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
@@ -10,6 +10,11 @@ chosen {
 
 	ocp@f1000000 {
 		pinctrl: pin-controller@10000 {
+			/* Non-default UART pins */
+			pmx_uart0: pmx-uart0 {
+				marvell,pins = "mpp4", "mpp5";
+			};
+
 			pmx_power_hdd: pmx-power-hdd {
 				marvell,pins = "mpp10";
 				marvell,function = "gpo";
-- 
2.30.2

