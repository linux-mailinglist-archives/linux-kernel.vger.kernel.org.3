Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF5050DEF4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239633AbiDYLlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbiDYLk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:40:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8952611A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 04:37:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94A08B815FA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2CAC385A4;
        Mon, 25 Apr 2022 11:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650886673;
        bh=oqcziTyHbgjccGI9JX/gmEGkDXbZaGKaCKgkgdQx71I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vn0VqbbQK6rr7q29cSfjgqHcJ77SnH1CCKo/lhC2H36LWEDEpEm14NHMLomloSMiV
         tTxt7yxXlgZNNL24WJFRkT/7/AzkhPL/dH8qNsVllCE3JYuVR/Jn7FHGUlLb1UFXXR
         SMo+eglUeiT8JpsdL6jqhpO8xIiWk27fcZZxcOkyOSyMJ8Q64J9t+X5yRK0wvlY3A3
         Napgz9q9AMC3iNwTO1NxsLSDa9COFoBK4qC7qxKae/kHHLQzEpSoVha69Hf4prIRSu
         q4km1oxjwd9rNmwvVpU/ASxsF3/l8yyz7DQBcv8r4k2Nd8FkiVzxYrMNpIhxMWYhaI
         RJl/d9weBlqBw==
Received: by pali.im (Postfix)
        id CB2494A44; Mon, 25 Apr 2022 13:37:50 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] irqchip/armada-370-xp: Do not allow mapping IRQ 0 and 1
Date:   Mon, 25 Apr 2022 13:37:06 +0200
Message-Id: <20220425113706.29310-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220425113706.29310-1-pali@kernel.org>
References: <20220425113706.29310-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRQs 0 and 1 cannot be mapped, they are handled internally by this driver
and this driver does not call generic_handle_domain_irq() for these IRQs.
So do not allow mapping these IRQs and correctly propagate error from the
.irq_map callback.

Signed-off-by: Pali Rohár <pali@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/irqchip/irq-armada-370-xp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 1120084cba09..ebd76ea1c69b 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -546,6 +546,10 @@ static struct irq_chip armada_370_xp_irq_chip = {
 static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
 				      unsigned int virq, irq_hw_number_t hw)
 {
+	/* IRQs 0 and 1 cannot be mapped, they are handled internally */
+	if (hw <= 1)
+		return -EINVAL;
+
 	armada_370_xp_irq_mask(irq_get_irq_data(virq));
 	if (!is_percpu_irq(hw))
 		writel(hw, per_cpu_int_base +
-- 
2.20.1

