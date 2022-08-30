Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D421A5A5AE1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 06:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiH3Ero (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 00:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiH3Erf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 00:47:35 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF36AB4F9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 21:47:34 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id z3-20020a17090abd8300b001fd803e34f1so8110603pjr.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 21:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=DF3EHZACZLIxZm103wJfkyVVUnHhmNz4e84k34pg8iM=;
        b=d//IYFbFbRj/XGv/L+vodF9VdUAaDfuMlXokuJPWHcVkRNgY84J/Nq6BwNLvkQJH+l
         qIY3tux1IkH+TGS1zi/PJWIDe/9R1ROlQPIotY7+VEvdoMJ4/thsof72inQ0Cn80VXj+
         xltiE7undvWYlNF+uMHyz6euWLMHSPsJoRSnEupUASGZx1lcKIDaxRaywMxGeyC3jOfj
         +B6i5IFJw98Qv6rfWsaCKPTgHuNrb7NawC+gGZG3zQg9LKTo8SVMHL6JYCYJrlJh8M3h
         ZYz+ouRwEeFK43KJD33wD1e4BwnP/wFeR9+Qkjk++zoL5wsLEeHee6JpThHE5socKCRj
         crFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DF3EHZACZLIxZm103wJfkyVVUnHhmNz4e84k34pg8iM=;
        b=FUauNUsngEg/b4s8V1hDkjyVR2nGleImwImNGPq6gjjIGOKS/On+eKY5/RVmqIeAgZ
         WljI4PsXqFh20i0ZuePNoVNgn8Ck0xW84D9+e/k05inGwT9bIKa42xaUn8yZprxI9iXB
         ji5HwqX+KWJTubLNotNj/FNoB3Ade0wMp8pMhmxBeIX/CPPP8AXNpiLiwK9c7qnrt1ch
         kjrfgrJpiCj0S3femuKxeyQ5BvybIvyBpp1y7alDalwedxAELljg4rR3EpVY6ZbOvja3
         z0KZ5F3JdXqCK6pW2azh51ViQhdwZx8nqqdsnooN7cHCG6lo1YPZvtkiEKZk9uTfapMB
         dtBQ==
X-Gm-Message-State: ACgBeo3Mu/FNlKRdCUNw7RKM/9b9mLVwtip7o8zm0r5gNaWnN835CaRa
        olKWxzsW2Fr+YnMCZQZ+PPAvRQ==
X-Google-Smtp-Source: AA6agR5dOijUTXfsEnOaqP4oO/8aejOL3xC6Fv953h7pj5T7Bxh/cxnIMjRjsK29SKoejrrC+jmtyg==
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id mw7-20020a17090b4d0700b001ef521cf051mr22130876pjb.164.1661834853798;
        Mon, 29 Aug 2022 21:47:33 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.81.23])
        by smtp.gmail.com with ESMTPSA id y27-20020a634b1b000000b0041cd5ddde6fsm592240pga.76.2022.08.29.21.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 21:47:33 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [PATCH v2 1/4] RISC-V: Fix ioremap_cache() and ioremap_wc() for systems with Svpbmt
Date:   Tue, 30 Aug 2022 10:16:39 +0530
Message-Id: <20220830044642.566769-2-apatel@ventanamicro.com>
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

