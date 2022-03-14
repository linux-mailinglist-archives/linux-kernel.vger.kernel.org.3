Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B564D7E93
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbiCNJaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238011AbiCNJ3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:29:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E343527A;
        Mon, 14 Mar 2022 02:28:26 -0700 (PDT)
Date:   Mon, 14 Mar 2022 09:28:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647250104;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lbX4guq10C4WbgjPFGR3cSWHkRW9v5h6QvXycrYx3bs=;
        b=W6SejkfzyqzbYt4BGVcAuC0bxVydl1mxspI84A48zhyJ/WOiCQqDEXTovJJd4qnG9iLYtt
        c9w9O6N3MplRfOwOkIk8/mYgZ/z2NNL3auRFMkeeOnjkcK57Qy1/rz9RtLNo82K3fWEnys
        75IIdEeTyGLeMTPJlfJ3ftah9R0mQhPS7p5+B6l7nKs/aPps0XiZ520ghC+Za5lvzu1jCn
        zc3vraDt1qpAjeRFdFSR0b5g18ugw1quptDPrtx5pMdzYrYNQ/C7BdkN8DIem3+3ZrMx5G
        0Vd8WFqhav333fx3qISF0utc4vrzPNzp1oA9dTDyMRR8LbvactM7+ckTu+B5yA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647250104;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lbX4guq10C4WbgjPFGR3cSWHkRW9v5h6QvXycrYx3bs=;
        b=uM1DMt1UNn6wElWYAix9Ejr5BY/sH5sV95dYVFB3V9DDtvw5YbNX0VB5gQ5uhC2FGnKgRg
        0p+lJ2h5L7p17xCw==
From:   "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/imx-tpm: Move
 tpm_read_sched_clock() under CONFIG_ARM
Cc:     Nathan Chancellor <nathan@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220303184212.2356245-1-nathan@kernel.org>
References: <20220303184212.2356245-1-nathan@kernel.org>
MIME-Version: 1.0
Message-ID: <164725010341.16921.1444597331705749005.tip-bot2@tip-bot2>
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

Commit-ID:     bf127df3cceada8693888fc86a3121c38ef25701
Gitweb:        https://git.kernel.org/tip/bf127df3cceada8693888fc86a3121c38ef25701
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Thu, 03 Mar 2022 11:42:12 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 07 Mar 2022 18:27:22 +01:00

clocksource/drivers/imx-tpm: Move tpm_read_sched_clock() under CONFIG_ARM

When building this driver for an architecture other than ARCH=arm:

  drivers/clocksource/timer-imx-tpm.c:78:20: error: unused function 'tpm_read_sched_clock' [-Werror,-Wunused-function]
  static u64 notrace tpm_read_sched_clock(void)
                     ^
  1 error generated.

Move the function definition under the existing CONFIG_ARM section so
there is no more warning.

Fixes: 10720e120e2b ("clocksource/drivers/imx-tpm: Exclude sched clock for ARM64")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Link: https://lore.kernel.org/r/20220303184212.2356245-1-nathan@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-imx-tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index 60cefc2..bd64a8a 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -73,12 +73,12 @@ static unsigned long tpm_read_current_timer(void)
 {
 	return tpm_read_counter();
 }
-#endif
 
 static u64 notrace tpm_read_sched_clock(void)
 {
 	return tpm_read_counter();
 }
+#endif
 
 static int tpm_set_next_event(unsigned long delta,
 				struct clock_event_device *evt)
