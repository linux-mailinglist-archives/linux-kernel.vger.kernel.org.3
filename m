Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BFC593009
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242588AbiHONfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242071AbiHONfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:35:09 -0400
X-Greylist: delayed 347 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 Aug 2022 06:35:07 PDT
Received: from forward100o.mail.yandex.net (forward100o.mail.yandex.net [37.140.190.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB8320F68;
        Mon, 15 Aug 2022 06:35:07 -0700 (PDT)
Received: from forward503p.mail.yandex.net (forward503p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:122])
        by forward100o.mail.yandex.net (Yandex) with ESMTP id 61BB052ABA4F;
        Mon, 15 Aug 2022 16:24:02 +0300 (MSK)
Received: from iva1-dcde80888020.qloud-c.yandex.net (iva1-dcde80888020.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:7695:0:640:dcde:8088])
        by forward503p.mail.yandex.net (Yandex) with ESMTP id 49E5511018E6;
        Mon, 15 Aug 2022 16:22:59 +0300 (MSK)
Received: by iva1-dcde80888020.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id BL0XdiM9S6-Mvi4Dxrs;
        Mon, 15 Aug 2022 16:22:57 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1660569778;
        bh=Pn3L6cXxvX9m7wl4hmev8LZGUCinVPWeTkQjWKkyw4Y=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=Ic1PN/9REPOl1gnzimegeayVri/yEbacitqkG72vxi/iYEZbgZh/GKBJ8KVikBmVu
         rNSIAhRerd+A+IZogTabK1I2VTuV5slOnQY3jdESYH19lPfT66eVvgeqk9upyoadN/
         DKvVG/cM3V+9jPWQkpFx0fPPWYx3jNO7Vb6CYsQ4=
Authentication-Results: iva1-dcde80888020.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     linux@yadro.com, Anup Patel <anup@brainfault.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Nikita Shubin <n.shubin@yadro.com>,
        Kautuk Consul <kconsul@ventanamicro.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v6 1/3] perf tools riscv: Add support for get_cpuid_str function
Date:   Mon, 15 Aug 2022 16:22:38 +0300
Message-Id: <20220815132251.25702-2-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815132251.25702-1-nikita.shubin@maquefel.me>
References: <20220815132251.25702-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
Tested-by: Kautuk Consul <kconsul@ventanamicro.com>
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
2.35.1

