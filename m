Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0BE474D68
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 22:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237828AbhLNV4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 16:56:38 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:36572 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbhLNV4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 16:56:33 -0500
Received: by mail-ot1-f47.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so22504750otl.3;
        Tue, 14 Dec 2021 13:56:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qe7cPB7ERis8/iDHDPVd+TJRCDPd6RhcsB1dakTgtUM=;
        b=acEtz/HmGWglQybcNcSEDnUYIIhsFnY2ExiejNpvqzdmEEmHkLG1OAxHzdoWkUJ0ue
         KFDIDkPNeECYy006x7YR25opDFfJTeNMypz1NlvG7BC/of8I7gZvNB2fRUlQ9LxQrWbp
         6kEGnS58qZmq9Rp2u2mVZoCILqaiqkpXDvJaUHsNAGkF2ZpnuBR0VO7JOYdDiSQp9QW2
         lXRtghyuESUlhX/5SsLbopgqydB3dKQhHaK34d1BVbKh47m4D11kocvMBd0XUnxDaZYX
         5Da2COhhM7hF4I8M9zho29pXdDQoaWGKXG0bHBqVZ9okDgS180YwwxjcwYrIbjpN2jCP
         AfFg==
X-Gm-Message-State: AOAM531LNl7PGIri5zfw8hHGqQITHgiHiZ+eND8QgdUkK5VyUqBVND+O
        WLr9Katw1444bl1Nfwwb4A==
X-Google-Smtp-Source: ABdhPJzFNS94lSMpQRAXBpVbhM4ypHJlli53gSBxd7G9uSv+jHqo1d8x3rZk7WJO0HhjRVhqG42HQw==
X-Received: by 2002:a9d:7a42:: with SMTP id z2mr6492158otm.362.1639518992628;
        Tue, 14 Dec 2021 13:56:32 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id c8sm4691otk.40.2021.12.14.13.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 13:56:31 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8] libperf: Add arm64 support to perf_mmap__read_self()
Date:   Tue, 14 Dec 2021 15:56:30 -0600
Message-Id: <20211214215630.4025090-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the arm64 variants for read_perf_counter() and read_timestamp().
Unfortunately the counter number is encoded into the instruction, so the
code is a bit verbose to enumerate all possible counters.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v8:
 - Set attr.config1 to request user access on arm64
v7:
 - Move enabling of libperf user read test for arm64 to this patch
---
 tools/lib/perf/mmap.c             | 98 +++++++++++++++++++++++++++++++
 tools/lib/perf/tests/test-evsel.c |  5 +-
 2 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
index c89dfa5f67b3..7ee3eb9f5e27 100644
--- a/tools/lib/perf/mmap.c
+++ b/tools/lib/perf/mmap.c
@@ -13,6 +13,7 @@
 #include <internal/lib.h>
 #include <linux/kernel.h>
 #include <linux/math64.h>
+#include <linux/stringify.h>
 #include "internal.h"
 
 void perf_mmap__init(struct perf_mmap *map, struct perf_mmap *prev,
@@ -294,6 +295,103 @@ static u64 read_timestamp(void)
 
 	return low | ((u64)high) << 32;
 }
+#elif defined(__aarch64__)
+#define read_sysreg(r) ({						\
+	u64 __val;							\
+	asm volatile("mrs %0, " __stringify(r) : "=r" (__val));		\
+	__val;								\
+})
+
+static u64 read_pmccntr(void)
+{
+	return read_sysreg(pmccntr_el0);
+}
+
+#define PMEVCNTR_READ(idx)					\
+	static u64 read_pmevcntr_##idx(void) {			\
+		return read_sysreg(pmevcntr##idx##_el0);	\
+	}
+
+PMEVCNTR_READ(0);
+PMEVCNTR_READ(1);
+PMEVCNTR_READ(2);
+PMEVCNTR_READ(3);
+PMEVCNTR_READ(4);
+PMEVCNTR_READ(5);
+PMEVCNTR_READ(6);
+PMEVCNTR_READ(7);
+PMEVCNTR_READ(8);
+PMEVCNTR_READ(9);
+PMEVCNTR_READ(10);
+PMEVCNTR_READ(11);
+PMEVCNTR_READ(12);
+PMEVCNTR_READ(13);
+PMEVCNTR_READ(14);
+PMEVCNTR_READ(15);
+PMEVCNTR_READ(16);
+PMEVCNTR_READ(17);
+PMEVCNTR_READ(18);
+PMEVCNTR_READ(19);
+PMEVCNTR_READ(20);
+PMEVCNTR_READ(21);
+PMEVCNTR_READ(22);
+PMEVCNTR_READ(23);
+PMEVCNTR_READ(24);
+PMEVCNTR_READ(25);
+PMEVCNTR_READ(26);
+PMEVCNTR_READ(27);
+PMEVCNTR_READ(28);
+PMEVCNTR_READ(29);
+PMEVCNTR_READ(30);
+
+/*
+ * Read a value direct from PMEVCNTR<idx>
+ */
+static u64 read_perf_counter(unsigned int counter)
+{
+	static u64 (* const read_f[])(void) = {
+		read_pmevcntr_0,
+		read_pmevcntr_1,
+		read_pmevcntr_2,
+		read_pmevcntr_3,
+		read_pmevcntr_4,
+		read_pmevcntr_5,
+		read_pmevcntr_6,
+		read_pmevcntr_7,
+		read_pmevcntr_8,
+		read_pmevcntr_9,
+		read_pmevcntr_10,
+		read_pmevcntr_11,
+		read_pmevcntr_13,
+		read_pmevcntr_12,
+		read_pmevcntr_14,
+		read_pmevcntr_15,
+		read_pmevcntr_16,
+		read_pmevcntr_17,
+		read_pmevcntr_18,
+		read_pmevcntr_19,
+		read_pmevcntr_20,
+		read_pmevcntr_21,
+		read_pmevcntr_22,
+		read_pmevcntr_23,
+		read_pmevcntr_24,
+		read_pmevcntr_25,
+		read_pmevcntr_26,
+		read_pmevcntr_27,
+		read_pmevcntr_28,
+		read_pmevcntr_29,
+		read_pmevcntr_30,
+		read_pmccntr
+	};
+
+	if (counter < ARRAY_SIZE(read_f))
+		return (read_f[counter])();
+
+	return 0;
+}
+
+static u64 read_timestamp(void) { return read_sysreg(cntvct_el0); }
+
 #else
 static u64 read_perf_counter(unsigned int counter __maybe_unused) { return 0; }
 static u64 read_timestamp(void) { return 0; }
diff --git a/tools/lib/perf/tests/test-evsel.c b/tools/lib/perf/tests/test-evsel.c
index 33ae9334861a..89be89afb24d 100644
--- a/tools/lib/perf/tests/test-evsel.c
+++ b/tools/lib/perf/tests/test-evsel.c
@@ -130,6 +130,9 @@ static int test_stat_user_read(int event)
 	struct perf_event_attr attr = {
 		.type	= PERF_TYPE_HARDWARE,
 		.config	= event,
+#ifdef __aarch64__
+		.config1 = 0x2,		/* Request user access */
+#endif
 	};
 	int err, i;
 
@@ -150,7 +153,7 @@ static int test_stat_user_read(int event)
 	pc = perf_evsel__mmap_base(evsel, 0, 0);
 	__T("failed to get mmapped address", pc);
 
-#if defined(__i386__) || defined(__x86_64__)
+#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
 	__T("userspace counter access not supported", pc->cap_user_rdpmc);
 	__T("userspace counter access not enabled", pc->index);
 	__T("userspace counter width not set", pc->pmc_width >= 32);
-- 
2.32.0

