Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF674585E63
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 11:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbiGaJzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 05:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236677AbiGaJzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 05:55:46 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFD6DF05
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 02:55:43 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id I5ffoCl2cClE7I5ffoBjBq; Sun, 31 Jul 2022 11:55:41 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 31 Jul 2022 11:55:41 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Lee Jones <lee@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>,
        Milo Kim <Milo.Kim@ti.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] mfd: lp8788: Fix an error handling path in lp8788_irq_init() and lp8788_irq_init()
Date:   Sun, 31 Jul 2022 11:55:38 +0200
Message-Id: <bcd5a72c9c1c383dd6324680116426e32737655a.1659261275.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <18398722da9df9490722d853e4797350189ae79b.1659261275.git.christophe.jaillet@wanadoo.fr>
References: <18398722da9df9490722d853e4797350189ae79b.1659261275.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In lp8788_irq_init(), if an error occurs after a successful
irq_domain_add_linear() call, it must be undone by a corresponding
irq_domain_remove() call.

irq_domain_remove() should also be called in lp8788_irq_exit() for the same
reason.

Fixes: eea6b7cc53aa ("mfd: Add lp8788 mfd driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/mfd/lp8788-irq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/lp8788-irq.c b/drivers/mfd/lp8788-irq.c
index 348439a3fbbd..39006297f3d2 100644
--- a/drivers/mfd/lp8788-irq.c
+++ b/drivers/mfd/lp8788-irq.c
@@ -175,6 +175,7 @@ int lp8788_irq_init(struct lp8788 *lp, int irq)
 				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				"lp8788-irq", irqd);
 	if (ret) {
+		irq_domain_remove(lp->irqdm);
 		dev_err(lp->dev, "failed to create a thread for IRQ_N\n");
 		return ret;
 	}
@@ -188,4 +189,6 @@ void lp8788_irq_exit(struct lp8788 *lp)
 {
 	if (lp->irq)
 		free_irq(lp->irq, lp->irqdm);
+	if (lp->irqdm)
+		irq_domain_remove(lp->irqdm);
 }
-- 
2.34.1

