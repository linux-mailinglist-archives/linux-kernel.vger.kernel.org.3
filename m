Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194495A5ADF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 06:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiH3Ert (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 00:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiH3Erj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 00:47:39 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E95ACA1C
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 21:47:38 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id t129so10217047pfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 21:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=vtPor/JINehJpJFz1SJxkilKXT4UTOKJym5PpR3Plyk=;
        b=KLp7YXcUffNSRJEbHo1U1gFf2nnUmwcycrLDg1hpm4yGoo8eT6ngd5n7pJlrXiBTfk
         j9mnZNlk/zsBbPEOgU3W+ROlFAHnTuHqXnzV/oofvNyRSPOyvcx91nVFrWKSVynCcPQO
         Yozf5ttY5wiN4KYbGgaGXYPQihD5M8YpjS8/gPwI8uEgq/W+mOeS+ezvte8NW6wcjCSF
         rCNcKS5RQDnSnMsHqNs5otYgdI2seYwWH7idJpYGeH1+Ka7AwhCj4uHSxf/VZ4qdRiOg
         QjG/bvyS1x4sWKWaVmNPZ4nPdw/DqZ2phPArkK5QGPNK2wavVtdSzz1cqCr6qgUPLu0s
         kCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vtPor/JINehJpJFz1SJxkilKXT4UTOKJym5PpR3Plyk=;
        b=rJ2t28+OhVY5RXi/QGx7hlcr0zceMoryCzmvn51PaY81Qj60Lxw0dpKHsNFmDLFOIo
         swo0bnOO4yNNMKVoRNm2bhkjzS+LKTpbfHNSbV4bwtrHPyJjHgFRb3L/QarPY24EKMjB
         UMHVZ5Nc6/tTJ7EvCaFdSGF3dpLoHkOAFS1eq1ZzfwdHhS49gc02a1e6LQ8BQxD0kN6A
         1jzF3JY6ReNf7s0qwd18RNadhFqA8QWoo7e12jMGTVLOyUgbEZjhngA9gBKb7JKzKKSG
         WLOZc8etklctArIuR4SUzj/tVwa4Lecmr3/NNtL4EqXEJ+VHgAwWhKo7Gco8a2+fd6gM
         WCNw==
X-Gm-Message-State: ACgBeo2AE9P78pWgnf9mPQgazEiGP/LriWyqo6M1SE+ZvWg1zUmbl4Qv
        +xJtp6l74zaoQoot+VRjTNZTNKjdVV5z+A==
X-Google-Smtp-Source: AA6agR4rh3ksVh2lnb3HasNfLMlOM72aYIH5s+vR9Vg3+NK7D0dv/gqNDtx+6K1K/D/vdy0w0onD2Q==
X-Received: by 2002:a63:ad02:0:b0:41a:910f:5195 with SMTP id g2-20020a63ad02000000b0041a910f5195mr16829161pgf.472.1661834857629;
        Mon, 29 Aug 2022 21:47:37 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.81.23])
        by smtp.gmail.com with ESMTPSA id y27-20020a634b1b000000b0041cd5ddde6fsm592240pga.76.2022.08.29.21.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 21:47:37 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [PATCH v2 2/4] RISC-V: Move riscv_init_cbom_blocksize() to cacheflush.c
Date:   Tue, 30 Aug 2022 10:16:40 +0530
Message-Id: <20220830044642.566769-3-apatel@ventanamicro.com>
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

The riscv_cbom_block_size parsing from DT belongs to cacheflush.c which
is home for all cache maintenance related stuff so let us move the
riscv_init_cbom_blocksize() and riscv_cbom_block_size to cacheflush.c.

Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/cacheflush.h |  2 ++
 arch/riscv/mm/cacheflush.c          | 39 +++++++++++++++++++++++++++++
 arch/riscv/mm/dma-noncoherent.c     | 38 ----------------------------
 3 files changed, 41 insertions(+), 38 deletions(-)

diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index a60acaecfeda..de55d6b8deeb 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -42,6 +42,8 @@ void flush_icache_mm(struct mm_struct *mm, bool local);
 
 #endif /* CONFIG_SMP */
 
+extern unsigned int riscv_cbom_block_size;
+
 #ifdef CONFIG_RISCV_ISA_ZICBOM
 void riscv_init_cbom_blocksize(void);
 #else
diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 6cb7d96ad9c7..336c5deea870 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -3,6 +3,8 @@
  * Copyright (C) 2017 SiFive
  */
 
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <asm/cacheflush.h>
 
 #ifdef CONFIG_SMP
@@ -86,3 +88,40 @@ void flush_icache_pte(pte_t pte)
 		flush_icache_all();
 }
 #endif /* CONFIG_MMU */
+
+unsigned int riscv_cbom_block_size = L1_CACHE_BYTES;
+
+#ifdef CONFIG_RISCV_ISA_ZICBOM
+void riscv_init_cbom_blocksize(void)
+{
+	struct device_node *node;
+	int ret;
+	u32 val;
+
+	for_each_of_cpu_node(node) {
+		unsigned long hartid;
+		int cbom_hartid;
+
+		ret = riscv_of_processor_hartid(node, &hartid);
+		if (ret)
+			continue;
+
+		if (hartid < 0)
+			continue;
+
+		/* set block-size for cbom extension if available */
+		ret = of_property_read_u32(node, "riscv,cbom-block-size", &val);
+		if (ret)
+			continue;
+
+		if (!riscv_cbom_block_size) {
+			riscv_cbom_block_size = val;
+			cbom_hartid = hartid;
+		} else {
+			if (riscv_cbom_block_size != val)
+				pr_warn("cbom-block-size mismatched between harts %d and %lu\n",
+					cbom_hartid, hartid);
+		}
+	}
+}
+#endif
diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
index cd2225304c82..3f502a1a68b1 100644
--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -8,11 +8,8 @@
 #include <linux/dma-direct.h>
 #include <linux/dma-map-ops.h>
 #include <linux/mm.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <asm/cacheflush.h>
 
-static unsigned int riscv_cbom_block_size = L1_CACHE_BYTES;
 static bool noncoherent_supported;
 
 void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
@@ -75,41 +72,6 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 	dev->dma_coherent = coherent;
 }
 
-#ifdef CONFIG_RISCV_ISA_ZICBOM
-void riscv_init_cbom_blocksize(void)
-{
-	struct device_node *node;
-	int ret;
-	u32 val;
-
-	for_each_of_cpu_node(node) {
-		unsigned long hartid;
-		int cbom_hartid;
-
-		ret = riscv_of_processor_hartid(node, &hartid);
-		if (ret)
-			continue;
-
-		if (hartid < 0)
-			continue;
-
-		/* set block-size for cbom extension if available */
-		ret = of_property_read_u32(node, "riscv,cbom-block-size", &val);
-		if (ret)
-			continue;
-
-		if (!riscv_cbom_block_size) {
-			riscv_cbom_block_size = val;
-			cbom_hartid = hartid;
-		} else {
-			if (riscv_cbom_block_size != val)
-				pr_warn("cbom-block-size mismatched between harts %d and %lu\n",
-					cbom_hartid, hartid);
-		}
-	}
-}
-#endif
-
 void riscv_noncoherent_supported(void)
 {
 	noncoherent_supported = true;
-- 
2.34.1

