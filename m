Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AA34B17BE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 22:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344761AbiBJVkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 16:40:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344740AbiBJVki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 16:40:38 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D612710
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 13:40:39 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id t75-20020a4a3e4e000000b002e9c0821d78so8084192oot.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 13:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=saY5DtvepsvwegCELkFkB7RgpB9RohGc6lIP30RliiM=;
        b=46zfGr3Kc5ND2ogjveHMMDJajmm20RjiQ5jLchAHKSOeQKPxbVdIY+oOIVYm/iux6G
         ZW7C8F9MHh0yrmBybRjiWtF0Xu0TFxrjlGVldYLEb13JSmAp10UwNlCF/RQs3NzeLRRw
         2fy36iHMRabUOaLns1XyogS6wb2Zks+GqSdmRph/bI6MJPxl0saHoEkNH7YyzZQ4fId2
         +pOuGvF2Q4fzB5TYRyebqrzn4PKDTXp8IVhCjORaAesIgT4iGxFQTo0yXwp2hn40ig2y
         16NA6FAr6bH+/4dUQKItEPAZiRomvHhNA/crV+uSdzIGkPshdjxQ0yAaA8xLgSiwIjNe
         ZXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=saY5DtvepsvwegCELkFkB7RgpB9RohGc6lIP30RliiM=;
        b=tGnJrwyXRieBjVK7IyuHrUKJ9pgPdxKgn+6AL0VB8TI/5svTp3JZjhCHmUhrET5+1e
         926P2hqqPAJNGcTLCNFDAfNH9UpNvzOycNzFj2JEKwfwWPkz0jhd8JvA+AmOjKKrx63o
         Gy0fQzjmXmV+//KN9QAuQKsDdrE2AQsk98VOoUr65g9EEAJbhnbarpG/X7LXoPoBIk4K
         fZqlq8nXj54Lqoo0+OvKefMJLe8xrA8MAka+mm6jGwRJoVVQ6FhRyZhA8Pm6CNg6aVMZ
         aJ3j8Ljvx6EAB7GgJC9DIQXOUYeceH3MKAMcbCBZ9APfFxPgoX2o72sWn9Qi3gkVcvCe
         WChw==
X-Gm-Message-State: AOAM533ecttCTSJHWLM6LMegE849Yry154+M4E8PvMnLiED+6QKncVi/
        dQOVgfyhMjosa4GrlMVGcbx+L2RJRcOAMHbf
X-Google-Smtp-Source: ABdhPJwjL2U7/u0jBP7WaACxI4KC0/AXyKMGE0aYyO5DPcLm++C2In2k7oqNhs9hXD+RC9AH2QAtbA==
X-Received: by 2002:a05:6870:e3c6:: with SMTP id y6mr1357918oad.200.1644529238281;
        Thu, 10 Feb 2022 13:40:38 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id u5sm8700000ooo.46.2022.02.10.13.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 13:40:37 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 6/6] RISC-V: Improve /proc/cpuinfo output for ISA extensions
Date:   Thu, 10 Feb 2022 13:40:18 -0800
Message-Id: <20220210214018.55739-7-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220210214018.55739-1-atishp@rivosinc.com>
References: <20220210214018.55739-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the /proc/cpuinfo outputs the entire riscv,isa string which
is not ideal when we have multiple ISA extensions present in the ISA
string. Some of them may not be enabled in kernel as well.

Parse only the enabled ISA extension and print them in a separate row.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h |  7 ++++++
 arch/riscv/kernel/cpu.c        | 44 ++++++++++++++++++++++++++++++++--
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 170bd80da520..691fc9c8099b 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -54,6 +54,13 @@ enum riscv_isa_ext_id {
 	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
 };
 
+struct riscv_isa_ext_data {
+	/* Name of the extension displayed to userspace via /proc/cpuinfo */
+	char uprop[RISCV_ISA_EXT_NAME_LEN_MAX];
+	/* The logical ISA extension ID */
+	unsigned int isa_ext_id;
+};
+
 unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
 
 #define riscv_isa_extension_mask(ext) BIT_MASK(RISCV_ISA_EXT_##ext)
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index ad0a7e9f828b..ced7e5be8641 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -6,6 +6,7 @@
 #include <linux/init.h>
 #include <linux/seq_file.h>
 #include <linux/of.h>
+#include <asm/hwcap.h>
 #include <asm/smp.h>
 #include <asm/pgtable.h>
 
@@ -63,12 +64,50 @@ int riscv_of_parent_hartid(struct device_node *node)
 }
 
 #ifdef CONFIG_PROC_FS
+#define __RISCV_ISA_EXT_DATA(UPROP, EXTID) \
+	{							\
+		.uprop = #UPROP,				\
+		.isa_ext_id = EXTID,				\
+	}
+
+static struct riscv_isa_ext_data isa_ext_arr[] = {
+	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
+};
+
+static void print_isa_ext(struct seq_file *f)
+{
+	struct riscv_isa_ext_data *edata;
+	int i = 0, arr_sz;
+
+	arr_sz = ARRAY_SIZE(isa_ext_arr) - 1;
+
+	/* No extension support available */
+	if (arr_sz <= 0)
+		return;
+
+	seq_puts(f, "isa-ext\t\t: ");
+	for (i = 0; i <= arr_sz; i++) {
+		edata = &isa_ext_arr[i];
+		if (!__riscv_isa_extension_available(NULL, edata->isa_ext_id))
+			continue;
+		seq_printf(f, "%s ", edata->uprop);
+	}
+	seq_puts(f, "\n");
+}
 
 static void print_isa(struct seq_file *f, const char *isa)
 {
-	/* Print the entire ISA as it is */
+	char *ext_start;
+	int isa_len = strlen(isa);
+	int base_isa_len = isa_len;
+
+	ext_start = strnchr(isa, isa_len, '_');
+	if (ext_start)
+		base_isa_len = isa_len - strlen(ext_start);
+
+	/* Print only the base ISA as it is */
 	seq_puts(f, "isa\t\t: ");
-	seq_write(f, isa, strlen(isa));
+	seq_write(f, isa, base_isa_len);
 	seq_puts(f, "\n");
 }
 
@@ -115,6 +154,7 @@ static int c_show(struct seq_file *m, void *v)
 	seq_printf(m, "hart\t\t: %lu\n", cpuid_to_hartid_map(cpu_id));
 	if (!of_property_read_string(node, "riscv,isa", &isa))
 		print_isa(m, isa);
+	print_isa_ext(m);
 	print_mmu(m);
 	if (!of_property_read_string(node, "compatible", &compat)
 	    && strcmp(compat, "riscv"))
-- 
2.30.2

