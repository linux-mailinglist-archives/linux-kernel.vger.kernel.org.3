Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5004D7E99
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiCNJav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238059AbiCNJ3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:29:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBF64476C;
        Mon, 14 Mar 2022 02:28:36 -0700 (PDT)
Date:   Mon, 14 Mar 2022 09:28:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647250115;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GQa2cda/jteCKccxrl8iyR7/LSZOxMWiEEqfqQOZOUA=;
        b=sVwB1BuefDt0SFIxpfgIx28+nfWDtiqXzV8hWS/uRjAaoIgCsjCAR4Bi6v+GXRvSFHrJMp
        qQoX67SC7sIimVTfnKp3TGqxLi/ypl2oKOiKEBPIdlZyncEIitN5in2T/qaHNZ9Qf3puyv
        AZ/Jjc3L1cfv39k2M+UK59kUQ2MImOfwt/Y9cvHR7+DYX0tkVYR72sC9WE9RshSbYFZtx7
        u2UZE1VMuPgGMNl5J1/olRRt2l4hAEic7VofkFlT0O/+oiv414x5XF2+KWt2zFQhVJwOyh
        pBtw+ZeRbm+N08x+AUVLpWHyhQnAP6B4LgCdKwW9Z6+Y2E+8JSqMAIbFBDvZOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647250115;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GQa2cda/jteCKccxrl8iyR7/LSZOxMWiEEqfqQOZOUA=;
        b=p8Ras7tQ0p4InizJab624wQnukVECiFYRAZVNxgMm/xMsQ2E70roh3eZaSaH0egyG6DtpW
        bd+iymu0f8kghTDg==
From:   "tip-bot2 for Peng Fan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/imx-tpm: Drop IRQF_IRQPOLL
Cc:     Peng Fan <peng.fan@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211214120737.1611955-3-peng.fan@oss.nxp.com>
References: <20211214120737.1611955-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Message-ID: <164725011451.16921.5795659129068966943.tip-bot2@tip-bot2>
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

Commit-ID:     59e2bcd8a95b4cc5a04809b6d2ee337e81b47f57
Gitweb:        https://git.kernel.org/tip/59e2bcd8a95b4cc5a04809b6d2ee337e81b47f57
Author:        Peng Fan <peng.fan@nxp.com>
AuthorDate:    Tue, 14 Dec 2021 20:07:34 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 26 Jan 2022 10:00:45 +01:00

clocksource/drivers/imx-tpm: Drop IRQF_IRQPOLL

Per the Documentation,
IRQF_IRQPOLL is used for polling (only the interrupt that is registered
first in a shared interrupt is considered for performance reasons)
The TPM timer is not sharing interrupt with others, and pass irqpoll
not make sense for i.MX platform.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Link: https://lore.kernel.org/r/20211214120737.1611955-3-peng.fan@oss.nxp.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-imx-tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index 2cdc077..2c0b0d4 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -137,7 +137,7 @@ static struct timer_of to_tpm = {
 	},
 	.of_irq = {
 		.handler		= tpm_timer_interrupt,
-		.flags			= IRQF_TIMER | IRQF_IRQPOLL,
+		.flags			= IRQF_TIMER,
 	},
 	.of_clk = {
 		.name = "per",
