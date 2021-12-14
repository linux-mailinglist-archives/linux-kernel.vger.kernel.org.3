Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B30474DA8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 23:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238168AbhLNWF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 17:05:27 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:58734 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237924AbhLNWEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 17:04:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CDDC8CE1B01
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 22:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B019C34638;
        Tue, 14 Dec 2021 22:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639519482;
        bh=ior3Cf5eRveO57U7YvrDWK95dxKhfvpwXUGIUoZYRTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QoCIj1bZfP5jlNSY5vdm7r4OTkPdjZPW+1w41GTd00ZXu6Hky1f381ukJbIWBhv6Q
         wfKFJ7Nqe4NkKhKii/Uwsk9yKmVy/tkE3gc5p4wBphB3PedjWp6vZHPrRNbtV4u/61
         qm0zLoUJx2sgtRYDJBq6T/bdhHgpy/EURBfhm8Uckpv7E+HtezAS8pNX0/Cy4IDiYw
         OvbXZqlXO4Pg5jY99jx7nMA091ubFYJE9JOuzbdUiFGyMrQ1zSNpTj48lVEQJLfv7s
         v7suDT3id9ZbCbc2EXCZtEb4Qm6KM1nPsSw6uZWzBXEdpV1gTXAl84TLgddEikLkt0
         d7yz7cuUD8Trw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 886E05C1F98; Tue, 14 Dec 2021 14:04:41 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 24/29] compiler_attributes.h: Add __disable_sanitizer_instrumentation
Date:   Tue, 14 Dec 2021 14:04:34 -0800
Message-Id: <20211214220439.2236564-24-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211214220356.GA2236323@paulmck-ThinkPad-P17-Gen-1>
References: <20211214220356.GA2236323@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Potapenko <glider@google.com>

The new attribute maps to
__attribute__((disable_sanitizer_instrumentation)), which will be
supported by Clang >= 14.0. Future support in GCC is also possible.

This attribute disables compiler instrumentation for kernel sanitizer
tools, making it easier to implement noinstr. It is different from the
existing __no_sanitize* attributes, which may still allow certain types
of instrumentation to prevent false positives.

Signed-off-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/compiler_attributes.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index b9121afd87331..37e2600202216 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -308,6 +308,24 @@
 # define __compiletime_warning(msg)
 #endif
 
+/*
+ * Optional: only supported since clang >= 14.0
+ *
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#disable-sanitizer-instrumentation
+ *
+ * disable_sanitizer_instrumentation is not always similar to
+ * no_sanitize((<sanitizer-name>)): the latter may still let specific sanitizers
+ * insert code into functions to prevent false positives. Unlike that,
+ * disable_sanitizer_instrumentation prevents all kinds of instrumentation to
+ * functions with the attribute.
+ */
+#if __has_attribute(disable_sanitizer_instrumentation)
+# define __disable_sanitizer_instrumentation \
+	 __attribute__((disable_sanitizer_instrumentation))
+#else
+# define __disable_sanitizer_instrumentation
+#endif
+
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-weak-function-attribute
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-weak-variable-attribute
-- 
2.31.1.189.g2e36527f23

