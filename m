Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95428489913
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbiAJNBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:01:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42826 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbiAJNAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:00:00 -0500
Date:   Mon, 10 Jan 2022 12:59:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641819597;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NQNKOwqodvSC184pmDbn6fSHDlBt0JpNXeJ0d8tnpQg=;
        b=zDBAPNp5rSuR2PDOwwdc4QSfsJQcFCRPZBXLf5WRAXC/hQCikN3fNVbwGd8IIgpt1QcG+h
        qjASTvJ9Zlx/urpi6vsWRIVgZlOn9kIguzFbnbq9TqEYZ9DgPod91LQPEgaOVo/wnpq6HB
        LEYZw0cvSrYp31kQGdlEWAG3e9rnuRN+t/XNPBoYCieWewS0KFqqBh7YR25a4h9CmyxGsM
        BDGcUZ67UB+r7271ewpWocvwzy7hrvCciyatLlO+5Cqy8yzdWivgOjBRp6EmMoQwfg74ct
        d72Zu0ZmsOk2g2r38nNK2LP+sFOo/wasGq6Pcc/63ZFteKSv/di3KkC/cYwCRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641819597;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NQNKOwqodvSC184pmDbn6fSHDlBt0JpNXeJ0d8tnpQg=;
        b=NKQK6sv1rAKHCVD/LUu3OT5wb9KZrP0QnRxKvAQRap7kcOxsQFyB4z7rryMTUH0CIEjJcr
        E9qIhvCYN3NzSADw==
From:   "tip-bot2 for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/renesas-ostm: Add RZ/G2L OSTM support
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211112184413.4391-4-biju.das.jz@bp.renesas.com>
References: <20211112184413.4391-4-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <164181959653.16921.6754213596034751626.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     3a3e9f23c2cae907677a236fa547610ca747e6fb
Gitweb:        https://git.kernel.org/tip/3a3e9f23c2cae907677a236fa547610ca747e6fb
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Fri, 12 Nov 2021 18:44:12 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 09 Dec 2021 14:05:20 +01:00

clocksource/drivers/renesas-ostm: Add RZ/G2L OSTM support

RZ/G2L SoC has Generic Timer Module(a.k.a OSTM) which needs to
deassert the reset line before accessing any registers.

This patch adds an entry point for RZ/G2L so that we can deassert
the reset line in probe callback.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20211112184413.4391-4-biju.das.jz@bp.renesas.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/renesas-ostm.c | 39 ++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/renesas-ostm.c b/drivers/clocksource/renesas-ostm.c
index 3d06ba6..21d1392 100644
--- a/drivers/clocksource/renesas-ostm.c
+++ b/drivers/clocksource/renesas-ostm.c
@@ -9,6 +9,8 @@
 #include <linux/clk.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
 #include <linux/sched_clock.h>
 #include <linux/slab.h>
 
@@ -159,6 +161,7 @@ static int __init ostm_init_clkevt(struct timer_of *to)
 
 static int __init ostm_init(struct device_node *np)
 {
+	struct reset_control *rstc;
 	struct timer_of *to;
 	int ret;
 
@@ -166,6 +169,14 @@ static int __init ostm_init(struct device_node *np)
 	if (!to)
 		return -ENOMEM;
 
+	rstc = of_reset_control_get_optional_exclusive(np, NULL);
+	if (IS_ERR(rstc)) {
+		ret = PTR_ERR(rstc);
+		goto err_free;
+	}
+
+	reset_control_deassert(rstc);
+
 	to->flags = TIMER_OF_BASE | TIMER_OF_CLOCK;
 	if (system_clock) {
 		/*
@@ -178,7 +189,7 @@ static int __init ostm_init(struct device_node *np)
 
 	ret = timer_of_init(np, to);
 	if (ret)
-		goto err_free;
+		goto err_reset;
 
 	/*
 	 * First probed device will be used as system clocksource. Any
@@ -203,9 +214,35 @@ static int __init ostm_init(struct device_node *np)
 
 err_cleanup:
 	timer_of_cleanup(to);
+err_reset:
+	reset_control_assert(rstc);
+	reset_control_put(rstc);
 err_free:
 	kfree(to);
 	return ret;
 }
 
 TIMER_OF_DECLARE(ostm, "renesas,ostm", ostm_init);
+
+#ifdef CONFIG_ARCH_R9A07G044
+static int __init ostm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	return ostm_init(dev->of_node);
+}
+
+static const struct of_device_id ostm_of_table[] = {
+	{ .compatible = "renesas,ostm", },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver ostm_device_driver = {
+	.driver = {
+		.name = "renesas_ostm",
+		.of_match_table = of_match_ptr(ostm_of_table),
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver_probe(ostm_device_driver, ostm_probe);
+#endif
