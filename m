Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B01054BFBB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 04:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239829AbiFOCjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 22:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236737AbiFOCjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 22:39:00 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4F62A241;
        Tue, 14 Jun 2022 19:38:59 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o33-20020a17090a0a2400b001ea806e48c6so738766pjo.1;
        Tue, 14 Jun 2022 19:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ljM1akAFcNegsAva6KUStT3JxFi81oN/aVdBiWtTGH0=;
        b=GwK5h2wx/oU4Z8fAqV9IkyEqcpmynB6usKm5hIC22zrQJPeZwm/qPx846zIwbHbtCz
         JDE8zdwhxt+/AFmM92WJXEHiyYBm7l2LQpQTUi2WzskDLUO5Wu4rpFAaGuYkrTTZ4Ixh
         8mVENRmC4lrS5d46z8IsGM54toGRcGs6pVGFms0TkEUoDvJbQE6nHnzwShUkdoePP/vF
         56fN0WsMWc9F9sugdzvgNssG2d6iogHWdSPj8RB2rX/ifxTyqMivt36YHbrEYEgvz6s3
         +TQ9cE2QWXbeOrEvvQYrZYyazgJMzN5QbmCfABPKqSn+bziAdpdNE/DR6tCu697cDgFG
         azGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ljM1akAFcNegsAva6KUStT3JxFi81oN/aVdBiWtTGH0=;
        b=hAvd4U+PVA/8cl3CsVvH5skbyPHcPtej7rz0w6Q1H/6s7hOe2Sh/cLNfvn/kRdkaar
         tgZ9bZcGb4NCTsjxsOQ5zHifGRYj2+CumQ+MvSDvp/YpvXbG3nWnwqGH7Rfg551W9TIs
         XCujABbRGFZqeRplW4lRiOEe0eOA7KBJpkzopkDmpciKvGCG9kW35rcBpsSKgMS+ssbj
         OBxrMcPQ0YIG8/CBrvnob+PJ3P5hYr7VjMKHtzAkkudTEXQV6Yw1XDCIZAGo4tpg0O81
         bF+pI6m4p1+Fpfz2AvgIHzZ0JF78+Qa1lUCS3So19WePPMo6rY0KlZm7OO/4tu3kFYit
         CERg==
X-Gm-Message-State: AJIora+Lb6Gn9WaNLGJx1awO5tDBV46NNmo8WVVxBlHjB3OCgW0EXHka
        uDqxu7/qaDADn6fYOSrFYZnTx1/xYnhmsKvaTiL6PQ==
X-Google-Smtp-Source: AGRyM1tPlXl8XwWf2qzQO4lIPzdQE7EatMLX7R1APxEuo8ln8LpypAcgkmVaPNsgGdKOVtSt59Sdjw==
X-Received: by 2002:a17:902:db0f:b0:166:42b5:c819 with SMTP id m15-20020a170902db0f00b0016642b5c819mr7165901plx.96.1655260739393;
        Tue, 14 Jun 2022 19:38:59 -0700 (PDT)
Received: from localhost ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id c14-20020aa781ce000000b0050dc7628178sm8293988pfn.82.2022.06.14.19.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 19:38:59 -0700 (PDT)
From:   Hongyu Xie <xy521521@gmail.com>
X-Google-Original-From: Hongyu Xie <xiehongyu1@kylinos.cn>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangqi@kylinos.cn, xiongxin@kylinos.cn, 125707942@qq.com,
        Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: [PATCH -next] usb: xhci: disable irq during initialization
Date:   Wed, 15 Jun 2022 10:38:55 +0800
Message-Id: <20220615023855.214533-1-xiehongyu1@kylinos.cn>
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
 drivers/usb/host/xhci.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 9ac56e9ffc64..8e4b86e84486 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -611,6 +611,7 @@ static int xhci_init(struct usb_hcd *hcd)
 
 static int xhci_run_finished(struct xhci_hcd *xhci)
 {
+	u32 temp;
 	if (xhci_start(xhci)) {
 		xhci_halt(xhci);
 		return -ENODEV;
@@ -620,6 +621,19 @@ static int xhci_run_finished(struct xhci_hcd *xhci)
 	if (xhci->quirks & XHCI_NEC_HOST)
 		xhci_ring_cmd_db(xhci);
 
+	/* Set the HCD state before we enable the irqs */
+	temp = readl(&xhci->op_regs->command);
+	temp |= (CMD_EIE);
+	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
+			"// Enable interrupts, cmd = 0x%x.", temp);
+	writel(temp, &xhci->op_regs->command);
+
+	temp = readl(&xhci->ir_set->irq_pending);
+	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
+			"// Enabling event ring interrupter %p by writing 0x%x
+			to irq_pending", xhci->ir_set,
+			(unsigned int) ER_IRQ_ENABLE(temp));
+	writel(ER_IRQ_ENABLE(temp), &xhci->ir_set->irq_pending);
 	return 0;
 }
 
@@ -668,19 +682,6 @@ int xhci_run(struct usb_hcd *hcd)
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

