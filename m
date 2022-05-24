Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F295332E9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 23:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241893AbiEXVUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 17:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235550AbiEXVT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 17:19:59 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7EA56FB4
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 14:19:58 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y199so17507703pfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 14:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AOOnQwX8FlMZPsRjdPt59x3rx2ygNvknjVlpR0iASV4=;
        b=YrTSwufLEZ1P7/fW0b/k6bLAK/RaBs/rYT5zdNK+AgXQ3AfBxedshAwy/hCIaDeMum
         63fAA5CXnCSlev0yz8w5zJhf+Gl71NBw+ln88+tJe9F2OdZrlckhk6isvq37z+mtIAoB
         GUUiprEZGCRYxZ3TKbhuCuaR+TCfnqGX+28hhCbYWCcA6wXWnx6tF0Ds0/yuAfu93c0U
         q9DKy/Dv2xD/oY1wOHTn8NdmF8uUp1br3r5riHE3BXs4JB+s8yMumemO0L0OoONBZGZk
         tiXTLgZUthwGvfGbljEKg/3YXIK/Tdn9WwXImLUgH03uoTJYhEk7NjuNRtYWoQCs8KrE
         rvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AOOnQwX8FlMZPsRjdPt59x3rx2ygNvknjVlpR0iASV4=;
        b=p4PADm7oXy4G7MkTFy9Gq/3HtommQgyg0C9RKUDevSLqEhquqejVd0WQfpxLdZ+lA0
         hfcA0VLpw/ccJfZyg6wqONRN61t/426/rb1Vym8BOM8tQyZ5Qr8+xvMZSZ1YGB8Mba4+
         Tpwha2s0Zbu+O9nzdL3IHFxRNZL7ntjGUfcjcwZAwZWrhHkuejRk4508xuVoFdedeYXN
         sEhEOhfUnpI/NRWyKVCq3NGRaYBWZkfCOJSM4xDi59XTuihFucliXeTi8md5qhuUgJ4p
         oPAtIE4BunQ4TjZR9aaFA716PaBTRE7oyhiLMHNnMJ+zR4lAQUBPP6epZ6lilHdJ6fC8
         gqag==
X-Gm-Message-State: AOAM5328gDwzhRmL8SzYvExNg3J5PtL6GCl6nKxk/tdIiKLRpTysHr3a
        ZCNDBEI7cSIbt8xNPn81Q8n47pX1ccdHsw==
X-Google-Smtp-Source: ABdhPJxSAPU1ORTbLoGjyN5yxspHkTvKVWS0vgFiLp2ZZwtBNnGRSmXsVQw8Qg6e72inntA8VWn4fQ==
X-Received: by 2002:a05:6a00:170c:b0:510:865f:bf34 with SMTP id h12-20020a056a00170c00b00510865fbf34mr30397811pfc.60.1653427197677;
        Tue, 24 May 2022 14:19:57 -0700 (PDT)
Received: from daolu.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id a4-20020a62d404000000b0050dc7628181sm9833817pfh.91.2022.05.24.14.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 14:19:57 -0700 (PDT)
From:   Dao Lu <daolu@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dao Lu <daolu@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE)
Subject: [PATCH v2] arch/riscv: add Zihintpause support
Date:   Tue, 24 May 2022 14:19:50 -0700
Message-Id: <20220524211954.1936117-1-daolu@rivosinc.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement support for the ZiHintPause extension.

The PAUSE instruction is a HINT that indicates the current hart’s rate of
instruction retirement should be temporarily reduced or paused.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Dao Lu <daolu@rivosinc.com>
---

v1 -> v2:
 Remove the usage of static branch, use PAUSE if toolchain supports it

 arch/riscv/Makefile                     | 4 ++++
 arch/riscv/include/asm/hwcap.h          | 1 +
 arch/riscv/include/asm/vdso/processor.h | 8 +++++++-
 arch/riscv/kernel/cpu.c                 | 1 +
 arch/riscv/kernel/cpufeature.c          | 2 ++
 5 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 7d81102cffd4..900a8fda1a2d 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -56,6 +56,10 @@ riscv-march-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-y)c
 toolchain-need-zicsr-zifencei := $(call cc-option-yn, -march=$(riscv-march-y)_zicsr_zifencei)
 riscv-march-$(toolchain-need-zicsr-zifencei) := $(riscv-march-y)_zicsr_zifencei
 
+# Check if the toolchain supports Zihintpause extension
+toolchain-supports-zihintpause := $(call cc-option-yn, -march=$(riscv-march-y)_zihintpause)
+riscv-march-$(toolchain-supports-zihintpause) := $(riscv-march-y)_zihintpause
+
 KBUILD_CFLAGS += -march=$(subst fd,,$(riscv-march-y))
 KBUILD_AFLAGS += -march=$(riscv-march-y)
 
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 0734e42f74f2..caa9ee5459b4 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -52,6 +52,7 @@ extern unsigned long elf_hwcap;
  */
 enum riscv_isa_ext_id {
 	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
+	RISCV_ISA_EXT_ZIHINTPAUSE,
 	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/riscv/include/asm/vdso/processor.h
index 134388cbaaa1..4de911a25051 100644
--- a/arch/riscv/include/asm/vdso/processor.h
+++ b/arch/riscv/include/asm/vdso/processor.h
@@ -8,7 +8,13 @@
 
 static inline void cpu_relax(void)
 {
-#ifdef __riscv_muldiv
+#ifdef __riscv_zihintpause
+	/*
+	 * Reduce instruction retirement.
+	 * This assumes the PC changes.
+	 */
+	__asm__ __volatile__ ("pause");
+#elif __riscv_muldiv
 	int dummy;
 	/* In lieu of a halt instruction, induce a long-latency stall. */
 	__asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index ccb617791e56..89e563e9c4cc 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -88,6 +88,7 @@ int riscv_of_parent_hartid(struct device_node *node)
  */
 static struct riscv_isa_ext_data isa_ext_arr[] = {
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
+	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
 	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
 };
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 1b2d42d7f589..37ff06682ae6 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -25,6 +25,7 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
 __ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_fpu);
 #endif
 
+
 /**
  * riscv_isa_extension_base() - Get base extension word
  *
@@ -192,6 +193,7 @@ void __init riscv_fill_hwcap(void)
 				set_bit(*ext - 'a', this_isa);
 			} else {
 				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
+				SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
 			}
 #undef SET_ISA_EXT_MAP
 		}
-- 
2.36.0

