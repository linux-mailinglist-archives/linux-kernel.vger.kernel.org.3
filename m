Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C83F4C0358
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 21:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbiBVUtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 15:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235660AbiBVUtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:49:08 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D94BA644D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:48:34 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id z7so12955551oid.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8URXe1loYhEkYqA2mgPstYxk0kAqAk7osNiGz1KzfP4=;
        b=tkekYg+ui1gZE9tvXRPYNaXdnHSqvcZXJR3E2Vm5fQodbde1h2KEXdYVPBeSbBJrKE
         tZITXpUaJDk67Z/a7izDd9M3gsdIhhNTMcdTj6S8CxQsNWqSdzP/jKbyNPXB2oJu3avO
         3Zk4Jzm23rDMqdxFIbyWksIRJgMYHe95vMZ4pU0NzJ4BWBMvSQ1mHfq53uAu7WYa6PEM
         +utp42+TYOdOY+tnl0KO6BUIuJx91baW39b4LLo7XR8xTBndLIkdHIwQHVU5hXpmXZsc
         ZJOLoy8uvivgGGcYyqXtIuEtIJ/Cze3eAL876RuQ9h20mvCPEdnfU11wF41bvhGTyTig
         senQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8URXe1loYhEkYqA2mgPstYxk0kAqAk7osNiGz1KzfP4=;
        b=OtaV98MNSjPr+OoDzj5IIQNsuGAYml7Sxrughk6XF6XfGExLpHYQouks7bOUZgPEmB
         LIbn9G4xzELaXFNaAx0ck1ab/F7AMtHSfuNb7fNomKXE//qUNw9YDXh6SEaApTRWbgrL
         kjSNBUcFhFFV8EdNxpE7pKBvDSGk2BCpmxUtKCGayIKAOLK+pHQCjfiZ4taOS6b3KZwr
         OttU0++FdoGevmhjfQ0ezTIueBh3GvDFCCWmexGhCPPI/3I6dHbJa2HJQFGfDhpbSXTO
         ppoXNlgvrvRqhF727DCzfoxBX8tORqGzqbMSnfdiWB1fDrYzuiZ67tG4oh7hvtw9Ytn2
         AMLg==
X-Gm-Message-State: AOAM531NrxVAdcOlHH5U363vYEDpJVC6DXPw2CulQFC0cOeZt/A4JlI1
        rrf/YEzhA0+9BBE0sljs/6d54e5kxZgryQ==
X-Google-Smtp-Source: ABdhPJwB9rW8JuhYMN3o1Zy+a756u4qrYvSc4u5fAhxI6ME+4kF0AoSQeiNHi0jhT+ZAJKpoKp4vFQ==
X-Received: by 2002:aca:5b85:0:b0:2d3:fe13:177f with SMTP id p127-20020aca5b85000000b002d3fe13177fmr2847716oib.59.1645562913488;
        Tue, 22 Feb 2022 12:48:33 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id o14sm16508197oaq.37.2022.02.22.12.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 12:48:33 -0800 (PST)
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
Subject: [PATCH v5 6/6] RISC-V: Improve /proc/cpuinfo output for ISA extensions
Date:   Tue, 22 Feb 2022 12:48:11 -0800
Message-Id: <20220222204811.2281949-7-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220222204811.2281949-1-atishp@rivosinc.com>
References: <20220222204811.2281949-1-atishp@rivosinc.com>
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
 arch/riscv/include/asm/hwcap.h |  7 +++++
 arch/riscv/kernel/cpu.c        | 51 ++++++++++++++++++++++++++++++++--
 2 files changed, 56 insertions(+), 2 deletions(-)

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
index ad0a7e9f828b..031ad15a059f 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -6,6 +6,7 @@
 #include <linux/init.h>
 #include <linux/seq_file.h>
 #include <linux/of.h>
+#include <asm/hwcap.h>
 #include <asm/smp.h>
 #include <asm/pgtable.h>
 
@@ -63,12 +64,57 @@ int riscv_of_parent_hartid(struct device_node *node)
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
 	seq_puts(f, "\n");
 }
 
@@ -115,6 +161,7 @@ static int c_show(struct seq_file *m, void *v)
 	seq_printf(m, "hart\t\t: %lu\n", cpuid_to_hartid_map(cpu_id));
 	if (!of_property_read_string(node, "riscv,isa", &isa))
 		print_isa(m, isa);
+	print_isa_ext(m);
 	print_mmu(m);
 	if (!of_property_read_string(node, "compatible", &compat)
 	    && strcmp(compat, "riscv"))
-- 
2.30.2

