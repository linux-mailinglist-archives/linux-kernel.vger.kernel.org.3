Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4F8581F0A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 06:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240382AbiG0Ej3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 00:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240396AbiG0EjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 00:39:25 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53A73DF1B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 21:39:23 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ku18so15314269pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 21:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=72mc9rV+Or/UCSUqmbngTq+GJzkxqJLuquOjL+k6DMk=;
        b=RUBWXp3346mGXGsT/osQGMIKkSCA7yBvKUWTxP6L7ZIoPDHhZWW3FU0T2eh8E66tQu
         639S1w9a6BlXBIGp2jX6yp5WT2gYUDqvnvYRa4cuHGwRQ3xENfJv/A+KPLMCA3EUsGhI
         hgzz0vAqmQoeaVWvPbRpm/8xi0fiS2xSf1wsACbKru8KFtUNsK0c+O+stYy2n8GxyAim
         qrRUEbZGWGVSDoicrAUaKPzTHfVF23eXYxcO/PIFW5gbXJPU5+tynMvpsPUogKKg9d1P
         nG3fUHb7Ln1NJ3aU99x6VeKAkO2mWvEMaPOxwSYv7hAZvbO88LjX9WrifLX3tfQWSyE+
         ihNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=72mc9rV+Or/UCSUqmbngTq+GJzkxqJLuquOjL+k6DMk=;
        b=zO2MDSmx0R5gm8Si4ZRg7T5LPUN60Ir4Q6NwYYScx8hFxoF7yjSA3Wol+wcJaKvgVv
         QOFCSO5G2to+DI4m5G5oWQum1QiPuZWbSubMPa/FWoXsA1WUDmzEohZYagmdjbZ5S9jK
         mLUQIUMRtdW0WHgeT6JzhkF6khPLI1fkla9rQBYM6r9vHqaqoWB+MdFK+zLp9RTvu45M
         8KewkzE4lQ1ez8y+1EynjQws/UZIrN0+gM117z95WPKCzzG8dtGTMN6UKYHK/DKbOLJj
         Kh2lOtz3+nslNy3uit3Tv6NTMwXOL2B2VfvBDInNnezeYTwqXSIcSOfYdxwuGB8P/QbC
         Kv7Q==
X-Gm-Message-State: AJIora9Q/RP38wQO1BtmH18jQ4AAKA4Xq8jUNmaQtGTit0kHG9iUPII6
        /67BhVKFn+GU3BNxlOdJt1qilw==
X-Google-Smtp-Source: AGRyM1sye5+G+KwpZYkgsqAmcItRzmgg5pY5UJAmggWcyiP+mzsHBRWAibIrbpUGHL0TCdZYem73+g==
X-Received: by 2002:a17:902:7143:b0:16d:986c:f2f9 with SMTP id u3-20020a170902714300b0016d986cf2f9mr7136604plm.42.1658896763327;
        Tue, 26 Jul 2022 21:39:23 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.87.63])
        by smtp.gmail.com with ESMTPSA id p2-20020a17090a284200b001f216407204sm500698pjf.36.2022.07.26.21.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 21:39:22 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Atish Patra <atishp@atishpatra.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Nikita Shubin <n.shubin@yadro.com>
Subject: [PATCH v2] RISC-V: Add mvendorid, marchid, and mimpid to /proc/cpuinfo output
Date:   Wed, 27 Jul 2022 10:08:29 +0530
Message-Id: <20220727043829.151794-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Identifying the underlying RISC-V implementation can be important
for some of the user space applications. For example, the perf tool
uses arch specific CPU implementation id (i.e. CPUID) to select a
JSON file describing custom perf events on a CPU.

Currently, there is no way to identify RISC-V implementation so we
add mvendorid, marchid, and mimpid to /proc/cpuinfo output.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Tested-by: Nikita Shubin <n.shubin@yadro.com>
---
Changes since v1:
 - Use IS_ENABLED() to check CONFIG defines
 - Added RB and TB tags in commit description
---
 arch/riscv/kernel/cpu.c | 51 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index fba9e9f46a8c..04bcc91c91ea 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -3,10 +3,13 @@
  * Copyright (C) 2012 Regents of the University of California
  */
 
+#include <linux/cpu.h>
 #include <linux/init.h>
 #include <linux/seq_file.h>
 #include <linux/of.h>
+#include <asm/csr.h>
 #include <asm/hwcap.h>
+#include <asm/sbi.h>
 #include <asm/smp.h>
 #include <asm/pgtable.h>
 
@@ -64,6 +67,50 @@ int riscv_of_parent_hartid(struct device_node *node)
 }
 
 #ifdef CONFIG_PROC_FS
+
+struct riscv_cpuinfo {
+	unsigned long mvendorid;
+	unsigned long marchid;
+	unsigned long mimpid;
+};
+static DEFINE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
+
+static int riscv_cpuinfo_starting(unsigned int cpu)
+{
+	struct riscv_cpuinfo *ci = this_cpu_ptr(&riscv_cpuinfo);
+
+#if IS_ENABLED(CONFIG_RISCV_SBI)
+	ci->mvendorid = sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
+	ci->marchid = sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
+	ci->mimpid = sbi_spec_is_0_1() ? 0 : sbi_get_mimpid();
+#elif IS_ENABLED(CONFIG_RISCV_M_MODE)
+	ci->mvendorid = csr_read(CSR_MVENDORID);
+	ci->marchid = csr_read(CSR_MARCHID);
+	ci->mimpid = csr_read(CSR_MIMPID);
+#else
+	ci->mvendorid = 0;
+	ci->marchid = 0;
+	ci->mimpid = 0;
+#endif
+
+	return 0;
+}
+
+static int __init riscv_cpuinfo_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "riscv/cpuinfo:starting",
+				riscv_cpuinfo_starting, NULL);
+	if (ret < 0) {
+		pr_err("cpuinfo: failed to register hotplug callbacks.\n");
+		return ret;
+	}
+
+	return 0;
+}
+device_initcall(riscv_cpuinfo_init);
+
 #define __RISCV_ISA_EXT_DATA(UPROP, EXTID) \
 	{							\
 		.uprop = #UPROP,				\
@@ -178,6 +225,7 @@ static int c_show(struct seq_file *m, void *v)
 {
 	unsigned long cpu_id = (unsigned long)v - 1;
 	struct device_node *node = of_get_cpu_node(cpu_id, NULL);
+	struct riscv_cpuinfo *ci = per_cpu_ptr(&riscv_cpuinfo, cpu_id);
 	const char *compat, *isa;
 
 	seq_printf(m, "processor\t: %lu\n", cpu_id);
@@ -188,6 +236,9 @@ static int c_show(struct seq_file *m, void *v)
 	if (!of_property_read_string(node, "compatible", &compat)
 	    && strcmp(compat, "riscv"))
 		seq_printf(m, "uarch\t\t: %s\n", compat);
+	seq_printf(m, "mvendorid\t: 0x%lx\n", ci->mvendorid);
+	seq_printf(m, "marchid\t\t: 0x%lx\n", ci->marchid);
+	seq_printf(m, "mimpid\t\t: 0x%lx\n", ci->mimpid);
 	seq_puts(m, "\n");
 	of_node_put(node);
 
-- 
2.34.1

