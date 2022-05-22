Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59C75303E7
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 17:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348214AbiEVPog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 11:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348145AbiEVPob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 11:44:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241723668E
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 08:44:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9F89B80AC0
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 15:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A75C385AA;
        Sun, 22 May 2022 15:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653234267;
        bh=issCkMCtvgjOFJMYrAwxjLaKfTsyPKtkpaH6yaHo3nk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q9C/FMqIswh924to3Qp7jaIljZnpLaaKeYqsqusO7vhazCSSbw37NUGB8LKP4PPQX
         ZK8ILwCXjCulprCDNzK151akWkrgxu/EXjiDxR3WbHklzh95mZ9eRilFL4hP5Qi/rf
         +XUd0XcDaKl851xKXpDXTcY6vOpuJ8+M1YH7+87AgHfrK7TUoBKVp1svjEVBhrdm4B
         BdSDgg03pB8l/9bKYCj+dhYrYGLtc+uGi8YauAj2hJeiUphJxcqPemqyOSJ43yo1Er
         hEoUb/gJCT3CPX1hT6R8XwmXClC1M6Ccvz6KpkFtwzN7NfnTQdXVc6tnFdbZpti+FD
         sJeu+F5e8pPpQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] riscv: introduce unified static key mechanism for ISA extensions
Date:   Sun, 22 May 2022 23:35:42 +0800
Message-Id: <20220522153543.2656-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220522153543.2656-1-jszhang@kernel.org>
References: <20220522153543.2656-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, riscv has several extensions which may not be supported on
all riscv platforms, for example, FPU and so on. To support unified
kernel Image style, we need to check whether the feature is supported
or not. If the check sits at hot code path, then performance will be
impacted a lot. static key can be used to solve the issue. In the past,
FPU support has been converted to use static key mechanism. I believe
we will have similar cases in the future.

This patch tries to add an unified mechanism to use static keys for
some ISA extensions by implementing an array of default-false static keys
and enabling them when detected.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/hwcap.h | 25 +++++++++++++++++++++++++
 arch/riscv/kernel/cpufeature.c |  7 +++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 0734e42f74f2..d3e113fe7366 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -12,6 +12,7 @@
 #include <uapi/asm/hwcap.h>
 
 #ifndef __ASSEMBLY__
+#include <linux/jump_label.h>
 /*
  * This yields a mask that user programs can use to figure out what
  * instruction set this cpu supports.
@@ -55,6 +56,16 @@ enum riscv_isa_ext_id {
 	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
 };
 
+/*
+ * This enum represents the logical ID for each RISC-V ISA extension static
+ * keys. We can use static key to optimize code path if some ISA extensions
+ * are available.
+ */
+enum riscv_isa_ext_key {
+	RISCV_ISA_EXT_KEY_FPU,		/* For 'F' and 'D' */
+	RISCV_ISA_EXT_KEY_MAX,
+};
+
 struct riscv_isa_ext_data {
 	/* Name of the extension displayed to userspace via /proc/cpuinfo */
 	char uprop[RISCV_ISA_EXT_NAME_LEN_MAX];
@@ -62,6 +73,20 @@ struct riscv_isa_ext_data {
 	unsigned int isa_ext_id;
 };
 
+extern struct static_key_false riscv_isa_ext_keys[RISCV_ISA_EXT_KEY_MAX];
+
+static __always_inline int riscv_isa_ext2key(int num)
+{
+	switch (num) {
+	case RISCV_ISA_EXT_f:
+		return RISCV_ISA_EXT_KEY_FPU;
+	case RISCV_ISA_EXT_d:
+		return RISCV_ISA_EXT_KEY_FPU;
+	default:
+		return -EINVAL;
+	}
+}
+
 unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
 
 #define riscv_isa_extension_mask(ext) BIT_MASK(RISCV_ISA_EXT_##ext)
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 1b2d42d7f589..89f886b35357 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -24,6 +24,8 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
 #ifdef CONFIG_FPU
 __ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_fpu);
 #endif
+__ro_after_init DEFINE_STATIC_KEY_ARRAY_FALSE(riscv_isa_ext_keys, RISCV_ISA_EXT_KEY_MAX);
+EXPORT_SYMBOL(riscv_isa_ext_keys);
 
 /**
  * riscv_isa_extension_base() - Get base extension word
@@ -232,6 +234,11 @@ void __init riscv_fill_hwcap(void)
 			print_str[j++] = (char)('a' + i);
 	pr_info("riscv: ELF capabilities %s\n", print_str);
 
+	for_each_set_bit(i, riscv_isa, RISCV_ISA_EXT_MAX) {
+		j = riscv_isa_ext2key(i);
+		if (j >= 0)
+			static_branch_enable(&riscv_isa_ext_keys[j]);
+	}
 #ifdef CONFIG_FPU
 	if (elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D))
 		static_branch_enable(&cpu_hwcap_fpu);
-- 
2.34.1

