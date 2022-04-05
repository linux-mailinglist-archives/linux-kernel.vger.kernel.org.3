Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EBF4F210B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiDECnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiDECnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:43:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEB4618B335
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649123320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sVIJ8cJ4ZYWLy9njZqjP9dBoADUUbduMAUK9CqZAoa8=;
        b=UdMJcHOnPK/KgaaaqIJ/WufnDJY3G4CHw2hv7tAy4qlSitJKRSL+b+cnD0nyINvozJFite
        X2N22Qrbubc9JnNoLUZoN6eouJOuKdxZqWt6/TLJocAGomrlt5sTpprV0m9WMU480Q18wC
        LQ7yz+Rz/JZfdRbS2CyHb6DWaf7SXzE=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221-6MwUwmLLPNeMVGSvJmw1Wg-1; Mon, 04 Apr 2022 21:48:39 -0400
X-MC-Unique: 6MwUwmLLPNeMVGSvJmw1Wg-1
Received: by mail-io1-f70.google.com with SMTP id z23-20020a6b0a17000000b00649f13ea3a7so7400482ioi.23
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 18:48:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sVIJ8cJ4ZYWLy9njZqjP9dBoADUUbduMAUK9CqZAoa8=;
        b=rqu0Oj6dh+/4pIQO8GASp88dNkCCSpdGff1oqtkUq9UOPFx9H4OWC7IyCQ+Cgtmraw
         wr8SrnzLGXCMBQynCxCfzYXcxAWdk4KD9teyRCtJ9A5ZtPyNysQ+vRGZF2TknGBk27Xo
         IzgHrRlsS0oodhUfeVHezKKR+40yzjrFvUuTmkYY5bho5yvX8m/A8/1ZcUIgKWvOCZ7B
         WknnxvBkSNh6yCJcxanh4R/kq31uJnCkpUkgj6dWwOxATGUYzM0PXNildqvfEIaFzCIR
         pWihoDDO9CB7rPNG6MYzZZ+8HrIQDhpI5EtMZ101AJMyWjP4i7NSUn18yxlcbXqBLGUv
         2NJA==
X-Gm-Message-State: AOAM530Vf+wuyjcgqCmPVJStweT0+O3QTO+/Hx1ZRzdKvjYwwsQyp2eL
        WXpbB1ggaF2JehXa26gDdSatEd+t9FnFAs5nG4KS6+pOYAIpsyrPh8sQpRrEjtAB9b9sGHd01yl
        H1qVjtnKSh6kc+jco/eIOdknI67W65nAH9+esdzGsWbofQgrO0wYsIWMZ7Jev8NUCYGvyS0iNHw
        ==
X-Received: by 2002:a92:cc41:0:b0:2ca:317d:1545 with SMTP id t1-20020a92cc41000000b002ca317d1545mr610371ilq.97.1649123319014;
        Mon, 04 Apr 2022 18:48:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4r+oclsvcEsUiRUe9DMRABSCkkiRtx/NYkAy387pbnwUItvkV/gFFJ6K8jTgQhR+UEusSug==
X-Received: by 2002:a92:cc41:0:b0:2ca:317d:1545 with SMTP id t1-20020a92cc41000000b002ca317d1545mr610343ilq.97.1649123318645;
        Mon, 04 Apr 2022 18:48:38 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id s5-20020a056602168500b0064c82210ce4sm7650542iow.13.2022.04.04.18.48.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Apr 2022 18:48:38 -0700 (PDT)
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
Subject: [PATCH v8 03/23] mm: Check against orig_pte for finish_fault()
Date:   Mon,  4 Apr 2022 21:48:36 -0400
Message-Id: <20220405014836.14077-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220405014646.13522-1-peterx@redhat.com>
References: <20220405014646.13522-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to check against none pte in finish_fault(), with the assumption
that the orig_pte is always none pte.

This change prepares us to be able to call do_fault() on !none ptes.  For
example, we should allow that to happen for pte marker so that we can restore
information out of the pte markers.

Let's change the "pte_none" check into detecting changes since we fetched
orig_pte.  One trivial thing to take care of here is, when pmd==NULL for
the pgtable we may not initialize orig_pte at all in handle_pte_fault().

By default orig_pte will be all zeros however the problem is not all
architectures are using all-zeros for a none pte.  pte_clear() will be the
right thing to use here so that we'll always have a valid orig_pte value
for the whole handle_pte_fault() call.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 3f396241a7db..b1af996b09ca 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4241,7 +4241,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 				      vmf->address, &vmf->ptl);
 	ret = 0;
 	/* Re-check under ptl */
-	if (likely(pte_none(*vmf->pte)))
+	if (likely(pte_same(*vmf->pte, vmf->orig_pte)))
 		do_set_pte(vmf, page, vmf->address);
 	else
 		ret = VM_FAULT_NOPAGE;
@@ -4709,6 +4709,13 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		 * concurrent faults and from rmap lookups.
 		 */
 		vmf->pte = NULL;
+		/*
+		 * Always initialize orig_pte.  This matches with below
+		 * code to have orig_pte to be the none pte if pte==NULL.
+		 * This makes the rest code to be always safe to reference
+		 * it, e.g. in finish_fault() we'll detect pte changes.
+		 */
+		pte_clear(vmf->vma->vm_mm, vmf->address, &vmf->orig_pte);
 	} else {
 		/*
 		 * If a huge pmd materialized under us just retry later.  Use
-- 
2.32.0

