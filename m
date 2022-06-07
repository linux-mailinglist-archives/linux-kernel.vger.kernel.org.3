Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC1A53F7EF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238072AbiFGIL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiFGILY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:11:24 -0400
Received: from mail-m17635.qiye.163.com (mail-m17635.qiye.163.com [59.111.176.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306C1B0A76
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 01:11:22 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPV6:240e:36a:1490:f100:dfad:59db:22ac:33c8])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id DF55740063E;
        Tue,  7 Jun 2022 16:11:18 +0800 (CST)
From:   Yupeng Li <liyupeng@zbhlos.com>
To:     chenhc@lemote.com, ralf@linux-mips.org, paul.burton@mips.com,
        jhogan@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        caizp2008@163.com, Yupeng Li <liyupeng@zbhlos.com>
Subject: [PATCH 1/1] MIPS: Replace setup_irq() by request_irq()
Date:   Tue,  7 Jun 2022 16:11:06 +0800
Message-Id: <20220607081106.3999978-1-liyupeng@zbhlos.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRkdSkNWGhpJH0JMHU8dQk
        wZVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktITUpVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MAg6Lxw5GT0yVhBRHzAaKDQt
        HxwKCTRVSlVKTU5PTkNCT0NLTkpMVTMWGhIXVRcSAg4LHhUcOwEZExcUCFUYFBZFWVdZEgtZQVlJ
        T0seQUhNGkFKT0JLQR1KS0tBHx0aH0FOQh8ZQUlJGhhBSEgYQ1lXWQgBWUFIS09JNwY+
X-HM-Tid: 0a813d37dccdd991kuwsdf55740063e
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit ac8fd122e070 ("MIPS: Replace setup_irq() by request_irq()")

request_irq() is preferred over setup_irq(). Invocations of setup_irq()
occur after memory allocators are ready.

Per tglx[1], setup_irq() existed in olden days when allocators were not
ready by the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

remove_irq() has been replaced by free_irq() as well.

There were build error's during previous version, couple of which was
reported by kbuild test robot <lkp@intel.com> of which one was reported
by Thomas Bogendoerfer <tsbogend@alpha.franken.de> as well. There were a
few more issues including build errors, those also have been fixed.

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos

Signed-off-by: Yupeng Li <liyupeng@zbhlos.com>
---
 arch/mips/loongson64/loongson-3/hpet.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/mips/loongson64/loongson-3/hpet.c b/arch/mips/loongson64/loongson-3/hpet.c
index ed15430ad64f..e4282592575b 100644
--- a/arch/mips/loongson64/loongson-3/hpet.c
+++ b/arch/mips/loongson64/loongson-3/hpet.c
@@ -187,12 +187,6 @@ static irqreturn_t hpet_irq_handler(int irq, void *data)
 	return IRQ_NONE;
 }
 
-static struct irqaction hpet_irq = {
-	.handler = hpet_irq_handler,
-	.flags = IRQF_NOBALANCING | IRQF_TIMER,
-	.name = "hpet",
-};
-
 /*
  * hpet address assignation and irq setting should be done in bios.
  * but pmon don't do this, we just setup here directly.
@@ -224,6 +218,7 @@ static void hpet_setup(void)
 
 void __init setup_hpet_timer(void)
 {
+	unsigned long flags = IRQF_NOBALANCING | IRQF_TIMER;
 	unsigned int cpu = smp_processor_id();
 	struct clock_event_device *cd;
 
@@ -247,7 +242,8 @@ void __init setup_hpet_timer(void)
 	cd->min_delta_ticks = HPET_MIN_PROG_DELTA;
 
 	clockevents_register_device(cd);
-	setup_irq(HPET_T0_IRQ, &hpet_irq);
+	if (request_irq(HPET_T0_IRQ, hpet_irq_handler, flags, "hpet", NULL))
+		pr_err("Failed to request irq %d (hpet)\n", HPET_T0_IRQ);
 	pr_info("hpet clock event device register\n");
 }
 
-- 
2.34.1

