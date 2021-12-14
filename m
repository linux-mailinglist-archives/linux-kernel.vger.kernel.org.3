Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759CE474DA3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 23:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238087AbhLNWFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 17:05:14 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:58676 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbhLNWEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 17:04:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 01288CE1AFC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 22:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D775CC3460E;
        Tue, 14 Dec 2021 22:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639519481;
        bh=yAyOCoJJGDvbdIk/RNZfIoo28DCW9neLeBwtlx1ZsaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jmp3We0GLfAAtvTGRkKIEnA+CAvlgG53ZZ8CNv14n0K2HCo48gjpMSoFtN95DKnXt
         o4LAkRR3NrGz4VLjfhS0xpuNIsftl+QlhktgxbJazQU7Eq5s4+yILn1guHKuk1Sx6M
         orS8k60YhVRHJPMoVkduBzR2vRISvk0oAE4lvktX/qMTqsOznWZwKaU1c0NCDumhv4
         2fLgbYfQJsHhTjVrgt2GQ2mt8vZPsbWT5jqeBpQk4DFtr5BZXP/eEC89ltDjsrIOoY
         gsNAsfn3ym9uStpfbpqgtE+hPUSz9Y5KXpZy8ntOhdXEhdVs10cXAmLJDRzKD+SoXF
         YMJEMmS4HqJ2A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 66E9B5C1411; Tue, 14 Dec 2021 14:04:41 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 07/29] kcsan: Call scoped accesses reordered in reports
Date:   Tue, 14 Dec 2021 14:04:17 -0800
Message-Id: <20211214220439.2236564-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211214220356.GA2236323@paulmck-ThinkPad-P17-Gen-1>
References: <20211214220356.GA2236323@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

The scoping of an access simply denotes the scope in which it may be
reordered. However, in reports, it'll be less confusing to say the
access is "reordered". This is more accurate when the race occurred.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/kcsan_test.c |  4 ++--
 kernel/kcsan/report.c     | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index 6607292385880..6e3c2b8bc6083 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -213,9 +213,9 @@ static bool report_matches(const struct expect_report *r)
 		const bool is_atomic = (ty & KCSAN_ACCESS_ATOMIC);
 		const bool is_scoped = (ty & KCSAN_ACCESS_SCOPED);
 		const char *const access_type_aux =
-				(is_atomic && is_scoped)	? " (marked, scoped)"
+				(is_atomic && is_scoped)	? " (marked, reordered)"
 				: (is_atomic			? " (marked)"
-				   : (is_scoped			? " (scoped)" : ""));
+				   : (is_scoped			? " (reordered)" : ""));
 
 		if (i == 1) {
 			/* Access 2 */
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index fc15077991c47..1b0e050bdf6a0 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -215,9 +215,9 @@ static const char *get_access_type(int type)
 	if (type & KCSAN_ACCESS_ASSERT) {
 		if (type & KCSAN_ACCESS_SCOPED) {
 			if (type & KCSAN_ACCESS_WRITE)
-				return "assert no accesses (scoped)";
+				return "assert no accesses (reordered)";
 			else
-				return "assert no writes (scoped)";
+				return "assert no writes (reordered)";
 		} else {
 			if (type & KCSAN_ACCESS_WRITE)
 				return "assert no accesses";
@@ -240,17 +240,17 @@ static const char *get_access_type(int type)
 	case KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC:
 		return "read-write (marked)";
 	case KCSAN_ACCESS_SCOPED:
-		return "read (scoped)";
+		return "read (reordered)";
 	case KCSAN_ACCESS_SCOPED | KCSAN_ACCESS_ATOMIC:
-		return "read (marked, scoped)";
+		return "read (marked, reordered)";
 	case KCSAN_ACCESS_SCOPED | KCSAN_ACCESS_WRITE:
-		return "write (scoped)";
+		return "write (reordered)";
 	case KCSAN_ACCESS_SCOPED | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC:
-		return "write (marked, scoped)";
+		return "write (marked, reordered)";
 	case KCSAN_ACCESS_SCOPED | KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE:
-		return "read-write (scoped)";
+		return "read-write (reordered)";
 	case KCSAN_ACCESS_SCOPED | KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC:
-		return "read-write (marked, scoped)";
+		return "read-write (marked, reordered)";
 	default:
 		BUG();
 	}
-- 
2.31.1.189.g2e36527f23

