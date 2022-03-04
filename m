Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B964B4CD925
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240435AbiCDQcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbiCDQb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:31:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910621CBAAC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:31:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E09461DA2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 16:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445D5C340E9;
        Fri,  4 Mar 2022 16:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646411470;
        bh=jFUfF78Cjf/1eZqprpKmqCTNroOHY0f+mDX1lYETlww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sGqNWxsOQXEHYpj3kI5lbcr7A3lryETmSG4ZqZBCCja1yoiYXw7I+Yt0e8Qwq+9cZ
         mbCBtbdKH6a3FqNcl0zmMqiPHqcej+7c/hDujLcFPLMmKVX4EctqLgb6zGfoUHXdii
         kWpPNsJNo0pIuV1Do16eJ4/gu/SXuWWCeBJfd1G5T0O4DaYtylUlaVjNAaknHRQfb+
         6di15z9pD1Rmivh+EwqMH1oJy9+wfHB891KPwF32FNCcBkFNuq0eSUUhMeEdHQdOz6
         qztNJQIihsY6afWCH2leaLMfzWCG537LI/L1taKHMm5fSv9U3zAK/3HNpKHETOthLS
         cKVANgFqk5GHQ==
Received: by pali.im (Postfix)
        id 4A456CAD; Fri,  4 Mar 2022 17:31:07 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: marvell: armada-37xx: Remap IO space to bus address 0x0
Date:   Fri,  4 Mar 2022 17:30:27 +0100
Message-Id: <20220304163027.29357-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220218212526.16021-1-pali@kernel.org>
References: <20220218212526.16021-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Legacy and old PCI I/O based cards do not support 32-bit I/O addressing.

Since commit 64f160e19e92 ("PCI: aardvark: Configure PCIe resources from
'ranges' DT property") kernel can set different PCIe address on CPU and
different on the bus for the one A37xx address mapping without any firmware
support in case the bus address does not conflict with other A37xx mapping.

So remap I/O space to the bus address 0x0 to enable support for old legacy
I/O port based cards which have hardcoded I/O ports in low address space.

Note that DDR on A37xx is mapped to bus address 0x0. And mapping of I/O
space can be set to address 0x0 too because MEM space and I/O space are
separate and so do not conflict.

Remapping IO space on Turris Mox to different address is not possible to
due bootloader bug.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 76f6386b25cc ("arm64: dts: marvell: Add Aardvark PCIe support for Armada 3700")
Cc: stable@vger.kernel.org # 64f160e19e92 ("PCI: aardvark: Configure PCIe resources from 'ranges' DT property")
Cc: stable@vger.kernel.org # 514ef1e62d65 ("arm64: dts: marvell: armada-37xx: Extend PCIe MEM space")
Cc: stable@vger.kernel.org # ???????????? ("arm64: dts: marvell: armada-37xx: Increase PCIe IO size from 64 KiB to 1 MiB")

---
Changes in v2:
* Do not remap IO space on Turris Mox
---
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 7 ++++++-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi           | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index 6581092c2c90..2838e3f65ada 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -150,17 +150,22 @@
 	slot-power-limit = <10000>;
 	/*
 	 * U-Boot port for Turris Mox has a bug which always expects that "ranges" DT property
 	 * contains exactly 2 ranges with 3 (child) address cells, 2 (parent) address cells and
-	 * 2 size cells and also expects that the second range starts at 16 MB offset. If these
+	 * 2 size cells and also expects that the second range starts at 16 MB offset. Also it
+	 * expects that first range uses same address for PCI (child) and CPU (parent) cells (so
+	 * no remapping) and that this address is the lowest from all specified ranges. If these
 	 * conditions are not met then U-Boot crashes during loading kernel DTB file. PCIe address
 	 * space is 128 MB long, so the best split between MEM and IO is to use fixed 16 MB window
 	 * for IO and the rest 112 MB (64+32+16) for MEM. Controller supports 32-bit IO mapping.
 	 * This bug is not present in U-Boot ports for other Armada 3700 devices and is fixed in
 	 * U-Boot version 2021.07. See relevant U-Boot commits (the last one contains fix):
 	 * https://source.denx.de/u-boot/u-boot/-/commit/cb2ddb291ee6fcbddd6d8f4ff49089dfe580f5d7
 	 * https://source.denx.de/u-boot/u-boot/-/commit/c64ac3b3185aeb3846297ad7391fc6df8ecd73bf
 	 * https://source.denx.de/u-boot/u-boot/-/commit/4a82fca8e330157081fc132a591ebd99ba02ee33
+	 * Bug related to requirement of same child and parent addresses for first range is fixed
+	 * in U-Boot version 2022.04 by following commit:
+	 * https://source.denx.de/u-boot/u-boot/-/commit/1fd54253bca7d43d046bba4853fe5fafd034bc17
 	 */
 	#address-cells = <3>;
 	#size-cells = <2>;
 	ranges = <0x81000000 0 0xe8000000   0 0xe8000000   0 0x01000000   /* Port 0 IO */
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 549c3f7c5b27..a099b7787429 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -514,9 +514,9 @@
 			 * IO at the end and the remaining seven windows
 			 * (totaling 127 MiB) for MEM.
 			 */
 			ranges = <0x82000000 0 0xe8000000   0 0xe8000000   0 0x07f00000   /* Port 0 MEM */
-				  0x81000000 0 0xeff00000   0 0xeff00000   0 0x00100000>; /* Port 0 IO*/
+				  0x81000000 0 0x00000000   0 0xeff00000   0 0x00100000>; /* Port 0 IO */
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0 0 0 1 &pcie_intc 0>,
 					<0 0 0 2 &pcie_intc 1>,
 					<0 0 0 3 &pcie_intc 2>,
-- 
2.20.1

