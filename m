Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750B455A05C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbiFXRhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiFXRhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:37:22 -0400
Received: from mail-ua1-x94a.google.com (mail-ua1-x94a.google.com [IPv6:2607:f8b0:4864:20::94a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444E1609EF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:22 -0700 (PDT)
Received: by mail-ua1-x94a.google.com with SMTP id v14-20020ab0768e000000b0037efa637aeeso1006779uaq.23
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WX+TLc+c32jY73zAmELqfC7scmTotnHMJPgbPcH9Hag=;
        b=rmtQIA0RTPQYWEYJ8kZRSAxO4ZWdbskuHARii0tUqF87tsg4HJnPzpTHsKmHhi7YHN
         szZo8r74Pfgxru6pGunO7KfxJtr6Wzabwa1wcCmLVAdMbm+j8fKHC5fV7wwrJG+ncVrB
         fWoXECRaKY9gz8ZiGg0zDe612OVnVf2pAh18JbfgZ2OytbBwiZCNN/oOGXrLiF3q3rzH
         fxFhSCJMn3o5octv4QkArXh3RvJqGO05jZSaGjrL9vscpWTsOFD0x47zLoXDuqUkCgEo
         PIWSrdAA+02ET/Ct0BrCGPnvyDWs7lIPDo0hPsnRg76cZrOaj70ey7iZ/86fIxktGj4r
         ckXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WX+TLc+c32jY73zAmELqfC7scmTotnHMJPgbPcH9Hag=;
        b=fg2uxSb0eIeOx+SwHEUnTeeQ0/mQ7qejyhIJQZ4lkZ1n4jf9eQkvW5M2RrasivKKI6
         NYJxFBoJDDEGsZFH9oViVnlhFUAvObZzF9S2LL6HFFGe7HJuEieQfDJ8E1cs0KfEPanG
         zUJTalnxI10kLm3IthIy2KYcXVo3+KfKvqEBBYvebOY97W1vTvDI1mLFc4QqEhapoWlw
         5DH8a/gMDi9elceWE8dWkAhmCM+qDzMyBVuCk49MRbfkMkU1U1uX8DfX9my2lcfadQZ/
         h6f6drcPCHRoQH4dglZZOMNoRJBpbsPJwPmeXfInD0Js+wQ/zyL8iI5t5j+NmYCEbtZd
         5DUw==
X-Gm-Message-State: AJIora8VMsmlJ6zZyoRqImoEEJbryC3gfh4oDt4b/E52fcTjp70ImxeV
        QyT7G7Y940Z43AR6JJI+lHIzJNscK5LGWSzH
X-Google-Smtp-Source: AGRyM1vX/wsU1Y9GWc4aZF68+l300w5Pdum+7CFc6GFKGc4oec+e4PYz/yVOvKtQiR6acb6V/yx2DV4xq/fD/H/b
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a67:6e47:0:b0:354:52a0:8ac2 with SMTP
 id j68-20020a676e47000000b0035452a08ac2mr173638vsc.65.1656092242031; Fri, 24
 Jun 2022 10:37:22 -0700 (PDT)
Date:   Fri, 24 Jun 2022 17:36:39 +0000
In-Reply-To: <20220624173656.2033256-1-jthoughton@google.com>
Message-Id: <20220624173656.2033256-10-jthoughton@google.com>
Mime-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [RFC PATCH 09/26] hugetlb: add hugetlb_hgm_enabled
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, this is always true if the VMA is shared. In the future, it's
possible that private mappings will get some or all HGM functionality.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/linux/hugetlb.h | 10 ++++++++++
 mm/hugetlb.c            |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 33ba48fac551..e7a6b944d0cc 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1174,6 +1174,16 @@ static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 }
 #endif	/* CONFIG_HUGETLB_PAGE */
 
+#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
+/* If HugeTLB high-granularity mappings are enabled for this VMA. */
+bool hugetlb_hgm_enabled(struct vm_area_struct *vma);
+#else
+static inline bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
+{
+	return false;
+}
+#endif
+
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
 					struct mm_struct *mm, pte_t *pte)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a2d2ffa76173..8b10b941458d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6983,6 +6983,14 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 
 #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
 
+#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
+bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
+{
+	/* All shared VMAs have HGM enabled. */
+	return vma->vm_flags & VM_SHARED;
+}
+#endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
+
 /*
  * These functions are overwritable if your architecture needs its own
  * behavior.
-- 
2.37.0.rc0.161.g10f37bed90-goog

