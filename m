Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B51B54DC77
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359617AbiFPIJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359243AbiFPIJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:09:45 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45A85A5A6;
        Thu, 16 Jun 2022 01:09:43 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x138so817178pfc.12;
        Thu, 16 Jun 2022 01:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dF+FiY5h3wouB9f0tCwxYbSd00JgHDWKLOSIO3vQJDs=;
        b=fMnIE6XMuy/mi5+plbtPUkHoZslY1IwsfG61DD97ZGy3MrnGf+fMrEwuMAW5vWdW/n
         SJ2DkVTlkIQLA+0HVKoXXxCib9NXAowfmdWWCWV/IZgsLelwyYrjVMSTW45A0VpJUrvo
         DR0hvikJSqIE3/AlJhOaQMhdV4I1lBbrzT/OD77FJ6FkZqcoHf6dhfaS8pJE6WMkn5Be
         p26EwaOGs9cz0x4R+DTsx0wJduu0Vc5W+W5+B1pfQ4bqCMsPQ3MCO6izyt1pwZaX29+6
         fib3yE74R3uCt6Pb9tDWcSoRFOR0WxIOFGxg4SHHSJeap0OwRGq8ktTf6+DGHKPvsgYC
         kBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dF+FiY5h3wouB9f0tCwxYbSd00JgHDWKLOSIO3vQJDs=;
        b=3u4tTjErY2KM7j/XCeJo7xpvdstGVZmCrPws0ssDMiCnkU++mP96ZAztjkIoUIPCm9
         3op/vcYjDOy/rvbZSXaa5Zi5fngNI/lx8PEIhKJgmWz7E/vTsNvWhk9u+ifd2VD5KBqw
         zOx8JCZ/tCfwsy4eoiOx1X2npteG4AajJS8elDTxF8P6JkPlqO0b2gz7r/cGb9bMj+pR
         jQkMPqH0WC/ZwwctYC0uQ+jBKlg5S6vPn062a9Rqc+oExeRbNwvs0EpDBN6fyDW1cGJn
         RjJHfuziPpE1mQh7HU2KCdfwpQLgpJQdFLLgbDywZTsOKvDghM1dA/27Jy2o18WL4+HD
         dMBA==
X-Gm-Message-State: AJIora95m7y2ZoInYi7hVpi7uw7shrhleYoWhgy5WKGSSdC6TR1TjVmD
        xlS6GFYSqfRfoIuVwRlLieI=
X-Google-Smtp-Source: AGRyM1vK8BMU+3szTuwEYO0HargDw4rk4y0Eq5yXQxHIQO1DeMUv3bzg5YwmwLT1JeaISqjDaGiRaA==
X-Received: by 2002:a63:9142:0:b0:3fc:c021:e237 with SMTP id l63-20020a639142000000b003fcc021e237mr3430332pge.279.1655366983401;
        Thu, 16 Jun 2022 01:09:43 -0700 (PDT)
Received: from localhost ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id nk10-20020a17090b194a00b001e2f53e1042sm3211009pjb.7.2022.06.16.01.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 01:09:42 -0700 (PDT)
From:   Hongyu Xie <xy521521@gmail.com>
X-Google-Original-From: Hongyu Xie <xiehongyu1@kylinos.cn>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        125707942@qq.com, wangqi@kylinos.cn, xiongxin@kylinos.cn,
        Hongyu Xie <xiehongyu1@kylinos.cn>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v4 -next] usb: xhci: disable irq during initialization
Date:   Thu, 16 Jun 2022 16:09:33 +0800
Message-Id: <20220616080933.1238309-1-xiehongyu1@kylinos.cn>
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
Reported-by: kernel test robot <lkp@intel.com>
---

v4: add definition for flags
v3:
- enabling interrupt right before setting Run/Stop bit
- spin_lock_irqsave to prevent receiving irqs in the small window
according to Mathias's suggestion
v2: fix compile error

 drivers/usb/host/xhci.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 9ac56e9ffc64..1344cc566338 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -611,15 +611,41 @@ static int xhci_init(struct usb_hcd *hcd)
 
 static int xhci_run_finished(struct xhci_hcd *xhci)
 {
+	unsigned long flags;
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
 
@@ -668,19 +694,6 @@ int xhci_run(struct usb_hcd *hcd)
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

