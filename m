Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0E34C2900
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 11:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbiBXKNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 05:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbiBXKNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:13:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A760AC992F;
        Thu, 24 Feb 2022 02:12:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EABDB82354;
        Thu, 24 Feb 2022 10:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76A9C340F4;
        Thu, 24 Feb 2022 10:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645697551;
        bh=1P5kYNK0inw6c83XhTJAHu36iAxTv1EUCPZswN00cPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=chV/K20lZ6/kqvnMaAEE2pmx3jHbqACH6fdoyNLDqPWPjXvFR+d4qHslnQpKgL0gI
         /7bPzNwlDYksaayGjwUbnRaVQwrFzF0fmCcnDRN3Qua0C6VUd7teGYZ0qXy+YgW2EQ
         NcZglRuJ9v3SXya/P1C6g65E1GKu2xzAfyG+qqcn+i8W0hrXiBPS1WbWfCaF0u+6L3
         kHcc3M+SSlh9FoWXg++sLN/XtGtPEdG4qQoQTMQ29da+iau4g+SMDXbAY6RumfGbd/
         GzN5ZUU3VRIT137CqxpiMG8MplvwPLaf8IkZ6dt0iwVYjY+XvDqe8ylOuKliYiU1qx
         1PkpnkS+2xIYw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nNB6r-00A979-N6; Thu, 24 Feb 2022 10:12:29 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 3/5] irqchip/qcom-pdc: Kill qcom_pdc_translate helper
Date:   Thu, 24 Feb 2022 10:12:24 +0000
Message-Id: <20220224101226.88373-4-maz@kernel.org>
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

qcom_pdc_translate() really is nothing but an open coded version
of irq_domain_translate_twocell(). Get rid of it and use the common
version instead.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/qcom-pdc.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 5be531403f50..837ca6998f6a 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -198,21 +198,6 @@ static struct pdc_pin_region *get_pin_region(int pin)
 	return NULL;
 }
 
-static int qcom_pdc_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
-			      unsigned long *hwirq, unsigned int *type)
-{
-	if (is_of_node(fwspec->fwnode)) {
-		if (fwspec->param_count != 2)
-			return -EINVAL;
-
-		*hwirq = fwspec->param[0];
-		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
 static int qcom_pdc_alloc(struct irq_domain *domain, unsigned int virq,
 			  unsigned int nr_irqs, void *data)
 {
@@ -223,7 +208,7 @@ static int qcom_pdc_alloc(struct irq_domain *domain, unsigned int virq,
 	unsigned int type;
 	int ret;
 
-	ret = qcom_pdc_translate(domain, fwspec, &hwirq, &type);
+	ret = irq_domain_translate_twocell(domain, fwspec, &hwirq, &type);
 	if (ret)
 		return ret;
 
@@ -256,7 +241,7 @@ static int qcom_pdc_alloc(struct irq_domain *domain, unsigned int virq,
 }
 
 static const struct irq_domain_ops qcom_pdc_ops = {
-	.translate	= qcom_pdc_translate,
+	.translate	= irq_domain_translate_twocell,
 	.alloc		= qcom_pdc_alloc,
 	.free		= irq_domain_free_irqs_common,
 };
-- 
2.30.2

