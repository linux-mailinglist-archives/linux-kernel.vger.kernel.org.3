Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748455904F5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 18:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238963AbiHKQmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 12:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239210AbiHKQlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 12:41:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5964A5C63
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660234422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3RIarNO4bl/SlYdwgU6TGCIMSMDAhYZFkoNFGsJp8ZY=;
        b=Ve3XDgeHzhWl1vN60y2FbtItfPts8jfi6EAA2rmqQ1gwGq9VPqMZmI6sAcqNLeHTob5pkG
        iDAd1LmFqFFnjYCbLAChj6sLqWTUMIwRseYb37zqxHfPOUPPyhaU6IymFMVG7/h+rLRy/E
        kiJNpP6QimDI6AA1Jrgf6CmF8y4C9w4=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-28-Qg9sZUtAONSi6vCROLRXPQ-1; Thu, 11 Aug 2022 12:13:41 -0400
X-MC-Unique: Qg9sZUtAONSi6vCROLRXPQ-1
Received: by mail-io1-f69.google.com with SMTP id j8-20020a6b7948000000b0067c2923d1b8so9797860iop.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3RIarNO4bl/SlYdwgU6TGCIMSMDAhYZFkoNFGsJp8ZY=;
        b=iQ+q4YCOKNlVEOVMrt0qwc3oHTyKFqITFcXBgCckhFPcJlct/bmFmotRqkF4aQmW3/
         shkIQNiJhonnkdWfzJR8PTOWvZ7j3ZSxvu1ILYVg4yWnKVfkdZt8xVIst8Ex+gvuqVrr
         noolZAnaFWajahyqz1AjiwQbnR3EryqpiR2fC+SDk1SbfRxge3ggXAL9akqhjYGVn2rB
         mnDXLswuYA+ehlN3nG4jbwC++V4nTe9ayNf3N/OwTUbNsSx2iWGoxeDn3TNgTg9pdsJt
         JkBhN/Ll9hMB6wwJXAmd6I4JkASk14AoycXaokHBRszBcklZsOzIPvKguE0DombgCmqB
         5Ozg==
X-Gm-Message-State: ACgBeo2IlN2qCWl7FjnF+H2ITanZL/UFOAh8Jq8YaFpGJ8ZB5MrBsmiF
        IC1Z8P3T7hdPpS2uGTB+AUj3gokMuoSEELz+WQhPtKR4v1e4CHg1kmyLi2WIsW7ZRxIUhT5NUGn
        CKgXSeu9MBVoE4oGNgufK+dft
X-Received: by 2002:a6b:c343:0:b0:67c:6033:a682 with SMTP id t64-20020a6bc343000000b0067c6033a682mr25999iof.148.1660234420822;
        Thu, 11 Aug 2022 09:13:40 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6oIBb2BB4Q/hh/sdEHHNGipMyiCcZTfi7mlLc8HUt82uGH8takFsvaPCiWYe/hV/AqCvZxHw==
X-Received: by 2002:a6b:c343:0:b0:67c:6033:a682 with SMTP id t64-20020a6bc343000000b0067c6033a682mr25990iof.148.1660234420598;
        Thu, 11 Aug 2022 09:13:40 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id t1-20020a92ca81000000b002dd1c3c5c46sm3415429ilo.73.2022.08.11.09.13.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Aug 2022 09:13:40 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Alistair Popple <apopple@nvidia.com>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v4 4/7] mm/thp: Carry over dirty bit when thp splits on pmd
Date:   Thu, 11 Aug 2022 12:13:28 -0400
Message-Id: <20220811161331.37055-5-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220811161331.37055-1-peterx@redhat.com>
References: <20220811161331.37055-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carry over the dirty bit from pmd to pte when a huge pmd splits.  It
shouldn't be a correctness issue since when pmd_dirty() we'll have the page
marked dirty anyway, however having dirty bit carried over helps the next
initial writes of split ptes on some archs like x86.

Reviewed-by: Huang Ying <ying.huang@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/huge_memory.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3222b40a0f6d..2f68e034ddec 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2027,7 +2027,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	pgtable_t pgtable;
 	pmd_t old_pmd, _pmd;
 	bool young, write, soft_dirty, pmd_migration = false, uffd_wp = false;
-	bool anon_exclusive = false;
+	bool anon_exclusive = false, dirty = false;
 	unsigned long addr;
 	int i;
 
@@ -2116,8 +2116,10 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		uffd_wp = pmd_swp_uffd_wp(old_pmd);
 	} else {
 		page = pmd_page(old_pmd);
-		if (pmd_dirty(old_pmd))
+		if (pmd_dirty(old_pmd)) {
+			dirty = true;
 			SetPageDirty(page);
+		}
 		write = pmd_write(old_pmd);
 		young = pmd_young(old_pmd);
 		soft_dirty = pmd_soft_dirty(old_pmd);
@@ -2183,6 +2185,9 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 				entry = pte_wrprotect(entry);
 			if (!young)
 				entry = pte_mkold(entry);
+			/* NOTE: this may set soft-dirty too on some archs */
+			if (dirty)
+				entry = pte_mkdirty(entry);
 			if (soft_dirty)
 				entry = pte_mksoft_dirty(entry);
 			if (uffd_wp)
-- 
2.32.0

