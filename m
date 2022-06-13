Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2339548CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351623AbiFMLEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 07:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350353AbiFMKyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 06:54:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208571D0DB;
        Mon, 13 Jun 2022 03:30:54 -0700 (PDT)
Date:   Mon, 13 Jun 2022 10:30:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655116251;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PLG/WtLVkroGPYAWdPXamFTN/HRL0nfnOe8+NibDVJE=;
        b=u6MjQaeD1yo84eqYt2O0QWrw6Iun8Y88DC0cD0rgJEHFkCEAbWbcWgMlBnD3iEgxXjehVJ
        7ziHU9O99LrL5Fj/i45fEsm834XYOkmpYLErg/ekFjX0aWkjMEj55PGKNxkjaJqKrGzu7g
        oj+8SIOeqkGjbnLpa5jw3f2tTBmXV+L4bdm8ygqz5qom5stivznHf57V2slmtWCWRuqN2F
        wlpP1FdjqUsSVocgry//O01zHSFU/FzAKEW3BMyPfyajshXTDeQeHYJjkpmhYo+4cxnx9e
        ruDq8k7lF/jJdlTS7Z0XJ1zXqqN8aRLfKkPkjzNNAmBuI2qwxy92wcwy1sl5GA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655116251;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PLG/WtLVkroGPYAWdPXamFTN/HRL0nfnOe8+NibDVJE=;
        b=Hb5QcSdc8Ny225TgrLKMtjCUBL1B/ZWX0ps3gxlrQu50D0+zUbqj7Wnpjr58hunj9dmuio
        ttcXALGh0WC2zXBA==
From:   "tip-bot2 for Lukas Wunner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/PM: Unexport {suspend,resume}_device_irqs()
Cc:     Lukas Wunner <lukas@wunner.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <fad9b50609f9d9828ea14772dbd4d195713f1c4b.1654846687.git.lukas@wunner.de>
References: <fad9b50609f9d9828ea14772dbd4d195713f1c4b.1654846687.git.lukas@wunner.de>
MIME-Version: 1.0
Message-ID: <165511625017.4207.9422220273821026208.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ac165aab469895de059a4a191a2e04ddb5421d0e
Gitweb:        https://git.kernel.org/tip/ac165aab469895de059a4a191a2e04ddb5421d0e
Author:        Lukas Wunner <lukas@wunner.de>
AuthorDate:    Fri, 10 Jun 2022 09:40:50 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 13 Jun 2022 12:27:37 +02:00

genirq/PM: Unexport {suspend,resume}_device_irqs()

Ever since {suspend,resume}_device_irqs() were introduced in 2009
by commit 0a0c5168df27 ("PM: Introduce functions for suspending and
resuming device interrupts"), they've been exported even though there
are no module users and never will be:  The functions are solely called
by the PM core, which is always built-in.  Unexport them.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/fad9b50609f9d9828ea14772dbd4d195713f1c4b.1654846687.git.lukas@wunner.de

---
 kernel/irq/pm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index ca71123..c556bc4 100644
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
