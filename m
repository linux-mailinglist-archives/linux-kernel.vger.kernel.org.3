Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C158552A247
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347269AbiEQM6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346616AbiEQMz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:55:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA22E63BC
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:55:57 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HCLlZq010020;
        Tue, 17 May 2022 12:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=YrPfjDANUD45n3Zdgz895KDNs9u9b5h3UTyNbQxL5mM=;
 b=tgvayBDGBtaPau1L7BNC79xzgzDdA8xjXFw77XfaI0Tlx+Z8mxlZvgTw2XmQsqNONvRC
 8HlLV4w5v5hWGibUDXr0t47UZ02WXmBcbNVDkqbum8pUrRH3vriVJKohkPTXd0dzgirf
 VYkGK2/hC8+pbSfQCXxVtWWY7Z3OwTt9o43eqlTHUVGL9CGyWKEA/nYXYZttjTK0QKw6
 HXot4psYrc3hjv6lk+j30PYfn9DLY8MSVdsj8v5OsWBEIb+smhBCAOo5uPJJhVrjGCuQ
 0wEJtuwezSFoXX8iXxBEhylK0/hfwd7AxYxG99QRu/akCWKIpFMHzEpoT/F1SQ/rK2aZ 5g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g4bn58y39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 12:55:48 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24HCfPk5007842;
        Tue, 17 May 2022 12:55:47 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g4bn58y22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 12:55:47 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24HCr3xo027106;
        Tue, 17 May 2022 12:55:45 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3g24293c9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 12:55:44 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24HCtgjS52101610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 12:55:42 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BABEF5204F;
        Tue, 17 May 2022 12:55:42 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.2.119])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 189345204E;
        Tue, 17 May 2022 12:55:42 +0000 (GMT)
Date:   Tue, 17 May 2022 15:55:40 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Jaewon Kim <jaewon31.kim@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [RFC PATCH] page_ext: create page extension for all memblock
 memory regions
Message-ID: <YoObTJcBUjeW+2l2@linux.ibm.com>
References: <CGME20220509073953epcas1p127f2d36186316642068c92c5d9dee1c4@epcas1p1.samsung.com>
 <20220509074330.4822-1-jaewon31.kim@samsung.com>
 <20220516173321.67402b7f09eacc43d4e476f4@linux-foundation.org>
 <YoNcBG6kQnmLZ3Z9@linux.ibm.com>
 <CAJrd-UuzTh-0Ee9+rMRES9onP_EkvJS-VpPP66J4M4n0Ku0ZWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJrd-UuzTh-0Ee9+rMRES9onP_EkvJS-VpPP66J4M4n0Ku0ZWA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5YVPBFhqjLEYLYFotIEAw6eaMXRQIfXc
X-Proofpoint-ORIG-GUID: 4jHQNVHVKyD_zTvEqWkYF-S_Zx8M_e7S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_03,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205170076
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 08:38:18PM +0900, Jaewon Kim wrote:
> Hello Mike Rapoport
> Thank you for your comment.
> 
> Oh really? Could you point out the code or the commit regarding 'all
> struct pages in any section should be valid and
> properly initialized' ?

There were several commits that refactored the memory map initialization,
freeing of the unused memory map and abuse of pfn_valid() as a substitute
of "is memory valid" semantics.

> Actually I am using v5.10 based source tree on an arm64 device.

Then most probably your change is not relevant for the upstream kernel.
Did you observe any issues with page_ext initialization on v5.18-rcN
kernels?

> I tried to look up and found the following commit in v5.16-rc1, did
> you mean this?
> 3de360c3fdb3 arm64/mm: drop HAVE_ARCH_PFN_VALID

Yes, this is one of those commits.
 
> I guess memblock_is_memory code in pfn_valid in arch/arm64/mm/init.c, v5.10
> might affect the page_ext_init.

Yes. In 5.10 the pfn_valid() test in page_ext_init() will skip an entire
section if the first pfn in that section is not memory that can be mapped
in the linear map.

But again, this should be fixed in the latest kernels.
 
> Thank you
> 
> 2022년 5월 17일 (화) 오후 5:25, Mike Rapoport <rppt@linux.ibm.com>님이 작성:
> >
> > On Mon, May 16, 2022 at 05:33:21PM -0700, Andrew Morton wrote:
> > > On Mon,  9 May 2022 16:43:30 +0900 Jaewon Kim <jaewon31.kim@samsung.com> wrote:
> > >
> > > > The page extension can be prepared for each section. But if the first
> > > > page is not valid, the page extension for the section was not
> > > > initialized though there were many other valid pages within the section.
> >
> > What do you mean by "first page [in a section] is not valid"?
> > In recent kernels all struct pages in any section should be valid and
> > properly initialized.
> >
> > > > To support the page extension for all sections, refer to memblock memory
> > > > regions. If the page is valid use the nid from pfn_to_nid, otherwise use
> > > > the previous nid.
> > > >
> > > > Also this pagech changed log to include total sections and a section
> > > > size.
> > > >
> > > > i.e.
> > > > allocated 100663296 bytes of page_ext for 64 sections (1 section : 0x8000000)
> > >
> > > Cc Joonsoo, who wrote this code.
> > > Cc Mike, for memblock.
> > >
> > > Thanks.
> > >
> > > >
> > > > diff --git a/mm/page_ext.c b/mm/page_ext.c
> > > > index 2e66d934d63f..506d58b36a1d 100644
> > > > --- a/mm/page_ext.c
> > > > +++ b/mm/page_ext.c
> > > > @@ -381,41 +381,43 @@ static int __meminit page_ext_callback(struct notifier_block *self,
> > > >  void __init page_ext_init(void)
> > > >  {
> > > >     unsigned long pfn;
> > > > -   int nid;
> > > > +   int nid = 0;
> > > > +   struct memblock_region *rgn;
> > > > +   int nr_section = 0;
> > > > +   unsigned long next_section_pfn = 0;
> > > >
> > > >     if (!invoke_need_callbacks())
> > > >             return;
> > > >
> > > > -   for_each_node_state(nid, N_MEMORY) {
> > > > +   /*
> > > > +    * iterate each memblock memory region and do not skip a section having
> > > > +    * !pfn_valid(pfn)
> > > > +    */
> > > > +   for_each_mem_region(rgn) {
> > > >             unsigned long start_pfn, end_pfn;
> > > >
> > > > -           start_pfn = node_start_pfn(nid);
> > > > -           end_pfn = node_end_pfn(nid);
> > > > -           /*
> > > > -            * start_pfn and end_pfn may not be aligned to SECTION and the
> > > > -            * page->flags of out of node pages are not initialized.  So we
> > > > -            * scan [start_pfn, the biggest section's pfn < end_pfn) here.
> > > > -            */
> > > > +           start_pfn = (unsigned long)(rgn->base >> PAGE_SHIFT);
> > > > +           end_pfn = start_pfn + (unsigned long)(rgn->size >> PAGE_SHIFT);
> > > > +
> > > > +           if (start_pfn < next_section_pfn)
> > > > +                   start_pfn = next_section_pfn;
> > > > +
> > > >             for (pfn = start_pfn; pfn < end_pfn;
> > > >                     pfn = ALIGN(pfn + 1, PAGES_PER_SECTION)) {
> > > >
> > > > -                   if (!pfn_valid(pfn))
> > > > -                           continue;
> > > > -                   /*
> > > > -                    * Nodes's pfns can be overlapping.
> > > > -                    * We know some arch can have a nodes layout such as
> > > > -                    * -------------pfn-------------->
> > > > -                    * N0 | N1 | N2 | N0 | N1 | N2|....
> > > > -                    */
> > > > -                   if (pfn_to_nid(pfn) != nid)
> > > > -                           continue;
> > > > +                   if (pfn_valid(pfn))
> > > > +                           nid = pfn_to_nid(pfn);
> > > > +                   nr_section++;
> > > >                     if (init_section_page_ext(pfn, nid))
> > > >                             goto oom;
> > > >                     cond_resched();
> > > >             }
> > > > +           next_section_pfn = pfn;
> > > >     }
> > > > +
> > > >     hotplug_memory_notifier(page_ext_callback, 0);
> > > > -   pr_info("allocated %ld bytes of page_ext\n", total_usage);
> > > > +   pr_info("allocated %ld bytes of page_ext for %d sections (1 section : 0x%x)\n",
> > > > +           total_usage, nr_section, (1 << SECTION_SIZE_BITS));
> > > >     invoke_init_callbacks();
> > > >     return;
> > > >
> > > > --
> > > > 2.17.1
> > > >
> >
> > --
> > Sincerely yours,
> > Mike.

-- 
Sincerely yours,
Mike.
