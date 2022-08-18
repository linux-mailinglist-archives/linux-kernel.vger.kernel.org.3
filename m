Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8794598015
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 10:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238336AbiHRI17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 04:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbiHRI15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 04:27:57 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FEFAF4BF
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 01:27:56 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 130so898366pfy.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 01:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=EmRObFLBYlo/QTIFOmKwyNbAwrACrTIX9zYb5ZW9YpQ=;
        b=ZnFbnLt+FmH/S92YpyR3SthYc2Q1rZs+3KQgNhRfnSuREc+qoFxX6gtyU3tRPSBXlQ
         ywvhMZRNfJw2m16v1N8UNmBzIWu/K+ar8pEtCvgXYfOcrzWZHezwXsdko0iBBBoec0zG
         2u9/hXyGsaaJKrnqpEoaHCSbauNEoaUB7ms8jnTIuikzM77pfGuqn58nDXiXAXYAHmSA
         0gGj3P9rJo5p8/gVuDiQxalHRsb8Uqe2uzB54CoE1OUtP+L2Gc2deo27RhrgntpbUspc
         NpuDf2+WvZ443nhrYEjvcwDb0+3zB/lJaOyqZahjtFwmaI8KVmdu7BGxOaowdS7P1QeA
         l69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=EmRObFLBYlo/QTIFOmKwyNbAwrACrTIX9zYb5ZW9YpQ=;
        b=5eyrHx2DDwgf9Int+S9Titk2Y9OwOlDL4MbzpLNu+KqMa/Qw5VI7+TJdmAxAiuVzmS
         f4UiklWg8ucnUis7YgI8eXfJKnSbC9mDmlpFmy4MmqheUtrt0bgWN7FQ3vf4kV9rGwc3
         FPGSGUIbyaDR+p4arWCrfPSODIgj1XbdPKmxLCmuRSKAYUfnvzH+PVEFq76Tbvhgc68z
         x+LagYJfir09S3lTaS4bwM/L2WlmbLgS7ysYMIcmOiTJQhgjFTD4uLuSC5nXbbsvdqp1
         4XBPraQZfhv8VguAHSIDQ5K92/UIHicsc4YYCWrX0mvsxmNMrMbD3Ox2I68CT++FwsOF
         AVjQ==
X-Gm-Message-State: ACgBeo2tUkrT9bsi6Itdw/egxe8jlaKG8XliUya8DXQudUCScXJZbStc
        9pR6QnROoSdaGglyKrZVGt+LGw==
X-Google-Smtp-Source: AA6agR5DTxmJDTqZ0OLuFeuGqsM5XgRBq8GRImtxLazznsQnmAtoenqlD5ZooU2acz1nq4rvKV7k/w==
X-Received: by 2002:a63:82c6:0:b0:41c:d253:a446 with SMTP id w189-20020a6382c6000000b0041cd253a446mr1623984pgd.125.1660811275880;
        Thu, 18 Aug 2022 01:27:55 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id 83-20020a621756000000b0052b84ca900csm971920pfx.62.2022.08.18.01.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 01:27:55 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH] mm: thp: remove redundant pgtable check in set_huge_zero_page()
Date:   Thu, 18 Aug 2022 16:27:48 +0800
Message-Id: <20220818082748.40021-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the pgtable is NULL in the set_huge_zero_page(), we should
not increment the count of PTE page table pages by calling
mm_inc_nr_ptes(). Otherwise we may receive the following warning
when the mm exits:

	BUG: non-zero pgtables_bytes on freeing mm

Now we can't observe the above warning since only
do_huge_pmd_anonymous_page() invokes set_huge_zero_page() and the
pgtable can not be NULL.

Therefore, instead of moving mm_inc_nr_ptes() to the non-NULL
branch of pgtable, it is better to remove the redundant pgtable
check directly.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/huge_memory.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 83c47a989260..655da0b4fea0 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -770,8 +770,7 @@ static void set_huge_zero_page(pgtable_t pgtable, struct mm_struct *mm,
 		return;
 	entry = mk_pmd(zero_page, vma->vm_page_prot);
 	entry = pmd_mkhuge(entry);
-	if (pgtable)
-		pgtable_trans_huge_deposit(mm, pmd, pgtable);
+	pgtable_trans_huge_deposit(mm, pmd, pgtable);
 	set_pmd_at(mm, haddr, pmd, entry);
 	mm_inc_nr_ptes(mm);
 }
-- 
2.20.1

