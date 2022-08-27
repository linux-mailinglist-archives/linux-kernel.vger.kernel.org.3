Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973915A3809
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 16:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbiH0N7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 09:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiH0N7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 09:59:32 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF353AB09
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 06:59:31 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27RDVuN1015338;
        Sat, 27 Aug 2022 13:59:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=tai/MXn8ZPUgKhe/ysmYN0x9H4L+5NOCU52Yg9ft/3E=;
 b=ciwEDzJIXYHOHtTKv7b6UQnksbrewNFkGr0sg2IkkmtU29lgtFLS87lG/9DNQgcBPq6W
 FJa+NBbcJWeukEeFWa4henrl0NQmJR5Jnlphu4QZ6yrFAvi+bex+tkAcaV0SbjyZybaE
 gYftDBzHHn01u7ake9fJ2OujlH9Ealg9uOWCRn2A4NKZYEX+qMk4zZA/ffE5GXHtfd3J
 vUkJZgMn1YIwrYUUJxKJJe8H+Ap3CLuXjLbseNRjQN3Fkgt7e3tGm9SK/iUFBoAnixvt
 Zqp1aHLtVW6xGCZCQRHt12WmLDQxM+2cmfJofUWLolfczm5tyzY62PevZWGYTTCHyLkg /g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j7m82gb29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 27 Aug 2022 13:59:26 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27RDxQQV011950;
        Sat, 27 Aug 2022 13:59:26 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j7m82gb23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 27 Aug 2022 13:59:26 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27RDpc1D021976;
        Sat, 27 Aug 2022 13:59:25 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03wdc.us.ibm.com with ESMTP id 3j7aw8td88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 27 Aug 2022 13:59:25 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27RDxPav31981854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Aug 2022 13:59:25 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2715CAE05C;
        Sat, 27 Aug 2022 13:59:25 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5285AE060;
        Sat, 27 Aug 2022 13:59:21 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.57.126])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 27 Aug 2022 13:59:21 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] mm/hugetlb: fix races when looking up a CONT-PTE
 size hugetlb page
In-Reply-To: <Ywfl/HIeO/ZbwYCg@monkey>
References: <0e5d92da043d147a867f634b17acbcc97a7f0e64.1661240170.git.baolin.wang@linux.alibaba.com>
 <4c24b891-04ce-2608-79d2-a75dc236533f@redhat.com>
 <376d2e0a-d28a-984b-903c-1f6451b04a15@linux.alibaba.com>
 <7d4e7f47-30a5-3cc6-dc9f-aa89120847d8@redhat.com>
 <YwVo7xSO+VebkIfQ@monkey>
 <64669c0a-4a6e-f034-a15b-c4a8deea9e5d@linux.alibaba.com>
 <7ee73879-e402-9175-eae8-41471d80d59e@redhat.com>
 <f7544713-d856-0875-41dd-52a5c27ba015@linux.alibaba.com>
 <Ywa1jp/6naTmUh42@monkey>
 <887ca2e2-a7c5-93a7-46cb-185daccd4444@redhat.com>
 <Ywfl/HIeO/ZbwYCg@monkey>
Date:   Sat, 27 Aug 2022 19:29:18 +0530
Message-ID: <87wnatrdmx.fsf@linux.ibm.com>
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NJS-kW6jpW7-Foi9oUXJ4C1Nzo4P32A2
X-Proofpoint-ORIG-GUID: Ueo1RRQG1puYe1wN0h4BG_S1cOHxJaXW
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-27_08,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 clxscore=1011 mlxscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208270054
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz <mike.kravetz@oracle.com> writes:

>
> On 08/25/22 09:25, David Hildenbrand wrote:
>> > Is the primary concern the locking?  If so, I am not sure we have an issue.
>> > As mentioned in your commit message, current code will use
>> > pte_offset_map_lock().  pte_offset_map_lock uses pte_lockptr, and pte_lockptr
>> > will either be the mm wide lock or pmd_page lock.  To me, it seems that
>> > either would provide correct synchronization for CONT-PTE entries.  Am I
>> > missing something or misreading the code?
>> > 
>> > I started looking at code cleanup suggested by David.  Here is a quick
>> > patch (not tested and likely containing errors) to see if this is a step
>> > in the right direction.
>> > 
>> > I like it because we get rid of/combine all those follow_huge_p*d
>> > routines.
>> > 
>> 
>> Yes, see comments below.
>> 
>> > From 35d117a707c1567ddf350554298697d40eace0d7 Mon Sep 17 00:00:00 2001
>> > From: Mike Kravetz <mike.kravetz@oracle.com>
>> > Date: Wed, 24 Aug 2022 15:59:15 -0700
>> > Subject: [PATCH] hugetlb: call hugetlb_follow_page_mask for hugetlb pages in
>> >  follow_page_mask
>> > 
>> > At the beginning of follow_page_mask, there currently is a call to
>> > follow_huge_addr which 'may' handle hugetlb pages.  ia64 is the only
>> > architecture which (incorrectly) provides a follow_huge_addr routine
>> > that does not return error.  Instead, at each level of the page table a
>> > check is made for a hugetlb entry.  If a hugetlb entry is found, a call
>> > to a routine associated with that page table level such as
>> > follow_huge_pmd is made.
>> > 
>> > All the follow_huge_p*d routines are basically the same.  In addition
>> > huge page size can be derived from the vma, so we know where in the page
>> > table a huge page would reside.  So, replace follow_huge_addr with a
>> > new architecture independent routine which will provide the same
>> > functionality as the follow_huge_p*d routines.  We can then eliminate
>> > the p*d_huge checks in follow_page_mask page table walking as well as
>> > the follow_huge_p*d routines themselves.>
>> > follow_page_mask still has is_hugepd hugetlb checks during page table
>> > walking.  This is due to these checks and follow_huge_pd being
>> > architecture specific.  These can be eliminated if
>> > hugetlb_follow_page_mask can be overwritten by architectures (powerpc)
>> > that need to do follow_huge_pd processing.
>> 
>> But won't the
>> 
>> > +	/* hugetlb is special */
>> > +	if (is_vm_hugetlb_page(vma))
>> > +		return hugetlb_follow_page_mask(vma, address, flags);
>> 
>> code route everything via hugetlb_follow_page_mask() and all these
>> (beloved) hugepd checks would essentially be unreachable?
>> 
>> At least my understanding is that hugepd only applies to hugetlb.
>> 
>> Can't we move the hugepd handling code into hugetlb_follow_page_mask()
>> as well?
>> 
>> I mean, doesn't follow_hugetlb_page() also have to handle that hugepd
>> stuff already ... ?
>> 
>> [...]
>
> I think so, but I got a little confused looking at the hugepd handling code.
> Adding Aneesh who added support to follow_page_mask in the series at:
> https://lore.kernel.org/linux-mm/1494926612-23928-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com/
>
> I believe you are correct in that follow_hugetlb_page must handle as well.
>
> One source of my confusion is the following in follow_huge_pd:
>
> 	/*
> 	 * hugepage directory entries are protected by mm->page_table_lock
> 	 * Use this instead of huge_pte_lockptr
> 	 */
> 	ptl = &mm->page_table_lock;
> 	spin_lock(ptl);
>
> Yet, if follow_hugetlb_page handles hugepd then it is using huge_pte_lockptr
> to get the lock pointer and is wrong?
>
> Hoping Aneesh can help clear up the confusion.


I agree it is all confusing. At some point, the goal was to teach
generic kernel page table walking code about hugepd entries. But looking
at this again and considering we only have hugepd entries for hugetlb,
may be the effort is not worth the complexity it adds.

ie,  instead of teaching generic page table walk about different hugetlb
page table layouts we special case using is_vm_hugetlb_page(vma)
wherever we can.

With respect to huge_pte_lockptr, it is tricky (hugepd entries are not
PMD_SIZE) 

static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
					   struct mm_struct *mm, pte_t *pte)
{
	if (huge_page_size(h) == PMD_SIZE)
		return pmd_lockptr(mm, (pmd_t *) pte);
	VM_BUG_ON(huge_page_size(h) == PAGE_SIZE);
	return &mm->page_table_lock;
}

>
> BTW, I also noticed that the above series added the comment:
> 	/* make this handle hugepd */
> above the call to follow_huge_addr() in follow_page_mask.  Perhaps there
> was at one time a plan to have follow_huge_addr handle hugepd?  That
> series removed powerpc specific follow_huge_addr routine.
>
> -- 
> Mike Kravetz
