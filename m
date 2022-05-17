Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F27529C5A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243303AbiEQI1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243107AbiEQI0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:26:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9154764DD
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:25:57 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24H7srkY023840;
        Tue, 17 May 2022 08:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=4hvJGCyHi9FcYZjntgbNpf5+gxAW2jOi+esOcw3eQXI=;
 b=pNPq6iZfbrGANtHuoMU/XCtr7mQTTKdueA+SDjCZNOzY/xkJ1wVG+5x4EFElUDMegwhc
 ylga7szMJel6Mds8aYo6ZfameBaUSS8HfRYzhNZbGQyjn1ab20GpLJLp8pGx+IwJR7qJ
 DJmRJWwIL1jfwX6jF4sX702fjREqgg0uYk56Ak5Jxi1ujK78o0QfnvbQZS7yozXdsjTp
 0VDFKA72mCYaz6Oq/k3m2S6KlFIUpjbHaigie2hMzOi6TU18ftjrLivKndKBx03+3V7z
 nMVqrJdPVHL+8p/MrG5AccWe9DpHeGKWPeKN+LFJAGcbUfiu5l8liN6lEwRwRbK0iTjj yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g47r2gms8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 08:25:47 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24H8JABD003597;
        Tue, 17 May 2022 08:25:47 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g47r2gmrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 08:25:47 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24H8Mvu1016506;
        Tue, 17 May 2022 08:25:44 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3g2428u2kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 08:25:44 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24H8Brug53936392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 08:11:53 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B10511C04C;
        Tue, 17 May 2022 08:25:42 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3A4C11C04A;
        Tue, 17 May 2022 08:25:41 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.11.67])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 17 May 2022 08:25:41 +0000 (GMT)
Date:   Tue, 17 May 2022 11:25:40 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jaewon Kim <jaewon31.kim@samsung.com>, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [RFC PATCH] page_ext: create page extension for all memblock
 memory regions
Message-ID: <YoNcBG6kQnmLZ3Z9@linux.ibm.com>
References: <CGME20220509073953epcas1p127f2d36186316642068c92c5d9dee1c4@epcas1p1.samsung.com>
 <20220509074330.4822-1-jaewon31.kim@samsung.com>
 <20220516173321.67402b7f09eacc43d4e476f4@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516173321.67402b7f09eacc43d4e476f4@linux-foundation.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5_QH9FzBiEjqJRwbRqWeG2xo8WTt7hGK
X-Proofpoint-GUID: eKQy1iZpBdgPSTkYwnXXCvBwJDW-ZZjC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_01,2022-05-16_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205170048
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 05:33:21PM -0700, Andrew Morton wrote:
> On Mon,  9 May 2022 16:43:30 +0900 Jaewon Kim <jaewon31.kim@samsung.com> wrote:
> 
> > The page extension can be prepared for each section. But if the first
> > page is not valid, the page extension for the section was not
> > initialized though there were many other valid pages within the section.

What do you mean by "first page [in a section] is not valid"?
In recent kernels all struct pages in any section should be valid and
properly initialized.
 
> > To support the page extension for all sections, refer to memblock memory
> > regions. If the page is valid use the nid from pfn_to_nid, otherwise use
> > the previous nid.
> > 
> > Also this pagech changed log to include total sections and a section
> > size.
> > 
> > i.e.
> > allocated 100663296 bytes of page_ext for 64 sections (1 section : 0x8000000)
> 
> Cc Joonsoo, who wrote this code.
> Cc Mike, for memblock.
> 
> Thanks.
> 
> > 
> > diff --git a/mm/page_ext.c b/mm/page_ext.c
> > index 2e66d934d63f..506d58b36a1d 100644
> > --- a/mm/page_ext.c
> > +++ b/mm/page_ext.c
> > @@ -381,41 +381,43 @@ static int __meminit page_ext_callback(struct notifier_block *self,
> >  void __init page_ext_init(void)
> >  {
> >  	unsigned long pfn;
> > -	int nid;
> > +	int nid = 0;
> > +	struct memblock_region *rgn;
> > +	int nr_section = 0;
> > +	unsigned long next_section_pfn = 0;
> >  
> >  	if (!invoke_need_callbacks())
> >  		return;
> >  
> > -	for_each_node_state(nid, N_MEMORY) {
> > +	/*
> > +	 * iterate each memblock memory region and do not skip a section having
> > +	 * !pfn_valid(pfn)
> > +	 */
> > +	for_each_mem_region(rgn) {
> >  		unsigned long start_pfn, end_pfn;
> >  
> > -		start_pfn = node_start_pfn(nid);
> > -		end_pfn = node_end_pfn(nid);
> > -		/*
> > -		 * start_pfn and end_pfn may not be aligned to SECTION and the
> > -		 * page->flags of out of node pages are not initialized.  So we
> > -		 * scan [start_pfn, the biggest section's pfn < end_pfn) here.
> > -		 */
> > +		start_pfn = (unsigned long)(rgn->base >> PAGE_SHIFT);
> > +		end_pfn = start_pfn + (unsigned long)(rgn->size >> PAGE_SHIFT);
> > +
> > +		if (start_pfn < next_section_pfn)
> > +			start_pfn = next_section_pfn;
> > +
> >  		for (pfn = start_pfn; pfn < end_pfn;
> >  			pfn = ALIGN(pfn + 1, PAGES_PER_SECTION)) {
> >  
> > -			if (!pfn_valid(pfn))
> > -				continue;
> > -			/*
> > -			 * Nodes's pfns can be overlapping.
> > -			 * We know some arch can have a nodes layout such as
> > -			 * -------------pfn-------------->
> > -			 * N0 | N1 | N2 | N0 | N1 | N2|....
> > -			 */
> > -			if (pfn_to_nid(pfn) != nid)
> > -				continue;
> > +			if (pfn_valid(pfn))
> > +				nid = pfn_to_nid(pfn);
> > +			nr_section++;
> >  			if (init_section_page_ext(pfn, nid))
> >  				goto oom;
> >  			cond_resched();
> >  		}
> > +		next_section_pfn = pfn;
> >  	}
> > +
> >  	hotplug_memory_notifier(page_ext_callback, 0);
> > -	pr_info("allocated %ld bytes of page_ext\n", total_usage);
> > +	pr_info("allocated %ld bytes of page_ext for %d sections (1 section : 0x%x)\n",
> > +		total_usage, nr_section, (1 << SECTION_SIZE_BITS));
> >  	invoke_init_callbacks();
> >  	return;
> >  
> > -- 
> > 2.17.1
> > 

-- 
Sincerely yours,
Mike.
