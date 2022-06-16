Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A47654DD36
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiFPIqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359735AbiFPIp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:45:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE665DBE7;
        Thu, 16 Jun 2022 01:45:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7AA2B822A9;
        Thu, 16 Jun 2022 08:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09536C385A2;
        Thu, 16 Jun 2022 08:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655369138;
        bh=vh8GCJZdFY4jPSPg5VmzbjDbx7oE/fXp3z/xiXgywUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n1lkWXHzI+t0mDgoSWSWheuGl+Yhhd0wPSb0bVE2UysyybbErUSot7z9E6GuG8RAn
         V+IsRMk1iaRoVsYR/szBarWkL/Jw8ftsevck0e6FM5p8SGxkFNjYVYRU5GuMWipgcJ
         tJVFgctbyrPyI6QZ1uT5cR8YaccrBPy1x5wGTFHztlpTIwlSnXmA/w+e5MVhO4Sgin
         qL6wzVaBls6N5AwchaONOy4479TCsqLBqOsAXhOY/cSSYRhC8QVK44a3/7QHhB9kPU
         3z/gepmHDxOH8OtqIJnWFyXL289cn06T/HNXcgEOo2Oqc/Oxg0igioh3ykIR4KHun+
         +hkokUInw+jZw==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: [PATCH V4 05/20] rv/include: Add instrumentation helper functions
Date:   Thu, 16 Jun 2022 10:44:47 +0200
Message-Id: <858a1130aa4b3add27ca2cdc6a5490de5b06befa.1655368610.git.bristot@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655368610.git.bristot@kernel.org>
References: <cover.1655368610.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instrumentation helper functions to facilitate the instrumentation of
auto-generated RV monitors create by dot2k.

Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 include/rv/instrumentation.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 include/rv/instrumentation.h

diff --git a/include/rv/instrumentation.h b/include/rv/instrumentation.h
new file mode 100644
index 000000000000..88dd33f10827
--- /dev/null
+++ b/include/rv/instrumentation.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Helper functions to facilitate the instrumentation of auto-generated
+ * RV monitors create by dot2k.
+ *
+ * The dot2k tool is available at tools/tracing/rv/dot2/
+ *
+ * Copyright (C) 2019-2022 Daniel Bristot de Oliveira <bristot@kernel.org>
+ */
+
+#include <linux/ftrace.h>
+
+#define rv_attach_trace_probe(monitor, tp, rv_handler)					\
+	do {										\
+		check_trace_callback_type_##tp(rv_handler);				\
+		WARN_ONCE(register_trace_##tp(rv_handler, NULL),			\
+				"fail attaching " #monitor " " #tp "handler");		\
+	} while (0)
+
+#define rv_detach_trace_probe(monitor, tp, rv_handler)					\
+	do {										\
+		unregister_trace_##tp(rv_handler, NULL);				\
+	} while (0)
-- 
2.35.1

