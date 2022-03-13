Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F814D7258
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 04:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbiCMDqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 22:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiCMDqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 22:46:20 -0500
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A9D020191
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 19:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=K4DYT
        Yamw5W482/bqkvKLO28oQ2hPpAmTuktLI5/W5A=; b=ZjC8pkJDSBqR2pMtGd/9T
        jiCMmdr3w0NcTvjxpYfNanmNNMiFX2lDkUeGF+/+6NAnoIODWSyMQUoGKotFUkAR
        wWPIbOkjrUee6aXdlvroSskMmqhQmircGauh7OlC2DRttvwEkplBJExGM8CWhYqD
        N4s3NQXGz2Vy46ZIGvqemE=
Received: from localhost (unknown [113.116.156.254])
        by smtp10 (Coremail) with SMTP id DsCowABXnoGfaC1iaWA_BA--.17294S2;
        Sun, 13 Mar 2022 11:44:31 +0800 (CST)
From:   wudaemon <wudaemon@163.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, wudaemon <wudaemon@163.com>
Subject: [RESEND] genirq: add log level to printk in print_irq_desc
Date:   Sun, 13 Mar 2022 03:44:15 +0000
Message-Id: <20220313034415.4110-1-wudaemon@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowABXnoGfaC1iaWA_BA--.17294S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF48GF43Zw1DKrW8Cr45Wrg_yoW8Cw17pF
        y3Ja43JF48G3WUXayUA3Z5ury3Ca4UGrWUGFZ8CFWfWF1jgw4Fq3yay3yFgr4YqrWrZry3
        XF45W3sFka1rArUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piHKZdUUUUU=
X-Originating-IP: [113.116.156.254]
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/1tbisBXBbVUMSB6krwADsO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add KERN_DEBUG level for debuging purpose, use checkpatch.pl check prompt:
ERROR: Macros starting with if should be enclosed by a do - while loop to avoid possible if/else logic defects
so add do - while loop to Macros
Signed-off-by: wudaemon <wudaemon@163.com>
---
 kernel/irq/debug.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/irq/debug.h b/kernel/irq/debug.h
index 8ccb326d2977..ce0ec677bea0 100644
--- a/kernel/irq/debug.h
+++ b/kernel/irq/debug.h
@@ -3,8 +3,8 @@
  * Debugging printout:
  */
 
-#define ___P(f) if (desc->status_use_accessors & f) printk("%14s set\n", #f)
-#define ___PS(f) if (desc->istate & f) printk("%14s set\n", #f)
+#define ___P(f) do {if (desc->status_use_accessors & f) printk(KERN_DEBUG "%14s set\n", #f); } while (0)
+#define ___PS(f) do {if (desc->istate & f) printk(KERN_DEBUG "%14s set\n", #f); } while (0)
 /* FIXME */
 #define ___PD(f) do { } while (0)
 
@@ -15,15 +15,15 @@ static inline void print_irq_desc(unsigned int irq, struct irq_desc *desc)
 	if (!__ratelimit(&ratelimit))
 		return;
 
-	printk("irq %d, desc: %p, depth: %d, count: %d, unhandled: %d\n",
+	printk(KERN_DEBUG "irq %d, desc: %p, depth: %d, count: %d, unhandled: %d\n",
 		irq, desc, desc->depth, desc->irq_count, desc->irqs_unhandled);
-	printk("->handle_irq():  %p, %pS\n",
+	printk(KERN_DEBUG "->handle_irq():  %p, %pS\n",
 		desc->handle_irq, desc->handle_irq);
-	printk("->irq_data.chip(): %p, %pS\n",
+	printk(KERN_DEBUG "->irq_data.chip(): %p, %pS\n",
 		desc->irq_data.chip, desc->irq_data.chip);
-	printk("->action(): %p\n", desc->action);
+	printk(KERN_DEBUG "->action(): %p\n", desc->action);
 	if (desc->action) {
-		printk("->action->handler(): %p, %pS\n",
+		printk(KERN_DEBUG "->action->handler(): %p, %pS\n",
 			desc->action->handler, desc->action->handler);
 	}
 
-- 
2.25.1

