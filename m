Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF46A473030
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240040AbhLMPM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 10:12:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35440 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbhLMPM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:12:26 -0500
Date:   Mon, 13 Dec 2021 16:12:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639408345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r1M+zioOBHGd0El2fLcGbxOaUdi+dU176cP2MmjhVGw=;
        b=QjplVppYpllpkNMYariDabgbvizeY6ZRQ1GYQvQct/vwXl7nkbt/Ma/NkLecJ99rr891jr
        PnPzVEZBTf6fbXJsyL3Ekp9r48mjv3Y/2g6MTUwYsNWOb0xUF+9y0cQNlXsoeobnZBBqgb
        GJaClVu5rL5Dly/KQO3+GS5j6NKp8Km/yElYmkq403fPAppxwJGi5k3/tM7nMgvA+UIMSJ
        eYgOplETqi+bYGDInWqN+NJO/I8smNd0YVcRFuQi65ZvRPagqF8qbwCGgUnBy873E4uqAo
        B6hApZsyKx6UoceY4diyVoDs8Dg7i0gD6qNk3PcuymgylWTMUJWt7NDWUiecuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639408345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r1M+zioOBHGd0El2fLcGbxOaUdi+dU176cP2MmjhVGw=;
        b=mPDD5kPotCVxfN2LYd71VfxzuhvQ9t2MWNjFuDnbOTRAuG5y2kzZ1Dz8WDBMo0IgyAvuxI
        dhqVW6WZmfUWnOAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: [PATCH v2] panic: Remove oops_id.
Message-ID: <Ybdi16aP2NEugWHq@linutronix.de>
References: <20211202142713.ofadr43tawengfw4@linutronix.de>
 <20211202144308.70fd454883c1d1e643491471@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211202144308.70fd454883c1d1e643491471@linux-foundation.org>
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
Remove the oops_id and use 0 in the output in case parser rely on it.

Link: https://bugs.debian.org/953172
Cc: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1=E2=80=A6v2:
  - Use 0 avoid breakage in parsers.

 kernel/panic.c |   19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -538,26 +538,9 @@ void oops_enter(void)
 		trigger_all_cpu_backtrace();
 }
=20
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
+	pr_warn("---[ end trace %016llx ]---\n", 0ULL);
 	pr_flush(1000, true);
 }
=20
