Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868F94C290A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 11:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbiBXKNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 05:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbiBXKNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:13:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502DE139CF8;
        Thu, 24 Feb 2022 02:12:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EE106130A;
        Thu, 24 Feb 2022 10:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011ACC340F6;
        Thu, 24 Feb 2022 10:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645697552;
        bh=GvBeGbRM9lOucS8iJkQ3NSS2HPWOy7uTkLQW2AEW4BI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GzGhMGFyUvoyE+Yip5PuayyHm6OWDkFf1GI1lWlyz+jmb+c6CtOq8RNOEuC5Wfh1l
         atvVxbZOHMN6Xdart0Zt8x4cRfani+6UlxsVgeUVgtDjQvTKVLjtShoI2gdTmIvrOP
         jAJIY6idec6Cdps+gE4VV16Sgb25qrElXnNQhE98Wif6Db2wSsg4HJtEBJXSgE/VCJ
         Lo5TH8Pl+SOQSJcbP0BrLHHN0htZt3yYnNLKdVbKFzyYnPbq21MU2ePEuiSTkbtXd3
         9wWkwVMrVo6DQK9KVrlsBnGKdg4YM1OUIpiXQQy0qZEZVUrM/QJ0Y3PrxJHbXLi7oZ
         GA8pavuitg+MA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nNB6r-00A979-TI; Thu, 24 Feb 2022 10:12:29 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 4/5] irqchip/qcom-pdc: Fix broken locking
Date:   Thu, 24 Feb 2022 10:12:25 +0000
Message-Id: <20220224101226.88373-5-maz@kernel.org>
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

pdc_enable_intr() serves as a primitive to qcom_pdc_gic_{en,dis}able,
and has a raw spinlock for mutual exclusion, which is uses with
interruptible primitives.

This means that this critical section can itself be interrupted.
Should the interrupt also be a PDC interrupt, and the endpoint driver
perform an irq_disable() on that interrupt, we end-up in a deadlock.

Fix this by using the irqsave/irqrestore variants of the locking
primitives.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/qcom-pdc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 837ca6998f6a..0cd20ddfae2a 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -55,17 +55,18 @@ static u32 pdc_reg_read(int reg, u32 i)
 static void pdc_enable_intr(struct irq_data *d, bool on)
 {
 	int pin_out = d->hwirq;
+	unsigned long flags;
 	u32 index, mask;
 	u32 enable;
 
 	index = pin_out / 32;
 	mask = pin_out % 32;
 
-	raw_spin_lock(&pdc_lock);
+	raw_spin_lock_irqsave(&pdc_lock, flags);
 	enable = pdc_reg_read(IRQ_ENABLE_BANK, index);
 	enable = on ? ENABLE_INTR(enable, mask) : CLEAR_INTR(enable, mask);
 	pdc_reg_write(IRQ_ENABLE_BANK, index, enable);
-	raw_spin_unlock(&pdc_lock);
+	raw_spin_unlock_irqrestore(&pdc_lock, flags);
 }
 
 static void qcom_pdc_gic_disable(struct irq_data *d)
-- 
2.30.2

