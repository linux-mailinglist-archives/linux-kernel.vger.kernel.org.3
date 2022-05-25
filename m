Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1538533FA2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244805AbiEYO41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241939AbiEYO4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:56:23 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9461D36171
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:56:21 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t6so30502070wra.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GRmrkmCITQkax/Dx9/Fy9p50J8k27ds4oFcgLc3FeZQ=;
        b=kvCQ65GYzcvSQpaiM0pwVax/xwd/9jvuxahiPnCLkSIX4BdbI1za5P7bpU9VlQK6ea
         BA61JlkSTP64rbEh2gh6mQSRNVUuHrRLTGz2EaNf9eCTprzJPKjfk4o2EsOhfyWD3wyW
         qFiFKPSQeqRTBUcI2uZ2EISBz0swMaw4t5qSQWe8jRRV+/EFhQWglN8/iqhPIZ9kvCbG
         CMiDsuK8/WE5ZlvxLcVOzJCPeSd0PESvhRpCRawDYukzTVVyIFbTR0/1YVsoeS2v55cT
         E66jCsl5nrzuTTzJUl2/2Z2JWWTxOgRayefQWFGxIoQgLoZopzRzn/1xE6QNoBPY+ll+
         RZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GRmrkmCITQkax/Dx9/Fy9p50J8k27ds4oFcgLc3FeZQ=;
        b=6V2F4mwhDPaNL2lBouVH+o+uD2NwBGdMT1/dj53BhVQeOdr1j7C2tq/gJ+2gyzbqTg
         AnnXng6IontXOmPSHrx5xrq+RN2V0ks5mz3N7iWviPTSPVC9zhWEREUe8JYZoeV2Fw97
         7Og29SEziSR0xwuwjhZZC4aKUM0kAIDAk+elH9Vx1O3E5isdPLL7pKde7mGTTpZqs5VN
         d7D0mQ9N1f97/9OiHKkZJFZ6tjnUGc47xtKHNHZ1ztsWF3OODMT9BxFB5aHwyqOKou4K
         1bDak7r2FZFyMlP6kbu9jMC5nUCZZVbTZqfLDhlMm2C/k0b2kfYfc7D4oOK7PawAA6n+
         YGwA==
X-Gm-Message-State: AOAM531pNMIT/tZU4RDrrp2rottAEM/84JxxCIajVBrL1jNpwgdPqwol
        BwB0i4FkVWp0JPNqRBoC8/4MlQy3+jg=
X-Google-Smtp-Source: ABdhPJzN/+hdpLVh3Tf15FuI+QNff0WX1WTfvz9VDPa84g7vY4sBJBxH+JDHaGZnaFnCPPm7JH02NQ==
X-Received: by 2002:a5d:5310:0:b0:20f:d075:a386 with SMTP id e16-20020a5d5310000000b0020fd075a386mr15953145wrv.619.1653490580047;
        Wed, 25 May 2022 07:56:20 -0700 (PDT)
Received: from localhost.localdomain (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id a19-20020a05600c349300b00397071b10dfsm2168896wmq.10.2022.05.25.07.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 07:56:19 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH] iommu/amd: Use try_cmpxchg64 in alloc_pte and free_clear_pte
Date:   Wed, 25 May 2022 16:54:16 +0200
Message-Id: <20220525145416.10816-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.35.3
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

Use try_cmpxchg64 instead of cmpxchg64 (*ptr, old, new) != old in
alloc_pte and free_clear_pte.  cmpxchg returns success in ZF flag, so this
change saves a compare after cmpxchg (and related move instruction
in front of cmpxchg). Also, remove racy explicit assignment to pteval
when cmpxchg fails, this is what try_cmpxchg does implicitly from
*pte in an atomic way.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Will Deacon <will@kernel.org>
---
 drivers/iommu/amd/io_pgtable.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 6608d1717574..7d4b61e5db47 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -258,7 +258,7 @@ static u64 *alloc_pte(struct protection_domain *domain,
 			__npte = PM_LEVEL_PDE(level, iommu_virt_to_phys(page));
 
 			/* pte could have been changed somewhere. */
-			if (cmpxchg64(pte, __pte, __npte) != __pte)
+			if (!try_cmpxchg64(pte, &__pte, __npte))
 				free_page((unsigned long)page);
 			else if (IOMMU_PTE_PRESENT(__pte))
 				*updated = true;
@@ -341,10 +341,8 @@ static void free_clear_pte(u64 *pte, u64 pteval, struct list_head *freelist)
 	u64 *pt;
 	int mode;
 
-	while (cmpxchg64(pte, pteval, 0) != pteval) {
+	while (!try_cmpxchg64(pte, &pteval, 0))
 		pr_warn("AMD-Vi: IOMMU pte changed since we read it\n");
-		pteval = *pte;
-	}
 
 	if (!IOMMU_PTE_PRESENT(pteval))
 		return;
-- 
2.35.3

