Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E014C290C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 11:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbiBXKNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 05:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbiBXKNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:13:05 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C80013AA30;
        Thu, 24 Feb 2022 02:12:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C8A5ECE1E46;
        Thu, 24 Feb 2022 10:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3234CC340F8;
        Thu, 24 Feb 2022 10:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645697552;
        bh=ZtLfo26jT/bIFMFsWcHW86soigSIb26d5K3SfwTXhkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H+QWNOF+ofgTmOKYgx/thfjFiUUhd+MNt0sEeC7SaxpfKeBoVvOpySlw6nCNSZjNQ
         EDCMNHq9OuOwSh6Tgw9Kruc+StHKYHYvP2K1SmOtTTsoIBsKq1RvEZYyQhJkyYv3rs
         NxjTE3OjVLqI1cwNz6TGREht16z17Q8O9NE9vXESs4da4a/UFwpSyJcr6olB2GEZGS
         g97gxHiKRLbpwy8aZPjHPJBImTzix9eVi/w9DH+sblbmFNxJbCvN+X7MzXoGMc3xrC
         odFkzlqyROXLA7g6926LeSCgRVE1ddYrqjf2MWpdiMh9bS9wGWHIp92mXQFqQbYxNl
         /P2p+tYx7HQsw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nNB6s-00A979-2T; Thu, 24 Feb 2022 10:12:30 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 5/5] irqchip/qcom-pdc: Drop open coded version of __assign_bit()
Date:   Thu, 24 Feb 2022 10:12:26 +0000
Message-Id: <20220224101226.88373-6-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220224101226.88373-1-maz@kernel.org>
References: <20220224101226.88373-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, agross@kernel.org, bjorn.andersson@linaro.org, tglx@linutronix.de, linux-arm-msm@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver uses what looks like an open-coded version of __assign_bit().
Replace it with the real thing.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/qcom-pdc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 0cd20ddfae2a..d96916cf6a41 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -23,9 +23,6 @@
 
 #define PDC_MAX_GPIO_IRQS	256
 
-#define CLEAR_INTR(reg, intr)	(reg & ~(1 << intr))
-#define ENABLE_INTR(reg, intr)	(reg | (1 << intr))
-
 #define IRQ_ENABLE_BANK		0x10
 #define IRQ_i_CFG		0x110
 
@@ -55,16 +52,16 @@ static u32 pdc_reg_read(int reg, u32 i)
 static void pdc_enable_intr(struct irq_data *d, bool on)
 {
 	int pin_out = d->hwirq;
+	unsigned long enable;
 	unsigned long flags;
 	u32 index, mask;
-	u32 enable;
 
 	index = pin_out / 32;
 	mask = pin_out % 32;
 
 	raw_spin_lock_irqsave(&pdc_lock, flags);
 	enable = pdc_reg_read(IRQ_ENABLE_BANK, index);
-	enable = on ? ENABLE_INTR(enable, mask) : CLEAR_INTR(enable, mask);
+	__assign_bit(mask, &enable, on);
 	pdc_reg_write(IRQ_ENABLE_BANK, index, enable);
 	raw_spin_unlock_irqrestore(&pdc_lock, flags);
 }
-- 
2.30.2

