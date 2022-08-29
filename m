Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5C75A4CCC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiH2NB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiH2NBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:01:21 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637EE2DC5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:53:03 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mj6so2873552pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=XMoCsdNUCfWhBPID8WfmwBdQlNlnjab95bfwWj1Kd10=;
        b=DY53GI5TAnAd0CsPwNi0mXXEFLioz8RUCQWfclNsemmIEoXDit4q8fe226V5e9n66T
         ymNgRpgtzoZ67kEOIRa3hxXmfD+fTl7OEJKhylMwqu6tmaSUeKNIO/GDq6fOX4zn/AaT
         yNPIV4K2SYBVbgHjH1vpuoOquPUSxJp7gnQZWKEim5K7/8UBrQYuAp5Nzj7iCi4wENRe
         9a1c5135iN0Crz5jFUAGAKPa5kPn75dCP06cCG7Si0znL0Tax5+WlC2U42B1RXs4Xm8u
         u0lM+CSOnLgcdAglCnrcAROqawX9s98jp/sQDsEbBA049PWUylpLPSHmeftcoAA4ttA3
         C8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=XMoCsdNUCfWhBPID8WfmwBdQlNlnjab95bfwWj1Kd10=;
        b=Cxaq2lD4W9KodZTr2Ce0U/2wUNhj6z3hfo3D59LJQm8ZGlxDpbglEYrQZmNcnkDxOo
         EJXcdKYk/leByYetSqX1dL+3qqPSNtMtT/FTR9uh5HCVvsCPs/Z0UAs88HZx9ryr4bcQ
         JuPUDT7/pmtR07jdqfyjvKEAuj57ckqoenZEYsIdnRNMl+wBBTdhxXCXhsB8kC4CxuVx
         r8WWMhZu1sZJgQ2KisxPPyYAKkxzgh7PJQdmLOMokhN7OjiNUShtSNrsZ28Gi4vu8nF4
         G+CrHsKe0R5E782C3M5Xw9i/lN8rF2VP9aSpo7HAbfXMM+k236ioNTM5pl5SXfGqtQpI
         Iv1w==
X-Gm-Message-State: ACgBeo3GxnE9WaLCcmezrEd7vZSLBInqx8zLeWgKFG6QOlR8QI7ZRjO+
        hgfmdsxKhkJpUUHlBfU2DLRitQ==
X-Google-Smtp-Source: AA6agR4bk82OZLIjKGxv61LXR9fE7Iqmvmc3giXZ2CUodzY2JdWIgqar/F3YzowFSpuFFbgRQ0T4tQ==
X-Received: by 2002:a17:90b:35c8:b0:1fd:aef7:1ef6 with SMTP id nb8-20020a17090b35c800b001fdaef71ef6mr7851082pjb.60.1661777582743;
        Mon, 29 Aug 2022 05:53:02 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.81.110])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902ecc600b0016ed5266a5csm7517607plh.170.2022.08.29.05.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 05:53:02 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [PATCH 3/4] RISC-V: Implement arch specific PMEM APIs
Date:   Mon, 29 Aug 2022 18:22:25 +0530
Message-Id: <20220829125226.511564-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220829125226.511564-1-apatel@ventanamicro.com>
References: <20220829125226.511564-1-apatel@ventanamicro.com>
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

