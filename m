Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4395A516C15
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383788AbiEBIhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiEBIha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:37:30 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0ED818386
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 01:34:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 8828C41982;
        Mon,  2 May 2022 08:33:56 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH] mailbox: apple: Keep IRQs active in suspend
Date:   Mon,  2 May 2022 17:33:45 +0900
Message-Id: <20220502083345.22433-1-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some consumers (notably SMC) need to be wakeup sources for s2idle,
so the IRQs need to stay enabled during suspend. We expect
consumers to properly suspend coprocessors such that no IRQs would
be triggered where not necessary, so this can be done unconditionally.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/mailbox/apple-mailbox.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/apple-mailbox.c b/drivers/mailbox/apple-mailbox.c
index e0c2bf7c6338..ce54f72d8676 100644
--- a/drivers/mailbox/apple-mailbox.c
+++ b/drivers/mailbox/apple-mailbox.c
@@ -369,8 +369,8 @@ static int apple_mbox_probe(struct platform_device *pdev)
 
 	ret = devm_request_threaded_irq(dev, mbox->irq_recv_not_empty, NULL,
 					apple_mbox_recv_irq,
-					IRQF_NO_AUTOEN | IRQF_ONESHOT, irqname,
-					mbox);
+					IRQF_NO_AUTOEN | IRQF_ONESHOT | IRQF_NO_SUSPEND,
+					irqname, mbox);
 	if (ret)
 		return ret;
 
@@ -378,9 +378,8 @@ static int apple_mbox_probe(struct platform_device *pdev)
 	if (!irqname)
 		return -ENOMEM;
 
-	ret = devm_request_irq(dev, mbox->irq_send_empty,
-			       apple_mbox_send_empty_irq, IRQF_NO_AUTOEN,
-			       irqname, mbox);
+	ret = devm_request_irq(dev, mbox->irq_send_empty, apple_mbox_send_empty_irq,
+			       IRQF_NO_AUTOEN | IRQF_NO_SUSPEND, irqname, mbox);
 	if (ret)
 		return ret;
 
-- 
2.35.1

