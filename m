Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B47B5A5AE2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 06:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiH3Erw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 00:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiH3Erp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 00:47:45 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E494DAE203
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 21:47:41 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id h11-20020a17090a470b00b001fbc5ba5224so10685086pjg.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 21:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=XMoCsdNUCfWhBPID8WfmwBdQlNlnjab95bfwWj1Kd10=;
        b=KyY6qemGdAkaKRbxVYdAz3bVkbn3V5vCqclhXgThxlPctC0qN1uzOeIZ5vS6FTD0GR
         RWzYhB7OVcdM4eCrhsKp6+DpAxlzpq0XIiGM6RHJ2Dib3h3tvpsF8gT7bAFdnT0V/K56
         Ft8aKk0KTa80X1JCkYDt0XUsujMjVvlgNpe0N5KhfgEwwRBdS+qhIELWu7PUP3DLhrIV
         fOW8V9hRRaRG2W98qspPi5sNCJfJipHToEpOG7U9qUWQ/eP26nGgtziHJDuHcrj1m+2Y
         EsecMzXMLGxtVS561ACyh+HMQvh4HuaP8HmJ++cYpcNd6kxzT0aDLPMxoIMkdBghnaEv
         6JRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=XMoCsdNUCfWhBPID8WfmwBdQlNlnjab95bfwWj1Kd10=;
        b=yAtJBhQunC6nm5mWs1j7adbQgwx1qclLe+l5/864r8rD2q/hzolbeaGV4s9h0oDNm8
         81r4NZB5QU5N1K1I/DDASzLCUnP5V7uT332PwWR6G+R4uWzVoJxqUz+kkNf860a7bHc5
         ojTiik+GtKI1V3+8Nt1jMudUOWlS1s3qdF/JghMaZ5t8A83x5rYSBtsfEoFv1us++6+R
         50w123ehLA0RWbDXdwG3pYbPxBgmesRerCbXY6G4KZVRAmZP/pZzAptC4gEE90QdmKyR
         H7jw45N1iAgkLi8A4pnwOaLzhokzYb/uKtQgu6XRKfy2NweziCk9CppeNdTwbNEyeLGD
         AP7A==
X-Gm-Message-State: ACgBeo2sTZXw2jXVielYq/xEvJ0+pW2YY41dYGqmeghyVk12gc8MMq5B
        EOqK54Rdz7KkMqO47Dq8pbZ4sA==
X-Google-Smtp-Source: AA6agR7SXnyqGd3PJVXZX31upuIkPNkqX09rWCJO72YV0QlNaewtvScGi6RvN5v6HKr8LRd4oNC6Ng==
X-Received: by 2002:a17:90a:cb94:b0:1fd:86fe:ba3e with SMTP id a20-20020a17090acb9400b001fd86feba3emr15789321pju.240.1661834861316;
        Mon, 29 Aug 2022 21:47:41 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.81.23])
        by smtp.gmail.com with ESMTPSA id y27-20020a634b1b000000b0041cd5ddde6fsm592240pga.76.2022.08.29.21.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 21:47:40 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [PATCH v2 3/4] RISC-V: Implement arch specific PMEM APIs
Date:   Tue, 30 Aug 2022 10:16:41 +0530
Message-Id: <20220830044642.566769-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220830044642.566769-1-apatel@ventanamicro.com>
References: <20220830044642.566769-1-apatel@ventanamicro.com>
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

The NVDIMM PMEM driver expects arch specific APIs for cache maintenance
and if arch does not provide these APIs then NVDIMM PMEM driver will
always use MEMREMAP_WT to map persistent memory which in-turn maps as
UC memory type defined by the RISC-V Svpbmt specification.

Now that the Svpbmt and Zicbom support is available in RISC-V kernel,
we implement PMEM APIs using ALT_CMO_OP() macros so that the NVDIMM
PMEM driver can use MEMREMAP_WB to map persistent memory.

Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/Kconfig     |  1 +
 arch/riscv/mm/Makefile |  1 +
 arch/riscv/mm/pmem.c   | 21 +++++++++++++++++++++
 3 files changed, 23 insertions(+)
 create mode 100644 arch/riscv/mm/pmem.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0ebd8da388d8..37d6370d29c3 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -25,6 +25,7 @@ config RISCV
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MMIOWB
+	select ARCH_HAS_PMEM_API
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_DIRECT_MAP if MMU
 	select ARCH_HAS_SET_MEMORY if MMU
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index d76aabf4b94d..3b368e547f83 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -31,3 +31,4 @@ endif
 
 obj-$(CONFIG_DEBUG_VIRTUAL) += physaddr.o
 obj-$(CONFIG_RISCV_DMA_NONCOHERENT) += dma-noncoherent.o
+obj-$(CONFIG_ARCH_HAS_PMEM_API) += pmem.o
diff --git a/arch/riscv/mm/pmem.c b/arch/riscv/mm/pmem.c
new file mode 100644
index 000000000000..089df92ae876
--- /dev/null
+++ b/arch/riscv/mm/pmem.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+
+#include <linux/export.h>
+#include <linux/libnvdimm.h>
+
+#include <asm/cacheflush.h>
+
+void arch_wb_cache_pmem(void *addr, size_t size)
+{
+	ALT_CMO_OP(clean, addr, size, riscv_cbom_block_size);
+}
+EXPORT_SYMBOL_GPL(arch_wb_cache_pmem);
+
+void arch_invalidate_pmem(void *addr, size_t size)
+{
+	ALT_CMO_OP(inval, addr, size, riscv_cbom_block_size);
+}
+EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
-- 
2.34.1

