Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C149489918
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiAJNBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:01:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42794 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbiAJM75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:59:57 -0500
Date:   Mon, 10 Jan 2022 12:59:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641819595;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2tn2jfcG6fdJ+mRwxp+0+JGUeCb7d8ZmjfMHhih999U=;
        b=hMAQBh7lpozElL3vR/iYK4GVxgI1Lih+btss1d7YzD4U39rx9Z/MEH+iSig5VDlaI97zhm
        eAFvC3cmyKdfQb5qd2xpKamNCfNDjnBq+23d2ioUFvv3uVNkTX5BKIzkf+8tW5mMTcnHXm
        K67vdvYHuVXdwtHfH16FYfjmcC39Dxu6OOAAxCMuckykQUv9DCPrlXS3DdjE8LINAhYnno
        Eq4wQMn30V++Ik2wwgXVpIFwFP9aEB+xs3+6Le6GVdMWiRvJjAEbM5mP8NEn3voj8YKexA
        3Cmur3knMUte6k9UAjoXD/kznqdnzgZCwP5dn1yHdcNE5up922gNSD6rr1JsKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641819595;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2tn2jfcG6fdJ+mRwxp+0+JGUeCb7d8ZmjfMHhih999U=;
        b=UOrU6afmVGNANr6Aa+jAPeK9VfyaicaisRMuRrKP+ua9NXbCM9k8pjhvt9lHo3c+FWmbvv
        vMDTbcL+mUht5fCA==
From:   "tip-bot2 for Peng Fan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-imx-sysctr: Set cpumask
 to cpu_possible_mask
Cc:     Peng Fan <peng.fan@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211201125030.2307746-2-peng.fan@oss.nxp.com>
References: <20211201125030.2307746-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Message-ID: <164181959418.16921.2526564999400774440.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     0ed9e4ebcebcb36bd1186e68cf2f72b3e0bfbac6
Gitweb:        https://git.kernel.org/tip/0ed9e4ebcebcb36bd1186e68cf2f72b3e0bfbac6
Author:        Peng Fan <peng.fan@nxp.com>
AuthorDate:    Wed, 01 Dec 2021 20:50:30 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 14 Dec 2021 10:17:27 +01:00

clocksource/drivers/timer-imx-sysctr: Set cpumask to cpu_possible_mask

The syctr interrupt could set the affinity to any cores in the
SoC. However, the default affinity is set to cpu 0.

This timer will be used as broadcast timer on all the i.MX
SoCs. Because DYNIRQ flag is set, the core time framework will runtime
set the interrupt affinity to the cores that needs to wake up and the
cpumask will runtime set to the core that will be wake up. So even the
sysctr initialization use cpumask 0, there is no issue, the current
patch is just use cpu_possible_mask to show the fact that the timer
supports routed to all the cpu cores and nothing else.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Link: https://lore.kernel.org/r/20211201125030.2307746-2-peng.fan@oss.nxp.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-imx-sysctr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/timer-imx-sysctr.c
index 2b309af..55a8e19 100644
--- a/drivers/clocksource/timer-imx-sysctr.c
+++ b/drivers/clocksource/timer-imx-sysctr.c
@@ -119,7 +119,7 @@ static struct timer_of to_sysctr = {
 
 static void __init sysctr_clockevent_init(void)
 {
-	to_sysctr.clkevt.cpumask = cpumask_of(0);
+	to_sysctr.clkevt.cpumask = cpu_possible_mask;
 
 	clockevents_config_and_register(&to_sysctr.clkevt,
 					timer_of_rate(&to_sysctr),
