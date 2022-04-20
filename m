Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496D9509266
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382703AbiDTV4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbiDTV4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:56:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAB945513;
        Wed, 20 Apr 2022 14:53:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BB0EB821B0;
        Wed, 20 Apr 2022 21:53:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5B1C385A0;
        Wed, 20 Apr 2022 21:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1650491607;
        bh=s+1aSxlHOsrj2r/dbmg/La17ENCktIGI5EcH703yDBc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hu+OnO1lFWn0QE4re9JajSeGmR5kc3K1HYS0x0FiHx6jDoziq07AlVY5PEFh5BjgS
         Rm2DTG+CDczCpPcm554B8IQhnTa+tpdLZWulhnB8jlTzzk6CP8OfXszgO9DIB6xc+S
         uwnsNhQI+uwo2WH/xQPSe4cE5602DcO9CUVattq8=
Date:   Wed, 20 Apr 2022 14:53:25 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, max.krummenacher@toradex.com,
        Shawn Guo <shawnguo@kernel.org>,
        Stefano Stabellini <stefano.stabellini@xilinx.com>,
        Christoph Hellwig <hch@lst.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [next] arm: boot failed - PC is at cpu_ca15_set_pte_ext
Message-Id: <20220420145325.602b45256b98c14c9325c61d@linux-foundation.org>
In-Reply-To: <9eb0c1a4f805a75e3e9f24dfcae3077b772a06c0.camel@gmail.com>
References: <CA+G9fYuACgY2hcAgh_LwVb9AURjodMJbV6SsJb90wj-0aJKUOw@mail.gmail.com>
        <CAMj1kXFKzi14UCoiDOMwS5jyNz61_UzxGXm+ke0EWEt4nn6E1g@mail.gmail.com>
        <9eb0c1a4f805a75e3e9f24dfcae3077b772a06c0.camel@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 09:50:52 +0200 Max Krummenacher <max.oss.09@gmail.com> wrote:

> > 
> > Unfortunately, the vmlinux.xz file I downloaded from the link below
> > seems to be different from the one that produced the crash, given that
> > the LR address of c04cfeb8 does not seem to correspond with
> > handle_mm_fault+0x60c/0xed0.
> > 
> > Can you please double check the artifacts?
> 
> Commit "mm: check against orig_pte for finish_fault()" introduced this,
> i.e. on yesterdays next reverting a066bab3c0eb made a i.MX6 boot again.
> A fix is discussed here:
> 
> https://lore.kernel.org/all/YliNP7ADcdc4Puvs@xz-m1.local/
> 

Thanks for finding that.  I have Peter's fix queued and shall push out
a snapshot later today, for integration into linux-next.


From: Peter Xu <peterx@redhat.com>
Subject: mm-check-against-orig_pte-for-finish_fault-fix

fix crash reported by Marek

Link: https://lkml.kernel.org/r/Ylb9rXJyPm8/ao8f@xz-m1.local
Signed-off-by: Peter Xu <peterx@redhat.com>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Jerome Glisse <jglisse@redhat.com>
Cc: "Kirill A . Shutemov" <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---


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

