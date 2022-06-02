Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7421253BDFC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 20:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbiFBSWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 14:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237993AbiFBSWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 14:22:11 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3EE6436
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 11:22:09 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id g205so5395588pfb.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 11:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ij7n7UZO/IK0zKEVoAHKDokBQE/6XWgjwPeS6gPTqcc=;
        b=IpMzaIeFOsyZY5RirkJatHmncMuZPPqDAIcHJBZPIVp7G09X1sx9pTdtZ7RdyauoYu
         CXIXH82Up2DBdc5z5bS621MpSvaQAGhEYPODX5fWKNzCB4RQkpwyu2MPYjFnd6ml7115
         Nwn/88YW4mU+XngygZGDRSvug40didfLWbcdd349F5mSLAuviIyjwBV6PRONP4z47m0x
         FPA/CgZSc2y/sQh3LXmJ9s9TVq2jz2mvYgIZe77eWdrLNR2mbFcu5BYQ9WCsR1D/zQfL
         5PPDk7dZs5AT4EQhjDnYpA8iC6vJaBbnXsV2xL/9ZDOr3dh5+4P3HEM8j12kvAV/h3wN
         5ysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ij7n7UZO/IK0zKEVoAHKDokBQE/6XWgjwPeS6gPTqcc=;
        b=4C08otoAoRJHFNFbjwMiZb44XveSXb2mU6Xosi9V207h0nmcft7yUU+VOfwmFVQlj4
         x+rE/Jlbamv990zTFPJdm76/YzNujcCsJCYkCukIHDFbzZ9HjPpq1Lopotnh/kVYVzY+
         TN/ponkHO3t6R5szXibv681fIclX1ekAGTXiUk47jTNOp+v3+uvOUMhE2lCX3iMBQFNI
         66x54afUFcqxj+yj7qX8wGt8ASb7yctmhJtsYkag8uRYWHqbzFIfaBP0nTvIg2AG8Px0
         y4I5toYqjVm82Etj9JnZ1vFLwxKJd7lIB21rSI2TNIUystuX5vTfQ5Xn5Q7cEKa+MHYA
         LRlw==
X-Gm-Message-State: AOAM533G4/wDNKbonAlrXgS/Md8bPq6wikrpibu4xO1KtQ88iiS9370i
        +ARlttATF8ZSI5InwyhVFVw=
X-Google-Smtp-Source: ABdhPJyLtH0blR5AqKJCr/dkM/hu+mh+rj2O4bSVPpE5tGGO/EHu3X2wtkjB9koaOEl7+HMO4L+bWQ==
X-Received: by 2002:a05:6a00:179e:b0:518:9e1d:1cbd with SMTP id s30-20020a056a00179e00b005189e1d1cbdmr54800149pfg.12.1654194129509;
        Thu, 02 Jun 2022 11:22:09 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id t10-20020a1709027fca00b0015f2d549b46sm3866779plb.237.2022.06.02.11.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 11:22:08 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 4/7] mm: khugepaged: use transhuge_vma_suitable replace open-code
Date:   Thu,  2 Jun 2022 11:21:56 -0700
Message-Id: <20220602182159.248387-5-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220602182159.248387-1-shy828301@gmail.com>
References: <20220602182159.248387-1-shy828301@gmail.com>
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

