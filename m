Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B1E4F215A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiDECn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiDECnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:43:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66FCC39A6BF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649123337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Tho0jTi/mP2SxzzY9PiukQljtVmr59NjLeFBDKY3mg=;
        b=VvYOROd87jq+Jg2/XfDAYGNmhXghpTkG00CR2PUzRMNtHtM8tMJOnheAERPmyU9s4n/G/i
        5a5Gp4XQO2UvH0fjCGQQ+HosVBnJAtD3z5fStbt6/jk3l4iSbSAMZz9fpmyrBfOgCb4z6a
        thBjITEovDD8fcCcg4/ahIprgOJz/QA=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-F3aZemvIOrizMzRkvM_hLw-1; Mon, 04 Apr 2022 21:48:56 -0400
X-MC-Unique: F3aZemvIOrizMzRkvM_hLw-1
Received: by mail-il1-f199.google.com with SMTP id m3-20020a056e02158300b002b6e3d1f97cso7181907ilu.19
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 18:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Tho0jTi/mP2SxzzY9PiukQljtVmr59NjLeFBDKY3mg=;
        b=3ygzHfw73x/LbAoxCzoKI3d7UiwMg/yDhzIoQ2spn3i/c0pOsCuwklI8u/UOoIM/mh
         2Wu440nsFtpNyqJWZQDhn8u3SKCnYa88oI3YJa6W99CYXVXb3qdWxSRuVJLc9NlAsuM0
         qfnB5FDyi1EOG/GyUK4rOK8CvT2qX/3NjxVmQ0FOBV/vLaF0qHBqoBu+jQKE0p6XQ4M8
         G7vXKDJHvQ5bwpTjnNb2JIZCM2jW/Fp3M40dE1siO6BeiCXyLq2AQThng+1moHKZRz45
         M6yDZ1FEfbDm0w/40CUG58w+f8qZVKISD3PBvPV56Ly3Z+LjugCiOSKTAInIaIKziczv
         v+Hg==
X-Gm-Message-State: AOAM532csGB5kwIJxbQ/tEemkxCNU0AflItFAVv4/SeqkyzhUXQ399dT
        +BuP18qCn4QCZbshrF0D11NtYGumjhnY3Q5BtuWrnl6c+ZX0ldu0y7jtzC1UEL4Pl5cCWfAxOt0
        YEI2z9t7+gG1R/M7KUMQd9aGAzHEJKZs7wGzt35H4mEJj0lU2VS6q/sebSiA+kEoIg89e0UJKjA
        ==
X-Received: by 2002:a6b:e60a:0:b0:646:3e9e:172f with SMTP id g10-20020a6be60a000000b006463e9e172fmr604274ioh.1.1649123335833;
        Mon, 04 Apr 2022 18:48:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEUfWYkT5v8wLM/eubINNRKFmNMGPSIHFsXbNqMBzFCqBGDzRGSMNc6UHIgjk9FfldR5FQwA==
X-Received: by 2002:a6b:e60a:0:b0:646:3e9e:172f with SMTP id g10-20020a6be60a000000b006463e9e172fmr604247ioh.1.1649123335505;
        Mon, 04 Apr 2022 18:48:55 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id k6-20020a6b4006000000b00649d7111ebasm7563860ioa.0.2022.04.04.18.48.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Apr 2022 18:48:55 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alistair Popple <apopple@nvidia.com>, peterx@redhat.com
Subject: [PATCH v8 09/23] mm/shmem: Allows file-back mem to be uffd wr-protected on thps
Date:   Mon,  4 Apr 2022 21:48:52 -0400
Message-Id: <20220405014852.14413-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220405014646.13522-1-peterx@redhat.com>
References: <20220405014646.13522-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index bd62d5938c6c..e0a567b66d07 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -333,8 +333,15 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
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

