Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12475ACE6A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 11:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbiIEI4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbiIEI4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:56:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A234C605
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:56:12 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2858J2uF010390;
        Mon, 5 Sep 2022 08:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=Hh2YO9yVS+kW0sHOZqKUc6hEYBGRxWLnulWEBjNRqR0=;
 b=StmTMXjmeofnLXUlVnrPEQsgtmUj2LzAVl/89riw6py7mHExE4pPvnjNnSPxCQU5PuY+
 XLWp1Q7CoGwJUuFwq+nCqi7oxsgQ+56OmrnY2GGjwgFR2sCoHaFGJkCtKcIsPXcA9+Mx
 99gjawSch76piReK7JHuFLcoKsBf3KO1AaF2zecAAWQe34X99KkZZMxMILq4LeQWsEZr
 lQEs+x+4TzwC3vn/A7xWMIbkaTxg75aeMY3W4Kp/QNOXlQfsoQ2R7efYbxh8jsYE4hfF
 Cf6EzXRQ1l2JggA7nji+dW8ycnoLtVMsOOECZmzCxJeOOytiT3XUF2DEUJxDaiEgpeRi sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jddgch2ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 08:56:07 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2858LD7H018464;
        Mon, 5 Sep 2022 08:56:07 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jddgch2bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 08:56:07 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2858pK6n014757;
        Mon, 5 Sep 2022 08:55:05 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01dal.us.ibm.com with ESMTP id 3jbxj9f0b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 08:55:05 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2858t5j424379660
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Sep 2022 08:55:05 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D9356A047;
        Mon,  5 Sep 2022 08:55:04 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A41A6A04D;
        Mon,  5 Sep 2022 08:55:00 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.107.234])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  5 Sep 2022 08:55:00 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>
Cc:     david@redhat.com, kirill.shutemov@linux.intel.com,
        jhubbard@nvidia.com, jgg@nvidia.com, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: gup: fix the fast GUP race against THP collapse
In-Reply-To: <CAHbLzkqGdnwY4P8jKQR0ojm6QV6b3dBi5pwrC1UJ4dqi3EqS4w@mail.gmail.com>
References: <20220901222707.477402-1-shy828301@gmail.com>
 <YxE/vuQlWJCJMuG2@xz-m1.local>
 <CAHbLzkqjZ_UhUbJ_f9Br7WCAgQvjrm5bMPRsKYvaFc2bzSuzrw@mail.gmail.com>
 <YxIofPiI8jvGzcjC@xz-m1.local>
 <CAHbLzkqGdnwY4P8jKQR0ojm6QV6b3dBi5pwrC1UJ4dqi3EqS4w@mail.gmail.com>
Date:   Mon, 05 Sep 2022 14:24:58 +0530
Message-ID: <87ilm2jj4t.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TYwweh_lIbIQnOHbjhgd7nL2N9pdarBo
X-Proofpoint-GUID: dqhajY8Ol1QP1NZA0GsNIMRToT7jeJtu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-05_05,2022-09-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0
 mlxlogscore=776 lowpriorityscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209050040
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Shi <shy828301@gmail.com> writes:

>
> On Fri, Sep 2, 2022 at 9:00 AM Peter Xu <peterx@redhat.com> wrote:
>>
>> On Thu, Sep 01, 2022 at 04:50:45PM -0700, Yang Shi wrote:
>> > On Thu, Sep 1, 2022 at 4:26 PM Peter Xu <peterx@redhat.com> wrote:
>> > >
>> > > Hi, Yang,
>> > >
>> > > On Thu, Sep 01, 2022 at 03:27:07PM -0700, Yang Shi wrote:
>> > > > Since general RCU GUP fast was introduced in commit 2667f50e8b81 ("mm:
>> > > > introduce a general RCU get_user_pages_fast()"), a TLB flush is no longer
>> > > > sufficient to handle concurrent GUP-fast in all cases, it only handles
>> > > > traditional IPI-based GUP-fast correctly.
>> > >
>> > > If TLB flush (or, IPI broadcasts) used to work to protect against gup-fast,
>> > > I'm kind of confused why it's not sufficient even if with RCU gup?  Isn't
>> > > that'll keep working as long as interrupt disabled (which current fast-gup
>> > > will still do)?
>> >
>> > Actually the wording was copied from David's commit log for his
>> > PageAnonExclusive fix. My understanding is the IPI broadcast still
>> > works, but it may not be supported by all architectures and not
>> > preferred anymore. So we should avoid depending on IPI broadcast IIUC.
>> >
>> > >
>> > > IIUC the issue is you suspect not all archs correctly implemented
>> > > pmdp_collapse_flush(), or am I wrong?
>> >
>> > This is a possible fix, please see below for details.
>> >
>> > >
>> > > > On architectures that send
>> > > > an IPI broadcast on TLB flush, it works as expected.  But on the
>> > > > architectures that do not use IPI to broadcast TLB flush, it may have
>> > > > the below race:
>> > > >
>> > > >    CPU A                                          CPU B
>> > > > THP collapse                                     fast GUP
>> > > >                                               gup_pmd_range() <-- see valid pmd
>> > > >                                                   gup_pte_range() <-- work on pte
>> > > > pmdp_collapse_flush() <-- clear pmd and flush
>> > > > __collapse_huge_page_isolate()
>> > > >     check page pinned <-- before GUP bump refcount
>> > > >                                                       pin the page
>> > > >                                                       check PTE <-- no change
>> > > > __collapse_huge_page_copy()
>> > > >     copy data to huge page
>> > > >     ptep_clear()
>> > > > install huge pmd for the huge page
>> > > >                                                       return the stale page
>> > > > discard the stale page
>> > > >
>> > > > The race could be fixed by checking whether PMD is changed or not after
>> > > > taking the page pin in fast GUP, just like what it does for PTE.  If the
>> > > > PMD is changed it means there may be parallel THP collapse, so GUP
>> > > > should back off.
>> > >
>> > > Could the race also be fixed by impl pmdp_collapse_flush() correctly for
>> > > the archs that are missing? Do you know which arch(s) is broken with it?
>> >
>> > Yes, and this was suggested by me in the first place, but per the
>> > suggestion from John and David, this is not the preferred way. I think
>> > it is because:
>> >
>> > Firstly, using IPI to serialize against fast GUP is not recommended
>> > anymore since fast GUP does check PTE then back off so we should avoid
>> > it.
>> > Secondly, if checking PMD then backing off could solve the problem,
>> > why do we still need broadcast IPI? It doesn't sound performant.
>> >
>> > >
>> > > It's just not clear to me whether this patch is an optimization or a fix,
>> > > if it's a fix whether the IPI broadcast in ppc pmdp_collapse_flush() would
>> > > still be needed.
>> >
>> > It is a fix and the fix will make IPI broadcast not useful anymore.
>>
>> How about another patch to remove the ppc impl too?  Then it can be a two
>> patches series.
>
> BTW, I don't think we could remove the ppc implementation since it is
> different from the generic pmdp_collapse_flush(), particularly for the
> hash part IIUC.
>
> The generic version calls flush_tlb_range() -> hash__flush_tlb_range()
> for hash, but the hash call is actually no-op. The ppc version calls
> hash__pmdp_collapse_flush() -> flush_tlb_pmd_range(), which does
> something useful.
>

We should actually rename flush_tlb_pmd_range(). It actually flush the
hash page table entries.

I will do the below patch for ppc64 to clarify this better

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
index 8b762f282190..fd30fa20c392 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
@@ -112,13 +112,12 @@ static inline void hash__flush_tlb_kernel_range(unsigned long start,
 
 struct mmu_gather;
 extern void hash__tlb_flush(struct mmu_gather *tlb);
-void flush_tlb_pmd_range(struct mm_struct *mm, pmd_t *pmd, unsigned long addr);
 
 #ifdef CONFIG_PPC_64S_HASH_MMU
 /* Private function for use by PCI IO mapping code */
 extern void __flush_hash_table_range(unsigned long start, unsigned long end);
-extern void flush_tlb_pmd_range(struct mm_struct *mm, pmd_t *pmd,
-				unsigned long addr);
+extern void flush_hash_table_pmd_range(struct mm_struct *mm, pmd_t *pmd,
+				       unsigned long addr);
 #else
 static inline void __flush_hash_table_range(unsigned long start, unsigned long end) { }
 #endif
diff --git a/arch/powerpc/mm/book3s64/hash_pgtable.c b/arch/powerpc/mm/book3s64/hash_pgtable.c
index ae008b9df0e6..f30131933a01 100644
--- a/arch/powerpc/mm/book3s64/hash_pgtable.c
+++ b/arch/powerpc/mm/book3s64/hash_pgtable.c
@@ -256,7 +256,7 @@ pmd_t hash__pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long addres
 	 * the __collapse_huge_page_copy can result in copying
 	 * the old content.
 	 */
-	flush_tlb_pmd_range(vma->vm_mm, &pmd, address);
+	flush_hash_table_pmd_range(vma->vm_mm, &pmd, address);
 	return pmd;
 }
 
diff --git a/arch/powerpc/mm/book3s64/hash_tlb.c b/arch/powerpc/mm/book3s64/hash_tlb.c
index eb0bccaf221e..a64ea0a7ef96 100644
--- a/arch/powerpc/mm/book3s64/hash_tlb.c
+++ b/arch/powerpc/mm/book3s64/hash_tlb.c
@@ -221,7 +221,7 @@ void __flush_hash_table_range(unsigned long start, unsigned long end)
 	local_irq_restore(flags);
 }
 
-void flush_tlb_pmd_range(struct mm_struct *mm, pmd_t *pmd, unsigned long addr)
+void flush_hash_table_pmd_range(struct mm_struct *mm, pmd_t *pmd, unsigned long addr)
 {
 	pte_t *pte;
 	pte_t *start_pte;

