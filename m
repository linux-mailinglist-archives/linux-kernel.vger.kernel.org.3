Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B729752F4DF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 23:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353654AbiETVQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 17:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353620AbiETVQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 17:16:19 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC46E186FE
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:16:18 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 137so8739287pgb.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FWCxIN+M68b8uiRtqF0Q6BeafTmXXsLbaGp3KwE5XtE=;
        b=MG5vVMB1O1NSDsob7g9pjDp5FCqlGuxDo+ahWdni+xykPUyYHOm+0D8noRAq74+JQ3
         ymSgqr4s8HXyKD75hSX82thQ/A9aHCbx1yaH+uEPfkYDwW8qXoJmJOdc3k4PxTJ0l/x/
         zem0fbbcKw3CLdBC5NhXLdocPf/BD4U7TApI0nu3S0/wZGBWPblHmC+20JV2qpH86OIq
         +fNUten4IZo85SyB0S0PDX93GJNkybmS5QUO2lt8NCZryroleEsgnJFw6M0khfq2iGMV
         0wvG2C0aQJWNUL0fReMVyC4l1ULdpPVNgBy7a0TGl84OT/JETPlFJ1pjAL87O/I32R5A
         aHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FWCxIN+M68b8uiRtqF0Q6BeafTmXXsLbaGp3KwE5XtE=;
        b=H5Eaf9BvXzSRZBheujysjC6mZfxcyOFfBDAO31u82MTL4K99Hw3oO5bDFc16x/27i7
         C+HIWZKQPeiXTVee0HlGyz8BEfO8uyVePp+d4Ib/uIUaqjhKUVJlQr9TYoHZWcibZ7PL
         J0RYgamqlFRGUvMJ3UbPWMWKiCNazxVSfRYXea29Q1kGF3GMD+R5j31/PhW67vHQJKtD
         VIpL5tHwy8mC0DqnwX3FfqyPM8WuHpg4+D1wE2Aj3rNHXucGdWMo0SPLuciN5szcWMM9
         CcPKicBssIq3NZ78TXdQx42yJl4yNfR3T7HnXcdE0okET8FNCcj30G/6JWYMA1inIxqq
         zxaA==
X-Gm-Message-State: AOAM530260QU/Xh46AHoAwtOGJxIQUHIgjCpzUvGekIeFQuAfg+k4BOa
        ZQ+CUd36HtYdE8utwaUC6Cc=
X-Google-Smtp-Source: ABdhPJyMccpJT5QHUtC5TElaI9zRj5Wzpv1ff3zBCJTMwc9y4u0+s7GN6DjhmisDKbpeVNwQvxjWew==
X-Received: by 2002:a62:6410:0:b0:4f3:9654:266d with SMTP id y16-20020a626410000000b004f39654266dmr11682191pfb.59.1653081377797;
        Fri, 20 May 2022 14:16:17 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902748100b0015e8d4eb2c2sm167620pll.268.2022.05.20.14.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 14:16:17 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] mm: khugepaged: use transhuge_vma_suitable replace open-code
Date:   Fri, 20 May 2022 14:16:02 -0700
Message-Id: <20220520211605.51473-5-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220520211605.51473-1-shy828301@gmail.com>
References: <20220520211605.51473-1-shy828301@gmail.com>
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
index 4fe1dd3d8ef4..51f0e6ea3977 100644
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

