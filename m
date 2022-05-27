Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EC8535B85
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243824AbiE0If6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241387AbiE0Ifx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:35:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5032F1356;
        Fri, 27 May 2022 01:35:52 -0700 (PDT)
Date:   Fri, 27 May 2022 08:35:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653640549;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RQk3XeCftUXv6jIxvFP8/sBrU2Gn7eBN/AOYqVB1ujU=;
        b=eYevdyTLTJHsS+Oif2EqXcKWOePiv+5yzW7xsbhylW8GOGO25Lsg/j6erkIMJ29mJYHZKn
        TSJcKFH+djYBFEgXJVe2xEiypuHt7pDlu7o12O6NFF4kgRuyeUzBlR1EylAjSajpZYXklt
        GpBGxpl8mq8NK4JxU2gcKEoGFOx3+T85INpqUPB4qZ/xejF8yynre+ryNB9PI+O0xg8ZR0
        kjMMXMhuwSXmdC7v4ZhScEedGPEvBMfL5Tem2ikSsBC7R20JDfv59BH6B/Py8zrgKSUtna
        zCLsjX7jSYixJtTcMrwWn7aoeD5KBBQLakwHWY7l/1Tg3MHBV9LzKywasW5wSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653640549;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RQk3XeCftUXv6jIxvFP8/sBrU2Gn7eBN/AOYqVB1ujU=;
        b=fbWdx09gsYeeA34K095IDEj046HVMvaSDk+eO4MHMcWuv2b6Jjhb+btk9ZRpq+7L2OMsPR
        N6MRN9bBuvrOeYBQ==
From:   "tip-bot2 for Krzysztof Kozlowski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/oxnas-rps: Fix
 irq_of_parse_and_map() return value
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220422104101.55754-1-krzysztof.kozlowski@linaro.org>
References: <20220422104101.55754-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Message-ID: <165364054751.4207.12591932253297497747.tip-bot2@tip-bot2>
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

Commit-ID:     9c04a8ff03def4df3f81219ffbe1ec9b44ff5348
Gitweb:        https://git.kernel.org/tip/9c04a8ff03def4df3f81219ffbe1ec9b44ff5348
Author:        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
AuthorDate:    Fri, 22 Apr 2022 12:41:01 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 24 May 2022 09:16:29 +02:00

clocksource/drivers/oxnas-rps: Fix irq_of_parse_and_map() return value

The irq_of_parse_and_map() returns 0 on failure, not a negative ERRNO.

Fixes: 89355274e1f7 ("clocksource/drivers/oxnas-rps: Add Oxford Semiconductor RPS Dual Timer")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://lore.kernel.org/r/20220422104101.55754-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-oxnas-rps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-oxnas-rps.c b/drivers/clocksource/timer-oxnas-rps.c
index 56c0cc3..d514b44 100644
--- a/drivers/clocksource/timer-oxnas-rps.c
+++ b/drivers/clocksource/timer-oxnas-rps.c
@@ -236,7 +236,7 @@ static int __init oxnas_rps_timer_init(struct device_node *np)
 	}
 
 	rps->irq = irq_of_parse_and_map(np, 0);
-	if (rps->irq < 0) {
+	if (!rps->irq) {
 		ret = -EINVAL;
 		goto err_iomap;
 	}
