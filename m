Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7632E4F139E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 13:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359322AbiDDLMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 07:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359282AbiDDLMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 07:12:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 996B53B54F;
        Mon,  4 Apr 2022 04:10:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5010BD6E;
        Mon,  4 Apr 2022 04:10:17 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.196.172])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC8853F718;
        Mon,  4 Apr 2022 04:10:15 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] irqchip/gic/gic-v3: prevent GSI to SGI translations
Date:   Mon,  4 Apr 2022 12:08:42 +0100
Message-Id: <20220404110842.2882446-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment the GIC IRQ domain translation routine happily converts
ACPI table GSI numbers below 16 to GIC SGIs (Software Generated
Interrupts aka IPIs). On the Devicetree side we explicitly forbid this
translation, actually the function will never return HWIRQs below 16 when
using a DT based domain translation.

We expect SGIs to be handled in the first part of the function, and any
further occurrence should be treated as a firmware bug, so add a check
and print to report this explicitly and avoid lengthy debug sessions.

Fixes: 64b499d8df40 ("irqchip/gic-v3: Configure SGIs as standard interrupts")
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
Hi,

marking this as an RFC because:
- I don't know if we really can forbid IPIs in ACPI tables. We certainly
  pushed back against this multiple times on the DT side.
- I don't know if this is the right place to filter this out.

This was triggered by an SSDT table wrongly containing an interrupt
resource entry of "0", for a debug UART without an interrupt line
connected [1] (about to be fixed). This overwrote the IPI0 trigger method
to "level", which prevented SGI0 to be enabled again *after* a CPU
offline/online cycle.
It required some debugging to find this firmware problem, so I am
proposing an explicit error message, and to actually deny registering
this interrupt.

[1] https://github.com/tianocore/edk2-platforms/blob/master/Platform/ARM/Morello/ConfigurationManager/ConfigurationManagerDxe/ConfigurationManager.c#L150-L157

Cheers,
Andre

 drivers/irqchip/irq-gic-v3.c | 6 ++++++
 drivers/irqchip/irq-gic.c    | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 0efe1a9a9f3b..c946ef3067d2 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1466,6 +1466,12 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 		if(fwspec->param_count != 2)
 			return -EINVAL;
 
+		if (fwspec->param[0] < 16) {
+			pr_err(FW_BUG "Illegal GSI%d translation request\n",
+			       fwspec->param[0]);
+			return -EINVAL;
+		}
+
 		*hwirq = fwspec->param[0];
 		*type = fwspec->param[1];
 
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 58ba835bee1f..09c710ecc387 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1123,6 +1123,12 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 		if(fwspec->param_count != 2)
 			return -EINVAL;
 
+		if (fwspec->param[0] < 16) {
+			pr_err(FW_BUG "Illegal GSI%d translation request\n",
+			       fwspec->param[0]);
+			return -EINVAL;
+		}
+
 		*hwirq = fwspec->param[0];
 		*type = fwspec->param[1];
 
-- 
2.25.1

