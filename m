Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32A04C8E52
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbiCAOyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiCAOyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:54:13 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5DB506CD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 06:53:31 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 221E66NP019241;
        Tue, 1 Mar 2022 14:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=r755EAf0NgTBzAd5eKjZLVSUMzgIwRaOk5yOUbjexMo=;
 b=aqLJW4sITbcmxD75pC0VFDLAq5tYrqdg/LTkYdYSfhfsaV00vzkXLcDsiB4ybFdlb3ZX
 7uoE7HgMTM0feNchhIbXVOWR0ZqsGj1wABjsRFKlIgOqU5BrG3wwQxaz/5+WzW7K2iPS
 Uieh1bn5vIvEbF8xLnqjH2pX7gi2D4AlSsmB2HcMp6+dw0+4OJjnCiWdMHkPuwYXa8DR
 jYuqVmyGzId/XTM3uodlh03OAQFL2dI010zZvBceoPMM2MbR2X1lH9YrfsZDSOfmfzQo
 kWJfpvYipWb6hfFrNPYvm6Z1HdE6d4aIx2M0YokRMmkG8Yx7uA/zPLtQQHt2bK40qyIq MQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ehfruhcd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 14:53:05 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 221E1lg6020622;
        Tue, 1 Mar 2022 14:53:04 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ehfruhcc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 14:53:04 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 221EbZde032417;
        Tue, 1 Mar 2022 14:53:02 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3efbu9c0j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 14:53:02 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 221Er0Mq51839274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Mar 2022 14:53:00 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0313952054;
        Tue,  1 Mar 2022 14:53:00 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.6.152])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 34AF05204F;
        Tue,  1 Mar 2022 14:52:58 +0000 (GMT)
Date:   Tue, 1 Mar 2022 16:52:56 +0200
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
Message-ID: <Yh4zSN7paDE4M6rS@linux.ibm.com>
References: <20220225180318.20594-1-vbabka@suse.cz>
 <YhnUcqyeMgCrWZbd@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <f194f876-1c46-f3ae-573e-d3ddd6dcf4cc@suse.cz>
 <Yh0qGY48JeH7TzdQ@linux.ibm.com>
 <7918434f-9730-3532-9b42-3e67d10d25d3@suse.cz>
 <Yh3lhDuL2DhuREp4@linux.ibm.com>
 <827b9a5a-f925-776d-1893-c35211fee7f9@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <827b9a5a-f925-776d-1893-c35211fee7f9@suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: J3VFofxv2mI_pls7deOAMgKjm00XlvIm
X-Proofpoint-GUID: 19Ktj9e3Sq3ze88BOuaXsNjENf97FRTv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-01_07,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203010079
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 10:41:10AM +0100, Vlastimil Babka wrote:
> On 3/1/22 10:21, Mike Rapoport wrote:
> > On Tue, Mar 01, 2022 at 12:38:11AM +0100, Vlastimil Babka wrote:
> >> On 2/28/22 21:01, Mike Rapoport wrote:
> >> > On Mon, Feb 28, 2022 at 08:10:18PM +0100, Vlastimil Babka wrote:
> >> > 
> >> > If stack_depot_init() is called from kmem_cache_init(), there will be a
> >> > confusion what allocator should be used because we use slab_is_available()
> >> > to stop using memblock and start using kmalloc() instead in both
> >> > stack_depot_init() and in memblock.
> >> 
> >> I did check that stack_depot_init() is called from kmem_cache_init()
> >> *before* we make slab_is_available() true, hence assumed that memblock would
> >> be still available at that point and expected no confusion. But seems if
> >> memblock is already beyond memblock_free_all() then it being still available
> >> is just an illusion?
> > 
> > Yeah, it appears it is an illusion :)
> > 
> > I think we have to deal with allocations that happen between
> > memblock_free_all() and slab_is_available() at the memblock level and then
> > figure out the where to put stack_depot_init() and how to allocate memory
> > there.
> > 
> > I believe something like this (untested) patch below addresses the first
> > issue. As for stack_depot_init() I'm still trying to figure out the
> > possible call paths, but it seems we can use stack_depot_early_init() for
> > SLUB debugging case. I'll try to come up with something Really Soon (tm).
> 
> Yeah as you already noticed, we are pursuing an approach to decide on
> calling stack_depot_early_init(), which should be a good way to solve this
> given how special slab is in this case. For memblock I just wanted to point
> out that it could be more robust, your patch below seems to be on the right
> patch. Maybe it just doesn't have to fallback to buddy, which could be
> considered a layering violation, but just return NULL that can be
> immediately recognized as an error?

The layering violation is anyway there for slab_is_available() case, so
adding a __alloc_pages() there will be only consistent.
 
> > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > index 50ad19662a32..4ea89d44d22a 100644
> > --- a/include/linux/memblock.h
> > +++ b/include/linux/memblock.h
> > @@ -90,6 +90,7 @@ struct memblock_type {
> >   */
> >  struct memblock {
> >  	bool bottom_up;  /* is bottom up direction? */
> > +	bool mem_freed;
> >  	phys_addr_t current_limit;
> >  	struct memblock_type memory;
> >  	struct memblock_type reserved;
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index b12a364f2766..60196dc4980e 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -120,6 +120,7 @@ struct memblock memblock __initdata_memblock = {
> >  	.reserved.name		= "reserved",
> >  
> >  	.bottom_up		= false,
> > +	.mem_freed		= false,
> >  	.current_limit		= MEMBLOCK_ALLOC_ANYWHERE,
> >  };
> >  
> > @@ -1487,6 +1488,13 @@ static void * __init memblock_alloc_internal(
> >  	if (WARN_ON_ONCE(slab_is_available()))
> >  		return kzalloc_node(size, GFP_NOWAIT, nid);
> >  
> > +	if (memblock.mem_freed) {
> > +		unsigned int order = get_order(size);
> > +
> > +		pr_warn("memblock: allocating from buddy\n");
> > +		return __alloc_pages_node(nid, order, GFP_KERNEL);
> > +	}
> > +
> >  	if (max_addr > memblock.current_limit)
> >  		max_addr = memblock.current_limit;
> >  
> > @@ -2116,6 +2124,7 @@ void __init memblock_free_all(void)
> >  
> >  	pages = free_low_memory_core_early();
> >  	totalram_pages_add(pages);
> > +	memblock.mem_freed = true;
> >  }
> >  
> >  #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_ARCH_KEEP_MEMBLOCK)
> >  

-- 
Sincerely yours,
Mike.
