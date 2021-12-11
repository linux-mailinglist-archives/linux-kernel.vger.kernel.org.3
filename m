Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458134713E8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 14:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhLKNFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 08:05:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54052 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhLKNFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 08:05:12 -0500
Date:   Sat, 11 Dec 2021 13:05:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639227910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D3ctdrVj6nKFrEs1bAgueLTOyfAoH/GU8M7/7WDrgck=;
        b=k3E9c2ngg2Szy59U+UpHjtI4ErIfFsaIzRGfh55cjCEYKadx/zIELB3vMtpsU3Q8Uv5GE1
        uCRhAkaygIy1coq9IaUyGjQTGCrRY4cTaOL+uLn/pQZKCQxHzr+wUnybAsYOQkIFzWxoBk
        lbxyq8Jv0fl7XY9Rte5+UCA2TG7ovrBSbOAwf4wd8nw1ZZysLx4ZvZz8YGG6b2H/8v2/Ff
        tn7wFCgP9KSc53U/KNuIUGDOA7/yM4vOww9FLN/a6a8o90ZYZX+KP1eXhaXFABHd2QGBTo
        lCScAwtLKb5+3q0na6Nrfs+X/TweL0BBncysNvUCsssAX/sTQzqEcUcZrZVsAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639227910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D3ctdrVj6nKFrEs1bAgueLTOyfAoH/GU8M7/7WDrgck=;
        b=OnE5NjQ44Ors/JSENu9Vp/FbZTQOwMKw3njRNXMXqMvLcPi1DO3sACFG4kt33oMT54cImc
        8Z0Ayz6GCH4K9sDg==
From:   "tip-bot2 for Alexey Sheplyakov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] clocksource/drivers/dw_apb_timer_of: Fix probe failure
Cc:     "Vadim V. Vlasov" <vadim.vlasov@elpitech.ru>,
        Alexey Sheplyakov <asheplyakov@basealt.ru>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211109153401.157491-1-asheplyakov@basealt.ru>
References: <20211109153401.157491-1-asheplyakov@basealt.ru>
MIME-Version: 1.0
Message-ID: <163922790985.23020.256879773025764473.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     a663bd19114d79f0902e2490fc484e5a7419cdc2
Gitweb:        https://git.kernel.org/tip/a663bd19114d79f0902e2490fc484e5a7419cdc2
Author:        Alexey Sheplyakov <asheplyakov@basealt.ru>
AuthorDate:    Tue, 09 Nov 2021 19:34:02 +04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 10 Dec 2021 17:46:54 +01:00

clocksource/drivers/dw_apb_timer_of: Fix probe failure

The driver refuses to probe with -EINVAL since the commit 5d9814df0aec
("clocksource/drivers/dw_apb_timer_of: Add error handling if no clock
available").

Before the driver used to probe successfully if either "clock-freq" or
"clock-frequency" properties has been specified in the device tree.

That commit changed

if (A && B)
	panic("No clock nor clock-frequency property");

into

if (!A && !B)
	return 0;

That's a bug: the reverse of `A && B` is '!A || !B', not '!A && !B'

Signed-off-by: Vadim V. Vlasov <vadim.vlasov@elpitech.ru>
Signed-off-by: Alexey Sheplyakov <asheplyakov@basealt.ru>
Fixes: 5d9814df0aec56a6 ("clocksource/drivers/dw_apb_timer_of: Add error handling if no clock available").
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vadim V. Vlasov <vadim.vlasov@elpitech.ru>
Acked-by: Dinh Nguyen <dinguyen@kernel.org>
Link: https://lore.kernel.org/r/20211109153401.157491-1-asheplyakov@basealt.ru
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/dw_apb_timer_of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
index 3819ef5..3245eb0 100644
--- a/drivers/clocksource/dw_apb_timer_of.c
+++ b/drivers/clocksource/dw_apb_timer_of.c
@@ -47,7 +47,7 @@ static int __init timer_get_base_and_rate(struct device_node *np,
 			pr_warn("pclk for %pOFn is present, but could not be activated\n",
 				np);
 
-	if (!of_property_read_u32(np, "clock-freq", rate) &&
+	if (!of_property_read_u32(np, "clock-freq", rate) ||
 	    !of_property_read_u32(np, "clock-frequency", rate))
 		return 0;
 
