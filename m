Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398A14B4DEF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350363AbiBNLQc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Feb 2022 06:16:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350718AbiBNLPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:15:51 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E172A1A4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:46:40 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-223-Z48kIwZ6OBWnlfFdy6e65g-1; Mon, 14 Feb 2022 05:46:36 -0500
X-MC-Unique: Z48kIwZ6OBWnlfFdy6e65g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 787313E741;
        Mon, 14 Feb 2022 10:46:34 +0000 (UTC)
Received: from x1.com (unknown [10.22.16.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C868C26DFB;
        Mon, 14 Feb 2022 10:46:19 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
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
Subject: [RFC V2 05/21] rv/include: Add tracing helper functions
Date:   Mon, 14 Feb 2022 11:44:56 +0100
Message-Id: <6b1c197c0b1dc9a27cfb71330ee2a0d670c93366.1644830251.git.bristot@kernel.org>
In-Reply-To: <cover.1644830251.git.bristot@kernel.org>
References: <cover.1644830251.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tracing helper functions to facilitate the instrumentation of
auto-generated RV monitors create by dot2k.

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
 include/rv/trace_helpers.h | 69 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 include/rv/trace_helpers.h

diff --git a/include/rv/trace_helpers.h b/include/rv/trace_helpers.h
new file mode 100644
index 000000000000..440c681148a8
--- /dev/null
+++ b/include/rv/trace_helpers.h
@@ -0,0 +1,69 @@
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
+struct tracepoint_hook_helper {
+	struct tracepoint *tp;
+	void *probe;
+	int registered;
+	char *name;
+};
+
+static inline void thh_compare_name(struct tracepoint *tp, void *priv)
+{
+	struct tracepoint_hook_helper *thh  = priv;
+
+	if (!strcmp(thh->name, tp->name))
+		thh->tp = tp;
+}
+
+static inline bool thh_fill_struct_tracepoint(struct tracepoint_hook_helper *thh)
+{
+	for_each_kernel_tracepoint(thh_compare_name, thh);
+
+	return !!thh->tp;
+}
+
+static inline void thh_unhook_probes(struct tracepoint_hook_helper *thh, int helpers_count)
+{
+	int i;
+
+	for (i = 0; i < helpers_count; i++) {
+		if (!thh[i].registered)
+			continue;
+
+		tracepoint_probe_unregister(thh[i].tp, thh[i].probe, NULL);
+	}
+}
+
+static inline int thh_hook_probes(struct tracepoint_hook_helper *thh, int helpers_count)
+{
+	int retval;
+	int i;
+
+	for (i = 0; i < helpers_count; i++) {
+		retval = thh_fill_struct_tracepoint(&thh[i]);
+		if (!retval)
+			goto out_err;
+
+		retval = tracepoint_probe_register(thh[i].tp, thh[i].probe, NULL);
+
+		if (retval)
+			goto out_err;
+
+		thh[i].registered = 1;
+	}
+	return 0;
+
+out_err:
+	thh_unhook_probes(thh, helpers_count);
+	return -EINVAL;
+}
-- 
2.33.1

