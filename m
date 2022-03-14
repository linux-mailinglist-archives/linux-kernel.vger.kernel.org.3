Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96A34D8E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 21:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245141AbiCNUkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 16:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245110AbiCNUka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 16:40:30 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE443AA79
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:39:19 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id v13so13361076qkv.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NrEmpomOHclDV+kQuj0wjvwONyoQAm3AKPhEX1ax17s=;
        b=H5jqZD+ybOPj9jvOGT1khK8EOCXznxHjM7UW3eRCvg1JuQYYgw/3R+pQmi8EHWtWzc
         4KI9pDN1Ghpgzgglw9kOBN+tyh9VPInf28WNsFo9MJkp6FZEh4EV90UWqAixUqe5AnMZ
         1+v+ds82XgLi03xfOBbcZP9UOu/4sComMDe2Bg46lqGZvcETO8YitlTCtzcPbdFDhbQb
         J+q0GWqnlKQ8IlgA1niXGO2RItdxbWCu0XlAs0qWE1Eyg6hJSj61YiRQrW65+heH/PJp
         N6QGyveZbHaXwuxcQUa2jHIsF+4n5IsjQo/Rx8DlP92qM3JzpfdBFx/ecoLTWvDYPUH+
         zAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NrEmpomOHclDV+kQuj0wjvwONyoQAm3AKPhEX1ax17s=;
        b=D9Mm0khBdc6brnON8wT+Itl2JVg7xBu4fS033KHMEEq4Bmb3wAoiRZQ+LSqH6yLEEU
         WlMmaOJ+RBuXr8WoU6Kc9cpvH6uHOfDVrvs21MVARqu0OM4XASq2uuQnCOnJ59Bb8TkV
         kRh84sGRoQXuO8Jbq1oE6E33JSH+xM1njLxdDT66o9vhTCSqX0aPSV/gT7LeZ/l92GUo
         19nipNyO4xVT9Qc8YuXTC/+PD82zhINptOSBitXhp+sSk46Ri7uOKAAP2QuGBBwuLoGb
         ngWvUrOk1cdETSsD1nYcz28GZm9OjX/rtexYpATZjAqTa3T4J/3nvoL8MnWCtTJm7Q+C
         NfWg==
X-Gm-Message-State: AOAM530lx26qwMJGeFe6AVn2FvqPaQxHpe3qiglI/rGAiXW8EfuWTmG3
        zQsWcGsdtf0eaAzMjDqXxIoTByqECo8Qlw==
X-Google-Smtp-Source: ABdhPJwVXuvZmuG1IiPfArhVLDTUd60rYoPE5F9UgA8JVB+HYCUAnjh6XvDRJvRl58UiYBwc2HxQgw==
X-Received: by 2002:a05:620a:28c4:b0:67d:c400:a9d7 with SMTP id l4-20020a05620a28c400b0067dc400a9d7mr5186069qkp.369.1647290357916;
        Mon, 14 Mar 2022 13:39:17 -0700 (PDT)
Received: from rivos-atish.ba.rivosinc.com (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id j188-20020a3755c5000000b0067d1c76a09fsm8597023qkb.74.2022.03.14.13.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 13:39:17 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
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
Subject: [PATCH v6 6/6] RISC-V: Improve /proc/cpuinfo output for ISA extensions
Date:   Mon, 14 Mar 2022 13:38:45 -0700
Message-Id: <20220314203845.832648-7-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220314203845.832648-1-atishp@rivosinc.com>
References: <20220314203845.832648-1-atishp@rivosinc.com>
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
Same goes for the single letter extensions as well which prints the
entire ISA string. Some of they may not be valid ISA extensions as
well (e.g 'su')

Parse only the valid & enabled ISA extension and print them.

Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h |  7 ++++
 arch/riscv/kernel/cpu.c        | 65 ++++++++++++++++++++++++++++++++--
 2 files changed, 70 insertions(+), 2 deletions(-)

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
index ad0a7e9f828b..fc115e307ef5 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -6,6 +6,7 @@
 #include <linux/init.h>
 #include <linux/seq_file.h>
 #include <linux/of.h>
+#include <asm/hwcap.h>
 #include <asm/smp.h>
 #include <asm/pgtable.h>
 
@@ -63,12 +64,72 @@ int riscv_of_parent_hartid(struct device_node *node)
 }
 
 #ifdef CONFIG_PROC_FS
+#define __RISCV_ISA_EXT_DATA(UPROP, EXTID) \
+	{							\
+		.uprop = #UPROP,				\
+		.isa_ext_id = EXTID,				\
+	}
+/**
+ * Here are the ordering rules of extension naming defined by RISC-V
+ * specification :
+ * 1. All extensions should be separated from other multi-letter extensions
+ *    from other multi-letter extensions by an underscore.
+ * 2. The first letter following the 'Z' conventionally indicates the most
+ *    closely related alphabetical extension category, IMAFDQLCBKJTPVH.
+ *    If multiple 'Z' extensions are named, they should be ordered first
+ *    by category, then alphabetically within a category.
+ * 3. Standard supervisor-level extensions (starts with 'S') should be
+ *    listed after standard unprivileged extensions.  If multiple
+ *    supervisor-level extensions are listed, they should be ordered
+ *    alphabetically.
+ * 4. Non-standard extensions (starts with 'X') must be listed after all
+ *    standard extensions. They must be separated from other multi-letter
+ *    extensions by an underscore.
+ */
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
+	for (i = 0; i <= arr_sz; i++) {
+		edata = &isa_ext_arr[i];
+		if (!__riscv_isa_extension_available(NULL, edata->isa_ext_id))
+			continue;
+		seq_printf(f, "_%s", edata->uprop);
+	}
+}
+
+/**
+ * These are the only valid base (single letter) ISA extensions as per the spec.
+ * It also specifies the canonical order in which it appears in the spec.
+ * Some of the extension may just be a place holder for now (B, K, P, J).
+ * This should be updated once corresponding extensions are ratified.
+ */
+static const char base_riscv_exts[13] = "imafdqcbkjpvh";
 
 static void print_isa(struct seq_file *f, const char *isa)
 {
-	/* Print the entire ISA as it is */
+	int i;
+
 	seq_puts(f, "isa\t\t: ");
-	seq_write(f, isa, strlen(isa));
+	/* Print the rv[64/32] part */
+	seq_write(f, isa, 4);
+	for (i = 0; i < sizeof(base_riscv_exts); i++) {
+		if (__riscv_isa_extension_available(NULL, base_riscv_exts[i] - 'a'))
+			/* Print only enabled the base ISA extensions */
+			seq_write(f, &base_riscv_exts[i], 1);
+	}
+	print_isa_ext(f);
 	seq_puts(f, "\n");
 }
 
-- 
2.30.2

