Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BC246653D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347390AbhLBOaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:30:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48734 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347284AbhLBOai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:30:38 -0500
Date:   Thu, 2 Dec 2021 15:27:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638455234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Gdtx2M3z+9HnZwSU5LzGV7Q21X/xsE9pdNLqQFFg4mQ=;
        b=NUbHTKZuq30rb/1XLsJzDvz193svlmcUSqygYaUvaG3sdANBC2z+Q00+sVWOdZmkdQAywS
        JyyRSgBRLHf6kH3VGa6uDH689wHUmNT/G51ro8uZvrhjzpcBEvsbJlcS18H7JFjM4FoDCL
        F850+ZsinUEzPpRapu45ze+9eK4+iAeCBi5GJCKR7xX0xoxhJtWbt37n9YjaMshBH1TkKc
        MA+s/udtcI30mjY73BUJnMAdolJqpl2y00xetWd7aGnYUVqBvFup/IQUzdNGcpoI6HS3lG
        WbI3vKNEOtiOekkAYelDnKqHagQkIOiKEFd21NgDC5pQ7ZuyrFIR39l9MG8RMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638455234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Gdtx2M3z+9HnZwSU5LzGV7Q21X/xsE9pdNLqQFFg4mQ=;
        b=NQCsqxwHzuoDHk1X7TXDCAUHLuTz0hQ/vj/Ap1UbSB1kaWXzTnkLoPTgk7XGQeAmERZz+F
        amGL6QjJGbsYacCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: [PATCH] panic: Remove oops_id.
Message-ID: <20211202142713.ofadr43tawengfw4@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The oops id has been added as part of the end of trace marker for the
kerneloops.org project. The id is used to automatically identify duplicate
submissions of the same report. Identical looking reports with different
a id can be considered as the same oops occurred again.

The early initialisation of the oops_id can create a warning if the
random core is not yet fully initialized. On PREEMPT_RT it is
problematic if the id is initialized on demand from non preemptible
context.

The kernel oops project is not available since 2017.
Remove the oops_id.

Link: https://bugs.debian.org/953172
Cc: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/panic.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 8e299cae1615e..84683d6452997 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -534,26 +534,9 @@ void oops_enter(void)
 		trigger_all_cpu_backtrace();
 }
 
-/*
- * 64-bit random ID for oopses:
- */
-static u64 oops_id;
-
-static int init_oops_id(void)
-{
-	if (!oops_id)
-		get_random_bytes(&oops_id, sizeof(oops_id));
-	else
-		oops_id++;
-
-	return 0;
-}
-late_initcall(init_oops_id);
-
 static void print_oops_end_marker(void)
 {
-	init_oops_id();
-	pr_warn("---[ end trace %016llx ]---\n", (unsigned long long)oops_id);
+	pr_warn("---[ end trace ]---\n");
 }
 
 /*
-- 
2.34.1

