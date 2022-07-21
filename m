Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793E757D646
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbiGUVvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbiGUVvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:51:51 -0400
Received: from luna (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net [86.15.83.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C0387234
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:51:50 -0700 (PDT)
Received: from ben by luna with local (Exim 4.96)
        (envelope-from <ben@luna.fluff.org>)
        id 1oEe5E-001y0G-2Z;
        Thu, 21 Jul 2022 22:51:48 +0100
From:   Ben Dooks <ben-linux@fluff.org>
To:     linux-kernel@vger.kernel.org
Cc:     maz@kernel.org, tglx@linutronix.de, Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH] irqchip/mmp: fix missing extern init code
Date:   Thu, 21 Jul 2022 22:51:47 +0100
Message-Id: <20220721215147.468971-1-ben-linux@fluff.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,FSL_HELO_NON_FQDN_1,
        HELO_NO_DOMAIN,KHOP_HELO_FCRDNS,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions icu_init_irq and mmp2_init_icu are exported
from this code, so declare them in the header file to avoid
the following sparse warnings:

drivers/irqchip/irq-mmp.c:248:13: warning: symbol 'icu_init_irq' was not declared. Should it be static?
drivers/irqchip/irq-mmp.c:271:13: warning: symbol 'mmp2_init_icu' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 include/linux/irqchip/mmp.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/irqchip/mmp.h b/include/linux/irqchip/mmp.h
index cb8455c87c8a..aa1813749a4f 100644
--- a/include/linux/irqchip/mmp.h
+++ b/include/linux/irqchip/mmp.h
@@ -4,4 +4,7 @@
 
 extern struct irq_chip icu_irq_chip;
 
+extern void icu_init_irq(void);
+extern void mmp2_init_icu(void);
+
 #endif	/* __IRQCHIP_MMP_H */
-- 
2.35.1

