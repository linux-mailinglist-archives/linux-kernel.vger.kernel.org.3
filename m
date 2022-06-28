Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEB555D945
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344470AbiF1Lrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345348AbiF1LrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:47:25 -0400
Received: from forward500o.mail.yandex.net (forward500o.mail.yandex.net [37.140.190.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E638132055;
        Tue, 28 Jun 2022 04:46:50 -0700 (PDT)
Received: from vla1-d53b4f396d89.qloud-c.yandex.net (vla1-d53b4f396d89.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:b8c:0:640:d53b:4f39])
        by forward500o.mail.yandex.net (Yandex) with ESMTP id 26B4F944B2A;
        Tue, 28 Jun 2022 14:46:49 +0300 (MSK)
Received: from vla3-178a3f795968.qloud-c.yandex.net (vla3-178a3f795968.qloud-c.yandex.net [2a02:6b8:c15:2584:0:640:178a:3f79])
        by vla1-d53b4f396d89.qloud-c.yandex.net (mxback/Yandex) with ESMTP id shX8vltbCi-klf4VlmY;
        Tue, 28 Jun 2022 14:46:49 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1656416809;
        bh=2/6RMvAXK2iD9AZRDQ9gg5xO/5zbiLVsv0H//9xZIDA=;
        h=In-Reply-To:References:Date:Subject:Cc:To:From:Message-Id;
        b=sl5Mzu5Ig9R8ynXv8QtUBqWYcIPYbeVE2X741qhvMD3WXpDu+9UKMWl9YvxdaVPHT
         qlROEU4obY84Txlo5Nyw7OsnwgkkaS6S3VJ2tqC8RGkrNgU2857MgIgWm1HYgpQVHN
         svjG3dQdYlqUF+J7SJbXdRNk60hH7vWT4nAwylpk=
Authentication-Results: vla1-d53b4f396d89.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by vla3-178a3f795968.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id s5dKAuvn1y-kjMCPfi8;
        Tue, 28 Jun 2022 14:46:46 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     linux@yadro.com, Genevieve Chan <genevieve.chan@starfivetech.com>,
        =?UTF-8?q?Jo=C3=A3o=20M=C3=A1rio=20Domingos?= 
        <joao.mario@tecnico.ulisboa.pt>,
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
Subject: [PATCH v5] perf tools riscv: Add support for get_cpuid_str function
Date:   Tue, 28 Jun 2022 14:45:56 +0300
Message-Id: <20220628114625.166665-3-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220628114625.166665-1-nikita.shubin@maquefel.me>
References: <20220628114625.166665-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
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
v4->v5:
- fixed cpuid leakage
- no "if" before free
- don't set cpuid to NULL, just goto free
---
 tools/perf/arch/riscv/util/Build    |   1 +
 tools/perf/arch/riscv/util/header.c | 104 ++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)
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
index 000000000000..4a41856938a8
--- /dev/null
+++ b/tools/perf/arch/riscv/util/header.c
@@ -0,0 +1,104 @@
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
+	if (!mvendorid || !marchid || !mimpid)
+		goto free;
+
+	if (asprintf(&cpuid, "%s-%s-%s", mvendorid, marchid, mimpid) < 0)
+		cpuid = NULL;
+
+free:
+	fclose(cpuinfo);
+	free(mvendorid);
+	free(marchid);
+	free(mimpid);
+
+	return cpuid;
+}
+
+int get_cpuid(char *buffer, size_t sz)
+{
+	char *cpuid = _get_cpuid();
+	int ret = 0;
+
+	if (sz < strlen(cpuid)) {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	scnprintf(buffer, sz, "%s", cpuid);
+free:
+	free(cpuid);
+	return ret;
+}
+
+char *
+get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
+{
+	return _get_cpuid();
+}
-- 
2.30.2

