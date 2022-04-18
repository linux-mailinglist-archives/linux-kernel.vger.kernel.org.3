Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D993A504D31
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 09:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbiDRH0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 03:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiDRH0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 03:26:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F7C17056
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 00:24:15 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23I7G1mo026797;
        Mon, 18 Apr 2022 07:24:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=D6CBfan09eIT1E3CmNWuMcsc/lZWABsYnRNEbvHvyv0=;
 b=C5RwCnsVZ0l8aV54MpmE4lMJFH9FkrYa/tMX+36ugcTgzZgH/yjgCACCjjupuobv38zk
 B1KGb3V0gA/s8cAIr484+14Ohfu/VExBqJ80XHAmlhRCXpqeYcSr2t1K6z1AdZyOq7Yz
 5ItGWvr8CYeAPpckn/COO3+ZyINaF2YT7/O2R4ZWkGODxdY+MGprmHHRFGVuBfpIjPuN
 Ir71k/uMgCb4kSxy8I2NBkoCVXu2UVaEfbb9iyrKAg6pW9EroplfAzW+GHgMcVFjnurS
 tagGMtDBMUlYqYrhV7GH3gJHtVAcbyK4WnDS0cFw17bYpdxgVqI9Ktcz17t7RnG5AWyV Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fg7916k5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Apr 2022 07:24:09 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23I7O99c034890;
        Mon, 18 Apr 2022 07:24:09 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fg7916k4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Apr 2022 07:24:09 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23I7NpkW008302;
        Mon, 18 Apr 2022 07:24:06 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3ffvt99hrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Apr 2022 07:24:06 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23I7O4iY33161696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Apr 2022 07:24:04 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C8D0AE056;
        Mon, 18 Apr 2022 07:24:04 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA192AE04D;
        Mon, 18 Apr 2022 07:24:03 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.146.209])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 18 Apr 2022 07:24:03 +0000 (GMT)
Date:   Mon, 18 Apr 2022 10:24:02 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] mm, page_alloc: check pfn is valid before moving to
 freelist
Message-ID: <Yl0IZWT2nsiYtqBT@linux.ibm.com>
References: <cover.1649794059.git.quic_sudaraja@quicinc.com>
 <fb3c8c008994b2ed96f74b6b9698ff998b689bd2.1649794059.git.quic_sudaraja@quicinc.com>
 <Ylc3JGy6DUq00ryv@linux.ibm.com>
 <ee7bfc09-80af-a348-36ab-9d4ba9c612fa@quicinc.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ee7bfc09-80af-a348-36ab-9d4ba9c612fa@quicinc.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fo9tXEcuP3tXt9eND5OvGuk3RvwYI5dM
X-Proofpoint-GUID: fiXGtzHx8PQL0ieEOwaNWuySMQU6Lhma
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-18_02,2022-04-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=992 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204180041
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 02:30:52AM +0530, Sudarshan Rajagopalan wrote:
> 
> On 4/14/2022 2:18 AM, Mike Rapoport wrote:
> > On Tue, Apr 12, 2022 at 01:16:23PM -0700, Sudarshan Rajagopalan wrote:
> > > Check if pfn is valid before or not before moving it to freelist.
> > > 
> > > There are possible scenario where a pageblock can have partial physical
> > > hole and partial part of System RAM. This happens when base address in RAM
> > > partition table is not aligned to pageblock size.
> > > 
> > > Example:
> > > 
> > > Say we have this first two entries in RAM partition table -
> > > 
> > > Base Addr: 0x0000000080000000 Length: 0x0000000058000000
> > > Base Addr: 0x00000000E3930000 Length: 0x0000000020000000
> > I wonder what was done to memory DIMMs to get such an interesting
> > physical memory layout...
> 
> We have a feature where we carve out some portion of memory in RAM partition
> table, hence we see such base addresses here.

Cannot the firmware align that portion at some sensible boundary?
Or at least report the carved out range as "reserved" (and maybe NOMAP)
rather than as hole?

> > > Physical hole: 0xD8000000 - 0xE3930000
> > > 
> > > With the pageblock which has partial physical hole at the beginning, we will
> > > run into PFNs from the physical hole whose struct page is not initialized and
> > > is invalid, and system would crash as we operate on invalid struct page to find
> > > out of page is in Buddy or LRU or not
> >
> > struct page must be initialized and valid even for holes in the physical
> > memory. When a pageblock spans both existing memory and a hole, the struct
> > pages for the "hole" part should be marked as PG_Reserved.
> > If you see that struct pages for memory holes exist but invalid, we should
> > solve the underlying issue that causes wrong struct pages contents.
> 
> We are using 5.15 kernel, arm64 platform. For the pages belonging to the
> physical hole, I don't see that pages are being initialized.
> 
> Looking into memmap_init code, we call init_unavailable_range() to
> initialize the pages that belong to holes in the zone. But again we only do
> this for PFNs that are valid according to below code snippet -
> 
> init_unavailable_range() {
> 
> 6667     for (pfn = spfn; pfn < epfn; pfn++) {
> 6668         if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages))) {
> 6669             pfn = ALIGN_DOWN(pfn, pageblock_nr_pages)
> 6670                 + pageblock_nr_pages - 1;
> 6671             continue;
> 6672         }
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/mm/page_alloc.c?h=v5.15.34#n6668
> 
> With arm64 specific definition of pfn_valid(), a PFN which isn't present in
> RAM partition table (i.e. belongs to physical hole), pfn_valid will return
> FALSE. Hence we don't initialize any pages that belongs to physical hole
> here.
> 
> Or am I missing anything in kernel that initializes pages belonging to
> physical holes too? If so could you point me to that?

I agree with your analysis for 5.15, you just didn't mention that the
problem happens with 5.15.
 
> I see that in next kernel versions, we are removing arm64 specific
> definition of pfn_valid by Anshuman. Doing so, PFNs in hole would have
> pfn_valid return TRUE and we would then initialize pages in holes as well.

That said, your patch will not fix anything in the current kernel because
the issue should not happen there, right?

> But this patch was reverted by Will Deacon on 5.15 kernel.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/arch/arm64/mm?h=v5.17.3&id=3de360c3fdb34fbdbaf6da3af94367d3fded95d3

The reason for the revert was fixed by the commit a9c38c5d267c
("dma-mapping: remove bogus test for pfn_valid from dma_map_resource").

...

> > > Hence, avoid operating on invalid pages within the same pageblock by checking
> > > if pfn is valid or not.
> > > Signed-off-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> > > Fixes: 4c7b9896621be ("mm: remove pfn_valid_within() and CONFIG_HOLES_IN_ZONE")
> > > Cc: Mike Rapoport <rppt@linux.ibm.com>
> > For now the patch looks like a band-aid for more fundamental bug, so
> > 
> > NAKED-by: Mike Rapoport <rppt@linux.ibm.com>
> > 
> This patch may look like work around solution but yes I think there's a
> fundamental problem where kernel takes a pageblock which has partial holes
> and partial System RAM as valid pageblock, which occurs when Base Address in
> RAM partition table are not aligned to pageblock size.
> 
> This fundamental problem needs to be fixed, and looking for your
> suggestions.

I'd suggest backporting a9c38c5d267c ("dma-mapping: remove bogus test for
pfn_valid from dma_map_resource") and 3de360c3fdb3 ("arm64/mm: drop
HAVE_ARCH_PFN_VALID") to 5.15.

-- 
Sincerely yours,
Mike.
