Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F554AA961
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 15:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380109AbiBEOUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 09:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380113AbiBEOUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 09:20:20 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C01C061346;
        Sat,  5 Feb 2022 06:20:20 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id y17so7589659plg.7;
        Sat, 05 Feb 2022 06:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fXpUWimVQCvLi12RE7G95TNrEuugIM/jhy8DgSTBsu8=;
        b=qLWx413D4IciL39NYeWr8qU1KR5zagd8EE38Tq5GVf3hMtZW9LxygN0yy4Sa4G3nK5
         o7XjAajXRMf22xa6ELrr0cEaDEXotb5UzArukoNtgfGjDRUSdt+7iyJXwik0SHr9Wodh
         yljY+pGNwNds9QoYnXSPvr51dv6aOyDrGAhTYjB8BrhXAFdzEi1BB/kqxntwvbR2GUeY
         b9ZEp1bPcveeUhL+pWpSX54NZ/noE5QErwkq5YbhW788sNH/8JdQx4bZ/H1DqmzfaZfU
         IXI+p9FgouIgMakWQ0kSdXK+ETMqZybLhlyTcP+2my+FKNPyJmA5vcuryETrXoHZjX+w
         PZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fXpUWimVQCvLi12RE7G95TNrEuugIM/jhy8DgSTBsu8=;
        b=6v9nLDz74/m9uyx3Ra9uBoZQQFhWb5y/DJahe+JwRaP4t8NNieDfllPVYBq/WhG1VT
         6w/d5fAOpKvG9YY54eGRDvLAjotiPq0A1HJzm69bMw6Eo3wYihqB5EUAgvSR4BabXexq
         yDbUNNBSO4HbTxYiRMNUWNfTjX/Wg6WUgQ6M9HYD0egGhMmpm3ipGECEkXjbiKbXfxOI
         EvmIuTzhOFSHOPFDGM/HmX6qSKKRnkcHPRO+6hrJDHV/j7Fb4T5RrAsKrqOPTndFnIaw
         isSXQzWb0YR7Bv394fYtVVNH45wRg1VWOjCTz+A1PcNKI5lpWqeS08WMjpOSVyxeEqwI
         dsKA==
X-Gm-Message-State: AOAM531sNyuL6i1H7S6sxzNSTt1MZgu9HBhoiqSygFLQIxwExeSBbGbn
        j6bEAhBNrzE7Zclvtdll94UXPT7kmEHYbsLx
X-Google-Smtp-Source: ABdhPJyXegnm+lnzB5nkdEiKy52n6ZgRIAHvhTy7NkETaaV3Ff/WvmUvrYGZRioCcZJITPM0NbegOw==
X-Received: by 2002:a17:90b:1e07:: with SMTP id pg7mr8738115pjb.97.1644070819294;
        Sat, 05 Feb 2022 06:20:19 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id lx4sm5795622pjb.44.2022.02.05.06.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 06:20:17 -0800 (PST)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>,
        Brian Cain <bcain@codeaurora.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Mike Rapoport <rppt@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-hexagon@vger.kernel.org, openrisc@lists.librecores.org
Subject: [PATCH] mm: Remove mmu_gathers storage from remaining architectures
Date:   Sat,  5 Feb 2022 23:19:53 +0900
Message-Id: <20220205141956.3315419-1-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally the mmu_gathers were removed in commit 1c3951769621 ("mm: now
that all old mmu_gather code is gone, remove the storage").  However,
the openrisc and hexagon architecture were merged around the same time
and mmu_gathers was not removed.

This patch removes them from openrisc, hexagon and nds32:

Noticed while cleaning this warning:

    arch/openrisc/mm/init.c:41:1: warning: symbol 'mmu_gathers' was not declared. Should it be static?

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/hexagon/mm/init.c  | 2 --
 arch/nds32/mm/init.c    | 1 -
 arch/openrisc/mm/init.c | 2 --
 3 files changed, 5 deletions(-)

diff --git a/arch/hexagon/mm/init.c b/arch/hexagon/mm/init.c
index f01e91e10d95..3167a3b5c97b 100644
--- a/arch/hexagon/mm/init.c
+++ b/arch/hexagon/mm/init.c
@@ -29,8 +29,6 @@ int max_kernel_seg = 0x303;
 /*  indicate pfn's of high memory  */
 unsigned long highstart_pfn, highend_pfn;
 
-DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
-
 /* Default cache attribute for newly created page tables */
 unsigned long _dflt_cache_att = CACHEDEF;
 
diff --git a/arch/nds32/mm/init.c b/arch/nds32/mm/init.c
index f63f839738c4..825c85cab1a1 100644
--- a/arch/nds32/mm/init.c
+++ b/arch/nds32/mm/init.c
@@ -18,7 +18,6 @@
 #include <asm/tlb.h>
 #include <asm/page.h>
 
-DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 DEFINE_SPINLOCK(anon_alias_lock);
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 
diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index 97305bde1b16..3a021ab6f1ae 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -38,8 +38,6 @@
 
 int mem_init_done;
 
-DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
-
 static void __init zone_sizes_init(void)
 {
 	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
-- 
2.31.1

