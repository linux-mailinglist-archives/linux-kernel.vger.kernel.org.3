Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECA14CA4D6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241784AbiCBMc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235226AbiCBMc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:32:27 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD31A6212C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 04:31:44 -0800 (PST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 222BIvPu012399;
        Wed, 2 Mar 2022 12:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=ssqeGosA0pQQPIYxQer1cI+lAi2Vi2aZv32kNe8fENU=;
 b=NbioDw1cTKrfga+7mEork8yFvieuFIaiaVv6xcmOpxxvLYo+QF2ocEhqYokl+S/gTJ1L
 gITQ+/erVbokMXNwtLkmUO9EhkiN0euLU7Y1WrhG+UOz25XKcOta5zdEN+rVefW3fAau
 uB6x+rwcXVCr4wP8VRbP3g1vQ2/LPhkK65+J9g0i3Ts144njbvCfyBDX1xqdguKvzAjO
 kW2MLoRjAqkreS6OOfJU1O/4oE4VbdPcdfSBHkYKDAKKIE4tgFTs/OHg8kUeg8KK4UBa
 CTUZ2oPZLBLy6+IecQgXNZHjAqugwHLQTdxNI376PssuFC/uhxaXSfht7y8HIN0DED1J FQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ej50kx0t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 12:31:24 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 222CGoaK019342;
        Wed, 2 Mar 2022 12:31:23 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ej50kx0k5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 12:31:23 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 222CCwT2023027;
        Wed, 2 Mar 2022 12:31:02 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3efbu9epcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 12:31:02 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 222CV0Yi52298158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Mar 2022 12:31:00 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB98DA405C;
        Wed,  2 Mar 2022 12:30:59 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30906A405F;
        Wed,  2 Mar 2022 12:30:58 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.6.152])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  2 Mar 2022 12:30:58 +0000 (GMT)
Date:   Wed, 2 Mar 2022 14:30:56 +0200
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
Message-ID: <Yh9jgGOocmU3WsES@linux.ibm.com>
References: <20220225180318.20594-1-vbabka@suse.cz>
 <YhnUcqyeMgCrWZbd@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <f194f876-1c46-f3ae-573e-d3ddd6dcf4cc@suse.cz>
 <Yh0+Jld+sDy1Hkdb@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <Yh8szz+UxqddwK7j@linux.ibm.com>
 <024aacf5-ac49-7d04-7293-1e1451ff9029@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <024aacf5-ac49-7d04-7293-1e1451ff9029@suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SnzLkF-2mRhK-sT9BnbXNXMy2Elyamk7
X-Proofpoint-ORIG-GUID: L_u0jnzP4pMN10y5bXNblvMUZZET6nKJ
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_06,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203020054
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 10:09:37AM +0100, Vlastimil Babka wrote:
> On 3/2/22 09:37, Mike Rapoport wrote:
> > On Mon, Feb 28, 2022 at 09:27:02PM +0000, Hyeonggon Yoo wrote:
> >> On Mon, Feb 28, 2022 at 08:10:18PM +0100, Vlastimil Babka wrote:
> >> > On 2/26/22 08:19, Hyeonggon Yoo wrote:
> >> > > On Fri, Feb 25, 2022 at 07:03:13PM +0100, Vlastimil Babka wrote:
> >> > >> Hi,
> >> > >> 
> >> > >> this series combines and revives patches from Oliver's last year
> >> > >> bachelor thesis (where I was the advisor) that make SLUB's debugfs
> >> > >> files alloc_traces and free_traces more useful.
> >> > >> The resubmission was blocked on stackdepot changes that are now merged,
> >> > >> as explained in patch 2.
> >> > >> 
> >> > > 
> >> > > Hello. I just started review/testing this series.
> >> > > 
> >> > > it crashed on my system (arm64)
> >> > 
> >> > Hmm, interesting. On x86_64 this works for me and stackdepot is allocated
> >> > from memblock. arm64 must have memblock freeing happen earlier or something.
> >> > (CCing memblock experts)
> >> > 
> >> > > I ran with boot parameter slub_debug=U, and without KASAN.
> >> > > So CONFIG_STACKDEPOT_ALWAYS_INIT=n.
> >> > > 
> >> > > void * __init memblock_alloc_try_nid(
> >> > >                         phys_addr_t size, phys_addr_t align,
> >> > >                         phys_addr_t min_addr, phys_addr_t max_addr,
> >> > >                         int nid)
> >> > > {
> >> > >         void *ptr;
> >> > > 
> >> > >         memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pS\n",
> >> > >                      __func__, (u64)size, (u64)align, nid, &min_addr,
> >> > >                      &max_addr, (void *)_RET_IP_);
> >> > >         ptr = memblock_alloc_internal(size, align,
> >> > >                                            min_addr, max_addr, nid, false);
> >> > >         if (ptr)
> >> > >                 memset(ptr, 0, size); <--- Crash Here
> >> > > 
> >> > >         return ptr;
> >> > > }
> >> > > 
> >> > > It crashed during create_boot_cache() -> stack_depot_init() ->
> >> > > memblock_alloc().
> >> > > 
> >> > > I think That's because, in kmem_cache_init(), both slab and memblock is not
> >> > > available. (AFAIU memblock is not available after mem_init() because of
> >> > > memblock_free_all(), right?)
> >> > 
> >> > Hm yes I see, even in x86_64 version mem_init() calls memblock_free_all().
> >> > But then, I would expect stack_depot_init() to detect that memblock_alloc()
> >> > returns NULL, we print ""Stack Depot hash table allocation failed,
> >> > disabling" and disable it. Instead it seems memblock_alloc() returns
> >> > something that's already potentially used by somebody else? Sounds like a bug?
> >> 
> >> 
> >> By the way, I fixed this by allowing stack_depot_init() to be called in
> >> kmem_cache_init() too [1] and Marco suggested that calling
> >> stack_depot_init() depending on slub_debug parameter for simplicity. [2]
> >> 
> >> I would prefer [2], Would you take a look?
> >> 
> >> [1] https://lkml.org/lkml/2022/2/27/31
> >> 
> >> [2] https://lkml.org/lkml/2022/2/28/717
> > 
> > I have the third version :)
> 
> While simple, it changes the timing of stack_depot_early_init() that was
> supposed to be at a single callsite - now it's less predictable and depends
> on e.g. kernel parameter ordering. Some arch/config combo could break,
> dunno. Setting a variable that stack_depot_early_init() checks should be
> more robust.

Not sure I follow.
stack_depot_early_init() is a wrapper for stack_depot_init() which already
checks 

	if (!stack_depot_disable && !stack_table)

So largely it can be at multiple call sites just like stack_depot_init...

Still, I understand your concern of having multiple call sites for
stack_depot_early_init().

The most robust way I can think of will be to make stack_depot_early_init()
a proper function, move memblock_alloc() there and add a variable, say
stack_depot_needed_early that will be set to 1 if
CONFIG_STACKDEPOT_ALWAYS_INIT=y or by the callers that need to allocate the
stack_table before kmalloc is up.
 
E.g

__init int stack_depot_early_init(void)
{

	if (stack_depot_needed_early && !stack_table) {
		size_t size = (STACK_HASH_SIZE * sizeof(struct stack_record *));
		int i;

		pr_info("Stack Depot allocating hash table with memblock_alloc\n");
		stack_table = memblock_alloc(size, SMP_CACHE_BYTES);
	
		if (!stack_table) {
			pr_err("Stack Depot hash table allocation failed, disabling\n");
			stack_depot_disable = true;
			return -ENOMEM;
		}
	}

	return 0;
}

The mutex is not needed here because mm_init() -> stack_depot_early_init()
happens before SMP and setting stack_table[i] to NULL is redundant with
memblock_alloc(). (btw, kvmalloc case could use __GFP_ZERO as well).

I'm not sure if the stack depot should be disabled for good if the early
allocation failed, but that's another story.

> > diff --git a/mm/slub.c b/mm/slub.c
> > index a74afe59a403..0c3ab2335b46 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -1548,6 +1548,10 @@ static int __init setup_slub_debug(char *str)
> >  	}
> >  out:
> >  	slub_debug = global_flags;
> > +
> > +	if (slub_flags & SLAB_STORE_USER && IS_ENABLED(CONFIG_STACKDEPOT))
> > +		stack_depot_early_init();
> > +
> >  	if (slub_debug != 0 || slub_debug_string)
> >  		static_branch_enable(&slub_debug_enabled);
> >  	else
> > @@ -4221,9 +4225,6 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
> >  	s->remote_node_defrag_ratio = 1000;
> >  #endif
> >  
> > -	if (s->flags & SLAB_STORE_USER && IS_ENABLED(CONFIG_STACKDEPOT))
> > -		stack_depot_init();
> > -
> >  	/* Initialize the pre-computed randomized freelist if slab is up */
> >  	if (slab_state >= UP) {
> >  		if (init_cache_random_seq(s))
> >  
> >> -- 
> >> Thank you, You are awesome!
> >> Hyeonggon :-)
> > 
> 

-- 
Sincerely yours,
Mike.
