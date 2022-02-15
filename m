Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED884B66DD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbiBOJDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:03:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbiBOJC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:02:57 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5701160D3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:02:39 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id z15so146452qtx.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tvH+QlgZ/sWTfV6i2aUa3kw0ko5FhadKBSyH+clOvO0=;
        b=zDOmDakQzSP/7sYVbqUvgTuqj3R9yqw9Io/yxg0eMVPUCokXz05l725Roqs13h03JD
         BW5lBqOCdY/gs2ZQZgoXuo59dK7DiiAmXU3sTp2opcf8b8eyCEQvJyCyFOCMk+ZRPuKk
         J5MAL1FANaw0dRduBoLdPyQR34ITQkk7JBUBnanfPZ3HLkS9s7itxzo6ZI6SQTd3f4H1
         yfEha9FrysXE0pWov5Qav7AJFN+0wNW0v66l3I74aIq+aFJ/rFL016DdnN1vN0dGtKWk
         urU5TJzGKLu7VRgb9zliqAEdmSTu2CUiT4Q+RkpF2YamgfgavQBU9E6NYyvCA25mN/D7
         2HyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tvH+QlgZ/sWTfV6i2aUa3kw0ko5FhadKBSyH+clOvO0=;
        b=iEGtbJYONjHMvAuwpWiwAOArfFwcRBTpVfGvEyeDUZ0J1MhH46BEmEycDKKTe5fqVO
         JC1KcKEOFAO4NYQ2aEbMI32grvcDodqqXt2CjUPVXky8uevzSopLTdbgYFcKnrRyJtou
         bLSbqj9+UEIg8rPYeHErJPNppxtokxie67nJ3unRdEKkw44D01eg4b4PeCyvWCJIhH9h
         AUXF72vF/vX+ZNG7sKeYenVFXOdOVEDci5YTSmhtdq/NmOy4c+6fOhc8i5Qs+VsBdFVD
         JGQEpYqzDwSCJcqwiVYwgnARTOPyTlptSR2hljO49Mn0w2rpDtaZTyMp5F4EttRLRLMv
         7swQ==
X-Gm-Message-State: AOAM532b3su17Xu+chHcAQMy1qiJ8KSLDnOZ3RerkXCYf5z1GNchGCec
        8X5Yz3nNIc2uZHYYvFrivbTjm9iBaV2ZSC5N
X-Google-Smtp-Source: ABdhPJxlQfhS9S4weNHZVTY2A2fhMEBUPvoDEPwMIijVKZ9lCBMABQvdT0Ef3nN/KBssjp9v9AHT8w==
X-Received: by 2002:ac8:41cf:: with SMTP id o15mr1951017qtm.254.1644915758374;
        Tue, 15 Feb 2022 01:02:38 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id w4sm17711158qko.123.2022.02.15.01.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 01:02:37 -0800 (PST)
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
Subject: [PATCH v3 4/6] RISC-V: Implement multi-letter ISA extension probing framework
Date:   Tue, 15 Feb 2022 01:02:09 -0800
Message-Id: <20220215090211.911366-5-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220215090211.911366-1-atishp@rivosinc.com>
References: <20220215090211.911366-1-atishp@rivosinc.com>
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

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 18 ++++++++++++++++++
 arch/riscv/kernel/cpufeature.c | 27 ++++++++++++++++++++++++---
 2 files changed, 42 insertions(+), 3 deletions(-)

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
index cd9eb34f8d11..af9a57ad3d4e 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -83,7 +83,7 @@ void __init riscv_fill_hwcap(void)
 
 	for_each_of_cpu_node(node) {
 		unsigned long this_hwcap = 0;
-		unsigned long this_isa = 0;
+		uint64_t this_isa = 0;
 
 		if (riscv_of_processor_hartid(node) < 0)
 			continue;
@@ -167,12 +167,22 @@ void __init riscv_fill_hwcap(void)
 			if (*isa != '_')
 				--isa;
 
+#define SET_ISA_EXT_MAP(name, bit)						\
+			do {							\
+				if ((ext_end - ext == sizeof(name) - 1) &&	\
+				     !memcmp(ext, name, sizeof(name) - 1)) {    \
+					this_isa |= (1UL << bit);		\
+					pr_info("Found ISA extension %s", name);\
+				}						\
+			} while (false)						\
+
 			if (unlikely(ext_err))
 				continue;
 			if (!ext_long) {
 				this_hwcap |= isa2hwcap[(unsigned char)(*ext)];
 				this_isa |= (1UL << (*ext - 'a'));
 			}
+#undef SET_ISA_EXT_MAP
 		}
 
 		/*
@@ -185,10 +195,21 @@ void __init riscv_fill_hwcap(void)
 		else
 			elf_hwcap = this_hwcap;
 
-		if (riscv_isa[0])
+		if (riscv_isa[0]) {
+#if IS_ENABLED(CONFIG_32BIT)
+			riscv_isa[0] &= this_isa & 0xFFFFFFFF;
+			riscv_isa[1] &= this_isa >> 32;
+#else
 			riscv_isa[0] &= this_isa;
-		else
+#endif
+		} else {
+#if IS_ENABLED(CONFIG_32BIT)
+			riscv_isa[0] = this_isa & 0xFFFFFFFF;
+			riscv_isa[1] = this_isa >> 32;
+#else
 			riscv_isa[0] = this_isa;
+#endif
+		}
 	}
 
 	/* We don't support systems with F but without D, so mask those out
-- 
2.30.2

