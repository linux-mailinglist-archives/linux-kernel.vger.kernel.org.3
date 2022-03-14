Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3994D7E9D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbiCNJaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238001AbiCNJ3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:29:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11D717E34;
        Mon, 14 Mar 2022 02:28:23 -0700 (PDT)
Date:   Mon, 14 Mar 2022 09:28:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647250102;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NbCJRXYb/cS6B1eEHB9xwf0U7FvtJA4bPnARLfSC9Ao=;
        b=jYeZCByJPAOt0b/l1gvzQ5Fjl3rQdLQ+QA4I3rHUtxEUeT6/y9M4hwPvnB5T+JaO1X/jHd
        sqdnkr03Z/FjhZ+ieqXFXjwVdCdVdndAj2TPuqrdqoj4klYEdxfNNbah/TmcTQIZckrH8X
        FLc3bkaN6z8F7O1Fw02ayeMXQ2TLGobqIkrwXitDPHr6EyWNbX+mZBCUKgccH2Q2YDIcmW
        pev3+uRyKazzOZGHk+H2YM+v593lpiTVU+d69xhAboh0QkHaQdBDUaU0fmrU+FCeXKfG9T
        ob16nnHU2HdXNR6Uk7YpIiyd4KxCjMV8QIpdEEh3ZGypVrqZ5bz+EY0af9T0yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647250102;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NbCJRXYb/cS6B1eEHB9xwf0U7FvtJA4bPnARLfSC9Ao=;
        b=C2ZD80ZX+B24h0B/HbntamSaAb8/7bh0Wp8VvxAQNXovrzN5t1EP8ONozHUljYzo9Al5HU
        n+U75mIQc+7hOQCQ==
From:   "tip-bot2 for Claudiu Beznea" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-microchip-pit64b: Remove
 mmio selection
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220304133601.2404086-2-claudiu.beznea@microchip.com>
References: <20220304133601.2404086-2-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Message-ID: <164725010138.16921.13269053740314917751.tip-bot2@tip-bot2>
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

Commit-ID:     34f03f7f3e9f79412b5bf8db9f2778c9ed2fd733
Gitweb:        https://git.kernel.org/tip/34f03f7f3e9f79412b5bf8db9f2778c9ed2fd733
Author:        Claudiu Beznea <claudiu.beznea@microchip.com>
AuthorDate:    Fri, 04 Mar 2022 15:35:56 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 07 Mar 2022 18:27:22 +01:00

clocksource/drivers/timer-microchip-pit64b: Remove mmio selection

PIT64B timer driver doesn't depend on CLKSRC_MMIO since
commit e85c1d21b16b ("clocksource/drivers/timer-microchip-pit64b:
Add clocksource suspend/resume"). Remove the selection.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/20220304133601.2404086-2-claudiu.beznea@microchip.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index cfb8ea0..1ea556e 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -713,7 +713,6 @@ config INGENIC_OST
 config MICROCHIP_PIT64B
 	bool "Microchip PIT64B support"
 	depends on OF || COMPILE_TEST
-	select CLKSRC_MMIO
 	select TIMER_OF
 	help
 	  This option enables Microchip PIT64B timer for Atmel
