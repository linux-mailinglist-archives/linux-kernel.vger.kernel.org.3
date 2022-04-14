Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B8C501CF9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 22:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345341AbiDNVAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 17:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiDNVAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 17:00:11 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51222CD648
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 13:57:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B1413CE2BB5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 20:57:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817D9C385A1;
        Thu, 14 Apr 2022 20:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649969862;
        bh=1b2MQi6pZu61G74HfcojVbbQGo/EswADqWmRfYXIXns=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Cpk0xi9bQ7FgsOnICSYYOWirsVgI5u6BPopIIDq+x32GurXDmzVRJSqjyU735L2Yk
         sLx/I2JlW2Nv0mw2gfXAtSTFRB3W80FiqQ8jTZeaqtOGStPKJpBtR5bAoU1Y2X3x1Y
         NF3s0pUvX2MzDj2NFW0s1B1tYZpQuKyvYa+u+vWs=
Date:   Thu, 14 Apr 2022 13:57:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH v8 03/23] mm: Check against orig_pte for finish_fault()
Message-Id: <20220414135740.42fb26be9e13d2aada35f140@linux-foundation.org>
In-Reply-To: <YlhMDmko0IN82d21@xz-m1.local>
References: <20220405014646.13522-1-peterx@redhat.com>
        <20220405014836.14077-1-peterx@redhat.com>
        <CGME20220413140330eucas1p167da41e079712b829ef8237dc27b049c@eucas1p1.samsung.com>
        <710c48c9-406d-e4c5-a394-10501b951316@samsung.com>
        <Ylb9rXJyPm8/ao8f@xz-m1.local>
        <6ccf5f5f-8dc5-16cc-f06c-78401b822a54@samsung.com>
        <YlhMDmko0IN82d21@xz-m1.local>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2022 12:30:06 -0400 Peter Xu <peterx@redhat.com> wrote:

> > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > 
> > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Thanks, Marek, for the fast feedback!

Certainly.

> I've also verified it for the uffd-wp case so the whole series keeps
> running as usual and nothing else shows up after the new patch replaced.
> 
> Andrew, any suggestion on how we proceed with the replacement patch?
> E.g. do you want me to post it separately to the list?

I turned it into an incremental diff and queued it against [03/23]:

--- a/include/linux/mm_types.h~mm-check-against-orig_pte-for-finish_fault-fix
+++ a/include/linux/mm_types.h
@@ -814,6 +814,8 @@ typedef struct {
  * @FAULT_FLAG_UNSHARE: The fault is an unsharing request to unshare (and mark
  *                      exclusive) a possibly shared anonymous page that is
  *                      mapped R/O.
+ * @FAULT_FLAG_ORIG_PTE_VALID: whether the fault has vmf->orig_pte cached.
+ *                        We should only access orig_pte if this flag set.
  *
  * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
  * whether we would allow page faults to retry by specifying these two
@@ -850,6 +852,7 @@ enum fault_flag {
 	FAULT_FLAG_INSTRUCTION =	1 << 8,
 	FAULT_FLAG_INTERRUPTIBLE =	1 << 9,
 	FAULT_FLAG_UNSHARE =		1 << 10,
+	FAULT_FLAG_ORIG_PTE_VALID =	1 << 11,
 };
 
 #endif /* _LINUX_MM_TYPES_H */
--- a/mm/memory.c~mm-check-against-orig_pte-for-finish_fault-fix
+++ a/mm/memory.c
@@ -4194,6 +4194,15 @@ void do_set_pte(struct vm_fault *vmf, st
 	set_pte_at(vma->vm_mm, addr, vmf->pte, entry);
 }
 
+static bool vmf_pte_changed(struct vm_fault *vmf)
+{
+	if (vmf->flags & FAULT_FLAG_ORIG_PTE_VALID) {
+		return !pte_same(*vmf->pte, vmf->orig_pte);
+	}
+
+	return !pte_none(*vmf->pte);
+}
+
 /**
  * finish_fault - finish page fault once we have prepared the page to fault
  *
@@ -4252,7 +4261,7 @@ vm_fault_t finish_fault(struct vm_fault
 				      vmf->address, &vmf->ptl);
 	ret = 0;
 	/* Re-check under ptl */
-	if (likely(pte_same(*vmf->pte, vmf->orig_pte)))
+	if (likely(!vmf_pte_changed(vmf)))
 		do_set_pte(vmf, page, vmf->address);
 	else
 		ret = VM_FAULT_NOPAGE;
@@ -4720,13 +4729,7 @@ static vm_fault_t handle_pte_fault(struc
 		 * concurrent faults and from rmap lookups.
 		 */
 		vmf->pte = NULL;
-		/*
-		 * Always initialize orig_pte.  This matches with below
-		 * code to have orig_pte to be the none pte if pte==NULL.
-		 * This makes the rest code to be always safe to reference
-		 * it, e.g. in finish_fault() we'll detect pte changes.
-		 */
-		pte_clear(vmf->vma->vm_mm, vmf->address, &vmf->orig_pte);
+		vmf->flags &= ~FAULT_FLAG_ORIG_PTE_VALID;
 	} else {
 		/*
 		 * If a huge pmd materialized under us just retry later.  Use
@@ -4750,6 +4753,7 @@ static vm_fault_t handle_pte_fault(struc
 		 */
 		vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
 		vmf->orig_pte = *vmf->pte;
+		vmf->flags |= FAULT_FLAG_ORIG_PTE_VALID;
 
 		/*
 		 * some architectures can have larger ptes than wordsize,
_

