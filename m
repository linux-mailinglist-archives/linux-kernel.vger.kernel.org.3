Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C418A545DB2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346901AbiFJHk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbiFJHky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:40:54 -0400
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3CD139AD8;
        Fri, 10 Jun 2022 00:40:52 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 1CF0E103B3F34;
        Fri, 10 Jun 2022 09:40:50 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id EC1E86064270;
        Fri, 10 Jun 2022 09:40:49 +0200 (CEST)
X-Mailbox-Line: From fad9b50609f9d9828ea14772dbd4d195713f1c4b Mon Sep 17 00:00:00 2001
Message-Id: <fad9b50609f9d9828ea14772dbd4d195713f1c4b.1654846687.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 10 Jun 2022 09:40:50 +0200
Subject: [PATCH] genirq/PM: Unexport {suspend,resume}_device_irqs()
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ever since {suspend,resume}_device_irqs() were introduced in 2009
by commit 0a0c5168df27 ("PM: Introduce functions for suspending and
resuming device interrupts"), they've been exported even though there
are no module users and never will be:  The functions are solely called
by the PM core, which is always built-in.  Unexport them.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 kernel/irq/pm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index ca71123a6130..c556bc49d213 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -147,7 +147,6 @@ void suspend_device_irqs(void)
 			synchronize_irq(irq);
 	}
 }
-EXPORT_SYMBOL_GPL(suspend_device_irqs);
 
 static void resume_irq(struct irq_desc *desc)
 {
@@ -259,4 +258,3 @@ void resume_device_irqs(void)
 {
 	resume_irqs(false);
 }
-EXPORT_SYMBOL_GPL(resume_device_irqs);
-- 
2.35.2

