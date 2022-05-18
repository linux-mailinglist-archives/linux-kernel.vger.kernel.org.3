Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C5152B46A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 10:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbiERIS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbiERIS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:18:26 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E2F996B1
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 01:18:25 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id i24so1464738pfa.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 01:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f22cXTNsoYn514XVAs+A0nZ4R63LnXxUaMnO5yshFsc=;
        b=mUJJaZznPXm2bEg7PPxlgx7o3QntT81XPFfYXi4PPvdVoRy4k1G9xOeSgyJt4jpWfg
         QE+A17kzFEKij01JyspqP1UXEAZaYitG0T4NmR7aoptr1Y3Ayr37p24GgnDWxynwDg2U
         bxOuwGcq90qqgJv8MdBu/3h123882KI1Kn4EHIBP2A9eu9LKGhXMIqc7W8rLmuuWQllt
         FESfWEd84TzBbbdEpYJcpcQL6ar4rpy+DlqZRBXS3kTiXWzW68YMR54dCwAeFO1wioca
         eIrnaqwuz3PPYImQlcs+d0J/C9PWbrxA9Jjy3LfC46XuO4BhqjJ1Gb8nalaWbrLhKbqw
         OMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f22cXTNsoYn514XVAs+A0nZ4R63LnXxUaMnO5yshFsc=;
        b=Nc/2Ous2IEKu0fDdqSR76ipAlfuRmBxyAkdZdKwORsGBmoTNYm0FMBjsD28pYcNmyU
         NKho38xiLuIZuwNpvNLG43ad141oFBFWcyIrAL8+5+fAnitbxF/R1hiyG1rr8iHyjjQU
         myCS/7k2UqEi7JBvECv7L7Yx4/vPDWFwROYmbbajRdbiImukjl82dCqj9r+RNbLj0nNv
         zEfb2XhCgFGIK0Wv5NXOhwluc0U06MuFcmVhE8yMjfMiQ8e9FgN0HCK1DDmZRhkmB58V
         Mst1P4hsCo3nun+ydt29fcn+he3cLURENCZcrZ50uoTJn9HCIUna/yr+NnUkUjDMRvau
         Yf5A==
X-Gm-Message-State: AOAM533Ou57271ytsyDRkeUhzEIaSW/xv+yAQSE2ZCfVqYJknyuhfWU3
        CKVTlGZYXmtq5UNSegYKzBUhFw==
X-Google-Smtp-Source: ABdhPJzx8V6y2Rr4Fth9lL0g63c1SH5CDRzTfNW+60mdSK5B8TxPN0VIhHLmLBbA2PUNJIH5856MJg==
X-Received: by 2002:a63:5b13:0:b0:3c2:163c:b9cb with SMTP id p19-20020a635b13000000b003c2163cb9cbmr22699800pgb.145.1652861904658;
        Wed, 18 May 2022 01:18:24 -0700 (PDT)
Received: from hsinchu01.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id y23-20020a1709027c9700b001619cebbad4sm989560pll.148.2022.05.18.01.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 01:18:24 -0700 (PDT)
From:   Po-Kai Chi <po-kai.chi@sifive.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Po-Kai Chi <po-kai.chi@sifive.com>
Subject: [PATCH] riscv: Invalid instruction cache after copy the xol area
Date:   Wed, 18 May 2022 16:17:53 +0800
Message-Id: <20220518081753.29589-1-po-kai.chi@sifive.com>
X-Mailer: git-send-email 2.36.1
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

We need to invalid the relevant instruction cache after
copying the xol area, to ensure the changes takes effect.

Signed-off-by: Po-Kai Chi <po-kai.chi@sifive.com>
---
 arch/riscv/kernel/probes/uprobes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
index 7a057b5f0adc..9d52beeac73c 100644
--- a/arch/riscv/kernel/probes/uprobes.c
+++ b/arch/riscv/kernel/probes/uprobes.c
@@ -165,6 +165,7 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 	/* Initialize the slot */
 	void *kaddr = kmap_atomic(page);
 	void *dst = kaddr + (vaddr & ~PAGE_MASK);
+	unsigned long addr = (unsigned long)dst;
 
 	memcpy(dst, src, len);
 
@@ -177,10 +178,9 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 	kunmap_atomic(kaddr);
 
 	/*
-	 * We probably need flush_icache_user_page() but it needs vma.
-	 * This should work on most of architectures by default. If
-	 * architecture needs to do something different it can define
-	 * its own version of the function.
+	 * Flush both I/D cache to ensure instruction modification
+	 * takes effect.
 	 */
 	flush_dcache_page(page);
+	flush_icache_range(addr, addr + len);
 }
-- 
2.36.1

