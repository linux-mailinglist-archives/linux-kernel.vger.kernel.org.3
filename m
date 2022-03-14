Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B654D7E9E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237690AbiCNJa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238049AbiCNJ3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:29:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F067B443FD;
        Mon, 14 Mar 2022 02:28:32 -0700 (PDT)
Date:   Mon, 14 Mar 2022 09:28:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647250111;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wN4CevDf67oADYGI1UEhms/ZgQxybNFcbh4TO+FRVI4=;
        b=jYuvUznK8Fl/gd7ZDp4+aGnhuNdCpmNNVWQFOTk7340qn+H6ap+GvoVnBnB45kkNhorsbH
        7Eg2sRuo21jjxDVq/RvwdtaGbNTkpQNfV5sBp/DXzcTe18BOU30JmEKJnnOmJba5G2NQQ2
        ASI4Hkziyy7CP9aUp0eDFGbjE8yQoGdBf6zNoxlNen6SY8GzwMtubnchHBkT30T6tCRPN9
        3uTZbyTDX5IRrkLxe0/dPLmKsNQEfajV0tiR0KLCeYNJjgGLM9E7jiN+4+h+4Brpa9fIJ7
        GPwX/Lmo6eqeKH4XHWMrx9E51aLykvYdm8yhCRZ+mIWFkBMkQuIA8JxiMM3JKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647250111;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wN4CevDf67oADYGI1UEhms/ZgQxybNFcbh4TO+FRVI4=;
        b=gaU9bNPKv7Vaysoc8kGclD1vGSV3yMYISYw3fF8/c6pmysCQTIGsFW90tCbN9/rUp6PiG+
        T9UZAYJV3OWeusAw==
From:   "tip-bot2 for Peng Fan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/imx-tpm: Exclude sched clock for ARM64
Cc:     Peng Fan <peng.fan@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220105124304.3567629-1-peng.fan@oss.nxp.com>
References: <20220105124304.3567629-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Message-ID: <164725011047.16921.16930641794301120667.tip-bot2@tip-bot2>
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

Commit-ID:     10720e120e2b1d66172dccb06eb4f346a665cca6
Gitweb:        https://git.kernel.org/tip/10720e120e2b1d66172dccb06eb4f346a665cca6
Author:        Peng Fan <peng.fan@nxp.com>
AuthorDate:    Wed, 05 Jan 2022 20:43:04 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 16 Feb 2022 14:43:30 +01:00

clocksource/drivers/imx-tpm: Exclude sched clock for ARM64

For ARM64 platform such as i.MX8ULP which has ARMv8 generic timer as sched
clock, which is much faster compared with tpm sched clock. Reading the
tpm count register in i.MX8ULP requires about 290ns, this is slow and
introduce scheduler latency. So exclude tpm sched clock for ARM64
platform.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Link: https://lore.kernel.org/r/20220105124304.3567629-1-peng.fan@oss.nxp.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-imx-tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index df80641..60cefc2 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -150,10 +150,10 @@ static int __init tpm_clocksource_init(void)
 	tpm_delay_timer.read_current_timer = &tpm_read_current_timer;
 	tpm_delay_timer.freq = timer_of_rate(&to_tpm) >> 3;
 	register_current_timer_delay(&tpm_delay_timer);
-#endif
 
 	sched_clock_register(tpm_read_sched_clock, counter_width,
 			     timer_of_rate(&to_tpm) >> 3);
+#endif
 
 	return clocksource_mmio_init(timer_base + TPM_CNT,
 				     "imx-tpm",
