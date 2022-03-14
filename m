Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0148D4D7E9B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiCNJaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238042AbiCNJ3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:29:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD536443F9;
        Mon, 14 Mar 2022 02:28:34 -0700 (PDT)
Date:   Mon, 14 Mar 2022 09:28:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647250113;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kL/afjmEA3jEuN1oqWn/f2qR0Dp2m1Y66acTVoUbX8c=;
        b=3PGRe1cSrXbOudJQTzzt7NDatClXTDHKVEHYOFp+V72IsxoLxnNEPcvARxaZhprfaoYZSk
        sRveaGxCt1wljNYfS9KXjWmcVpevqNREu97yE2pAVHCw+bRacJaVIAi+nQI11/KXpyPula
        Ohm67TsRBfKW6KnpMupQoaefcTBscXaZu8/oP1UWO+SvRSMJhsnLMHIvhLkGmBw0jz56wS
        oFnPj4qoKXdb1goKza5NS0DM2U6y1lM6sggxUScI67zEhFYOydGR7p4H0pDNTeGI0wUuig
        qxhtsTsjEzeLb8q/aeveMtsHK6qsIQS9Y5+TPjvE6pNrMNuFiMHanz+GUob44w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647250113;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kL/afjmEA3jEuN1oqWn/f2qR0Dp2m1Y66acTVoUbX8c=;
        b=4x8jhkaec7CEVtccF8FGe7ZMfOvWOkqSiUrKgHs189Bv6a7XoWTArX8vaTGZgWVOPGW4ca
        9suNL3uNCnOFyvAw==
From:   "tip-bot2 for Peng Fan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/imx-tpm: Add CLOCK_EVT_FEAT_DYNIRQ
Cc:     Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211214120737.1611955-5-peng.fan@oss.nxp.com>
References: <20211214120737.1611955-5-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Message-ID: <164725011251.16921.9372165520109504949.tip-bot2@tip-bot2>
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

Commit-ID:     39664b624f6a6518001b2c8f86bac1352c89d0af
Gitweb:        https://git.kernel.org/tip/39664b624f6a6518001b2c8f86bac1352c89d0af
Author:        Peng Fan <peng.fan@nxp.com>
AuthorDate:    Tue, 14 Dec 2021 20:07:36 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 26 Jan 2022 10:01:00 +01:00

clocksource/drivers/imx-tpm: Add CLOCK_EVT_FEAT_DYNIRQ

Add CLOCK_EVT_FEAT_DYNIRQ to allow the IRQ could be runtime set affinity
to the cores that needs wake up, otherwise saying core0 has to send
IPI to wakeup core1. With CLOCK_EVT_FEAT_DYNIRQ set, when broadcast
timer could wake up the cores, IPI is not needed.

Acked-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Link: https://lore.kernel.org/r/20211214120737.1611955-5-peng.fan@oss.nxp.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-imx-tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index 3afd9b0..578fe16 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -129,7 +129,7 @@ static struct timer_of to_tpm = {
 	.clkevt = {
 		.name			= "i.MX7ULP TPM Timer",
 		.rating			= 200,
-		.features		= CLOCK_EVT_FEAT_ONESHOT,
+		.features		= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_DYNIRQ,
 		.set_state_shutdown	= tpm_set_state_shutdown,
 		.set_state_oneshot	= tpm_set_state_oneshot,
 		.set_next_event		= tpm_set_next_event,
