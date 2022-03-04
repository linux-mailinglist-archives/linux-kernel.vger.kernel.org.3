Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8F04CCCEE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbiCDFTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238079AbiCDFTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:19:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98B48AA01A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646371117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cWQZRYNGI2cSzJcmY2NeIfodfPZX4V25Mo1spySEF5s=;
        b=FJtY6RtzeJpPfCauenbbhYLU99scnUrXwd04P0gEZqI9qaEGWel++OnFeawcbroKNUGz3q
        VGWsn9ZVGuoAsAbUSW+lE6epUWmb1c8/v4ar9cD1RKV/iqLPdG4n6j27+DtZY43nqmeQxL
        b41qK1bZ/pQ61suzF3+pUBX48483aHs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-q1iNiXs1N6Ck0eExqtroyw-1; Fri, 04 Mar 2022 00:18:36 -0500
X-MC-Unique: q1iNiXs1N6Ck0eExqtroyw-1
Received: by mail-pj1-f72.google.com with SMTP id e7-20020a17090a4a0700b001bc5a8c533eso4173379pjh.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 21:18:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cWQZRYNGI2cSzJcmY2NeIfodfPZX4V25Mo1spySEF5s=;
        b=wmRjd84AdgTeZLdDvmPUYGp1Tpzmhic3+WFiHanbVCwWgHiMOqjHAJEXPxHmj51ece
         2j82HIrXg46lmKbJOfkRqrZ236CmT1EeTHSNcsIlNsQnkfY1bzhWkBysrxbKg6f3IaAJ
         eG9fxZTuOS+roWRw3JfWffnchqZW5nqnE2YFeytPGPUM+Ems4wprUB2LZbleSy+MFTEu
         8JYbi4ki2ySwwhOKeYo6gMwGcmLBKmGzAcVcKbYv7cpuC5zPzxxCE4XNPpsFRAb79DYd
         SN/YfJnTV7Owp+4yqr09A7k4fn9vLlr3N2y7PKhmKV2JX67VW5ZRxi2JuO5W6ZNS6RbC
         fYPA==
X-Gm-Message-State: AOAM530wRoq/W11MLjZbnxWHARXUPE1rb+v9v9ebBQIMVPU/2qowvJ/I
        vpnGHLngly1h0/2aEOicyO0LLTSFJPLNv28rCJyZstzxy5C3e2U+dKyOt931IBoJMZBioDOCpLF
        UdmcW6B6/E6oilyWcftN/4oxv
X-Received: by 2002:a63:af02:0:b0:375:57f0:8af1 with SMTP id w2-20020a63af02000000b0037557f08af1mr32843634pge.188.1646371115432;
        Thu, 03 Mar 2022 21:18:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx4jOImxHShOaqYtf+LhwSwkfO4VXJz5d+7rIaM+Vv6wcTRt41/dvgoYP9dxEas9oL3cZidzQ==
X-Received: by 2002:a63:af02:0:b0:375:57f0:8af1 with SMTP id w2-20020a63af02000000b0037557f08af1mr32843618pge.188.1646371115135;
        Thu, 03 Mar 2022 21:18:35 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.59])
        by smtp.gmail.com with ESMTPSA id p16-20020a056a000b5000b004f669806cd9sm4323865pfo.87.2022.03.03.21.18.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Mar 2022 21:18:34 -0800 (PST)
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
Subject: [PATCH v7 09/23] mm/shmem: Allows file-back mem to be uffd wr-protected on thps
Date:   Fri,  4 Mar 2022 13:16:54 +0800
Message-Id: <20220304051708.86193-10-peterx@redhat.com>
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

We don't have "huge" version of pte markers, instead when necessary we split
the thp.

However split the thp is not enough, because file-backed thp is handled totally
differently comparing to anonymous thps: rather than doing a real split, the
thp pmd will simply got cleared in __split_huge_pmd_locked().

That is not enough if e.g. when there is a thp covers range [0, 2M) but we want
to wr-protect small page resides in [4K, 8K) range, because after
__split_huge_pmd() returns, there will be a none pmd, and change_pmd_range()
will just skip it right after the split.

Here we leverage the previously introduced change_pmd_prepare() macro so that
we'll populate the pmd with a pgtable page after the pmd split (in which
process the pmd will be cleared for cases like shmem).  Then change_pte_range()
will do all the rest for us by installing the uffd-wp pte marker at any none
pte that we'd like to wr-protect.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/mprotect.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 4878b6b99df9..95b307d4766d 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -329,8 +329,15 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 		}
 
 		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
-			if (next - addr != HPAGE_PMD_SIZE) {
+			if ((next - addr != HPAGE_PMD_SIZE) ||
+			    uffd_wp_protect_file(vma, cp_flags)) {
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
+				/*
+				 * For file-backed, the pmd could have been
+				 * cleared; make sure pmd populated if
+				 * necessary, then fall-through to pte level.
+				 */
+				change_pmd_prepare(vma, pmd, cp_flags);
 			} else {
 				int nr_ptes = change_huge_pmd(vma, pmd, addr,
 							      newprot, cp_flags);
-- 
2.32.0

