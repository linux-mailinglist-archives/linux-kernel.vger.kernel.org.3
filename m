Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9A44CFE75
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242290AbiCGM2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242415AbiCGM2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:28:02 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B232481199
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 04:27:07 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:3895:ecac:cede:7a48])
        by albert.telenet-ops.be with bizsmtp
        id 3QT42700N31zFQa06QT4aT; Mon, 07 Mar 2022 13:27:05 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nRCS8-0032zO-8V; Mon, 07 Mar 2022 13:27:04 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nRCS7-002L4P-Cg; Mon, 07 Mar 2022 13:27:03 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] mtd: hyperbus: HBMC_AM654 should depend on ARCH_K3
Date:   Mon,  7 Mar 2022 13:27:02 +0100
Message-Id: <9fd6b975adba710158f28aa603cf87a6d189a418.1646655894.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AM65x HyperBus controller is only present on Texas Instruments AM65x
SoCs.  Hence add a dependency on ARCH_K3, to prevent asking the user
about this driver when configuring a kernel without support for the
Texas Instruments Inc. K3 multicore SoC architecture.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mtd/hyperbus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/hyperbus/Kconfig b/drivers/mtd/hyperbus/Kconfig
index 46c7e407e3780ae8..30ffc4c16e4d3e57 100644
--- a/drivers/mtd/hyperbus/Kconfig
+++ b/drivers/mtd/hyperbus/Kconfig
@@ -15,7 +15,7 @@ if MTD_HYPERBUS
 
 config HBMC_AM654
 	tristate "HyperBus controller driver for AM65x SoC"
-	depends on ARM64 || COMPILE_TEST
+	depends on ARCH_K3 || COMPILE_TEST
 	select MULTIPLEXER
 	imply MUX_MMIO
 	help
-- 
2.25.1

