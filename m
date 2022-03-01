Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411504C87BD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbiCAJWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbiCAJWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:22:22 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5681580233
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 01:21:41 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2218qnid002710;
        Tue, 1 Mar 2022 09:21:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=o/tJPwku/fIQ2KGZl2nDoj+65rfXrxO2m5g1soyEaT4=;
 b=HdR4jZZp14K/Rof0XuY5+JzxwLwHkOImEfZi+5w+N0lf2XSY4PbPUmUoiIiT/U3+IsmS
 avYJjKJm3U7B1WRoFGfW12h5YRB2us2wOpMH5cyouExZ1oY4EaFeYAsjmihIhMZMWsSV
 jfIf/9NV2COW5grLzyU9KSZ6O6zAg1yMWMXYZ09vqoOAcqjJ2ql7Fc9nAZC/DJVcdLNi
 1f3QndlZZYhcd5Ncr4TzjmA6VO3mSHeEqN4ASF3he6wamUJNsZCfafoj9P5d6gaR3hGO
 jUWvUQN1uELRAoGMSVw9GVoFrc4k0i1sgam9iAE3vvvrYkvHhkGQ59tJCAHvD2PxdmXq 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ehgc6gn9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 09:21:23 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2219LMNx012278;
        Tue, 1 Mar 2022 09:21:22 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ehgc6gn95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 09:21:22 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2219I2b9015100;
        Tue, 1 Mar 2022 09:21:20 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 3efbu8t3gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 09:21:20 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2219LHoV59834824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Mar 2022 09:21:18 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E126111C050;
        Tue,  1 Mar 2022 09:21:17 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F4DC11C04C;
        Tue,  1 Mar 2022 09:21:15 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.186.94])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  1 Mar 2022 09:21:15 +0000 (GMT)
Date:   Tue, 1 Mar 2022 11:21:08 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
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
Message-ID: <Yh3lhDuL2DhuREp4@linux.ibm.com>
References: <20220225180318.20594-1-vbabka@suse.cz>
 <YhnUcqyeMgCrWZbd@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <f194f876-1c46-f3ae-573e-d3ddd6dcf4cc@suse.cz>
 <Yh0qGY48JeH7TzdQ@linux.ibm.com>
 <7918434f-9730-3532-9b42-3e67d10d25d3@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7918434f-9730-3532-9b42-3e67d10d25d3@suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1fyVTac-g_3ygn2fNPwzBT0WrFoepykQ
X-Proofpoint-ORIG-GUID: k8rUZ7YOrugsQ5vBaerTrvJHIWtI6a6s
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-28_10,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 impostorscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

On Tue, Mar 01, 2022 at 12:38:11AM +0100, Vlastimil Babka wrote:
> On 2/28/22 21:01, Mike Rapoport wrote:
> > On Mon, Feb 28, 2022 at 08:10:18PM +0100, Vlastimil Babka wrote:
> >> On 2/26/22 08:19, Hyeonggon Yoo wrote:
> >> > On Fri, Feb 25, 2022 at 07:03:13PM +0100, Vlastimil Babka wrote:
> >> >> Hi,
> >> >> 
> >> >> this series combines and revives patches from Oliver's last year
> >> >> bachelor thesis (where I was the advisor) that make SLUB's debugfs
> >> >> files alloc_traces and free_traces more useful.
> >> >> The resubmission was blocked on stackdepot changes that are now merged,
> >> >> as explained in patch 2.
> >> >> 
> >> > 
> >> > Hello. I just started review/testing this series.
> >> > 
> >> > it crashed on my system (arm64)
> >> 
> >> Hmm, interesting. On x86_64 this works for me and stackdepot is allocated
> >> from memblock. arm64 must have memblock freeing happen earlier or something.
> >> (CCing memblock experts)
> >> 
> >> > I ran with boot parameter slub_debug=U, and without KASAN.
> >> > So CONFIG_STACKDEPOT_ALWAYS_INIT=n.
> >> > 
> >> > void * __init memblock_alloc_try_nid(
> >> >                         phys_addr_t size, phys_addr_t align,
> >> >                         phys_addr_t min_addr, phys_addr_t max_addr,
> >> >                         int nid)
> >> > {
> >> >         void *ptr;
> >> > 
> >> >         memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pS\n",
> >> >                      __func__, (u64)size, (u64)align, nid, &min_addr,
> >> >                      &max_addr, (void *)_RET_IP_);
> >> >         ptr = memblock_alloc_internal(size, align,
> >> >                                            min_addr, max_addr, nid, false);
> >> >         if (ptr)
> >> >                 memset(ptr, 0, size); <--- Crash Here
> >> > 
> >> >         return ptr;
> >> > }
> >> > 
> >> > It crashed during create_boot_cache() -> stack_depot_init() ->
> >> > memblock_alloc().
> >> > 
> >> > I think That's because, in kmem_cache_init(), both slab and memblock is not
> >> > available. (AFAIU memblock is not available after mem_init() because of
> >> > memblock_free_all(), right?)
> >> 
> >> Hm yes I see, even in x86_64 version mem_init() calls memblock_free_all().
> >> But then, I would expect stack_depot_init() to detect that memblock_alloc()
> >> returns NULL, we print ""Stack Depot hash table allocation failed,
> >> disabling" and disable it. Instead it seems memblock_alloc() returns
> >> something that's already potentially used by somebody else? Sounds like a bug?
> > 
> > If stack_depot_init() is called from kmem_cache_init(), there will be a
> > confusion what allocator should be used because we use slab_is_available()
> > to stop using memblock and start using kmalloc() instead in both
> > stack_depot_init() and in memblock.
> 
> I did check that stack_depot_init() is called from kmem_cache_init()
> *before* we make slab_is_available() true, hence assumed that memblock would
> be still available at that point and expected no confusion. But seems if
> memblock is already beyond memblock_free_all() then it being still available
> is just an illusion?

Yeah, it appears it is an illusion :)

I think we have to deal with allocations that happen between
memblock_free_all() and slab_is_available() at the memblock level and then
figure out the where to put stack_depot_init() and how to allocate memory
there.

I believe something like this (untested) patch below addresses the first
issue. As for stack_depot_init() I'm still trying to figure out the
possible call paths, but it seems we can use stack_depot_early_init() for
SLUB debugging case. I'll try to come up with something Really Soon (tm).

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 50ad19662a32..4ea89d44d22a 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -90,6 +90,7 @@ struct memblock_type {
  */
 struct memblock {
 	bool bottom_up;  /* is bottom up direction? */
+	bool mem_freed;
 	phys_addr_t current_limit;
 	struct memblock_type memory;
 	struct memblock_type reserved;
diff --git a/mm/memblock.c b/mm/memblock.c
index b12a364f2766..60196dc4980e 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -120,6 +120,7 @@ struct memblock memblock __initdata_memblock = {
 	.reserved.name		= "reserved",
 
 	.bottom_up		= false,
+	.mem_freed		= false,
 	.current_limit		= MEMBLOCK_ALLOC_ANYWHERE,
 };
 
@@ -1487,6 +1488,13 @@ static void * __init memblock_alloc_internal(
 	if (WARN_ON_ONCE(slab_is_available()))
 		return kzalloc_node(size, GFP_NOWAIT, nid);
 
+	if (memblock.mem_freed) {
+		unsigned int order = get_order(size);
+
+		pr_warn("memblock: allocating from buddy\n");
+		return __alloc_pages_node(nid, order, GFP_KERNEL);
+	}
+
 	if (max_addr > memblock.current_limit)
 		max_addr = memblock.current_limit;
 
@@ -2116,6 +2124,7 @@ void __init memblock_free_all(void)
 
 	pages = free_low_memory_core_early();
 	totalram_pages_add(pages);
+	memblock.mem_freed = true;
 }
 
 #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_ARCH_KEEP_MEMBLOCK)
 
> > Hyeonggon, did you run your tests with panic on warn at any chance?
> >  
> >> > Thanks!
> >> > 
> >> > /*
> >> >  * Set up kernel memory allocators
> >> >  */
> >> > static void __init mm_init(void)
> >> > {
> >> >         /*
> >> >          * page_ext requires contiguous pages,
> >> >          * bigger than MAX_ORDER unless SPARSEMEM.
> >> >          */
> >> >         page_ext_init_flatmem();
> >> >         init_mem_debugging_and_hardening();
> >> >         kfence_alloc_pool();
> >> >         report_meminit();
> >> >         stack_depot_early_init();
> >> >         mem_init();
> >> >         mem_init_print_info();
> >> >         kmem_cache_init();
> >> >         /*
> >> >          * page_owner must be initialized after buddy is ready, and also after
> >> >          * slab is ready so that stack_depot_init() works properly
> >> >          */)
> >> > 
> >> >> Patch 1 is a new preparatory cleanup.
> >> >> 
> >> >> Patch 2 originally submitted here [1], was merged to mainline but
> >> >> reverted for stackdepot related issues as explained in the patch.
> >> >> 
> >> >> Patches 3-5 originally submitted as RFC here [2]. In this submission I
> >> >> have omitted the new file 'all_objects' (patch 3/3 in [2]) as it might
> >> >> be considered too intrusive so I will postpone it for later. The docs
> >> >> patch is adjusted accordingly.
> >> >> 
> >> >> Also available in git, based on v5.17-rc1:
> >> >> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-stackdepot-v1
> >> >> 
> >> >> I'd like to ask for some review before I add this to the slab tree.
> >> >> 
> >> >> [1] https://lore.kernel.org/all/20210414163434.4376-1-glittao@gmail.com/
> >> >> [2] https://lore.kernel.org/all/20210521121127.24653-1-glittao@gmail.com/
> >> >> 
> >> >> Oliver Glitta (4):
> >> >>   mm/slub: use stackdepot to save stack trace in objects
> >> >>   mm/slub: aggregate and print stack traces in debugfs files
> >> >>   mm/slub: sort debugfs output by frequency of stack traces
> >> >>   slab, documentation: add description of debugfs files for SLUB caches
> >> >> 
> >> >> Vlastimil Babka (1):
> >> >>   mm/slub: move struct track init out of set_track()
> >> >> 
> >> >>  Documentation/vm/slub.rst |  61 +++++++++++++++
> >> >>  init/Kconfig              |   1 +
> >> >>  mm/slub.c                 | 152 +++++++++++++++++++++++++-------------
> >> >>  3 files changed, 162 insertions(+), 52 deletions(-)
> >> >> 
> >> >> -- 
> >> >> 2.35.1
> >> >> 
> >> >> 
> >> > 
> >> 
> > 
> 

-- 
Sincerely yours,
Mike.
