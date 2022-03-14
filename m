Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8CD4D7E85
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238029AbiCNJ3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237980AbiCNJ33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:29:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65D43EF18;
        Mon, 14 Mar 2022 02:28:20 -0700 (PDT)
Date:   Mon, 14 Mar 2022 09:28:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647250099;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=raYoc9SCPSq75ju1wtLpLgCMnDitnGTN5nsf2dGzIwg=;
        b=g3UJRN8W5Wiic5VrT5/N+KNl1srwtTNuFXIY2Jw30QREW7D8+U0nkaCZE4PUjTyoDZWsIn
        K57u1ADso6U1wZFgXbxJxyKWC+I9Km0Cr+pGu/a5qD/D07D1uJx/hC0b3B8EeVuYwBvPh0
        AUOwTgxA+tpP517kyLsrwOGebeoGvUILz7cy9e1+1HQ5a6MHVxQAusD94pVbq6aOQCh/3V
        quPaTH34ml+0wdD7HddjuApIZN4KraI1OpDobcGZH4zQ7bXP4zeALrHylwrn/pzk9V6oH0
        ySzBobtLsfPzHOCQpPsqXkM2JJp/1oaIzWajT4qbi3NyZ0IXITudACzwXU/EBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647250099;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=raYoc9SCPSq75ju1wtLpLgCMnDitnGTN5nsf2dGzIwg=;
        b=FDThq3fyGApIf9giJMDR6Gtq97AM3jwZq0CTPRyVMdF9p8UvSWHdyJoNtKN7ZPZu4jvol4
        kXYztH9iFtikR5Dg==
From:   "tip-bot2 for Guillaume Ranquet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-of: Check return value
 of of_iomap in timer_of_base_init()
Cc:     Guillaume Ranquet <granquet@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307172656.4836-1-granquet@baylibre.com>
References: <20220307172656.4836-1-granquet@baylibre.com>
MIME-Version: 1.0
Message-ID: <164725009835.16921.6234638844182639632.tip-bot2@tip-bot2>
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

Commit-ID:     4467b8bad2401794fb89a0268c8c8257180bf60f
Gitweb:        https://git.kernel.org/tip/4467b8bad2401794fb89a0268c8c8257180bf60f
Author:        Guillaume Ranquet <granquet@baylibre.com>
AuthorDate:    Mon, 07 Mar 2022 18:26:56 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 07 Mar 2022 19:21:25 +01:00

clocksource/drivers/timer-of: Check return value of of_iomap in timer_of_base_init()

of_base->base can either be iomapped using of_io_request_and_map() or
of_iomap() depending whether or not an of_base->name has been set.

Thus check of_base->base against NULL as of_iomap() does not return a
PTR_ERR() in case of error.

Fixes: 9aea417afa6b ("clocksource/drivers/timer-of: Don't request the resource by name")
Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
Link: https://lore.kernel.org/r/20220307172656.4836-1-granquet@baylibre.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-of.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
index 529cc6a..c3f54d9 100644
--- a/drivers/clocksource/timer-of.c
+++ b/drivers/clocksource/timer-of.c
@@ -157,9 +157,9 @@ static __init int timer_of_base_init(struct device_node *np,
 	of_base->base = of_base->name ?
 		of_io_request_and_map(np, of_base->index, of_base->name) :
 		of_iomap(np, of_base->index);
-	if (IS_ERR(of_base->base)) {
-		pr_err("Failed to iomap (%s)\n", of_base->name);
-		return PTR_ERR(of_base->base);
+	if (IS_ERR_OR_NULL(of_base->base)) {
+		pr_err("Failed to iomap (%s:%s)\n", np->name, of_base->name);
+		return of_base->base ? PTR_ERR(of_base->base) : -ENOMEM;
 	}
 
 	return 0;
