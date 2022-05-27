Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E295F535B93
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349692AbiE0IgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236827AbiE0Ify (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:35:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50A8F1364;
        Fri, 27 May 2022 01:35:52 -0700 (PDT)
Date:   Fri, 27 May 2022 08:35:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653640550;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/mCZR0KCO84rakvSVekvJ+wGhtqPya4dke5Wz4fL3yo=;
        b=2zjC35//WZAjc0SWjhhywFdqFz4gbDZkpdlJFOnU95MQ1/x0QM/LYnF61Azy50l0/HlNSP
        QG+M+LaKxqlaBFG0w27H7baC6JO0AjauD7SAvN2AkV/DP0mt63XLNcZHKvm4bGfYur3VlZ
        HExVRHVwl68R+vqmv0fFgfncRCl7w9nyQG3j8ywO4xYxLPfye3D33Uz+EDZ7OGdUy7/ZBw
        +jurIyhi8tBNw4BCUi5FYuRELge1c/a3W720KetqtgTeKwnU9UVdDUK0GIVQpNlEa7Q2rq
        8PN1KhT+HiHBbxfE+3R1Mpkj4cLXwqBsBeY7/ssMUHnYpKrUvZQtuZEVMdsFuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653640550;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/mCZR0KCO84rakvSVekvJ+wGhtqPya4dke5Wz4fL3yo=;
        b=+JKlF67pyqA6hp8lIyIFnMRrejIcr1ObxZ32rYFXf9xxlWidM1y+AS5yo9xoAu0cqIP59h
        NfWyG5OaDqsGusDw==
From:   "tip-bot2 for Dan Carpenter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Remove
 unnecessary NULL check
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YoZM65RFDQAfqV6J@kili>
References: <YoZM65RFDQAfqV6J@kili>
MIME-Version: 1.0
Message-ID: <165364054912.4207.16238719218842755254.tip-bot2@tip-bot2>
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

Commit-ID:     8c0d9461ab760439b09ae321803ee85df1136e08
Gitweb:        https://git.kernel.org/tip/8c0d9461ab760439b09ae321803ee85df1136e08
Author:        Dan Carpenter <dan.carpenter@oracle.com>
AuthorDate:    Thu, 19 May 2022 16:58:23 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 24 May 2022 09:16:29 +02:00

clocksource/drivers/timer-ti-dm: Remove unnecessary NULL check

The "pdata" pointer cannot be NULL because it's checked at the start of
the function.  Delete the check.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/YoZM65RFDQAfqV6J@kili
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-ti-dm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 3e52c52..33609be 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -828,8 +828,7 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 		cpu_pm_register_notifier(&timer->nb);
 	}
 
-	if (pdata)
-		timer->errata = pdata->timer_errata;
+	timer->errata = pdata->timer_errata;
 
 	timer->pdev = pdev;
 
