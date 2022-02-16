Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7524B7BED
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 01:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245097AbiBPA3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 19:29:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244663AbiBPA3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 19:29:43 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894EAF70E3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 16:29:32 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id d84so367297qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 16:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=saY5DtvepsvwegCELkFkB7RgpB9RohGc6lIP30RliiM=;
        b=WeZDZR/wgQ3HJBPaI1lbXHd1ymtPQLDkS89Y+hauG1FO7BiVnsUlJENU/aTTHJpzEc
         froSAw9Ech0bJ+/c1Eraap/5RgylGvP7owPvkrrM6DFIeriyFvDtSEYJItciK+P4Q+a4
         ZP5M4HEm1g7/v2Ef94+/nNSZaRNRm8L84VFyZ6sXbTE9YoJyfSqPFlpxEIik7YVM+TbG
         N8fGGs4RzKaRlfIuJqT0RWYV9frhIGhYUyECWmefGtcKfY7AIBCPxirqDhAOIxi/Bpbz
         kEwPGV+cemQeaXAUaJayW4Hiez9IXaR63DTPml67Vo00MLrsCxo9jgVcVldPNI7DRUsX
         0VBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=saY5DtvepsvwegCELkFkB7RgpB9RohGc6lIP30RliiM=;
        b=lCl+5rlL6YgIHt7Dd9yAIhRrR0nFQQpG3zCltLiolA3LxXy/lJhS5gNauSkMizzqv+
         AyZcOrHu7E7QJmJ3d8f4piaDVDEpiXjYhSYrpY8J8W+IKVBM4PmvGD06dIBWeXhvf9dd
         kORY/NFliP5V+Nb4aX5V1r+97WQCWlQYtlsvKJ/B7V+YvHDQTRmI540OpuACtWPuvUMd
         mLaRSfkNC+cDmAsOi8QybGxh9t2GV7XTO4My4pp08tyERMY09km6rFSUSi45XHBCrGen
         72EmR/7FKYVGpQE5Qpv63eAizcrTTWSqmok5/h7k1h9dQUeXSqn3o2ErWokrdasJiE6l
         cgJA==
X-Gm-Message-State: AOAM531sLD/Z+p99aTyvs62olBmZ/MlsMJGpDLKH1fw+hzLxT85C6fAF
        rQz2Qi06JgXGGVKQP75JIMyiN6xbuiz0FPwB
X-Google-Smtp-Source: ABdhPJxgLsfYpRA+QvmhMNAXVF99c28x84OUD52yELKhbQvJUdEA4sPu3mofe6wteSIvVcp8Ebs2nQ==
X-Received: by 2002:a37:d2c7:0:b0:47b:4cd8:5dbc with SMTP id f190-20020a37d2c7000000b0047b4cd85dbcmr187629qkj.567.1644971371452;
        Tue, 15 Feb 2022 16:29:31 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id g21sm20882584qtb.70.2022.02.15.16.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 16:29:31 -0800 (PST)
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
        Paul Walmsley <paul.walmsley@sifive.com>, heiko@sntech.de,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 6/6] RISC-V: Improve /proc/cpuinfo output for ISA extensions
Date:   Tue, 15 Feb 2022 16:29:11 -0800
Message-Id: <20220216002911.1219593-7-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220216002911.1219593-1-atishp@rivosinc.com>
References: <20220216002911.1219593-1-atishp@rivosinc.com>
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

