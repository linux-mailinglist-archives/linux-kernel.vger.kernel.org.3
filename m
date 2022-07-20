Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE9F57B567
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240509AbiGTL2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbiGTL1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:27:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F332054AF6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:27:40 -0700 (PDT)
Date:   Wed, 20 Jul 2022 11:27:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658316459;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hkGTu2jDHZ2PFn/uYvr1wRRpqjjdPyRNgcjseQpdRvo=;
        b=i1e8MGjNuSThuhG3IxZm4E8Ba83uQSI6w3wQCBPWxW7J/nCpqeA42sBY8fzQ/P2fTkTpdI
        BbZ5it7qM9lbhoifLePtDlq0EYclVmP15Val3h8spfHydXSyjxjtoZb5x6OF4v0WW0+2E0
        S0XgbAcoz1pILseccrknCq/onTW4hnG5nRbMq4FHGH5grpHlnINmZJieDT12AYQrqjjUgE
        HfoYaEV9gZvVrpejbyygkKQkM2mCboTWlHdnYd8tlyrFabZ0HVFeEMCbijohIUu/aevyK+
        tR2wiLBoJoo0whEuEFIQrbnXLWdpDmquVeNwZFYtHQez5iQRX4E+kL+DCx6Yag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658316459;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hkGTu2jDHZ2PFn/uYvr1wRRpqjjdPyRNgcjseQpdRvo=;
        b=tir8tXL7SqcymZXZ+nnCLvp0tzNpkdys8Gx/Niuh8Z8w0om9tapEA+CaGtwKWRLqvrwOWH
        rqmsS6sg9EBeMNBw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] ACPI: irq: Allow acpi_gsi_to_irq() to
 have an arch-specific fallback
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, Marc Zyngier <maz@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>, tglx@linutronix.de
In-Reply-To: <1658314292-35346-4-git-send-email-lvjianmin@loongson.cn>
References: <1658314292-35346-4-git-send-email-lvjianmin@loongson.cn>
MIME-Version: 1.0
Message-ID: <165831645831.15455.17329614509617059533.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     744b9a0c3c8334d705dea6af3645ea30d597c360
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/744b9a0c3c8334d705dea6af3645ea30d597c360
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 20 Jul 2022 18:51:22 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 20 Jul 2022 12:05:17 +01:00

ACPI: irq: Allow acpi_gsi_to_irq() to have an arch-specific fallback

It appears that the generic version of acpi_gsi_to_irq() doesn't
fallback to establishing a mapping if there is no pre-existing
one while the x86 version does.

While arm64 seems unaffected by it, LoongArch is relying on the x86
behaviour. In an effort to prevent new architectures from reinventing
the proverbial wheel, provide an optional callback that the arch code
can set to restore the x86 behaviour.

Hopefully we can eventually get rid of this in the future once
the expected behaviour has been clarified.

Reported-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Tested-by: Hanjun Guo <guohanjun@huawei.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Link: https://lore.kernel.org/r/1658314292-35346-4-git-send-email-lvjianmin@loongson.cn
---
 drivers/acpi/irq.c   | 18 ++++++++++++++++--
 include/linux/acpi.h |  1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index f0de768..dabe45e 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -13,6 +13,7 @@
 enum acpi_irq_model_id acpi_irq_model;
 
 static struct fwnode_handle *(*acpi_get_gsi_domain_id)(u32 gsi);
+static u32 (*acpi_gsi_to_irq_fallback)(u32 gsi);
 
 /**
  * acpi_gsi_to_irq() - Retrieve the linux irq number for a given GSI
@@ -32,9 +33,12 @@ int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
 					DOMAIN_BUS_ANY);
 	*irq = irq_find_mapping(d, gsi);
 	/*
-	 * *irq == 0 means no mapping, that should
-	 * be reported as a failure
+	 * *irq == 0 means no mapping, that should be reported as a
+	 * failure, unless there is an arch-specific fallback handler.
 	 */
+	if (!*irq && acpi_gsi_to_irq_fallback)
+		*irq = acpi_gsi_to_irq_fallback(gsi);
+
 	return (*irq > 0) ? 0 : -EINVAL;
 }
 EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
@@ -302,6 +306,16 @@ void __init acpi_set_irq_model(enum acpi_irq_model_id model,
 }
 
 /**
+ * acpi_set_gsi_to_irq_fallback - Register a GSI transfer
+ * callback to fallback to arch specified implementation.
+ * @fn: arch-specific fallback handler
+ */
+void __init acpi_set_gsi_to_irq_fallback(u32 (*fn)(u32))
+{
+	acpi_gsi_to_irq_fallback = fn;
+}
+
+/**
  * acpi_irq_create_hierarchy - Create a hierarchical IRQ domain with the default
  *                             GSI domain as its parent.
  * @flags:      Irq domain flags associated with the domain
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 957e23f..e2b60d5 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -357,6 +357,7 @@ int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 *gsi);
 
 void acpi_set_irq_model(enum acpi_irq_model_id model,
 			struct fwnode_handle *(*)(u32));
+void acpi_set_gsi_to_irq_fallback(u32 (*)(u32));
 
 struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
 					     unsigned int size,
