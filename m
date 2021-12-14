Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDAB8474DAE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 23:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238058AbhLNWFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 17:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237956AbhLNWEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 17:04:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CE1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 14:04:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 284A9CE1AFD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 22:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3386DC3462D;
        Tue, 14 Dec 2021 22:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639519482;
        bh=zXMl1fQkzzBN0oZrE6JE6Mp3+PceheRu7zyV+QlJBmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nnfGd9NjsTW8yNhydPLIW/LYnSF4TqpT9AkS8YwlERhNPy1Z/3WKVtAtRoc+y2O/P
         rpwB8W+Hniv4PrMKOB2cvi98wBVx6MmKJWe4a544MGcF8QYGM5mwfGHlzxMlY5h8iC
         LO8er9jIfFM2z3j3CBVSS2HhKK7IdaUt7V3wjzR7jHHLQbTI0sV/eLkShCWNDxB5Uo
         3u4xlp9NzgjX4WVyhJuNbpw/EeWmB4055jaIXytUziLDi/o0RSF7rr5S8RxHbIenc4
         RAZim2w/RZQ00JSOCOzeXgbr6mw9WDjgXYI0XdN1K7z4g0dWV+olQALM33+qjha2//
         IWJf5nNt152qg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 849335C1E8A; Tue, 14 Dec 2021 14:04:41 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 22/29] objtool, kcsan: Add memory barrier instrumentation to whitelist
Date:   Tue, 14 Dec 2021 14:04:32 -0800
Message-Id: <20211214220439.2236564-22-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211214220356.GA2236323@paulmck-ThinkPad-P17-Gen-1>
References: <20211214220356.GA2236323@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Adds KCSAN's memory barrier instrumentation to objtool's uaccess
whitelist.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/objtool/check.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 21735829b860c..61dfb66b30b64 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -849,6 +849,10 @@ static const char *uaccess_safe_builtin[] = {
 	"__asan_report_store16_noabort",
 	/* KCSAN */
 	"__kcsan_check_access",
+	"__kcsan_mb",
+	"__kcsan_wmb",
+	"__kcsan_rmb",
+	"__kcsan_release",
 	"kcsan_found_watchpoint",
 	"kcsan_setup_watchpoint",
 	"kcsan_check_scoped_accesses",
-- 
2.31.1.189.g2e36527f23

