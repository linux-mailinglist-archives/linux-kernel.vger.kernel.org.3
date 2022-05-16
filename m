Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A5A528B9F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 19:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245320AbiEPRKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 13:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbiEPRKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 13:10:45 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AC8B15
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 10:10:43 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GH3HKn008227;
        Mon, 16 May 2022 17:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=EQDSiWVsrHfFNpz7/GlZT6cfiq4XqE+Mc1oEGcE0XYo=;
 b=g5LmQuc1P43Hmgeh1+3Luuh9XYDCxfQvBj/heqmowiPpSANwt75PMmhv8EVsRn/B0y/Z
 sqNP6ZD+aKVfrapLCQEIibGEFgpOR0YxfmtWaVk1znoHceZFRhaw2lAujJ9z/ijDiEK2
 ren6PMNmahXQoP/EFdyNyW3aqwGhrXxaFWQh/fk9RIbXylkJmjRUtc9xHCMtHGsyvupZ
 USpKXfDbZL96z++5JoSK+WIaJbOYR0rrn1yTD8kceD4kZyLdGvVC/kbC0jhlJQhV87cW
 VISrpNXn+YI0i6dCXwXkyA42tFJfQc+T+SwJo3yyo3c2/5hJPCbNb12smun2PfI8gLQr Ow== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g3tp4r3ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 17:10:27 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24GH2C2t013234;
        Mon, 16 May 2022 17:10:25 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3g2429b1c9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 17:10:25 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24GHAN2B30671230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 17:10:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DCCB42041;
        Mon, 16 May 2022 17:10:23 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 280724203F;
        Mon, 16 May 2022 17:10:23 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 16 May 2022 17:10:23 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mapletree-vs-khugepaged
References: <20220428172040.GA3623323@roeck-us.net> <YmvVkKXJWBoGqWFx@osiris>
        <yt9dk0apbicu.fsf@linux.ibm.com>
        <20220513165955.mkg5wvfi4dwpzoer@revolver>
        <yt9dbkvy5zu0.fsf@linux.ibm.com>
        <20220516140202.pcw2f6gu4kyslmjd@revolver>
        <yt9d1qwt5w06.fsf@linux.ibm.com>
        <20220516155042.axgwex2enlf54n5m@revolver>
Date:   Mon, 16 May 2022 19:10:22 +0200
In-Reply-To: <20220516155042.axgwex2enlf54n5m@revolver> (Liam Howlett's
        message of "Mon, 16 May 2022 15:50:48 +0000")
Message-ID: <yt9dwnel4d4x.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WTheaXz1skIBlTqODTepZre2Rqhxr28L
X-Proofpoint-GUID: WTheaXz1skIBlTqODTepZre2Rqhxr28L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-16_15,2022-05-16_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205160094
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Liam Howlett <liam.howlett@oracle.com> writes:

> * Sven Schnelle <svens@linux.ibm.com> [220516 11:37]:
>> Hi Liam,
>> 
>> Liam Howlett <liam.howlett@oracle.com> writes:
>> 
>> > * Sven Schnelle <svens@linux.ibm.com> [220515 16:02]:
>> >
>> > I tried the above on my qemu s390 with kernel 5.18.0-rc6-next-20220513,
>> > but it runs without issue, return code is 0.  Is there something the VM
>> > needs to have for this to trigger?
>> 
>> A coworker said the same. Reason for this seems to be that i've run the
>> code in a unittest environment which seems to make a difference. When
>> compiling the code above with gcc on my system it also doesn't crash.
>> So i have to figure out what makes this unittest binary special.
>> 
>> >> I've added a few debug statements to the maple tree code:
>> >> 
>> >> [   27.769641] mas_next_entry: offset=14
>> >> [   27.769642] mas_next_nentry: entry = 0e00000000000000, slots=0000000090249f80, mas->offset=15 count=14
>> >
>> > Where exactly are you printing this?
>> 
>> I added a lot of debug statements to the code trying to understand
>> it. I'll attach it to this mail.
>
> Thanks.  Can you check to see if that diff you sent was the correct
> file?  It appears to be the git stats and not the changes themselves.

No, it wasn't. I did git stash show with -p, which doesn't make sense.
I've attached the correct diff.

>> > If this is the case, then I think any task that has more than 14 VMAs
>> > would have issues.  I also use mas_next_entry() in mas_find() which is
>> > used for the mas_for_each() macro/iterator.  Can you please enable
>> > CONFIG_DEBUG_VM_MAPLE_TREE ?  mmap.c tests the tree after pretty much
>> > any change and will dump useful information if there is an issue -
>> > including the entire tree. See validate_mm_mt() for details.
>> >
>> > You can find CONFIG_DEBUG_VM_MAPLE_TREE in the config:
>> > kernel hacking -> Memory debugging -> Debug VM -> Debug VM maple trees
>> 
>> I have both DEBUG_MAPPLE_TREE and DEBUG_VM_MAPLE_TREE enabled, but don't
>> see anything printed.
>
> I suspect that this means the issue is actually in the mmap code and not
> the tree.  It may be sensitive to the task-specific layout.  Do you have
> randomization on as well?  I'm thinking maybe I return NULL because I'm
> asking for the next element after the last VMA and not checking that
> correctly or similar.


> Does ./scripts/faddr2line work for you?  What does it say about
> mmap_region+0x19e/0x848 ?

2629        next = mas_next(&mas, ULONG_MAX);
2630        prev = mas_prev(&mas, 0);
2631        if (vm_flags & VM_SPECIAL)
2632               goto cannot_expand;
2633
2634        /* Attempt to expand an old mapping */
2635        /* Check next */
2636        if (next && next->vm_start == end && !vma_policy(next) &&

next above is 0x0e00000000000000 and next->vm_start will trigger the crash.

2637            can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
2638                              NULL_VM_UFFD_CTX, NULL)) {
2639               merge_end = next->vm_end;
2640               vma = next;
2641               vm_pgoff = next->vm_pgoff - pglen;
2642        }

--=-=-=
Content-Type: text/x-diff
Content-Disposition: attachment; filename=mapple-debug.diff

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 967631055210..a621d17e872d 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -140,6 +140,7 @@ struct maple_subtree_state {
 	struct maple_big_node *bn;
 };
 
+extern int mas_debug;
 /* Functions */
 static inline struct maple_node *mt_alloc_one(gfp_t gfp)
 {
@@ -4550,6 +4551,9 @@ static inline void *mas_next_nentry(struct ma_state *mas,
 	while (mas->offset < count) {
 		pivot = pivots[mas->offset];
 		entry = mas_slot(mas, slots, mas->offset);
+		if (mas_debug)
+			pr_err("%s: entry = %px, slots=%px, mas->offset=%d\n",
+			       __func__, entry, slots, mas->offset);
 		if (ma_dead_node(node))
 			return NULL;
 
@@ -4570,6 +4574,10 @@ static inline void *mas_next_nentry(struct ma_state *mas,
 
 	pivot = mas_safe_pivot(mas, pivots, mas->offset, type);
 	entry = mas_slot(mas, slots, mas->offset);
+	if (mas_debug)
+		pr_err("%s: entry = %px, slots=%px, mas->offset=%d count=%d\n",
+		       __func__, entry, slots, mas->offset, count);
+
 	if (ma_dead_node(node))
 		return NULL;
 
@@ -4580,6 +4588,8 @@ static inline void *mas_next_nentry(struct ma_state *mas,
 		return NULL;
 
 found:
+	if (mas_debug)
+		pr_err("found pivot = %lx, entry = %px\n", pivot, entry);
 	mas->last = pivot;
 	return entry;
 }
@@ -4618,6 +4628,9 @@ static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
 	unsigned long last;
 	enum maple_type mt;
 
+	if (mas_debug)
+		pr_err("%s: entry\n", __func__);
+
 	last = mas->last;
 retry:
 	offset = mas->offset;
@@ -4625,10 +4638,17 @@ static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
 	node = mas_mn(mas);
 	mt = mte_node_type(mas->node);
 	mas->offset++;
-	if (unlikely(mas->offset >= mt_slots[mt]))
+	if (mas_debug)
+		pr_err("%s: offset=%d\n", __func__, offset);
+	if (unlikely(mas->offset >= mt_slots[mt])) {
+		if (mas_debug)
+			pr_err("%s: next node\n", __func__);
 		goto next_node;
+	}
 
 	while (!mas_is_none(mas)) {
+		if (mas_debug)
+			pr_err("%s: !none\n", __func__);
 		entry = mas_next_nentry(mas, node, limit, mt);
 		if (unlikely(ma_dead_node(node))) {
 			mas_rewalk(mas, last);
@@ -4656,6 +4676,8 @@ static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
 	mas->index = mas->last = limit;
 	mas->offset = offset;
 	mas->node = prev_node;
+	if (mas_debug)
+		pr_err("%s: return NULL, mas->node = %px\n", __func__, prev_node);
 	return NULL;
 }
 
@@ -4914,6 +4936,8 @@ static inline bool mas_anode_descend(struct ma_state *mas, unsigned long size)
 void *mas_walk(struct ma_state *mas)
 {
 	void *entry;
+	if (mas_debug)
+		pr_err("%s\n", __func__);
 
 retry:
 	entry = mas_state_walk(mas);
@@ -5838,7 +5862,12 @@ EXPORT_SYMBOL_GPL(mas_pause);
  */
 void *mas_find(struct ma_state *mas, unsigned long max)
 {
+	if (mas_debug)
+		pr_err("%s: max=%lx\n", __func__, max);
+
 	if (unlikely(mas_is_paused(mas))) {
+		if (mas_debug)
+			pr_err("%s: paused\n", __func__);
 		if (unlikely(mas->last == ULONG_MAX)) {
 			mas->node = MAS_NONE;
 			return NULL;
@@ -5848,6 +5877,8 @@ void *mas_find(struct ma_state *mas, unsigned long max)
 	}
 
 	if (unlikely(mas_is_start(mas))) {
+		if (mas_debug)
+			pr_err("%s: start\n", __func__);
 		/* First run or continue */
 		void *entry;
 
@@ -5859,8 +5890,10 @@ void *mas_find(struct ma_state *mas, unsigned long max)
 			return entry;
 	}
 
-	if (unlikely(!mas_searchable(mas)))
+	if (unlikely(!mas_searchable(mas))) {
+		pr_err("%s: not searchable\n", __func__);
 		return NULL;
+	}
 
 	/* Retries on dead nodes handled by mas_next_entry */
 	return mas_next_entry(mas, max);
diff --git a/mm/mmap.c b/mm/mmap.c
index 2049500931ae..16ee834c0a4c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -57,6 +57,7 @@
 
 #include "internal.h"
 
+int mas_debug;
 #ifndef arch_mmap_check
 #define arch_mmap_check(addr, len, flags)	(0)
 #endif
@@ -2375,6 +2376,10 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 	int count = 0;
 	int error = -ENOMEM;
 	MA_STATE(mas_detach, &mt_detach, start, end - 1);
+
+	if (mas_debug)
+		pr_err("%s:%d\n", __func__, __LINE__);
+
 	mt_init_flags(&mt_detach, MM_MT_FLAGS);
 	mt_set_external_lock(&mt_detach, &mm->mmap_lock);
 
@@ -2541,28 +2546,37 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
  *
  * Returns: -EINVAL on failure, 1 on success and unlock, 0 otherwise.
  */
+
+
+
 int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
 		  unsigned long start, size_t len, struct list_head *uf,
 		  bool downgrade)
 {
 	unsigned long end;
 	struct vm_area_struct *vma;
+	if (mas_debug)
+		pr_err("%s: %lx %lx\n", __func__, start, len);
 
 	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start)
 		return -EINVAL;
-
+	if (mas_debug)
+		pr_err("%s:%d\n", __func__, __LINE__);
 	end = start + PAGE_ALIGN(len);
 	if (end == start)
 		return -EINVAL;
-
+	if (mas_debug)
+		pr_err("%s:%d\n", __func__, __LINE__);
 	 /* arch_unmap() might do unmaps itself.  */
 	arch_unmap(mm, start, end);
-
+	if (mas_debug)
+		pr_err("%s:%d\n", __func__, __LINE__);
 	/* Find the first overlapping VMA */
 	vma = mas_find(mas, end - 1);
 	if (!vma)
 		return 0;
-
+	if (mas_debug)
+		pr_err("vma=%px\n", vma);
 	return do_mas_align_munmap(mas, vma, mm, start, end, uf, downgrade);
 }
 
@@ -2594,6 +2608,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	pgoff_t vm_pgoff;
 	int error;
 	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
+	mas_debug = (addr == (1UL << 54));
 
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
@@ -2609,23 +2624,30 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 					(len >> PAGE_SHIFT) - nr_pages))
 			return -ENOMEM;
 	}
-
 	/* Unmap any existing mapping in the area */
-	if (do_mas_munmap(&mas, mm, addr, len, uf, false))
+
+	if (do_mas_munmap(&mas, mm, addr, len, uf, false)) {
+		mas_debug = 0;
 		return -ENOMEM;
+	}
 
 	/*
 	 * Private writable mapping: check memory availability
 	 */
 	if (accountable_mapping(file, vm_flags)) {
 		charged = len >> PAGE_SHIFT;
-		if (security_vm_enough_memory_mm(mm, charged))
+		if (security_vm_enough_memory_mm(mm, charged)) {
+			mas_debug = 0;
 			return -ENOMEM;
+		}
 		vm_flags |= VM_ACCOUNT;
 	}
 
 	next = mas_next(&mas, ULONG_MAX);
 	prev = mas_prev(&mas, 0);
+	if (mas_debug)
+		pr_err("%s: next %px\n", __func__, next);
+	mas_debug = 0;
 	if (vm_flags & VM_SPECIAL)
 		goto cannot_expand;
 

--=-=-=--

