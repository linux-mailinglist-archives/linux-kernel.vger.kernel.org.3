Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30045A9A4D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbiIAO20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiIAO2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:28:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF305A2D3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:28:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1850E61D0C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 14:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B3BC433C1;
        Thu,  1 Sep 2022 14:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662042501;
        bh=gu2akoPgYWzpicAL/pzg4dqNYqYhVCGE9d7HIK3+bcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n5IOoG6JwbWKl2iQZZNH9mEcv6LS/o8JQXfchSR0sLqknX6MA20hEsUt0rCcXMQMK
         iouIaw/5tombY2bwj9mSw8ZezY530FESbdgTaOLd6ax0pa5RTcv1lhPXPf1kVWJGBw
         ZhoC90NocFZzXmnxpcgubcGzW2dbcBL5sdgjjSiQG/SGTSDEPybIq0gbi/DOYNCtej
         kKPEu50HuQOvkJt00vfEogfN1ZwPu2HmH0VMyF2cDAQFkIT/KHjjSXg9lZPMjW6+Rw
         0J4MQhD3pbVvsBCMAp8eMHQBpo23txlIS7ysYJuInn/o5NGAHCbHjOdfZibFgUVqRV
         IClj412A+wQrQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oTlB9-0003Zs-1a; Thu, 01 Sep 2022 16:28:23 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 3/4] irqdomain: Fix domain-association race
Date:   Thu,  1 Sep 2022 16:28:15 +0200
Message-Id: <20220901142816.13731-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220901142816.13731-1-johan+linaro@kernel.org>
References: <20220901142816.13731-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check for an already mapped virq was done outside of the
irq_domain_mutex-protected section which meant that an (unlikely) racing
association may not be detected.

Fix this by factoring out the association implementation, which will
also be used in follow-on changes to clean up the locking.

Fixes: ddaf144c61da ("irqdomain: Refactor irq_domain_associate_many()")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 kernel/irq/irqdomain.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 1af1d141e165..9f3203e180c5 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -560,8 +560,8 @@ static void irq_domain_disassociate(struct irq_domain *domain, unsigned int irq)
 	irq_domain_clear_mapping(domain, hwirq);
 }
 
-int irq_domain_associate(struct irq_domain *domain, unsigned int virq,
-			 irq_hw_number_t hwirq)
+static int __irq_domain_associate(struct irq_domain *domain, unsigned int virq,
+				  irq_hw_number_t hwirq)
 {
 	struct irq_data *irq_data = irq_get_irq_data(virq);
 	int ret;
@@ -574,7 +574,6 @@ int irq_domain_associate(struct irq_domain *domain, unsigned int virq,
 	if (WARN(irq_data->domain, "error: virq%i is already associated", virq))
 		return -EINVAL;
 
-	mutex_lock(&irq_domain_mutex);
 	irq_data->hwirq = hwirq;
 	irq_data->domain = domain;
 	if (domain->ops->map) {
@@ -591,7 +590,6 @@ int irq_domain_associate(struct irq_domain *domain, unsigned int virq,
 			}
 			irq_data->domain = NULL;
 			irq_data->hwirq = 0;
-			mutex_unlock(&irq_domain_mutex);
 			return ret;
 		}
 
@@ -602,12 +600,23 @@ int irq_domain_associate(struct irq_domain *domain, unsigned int virq,
 
 	domain->mapcount++;
 	irq_domain_set_mapping(domain, hwirq, irq_data);
-	mutex_unlock(&irq_domain_mutex);
 
 	irq_clear_status_flags(virq, IRQ_NOREQUEST);
 
 	return 0;
 }
+
+int irq_domain_associate(struct irq_domain *domain, unsigned int virq,
+			 irq_hw_number_t hwirq)
+{
+	int ret;
+
+	mutex_lock(&irq_domain_mutex);
+	ret = __irq_domain_associate(domain, virq, hwirq);
+	mutex_unlock(&irq_domain_mutex);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(irq_domain_associate);
 
 void irq_domain_associate_many(struct irq_domain *domain, unsigned int irq_base,
-- 
2.35.1

