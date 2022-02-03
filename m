Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E099E4A8548
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 14:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350861AbiBCNby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 08:31:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61988 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350850AbiBCNbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:31:47 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 213D8FpV018387;
        Thu, 3 Feb 2022 13:31:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=c3ld7fOi19eRtKxr7jND8nYUdH+YTDHVwHNkgfJYX+w=;
 b=TY1igTumLEeTYOahgNYvH7P37emSWMP/OKkX2UEY41cLAqnGG55+YoSO4pWT0kvb0snl
 z+UQsicRN5MwwECJI/v8kGFVFtFfj8cALNubKsCe1fiM0HB1TH4QKQDO4XnTNmrs1h/q
 YfmAY3W0TIDJLdQfTqkQtHWG/QvMVay5J5u9DF6nHOVwp13izstCeJKv8qZUZm7CqQLK
 yLrNGyftvmnypn0qbtXD0Ihcy6pNtn5LP0mJorwxh6S0LLdWDzJ8vBTMZrt1uxEyG3d0
 Srmx6LaK5IzF5GBu/v8sg1QmTSGV1fC47SXx7ClpH4RKW13eyI5ghf900GtR2OTQqGk1 Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e02k272e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 13:31:36 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 213DOOfW003453;
        Thu, 3 Feb 2022 13:31:36 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e02k272d0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 13:31:35 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 213DD53G017456;
        Thu, 3 Feb 2022 13:31:32 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3dvw7a6ayb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 13:31:32 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 213DVURj44892576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Feb 2022 13:31:30 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27FF6A4060;
        Thu,  3 Feb 2022 13:31:30 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D365A405C;
        Thu,  3 Feb 2022 13:31:29 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.1.135])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Feb 2022 13:31:29 +0000 (GMT)
Date:   Thu, 3 Feb 2022 13:04:27 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        David Hildenbrand <david@redhat.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jan Kara <jack@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 4/4] mm/gup: remove get_user_pages_locked()
Message-ID: <20220203130427.3f2b1eb9@p-imbrenda>
In-Reply-To: <20220203093232.572380-5-jhubbard@nvidia.com>
References: <20220203093232.572380-1-jhubbard@nvidia.com>
        <20220203093232.572380-5-jhubbard@nvidia.com>
Organization: IBM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7CJakBG32dQ5y6f0ZIRQeO8kAuribknk
X-Proofpoint-ORIG-GUID: QpiMlTKxR45-jrwoQEut6ekc6WaIQ4N3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-03_04,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=992 spamscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2022 01:32:32 -0800
John Hubbard <jhubbard@nvidia.com> wrote:

> There is only one caller of get_user_pages_locked(). The purpose of
> get_user_pages_locked() is to allow for unlocking the mmap_lock when
> reading a page from the disk during a page fault (hidden behind
> VM_FAULT_RETRY). The idea is to reduce contention on the heavily-used
> mmap_lock. (Thanks to Jan Kara for clearly pointing that out, and in
> fact I've used some of his wording here.)
> 
> However, it is unlikely for lookup_node() to take a page fault. With
> that in mind, change over to calling get_user_pages_fast(). This
> simplifies the code, runs a little faster in the expected case, and
> allows removing get_user_pages_locked() entirely.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

I have always disliked these functions that might or might not unlock
the lock under the hood. I'm happy to see one more go.

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  include/linux/mm.h |  2 --
>  mm/gup.c           | 59 ----------------------------------------------
>  mm/mempolicy.c     | 21 +++++++----------
>  3 files changed, 9 insertions(+), 73 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 80c540c17d83..528ef1cb4f3a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1916,8 +1916,6 @@ long get_user_pages(unsigned long start, unsigned long nr_pages,
>  long pin_user_pages(unsigned long start, unsigned long nr_pages,
>  		    unsigned int gup_flags, struct page **pages,
>  		    struct vm_area_struct **vmas);
> -long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
> -		    unsigned int gup_flags, struct page **pages, int *locked);
>  long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>  		    struct page **pages, unsigned int gup_flags);
>  long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
> diff --git a/mm/gup.c b/mm/gup.c
> index b0ecbfe03928..7da49df59110 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2118,65 +2118,6 @@ long get_user_pages(unsigned long start, unsigned long nr_pages,
>  }
>  EXPORT_SYMBOL(get_user_pages);
>  
> -/**
> - * get_user_pages_locked() - variant of get_user_pages()
> - *
> - * @start:      starting user address
> - * @nr_pages:   number of pages from start to pin
> - * @gup_flags:  flags modifying lookup behaviour
> - * @pages:      array that receives pointers to the pages pinned.
> - *              Should be at least nr_pages long. Or NULL, if caller
> - *              only intends to ensure the pages are faulted in.
> - * @locked:     pointer to lock flag indicating whether lock is held and
> - *              subsequently whether VM_FAULT_RETRY functionality can be
> - *              utilised. Lock must initially be held.
> - *
> - * It is suitable to replace the form:
> - *
> - *      mmap_read_lock(mm);
> - *      do_something()
> - *      get_user_pages(mm, ..., pages, NULL);
> - *      mmap_read_unlock(mm);
> - *
> - *  to:
> - *
> - *      int locked = 1;
> - *      mmap_read_lock(mm);
> - *      do_something()
> - *      get_user_pages_locked(mm, ..., pages, &locked);
> - *      if (locked)
> - *          mmap_read_unlock(mm);
> - *
> - * We can leverage the VM_FAULT_RETRY functionality in the page fault
> - * paths better by using either get_user_pages_locked() or
> - * get_user_pages_unlocked().
> - *
> - */
> -long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
> -			   unsigned int gup_flags, struct page **pages,
> -			   int *locked)
> -{
> -	/*
> -	 * FIXME: Current FOLL_LONGTERM behavior is incompatible with
> -	 * FAULT_FLAG_ALLOW_RETRY because of the FS DAX check requirement on
> -	 * vmas.  As there are no users of this flag in this call we simply
> -	 * disallow this option for now.
> -	 */
> -	if (WARN_ON_ONCE(gup_flags & FOLL_LONGTERM))
> -		return -EINVAL;
> -	/*
> -	 * FOLL_PIN must only be set internally by the pin_user_pages*() APIs,
> -	 * never directly by the caller, so enforce that:
> -	 */
> -	if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
> -		return -EINVAL;
> -
> -	return __get_user_pages_locked(current->mm, start, nr_pages,
> -				       pages, NULL, locked,
> -				       gup_flags | FOLL_TOUCH);
> -}
> -EXPORT_SYMBOL(get_user_pages_locked);
> -
>  /*
>   * get_user_pages_unlocked() is suitable to replace the form:
>   *
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 028e8dd82b44..3f8dc58da3e8 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -907,17 +907,14 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
>  static int lookup_node(struct mm_struct *mm, unsigned long addr)
>  {
>  	struct page *p = NULL;
> -	int err;
> +	int ret;
>  
> -	int locked = 1;
> -	err = get_user_pages_locked(addr & PAGE_MASK, 1, 0, &p, &locked);
> -	if (err > 0) {
> -		err = page_to_nid(p);
> +	ret = get_user_pages_fast(addr & PAGE_MASK, 1, 0, &p);
> +	if (ret > 0) {
> +		ret = page_to_nid(p);
>  		put_page(p);
>  	}
> -	if (locked)
> -		mmap_read_unlock(mm);
> -	return err;
> +	return ret;
>  }
>  
>  /* Retrieve NUMA policy */
> @@ -968,14 +965,14 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
>  	if (flags & MPOL_F_NODE) {
>  		if (flags & MPOL_F_ADDR) {
>  			/*
> -			 * Take a refcount on the mpol, lookup_node()
> -			 * will drop the mmap_lock, so after calling
> -			 * lookup_node() only "pol" remains valid, "vma"
> -			 * is stale.
> +			 * Take a refcount on the mpol, because we are about to
> +			 * drop the mmap_lock, after which only "pol" remains
> +			 * valid, "vma" is stale.
>  			 */
>  			pol_refcount = pol;
>  			vma = NULL;
>  			mpol_get(pol);
> +			mmap_read_unlock(mm);
>  			err = lookup_node(mm, addr);
>  			if (err < 0)
>  				goto out;

