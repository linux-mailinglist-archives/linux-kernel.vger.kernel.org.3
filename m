Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB9F57D63F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbiGUVpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGUVpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:45:51 -0400
Received: from luna (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net [86.15.83.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60A617E1D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:45:49 -0700 (PDT)
Received: from ben by luna with local (Exim 4.96)
        (envelope-from <ben@luna.fluff.org>)
        id 1oEdzP-001uuG-2X;
        Thu, 21 Jul 2022 22:45:47 +0100
From:   Ben Dooks <ben-linux@fluff.org>
To:     linux-kernel@vger.kernel.org
Cc:     maz@kernel.org, tglx@linutronix.de, Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH] irqchip/mmp: fix missing include of <linux/irqchip/mmp.h>
Date:   Thu, 21 Jul 2022 22:45:47 +0100
Message-Id: <20220721214547.457049-1-ben-linux@fluff.org>
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

The icu_irq_chip is deifned in <linux/irqchip/mmp.h> but the
irq-mmp.c does not include this to get the definition of this
symbol. Include the header to fix the following sparse warning:

drivers/irqchip/irq-mmp.c:139:17: warning: symbol 'icu_irq_chip' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 drivers/irqchip/irq-mmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index 83455ca72439..dcc30bee572e 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -14,6 +14,7 @@
 #include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/irqchip/mmp.h>
 #include <linux/irqdomain.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
-- 
2.35.1

