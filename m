Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDD9559E26
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 18:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiFXQBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiFXQBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:01:37 -0400
Received: from forward501j.mail.yandex.net (forward501j.mail.yandex.net [5.45.198.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201055251F;
        Fri, 24 Jun 2022 09:01:34 -0700 (PDT)
Received: from myt5-30ca2e5366d2.qloud-c.yandex.net (myt5-30ca2e5366d2.qloud-c.yandex.net [IPv6:2a02:6b8:c12:fa5:0:640:30ca:2e53])
        by forward501j.mail.yandex.net (Yandex) with ESMTP id D6F5B6233EA;
        Fri, 24 Jun 2022 19:01:32 +0300 (MSK)
Received: from myt5-ca5ec8faf378.qloud-c.yandex.net (myt5-ca5ec8faf378.qloud-c.yandex.net [2a02:6b8:c12:2514:0:640:ca5e:c8fa])
        by myt5-30ca2e5366d2.qloud-c.yandex.net (mxback/Yandex) with ESMTP id qioSD0rNVz-1Vf4Z6IB;
        Fri, 24 Jun 2022 19:01:32 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1656086492;
        bh=PUG8BO7e1bq7Yd/4revT/SkW7cbQUppnFmBmmkR/A8I=;
        h=In-Reply-To:References:Date:Subject:Cc:To:From:Message-Id;
        b=sqeaDYikYQJ1uwwG/xnLpAdcfWEB/CbQU1IcQcqAfJ26vD1K27fdhBk9km5MVg8E+
         pKkBGqgypni7d3+mfzQLKMHzL1PTEpee3qdgEiTdlatWOgtg1tFx4l5rXj37SqwyBG
         qp8kW9M2MeQoZ8E9Vt0ae+2K68uiYXUX5nKdLtf0=
Authentication-Results: myt5-30ca2e5366d2.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by myt5-ca5ec8faf378.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id iVUkuL8Azf-1UMKIGh9;
        Fri, 24 Jun 2022 19:01:31 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>
Cc:     =?UTF-8?q?Jo=C3=A3o=20M=C3=A1rio=20Domingos?= 
        <joao.mario@tecnico.ulisboa.pt>, linux@yadro.com,
        Nikita Shubin <n.shubin@yadro.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v4 2/5] perf tools riscv: Add support for get_cpuid_str function
Date:   Fri, 24 Jun 2022 19:00:52 +0300
Message-Id: <20220624160117.3206-3-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220624160117.3206-1-nikita.shubin@maquefel.me>
References: <20220624160117.3206-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Shubin <n.shubin@yadro.com>

The get_cpuid_str function returns the string that
contains values of MVENDORID, MARCHID and MIMPID in
hex format separated by coma.

The values themselves are taken from first cpu entry
in "/proc/cpuid" that contains "mvendorid", "marchid"
and "mimpid".

Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
---
 tools/perf/arch/riscv/util/Build    |   1 +
 tools/perf/arch/riscv/util/header.c | 109 ++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)
 create mode 100644 tools/perf/arch/riscv/util/header.c

diff --git a/tools/perf/arch/riscv/util/Build b/tools/perf/arch/riscv/util/Build
index 7d3050134ae0..603dbb5ae4dc 100644
--- a/tools/perf/arch/riscv/util/Build
+++ b/tools/perf/arch/riscv/util/Build
@@ -1,4 +1,5 @@
 perf-y += perf_regs.o
+perf-y += header.o
 
 perf-$(CONFIG_DWARF) += dwarf-regs.o
 perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/arch/riscv/util/header.c b/tools/perf/arch/riscv/util/header.c
new file mode 100644
index 000000000000..53e8ddf7990b
--- /dev/null
+++ b/tools/perf/arch/riscv/util/header.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Implementation of get_cpuid().
+ *
+ * Author: Nikita Shubin <n.shubin@yadro.com>
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <api/fs/fs.h>
+#include <errno.h>
+#include "../../util/debug.h"
+#include "../../util/header.h"
+
+#define CPUINFO_MVEN	"mvendorid"
+#define CPUINFO_MARCH	"marchid"
+#define CPUINFO_MIMP	"mimpid"
+#define CPUINFO		"/proc/cpuinfo"
+
+static char *_get_field(const char *line)
+{
+	char *line2, *nl;
+
+	line2 = strrchr(line, ' ');
+	if (!line2)
+		return NULL;
+
+	line2++;
+	nl = strrchr(line, '\n');
+	if (!nl)
+		return NULL;
+
+	return strndup(line2, nl - line2);
+}
+
+static char *_get_cpuid(void)
+{
+	char *line = NULL;
+	char *mvendorid = NULL;
+	char *marchid = NULL;
+	char *mimpid = NULL;
+	char *cpuid = NULL;
+	int read;
+	unsigned long line_sz;
+	FILE *cpuinfo;
+
+	cpuinfo = fopen(CPUINFO, "r");
+	if (cpuinfo == NULL)
+		return cpuid;
+
+	while ((read = getline(&line, &line_sz, cpuinfo)) != -1) {
+		if (!strncmp(line, CPUINFO_MVEN, strlen(CPUINFO_MVEN))) {
+			mvendorid = _get_field(line);
+			if (!mvendorid)
+				goto free;
+		} else if (!strncmp(line, CPUINFO_MARCH, strlen(CPUINFO_MARCH))) {
+			marchid = _get_field(line);
+			if (!marchid)
+				goto free;
+		} else if (!strncmp(line, CPUINFO_MIMP, strlen(CPUINFO_MIMP))) {
+			mimpid = _get_field(line);
+			if (!mimpid)
+				goto free;
+
+			break;
+		}
+	}
+
+	if (!mvendorid || !marchid || !mimpid) {
+		cpuid = NULL;
+		goto free;
+	}
+
+	if (asprintf(&cpuid, "%s-%s-%s", mvendorid, marchid, mimpid) < 0)
+		cpuid = NULL;
+
+free:
+	fclose(cpuinfo);
+
+	if (mvendorid)
+		free(mvendorid);
+
+	if (marchid)
+		free(marchid);
+
+	if (mimpid)
+		free(mimpid);
+
+	return cpuid;
+}
+
+int get_cpuid(char *buffer, size_t sz)
+{
+	char *cpuid = _get_cpuid();
+
+	if (sz < strlen(cpuid)) {
+		free(cpuid);
+		return -EINVAL;
+	}
+
+	scnprintf(buffer, sz, "%s", cpuid);
+	return 0;
+}
+
+char *
+get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
+{
+	return _get_cpuid();
+}
-- 
2.35.1

