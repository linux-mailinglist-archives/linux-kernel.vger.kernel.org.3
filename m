Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAA85A4CCB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiH2NBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiH2NBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:01:21 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2901D16588
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:52:55 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id m2so7890039pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=DF3EHZACZLIxZm103wJfkyVVUnHhmNz4e84k34pg8iM=;
        b=VwwMibK4e1SGhbD7sfBq/VulE9XYXIwXhHxCTuKnLGjjKcyYtOU26SdNAy0JJLC328
         OGsC0x7AUiU+rPHANfFbPQKXIrm9BPUlPQ+KLS2hnv/uHnFjNLNVCsIub5rusNcz8PaS
         9ITaJBrp3LWW015hTkbf7G50YoCWhaNeKGQBGEcfbfe2SFMHn7uBZldruUZyDK2yoP1S
         nc0+t/oV2jnDFCK1IxcUqlHXx/zeLtYruOq/1VDzU7WDFU8YGTmelwo+1naw5PvIe6rl
         FQVuklwhjiugna99cpvtoiVQ3B1TnpSKwhBq/moEV0G4cBA2/9uvoYyZtF0EdJ0uXt08
         jqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DF3EHZACZLIxZm103wJfkyVVUnHhmNz4e84k34pg8iM=;
        b=jokRXuIr5yW84NUiCh+lESQDSGFwDk3MHnngZ2jbYQCE3W3mXlQS/Tg3gktguS2u3r
         qdAhLBbPrJqLeW/UR3+z6HCB4SegfPn/h95bC6lGIsC/5QaChraIanZeXWpF/EuE3S2r
         QaQGiZzlOx5lwqo2VNlahgEiCnMB39yWbGAOGAmyM5Ur26p2RacB4uapWbHnkn1ZVyWN
         kqNgN6vNO+FQVcxqmmZu7a2QixHoxd8PtiTfGA/vOHFuWG2V1drJwLPK4WUBgJa9eLWn
         LKKdInSNJtopIUtFFLc7VYPq/NFqiuNY1q78MSAGM7R+PK6SDR4aaJ1M3stbvsG03qHX
         to4A==
X-Gm-Message-State: ACgBeo33WMqstaalrlutAT+Go3vXpwEuCFb2mM9FM8CAsqrE9p2MVLKO
        p72yfjJmpD8sL7+/y0QxhvRX5A==
X-Google-Smtp-Source: AA6agR5aA3lQRu1vS8qwSp/nS3Li+E+T9vQqImCN0tFjn0Mho9TQuefM6AnU7y3mkyQDlJtkWx7W4g==
X-Received: by 2002:a17:903:2310:b0:173:10e1:3a76 with SMTP id d16-20020a170903231000b0017310e13a76mr16520555plh.160.1661777574577;
        Mon, 29 Aug 2022 05:52:54 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.81.110])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902ecc600b0016ed5266a5csm7517607plh.170.2022.08.29.05.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 05:52:54 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [PATCH 1/4] RISC-V: Fix ioremap_cache() and ioremap_wc() for systems with Svpbmt
Date:   Mon, 29 Aug 2022 18:22:23 +0530
Message-Id: <20220829125226.511564-2-apatel@ventanamicro.com>
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

Currently, all flavors of ioremap_xyz() function maps to the generic
ioremap() which means any ioremap_xyz() call will always map the
target memory as IO using _PAGE_IOREMAP page attributes. This breaks
ioremap_cache() and ioremap_wc() on systems with Svpbmt because memory
remapped using ioremap_cache() and ioremap_wc() will use _PAGE_IOREMAP
page attributes.

To address above (just like other architectures), we implement RISC-V
specific ioremap_cache() and ioremap_wc() which maps memory using page
attributes as defined by the Svpbmt specification.

Fixes: ff689fd21cb1 ("riscv: add RISC-V Svpbmt extension support")
Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/io.h      | 10 ++++++++++
 arch/riscv/include/asm/pgtable.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index 69605a474270..07ac63999575 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -133,6 +133,16 @@ __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
 #define outsq(addr, buffer, count) __outsq((void __iomem *)addr, buffer, count)
 #endif
 
+#ifdef CONFIG_MMU
+#define ioremap_wc(addr, size)		\
+	ioremap_prot((addr), (size), _PAGE_IOREMAP_WC)
+#endif
+
 #include <asm-generic/io.h>
 
+#ifdef CONFIG_MMU
+#define ioremap_cache(addr, size)	\
+	ioremap_prot((addr), (size), _PAGE_KERNEL)
+#endif
+
 #endif /* _ASM_RISCV_IO_H */
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 7ec936910a96..346b7c1a3eeb 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -182,6 +182,8 @@ extern struct pt_alloc_ops pt_ops __initdata;
 #define PAGE_TABLE		__pgprot(_PAGE_TABLE)
 
 #define _PAGE_IOREMAP	((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_IO)
+#define _PAGE_IOREMAP_WC	((_PAGE_KERNEL & ~_PAGE_MTMASK) | \
+				 _PAGE_NOCACHE)
 #define PAGE_KERNEL_IO		__pgprot(_PAGE_IOREMAP)
 
 extern pgd_t swapper_pg_dir[];
-- 
2.34.1

