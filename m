Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C6754D8AD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 04:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353164AbiFPC4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 22:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354229AbiFPC4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 22:56:41 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73985A091;
        Wed, 15 Jun 2022 19:56:39 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y196so302969pfb.6;
        Wed, 15 Jun 2022 19:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C39oS/JXA4kYL1oQFrI4MpJXg8RAY2fTyeKeofIGePs=;
        b=js4aGzhoQvKvnrZgeaqVUFgEQGPqBRmsFAAG5y+bCfxg9L9x4qlAoZmCCq95jnjnnV
         QBMH3RihttvUH/x4Q3KWvLfDar0dSZNx3HI7Mo5bSvacmgcCUAEarJ73KWY5AlY5I6zM
         jpBm1+VS1YwnpGaZShD6bKM1G5amGUoYlCZefpK/qvtQDEYgYgKe/cyVX8KsCUDqJ3zH
         I1uZHeRZhWGzONFnh98D4tygpZrU3yuoWZqw4e4voQKyJLWWO0E8uLeLg9IKzGIOjCF6
         hSyCZl2Bb/BK5alMyiZZ0y3VJ2ejsOMLkFaz6O9eOjnUo4jZO1C87stMRb33D9Wfoqrx
         xMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C39oS/JXA4kYL1oQFrI4MpJXg8RAY2fTyeKeofIGePs=;
        b=5vuMbrfPeMyeM+qRfvkM8C03T3V/vrP+aaUGiq/3smcXbfGMoWeefnK5XFyZUklkgD
         6Qg4jSmgdUsFZf0uYIWDvLC1pDe07Y7QOXv2A6O3ynr0n5xnhtshLHtVPaXk3Br2i9Jf
         pvm+oMcAd50rcCCDc/3W8NAh3loBRtJRWBytfXWgDQz2V9bgbEErWOeuhAdQ21kbgqXU
         lbzz2DU74hd2kIRhWNnyVEZfR2GfcOShuRO7vlIvX4BKg4XaN0uHJ7MLvXEyg9INsbDw
         HlJmgnb8Y7naakzU1j2QhwxKbJwJfDRG6nrl4YQMye260ly66FN+Gr/SIcXsEFEqpulF
         Xlqg==
X-Gm-Message-State: AJIora9FZh5lto+swAE+w6JLeet9FVuIvS/8KadjmaF6VNakzB0UfNUs
        tCw8g7f0Eu1hLxB19K8pZdNr14dZUGiieHCFxVk=
X-Google-Smtp-Source: AGRyM1uUH7g7SHIf6vpotFH0NzOFWQRBrbtwP6vksHLLniC+ePrY1uAGvhT5qC6ug1qqxjeEbhUekQ==
X-Received: by 2002:aa7:9f84:0:b0:51b:b64d:fc69 with SMTP id z4-20020aa79f84000000b0051bb64dfc69mr2590049pfr.7.1655348199123;
        Wed, 15 Jun 2022 19:56:39 -0700 (PDT)
Received: from localhost ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id w1-20020a63a741000000b00404fd2138afsm349057pgo.40.2022.06.15.19.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 19:56:38 -0700 (PDT)
From:   Hongyu Xie <xy521521@gmail.com>
X-Google-Original-From: Hongyu Xie <xiehongyu1@kylinos.cn>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        125707942@qq.com, wangqi@kylinos.cn, xiongxin@kylinos.cn,
        Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: [PATCH v3 -next] usb: xhci: disable irq during initialization
Date:   Thu, 16 Jun 2022 10:56:34 +0800
Message-Id: <20220616025634.3693260-1-xiehongyu1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

irq is disabled in xhci_quiesce(called by xhci_halt, with bit:2 cleared
in USBCMD register), but xhci_run(called by usb_add_hcd) re-enable it.
It's possible that you will receive thousands of interrupt requests
after initialization for 2.0 roothub. And you will get a lot of
warning like, "xHCI dying, ignoring interrupt. Shouldn't IRQs be
disabled?". This amount of interrupt requests will cause the entire
system to freeze.
This problem was first found on a device with ASM2142 host controller
on it.

Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
---

v3:
- enabling interrupt right before setting Run/Stop bit
- spin_lock_irqsave to prevent receiving irqs in the small window
according to Mathias's suggestion
v2: fix compile error

 drivers/usb/host/xhci.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 9ac56e9ffc64..5cf8baa4f6f3 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -611,15 +611,40 @@ static int xhci_init(struct usb_hcd *hcd)
 
 static int xhci_run_finished(struct xhci_hcd *xhci)
 {
+	u32 temp;
+
+	/* Prevent receiving irqs in the small window between enabling interrupt
+	 * and setting Run/Stop bit
+	 */
+	spin_lock_irqsave(&xhci->lock, flags);
+
+	/* Enable interrupt right before setting Run/Stop bit according to spec
+	 * 4.2
+	 */
+	/* Set the HCD state before we enable the irqs */
+	temp = readl(&xhci->op_regs->command);
+	temp |= (CMD_EIE);
+	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
+			"// Enable interrupts, cmd = 0x%x.", temp);
+	writel(temp, &xhci->op_regs->command);
+
+	temp = readl(&xhci->ir_set->irq_pending);
+	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
+			"// %s %p by writing 0x%x %s",
+			"Enabling event ring interrupter",
+			"to irq_pending", xhci->ir_set,
+			(unsigned int) ER_IRQ_ENABLE(temp));
+	writel(ER_IRQ_ENABLE(temp), &xhci->ir_set->irq_pending);
 	if (xhci_start(xhci)) {
 		xhci_halt(xhci);
+		spin_unlock_irqrestore(&xhci->lock, flags);
 		return -ENODEV;
 	}
 	xhci->cmd_ring_state = CMD_RING_STATE_RUNNING;
 
 	if (xhci->quirks & XHCI_NEC_HOST)
 		xhci_ring_cmd_db(xhci);
-
+	spin_unlock_irqrestore(&xhci->lock, flags);
 	return 0;
 }
 
@@ -668,19 +693,6 @@ int xhci_run(struct usb_hcd *hcd)
 	temp |= (xhci->imod_interval / 250) & ER_IRQ_INTERVAL_MASK;
 	writel(temp, &xhci->ir_set->irq_control);
 
-	/* Set the HCD state before we enable the irqs */
-	temp = readl(&xhci->op_regs->command);
-	temp |= (CMD_EIE);
-	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
-			"// Enable interrupts, cmd = 0x%x.", temp);
-	writel(temp, &xhci->op_regs->command);
-
-	temp = readl(&xhci->ir_set->irq_pending);
-	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
-			"// Enabling event ring interrupter %p by writing 0x%x to irq_pending",
-			xhci->ir_set, (unsigned int) ER_IRQ_ENABLE(temp));
-	writel(ER_IRQ_ENABLE(temp), &xhci->ir_set->irq_pending);
-
 	if (xhci->quirks & XHCI_NEC_HOST) {
 		struct xhci_command *command;
 
-- 
2.25.1

