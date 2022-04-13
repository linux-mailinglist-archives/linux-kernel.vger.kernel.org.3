Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1254750003F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 22:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbiDMUvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 16:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238798AbiDMUvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 16:51:21 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460AC7E5A3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:48:49 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23DKjlFT017607;
        Wed, 13 Apr 2022 20:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=/hVdmDonhk3wqZxwZm4erPQBfXsXFhd0ALrEzdPtdjk=;
 b=or6Q5s3D4tqEvBpkOeVhXruQLtpId7861XZvyg9WIqU9VoogVV2LFkYVn/3HZyA016V7
 9zVbFps5Aa8qUd7vWowi/g7QKGpb3dBi+f7UcBEtRLh3j82kwZluv2D0vuQo5Yyu7Pw5
 fzgxG5j1Ttmi1lcDGLzO+0g5KZCC/52aDtqL/T/5VCiGVaRyKyBDgRWkVTPlP8lOIBYX
 y3bUpcDNCXHFr2KnwQh6oDoQ5qX8EId2m0F3WGyv00y0Zs7t/84B/Hm28vPytMjt7K91
 Q9Feqc4UV5Fc4arG4xAVFeYBM0AKBxIjZ7qUMZYjdR43aXaA+DOmm0bQFHo0DiwLDare 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fe5k3g760-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Apr 2022 20:48:43 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23DKmhax025143;
        Wed, 13 Apr 2022 20:48:43 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fe5k3g759-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Apr 2022 20:48:43 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23DKk2I9017094;
        Wed, 13 Apr 2022 20:48:41 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 3fb1s8nyg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Apr 2022 20:48:41 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23DKmc1m37945698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 20:48:39 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFE764C050;
        Wed, 13 Apr 2022 20:48:38 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FEDC4C046;
        Wed, 13 Apr 2022 20:48:38 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.63.101])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 13 Apr 2022 20:48:38 +0000 (GMT)
Date:   Wed, 13 Apr 2022 23:48:36 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] mm, page_alloc: check pfn is valid before moving to
 freelist
Message-ID: <Ylc3JGy6DUq00ryv@linux.ibm.com>
References: <cover.1649794059.git.quic_sudaraja@quicinc.com>
 <fb3c8c008994b2ed96f74b6b9698ff998b689bd2.1649794059.git.quic_sudaraja@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb3c8c008994b2ed96f74b6b9698ff998b689bd2.1649794059.git.quic_sudaraja@quicinc.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VkpuEQSosTdNJKr7Pxsxxkf9ertTusye
X-Proofpoint-GUID: ftZzQ1Wmgm0yWSVWpTy3ejE6S1UGtxfH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-13_04,2022-04-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=3 priorityscore=1501
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=3
 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1011 spamscore=3
 mlxlogscore=157 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204130100
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 01:16:23PM -0700, Sudarshan Rajagopalan wrote:
> Check if pfn is valid before or not before moving it to freelist.
> 
> There are possible scenario where a pageblock can have partial physical
> hole and partial part of System RAM. This happens when base address in RAM
> partition table is not aligned to pageblock size.
> 
> Example:
> 
> Say we have this first two entries in RAM partition table -
> 
> Base Addr: 0x0000000080000000 Length: 0x0000000058000000
> Base Addr: 0x00000000E3930000 Length: 0x0000000020000000

I wonder what was done to memory DIMMs to get such an interesting
physical memory layout...

> ...
> 
> Physical hole: 0xD8000000 - 0xE3930000
> 
> On system having 4K as page size and hence pageblock size being 4MB, the
> base address 0xE3930000 is not aligned to 4MB pageblock size.
> 
> Now we will have pageblock which has partial physical hole and partial part
> of System RAM -
> 
> Pageblock [0xE3800000 - 0xE3C00000] -
> 	0xE3800000 - 0xE3930000 -- physical hole
> 	0xE3930000 - 0xE3C00000 -- System RAM
> 
> Now doing __alloc_pages say we get a valid page with PFN 0xE3B00 from
> __rmqueue_fallback, we try to put other pages from the same pageblock as well
> into freelist by calling steal_suitable_fallback().
> 
> We then search for freepages from start of the pageblock due to below code -
> 
>  move_freepages_block(zone, page, migratetype, ...)
> {
>     pfn = page_to_pfn(page);
>     start_pfn = pfn & ~(pageblock_nr_pages - 1);
>     end_pfn = start_pfn + pageblock_nr_pages - 1;
> ...
> }
> 
> With the pageblock which has partial physical hole at the beginning, we will
> run into PFNs from the physical hole whose struct page is not initialized and
> is invalid, and system would crash as we operate on invalid struct page to find
> out of page is in Buddy or LRU or not

struct page must be initialized and valid even for holes in the physical
memory. When a pageblock spans both existing memory and a hole, the struct
pages for the "hole" part should be marked as PG_Reserved. 
 
If you see that struct pages for memory holes exist but invalid, we should
solve the underlying issue that causes wrong struct pages contents.

> [  107.629453][ T9688] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [  107.639214][ T9688] Mem abort info:
> [  107.642829][ T9688]   ESR = 0x96000006
> [  107.646696][ T9688]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  107.652878][ T9688]   SET = 0, FnV = 0
> [  107.656751][ T9688]   EA = 0, S1PTW = 0
> [  107.660705][ T9688]   FSC = 0x06: level 2 translation fault
> [  107.666455][ T9688] Data abort info:
> [  107.670151][ T9688]   ISV = 0, ISS = 0x00000006
> [  107.674827][ T9688]   CM = 0, WnR = 0
> [  107.678615][ T9688] user pgtable: 4k pages, 39-bit VAs, pgdp=000000098a237000
> [  107.685970][ T9688] [0000000000000000] pgd=0800000987170003, p4d=0800000987170003, pud=0800000987170003, pmd=0000000000000000
> [  107.697582][ T9688] Internal error: Oops: 96000006 [#1] PREEMPT SMP
> 
> [  108.209839][ T9688] pc : move_freepages_block+0x174/0x27c

can you post fadd2line for this address?

> [  108.215407][ T9688] lr : steal_suitable_fallback+0x20c/0x398
> 
> [  108.305908][ T9688] Call trace:
> [  108.309151][ T9688]  move_freepages_block+0x174/0x27c        [PageLRU]
> [  108.314359][ T9688]  steal_suitable_fallback+0x20c/0x398
> [  108.319826][ T9688]  rmqueue_bulk+0x250/0x934
> [  108.324325][ T9688]  rmqueue_pcplist+0x178/0x2ac
> [  108.329086][ T9688]  rmqueue+0x5c/0xc10
> [  108.333048][ T9688]  get_page_from_freelist+0x19c/0x430
> [  108.338430][ T9688]  __alloc_pages+0x134/0x424
> [  108.343017][ T9688]  page_cache_ra_unbounded+0x120/0x324
> [  108.348494][ T9688]  do_sync_mmap_readahead+0x1b0/0x234
> [  108.353878][ T9688]  filemap_fault+0xe0/0x4c8
> [  108.358375][ T9688]  do_fault+0x168/0x6cc
> [  108.362518][ T9688]  handle_mm_fault+0x5c4/0x848
> [  108.367280][ T9688]  do_page_fault+0x3fc/0x5d0
> [  108.371867][ T9688]  do_translation_fault+0x6c/0x1b0
> [  108.376985][ T9688]  do_mem_abort+0x68/0x10c
> [  108.381389][ T9688]  el0_ia+0x50/0xbc
> [  108.385175][ T9688]  el0t_32_sync_handler+0x88/0xbc
> [  108.390208][ T9688]  el0t_32_sync+0x1b8/0x1bc
> 
> Hence, avoid operating on invalid pages within the same pageblock by checking
> if pfn is valid or not.

> Signed-off-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> Fixes: 4c7b9896621be ("mm: remove pfn_valid_within() and CONFIG_HOLES_IN_ZONE")
> Cc: Mike Rapoport <rppt@linux.ibm.com>

For now the patch looks like a band-aid for more fundamental bug, so

NAKED-by: Mike Rapoport <rppt@linux.ibm.com>


> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/page_alloc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6e5b448..e87aa053 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2521,6 +2521,11 @@ static int move_freepages(struct zone *zone,
>  	int pages_moved = 0;
>  
>  	for (pfn = start_pfn; pfn <= end_pfn;) {
> +		if (!pfn_valid(pfn)) {
> +			pfn++;
> +			continue;
> +		}
> +
>  		page = pfn_to_page(pfn);
>  		if (!PageBuddy(page)) {
>  			/*
> -- 
> 2.7.4
> 

-- 
Sincerely yours,
Mike.
