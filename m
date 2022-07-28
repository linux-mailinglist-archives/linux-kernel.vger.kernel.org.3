Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921F2583C56
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236611AbiG1Kpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236441AbiG1Kow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:44:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381D76113B;
        Thu, 28 Jul 2022 03:44:20 -0700 (PDT)
Date:   Thu, 28 Jul 2022 10:44:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659005058;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hf61HpLzxZHwfHd+7ApzXIc22+Huwe7ZrKmU/hEIKDM=;
        b=et2A7TPL515HXJFdhWA3MyzVvjslsJUllH2O2qjKICInG4MEJ75p4ib5T9CsTkcdhmfHJX
        26d7Mghh3ifaMunKZhXwnhlBj1D1fSKpp6JdxxwHL4Lz2DraiPugPQ3e1bF17kgDOHpMUB
        asRvPaExbEe/WBCeb1YfCaGucLO+Bu8X1e9PN8+PhlwK5CHDNIhH68kJ2/RkvOoVIDiXHU
        iGYVp3rrlP4k2vbxPCk5C21wxfLSh/LVIjISUh0VQU3RaSOY1VgOn+qd4FJp6Q0WUsjrg8
        IDnwhL1iT5SgU7Og95AA6Ty9kkaqTQ8bTQ8j9QQGraPAEJKbqOgqCqK4U3hK9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659005058;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hf61HpLzxZHwfHd+7ApzXIc22+Huwe7ZrKmU/hEIKDM=;
        b=5qd9ocM7C7z1qEvt7YyqWjNtsBJnR6wgys+lunf6d+00LCRmO4nyaz1pv/GNVWTsuKoocY
        v5JPOKO6rwa4qSCg==
From:   "tip-bot2 for Kartik" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-tegra186: Add support
 for Tegra234 SoC
Cc:     Kartik <kkartik@nvidia.com>, Thierry Reding <treding@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1656922422-25823-4-git-send-email-kkartik@nvidia.com>
References: <1656922422-25823-4-git-send-email-kkartik@nvidia.com>
MIME-Version: 1.0
Message-ID: <165900505716.15455.14363041253812722121.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     07385a6055a8649593052703b1bfd6aef49db02a
Gitweb:        https://git.kernel.org/tip/07385a6055a8649593052703b1bfd6aef49db02a
Author:        Kartik <kkartik@nvidia.com>
AuthorDate:    Mon, 04 Jul 2022 13:43:39 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 16 Jul 2022 00:38:50 +02:00

clocksource/drivers/timer-tegra186: Add support for Tegra234 SoC

The timer IP block present on Tegra234 SoC supports watchdog timer
functionality that can be used to recover from system hangs. The
watchdog timer uses a timer in the background for countdown.

Signed-off-by: Kartik <kkartik@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Link: https://lore.kernel.org/r/1656922422-25823-4-git-send-email-kkartik@nvidia.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-tegra186.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer-tegra186.c
index 4515517..ea74288 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -486,8 +486,14 @@ static const struct tegra186_timer_soc tegra186_timer = {
 	.num_wdts = 3,
 };
 
+static const struct tegra186_timer_soc tegra234_timer = {
+	.num_timers = 16,
+	.num_wdts = 3,
+};
+
 static const struct of_device_id tegra186_timer_of_match[] = {
 	{ .compatible = "nvidia,tegra186-timer", .data = &tegra186_timer },
+	{ .compatible = "nvidia,tegra234-timer", .data = &tegra234_timer },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tegra186_timer_of_match);
