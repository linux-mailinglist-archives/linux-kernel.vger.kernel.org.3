Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D55151D093
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 07:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387749AbiEFFZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 01:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239514AbiEFFZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 01:25:52 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9575DA5C
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 22:22:10 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n18so6393459plg.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 22:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ny5V9hV8WNPqWG0K0hKRF+ytRyOWelWP3foEMg6Arxw=;
        b=AQwkLRlg6wVbe9vtL5WcHTIR9yNaleyWfC9TGRE7bBtMfEaAnlTtEdzkRiTUczg8OM
         p9lBmS5hVcnLA2nJDYEKn2m8ooeSRN5gUbKaTD/sE0cOfRfTH6xFi8hpQMB9wOdzpzH4
         c5FS4cSYRyR+h9SiLHJy0kKSXhnNqwkggYif1VaTCqpuIdJogBzx0ikEaAUG+uo5DlpK
         eLsXXC+y1KrnOXh4ufFMHUzEGtgzdc1vgP/qvE4qtDzisFGz8TN51QvYxPAJfuoGOnPT
         ikAcs53iIMTGDVA7KS/h5NTiOt/b64Bn/ry9txEojDJfgscAKUXj/IS/E2ODyWOhppX5
         LNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ny5V9hV8WNPqWG0K0hKRF+ytRyOWelWP3foEMg6Arxw=;
        b=TRpZk5/cJGy8S+ubPDO43TThP+n4yYmU0GT+hjGMBP8Qw5vxYD13+XdlhcER+u9UYl
         gVkY43Pc1UnQrErXIITR21NeGtTl/VeQeAXuwf7JoesKQIWP2W84O/KYVoO72vQQmJKq
         2dpdJ4zzWeaH1ej1w1IUQEuzkO15snLvCqUKwq0/S1EbEWiRU+iSSoIBbayPt9P3/zYU
         l1lxeJZwrVKWn21hTCfbZA6edi9GM4QVonP6TMbEC6n21HVJPlBj0ZJmLwRJq1N4adxG
         5O1/UbQV4Q6+isT/KxC+XcYx3QSAY1MUvTArwsRCiZNiz1GUuEyXu0ZeJIqzsSxBxxMM
         BrwA==
X-Gm-Message-State: AOAM533zGi9BvFmMIN3auYD5flTNJ7wln1oe6JClgQfxmguBjQaub4Mm
        fB3YnuaBUIIcH3oPOPtVJ+Y=
X-Google-Smtp-Source: ABdhPJxPN0ui6wONzVuSoq/FRsvz9udM03Ode+1RrglHFjBV+3GibvlxehV5jDrV65R3Qj3Ux4NT3g==
X-Received: by 2002:a17:902:ba91:b0:15a:42f3:73ef with SMTP id k17-20020a170902ba9100b0015a42f373efmr1765340pls.162.1651814529928;
        Thu, 05 May 2022 22:22:09 -0700 (PDT)
Received: from hyeyoo.. ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id oc15-20020a17090b1c0f00b001d93118827asm2531958pjb.57.2022.05.05.22.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 22:22:09 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     42.hyeyoo@gmail.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mm/cpa: set PAGE_KERNEL in __set_pages_p()
Date:   Fri,  6 May 2022 14:19:39 +0900
Message-Id: <20220506051940.156952-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__set_pages_np() not only clears _PAGE_PRESENT and _PAGE_RW, but also
clears _PAGE_GLOBAL to avoid confusing _PAGE_GLOBAL as _PAGE_PROTNONE
when the PTE is not present.

Common usage for __set_pages_p() is to call it after __set_pages_np().
Therefore calling __set_pages_p() after __set_pages_np() clears
_PAGE_GLOBAL, making it unable to globally shared in TLB.

As they are called by set_direct_map_{invalid,default}_noflush(),
pages in direct map cannot be globally shared in TLB after being used by
vmalloc, secretmem, and hibernation.

So set PAGE_KERNEL isntead of __pgprot(_PAGE_PRESENT | _PAGE_RW) in
__set_pages_p().

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 arch/x86/mm/pat/set_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index abf5ed76e4b7..fcb6147c4cd4 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2177,7 +2177,7 @@ static int __set_pages_p(struct page *page, int numpages)
 	struct cpa_data cpa = { .vaddr = &tempaddr,
 				.pgd = NULL,
 				.numpages = numpages,
-				.mask_set = __pgprot(_PAGE_PRESENT | _PAGE_RW),
+				.mask_set = PAGE_KERNEL,
 				.mask_clr = __pgprot(0),
 				.flags = 0};
 
-- 
2.32.0

