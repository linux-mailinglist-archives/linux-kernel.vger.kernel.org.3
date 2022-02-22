Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697EC4C0356
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 21:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbiBVUtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 15:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbiBVUs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:48:56 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4865A41BB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:48:30 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id j9-20020a9d7d89000000b005ad5525ba09so8209992otn.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7jxshT1pWA/8RZp0d4XCT2f4zJBopPI7Okk1zgrv3jU=;
        b=rcW/NJ3twEXUjUwMjHFOr2n4rYJi5TW0BSWPqI5ZoOTC69sMiCT7h39r/USkVKIYHO
         0J2flxYvVc4S5GlpKiyqWPWZ12NjMFEZGGXqZRYLd8u4IZRM3jsapeRiUNIB4Kz4YNRJ
         vsGUv/doyie+sOOkt9MyiQT0aCPc58B6+vDRtK7Yssu/yQahgZlZSKXETmW/M9H5q/mt
         1iZCAQKnBPTdewg+SDGiRZcm49aAaAXE2pJsqwZxZPvb/9VFXrTEfSbspTuz4j/rAm0C
         UizPz/QaiZZRMKTsJoQ2BABJCcmgTTyz82uJGl8xZhvsrVXCxkwaDOh75iEcoNCtrPVY
         DzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7jxshT1pWA/8RZp0d4XCT2f4zJBopPI7Okk1zgrv3jU=;
        b=LW+tNpVFWg5MmlsiM8ILPm5/LQX/ty4RBbqS2FYei/HQt8ne0D81SELIDev79oKHW6
         Za82JF66AtepY8FZiU5tr4YyZQiD1egU5T+BaMaPhXCaMz2SsII4UhLk5UjURloMuHf5
         VNvKwtroTBZzQRJ6g9lx6rWSGZa3DtsAgA41XapSDFFnrvP3z/0CW2yEk3qvPcbD+j5E
         kvkSkHZ3aobpuDfhppHzyijNbzDMzBkHfT2xh3JFhlEM6WiPKGLJZxflauUuPFtGal3Z
         HWeG5lzfBMppMYzoHhP2pzDKiRdvLNkRS8blzpZIP7TZJcts0OPivuuuQwyvXvyOTog2
         u3fw==
X-Gm-Message-State: AOAM533zlzV0vJyPTPr2qQ724KupJ6jdFmq1RR8oTTd31FLiOYAJUHAU
        ehnmYcqDZ/WKPDJ+8haO/4Bo2/csoHXyog==
X-Google-Smtp-Source: ABdhPJziqVBxNlzDAcUXnP8ghiwG6ffgujh/J8VzWwqr8QmDfZL1gilLS0gYfHzMF0NzxkkbF/GKGQ==
X-Received: by 2002:a05:6830:410b:b0:5af:432e:e375 with SMTP id w11-20020a056830410b00b005af432ee375mr3276695ott.191.1645562909675;
        Tue, 22 Feb 2022 12:48:29 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id o14sm16508197oaq.37.2022.02.22.12.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 12:48:29 -0800 (PST)
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
Subject: [PATCH v5 4/6] RISC-V: Implement multi-letter ISA extension probing framework
Date:   Tue, 22 Feb 2022 12:48:09 -0800
Message-Id: <20220222204811.2281949-5-atishp@rivosinc.com>
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

Multi-letter extensions can be probed using exising
riscv_isa_extension_available API now. It doesn't support versioning
right now as there is no use case for it.
Individual extension specific implementation will be added during
each extension support.

Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 18 ++++++++++++++++++
 arch/riscv/kernel/cpufeature.c | 24 ++++++++++++++++++------
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 5ce50468aff1..170bd80da520 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -34,7 +34,25 @@ extern unsigned long elf_hwcap;
 #define RISCV_ISA_EXT_s		('s' - 'a')
 #define RISCV_ISA_EXT_u		('u' - 'a')
 
+/*
+ * Increse this to higher value as kernel support more ISA extensions.
+ */
 #define RISCV_ISA_EXT_MAX	64
+#define RISCV_ISA_EXT_NAME_LEN_MAX 32
+
+/* The base ID for multi-letter ISA extensions */
+#define RISCV_ISA_EXT_BASE 26
+
+/*
+ * This enum represent the logical ID for each multi-letter RISC-V ISA extension.
+ * The logical ID should start from RISCV_ISA_EXT_BASE and must not exceed
+ * RISCV_ISA_EXT_MAX. 0-25 range is reserved for single letter
+ * extensions while all the multi-letter extensions should define the next
+ * available logical extension id.
+ */
+enum riscv_isa_ext_id {
+	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
+};
 
 unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index b0df7eff47f7..c6693873e95c 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -83,7 +83,7 @@ void __init riscv_fill_hwcap(void)
 
 	for_each_of_cpu_node(node) {
 		unsigned long this_hwcap = 0;
-		unsigned long this_isa = 0;
+		DECLARE_BITMAP(this_isa, RISCV_ISA_EXT_MAX);
 
 		if (riscv_of_processor_hartid(node) < 0)
 			continue;
@@ -100,6 +100,7 @@ void __init riscv_fill_hwcap(void)
 		if (!strncmp(isa, "rv64", 4))
 			isa += 4;
 #endif
+		bitmap_zero(this_isa, RISCV_ISA_EXT_MAX);
 		for (; *isa; ++isa) {
 			const char *ext = isa++;
 			const char *ext_end = isa;
@@ -172,12 +173,22 @@ void __init riscv_fill_hwcap(void)
 			if (*isa != '_')
 				--isa;
 
+#define SET_ISA_EXT_MAP(name, bit)						\
+			do {							\
+				if ((ext_end - ext == sizeof(name) - 1) &&	\
+				     !memcmp(ext, name, sizeof(name) - 1)) {    \
+					set_bit(bit, this_isa);			\
+					pr_info("Found ISA extension %s", name);\
+				}						\
+			} while (false)						\
+
 			if (unlikely(ext_err))
 				continue;
 			if (!ext_long) {
 				this_hwcap |= isa2hwcap[(unsigned char)(*ext)];
-				this_isa |= (1UL << (*ext - 'a'));
+				set_bit(*ext - 'a', this_isa);
 			}
+#undef SET_ISA_EXT_MAP
 		}
 
 		/*
@@ -190,10 +201,11 @@ void __init riscv_fill_hwcap(void)
 		else
 			elf_hwcap = this_hwcap;
 
-		if (riscv_isa[0])
-			riscv_isa[0] &= this_isa;
+		if (bitmap_weight(riscv_isa, RISCV_ISA_EXT_MAX))
+			bitmap_and(riscv_isa, riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
 		else
-			riscv_isa[0] = this_isa;
+			bitmap_copy(riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
+
 	}
 
 	/* We don't support systems with F but without D, so mask those out
@@ -207,7 +219,7 @@ void __init riscv_fill_hwcap(void)
 	for (i = 0, j = 0; i < NUM_ALPHA_EXTS; i++)
 		if (riscv_isa[0] & BIT_MASK(i))
 			print_str[j++] = (char)('a' + i);
-	pr_info("riscv: ISA extensions %s\n", print_str);
+	pr_info("riscv: base ISA extensions %s\n", print_str);
 
 	memset(print_str, 0, sizeof(print_str));
 	for (i = 0, j = 0; i < NUM_ALPHA_EXTS; i++)
-- 
2.30.2

