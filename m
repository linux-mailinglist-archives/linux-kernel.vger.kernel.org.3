Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2812A54C44A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244939AbiFOJHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244746AbiFOJHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:07:25 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70AB3EA82;
        Wed, 15 Jun 2022 02:07:07 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso1471358pjk.0;
        Wed, 15 Jun 2022 02:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4JtPRyjbP8QuT3v17GJxg9BNek2Y86FBp+fdy2by9ME=;
        b=jOotHS64BY6M39fk6R8uENDwG2gcmiTJ3g0/qnWke0JrBrPJeJrJTZkm16oK9MTdZE
         mcAUhKwnm4NiLzC5+cSEZNnqES1bwBIcgmD4b2TaqaxzNEZ0vlzwBMVr/sOdfdajSz5j
         P3Omged3y6HVr1qT1kjfd+aaWOQcOMq3H6hRJ6E9VAKvsUHojVF/AbR7/p3G4WwmWJii
         4tNw23te90tgXOwGH7FICq2gWFsPUCot6Z2JeP0LRAm6gz4hCmP7gtFIW/gvDdIS7kuk
         88cfLw09hy4Ob2A4dxfu7QadKKmwYBvd336S6C4Q2fzuO9lSTdS01LrjkobxAij85s+D
         MfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4JtPRyjbP8QuT3v17GJxg9BNek2Y86FBp+fdy2by9ME=;
        b=xcehnxHApk6umL/+JLqscV4irex268iySdmDHmiJdGQj+70RcVIo++1n58rMsIHBnQ
         w3qU9gOroFWT0sJzll/LISKsqPmYABYID++iWAsP0Hrx7iDE4dPrLI11dOqjW048LMrD
         eZN2vMC0G5zAtfpMTShfTWOFmzsSPjF+RU2v8Zi4a1rN4pl84SS4sX9JlZpgVTsEteIj
         nmHS1UnlRCQhBohMNOXXIPnzje+OKI8uW4fobC2akuG+kYk/RJq8c2YyzsJSaKTS21zP
         41xxUTXbVAeM7Tw55S/uE1uCuSgcKOaeReNHT/Ati99lGztx1Ou/LMuNDlYLGwZBvHf4
         M6+w==
X-Gm-Message-State: AJIora/fUqNFm2unzsSNzo8Y6QM4t1E87irPhOmc0c2Rggu/CrVCrK47
        HYbuFnMt/6VFoQuuIzU/HBnDvSpnzOTO+iD6ync=
X-Google-Smtp-Source: ABdhPJySN52jEKSf82uTHdGB9FMkjyPTuQAeoOTbelMrzYhTURhqOj0vKUkkUK1xFfKum1H14ZBk7w==
X-Received: by 2002:a17:902:7105:b0:168:dfe3:66e0 with SMTP id a5-20020a170902710500b00168dfe366e0mr8209334pll.88.1655284027260;
        Wed, 15 Jun 2022 02:07:07 -0700 (PDT)
Received: from localhost ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id w2-20020a62c702000000b0051c03229a2bsm9208920pfg.21.2022.06.15.02.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 02:07:06 -0700 (PDT)
From:   Hongyu Xie <xy521521@gmail.com>
X-Google-Original-From: Hongyu Xie <xiehongyu1@kylinos.cn>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        125707942@qq.com, wangqi@kylinos.cn, xiongxin@kylinos.cn,
        Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: [PATCH v2 -next] usb: xhci: disable irq during initialization
Date:   Wed, 15 Jun 2022 17:07:03 +0800
Message-Id: <20220615090703.1812560-1-xiehongyu1@kylinos.cn>
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

v2: fix compile error

 drivers/usb/host/xhci.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 9ac56e9ffc64..513bcd346886 100644
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
+			"// Enabling event ring interrupter %p by writing 0x%x"
+			"to irq_pending", xhci->ir_set,
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

