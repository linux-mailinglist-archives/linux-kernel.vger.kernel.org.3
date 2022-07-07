Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9083E569D4F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbiGGISN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbiGGIRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:17:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7344D4F1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:15:53 -0700 (PDT)
Date:   Thu, 07 Jul 2022 08:15:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657181751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RRD2nHrpMGmkH0i5M7xT9PMwHigsUjma/i1UJRHOxec=;
        b=3cxV60yc2VQFfadEMOcanBaOaNRMoabMte0/ffxHAr3ZjiMtfJmqliwsvMHSCs5ukPmHTp
        YDgmiTCvA/MqrBWAsDqinvjQ7wyP9nlh5WNeShG2xvppykFuKLfX99Zy4FTKQxFwkiT2SJ
        Am8Zu6U4IKqM7f2a3PUCXv+/p8DmR76U7RTztvQ0fXMfwAdxN01f4zy4akGKhcmv0SrLOR
        v5oqFQ85PySFZOFQkxnq/3qML6ptLHWfTSn0QI9JUFu2iuu+gVIVxOLvJkTNMzhKeI9ct8
        9oQtleUDP1shFKIucWCBzfhZLiCArTu8XIRecqT3RkNFO93Xaa2AC51cN9kYOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657181751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RRD2nHrpMGmkH0i5M7xT9PMwHigsUjma/i1UJRHOxec=;
        b=ewQc+3eiBxW9KxJ6yJuQ8nzSsj5ulxW7EjIXOeGzQpgzB88AYpudwM62CeyxMPaBo4rqJ/
        /ansUXkXF6Cas8Dw==
From:   "irqchip-bot for Antonio Borneo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/stm32-exti: Read event trigger
 type from event_trg register
Cc:     Antonio Borneo <antonio.borneo@foss.st.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220606162757.415354-6-antonio.borneo@foss.st.com>
References: <20220606162757.415354-6-antonio.borneo@foss.st.com>
MIME-Version: 1.0
Message-ID: <165718175019.15455.4071751189569626975.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     ce4ef8f9f2abcf104a5417225cbfe3560e779093
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/ce4ef8f9f2abcf104a5417225cbfe3560e779093
Author:        Antonio Borneo <antonio.borneo@foss.st.com>
AuthorDate:    Mon, 06 Jun 2022 18:27:56 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 07 Jul 2022 09:07:44 +01:00

irqchip/stm32-exti: Read event trigger type from event_trg register

The flag reporting whether an event is 'direct' or 'configurable'
is available in the read-only registers EVENT_TRG.

Drop this redundant information from the struct stm32_desc_irq and
use the proper bit from EVENT_TRG register.
On armv7a this patch reduces by 3% the size of the driver, from
   text    data     bss     dec     hex filename
   7233     424       4    7661    1ded irq-stm32-exti.o
to
   6977     424       4    7405    1ced irq-stm32-exti.o

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220606162757.415354-6-antonio.borneo@foss.st.com
---
 drivers/irqchip/irq-stm32-exti.c | 180 ++++++++++++++++--------------
 1 file changed, 96 insertions(+), 84 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index e8fa91b..0455896 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -34,6 +34,7 @@ struct stm32_exti_bank {
 	u32 swier_ofst;
 	u32 rpr_ofst;
 	u32 fpr_ofst;
+	u32 trg_ofst;
 };
 
 #define UNDEF_REG ~0
@@ -41,7 +42,6 @@ struct stm32_exti_bank {
 struct stm32_desc_irq {
 	u32 exti;
 	u32 irq_parent;
-	struct irq_chip *chip;
 };
 
 struct stm32_exti_drv_data {
@@ -78,6 +78,7 @@ static const struct stm32_exti_bank stm32f4xx_exti_b1 = {
 	.swier_ofst	= 0x10,
 	.rpr_ofst	= 0x14,
 	.fpr_ofst	= UNDEF_REG,
+	.trg_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank *stm32f4xx_exti_banks[] = {
@@ -97,6 +98,7 @@ static const struct stm32_exti_bank stm32h7xx_exti_b1 = {
 	.swier_ofst	= 0x08,
 	.rpr_ofst	= 0x88,
 	.fpr_ofst	= UNDEF_REG,
+	.trg_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank stm32h7xx_exti_b2 = {
@@ -107,6 +109,7 @@ static const struct stm32_exti_bank stm32h7xx_exti_b2 = {
 	.swier_ofst	= 0x28,
 	.rpr_ofst	= 0x98,
 	.fpr_ofst	= UNDEF_REG,
+	.trg_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank stm32h7xx_exti_b3 = {
@@ -117,6 +120,7 @@ static const struct stm32_exti_bank stm32h7xx_exti_b3 = {
 	.swier_ofst	= 0x48,
 	.rpr_ofst	= 0xA8,
 	.fpr_ofst	= UNDEF_REG,
+	.trg_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank *stm32h7xx_exti_banks[] = {
@@ -138,6 +142,7 @@ static const struct stm32_exti_bank stm32mp1_exti_b1 = {
 	.swier_ofst	= 0x08,
 	.rpr_ofst	= 0x0C,
 	.fpr_ofst	= 0x10,
+	.trg_ofst	= 0x3EC,
 };
 
 static const struct stm32_exti_bank stm32mp1_exti_b2 = {
@@ -148,6 +153,7 @@ static const struct stm32_exti_bank stm32mp1_exti_b2 = {
 	.swier_ofst	= 0x28,
 	.rpr_ofst	= 0x2C,
 	.fpr_ofst	= 0x30,
+	.trg_ofst	= 0x3E8,
 };
 
 static const struct stm32_exti_bank stm32mp1_exti_b3 = {
@@ -158,6 +164,7 @@ static const struct stm32_exti_bank stm32mp1_exti_b3 = {
 	.swier_ofst	= 0x48,
 	.rpr_ofst	= 0x4C,
 	.fpr_ofst	= 0x50,
+	.trg_ofst	= 0x3E4,
 };
 
 static const struct stm32_exti_bank *stm32mp1_exti_banks[] = {
@@ -170,90 +177,90 @@ static struct irq_chip stm32_exti_h_chip;
 static struct irq_chip stm32_exti_h_chip_direct;
 
 static const struct stm32_desc_irq stm32mp1_desc_irq[] = {
-	{ .exti = 0, .irq_parent = 6, .chip = &stm32_exti_h_chip },
-	{ .exti = 1, .irq_parent = 7, .chip = &stm32_exti_h_chip },
-	{ .exti = 2, .irq_parent = 8, .chip = &stm32_exti_h_chip },
-	{ .exti = 3, .irq_parent = 9, .chip = &stm32_exti_h_chip },
-	{ .exti = 4, .irq_parent = 10, .chip = &stm32_exti_h_chip },
-	{ .exti = 5, .irq_parent = 23, .chip = &stm32_exti_h_chip },
-	{ .exti = 6, .irq_parent = 64, .chip = &stm32_exti_h_chip },
-	{ .exti = 7, .irq_parent = 65, .chip = &stm32_exti_h_chip },
-	{ .exti = 8, .irq_parent = 66, .chip = &stm32_exti_h_chip },
-	{ .exti = 9, .irq_parent = 67, .chip = &stm32_exti_h_chip },
-	{ .exti = 10, .irq_parent = 40, .chip = &stm32_exti_h_chip },
-	{ .exti = 11, .irq_parent = 42, .chip = &stm32_exti_h_chip },
-	{ .exti = 12, .irq_parent = 76, .chip = &stm32_exti_h_chip },
-	{ .exti = 13, .irq_parent = 77, .chip = &stm32_exti_h_chip },
-	{ .exti = 14, .irq_parent = 121, .chip = &stm32_exti_h_chip },
-	{ .exti = 15, .irq_parent = 127, .chip = &stm32_exti_h_chip },
-	{ .exti = 16, .irq_parent = 1, .chip = &stm32_exti_h_chip },
-	{ .exti = 19, .irq_parent = 3, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 21, .irq_parent = 31, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 22, .irq_parent = 33, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 23, .irq_parent = 72, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 24, .irq_parent = 95, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 25, .irq_parent = 107, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 26, .irq_parent = 37, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 27, .irq_parent = 38, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 28, .irq_parent = 39, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 29, .irq_parent = 71, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 30, .irq_parent = 52, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 31, .irq_parent = 53, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 32, .irq_parent = 82, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 33, .irq_parent = 83, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 47, .irq_parent = 93, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 48, .irq_parent = 138, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 50, .irq_parent = 139, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 52, .irq_parent = 140, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 53, .irq_parent = 141, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 54, .irq_parent = 135, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 61, .irq_parent = 100, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 65, .irq_parent = 144, .chip = &stm32_exti_h_chip },
-	{ .exti = 68, .irq_parent = 143, .chip = &stm32_exti_h_chip },
-	{ .exti = 70, .irq_parent = 62, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 73, .irq_parent = 129, .chip = &stm32_exti_h_chip },
+	{ .exti = 0, .irq_parent = 6 },
+	{ .exti = 1, .irq_parent = 7 },
+	{ .exti = 2, .irq_parent = 8 },
+	{ .exti = 3, .irq_parent = 9 },
+	{ .exti = 4, .irq_parent = 10 },
+	{ .exti = 5, .irq_parent = 23 },
+	{ .exti = 6, .irq_parent = 64 },
+	{ .exti = 7, .irq_parent = 65 },
+	{ .exti = 8, .irq_parent = 66 },
+	{ .exti = 9, .irq_parent = 67 },
+	{ .exti = 10, .irq_parent = 40 },
+	{ .exti = 11, .irq_parent = 42 },
+	{ .exti = 12, .irq_parent = 76 },
+	{ .exti = 13, .irq_parent = 77 },
+	{ .exti = 14, .irq_parent = 121 },
+	{ .exti = 15, .irq_parent = 127 },
+	{ .exti = 16, .irq_parent = 1 },
+	{ .exti = 19, .irq_parent = 3 },
+	{ .exti = 21, .irq_parent = 31 },
+	{ .exti = 22, .irq_parent = 33 },
+	{ .exti = 23, .irq_parent = 72 },
+	{ .exti = 24, .irq_parent = 95 },
+	{ .exti = 25, .irq_parent = 107 },
+	{ .exti = 26, .irq_parent = 37 },
+	{ .exti = 27, .irq_parent = 38 },
+	{ .exti = 28, .irq_parent = 39 },
+	{ .exti = 29, .irq_parent = 71 },
+	{ .exti = 30, .irq_parent = 52 },
+	{ .exti = 31, .irq_parent = 53 },
+	{ .exti = 32, .irq_parent = 82 },
+	{ .exti = 33, .irq_parent = 83 },
+	{ .exti = 47, .irq_parent = 93 },
+	{ .exti = 48, .irq_parent = 138 },
+	{ .exti = 50, .irq_parent = 139 },
+	{ .exti = 52, .irq_parent = 140 },
+	{ .exti = 53, .irq_parent = 141 },
+	{ .exti = 54, .irq_parent = 135 },
+	{ .exti = 61, .irq_parent = 100 },
+	{ .exti = 65, .irq_parent = 144 },
+	{ .exti = 68, .irq_parent = 143 },
+	{ .exti = 70, .irq_parent = 62 },
+	{ .exti = 73, .irq_parent = 129 },
 };
 
 static const struct stm32_desc_irq stm32mp13_desc_irq[] = {
-	{ .exti = 0, .irq_parent = 6, .chip = &stm32_exti_h_chip },
-	{ .exti = 1, .irq_parent = 7, .chip = &stm32_exti_h_chip },
-	{ .exti = 2, .irq_parent = 8, .chip = &stm32_exti_h_chip },
-	{ .exti = 3, .irq_parent = 9, .chip = &stm32_exti_h_chip },
-	{ .exti = 4, .irq_parent = 10, .chip = &stm32_exti_h_chip },
-	{ .exti = 5, .irq_parent = 24, .chip = &stm32_exti_h_chip },
-	{ .exti = 6, .irq_parent = 65, .chip = &stm32_exti_h_chip },
-	{ .exti = 7, .irq_parent = 66, .chip = &stm32_exti_h_chip },
-	{ .exti = 8, .irq_parent = 67, .chip = &stm32_exti_h_chip },
-	{ .exti = 9, .irq_parent = 68, .chip = &stm32_exti_h_chip },
-	{ .exti = 10, .irq_parent = 41, .chip = &stm32_exti_h_chip },
-	{ .exti = 11, .irq_parent = 43, .chip = &stm32_exti_h_chip },
-	{ .exti = 12, .irq_parent = 77, .chip = &stm32_exti_h_chip },
-	{ .exti = 13, .irq_parent = 78, .chip = &stm32_exti_h_chip },
-	{ .exti = 14, .irq_parent = 106, .chip = &stm32_exti_h_chip },
-	{ .exti = 15, .irq_parent = 109, .chip = &stm32_exti_h_chip },
-	{ .exti = 16, .irq_parent = 1, .chip = &stm32_exti_h_chip },
-	{ .exti = 19, .irq_parent = 3, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 21, .irq_parent = 32, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 22, .irq_parent = 34, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 23, .irq_parent = 73, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 24, .irq_parent = 93, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 25, .irq_parent = 114, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 26, .irq_parent = 38, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 27, .irq_parent = 39, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 28, .irq_parent = 40, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 29, .irq_parent = 72, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 30, .irq_parent = 53, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 31, .irq_parent = 54, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 32, .irq_parent = 83, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 33, .irq_parent = 84, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 44, .irq_parent = 96, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 47, .irq_parent = 92, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 48, .irq_parent = 116, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 50, .irq_parent = 117, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 52, .irq_parent = 118, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 53, .irq_parent = 119, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 68, .irq_parent = 63, .chip = &stm32_exti_h_chip_direct },
-	{ .exti = 70, .irq_parent = 98, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 0, .irq_parent = 6 },
+	{ .exti = 1, .irq_parent = 7 },
+	{ .exti = 2, .irq_parent = 8 },
+	{ .exti = 3, .irq_parent = 9 },
+	{ .exti = 4, .irq_parent = 10 },
+	{ .exti = 5, .irq_parent = 24 },
+	{ .exti = 6, .irq_parent = 65 },
+	{ .exti = 7, .irq_parent = 66 },
+	{ .exti = 8, .irq_parent = 67 },
+	{ .exti = 9, .irq_parent = 68 },
+	{ .exti = 10, .irq_parent = 41 },
+	{ .exti = 11, .irq_parent = 43 },
+	{ .exti = 12, .irq_parent = 77 },
+	{ .exti = 13, .irq_parent = 78 },
+	{ .exti = 14, .irq_parent = 106 },
+	{ .exti = 15, .irq_parent = 109 },
+	{ .exti = 16, .irq_parent = 1 },
+	{ .exti = 19, .irq_parent = 3 },
+	{ .exti = 21, .irq_parent = 32 },
+	{ .exti = 22, .irq_parent = 34 },
+	{ .exti = 23, .irq_parent = 73 },
+	{ .exti = 24, .irq_parent = 93 },
+	{ .exti = 25, .irq_parent = 114 },
+	{ .exti = 26, .irq_parent = 38 },
+	{ .exti = 27, .irq_parent = 39 },
+	{ .exti = 28, .irq_parent = 40 },
+	{ .exti = 29, .irq_parent = 72 },
+	{ .exti = 30, .irq_parent = 53 },
+	{ .exti = 31, .irq_parent = 54 },
+	{ .exti = 32, .irq_parent = 83 },
+	{ .exti = 33, .irq_parent = 84 },
+	{ .exti = 44, .irq_parent = 96 },
+	{ .exti = 47, .irq_parent = 92 },
+	{ .exti = 48, .irq_parent = 116 },
+	{ .exti = 50, .irq_parent = 117 },
+	{ .exti = 52, .irq_parent = 118 },
+	{ .exti = 53, .irq_parent = 119 },
+	{ .exti = 68, .irq_parent = 63 },
+	{ .exti = 70, .irq_parent = 98 },
 };
 
 static const struct stm32_exti_drv_data stm32mp1_drv_data = {
@@ -711,6 +718,8 @@ static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
 	struct irq_fwspec p_fwspec;
 	irq_hw_number_t hwirq;
 	int bank;
+	u32 event_trg;
+	struct irq_chip *chip;
 
 	hwirq = fwspec->param[0];
 	if (hwirq >= host_data->drv_data->bank_nr * IRQS_PER_BANK)
@@ -724,8 +733,11 @@ static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
 	if (!desc)
 		return -EINVAL;
 
-	irq_domain_set_hwirq_and_chip(dm, virq, hwirq, desc->chip,
-				      chip_data);
+	event_trg = readl_relaxed(host_data->base + chip_data->reg_bank->trg_ofst);
+	chip = (event_trg & BIT(hwirq % IRQS_PER_BANK)) ?
+	       &stm32_exti_h_chip : &stm32_exti_h_chip_direct;
+
+	irq_domain_set_hwirq_and_chip(dm, virq, hwirq, chip, chip_data);
 	if (desc->irq_parent) {
 		p_fwspec.fwnode = dm->parent->fwnode;
 		p_fwspec.param_count = 3;
