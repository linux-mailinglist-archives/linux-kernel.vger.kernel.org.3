Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253A753FFFA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244696AbiFGN0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244686AbiFGN0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:26:12 -0400
X-Greylist: delayed 540 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Jun 2022 06:26:08 PDT
Received: from forward500j.mail.yandex.net (forward500j.mail.yandex.net [5.45.198.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2912AC1EDC;
        Tue,  7 Jun 2022 06:26:07 -0700 (PDT)
Received: from myt5-f0e8352497c8.qloud-c.yandex.net (myt5-f0e8352497c8.qloud-c.yandex.net [IPv6:2a02:6b8:c12:3c22:0:640:f0e8:3524])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id D93886CB6DAE;
        Tue,  7 Jun 2022 16:17:01 +0300 (MSK)
Received: from myt6-654ec0a0ab93.qloud-c.yandex.net (myt6-654ec0a0ab93.qloud-c.yandex.net [2a02:6b8:c12:1d80:0:640:654e:c0a0])
        by myt5-f0e8352497c8.qloud-c.yandex.net (mxback/Yandex) with ESMTP id 3zNxHODKJI-H0fO9MpU;
        Tue, 07 Jun 2022 16:17:01 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1654607821;
        bh=hQhndwkj71U3FGMLsP/eq3Nugqa3M1fyrFTWT3q68hQ=;
        h=In-Reply-To:References:Date:Subject:Cc:To:From:Message-Id;
        b=NJnzfUlSlee1UpmU5Dgch59/F8lXLuIVD8FhhXiFA9CJ1kWdMxKhcIdnWVy6AZTyV
         3DqZZltYprFxT3qkivpyJ0ssDY7OpxzlKcpbiyThK37jmqOpTq4pnBxIpCpTTzdWHO
         q+ZchxAeidjMHg1V/WiYd32NttwLoMnkuASiG1Ls=
Authentication-Results: myt5-f0e8352497c8.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by myt6-654ec0a0ab93.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id sOXgg17Zrk-GxM4mQbH;
        Tue, 07 Jun 2022 16:16:59 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Genevieve Chan <genevieve.chan@starfivetech.com>,
        =?UTF-8?q?Jo=C3=A3o=20M=C3=A1rio=20Domingos?= 
        <joao.mario@tecnico.ulisboa.pt>,
        Nikita Shubin <n.shubin@yadro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-riscv@lists.infradead.org (open list:RISC-V PMU DRIVERS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PMU PROFILING
        AND DEBUGGING),
        linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS
        SUBSYSTEM)
Subject: [PATCH v3 2/4] RISC-V: Support CPUID for risc-v in perf
Date:   Tue,  7 Jun 2022 16:16:45 +0300
Message-Id: <20220607131648.29439-3-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220607131648.29439-1-nikita.shubin@maquefel.me>
References: <20220607131648.29439-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: João Mário Domingos <joao.mario@tecnico.ulisboa.pt>

This patch creates the header.c file for the risc-v architecture and introduces support for
PMU identification through sysfs.
It is now possible to configure pmu-events in risc-v.

Depends on patch [1], that introduces the id sysfs file.

Signed-off-by: João Mário Domingos <joao.mario@tecnico.ulisboa.pt>
[Nikita: replaced soc:pmu to riscv-pmu/id]
Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
Tested-by: Nikita Shubin <n.shubin@yadro.com>
---
v2->v3:
- Change 'soc/soc:pmu/id' to 'riscv-pmu/id'
---
 drivers/perf/riscv_pmu.c            | 18 ++++++++
 tools/perf/arch/riscv/util/Build    |  1 +
 tools/perf/arch/riscv/util/header.c | 66 +++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+)
 create mode 100644 tools/perf/arch/riscv/util/header.c

diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
index b2b8d2074ed0..d1aa4e0e527f 100644
--- a/drivers/perf/riscv_pmu.c
+++ b/drivers/perf/riscv_pmu.c
@@ -17,6 +17,23 @@
 
 #include <asm/sbi.h>
 
+PMU_FORMAT_ATTR(event, "config:0-63");
+
+static struct attribute *riscv_arch_formats_attr[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+static struct attribute_group riscv_pmu_format_group = {
+	.name = "format",
+	.attrs = riscv_arch_formats_attr,
+};
+
+static const struct attribute_group *riscv_pmu_attr_groups[] = {
+	&riscv_pmu_format_group,
+	NULL,
+};
+
 static unsigned long csr_read_num(int csr_num)
 {
 #define switchcase_csr_read(__csr_num, __val)		{\
@@ -307,6 +324,7 @@ struct riscv_pmu *riscv_pmu_alloc(void)
 			cpuc->events[i] = NULL;
 	}
 	pmu->pmu = (struct pmu) {
+		.attr_groups	= riscv_pmu_attr_groups,
 		.event_init	= riscv_pmu_event_init,
 		.add		= riscv_pmu_add,
 		.del		= riscv_pmu_del,
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
index 000000000000..98d40b87c9f3
--- /dev/null
+++ b/tools/perf/arch/riscv/util/header.c
@@ -0,0 +1,66 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <api/fs/fs.h>
+#include <errno.h>
+#include "../../util/debug.h"
+#include "../../util/header.h"
+
+#define STR_LEN 1024
+#define ID_SIZE 64
+
+static int _get_cpuid(char *buf, size_t sz)
+{
+	const char *sysfs = sysfs__mountpoint();
+	u64 id = 0;
+	char path[PATH_MAX];
+	FILE *file;
+
+	if (!sysfs || sz < ID_SIZE)
+		return -EINVAL;
+
+	scnprintf(path, PATH_MAX, "%s/devices/platform/riscv-pmu/id",
+			sysfs);
+
+	file = fopen(path, "r");
+	if (!file) {
+		pr_debug("fopen failed for file %s\n", path);
+		return -EINVAL;
+	}
+	if (!fgets(buf, ID_SIZE, file)) {
+		fclose(file);
+		return -EINVAL;
+	}
+
+	fclose(file);
+
+	/*Check if value is numeric and remove special characters*/
+	id = strtoul(buf, NULL, 16);
+	if (!id)
+		return -EINVAL;
+	scnprintf(buf, ID_SIZE, "0x%lx", id);
+
+	return 0;
+}
+
+char *get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
+{
+	char *buf = NULL;
+	int res;
+
+	if (!pmu)
+		return NULL;
+
+	buf = malloc(ID_SIZE);
+	if (!buf)
+		return NULL;
+
+	/* read id */
+	res = _get_cpuid(buf, ID_SIZE);
+	if (res) {
+		pr_err("failed to get cpuid string for PMU %s\n", pmu->name);
+		free(buf);
+		buf = NULL;
+	}
+
+	return buf;
+}
-- 
2.35.1

