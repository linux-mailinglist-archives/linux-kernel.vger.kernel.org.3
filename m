Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D416954DD08
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359572AbiFPIjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiFPIi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:38:58 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05935D64F;
        Thu, 16 Jun 2022 01:38:57 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id w29so631746pgl.8;
        Thu, 16 Jun 2022 01:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X3rs3EZNUK5eXVTg1TQXkjmyGPn0t+3fhRIQGIQTt/M=;
        b=FbvS3MCf0rAKnwl/9sCw7pwSbwYCdNVDEjfFetPrk9VhwkklDjNZJ0ir6f1wsVv2eW
         GICSBSI34Ooo7/RNmxEqX1Fv+c/JqQunH7kZJ85le2iHjbmbQLKY41SXx/azHJebANQF
         unrUHunbyw7Cgt4RW46OFZxjK66ENjsxzTf/AJTJ9MLB6OokjDWf5NnPxGLFXIziGU3+
         XwyHKoqIvxgDHikLHBnIBLPY5wZmf2CfnWCcK5WkE7BbE/i0YeGHHQLgG6sBExcS21rZ
         PwRZQeuWDnA8HK5enYY8lfZ64coV8HBrhwTqo0f15JwnSmzOHszp/3UccT3J5dLxfkwt
         3iGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X3rs3EZNUK5eXVTg1TQXkjmyGPn0t+3fhRIQGIQTt/M=;
        b=6RjC+WjUtEMdYcCYpuEzE0JT1saa10QElWfH/6Yn7Kx58XH1dL/5xKp2JAPcoEwgqu
         SetN66Xs+JvrErpPxbJNO3B92pcvtpaLL98WkUPXaOEcE8HgdCW2JL2Ok/CwdN1vZEep
         +9zLXTMudzR48fK+VRcmWVKCEJEe7Rl1i4XS1kBJGJnWxYzaGk9Uibhz4pe6/fVpurHT
         V7Qj2KL83tFGLP6A31z0SjBlXjlO7FNiX0HgxGa8FBYDC2YTLJGVNiujjtSnN99si9Tz
         YQRYHQI4y0zf9E7r7OT0jxTxxwpU46/F4EJD94LTRyC49i+dI9yuApfGtE9YfV3TVy30
         aLvw==
X-Gm-Message-State: AJIora+RwjQ8XQzi6bEj3QGv8WPNuesTMnq4EyzdUqbmNAKTYrhKR96W
        JYOefpKEpQYIJMeUDByMFr+RSMK5G//0Q1TLOYw=
X-Google-Smtp-Source: AGRyM1sBmk5Q28SwAF/4hpfVX9rC42L68jrBMrgK95HRcImHgqHz8VS5YJ3nIJHsW62Z/M5IeM+yHA==
X-Received: by 2002:a05:6a00:4406:b0:51c:244f:85d8 with SMTP id br6-20020a056a00440600b0051c244f85d8mr3742673pfb.36.1655368737148;
        Thu, 16 Jun 2022 01:38:57 -0700 (PDT)
Received: from localhost ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id e15-20020a63370f000000b003fdc16f5de2sm1067536pga.15.2022.06.16.01.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 01:38:56 -0700 (PDT)
From:   Hongyu Xie <xy521521@gmail.com>
X-Google-Original-From: Hongyu Xie <xiehongyu1@kylinos.cn>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        125707942@qq.com, wangqi@kylinos.cn, xiongxin@kylinos.cn,
        Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: [PATCH v5 -next] usb: xhci: disable irq during initialization
Date:   Thu, 16 Jun 2022 16:38:52 +0800
Message-Id: <20220616083852.1264261-1-xiehongyu1@kylinos.cn>
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

v5: remove reported by test robot
v4: fix compile err reported by test robot
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

