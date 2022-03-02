Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AAF4C9F67
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237583AbiCBIiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238088AbiCBIis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:38:48 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3300250055
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:38:05 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2226N0hr002909;
        Wed, 2 Mar 2022 08:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=mc+Kc+DCEcKRZPN5qTrPjUbLA+hIr9inqzz2bxJfQh0=;
 b=TwIiYIb09X89dzJIyrvyID0O0VwrLtjzSjJzm+NuAq+N3lvjcfpHNslHPx8JrthvYbBS
 FNg2Ifx0zRS1pFyZSB4ECryYb4G5jEwHj/2G1NeZLXocnuOoOpLYq/ZK1yefnLYsezPC
 kEHxQUOqnGrjkCmCBhXAoWIUzmEUmpCfzjlcGSxahhltzCtryLZZHCDqGG7Ji4A9uRIO
 h6tU13DYvzJ8IeG+kJTrekQuEpoYv+oYzeNBpTErHm8owZHQhmlV9i8KBsrEuux5Ioky
 RQRIlrcV9DBTpi7HgYed5kYoY4UgLgcEOcHFy9Uzk174BSJQOO7zfdPFvpkId7DxlOwV cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ej38v2f1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 08:37:45 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2228X9tc014378;
        Wed, 2 Mar 2022 08:37:44 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ej38v2f0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 08:37:44 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2228SW0S004616;
        Wed, 2 Mar 2022 08:37:41 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3efbu9cqv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 08:37:41 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2228bdJD50921910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Mar 2022 08:37:39 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C49C5204F;
        Wed,  2 Mar 2022 08:37:39 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.6.152])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 96EB952051;
        Wed,  2 Mar 2022 08:37:37 +0000 (GMT)
Date:   Wed, 2 Mar 2022 10:37:35 +0200
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
Message-ID: <Yh8szz+UxqddwK7j@linux.ibm.com>
References: <20220225180318.20594-1-vbabka@suse.cz>
 <YhnUcqyeMgCrWZbd@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <f194f876-1c46-f3ae-573e-d3ddd6dcf4cc@suse.cz>
 <Yh0+Jld+sDy1Hkdb@ip-172-31-19-208.ap-northeast-1.compute.internal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh0+Jld+sDy1Hkdb@ip-172-31-19-208.ap-northeast-1.compute.internal>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oyPXrdVh4XkTyeSq6Ho5Kg-Xb11KovFw
X-Proofpoint-GUID: GJMQnKyrQDtSPkSAoU05iEWR3Y_Qv7a6
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_01,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203020034
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

I have the third version :)

diff --git a/mm/slub.c b/mm/slub.c
index a74afe59a403..0c3ab2335b46 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1548,6 +1548,10 @@ static int __init setup_slub_debug(char *str)
 	}
 out:
 	slub_debug = global_flags;
+
+	if (slub_flags & SLAB_STORE_USER && IS_ENABLED(CONFIG_STACKDEPOT))
+		stack_depot_early_init();
+
 	if (slub_debug != 0 || slub_debug_string)
 		static_branch_enable(&slub_debug_enabled);
 	else
@@ -4221,9 +4225,6 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
 	s->remote_node_defrag_ratio = 1000;
 #endif
 
-	if (s->flags & SLAB_STORE_USER && IS_ENABLED(CONFIG_STACKDEPOT))
-		stack_depot_init();
-
 	/* Initialize the pre-computed randomized freelist if slab is up */
 	if (slab_state >= UP) {
 		if (init_cache_random_seq(s))
 
> -- 
> Thank you, You are awesome!
> Hyeonggon :-)

-- 
Sincerely yours,
Mike.
