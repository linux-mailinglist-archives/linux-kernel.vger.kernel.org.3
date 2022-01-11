Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBF648A938
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 09:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348857AbiAKIRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 03:17:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54426 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348845AbiAKIRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 03:17:48 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B6M6fI006533;
        Tue, 11 Jan 2022 08:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=WW4nRJCrp2O0gmlqArh2zi0Ono1qZ4cRDB/3IMS2aU4=;
 b=F91MrIljTuD+yqE/J7rLSUXlYJwR7FjT3DJp4v2gHxrlIm5kVFBGDb4Zdx83RZmsuSRG
 SF8s2D5vGLnzgC1EbXeO9zlLNBw7zXOYmZdZD06OLGzUThZjesb8R8NAKBgeNV6zIvzL
 X0bnkO+COXh/g5U5oT5bI5Lhg2rSJQYaqRUoqImwhLu4i1wZOXRrjkeMhsuViWkro7yS
 D07OADMNqsa9UJQuGANUGBEwyzFt3QnsafhRDdqortHtAY6bOeVs7AdIFEpEeNk11Gg2
 TohqEsi+pNkSFx4JhTlU9pmT6ts/zKc6jTe0yYdHF6a2pSOl2LFTGwVu5XEm6+DA2TJM mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dh4jdan2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 08:16:39 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20B860hQ016146;
        Tue, 11 Jan 2022 08:16:38 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dh4jdan2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 08:16:38 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20B8CJPZ018038;
        Tue, 11 Jan 2022 08:16:37 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 3df28a9jb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 08:16:37 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20B8GaIp5767784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 08:16:36 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44FAFAE064;
        Tue, 11 Jan 2022 08:16:36 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF998AE066;
        Tue, 11 Jan 2022 08:16:27 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.112.216])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jan 2022 08:16:27 +0000 (GMT)
X-Mailer: emacs 28.0.90 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Yu Zhao <yuzhao@google.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
Subject: Re: [PATCH v6 4/9] mm: multigenerational lru: groundwork
In-Reply-To: <20220104202227.2903605-5-yuzhao@google.com>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-5-yuzhao@google.com>
Date:   Tue, 11 Jan 2022 13:46:24 +0530
Message-ID: <878rvm661z.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: viEjU2U4v_MgGJbxkWFac0_jQpUME9Y3
X-Proofpoint-ORIG-GUID: ycq6qDeljNjiG_kVdl1MGjZTm8vdgF-2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_03,2022-01-10_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 adultscore=0 clxscore=1011 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110044
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Zhao <yuzhao@google.com> writes:

.....

 +
> +/*
> + * Evictable pages are divided into multiple generations. The youngest and the
> + * oldest generation numbers, max_seq and min_seq, are monotonically increasing.
> + * They form a sliding window of a variable size [MIN_NR_GENS, MAX_NR_GENS]. An
> + * offset within MAX_NR_GENS, gen, indexes the lru list of the corresponding
> + * generation. The gen counter in folio->flags stores gen+1 while a page is on
> + * lrugen->lists[]. Otherwise, it stores 0.
> + *
> + * A page is added to the youngest generation on faulting. The aging needs to
> + * check the accessed bit at least twice before handing this page over to the
> + * eviction. The first check takes care of the accessed bit set on the initial
> + * fault; the second check makes sure this page hasn't been used since then.
> + * This process, AKA second chance, requires a minimum of two generations,
> + * hence MIN_NR_GENS. And to be compatible with the active/inactive lru, these
> + * two generations are mapped to the active; the rest of generations, if they
> + * exist, are mapped to the inactive. PG_active is always cleared while a page
> + * is on lrugen->lists[] so that demotion, which happens consequently when the
> + * aging creates a new generation, needs not to worry about it.
> + */

Where do we clear PG_active in the code? Is this the reason we endup
with

  void deactivate_page(struct page *page)
  {
 -	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
 +	if (PageLRU(page) && !PageUnevictable(page) && (PageActive(page) || lru_gen_enabled())) {




> +#define MIN_NR_GENS		2U
> +#define MAX_NR_GENS		((unsigned int)CONFIG_NR_LRU_GENS)
> +
> +struct lru_gen_struct {
> +	/* the aging increments the youngest generation number */
> +	unsigned long max_seq;
> +	/* the eviction increments the oldest generation numbers */
> +	unsigned long min_seq[ANON_AND_FILE];
> +	/* the birth time of each generation in jiffies */
> +	unsigned long timestamps[MAX_NR_GENS];
> +	/* the multigenerational lru lists */
> +	struct list_head lists[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
> +	/* the sizes of the above lists */
> +	unsigned long nr_pages[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
> +	/* whether the multigenerational lru is enabled */
> +	bool enabled;
> +};
> +

....

>  static void __meminit zone_init_internals(struct zone *zone, enum zone_type idx, int nid,
> diff --git a/mm/swap.c b/mm/swap.c
> index e8c9dc6d0377..d7dde3b7d4b5 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -462,6 +462,11 @@ void folio_add_lru(struct folio *folio)
>  	VM_BUG_ON_FOLIO(folio_test_active(folio) && folio_test_unevictable(folio), folio);
>  	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
>  
> +	/* see the comment in lru_gen_add_folio() */
> +	if (lru_gen_enabled() && !folio_test_unevictable(folio) &&
> +	    task_in_lru_fault() && !(current->flags & PF_MEMALLOC))
> +		folio_set_active(folio);
> +


Can you explain this better? What is the significance of marking the
folio active here. Do we need to differentiate parallel page faults (across
different vmas) w.r.t task_in_lru_fault()?


>  	folio_get(folio);
>  	local_lock(&lru_pvecs.lock);
>  	pvec = this_cpu_ptr(&lru_pvecs.lru_add);
> @@ -563,7 +568,7 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec)
>  
