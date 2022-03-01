Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D48C4C87CD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbiCAJZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiCAJZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:25:16 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1034552B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 01:24:35 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2219AOJp018450;
        Tue, 1 Mar 2022 09:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=SiUsJ1DXW6hxS+hdywKpSldhFIimq7TO7KWzL6I9/BM=;
 b=qenEXEHrRyE1WUEQy1Jobt2NeT8/tppv6s0nkKTCizkbsKN3X69LyefXnqSxr/3j0iAM
 48fu7IoPJWXu4Zcz+MA8959Ej6YVUSGysEClvbg6X+Hr10+HzzYFtd/DclmOaN51O5gg
 d1B1wwuE6bQiTQ74brtgVSJnOMR7+yyl524442yamtF44UKRfu7VT1a17rL7ayU3Q16j
 SzdG4dViv9nlqlej61fkdFyYLPYrTQ/GEspv6zS2X4iRme5hLvwXfSJVNCCaUGyngd3N
 ndEay3Su6P2SJ4dKk/z62ToaeIKfXMxHOVtaEotxeOjeVs8o9co5XUSiyXMy40nZ1qKY fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ehfru9ce9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 09:24:18 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2219Cj0T027397;
        Tue, 1 Mar 2022 09:24:17 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ehfru9cdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 09:24:17 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2219HW3f027814;
        Tue, 1 Mar 2022 09:24:15 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 3efbu9252w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 09:24:15 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2219OCEe17367336
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Mar 2022 09:24:12 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B70B54C050;
        Tue,  1 Mar 2022 09:24:12 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6CEE4C052;
        Tue,  1 Mar 2022 09:24:10 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.186.94])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  1 Mar 2022 09:24:10 +0000 (GMT)
Date:   Tue, 1 Mar 2022 11:23:48 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marco Elver <elver@google.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: Re: [PATCH 0/5] SLUB debugfs improvements based on stackdepot
Message-ID: <Yh3mJJya4xCXvcNl@linux.ibm.com>
References: <20220225180318.20594-1-vbabka@suse.cz>
 <YhnUcqyeMgCrWZbd@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <f194f876-1c46-f3ae-573e-d3ddd6dcf4cc@suse.cz>
 <Yh0+Jld+sDy1Hkdb@ip-172-31-19-208.ap-northeast-1.compute.internal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh0+Jld+sDy1Hkdb@ip-172-31-19-208.ap-northeast-1.compute.internal>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: q2Wjh4QaMz10uDTwH4W41tNznZ3kFpqg
X-Proofpoint-GUID: aitNhXh253_qIzmEJ0Kvc6Y2-L6GjGcg
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-28_10,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203010044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 28, 2022 at 09:27:02PM +0000, Hyeonggon Yoo wrote:
> On Mon, Feb 28, 2022 at 08:10:18PM +0100, Vlastimil Babka wrote:
> > On 2/26/22 08:19, Hyeonggon Yoo wrote:
> > > On Fri, Feb 25, 2022 at 07:03:13PM +0100, Vlastimil Babka wrote:
> > >> Hi,
> > >> 
> > >> this series combines and revives patches from Oliver's last year
> > >> bachelor thesis (where I was the advisor) that make SLUB's debugfs
> > >> files alloc_traces and free_traces more useful.
> > >> The resubmission was blocked on stackdepot changes that are now merged,
> > >> as explained in patch 2.
> > >> 
> > > 
> > > Hello. I just started review/testing this series.
> > > 
> > > it crashed on my system (arm64)
> > 
> > Hmm, interesting. On x86_64 this works for me and stackdepot is allocated
> > from memblock. arm64 must have memblock freeing happen earlier or something.
> > (CCing memblock experts)
> > 
> > > I ran with boot parameter slub_debug=U, and without KASAN.
> > > So CONFIG_STACKDEPOT_ALWAYS_INIT=n.
> > > 
> > > void * __init memblock_alloc_try_nid(
> > >                         phys_addr_t size, phys_addr_t align,
> > >                         phys_addr_t min_addr, phys_addr_t max_addr,
> > >                         int nid)
> > > {
> > >         void *ptr;
> > > 
> > >         memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pS\n",
> > >                      __func__, (u64)size, (u64)align, nid, &min_addr,
> > >                      &max_addr, (void *)_RET_IP_);
> > >         ptr = memblock_alloc_internal(size, align,
> > >                                            min_addr, max_addr, nid, false);
> > >         if (ptr)
> > >                 memset(ptr, 0, size); <--- Crash Here
> > > 
> > >         return ptr;
> > > }
> > > 
> > > It crashed during create_boot_cache() -> stack_depot_init() ->
> > > memblock_alloc().
> > > 
> > > I think That's because, in kmem_cache_init(), both slab and memblock is not
> > > available. (AFAIU memblock is not available after mem_init() because of
> > > memblock_free_all(), right?)
> > 
> > Hm yes I see, even in x86_64 version mem_init() calls memblock_free_all().
> > But then, I would expect stack_depot_init() to detect that memblock_alloc()
> > returns NULL, we print ""Stack Depot hash table allocation failed,
> > disabling" and disable it. Instead it seems memblock_alloc() returns
> > something that's already potentially used by somebody else? Sounds like a bug?
> 
> 
> By the way, I fixed this by allowing stack_depot_init() to be called in
> kmem_cache_init() too [1] and Marco suggested that calling
> stack_depot_init() depending on slub_debug parameter for simplicity. [2]
> 
> I would prefer [2], Would you take a look?
> 
> [1] https://lkml.org/lkml/2022/2/27/31
> 
> [2] https://lkml.org/lkml/2022/2/28/717

I'm still looking at stack_depot_init() callers, but I think it's possible
to make stack_depot_early_init() a proper function that calls
memblock_alloc() and only use stack_depot_init() when slab is actually
available.
 
> > > Thanks!
> > > 
> > > /*
> > >  * Set up kernel memory allocators
> > >  */
> > > static void __init mm_init(void)
> > > {
> > >         /*
> > >          * page_ext requires contiguous pages,
> > >          * bigger than MAX_ORDER unless SPARSEMEM.
> > >          */
> > >         page_ext_init_flatmem();
> > >         init_mem_debugging_and_hardening();
> > >         kfence_alloc_pool();
> > >         report_meminit();
> > >         stack_depot_early_init();
> > >         mem_init();
> > >         mem_init_print_info();
> > >         kmem_cache_init();
> > >         /*
> > >          * page_owner must be initialized after buddy is ready, and also after
> > >          * slab is ready so that stack_depot_init() works properly
> > >          */)
> > > 
> > >> Patch 1 is a new preparatory cleanup.
> > >> 
> > >> Patch 2 originally submitted here [1], was merged to mainline but
> > >> reverted for stackdepot related issues as explained in the patch.
> > >> 
> > >> Patches 3-5 originally submitted as RFC here [2]. In this submission I
> > >> have omitted the new file 'all_objects' (patch 3/3 in [2]) as it might
> > >> be considered too intrusive so I will postpone it for later. The docs
> > >> patch is adjusted accordingly.
> > >> 
> > >> Also available in git, based on v5.17-rc1:
> > >> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-stackdepot-v1
> > >> 
> > >> I'd like to ask for some review before I add this to the slab tree.
> > >> 
> > >> [1] https://lore.kernel.org/all/20210414163434.4376-1-glittao@gmail.com/
> > >> [2] https://lore.kernel.org/all/20210521121127.24653-1-glittao@gmail.com/
> > >> 
> > >> Oliver Glitta (4):
> > >>   mm/slub: use stackdepot to save stack trace in objects
> > >>   mm/slub: aggregate and print stack traces in debugfs files
> > >>   mm/slub: sort debugfs output by frequency of stack traces
> > >>   slab, documentation: add description of debugfs files for SLUB caches
> > >> 
> > >> Vlastimil Babka (1):
> > >>   mm/slub: move struct track init out of set_track()
> > >> 
> > >>  Documentation/vm/slub.rst |  61 +++++++++++++++
> > >>  init/Kconfig              |   1 +
> > >>  mm/slub.c                 | 152 +++++++++++++++++++++++++-------------
> > >>  3 files changed, 162 insertions(+), 52 deletions(-)
> > >> 
> > >> -- 
> > >> 2.35.1
> > >> 
> > >> 
> > > 
> > 
> 
> -- 
> Thank you, You are awesome!
> Hyeonggon :-)

-- 
Sincerely yours,
Mike.
