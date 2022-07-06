Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B01568C76
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbiGFPQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiGFPQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:16:09 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A28723151;
        Wed,  6 Jul 2022 08:16:08 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6BD662223A;
        Wed,  6 Jul 2022 17:16:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657120565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AlO8fxYi1tcYG3PxFb6I4+tm+M3TQCtA0dFAdu++K04=;
        b=LQ/Dx3Qx6igB9fnrGf0DI5PEx38/eHhrJOG/hlwE+hR8svh+D4u7n59GutX2kRQGvITCWx
        HXwnzOVzK46ug6zMsUOm4wABz9M/s/JOdS1WCOR9Z/XqU4H0doAURob5br/jJWL917dZc6
        n+7up2XgIEB3e+LWFccaJfYdeaFcCCg=
From:   Michael Walle <michael@walle.cc>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 1/2] genirq: allow irq_set_chip_handler_name_locked() to take a const irq_chip
Date:   Wed,  6 Jul 2022 17:15:52 +0200
Message-Id: <20220706151553.1580790-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit 393e1280f765 ("genirq: Allow irq_chip registration
functions to take a const irq_chip"), allow the
irq_set_chip_handler_name_locked() function to take a const irq_chip
argument.

Signed-off-by: Michael Walle <michael@walle.cc>
---
Given this is the correct approach, can this go through the pinctrl tree?
Of not, do we need an immutable tag?

 include/linux/irqdesc.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index a77584593f7d..1cd4e36890fb 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -209,14 +209,15 @@ static inline void irq_set_handler_locked(struct irq_data *data,
  * Must be called with irq_desc locked and valid parameters.
  */
 static inline void
-irq_set_chip_handler_name_locked(struct irq_data *data, struct irq_chip *chip,
+irq_set_chip_handler_name_locked(struct irq_data *data,
+				 const struct irq_chip *chip,
 				 irq_flow_handler_t handler, const char *name)
 {
 	struct irq_desc *desc = irq_data_to_desc(data);
 
 	desc->handle_irq = handler;
 	desc->name = name;
-	data->chip = chip;
+	data->chip = (struct irq_chip *)chip;
 }
 
 bool irq_check_status_bit(unsigned int irq, unsigned int bitmask);
-- 
2.30.2

