Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C85358C519
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 10:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239735AbiHHIyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 04:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237164AbiHHIx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 04:53:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F6BB492
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 01:53:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4DD8B80E2B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 08:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83696C433C1;
        Mon,  8 Aug 2022 08:53:53 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] irqchip/loongson-pch-pic: Move find_pch_pic() into CONFIG_ACPI
Date:   Mon,  8 Aug 2022 16:53:59 +0800
Message-Id: <20220808085359.3351574-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MIPS doesn't declare find_pch_pic(), which makes a build warning:

>> drivers/irqchip/irq-loongson-pch-pic.c:51:5: warning: no previous prototype for function 'find_pch_pic' [-Wmissing-prototypes]
   int find_pch_pic(u32 gsi)
       ^
   drivers/irqchip/irq-loongson-pch-pic.c:51:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int find_pch_pic(u32 gsi)
   ^
   static
   1 warning generated.

Move find_pch_pic() into CONFIG_ACPI which only used by LoongArch to fix
the warning.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/irq-loongson-pch-pic.c | 38 +++++++++++++-------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index b6f1392964b1..b987b6517d59 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -48,25 +48,6 @@ static struct pch_pic *pch_pic_priv[MAX_IO_PICS];
 
 struct fwnode_handle *pch_pic_handle[MAX_IO_PICS];
 
-int find_pch_pic(u32 gsi)
-{
-	int i;
-
-	/* Find the PCH_PIC that manages this GSI. */
-	for (i = 0; i < MAX_IO_PICS; i++) {
-		struct pch_pic *priv = pch_pic_priv[i];
-
-		if (!priv)
-			return -1;
-
-		if (gsi >= priv->gsi_base && gsi < (priv->gsi_base + priv->vec_count))
-			return i;
-	}
-
-	pr_err("ERROR: Unable to locate PCH_PIC for GSI %d\n", gsi);
-	return -1;
-}
-
 static void pch_pic_bitset(struct pch_pic *priv, int offset, int bit)
 {
 	u32 reg;
@@ -325,6 +306,25 @@ IRQCHIP_DECLARE(pch_pic, "loongson,pch-pic-1.0", pch_pic_of_init);
 #endif
 
 #ifdef CONFIG_ACPI
+int find_pch_pic(u32 gsi)
+{
+	int i;
+
+	/* Find the PCH_PIC that manages this GSI. */
+	for (i = 0; i < MAX_IO_PICS; i++) {
+		struct pch_pic *priv = pch_pic_priv[i];
+
+		if (!priv)
+			return -1;
+
+		if (gsi >= priv->gsi_base && gsi < (priv->gsi_base + priv->vec_count))
+			return i;
+	}
+
+	pr_err("ERROR: Unable to locate PCH_PIC for GSI %d\n", gsi);
+	return -1;
+}
+
 static int __init
 pch_lpc_parse_madt(union acpi_subtable_headers *header,
 		       const unsigned long end)
-- 
2.31.1

