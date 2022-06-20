Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4485517E0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241055AbiFTL45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242040AbiFTL4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:56:52 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD5C17E11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:56:47 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h192so10108423pgc.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rI0zAiF6+xouFdkf88WxUsEVQ+mvGqHQih04lexR5nU=;
        b=n1R4AymCtdjuMbvvEWoz/d9pnN3llJKP2G7oN4iZfCbG7/Y0GGXIzu6B1PssT/sF/d
         CWsYvD6uglFULOhQdMIaOXecbMrj6pXPakW4qweTQCkmeC9zn8lW70vQp6sgr5FR9dcm
         X6yQyWVqwwZJAwVDUYgCXeN5Q6arTIdHxRaquhWKB9qWoTjswJuOkEpGynPqbYXrqZLT
         4b2WfwwmuarH2Y9DoxINyGvy1pqUg+LZyGsufMWArb3aNSJYeGCQRD0nNWun/WVaUbhG
         UH7Ci/jtHZgZO1Xe/UBBrQ0Zvw/rP4jd7TlsbeLDv04g5JFoU9H1ElEQe4nxhDqZAgpT
         yykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rI0zAiF6+xouFdkf88WxUsEVQ+mvGqHQih04lexR5nU=;
        b=OnZqWeFbV9vvOFQrEhO+CIEqe8UIvXNSDBB4TKYwnw8B34uE+Ert188MpmauYbi3pG
         dpy49HBM4o7PMG7VuQIEs7Sv1u/mvm9qET+KAScIDl7NT3MlIC2ztssRHdjs+7zF+usL
         j9qGzIW0CdwF/u2BcBtMfherlWSN2ea3gNblO5OC4YiOypa90Gg3XaleH0WMLZLfP8vK
         oLLNtPH9Mt2pu3eNO5IdVVkIhEIBd9UHUCv+FW904PcWFrZkPMufFQX8MEgCQ6BRNqdE
         H1LXC1KFpMZ8lYNtk29mMfJVUkdVi5lDfD3ja176HIlmXVK9inujwdFAX0ugMT+7rF5M
         o9Ig==
X-Gm-Message-State: AJIora91TxyJLeqUGS1skeyqBxuEWCaUgTVOKiIbcyx3I4X/RCS22hrP
        U22w3PJQlZUZRuqvaXjEwM/Iqg==
X-Google-Smtp-Source: AGRyM1vC//SgXgox2YN72+b7ZCp08BereLLgLXewSNx2DC5V6PNqDmhpgdYQAR8ndKksIX1jIkydNg==
X-Received: by 2002:a65:668b:0:b0:3f6:4026:97cd with SMTP id b11-20020a65668b000000b003f6402697cdmr21086549pgw.420.1655726207401;
        Mon, 20 Jun 2022 04:56:47 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([122.167.110.75])
        by smtp.gmail.com with ESMTPSA id iy22-20020a170903131600b0016a1d007637sm2756809plb.110.2022.06.20.04.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 04:56:46 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Atish Patra <atishp@atishpatra.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH] RISC-V: Add mvendorid, marchid, and mimpid to /proc/cpuinfo output
Date:   Mon, 20 Jun 2022 17:25:49 +0530
Message-Id: <20220620115549.1529597-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
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

Identifying the underlying RISC-V implementation can be important
for some of the user space applications. For example, the perf tool
uses arch specific CPU implementation id (i.e. CPUID) to select a
JSON file describing custom perf events on a CPU.

Currently, there is no way to identify RISC-V implementation so we
add mvendorid, marchid, and mimpid to /proc/cpuinfo output.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/kernel/cpu.c | 51 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index fba9e9f46a8c..c037b8691bbb 100644
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
+#if defined(CONFIG_RISCV_SBI)
+	ci->mvendorid = sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
+	ci->marchid = sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
+	ci->mimpid = sbi_spec_is_0_1() ? 0 : sbi_get_mimpid();
+#elif defined(CONFIG_RISCV_M_MODE)
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

