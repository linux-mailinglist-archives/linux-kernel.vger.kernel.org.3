Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9984BC1EC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 22:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239939AbiBRV05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 16:26:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239985AbiBRV0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:26:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BB528DDE7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:26:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F1B261E14
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 21:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE9AC340EB;
        Fri, 18 Feb 2022 21:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645219567;
        bh=67CzBjJX5ADPiMrFIWys7nmcZswOOgMf2OfedGZwxso=;
        h=From:To:Cc:Subject:Date:From;
        b=KnpXmn4UT51pv3OWGWxN0LEuLx7nJmopvtcQpAL5hGJK3qQ4/stQHpVs9AUiPmeSm
         OMU0ic9ZpSj4FvN3+zGRy+vCoJAgTsecq1voWEgbcwO2qOCzywXe3l3L547tvQCawy
         MgNnbuqAeU2KI8HnejMxoccRTnjmBbPX1A65DsS9UIjXpJbbghEW1gbrm96oblRBRr
         nhP6p//q8hPYwj7rV+BHj0GLSRZdW9xz7HT0akxtZw8zde2G2lQdjaMNDG6gazRQOK
         gM1ON+gK2ZxY02Pq32ozlEfCO0MxVzlotwVmnaFaglDiuWD1uqf4aD8Wcsxs5HBdLa
         FXYs/J54Nohng==
Received: by pali.im (Postfix)
        id 496B22BAE; Fri, 18 Feb 2022 22:26:04 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: marvell: armada-37xx: Remap IO space to bus address 0x0
Date:   Fri, 18 Feb 2022 22:25:26 +0100
Message-Id: <20220218212526.16021-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remap PCI I/O space to the bus address 0x0 in the Armada 37xx
device-tree in order to support legacy I/O port based cards which have
hardcoded I/O ports in low address space.

Some legacy PCI I/O based cards do not support 32-bit I/O addressing.

Since commit 64f160e19e92 ("PCI: aardvark: Configure PCIe resources from
'ranges' DT property") this driver can work with I/O windows which have
a different address for CPU than for PCI bus (unless there is some
conflict with other A37xx mapping), without needing additional support
for this in the firmware.

Note that DDR on A37xx is mapped to bus address 0x0 and that mapping of
I/O space can be set to address 0x0 too because MEM space and I/O space
are separate and so they do not conflict.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reported-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 2 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index 6581092c2c90..7d1b9153a901 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -163,7 +163,7 @@
 	 */
 	#address-cells = <3>;
 	#size-cells = <2>;
-	ranges = <0x81000000 0 0xe8000000   0 0xe8000000   0 0x01000000   /* Port 0 IO */
+	ranges = <0x81000000 0 0x00000000   0 0xe8000000   0 0x01000000   /* Port 0 IO */
 		  0x82000000 0 0xe9000000   0 0xe9000000   0 0x07000000>; /* Port 0 MEM */
 
 	/* enabled by U-Boot if PCIe module is present */
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 549c3f7c5b27..a099b7787429 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -515,7 +515,7 @@
 			 * (totaling 127 MiB) for MEM.
 			 */
 			ranges = <0x82000000 0 0xe8000000   0 0xe8000000   0 0x07f00000   /* Port 0 MEM */
-				  0x81000000 0 0xeff00000   0 0xeff00000   0 0x00100000>; /* Port 0 IO*/
+				  0x81000000 0 0x00000000   0 0xeff00000   0 0x00100000>; /* Port 0 IO */
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0 0 0 1 &pcie_intc 0>,
 					<0 0 0 2 &pcie_intc 1>,
-- 
2.20.1

