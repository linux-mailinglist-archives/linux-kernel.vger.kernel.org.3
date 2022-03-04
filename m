Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093374CCCF2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238129AbiCDFUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238119AbiCDFUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:20:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7343184615
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646371174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8c/lNa0oM80rkM4kbMMwF9soU2NQfSaZ5E7MuZnV//g=;
        b=isNEHponEL21nwh7Ua9pT37LZoTRuMx/nxB0oG0Avq3rQFvV3elkehMafVN1iNcNy1/IrZ
        NZTHIdIUUkFR1mXBcPvBtDxLojoBreRCOvsV0z792eHN8ZfrffveWox6Sac/4X+QIhQvHP
        Ek21AZPYHoGLV4F8Mal3LmZfuVopio0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80-d18QJnMHO_iSKP7gAm8lxw-1; Fri, 04 Mar 2022 00:19:32 -0500
X-MC-Unique: d18QJnMHO_iSKP7gAm8lxw-1
Received: by mail-pj1-f70.google.com with SMTP id p5-20020a17090a748500b001bee6752974so4167502pjk.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 21:19:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8c/lNa0oM80rkM4kbMMwF9soU2NQfSaZ5E7MuZnV//g=;
        b=poFGTYUIZIkMyJTGOSBgU5m1cNTGJOlAA+9yInXLTd6TyPCaZixLnZv9IGSGPHako2
         +mHJlEquqP3skcw85tJgQ2VmcQKtkRdLbsJS7UO/TUWzdYSZfOUcw0OLPySsqVGFZiNY
         y4WE0egUaWYQo7QFU9vwepHChrxezrfTGBChlbHWxHnmE0YW7FOInluuoSwTZ+0ORvBv
         RbXz4zydO/5/uiTg7hJ6UG055N07ihNNc19Syrtj0DbuT35PUSMQxMc62YxtLTq1qSud
         o6Aqs1JogSylviykCqFHghox/p/kpX0/vrCqQGPv7X47KJAz4BQX59GypEnipY95ITWQ
         H3dQ==
X-Gm-Message-State: AOAM530gA7uXbdkukbOXqXEFlqrYWPLgJS13PKTTFogEnkt9Ui+FxrlZ
        Gw+MRXNLQY1fb9BARe6x0zjpnugoZvxAZnO+r1nm3EzoaMKLVIs3NHQqFIeMbMllrEc0G1fTkLv
        IaQUBziBUUoYgR9aHogQbkQqo
X-Received: by 2002:a17:902:f145:b0:151:a441:433a with SMTP id d5-20020a170902f14500b00151a441433amr8804581plb.44.1646371171329;
        Thu, 03 Mar 2022 21:19:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFfQF8+il2cx3Q+YaVVz5krns+0z+Q5hZNGFwZcBniVedYFkNfGyU++c+42HLp3JPbzL24yQ==
X-Received: by 2002:a17:902:f145:b0:151:a441:433a with SMTP id d5-20020a170902f14500b00151a441433amr8804562plb.44.1646371171051;
        Thu, 03 Mar 2022 21:19:31 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.59])
        by smtp.gmail.com with ESMTPSA id p16-20020a056a000b5000b004f669806cd9sm4323865pfo.87.2022.03.03.21.19.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Mar 2022 21:19:30 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v7 16/23] mm/hugetlb: Allow uffd wr-protect none ptes
Date:   Fri,  4 Mar 2022 13:17:01 +0800
Message-Id: <20220304051708.86193-17-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304051708.86193-1-peterx@redhat.com>
References: <20220304051708.86193-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Teach hugetlbfs code to wr-protect none ptes just in case the page cache
existed for that pte.  Meanwhile we also need to be able to recognize a uffd-wp
marker pte and remove it for uffd_wp_resolve.

Since at it, introduce a variable "psize" to replace all references to the huge
page size fetcher.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index afd3d93cfe9a..1a20be29ac3a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6169,7 +6169,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	pte_t *ptep;
 	pte_t pte;
 	struct hstate *h = hstate_vma(vma);
-	unsigned long pages = 0;
+	unsigned long pages = 0, psize = huge_page_size(h);
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
@@ -6189,13 +6189,19 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 
 	mmu_notifier_invalidate_range_start(&range);
 	i_mmap_lock_write(vma->vm_file->f_mapping);
-	for (; address < end; address += huge_page_size(h)) {
+	for (; address < end; address += psize) {
 		spinlock_t *ptl;
-		ptep = huge_pte_offset(mm, address, huge_page_size(h));
+		ptep = huge_pte_offset(mm, address, psize);
 		if (!ptep)
 			continue;
 		ptl = huge_pte_lock(h, mm, ptep);
 		if (huge_pmd_unshare(mm, vma, &address, ptep)) {
+			/*
+			 * When uffd-wp is enabled on the vma, unshare
+			 * shouldn't happen at all.  Warn about it if it
+			 * happened due to some reason.
+			 */
+			WARN_ON_ONCE(uffd_wp || uffd_wp_resolve);
 			pages++;
 			spin_unlock(ptl);
 			shared_pmd = true;
@@ -6220,12 +6226,20 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 				else if (uffd_wp_resolve)
 					newpte = pte_swp_clear_uffd_wp(newpte);
 				set_huge_swap_pte_at(mm, address, ptep,
-						     newpte, huge_page_size(h));
+						     newpte, psize);
 				pages++;
 			}
 			spin_unlock(ptl);
 			continue;
 		}
+		if (unlikely(pte_marker_uffd_wp(pte))) {
+			/*
+			 * This is changing a non-present pte into a none pte,
+			 * no need for huge_ptep_modify_prot_start/commit().
+			 */
+			if (uffd_wp_resolve)
+				huge_pte_clear(mm, address, ptep, psize);
+		}
 		if (!huge_pte_none(pte)) {
 			pte_t old_pte;
 			unsigned int shift = huge_page_shift(hstate_vma(vma));
@@ -6239,6 +6253,12 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 				pte = huge_pte_clear_uffd_wp(pte);
 			huge_ptep_modify_prot_commit(vma, address, ptep, old_pte, pte);
 			pages++;
+		} else {
+			/* None pte */
+			if (unlikely(uffd_wp))
+				/* Safe to modify directly (none->non-present). */
+				set_huge_pte_at(mm, address, ptep,
+						make_pte_marker(PTE_MARKER_UFFD_WP));
 		}
 		spin_unlock(ptl);
 	}
-- 
2.32.0

