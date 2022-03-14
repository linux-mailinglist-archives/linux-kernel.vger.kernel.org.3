Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7D64D7E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbiCNJbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238040AbiCNJ3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:29:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3240F4477D;
        Mon, 14 Mar 2022 02:28:38 -0700 (PDT)
Date:   Mon, 14 Mar 2022 09:28:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647250116;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZrUjhy5AdkNOoYVg688O0daG5ZvTvWz+TTisUN4SPZk=;
        b=XMK7kDWAg8Bc6PXHmBHJdlyMeaFWC4QuY/QuMHrdPNP1zF2yV+QtoL4wM8tuYvHtEZZzmF
        UJjpihOi2PVMTiHof6RKVnGkSKBmI7CiSD+2+scNNMQjclmNzcKjnua//D1AfYoYRKt329
        Xu30/4ds4Koq/LEEA39rwkl8MAgi1ZeEdim9DnLPl3eMMyJAuHqwozKyDB0BQsI0HxSrA8
        lNmuhOY4k5z00cqDNJxk0aqAW735G/8AQ4ntUGE4nsF3Slrz5c49MMZPY2r3BvGXXqLDIE
        60QE9exPBGK9fnlJVmToBDnoq77R5xnh4nR7MiL1zRIurDYoAmkAa3cbsmtz/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647250116;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZrUjhy5AdkNOoYVg688O0daG5ZvTvWz+TTisUN4SPZk=;
        b=JFPJmRt9pi2youpcdk7J2vGZdw3ELDbOMYpsnTsIjRYpIyygKSdjpyJyJXpQuzNG0C+Auz
        ndwEVp8WfPogBEDw==
From:   "tip-bot2 for Peng Fan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/imx-sysctr: Drop IRQF_IRQPOLL
Cc:     Peng Fan <peng.fan@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211214120737.1611955-2-peng.fan@oss.nxp.com>
References: <20211214120737.1611955-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Message-ID: <164725011554.16921.17757039443052525428.tip-bot2@tip-bot2>
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

Commit-ID:     841255544b653cbabe4ee5eda56bbb8b7ad8de8a
Gitweb:        https://git.kernel.org/tip/841255544b653cbabe4ee5eda56bbb8b7ad8de8a
Author:        Peng Fan <peng.fan@nxp.com>
AuthorDate:    Tue, 14 Dec 2021 20:07:33 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 26 Jan 2022 10:00:39 +01:00

clocksource/drivers/imx-sysctr: Drop IRQF_IRQPOLL

Per the Documentation,
IRQF_IRQPOLL is used for polling (only the interrupt that is registered
first in a shared interrupt is considered for performance reasons)
But this timer is not sharing interrupt line with others, and
actually irqpoll not work with this timer with IRQF_IRQPOLL set, so
drop the flag.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Link: https://lore.kernel.org/r/20211214120737.1611955-2-peng.fan@oss.nxp.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-imx-sysctr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/timer-imx-sysctr.c
index 55a8e19..523e376 100644
--- a/drivers/clocksource/timer-imx-sysctr.c
+++ b/drivers/clocksource/timer-imx-sysctr.c
@@ -110,7 +110,7 @@ static struct timer_of to_sysctr = {
 	},
 	.of_irq = {
 		.handler		= sysctr_timer_interrupt,
-		.flags			= IRQF_TIMER | IRQF_IRQPOLL,
+		.flags			= IRQF_TIMER,
 	},
 	.of_clk = {
 		.name = "per",
