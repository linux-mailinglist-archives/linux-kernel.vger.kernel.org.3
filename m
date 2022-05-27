Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D84535B8F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349812AbiE0IhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349741AbiE0IgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:36:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0317FF58C;
        Fri, 27 May 2022 01:36:03 -0700 (PDT)
Date:   Fri, 27 May 2022 08:36:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653640562;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YV94WFEBhQ3Vi9i7oZUew/ph+yFRL0KG8U7E6tDma8w=;
        b=wDGYD1dpOwGzCwvzyVw7xLhZssLpY2JXV4/XEFQG5PdJ1KeUi/DzA1Z0gw9GYSRIbkJYKV
        xsITEjc5dx1YteQcfsf8ypNsM+rlB5exbhxL4TFgbXQDzdgZg2BPZNkUjEkXr97W1Z34qA
        O6b4R43N0vgjp6cgnRCCkFOclYih4sUb056fu14bi9M+GTrO0/S00hOk6I2GrM1BtU9R8m
        ZFGElC/XayKkAleWsfEkAinNep8Wj5aADhCrUHNrA1C+rtmvXLORQiNzKDHPpJoQKAkUw0
        PS6Rw0J2LGzbWcbVw7kWvfY89DpRMU4Ri5OexLFBeTgxW7nQgjq7bvCtNHgaew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653640562;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YV94WFEBhQ3Vi9i7oZUew/ph+yFRL0KG8U7E6tDma8w=;
        b=yKK5iJS0jc5QheMItRJgDAX5LAeFA4MiiBWpbuMzZZkrqxLhIixRkToi7lZo4tC45ExvDr
        +1YQlxLie8PcSDDQ==
From:   "tip-bot2 for Andre Przywara" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/sp804: Avoid error on multiple
 instances
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220506162522.3675399-1-andre.przywara@arm.com>
References: <20220506162522.3675399-1-andre.przywara@arm.com>
MIME-Version: 1.0
Message-ID: <165364056118.4207.17407436599286478766.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a98399cbc1e05f7b977419f03905501d566cf54e
Gitweb:        https://git.kernel.org/tip/a98399cbc1e05f7b977419f03905501d566cf54e
Author:        Andre Przywara <andre.przywara@arm.com>
AuthorDate:    Fri, 06 May 2022 17:25:22 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 18 May 2022 11:08:52 +02:00

clocksource/drivers/sp804: Avoid error on multiple instances

When a machine sports more than one SP804 timer instance, we only bring
up the first one, since multiple timers of the same kind are not useful
to Linux. As this is intentional behaviour, we should not return an
error message, as we do today:
===============
[    0.000800] Failed to initialize '/bus@8000000/motherboard-bus@8000000/iofpga-bus@300000000/timer@120000': -22
===============

Replace the -EINVAL return with a debug message and return 0 instead.

Also we do not reach the init function anymore if the DT node is
disabled (as this is now handled by OF_DECLARE), so remove the explicit
check for that case.

This fixes a long standing bogus error when booting ARM's fastmodels.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/20220506162522.3675399-1-andre.przywara@arm.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-sp804.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 401d592..e6a87f4 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -259,6 +259,11 @@ static int __init sp804_of_init(struct device_node *np, struct sp804_timer *time
 	struct clk *clk1, *clk2;
 	const char *name = of_get_property(np, "compatible", NULL);
 
+	if (initialized) {
+		pr_debug("%pOF: skipping further SP804 timer device\n", np);
+		return 0;
+	}
+
 	base = of_iomap(np, 0);
 	if (!base)
 		return -ENXIO;
@@ -270,11 +275,6 @@ static int __init sp804_of_init(struct device_node *np, struct sp804_timer *time
 	writel(0, timer1_base + timer->ctrl);
 	writel(0, timer2_base + timer->ctrl);
 
-	if (initialized || !of_device_is_available(np)) {
-		ret = -EINVAL;
-		goto err;
-	}
-
 	clk1 = of_clk_get(np, 0);
 	if (IS_ERR(clk1))
 		clk1 = NULL;
