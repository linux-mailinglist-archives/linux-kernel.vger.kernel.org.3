Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38517469EA2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385569AbhLFPnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386664AbhLFP0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:26:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10A0C061354;
        Mon,  6 Dec 2021 07:17:22 -0800 (PST)
Date:   Mon, 06 Dec 2021 15:15:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638803751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iJQf/9nrvDzpoXrQFytyK1Bn+kAavcB53pXJuJLKM/8=;
        b=3wHX2C/Sha4t8YKIMx5/ES7gNfTSOUzy6FWFdn30tfq4TZP3czNjWpnfOpohTguXu1yRNG
        d/8K8C7kP8gjdUObE+jQ3J8Z9vraKyaLmP32YgIrdh/0eOBSlE0EEIpb1KPl/WdO8P9Hgl
        oqKeSLqvTRY9mtULgvPlNj0y0RceHrPRb81qtpjIEUyDGQy1/PVzuWdYRwxdc5NXDwDGwh
        ENrtoPhFsiZKQtu6VwwzD/U0SpsIQ5vECMKarqWmJ51o5fGSApPihMOUGecnDCKKFw41az
        Eq2Y5YvO1GTBQkXb+3P/xkSJJ1tiRL6jRTO5QlkhJ3b7tHJTV6yPMGPVoveZKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638803751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iJQf/9nrvDzpoXrQFytyK1Bn+kAavcB53pXJuJLKM/8=;
        b=plwbOJKL2UV1df+bJ145ScO3NFQGbF/Cnh3wVB/gqdsYxDCAPbXDleOphHOsHqqkPPQs5v
        CpWOrciWq0SL/eAg==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] sched: Trigger warning if ->migration_disabled
 counter underflows.
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211129174654.668506-2-bigeasy@linutronix.de>
References: <20211129174654.668506-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <163880375014.11128.11566339706185975718.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9d0df37797453f168afdb2e6fd0353c73718ae9a
Gitweb:        https://git.kernel.org/tip/9d0df37797453f168afdb2e6fd0353c73718ae9a
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 29 Nov 2021 18:46:44 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 04 Dec 2021 10:56:22 +01:00

sched: Trigger warning if ->migration_disabled counter underflows.

If migrate_enable() is used more often than its counter part then it
remains undetected and rq::nr_pinned will underflow, too.

Add a warning if migrate_enable() is attempted if without a matching a
migrate_disable().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20211129174654.668506-2-bigeasy@linutronix.de
---
 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3c9b0fd..300218a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2173,6 +2173,9 @@ void migrate_enable(void)
 		return;
 	}
 
+	if (WARN_ON_ONCE(!p->migration_disabled))
+		return;
+
 	/*
 	 * Ensure stop_task runs either before or after this, and that
 	 * __set_cpus_allowed_ptr(SCA_MIGRATE_ENABLE) doesn't schedule().
