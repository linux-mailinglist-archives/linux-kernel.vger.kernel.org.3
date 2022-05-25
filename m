Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164C9534497
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 21:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344785AbiEYTwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 15:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239643AbiEYTw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 15:52:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4F3113F15
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 12:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653508345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MoWVBq/Srp3PM5Qk/nZzvo63HOw5jDODOMMJjoSaqDU=;
        b=XIogzBMRNbL7IAItWb489/xhAY/DRfpWOgXH2PzBzsq30Dp/YUJcRHk3zdoJUgTXFywNnx
        aF5Rca5WaV3Q0ldCe1MP+/eXfxs+NGAhlipZPZc1CwebkapbC1ZYLjehscCZq46d95DKyP
        4FNTQDMMOw7ER1vJBgKlGBQdYxQbPgs=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-mAT3p7_lO1mqkSQ4BefgLw-1; Wed, 25 May 2022 15:52:24 -0400
X-MC-Unique: mAT3p7_lO1mqkSQ4BefgLw-1
Received: by mail-il1-f197.google.com with SMTP id p12-20020a056e02144c00b002d196a4d73eso7301006ilo.18
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 12:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MoWVBq/Srp3PM5Qk/nZzvo63HOw5jDODOMMJjoSaqDU=;
        b=f2Tcxw19sSEraA4VXD7dzYeaKfBc/mvPyvQtTAbKEdls4DqymFgSy3WM33JHl+iNWn
         TBtELcLABHPuU9nZldmh9+5zkXGBntci/eVlbjXTyHJmJV/bViBLNbSivjL8E9PFzWhw
         mlOBfJYPXkZJzkokXnB9wPOnAK+1qEV+7HMatPW9CVW/gpb5HeFx/9svu16G8hEIc9IV
         RZ0m85DGYG2MsnxutYDasNs3gjCL4hSAGcQuW6UK8qtjrMsuWalTSfZGe5atN0NhaJv0
         Jq4s4MTzECjQ+sjjqIltKxaaP6mhCJJaaRLcSgeuXFJLXLnJdIfdnoJrJ0xqtAuG5Xp3
         KkzQ==
X-Gm-Message-State: AOAM5304svxPFQCdX7uaQWaR0sxhu890aO4X6pmi68+rFwXuAHXQpmOu
        SLoGbyldi8glz8WcBZZPNrLufIcgMU1EXryceOKBJ/pK7lVXPXz+iBGup/B+OrrG7rLJuHI7+My
        RbX3xuQIPdvnAkbHYJTFEXfNPp4l1eByAXMc81eXJzAbLeX3od1jCBI1VW3Vnb7s70Y1ueCjffg
        ==
X-Received: by 2002:a05:6602:29ce:b0:609:4f60:59cb with SMTP id z14-20020a05660229ce00b006094f6059cbmr15759286ioq.183.1653508343121;
        Wed, 25 May 2022 12:52:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9bqdjvCpdaS834IY1vu+Cs+k6e6lxk4WTcV42PxlupTWCvf9TA9JPzqBYXGpZnofQU3rNkQ==
X-Received: by 2002:a05:6602:29ce:b0:609:4f60:59cb with SMTP id z14-20020a05660229ce00b006094f6059cbmr15759276ioq.183.1653508342846;
        Wed, 25 May 2022 12:52:22 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id n25-20020a02a199000000b0032e31eeebc1sm4352021jah.170.2022.05.25.12.52.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 May 2022 12:52:22 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH] mm/x86: Remove dead code for hugetlbpage.c
Date:   Wed, 25 May 2022 15:52:20 -0400
Message-Id: <20220525195220.10241-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems to exist since the old times and never used once.  Remove them.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/mm/hugetlbpage.c | 39 ---------------------------------------
 1 file changed, 39 deletions(-)

diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
index a0d023cb4292..509408da0da1 100644
--- a/arch/x86/mm/hugetlbpage.c
+++ b/arch/x86/mm/hugetlbpage.c
@@ -19,44 +19,6 @@
 #include <asm/tlbflush.h>
 #include <asm/elf.h>
 
-#if 0	/* This is just for testing */
-struct page *
-follow_huge_addr(struct mm_struct *mm, unsigned long address, int write)
-{
-	unsigned long start = address;
-	int length = 1;
-	int nr;
-	struct page *page;
-	struct vm_area_struct *vma;
-
-	vma = find_vma(mm, addr);
-	if (!vma || !is_vm_hugetlb_page(vma))
-		return ERR_PTR(-EINVAL);
-
-	pte = huge_pte_offset(mm, address, vma_mmu_pagesize(vma));
-
-	/* hugetlb should be locked, and hence, prefaulted */
-	WARN_ON(!pte || pte_none(*pte));
-
-	page = &pte_page(*pte)[vpfn % (HPAGE_SIZE/PAGE_SIZE)];
-
-	WARN_ON(!PageHead(page));
-
-	return page;
-}
-
-int pmd_huge(pmd_t pmd)
-{
-	return 0;
-}
-
-int pud_huge(pud_t pud)
-{
-	return 0;
-}
-
-#else
-
 /*
  * pmd_huge() returns 1 if @pmd is hugetlb related entry, that is normal
  * hugetlb entry or non-present (migration or hwpoisoned) hugetlb entry.
@@ -72,7 +34,6 @@ int pud_huge(pud_t pud)
 {
 	return !!(pud_val(pud) & _PAGE_PSE);
 }
-#endif
 
 #ifdef CONFIG_HUGETLB_PAGE
 static unsigned long hugetlb_get_unmapped_area_bottomup(struct file *file,
-- 
2.32.0

