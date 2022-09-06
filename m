Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAED5AED1E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241087AbiIFOST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241448AbiIFOQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:16:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B43AB62
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 06:49:21 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Dbk75024128;
        Tue, 6 Sep 2022 13:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+LONfiP1FwuoZ7sqp1pViTF6ooPK4HKK4YlqTWf6pqg=;
 b=sNOqYYDADMI3R5nSXwQGUJtWPPP6SQoyLYvFB1XRzpnlY2WMioY05Nif/WaLXJPxTPrQ
 TPabg+kBf6HFmKgvMcv9MidZLyV4GXolWLXkxp1xy0mcqg5uxXr9ZH5YYlxD47XQ4RhW
 Dtfa16C/oR6idlnN0NgS4GHJjnSZgoWwNdKRI3ovpvUGFUj0EtbxInfFEECFgQ3TkHLU
 q2fkMtj0oSlO2y1aZ6eLVmLB+fPWzJxUs6W6P/HVrvuI3RFuGH75ePNMZQKBNalWrpgV
 zxp6DThGJ12S3QN+/s3hiYDyKaIH7h17GojUZ8S3cx3xZFzdBd/tN6vODXrdfkJqW4df qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3je78j8esy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 13:47:04 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 286DcGaO025665;
        Tue, 6 Sep 2022 13:47:03 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3je78j8eqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 13:47:03 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 286DaQIi009009;
        Tue, 6 Sep 2022 13:47:00 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3jbxj8uukd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 13:47:00 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 286Dkv4734996560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Sep 2022 13:46:57 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDA01A405C;
        Tue,  6 Sep 2022 13:46:57 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9AE7A4054;
        Tue,  6 Sep 2022 13:46:56 +0000 (GMT)
Received: from [9.101.4.33] (unknown [9.101.4.33])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  6 Sep 2022 13:46:56 +0000 (GMT)
Message-ID: <c84136d3-703a-0e57-20ce-59f6b5823999@linux.ibm.com>
Date:   Tue, 6 Sep 2022 15:46:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.0
Subject: Re: [RFC PATCH RESEND 05/28] mm: add per-VMA lock and helper
 functions to control it
Content-Language: fr
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        rientjes@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220901173516.702122-1-surenb@google.com>
 <20220901173516.702122-6-surenb@google.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <20220901173516.702122-6-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UrSfiMSxrDaJu89C83q1fw95SxfJl1td
X-Proofpoint-ORIG-GUID: 41BMFJp_5MK8rlp_otVy0PPuDlQMVUZL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_07,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=704 malwarescore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 spamscore=0 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060065
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 01/09/2022 à 19:34, Suren Baghdasaryan a écrit :
> Introduce a per-VMA rw_semaphore to be used during page fault handling
> instead of mmap_lock. Because there are cases when multiple VMAs need
> to be exclusively locked during VMA tree modifications, instead of the
> usual lock/unlock patter we mark a VMA as locked by taking per-VMA lock
> exclusively and setting vma->lock_seq to the current mm->lock_seq. When
> mmap_write_lock holder is done with all modifications and drops mmap_lock,
> it will increment mm->lock_seq, effectively unlocking all VMAs marked as
> locked.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Despite a minor comment below,

Reviewed-by: Laurent Dufour <laurent.dufour@fr.ibm.com>

> ---
>  include/linux/mm.h        | 78 +++++++++++++++++++++++++++++++++++++++
>  include/linux/mm_types.h  |  7 ++++
>  include/linux/mmap_lock.h | 13 +++++++
>  kernel/fork.c             |  4 ++
>  mm/init-mm.c              |  3 ++
>  5 files changed, 105 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7d322a979455..476bf936c5f0 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -611,6 +611,83 @@ struct vm_operations_struct {
>  					  unsigned long addr);
>  };
>  
> +#ifdef CONFIG_PER_VMA_LOCK
> +static inline void vma_init_lock(struct vm_area_struct *vma)
> +{
> +	init_rwsem(&vma->lock);
> +	vma->vm_lock_seq = -1;
> +}
> +
> +static inline void vma_mark_locked(struct vm_area_struct *vma)
> +{
> +	int mm_lock_seq;
> +
> +	mmap_assert_write_locked(vma->vm_mm);
> +
> +	/*
> +	 * current task is holding mmap_write_lock, both vma->vm_lock_seq and
> +	 * mm->mm_lock_seq can't be concurrently modified.
> +	 */
> +	mm_lock_seq = READ_ONCE(vma->vm_mm->mm_lock_seq);
> +	if (vma->vm_lock_seq == mm_lock_seq)
> +		return;
> +
> +	down_write(&vma->lock);
> +	vma->vm_lock_seq = mm_lock_seq;
> +	up_write(&vma->lock);
> +}
> +
> +static inline bool vma_read_trylock(struct vm_area_struct *vma)
> +{
> +	if (unlikely(down_read_trylock(&vma->lock) == 0))
> +		return false;
> +
> +	/*
> +	 * Overflow might produce false locked result but it's not critical.

It might be good to precise here that in the case of false locked, the
caller is assumed to fallback read locking the mm entirely before doing its
change relative to that VMA.

> +	 * False unlocked result is critical but is impossible because we
> +	 * modify and check vma->vm_lock_seq under vma->lock protection and
> +	 * mm->mm_lock_seq modification invalidates all existing locks.
> +	 */
> +	if (vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq)) {
> +		up_read(&vma->lock);
> +		return false;
> +	}
> +	return true;
> +}
> +
> +static inline void vma_read_unlock(struct vm_area_struct *vma)
> +{
> +	up_read(&vma->lock);
> +}
> +
> +static inline void vma_assert_locked(struct vm_area_struct *vma)
> +{
> +	lockdep_assert_held(&vma->lock);
> +	VM_BUG_ON_VMA(!rwsem_is_locked(&vma->lock), vma);
> +}
> +
> +static inline void vma_assert_write_locked(struct vm_area_struct *vma, int pos)
> +{
> +	mmap_assert_write_locked(vma->vm_mm);
> +	/*
> +	 * current task is holding mmap_write_lock, both vma->vm_lock_seq and
> +	 * mm->mm_lock_seq can't be concurrently modified.
> +	 */
> +	VM_BUG_ON_VMA(vma->vm_lock_seq != READ_ONCE(vma->vm_mm->mm_lock_seq), vma);
> +}
> +
> +#else /* CONFIG_PER_VMA_LOCK */
> +
> +static inline void vma_init_lock(struct vm_area_struct *vma) {}
> +static inline void vma_mark_locked(struct vm_area_struct *vma) {}
> +static inline bool vma_read_trylock(struct vm_area_struct *vma)
> +		{ return false; }
> +static inline void vma_read_unlock(struct vm_area_struct *vma) {}
> +static inline void vma_assert_locked(struct vm_area_struct *vma) {}
> +static inline void vma_assert_write_locked(struct vm_area_struct *vma, int pos) {}
> +
> +#endif /* CONFIG_PER_VMA_LOCK */
> +
>  static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
>  {
>  	static const struct vm_operations_struct dummy_vm_ops = {};
> @@ -619,6 +696,7 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
>  	vma->vm_mm = mm;
>  	vma->vm_ops = &dummy_vm_ops;
>  	INIT_LIST_HEAD(&vma->anon_vma_chain);
> +	vma_init_lock(vma);
>  }
>  
>  static inline void vma_set_anonymous(struct vm_area_struct *vma)
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index bed25ef7c994..6a03f59c1e78 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -486,6 +486,10 @@ struct vm_area_struct {
>  	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
>  #endif
>  	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
> +#ifdef CONFIG_PER_VMA_LOCK
> +	struct rw_semaphore lock;
> +	int vm_lock_seq;
> +#endif
>  } __randomize_layout;
>  
>  struct kioctx_table;
> @@ -567,6 +571,9 @@ struct mm_struct {
>  					  * init_mm.mmlist, and are protected
>  					  * by mmlist_lock
>  					  */
> +#ifdef CONFIG_PER_VMA_LOCK
> +		int mm_lock_seq;
> +#endif
>  
>  
>  		unsigned long hiwater_rss; /* High-watermark of RSS usage */
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index e49ba91bb1f0..a391ae226564 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -72,6 +72,17 @@ static inline void mmap_assert_write_locked(struct mm_struct *mm)
>  	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
>  }
>  
> +#ifdef CONFIG_PER_VMA_LOCK
> +static inline void vma_mark_unlocked_all(struct mm_struct *mm)
> +{
> +	mmap_assert_write_locked(mm);
> +	/* No races during update due to exclusive mmap_lock being held */
> +	WRITE_ONCE(mm->mm_lock_seq, mm->mm_lock_seq + 1);
> +}
> +#else
> +static inline void vma_mark_unlocked_all(struct mm_struct *mm) {}
> +#endif
> +
>  static inline void mmap_init_lock(struct mm_struct *mm)
>  {
>  	init_rwsem(&mm->mmap_lock);
> @@ -114,12 +125,14 @@ static inline bool mmap_write_trylock(struct mm_struct *mm)
>  static inline void mmap_write_unlock(struct mm_struct *mm)
>  {
>  	__mmap_lock_trace_released(mm, true);
> +	vma_mark_unlocked_all(mm);
>  	up_write(&mm->mmap_lock);
>  }
>  
>  static inline void mmap_write_downgrade(struct mm_struct *mm)
>  {
>  	__mmap_lock_trace_acquire_returned(mm, false, true);
> +	vma_mark_unlocked_all(mm);
>  	downgrade_write(&mm->mmap_lock);
>  }
>  
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 614872438393..bfab31ecd11e 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -475,6 +475,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
>  		 */
>  		*new = data_race(*orig);
>  		INIT_LIST_HEAD(&new->anon_vma_chain);
> +		vma_init_lock(new);
>  		new->vm_next = new->vm_prev = NULL;
>  		dup_anon_vma_name(orig, new);
>  	}
> @@ -1130,6 +1131,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  	seqcount_init(&mm->write_protect_seq);
>  	mmap_init_lock(mm);
>  	INIT_LIST_HEAD(&mm->mmlist);
> +#ifdef CONFIG_PER_VMA_LOCK
> +	WRITE_ONCE(mm->mm_lock_seq, 0);
> +#endif
>  	mm_pgtables_bytes_init(mm);
>  	mm->map_count = 0;
>  	mm->locked_vm = 0;
> diff --git a/mm/init-mm.c b/mm/init-mm.c
> index fbe7844d0912..8399f90d631c 100644
> --- a/mm/init-mm.c
> +++ b/mm/init-mm.c
> @@ -37,6 +37,9 @@ struct mm_struct init_mm = {
>  	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
>  	.arg_lock	=  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
>  	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
> +#ifdef CONFIG_PER_VMA_LOCK
> +	.mm_lock_seq	= 0,
> +#endif
>  	.user_ns	= &init_user_ns,
>  	.cpu_bitmap	= CPU_BITS_NONE,
>  #ifdef CONFIG_IOMMU_SVA

