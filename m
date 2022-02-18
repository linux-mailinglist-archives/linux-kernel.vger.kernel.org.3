Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59B74BBA2E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 14:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235790AbiBRNiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 08:38:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbiBRNiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 08:38:03 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA3E1AA256
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 05:37:45 -0800 (PST)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E10EA40306
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645191463;
        bh=5wR2inrb50SGryPV3ql5qm7RIRt9i7gNq/sby+Clcps=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=qZuo+9Csuk+9lm4KjCfI9sOW1y/+M6zZS6c2K7eLmCTFmq7gOMj4jzO1lD+pclrtQ
         7RF8NbzT9DWNJbOzZI1lFfv3hfRWMheQyQXkuXXBrnblME10x1269GVi5H8N5Xx6BY
         cHR31WadHXSYtlqZZBKcQQsStuOO+aqTk/dOERY48V5RNU5U2DvaNKkYu0b5R/tHYD
         xhZ63bm9Kxz8uGlrq26o33GPw30N0oNRmJ12BegPlzmOqCTWveCGeb+b9iPTbs3d6r
         v/oSTcD9BYTSWccymiWo8KPHqeUo+5SIo4EMBHR6lwpDCzvoAG79RnT+gRBNKVV8HC
         y8PJPCvADzAwQ==
Received: by mail-wm1-f69.google.com with SMTP id 125-20020a1c0283000000b0037bf720e6a8so5935018wmc.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 05:37:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5wR2inrb50SGryPV3ql5qm7RIRt9i7gNq/sby+Clcps=;
        b=34QPEzkRKqVCPCwhJH8ovzsInp3kBTSFOs15kiAsTvB13W4OwuP4nzptstm5dLufni
         /deRnS6eOoIYUJl1yg0EhNMTLFNPz/5/n1AgKvaHGVibNiYciAQcNp1KQuMiy3lGxnVr
         uH4BAz0/pDO6wkjZLQfYpezVHiGC1j9/u+0hltcSG7LUcGOjdc4nHAM2rW1mE8V+eaIc
         ODOLfi/aUvtY0GgYq2mupGMiBfmrtLnhQ3ZBG5msjYUO9s1+IEkS9GuOU2zqcSyARveU
         5EPsdyr4JDGoy3i7k+hXRmkt8YejpgEyeA9tkfKoDtMze8YwwtEj5ciQYFL7aXsQXkKH
         u06w==
X-Gm-Message-State: AOAM530U0/1Xapo5TGyPyoFperfY6Ua2gzt+HlBEdvwLJxrIkPVrBv7u
        mD+mk3Kf1sBF4p5nuzRl83cM32HDPWejXs7wGEmbAwNHLBEbL19X2ee2L8kxttZPDOM/SQ1YeRt
        mk04qaBzt3tvGarZcQE4dcyzvQPXQa186E5wPnzP/VQ==
X-Received: by 2002:a1c:7715:0:b0:37b:dc94:9eb4 with SMTP id t21-20020a1c7715000000b0037bdc949eb4mr7292831wmi.61.1645191463169;
        Fri, 18 Feb 2022 05:37:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz1rOcJLLe1sMpbmzJaKzZ9MrfRNf1PgF+TEXDfRIfQBwQQMxq9mXwaThHJyZuyQwyiE6VwOg==
X-Received: by 2002:a1c:7715:0:b0:37b:dc94:9eb4 with SMTP id t21-20020a1c7715000000b0037bdc949eb4mr7292811wmi.61.1645191463026;
        Fri, 18 Feb 2022 05:37:43 -0800 (PST)
Received: from localhost.localdomain (lfbn-gre-1-195-1.w90-112.abo.wanadoo.fr. [90.112.158.1])
        by smtp.gmail.com with ESMTPSA id h21sm4886378wmq.26.2022.02.18.05.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 05:37:42 -0800 (PST)
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
Subject: [PATCH -fixes 2/4] riscv: Fix config KASAN && SPARSEMEM && !SPARSE_VMEMMAP
Date:   Fri, 18 Feb 2022 14:35:11 +0100
Message-Id: <20220218133513.1762929-3-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220218133513.1762929-1-alexandre.ghiti@canonical.com>
References: <20220218133513.1762929-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to get the pfn of a struct page* when sparsemem is enabled
without vmemmap, the mem_section structures need to be initialized which
happens in sparse_init.

But kasan_early_init calls pfn_to_page way before sparse_init is called,
which then tries to dereference a null mem_section pointer.

Fix this by removing the usage of this function in kasan_early_init.

Fixes: 8ad8b72721d0 ("riscv: Add KASAN support")
Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 arch/riscv/mm/kasan_init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index f61f7ca6fe0f..85e849318389 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -202,8 +202,7 @@ asmlinkage void __init kasan_early_init(void)
 
 	for (i = 0; i < PTRS_PER_PTE; ++i)
 		set_pte(kasan_early_shadow_pte + i,
-			mk_pte(virt_to_page(kasan_early_shadow_page),
-			       PAGE_KERNEL));
+			pfn_pte(virt_to_pfn(kasan_early_shadow_page), PAGE_KERNEL));
 
 	for (i = 0; i < PTRS_PER_PMD; ++i)
 		set_pmd(kasan_early_shadow_pmd + i,
-- 
2.32.0

