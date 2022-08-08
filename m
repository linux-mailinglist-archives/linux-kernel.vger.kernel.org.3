Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D95A58C6AB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 12:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbiHHKoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 06:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbiHHKoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 06:44:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05359DEB5
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 03:44:20 -0700 (PDT)
Date:   Mon, 08 Aug 2022 10:44:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659955459;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FTV4d4vohQSpJlgXmrHEwH+1hfSYuiKyvJxFcCTxoTk=;
        b=D5wbH5t1EVNruyDRhhhHKk07WYeGHHeUQT8UVhZmI+Bcscbnoh7UXPrlPE/G/2JfFaWiWS
        Jowd4dUD71fGkLC/Pow5VQ6eHs4hYhs2kkvphBjgbWSdlYEEuriwWVaNPEo+YFX4mdKP9e
        TZwXaBk34ENa38oq9dFEGH6OTUw4Tum2FmJB0kmhvxyJn+QRQgKObywM/wBJYP6VBi2D3o
        liV5aWee8gNlodmAR4xHTQvMz85HOpyURgb1n84rAsO5K4PihTXVDChbZ2UcGupCSf/68o
        CQyrK3XmYkXABpIlSLGb4K46cCW3mEqWW7uw7pfxxugjSlXUk41PE0Sp/kmgsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659955459;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FTV4d4vohQSpJlgXmrHEwH+1hfSYuiKyvJxFcCTxoTk=;
        b=Yxkc0WibHOHW2vcw6EN3kqT8a/Gt9mkEA6jQGpHROvY8QfGp+3gAD/JznndsOc16aEmwxQ
        XCnGPtCxOcEHrZBw==
From:   "irqchip-bot for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/loongson-pch-pic: Move
 find_pch_pic() into CONFIG_ACPI
Cc:     kernel test robot <lkp@intel.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220808093205.3658485-1-chenhuacai@loongson.cn>
References: <20220808093205.3658485-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Message-ID: <165995545744.15455.8409524253029637050.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     fda7409a8fcfa457814f8186f2861a9f00008e75
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/fda7409a8fcfa457814f8186f2861a9f00008e75
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Mon, 08 Aug 2022 17:32:05 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 08 Aug 2022 11:10:28 +01:00

irqchip/loongson-pch-pic: Move find_pch_pic() into CONFIG_ACPI

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

BTW, remove the duplicated declaration of find_pch_pic() in irq.h.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220808093205.3658485-1-chenhuacai@loongson.cn
---
 arch/loongarch/include/asm/irq.h       |  1 +-
 drivers/irqchip/irq-loongson-pch-pic.c | 38 ++++++++++++-------------
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
index 149b212..093aee9 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -81,7 +81,6 @@ extern struct acpi_vector_group msi_group[MAX_IO_PICS];
 #define GSI_MIN_PCH_IRQ		LOONGSON_PCH_IRQ_BASE
 #define GSI_MAX_PCH_IRQ		(LOONGSON_PCH_IRQ_BASE + 256 - 1)
 
-extern int find_pch_pic(u32 gsi);
 extern int eiointc_get_node(int id);
 
 struct acpi_madt_lio_pic;
diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index b6f1392..b987b65 100644
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
