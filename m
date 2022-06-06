Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775E153F1DB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 23:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbiFFVoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 17:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiFFVoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 17:44:30 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A1898094
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 14:44:25 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q123so14021435pgq.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 14:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ij7n7UZO/IK0zKEVoAHKDokBQE/6XWgjwPeS6gPTqcc=;
        b=mXJ/hahxbI7vbEPKM3HNI31LOwv12MOVMykwZIF/4WcDnhIo7yCNxtwhCyA+9ateh8
         /dsaYwTgy+aYi1g7b3kCczzNJ+WEAy6PcjMcJ5J0IiDz9N71++VS+nAfh/2zpRkZHRfa
         vYvtioaXpeUvymXxTzMCRSVMrRPyXiSIYuL1uN7AZNHMXqfLKTCTvXDqHwZWqahHfM2L
         WCDWc/QOyZDpHyCDtkPuRhYal0AaWB8/j7KaKcBGmN9/a5lpVSIJnaHwWII2HPckBuW7
         rl6/VYaSW5bRJ2ZinxJHxIyok/ClC8cfp/QXquPk6mOoO7jd8h/jlQpaGDZwA+AlTVPK
         vFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ij7n7UZO/IK0zKEVoAHKDokBQE/6XWgjwPeS6gPTqcc=;
        b=3Ercl1cuYhfRGc3vubGmBB/N/2c58AYz30wypTaWw9+71Za4Dbbz0zkAsdUe8Zem+q
         9BnOMSM+LXoB/MVFDGLFStE6frpLGuwrGhNsHby//UZLyOAsfBqqr26XULFfz+/OD/qP
         AG8ycwahGsz3sjVcNWiSLBnL+BdrKZpI6H7ITFo+NIejvJ8Il5/RMpZ0CeNm8lxcXi8b
         ROXrpSPCrf44XAIbE3dtXhiRuG58KiWqcHim5s1AAJUpziqtHdmEurEMXBNbkPBaZ0a2
         IMyDjNhV0omp9+2XoyzE2W6eJmH9CXTl47dDCAI0Fy9noewmbsY3v21X9yIeZTkN0TQB
         COWQ==
X-Gm-Message-State: AOAM532KTq+MniNGJVj3Y3b4ogn2n8JooPxFiozbsB2Wir1PZEtW/SNq
        wNF5Mnb90ABfXLkoJkv+8JpmLUPUbRTm6w==
X-Google-Smtp-Source: ABdhPJzMLSIncjP6QHixKNI/DAPcwxVzDs8Kf+dHw2xn4cBNcjVPbSTe/tA+bImKxTtxSNxqvHYUlA==
X-Received: by 2002:a65:4907:0:b0:3fd:bc3e:fb0a with SMTP id p7-20020a654907000000b003fdbc3efb0amr6869220pgs.123.1654551865142;
        Mon, 06 Jun 2022 14:44:25 -0700 (PDT)
Received: from localhost.biz ([8.25.197.27])
        by smtp.gmail.com with ESMTPSA id a4-20020a170903100400b0016397da033csm10881675plb.62.2022.06.06.14.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 14:44:24 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 4/7] mm: khugepaged: use transhuge_vma_suitable replace open-code
Date:   Mon,  6 Jun 2022 14:44:11 -0700
Message-Id: <20220606214414.736109-5-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220606214414.736109-1-shy828301@gmail.com>
References: <20220606214414.736109-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hugepage_vma_revalidate() needs to check if the address is still in
the aligned HPAGE_PMD_SIZE area of the vma when reacquiring mmap_lock,
but it was open-coded, use transhuge_vma_suitable() to do the job.  And
add proper comments for transhuge_vma_suitable().

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/huge_mm.h | 6 ++++++
 mm/khugepaged.c         | 5 +----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index a8f61db47f2a..79d5919beb83 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -128,6 +128,12 @@ static inline bool transhuge_vma_size_ok(struct vm_area_struct *vma)
 	return false;
 }
 
+/*
+ * Do the below checks:
+ *   - For non-anon vma, check if the vm_pgoff is HPAGE_PMD_NR aligned.
+ *   - For all vmas, check if the haddr is in an aligned HPAGE_PMD_SIZE
+ *     area.
+ */
 static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
 		unsigned long addr)
 {
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 7a5d1c1a1833..ca1754d3a827 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -951,7 +951,6 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 		struct vm_area_struct **vmap)
 {
 	struct vm_area_struct *vma;
-	unsigned long hstart, hend;
 
 	if (unlikely(khugepaged_test_exit(mm)))
 		return SCAN_ANY_PROCESS;
@@ -960,9 +959,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 	if (!vma)
 		return SCAN_VMA_NULL;
 
-	hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
-	hend = vma->vm_end & HPAGE_PMD_MASK;
-	if (address < hstart || address + HPAGE_PMD_SIZE > hend)
+	if (!transhuge_vma_suitable(vma, address))
 		return SCAN_ADDRESS_RANGE;
 	if (!hugepage_vma_check(vma, vma->vm_flags))
 		return SCAN_VMA_CHECK;
-- 
2.26.3

