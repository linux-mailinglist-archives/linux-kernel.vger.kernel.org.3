Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799E54632F6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 12:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241035AbhK3LtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 06:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240999AbhK3Lsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:48:41 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CEBC06175C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 03:45:21 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id z138-20020a1c7e90000000b003319c5f9164so13604850wmc.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 03:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=j+xGmYJ7a6naxsOgId4/Y5ehX22eJTAnRqZAmnKJeqk=;
        b=BIT8VeP6OqlyivV/xY4OJ8catpXBR2IJSu8XREWcZg71WaAQIG5+hSM4qIocXAFjTH
         gRBCk6dzWkb5Ke0XMnBRGHcxF+p8r7eNgJsjXXBnQa3KuFdDeGf9PY/FWud8Z5tGk0Dx
         TMS5WC/YyCMQ4Kco5Sz4NOLsAIYw94zsal4vqc8G0xrQL4bEF/N60XkvMzDgctYFiQVI
         w2/tGq06afI4dtOL8NvZqEN4Mr+YXm2ckISYsl33DE1TvSuMEVl4UjqaYZZVgMqRPAO1
         l6LV3jYTi2PS2YN1bmf1XuSMpmIqz92ZQjvfQsvKif8oMYkkNTrZf5xUTmuLXSRM453W
         WdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=j+xGmYJ7a6naxsOgId4/Y5ehX22eJTAnRqZAmnKJeqk=;
        b=MenN3b1JMyTAgqgEduPQ1sxq90Bw+OqYfpkcdmimN4aObNtj14PXrnU+Hirqz1+50D
         ChCgnL6lwp79IgrDDaqQ0jh5S0d35KDq0CXFDZbBPqgfuZJ0M57auSxTLmJGHtPFcQ2l
         OeSgZ7Fr0LberYzjuun27R2QPcP0bptB8oT2VRnOgZSYD96tWI3YVXOcz2fm1/Qnoak6
         JoB7BbIBj0SvpUaKI2X/uO9c4zTUEljxFW5rg53HOAjqjRlKzP0ApqJ3QUIZUVe+4wf+
         eCLdwap/6BcH3YWFJZKvz9zZGLhQk0IIHPYxE6plCIz1Rp0BGOIEymd4wKAMhqWrq9Kg
         /pvA==
X-Gm-Message-State: AOAM531vqmgsMFGfU3EzTRPX+i6atnWEnTAwu5G6sRuAEn1SQzLaAa3m
        8qQGL7sApPPGbMkMthxJ8ahWqwHGtQ==
X-Google-Smtp-Source: ABdhPJxMKVacuR9XDxyJLMVa2EiD6d4veLO+QybAaMsXncBxd+AFabcdu3YiPCN9Nl29f+z7+XhyR+Y0JA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:86b7:11e9:7797:99f0])
 (user=elver job=sendgmr) by 2002:a05:600c:1d1b:: with SMTP id
 l27mr624069wms.1.1638272720147; Tue, 30 Nov 2021 03:45:20 -0800 (PST)
Date:   Tue, 30 Nov 2021 12:44:15 +0100
In-Reply-To: <20211130114433.2580590-1-elver@google.com>
Message-Id: <20211130114433.2580590-8-elver@google.com>
Mime-Version: 1.0
References: <20211130114433.2580590-1-elver@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 07/25] kcsan: Call scoped accesses reordered in reports
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scoping of an access simply denotes the scope in which it may be
reordered. However, in reports, it'll be less confusing to say the
access is "reordered". This is more accurate when the race occurred.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/kcsan_test.c |  4 ++--
 kernel/kcsan/report.c     | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index 660729238588..6e3c2b8bc608 100644
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
index fc15077991c4..1b0e050bdf6a 100644
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
2.34.0.rc2.393.gf8c9666880-goog

