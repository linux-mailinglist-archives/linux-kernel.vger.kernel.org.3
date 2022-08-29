Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0F75A4CCA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiH2NBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiH2NBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:01:21 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B63447B91
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:52:59 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso14586181pjk.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=5ilaCtDntV5LvqrHcpDpXbfyMqkerLgg3poBAYZ46YQ=;
        b=Y5QcKGoYcZUCjnyFG9953lwHuj8t9eSGvfQexdUbQBs3F5Q74O7L0rLpj+Rk2NMLRB
         akZxLE23GhCaDZhrHVl4kvCKRrenMI/lG5N9iy1F5E1tHRv3GJsSzpnEOOs042Xuybrb
         pe7VGMP+ilvW34wpbW2Ocm3E8BupI9Rpo2t983yVIvRf3ARenyrZYqQ507gIEbhu8AJG
         8uhZkR4PxP+N2CQ87mbzj6ax4HHh8AvTYKL7Ck06mcZsrDe+dU3nmz8sB+eZbD3D4Ivp
         HL9tOZqtrKj6JOn2joQwSLIbJtXPt9h0gUjBubttZ0XYW4NhHWzdx6R0CRKU1o7Gq/II
         nMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=5ilaCtDntV5LvqrHcpDpXbfyMqkerLgg3poBAYZ46YQ=;
        b=iAFCRKOCbToA98e+Wmnk9X52F7BtwoqZLQSV+4LLsJ1GLFpmEUTY9Jop5oa3faFSnI
         4FxqGO3bz85vl7UEw7vLqL/Nyl1JKcJXbWckbWBY8QImjxrGwmjxcHeXaQ9L8X6NiL8+
         4AZeFrr6rbHSKtO95oP4Xd8qKEeBHZnFNPu/DWBc8ES5lNyOhWOTULFKkV/5iI46d640
         d5vv17Gy4IRusrUlGlxKUSxBYoLWUsssbThG0Gzuwf0VIZtmxg8LOIlt5uRD5/2ScPeB
         1d9qSNMmtiSUTV8w0LYkREAY+EWzSypObRjOnxkNhXAnFqyXwVSlyJb9K0ItpC/pgZ7/
         c5wg==
X-Gm-Message-State: ACgBeo2ejfY/IzSaz4BG49/xbJ+6NlUweEMnzhDuF0FwOeVzYT5e8uVv
        uSOzUa9DoyFPU0+JGlAYkZM2tA==
X-Google-Smtp-Source: AA6agR4OoFG/9b1mM+UxTLGwZsmbxe4eml0wufZpYjFVzAvxCeN1tO1qI+X9fHG9U5AkBhxKVgkPrA==
X-Received: by 2002:a17:902:a704:b0:174:3ad5:30b8 with SMTP id w4-20020a170902a70400b001743ad530b8mr15331334plq.14.1661777578696;
        Mon, 29 Aug 2022 05:52:58 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.81.110])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902ecc600b0016ed5266a5csm7517607plh.170.2022.08.29.05.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 05:52:58 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [PATCH 2/4] RISC-V: Move riscv_init_cbom_blocksize() to cacheflush.c
Date:   Mon, 29 Aug 2022 18:22:24 +0530
Message-Id: <20220829125226.511564-3-apatel@ventanamicro.com>
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

The riscv_cbom_block_size parsing from DT belongs to cacheflush.c which
is home for all cache maintenance related stuff so let us move the
riscv_init_cbom_blocksize() and riscv_cbom_block_size to cacheflush.c.

Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/cacheflush.h |  2 ++
 arch/riscv/mm/cacheflush.c          | 37 +++++++++++++++++++++++++++++
 arch/riscv/mm/dma-noncoherent.c     | 36 ----------------------------
 3 files changed, 39 insertions(+), 36 deletions(-)

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
index 6cb7d96ad9c7..26be957dcbf2 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -86,3 +86,40 @@ void flush_icache_pte(pte_t pte)
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
index cd2225304c82..b09e4b431307 100644
--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -12,7 +12,6 @@
 #include <linux/of_device.h>
 #include <asm/cacheflush.h>
 
-static unsigned int riscv_cbom_block_size = L1_CACHE_BYTES;
 static bool noncoherent_supported;
 
 void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
@@ -75,41 +74,6 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
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

