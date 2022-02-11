Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0024B234F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349047AbiBKKfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:35:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349032AbiBKKfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:35:07 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7961CEB1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:35:06 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t8-20020a259ac8000000b00619a3b5977fso17999380ybo.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zI7UttEId1m8qD/b8dbgmy1+n+4tYzA6No79RQaEvJg=;
        b=c95z3s6HerUsvP/6fia6eJdMvptjfAevj7eDXrXgwIk+/Yf1znUfb9oQkMdkukkGxo
         /NqRN6P/TR/OZgj3LaDZza8AEC1H/0xz/5VKrU72Vfaeze5e9ZGStAeEN7V7WuzLKfU5
         WOU5qYZ7Q2y0t3BDkFPJ1BMwqNwqlVaVTolLTpGlPMdSst9KaiBCS5Ls0CGq9NIKrkLD
         skEflOenO7ka0YxTJqL2cSVyBut2gJDQLX9m7BfEhm+xP4MPnl6Yx+ONFzEsTmdYiRT5
         NdgL+/eiQFsuP5u/4IRBw2MLSecRQ8PbLZlhXTmcvRh8w8NIRYAB2aiK+PXuK4zZ+Rc2
         zJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zI7UttEId1m8qD/b8dbgmy1+n+4tYzA6No79RQaEvJg=;
        b=tykJOBTyF8Y9lwa7ma+hCc6T8PlHw9rOkp2cv5xiFZ8ZZ2bzIJEyJ2IgLUquNKzVXi
         U813UM8cQsXGEQEl2y8lXbZluIVFdtQnNyN7WRgl6H2gDR0/Y0+nOsW2mGmijpeL5cRP
         GmtoOft1UrC4s2uKtlrMQ0RVkOoaTm0RLlIs0TRdfXQOzDLt17HSeZYD04DbtyoZf/ta
         iX/9CEs3FG4fIC+N69OY7RVxc+yG3m2iex6Mpq4su264GyJSZcegEnm28e0DJ8WDNA1b
         DWBVzfLqzObikgSZ9e7QrCS+oROkMahy5rrKY8y7GSVY5pgGS0lMaRx58MwDrgPVupz9
         2CZQ==
X-Gm-Message-State: AOAM530Qao0YGRmJRC8rsfaDo0PKPfs8RDM1DJYnJxCUyEhgD2Tg7PNG
        /Ie5oD10mdOLicr/anYmW4DTuSsOsZRC
X-Google-Smtp-Source: ABdhPJyR3EAY6q+MUpkB9EnOpbAkDmuicacRDgwQL12qDtgndGv3SRuWrd0G2nqwMG5XhpypEUcVLVx/mWE5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2d98:3ad9:1d8a:fb9b])
 (user=irogers job=sendgmr) by 2002:a81:3350:: with SMTP id
 z77mr859862ywz.281.1644575705706; Fri, 11 Feb 2022 02:35:05 -0800 (PST)
Date:   Fri, 11 Feb 2022 02:34:11 -0800
In-Reply-To: <20220211103415.2737789-1-irogers@google.com>
Message-Id: <20220211103415.2737789-19-irogers@google.com>
Mime-Version: 1.0
References: <20220211103415.2737789-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v3 18/22] libperf: Add reference count checking macros.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Hao Luo <haoluo@google.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macros serve as a way to debug use of a reference counted struct.
The macros add a memory allocated pointer that is interposed between
the reference counted original struct at a get and freed by a put.
The pointer replaces the original struct, so use of the struct name
via APIs remains unchanged.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/internal/rc_check.h | 94 ++++++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 tools/lib/perf/include/internal/rc_check.h

diff --git a/tools/lib/perf/include/internal/rc_check.h b/tools/lib/perf/include/internal/rc_check.h
new file mode 100644
index 000000000000..30d12f9c7b52
--- /dev/null
+++ b/tools/lib/perf/include/internal/rc_check.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_RC_CHECK_H
+#define __LIBPERF_INTERNAL_RC_CHECK_H
+
+#include <stdlib.h>
+#include <linux/zalloc.h>
+
+/*
+ * Shared reference count checking macros.
+ *
+ * Reference count checking is an approach to sanitizing the use of reference
+ * counted structs. It leverages address and leak sanitizers to make sure gets
+ * are paired with a put. Reference count checking adds a malloc-ed layer of
+ * indirection on a get, and frees it on a put. A missed put will be reported as
+ * a memory leak. A double put will be reported as a double free. Accessing
+ * after a put will cause a use-after-free and/or a segfault.
+ */
+
+#ifndef REFCNT_CHECKING
+/* Replaces "struct foo" so that the pointer may be interposed. */
+#define DECLARE_RC_STRUCT(struct_name)		\
+	struct struct_name
+
+/* Declare a reference counted struct variable. */
+#define RC_STRUCT(struct_name) struct struct_name
+
+/*
+ * Interpose the indirection. Result will hold the indirection and object is the
+ * reference counted struct.
+ */
+#define ADD_RC_CHK(result, object) (result = object, object)
+
+/* Strip the indirection layer. */
+#define RC_CHK_ACCESS(object) object
+
+/* Frees the object and the indirection layer. */
+#define RC_CHK_FREE(object) free(object)
+
+/* A get operation adding the indirection layer. */
+#define RC_CHK_GET(result, object) ADD_RC_CHK(result, object)
+
+/* A put operation removing the indirection layer. */
+#define RC_CHK_PUT(object) {}
+
+#else
+
+/* Replaces "struct foo" so that the pointer may be interposed. */
+#define DECLARE_RC_STRUCT(struct_name)			\
+	struct original_##struct_name;			\
+	struct struct_name {				\
+		struct original_##struct_name *orig;	\
+	};						\
+	struct original_##struct_name
+
+/* Declare a reference counted struct variable. */
+#define RC_STRUCT(struct_name) struct original_##struct_name
+
+/*
+ * Interpose the indirection. Result will hold the indirection and object is the
+ * reference counted struct.
+ */
+#define ADD_RC_CHK(result, object)					\
+	(								\
+		object ? (result = malloc(sizeof(*result)),		\
+			result ? (result->orig = object, result)	\
+			: (result = NULL, NULL))			\
+		: (result = NULL, NULL)					\
+		)
+
+/* Strip the indirection layer. */
+#define RC_CHK_ACCESS(object) object->orig
+
+/* Frees the object and the indirection layer. */
+#define RC_CHK_FREE(object)			\
+	do {					\
+		zfree(&object->orig);		\
+		free(object);			\
+	} while(0)
+
+/* A get operation adding the indirection layer. */
+#define RC_CHK_GET(result, object) ADD_RC_CHK(result, (object ? object->orig : NULL))
+
+/* A put operation removing the indirection layer. */
+#define RC_CHK_PUT(object)			\
+	do {					\
+		if (object) {			\
+			object->orig = NULL;	\
+			free(object);		\
+		}				\
+	} while(0)
+
+#endif
+
+#endif /* __LIBPERF_INTERNAL_RC_CHECK_H */
-- 
2.35.1.265.g69c8d7142f-goog

