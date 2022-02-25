Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247AC4C44D6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240702AbiBYMqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiBYMqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:46:36 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24A421CD12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:46:04 -0800 (PST)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A602C3F1C9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 12:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645793163;
        bh=IZZDTFAqzc8aGjWg1aZGEvUIk/RV0NTNXI1qwgw2jtM=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=NbuplYwpZDA6vimglNGnb8sl8yD7+jhJ2oi2Ti0IUGF2J8G0s9m/GZ+8jhnFutli7
         5Y/Ldq7Ixg47hG+FvmiBCry+Tp5sr26yKf4JRpOvFLrfi8/Lpl9dPIzsgq7lpu8Ozj
         KLe95HHy8+5oGLpMPcRsrSHu4fIr55Z47JvXsBPcnoUcgLNgqrigfjUQFk/tV88G7r
         t6vujrku7IlIqFQ/9Y6We8xM4uT8TJuQLRIOjs/R9lE0l4xg2bsUBtlv/FmKcYAHkU
         qiK3MXgm0a3NJakRdxbIAWeelxK8C3XhS53DBYDYoiePomfoUPJ6G03o+FWa3R4oA+
         0dx1/xoQYLzEw==
Received: by mail-wm1-f69.google.com with SMTP id w3-20020a7bc743000000b0037c5168b3c4so1510781wmk.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:46:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IZZDTFAqzc8aGjWg1aZGEvUIk/RV0NTNXI1qwgw2jtM=;
        b=5MFNklMRl4lPD1dBHw6iQRs6qpAfetCZZFL9EAFzXMsrN9fHIIUh1TnbEypkD6jVQW
         dtxokPL0gVgyMdqZP9CSj3bEByw5k6aC5aRUXHWXR5hAZDTTAPNn/jT9B5A8vi+oynwE
         0RVNSzt3xYiCTiD92fAkuanttp0qONjLVPSU4tVubtUgHsJ1HXtJdCf5vRAWmHiBewHV
         ElRXMHHVjkPxl39lGdTh3VClILARJBNhY+k/RKPjIpf8xynKSsHvFe6liWMNDV73RMwF
         WzuXn9BhCdHo7M43okBU7vjCfAuavyIJ68LooQBmLoYihd66mponshpe5LhrGmuGM+Lm
         42Qw==
X-Gm-Message-State: AOAM531QnMq/ZcoBPoFYjqTrF+kB+M7wvz1Hon5AOe+Tzl/iRGRcW3qk
        lEsi0339dlKXI+ZK3vgjn+FySuKqCl6veRCc2N89zHMIS00MUoxJsBUTg07yD6k+X1/tP11LR5b
        DUKdPeYjpuHx90XYq1tb8h2/aRzZ38LbZ00LlCmYpZA==
X-Received: by 2002:a5d:59af:0:b0:1e4:a027:ce3b with SMTP id p15-20020a5d59af000000b001e4a027ce3bmr5811393wrr.318.1645793163256;
        Fri, 25 Feb 2022 04:46:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxO7k/BdZpfrSelXcnhXik1Fk/jhx3wZbS/FHtdA4vPeJI99+BzxjzzIqpykVUwH5wXXBm4Wg==
X-Received: by 2002:a5d:59af:0:b0:1e4:a027:ce3b with SMTP id p15-20020a5d59af000000b001e4a027ce3bmr5811384wrr.318.1645793163068;
        Fri, 25 Feb 2022 04:46:03 -0800 (PST)
Received: from localhost.localdomain (lfbn-gre-1-195-1.w90-112.abo.wanadoo.fr. [90.112.158.1])
        by smtp.gmail.com with ESMTPSA id e33-20020a05600c4ba100b003810c690ba2sm4741109wmp.3.2022.02.25.04.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 04:46:02 -0800 (PST)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Nick Hu <nickhu@andestech.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: [PATCH -fixes v3 6/6] riscv: Fix kasan pud population
Date:   Fri, 25 Feb 2022 13:39:53 +0100
Message-Id: <20220225123953.3251327-7-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220225123953.3251327-1-alexandre.ghiti@canonical.com>
References: <20220225123953.3251327-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sv48, the kasan inner regions are not aligned on PGDIR_SIZE and then
when we populate the kasan linear mapping region, we clear the kasan
vmalloc region which is in the same PGD.

Fix this by copying the content of the kasan early pud after allocating a
new PGD for the first time.

Fixes: e8a62cc26ddf ("riscv: Implement sv48 support")
Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 arch/riscv/mm/kasan_init.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index 85e849318389..cd1a145257b7 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -113,8 +113,11 @@ static void __init kasan_populate_pud(pgd_t *pgd,
 		base_pud = pt_ops.get_pud_virt(pfn_to_phys(_pgd_pfn(*pgd)));
 	} else {
 		base_pud = (pud_t *)pgd_page_vaddr(*pgd);
-		if (base_pud == lm_alias(kasan_early_shadow_pud))
+		if (base_pud == lm_alias(kasan_early_shadow_pud)) {
 			base_pud = memblock_alloc(PTRS_PER_PUD * sizeof(pud_t), PAGE_SIZE);
+			memcpy(base_pud, (void *)kasan_early_shadow_pud,
+			       sizeof(pud_t) * PTRS_PER_PUD);
+		}
 	}
 
 	pudp = base_pud + pud_index(vaddr);
-- 
2.32.0

