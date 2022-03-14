Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3324D8E58
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 21:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245069AbiCNUkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 16:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245117AbiCNUk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 16:40:27 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441183B036
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:39:13 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id s11so5241868qtc.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZKxcoiW2sFrGr3ldNCNu9wCCT4Ol89xMsxiQLGmBKoY=;
        b=NafqdwqBPqX1R63OZ/hAYGvoxQ/pek6BrUiwCv2wZ6cM99CFM236CS3evld1rZqbWQ
         fBrkYF/Gy/oOr10gKs/wxTkI0V5OetnpRZE2+wOJd6sA9PDuWCBVEeLlpoYTae9GPFBL
         s+ZhZJOUUMYcrMiKGQ07qSQXfsZP1SOi8YClR9x3F6lmwrmBfJm+Y0B617J590+xydoW
         ZcvshNTrD8o3XreqIaUYs5dq1k5QxpvSTGxinYU3Syxe2kRiOnTAcp5UzsRZ0yh7GWGw
         sKca4VdMAMawR2GSOi1zSJNge2UMCxdd953NrAbClfFO2GP0cYIlUYH1S57X8vukyQVv
         MK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZKxcoiW2sFrGr3ldNCNu9wCCT4Ol89xMsxiQLGmBKoY=;
        b=jggbLbkV0cZ32jyTJ7/83MsRVaG5/DOpcWFC9kJXPZ6RQRR5V+ICLQMtdwhf8bfNhV
         N3FxNkAaplBM9PgmWd/YnMY9ShCEKdZp36Fxm0BnS8E9XNNVeuLk/t9SmHxxxKOyvYmo
         isdgIqWioCtDuL4ni3w6dQ8XqehiIn4VgjQ+WbXHFyMnlIBYz1q3Kj41TEYtieeEBzMq
         yvTP98PjqFtnX56x3D46QBWeMG642X+o5EbzR4p+CWCAul4d/xc130l0CEQdT8DM8hQV
         hTnTaMOY7rMnF6owS25CHmq3a7qyHwoxNcMLnpnh/vFz4lSvsSLnk7jWjZXulGsqWTC5
         RVXA==
X-Gm-Message-State: AOAM533Tj1dKTfowcp5AYKHvqRsl5k+HRjcQrzkm0eGBQ1hYe7O+6BpM
        cbAUhSXFxULEe/cS326OymoEs6nG3Ahyeg==
X-Google-Smtp-Source: ABdhPJx87e8zvfeKGO0DgQLIPimSPq8sUch7uYeU6/3YirRmK8X3plKE2KVFWpNvipVAyavaY4RInw==
X-Received: by 2002:a05:622a:107:b0:2e1:d655:cc4c with SMTP id u7-20020a05622a010700b002e1d655cc4cmr3852217qtw.669.1647290351876;
        Mon, 14 Mar 2022 13:39:11 -0700 (PDT)
Received: from rivos-atish.ba.rivosinc.com (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id j188-20020a3755c5000000b0067d1c76a09fsm8597023qkb.74.2022.03.14.13.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 13:39:11 -0700 (PDT)
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
Subject: [PATCH v6 4/6] RISC-V: Implement multi-letter ISA extension probing framework
Date:   Mon, 14 Mar 2022 13:38:43 -0700
Message-Id: <20220314203845.832648-5-atishp@rivosinc.com>
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

Multi-letter extensions can be probed using exising
riscv_isa_extension_available API now. It doesn't support versioning
right now as there is no use case for it.
Individual extension specific implementation will be added during
each extension support.

Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 18 ++++++++++++++++++
 arch/riscv/kernel/cpufeature.c | 22 ++++++++++++++++------
 2 files changed, 34 insertions(+), 6 deletions(-)

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
index b0df7eff47f7..3455fdfd680e 100644
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
@@ -172,12 +173,20 @@ void __init riscv_fill_hwcap(void)
 			if (*isa != '_')
 				--isa;
 
+#define SET_ISA_EXT_MAP(name, bit)						\
+			do {							\
+				if ((ext_end - ext == sizeof(name) - 1) &&	\
+				     !memcmp(ext, name, sizeof(name) - 1))	\
+					set_bit(bit, this_isa);			\
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
@@ -190,10 +199,11 @@ void __init riscv_fill_hwcap(void)
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
@@ -207,7 +217,7 @@ void __init riscv_fill_hwcap(void)
 	for (i = 0, j = 0; i < NUM_ALPHA_EXTS; i++)
 		if (riscv_isa[0] & BIT_MASK(i))
 			print_str[j++] = (char)('a' + i);
-	pr_info("riscv: ISA extensions %s\n", print_str);
+	pr_info("riscv: base ISA extensions %s\n", print_str);
 
 	memset(print_str, 0, sizeof(print_str));
 	for (i = 0, j = 0; i < NUM_ALPHA_EXTS; i++)
-- 
2.30.2

