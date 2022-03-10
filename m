Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAB64D44D5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 11:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241335AbiCJKkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 05:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241239AbiCJKkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:40:45 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7FC5D1A1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 02:39:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 12DD0CE2314
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 10:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB98C340E8;
        Thu, 10 Mar 2022 10:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646908781;
        bh=VWVBHDjNII7WtVdQLshAf0KB/KSzDlt3zf3L3DxI29E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aC4zDMr8lyQ2UGX2o2Gs+5e2B+yNix8po7FkvrBHh7TEbwG2vD+VYRgOI87SnMqcB
         tR+HrULtxr1fzVoSsf4+ScZE/iSZhFHFfN4UQdTWS4X1gw4mp/ORARsQd9DDq0Tfq+
         XfW3vl9iI7NJ27pV1IocE1bumi3DObbg058wEclgHaU1DXGcN/hfJ7wqL9P4iodaB7
         KXQFbuoxBvd1jnUJhWgiRA8lBxW3rTYkCFEDWLusqvgldAhFIS5WBAwHR/1mij8ouO
         8TFSvG0qgf6iEMVIsPGpFl+8WI/kUTEZvTwpR/Jo2TqjV+p5s8/4bp0/ipeAN4Oj4E
         zGZXbxZlswckg==
Received: by pali.im (Postfix)
        id DD5EF7FC; Thu, 10 Mar 2022 11:39:37 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] arm64: dts: marvell: armada-37xx: Remap IO space to bus address 0x0
Date:   Thu, 10 Mar 2022 11:39:23 +0100
Message-Id: <20220310103923.24847-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220218212526.16021-1-pali@kernel.org>
References: <20220218212526.16021-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

---
Changes in v3:
* Rebase on v5.17-rc1

Changes in v2:
* Do not remap IO space on Turris Mox
---
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 7 ++++++-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi           | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index 04da07ae4420..4b377fe807e0 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -136,19 +136,24 @@
 	status = "okay";
 	reset-gpios = <&gpiosb 3 GPIO_ACTIVE_LOW>;
 	/*
 	 * U-Boot port for Turris Mox has a bug which always expects that "ranges" DT property
 	 * contains exactly 2 ranges with 3 (child) address cells, 2 (parent) address cells and
-	 * 2 size cells and also expects that the second range starts at 16 MB offset. If these
+	 * 2 size cells and also expects that the second range starts at 16 MB offset. Also it
+	 * expects that first range uses same address for PCI (child) and CPU (parent) cells (so
+	 * no remapping) and that this address is the lowest from all specified ranges. If these
 	 * conditions are not met then U-Boot crashes during loading kernel DTB file. PCIe address
 	 * space is 128 MB long, so the best split between MEM and IO is to use fixed 16 MB window
 	 * for IO and the rest 112 MB (64+32+16) for MEM, despite that maximal IO size is just 64 kB.
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
 		  0x82000000 0 0xe9000000   0 0xe9000000   0 0x07000000>; /* Port 0 MEM */
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 673f4906eef9..fb78ef613b29 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -497,11 +497,11 @@
 			 * with size a power of two. Use one 64 KiB window for
 			 * IO at the end and the remaining seven windows
 			 * (totaling 127 MiB) for MEM.
 			 */
 			ranges = <0x82000000 0 0xe8000000   0 0xe8000000   0 0x07f00000   /* Port 0 MEM */
-				  0x81000000 0 0xefff0000   0 0xefff0000   0 0x00010000>; /* Port 0 IO */
+				  0x81000000 0 0x00000000   0 0xefff0000   0 0x00010000>; /* Port 0 IO */
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0 0 0 1 &pcie_intc 0>,
 					<0 0 0 2 &pcie_intc 1>,
 					<0 0 0 3 &pcie_intc 2>,
 					<0 0 0 4 &pcie_intc 3>;
-- 
2.20.1

