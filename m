Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C65583C3D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbiG1KoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbiG1KoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:44:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4D45C369;
        Thu, 28 Jul 2022 03:44:07 -0700 (PDT)
Date:   Thu, 28 Jul 2022 10:44:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659005045;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mlGuWC80SQowyHFk+tf83qBM4YxeG6g+ghu3Qk17jmU=;
        b=Jcf8xvUrJex0lrETwwz47Ca9D1z8JR4gYw0E3UYB7QDz4H39Iofulz4NDoKfYqxWkvvBHP
        v1gG3fLeHzO+brfvr8er8lhI1Fvn0MG5YEk6o1QeJTW9w60aYdJy9/1b/NXLQGZULnRuVA
        GNsBAIzmbTctePfXcD9Bpkx3fSqrO3eF2yRea6bY1mcIIj78XUEdQqLw6XVNY2VkZBYPO/
        JX2AfIBCbbDCsuVs3F76nrvipatqi/NWBZf6VF5qda5P+DukdF8IN0+NPJLFw5X9ZPy8oQ
        fOj9QNxwIXD9bTJXoLNhm0PDbAk02305M6On+XullKsRnqy+5vfDyQzR5oxgaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659005045;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mlGuWC80SQowyHFk+tf83qBM4YxeG6g+ghu3Qk17jmU=;
        b=yXAv4u+aTxUcEay+bDwENZd8oW3e2kIC6acy4fc59ucYL9Nrqw9APLNZCh3//4x37jnWoU
        gGR9iBUDtrHY2BCw==
From:   "tip-bot2 for Tony Lindgren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Make driver
 selection bool for TI K3
Cc:     Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220523151448.23732-1-tony@atomide.com>
References: <20220523151448.23732-1-tony@atomide.com>
MIME-Version: 1.0
Message-ID: <165900504458.15455.114530312687411609.tip-bot2@tip-bot2>
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

Commit-ID:     775343f9fde99b4e5e6470f9d8afd519ee67dfa3
Gitweb:        https://git.kernel.org/tip/775343f9fde99b4e5e6470f9d8afd519ee67dfa3
Author:        Tony Lindgren <tony@atomide.com>
AuthorDate:    Mon, 23 May 2022 18:14:48 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 27 Jul 2022 17:00:48 +02:00

clocksource/drivers/timer-ti-dm: Make driver selection bool for TI K3

The clocksource drivers do not currently have loadable modules as
pointed out by Daniel Lezcano <daniel.lezcano@linaro.org>.

Let's reconsider this later on once timer removal discussion has been
done, and set timer-ti-dm to bool for TI K3 SoC.

Cc: Keerthy <j-keerthy@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Link: https://lore.kernel.org/r/20220523151448.23732-1-tony@atomide.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 967dcfb..5d09cf5 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -57,7 +57,8 @@ config DIGICOLOR_TIMER
 	  Enables the support for the digicolor timer driver.
 
 config OMAP_DM_TIMER
-	tristate "OMAP dual-mode timer driver" if ARCH_K3 || COMPILE_TEST
+	bool "OMAP dual-mode timer driver" if ARCH_K3 || COMPILE_TEST
+	default y if ARCH_K3
 	select TIMER_OF
 	help
 	  Enables the support for the TI dual-mode timer driver.
