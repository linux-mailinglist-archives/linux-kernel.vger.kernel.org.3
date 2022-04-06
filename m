Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60604F634F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbiDFPX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbiDFPWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:22:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A20347CE86
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 05:22:14 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236BFpEe013712;
        Wed, 6 Apr 2022 12:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=UUOAOVXQv7FmL7v0LVM2RmRG55lZHmDMXG1dw2sqO5g=;
 b=UoaURcX5SchXZj/VnmhpnDhId6OZkOvpMlayOhACl5PGxrZrOKmsaZckcbtRn+e4Xj5g
 Ot4gEZaeN2zl0BBSA0KZ74ezqbM9zA9wsf1+VLp/X/zrPPRTrQEGEYOsiWFbRR3bWzDR
 3i+3x6x18Qb7b++cFY4GaBdaZMRUJlUPca7Ed3ZIdcyUJfbh97MQJGN/OiaXEcQYb6Gx
 rDuXF5fue4+a9AvK9i06Wj55oARTv4hGGLVxa7AQDBvamPhkF7xSspfYAwXFkoKbkzq/
 uKllFYb2qa/wZ9pHXcdgKWZNyuDZKXvhkVEZTmBRwmJHtQk6iJJcLrLEBOvOmkGAiAo5 NQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f99u9192e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Apr 2022 12:21:50 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 236CJ9Do002807;
        Wed, 6 Apr 2022 12:21:50 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f99u9191b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Apr 2022 12:21:50 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 236CJS1C013275;
        Wed, 6 Apr 2022 12:21:47 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3f6e48xdyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Apr 2022 12:21:46 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 236CLiKq33030446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Apr 2022 12:21:44 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 699D5A4040;
        Wed,  6 Apr 2022 12:21:44 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 493D1A404D;
        Wed,  6 Apr 2022 12:21:43 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.20.15])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  6 Apr 2022 12:21:43 +0000 (GMT)
Date:   Wed, 6 Apr 2022 15:21:41 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Marco Elver <elver@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>
Subject: Re: [PATCH v3 1/6] lib/stackdepot: allow requesting early
 initialization dynamically
Message-ID: <Yk2F1aI5tIAAFB8/@linux.ibm.com>
References: <20220404164112.18372-1-vbabka@suse.cz>
 <20220404164112.18372-2-vbabka@suse.cz>
 <8a13e52b-f4ff-4fd9-1f8a-fdea3868bc1@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a13e52b-f4ff-4fd9-1f8a-fdea3868bc1@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: W1kWC0GWor52snNpSZGEf3OAv5yV2pns
X-Proofpoint-ORIG-GUID: 41wvWAlOIjwu39NE10264zlGjnADyeWn
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-06_04,2022-04-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 impostorscore=0 phishscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204060057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 02:40:03PM -0700, David Rientjes wrote:
> On Mon, 4 Apr 2022, Vlastimil Babka wrote:
> 
> > In a later patch we want to add stackdepot support for object owner
> > tracking in slub caches, which is enabled by slub_debug boot parameter.
> > This creates a bootstrap problem as some caches are created early in
> > boot when slab_is_available() is false and thus stack_depot_init()
> > tries to use memblock. But, as reported by Hyeonggon Yoo [1] we are
> > already beyond memblock_free_all(). Ideally memblock allocation should
> > fail, yet it succeeds, but later the system crashes, which is a
> > separately handled issue.
> > 
> > To resolve this boostrap issue in a robust way, this patch adds another
> > way to request stack_depot_early_init(), which happens at a well-defined
> > point of time. In addition to build-time CONFIG_STACKDEPOT_ALWAYS_INIT,
> > code that's e.g. processing boot parameters (which happens early enough)
> > can call a new function stack_depot_want_early_init(), which sets a flag
> > that stack_depot_early_init() will check.
> > 
> > In this patch we also convert page_owner to this approach. While it
> > doesn't have the bootstrap issue as slub, it's also a functionality
> > enabled by a boot param and can thus request stack_depot_early_init()
> > with memblock allocation instead of later initialization with
> > kvmalloc().
> > 
> > As suggested by Mike, make stack_depot_early_init() only attempt
> > memblock allocation and stack_depot_init() only attempt kvmalloc().
> > Also change the latter to kvcalloc(). In both cases we can lose the
> > explicit array zeroing, which the allocations do already.
> > 
> > As suggested by Marco, provide empty implementations of the init
> > functions for !CONFIG_STACKDEPOT builds to simplify the callers.
> > 
> > [1] https://lore.kernel.org/all/YhnUcqyeMgCrWZbd@ip-172-31-19-208.ap-northeast-1.compute.internal/
> > 
> > Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Suggested-by: Mike Rapoport <rppt@linux.ibm.com>
> > Suggested-by: Marco Elver <elver@google.com>
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > Reviewed-by: Marco Elver <elver@google.com>
> > Reviewed-and-tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  include/linux/stackdepot.h | 26 ++++++++++++---
> >  lib/stackdepot.c           | 66 +++++++++++++++++++++++++-------------
> >  mm/page_owner.c            |  9 ++++--
> >  3 files changed, 72 insertions(+), 29 deletions(-)
> > 
> > diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
> > index 17f992fe6355..bc2797955de9 100644
> > --- a/include/linux/stackdepot.h
> > +++ b/include/linux/stackdepot.h
> > @@ -20,18 +20,36 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
> >  					gfp_t gfp_flags, bool can_alloc);
> >  
> >  /*
> > - * Every user of stack depot has to call this during its own init when it's
> > - * decided that it will be calling stack_depot_save() later.
> > + * Every user of stack depot has to call stack_depot_init() during its own init
> > + * when it's decided that it will be calling stack_depot_save() later. This is
> > + * recommended for e.g. modules initialized later in the boot process, when
> > + * slab_is_available() is true.
> >   *
> >   * The alternative is to select STACKDEPOT_ALWAYS_INIT to have stack depot
> >   * enabled as part of mm_init(), for subsystems where it's known at compile time
> >   * that stack depot will be used.
> > + *
> > + * Another alternative is to call stack_depot_want_early_init(), when the
> > + * decision to use stack depot is taken e.g. when evaluating kernel boot
> > + * parameters, which precedes the enablement point in mm_init().
> > + *
> > + * stack_depot_init() and stack_depot_want_early_init() can be called regardless
> > + * of CONFIG_STACKDEPOT and are no-op when disabled. The actual save/fetch/print
> > + * functions should only be called from code that makes sure CONFIG_STACKDEPOT
> > + * is enabled.
> >   */
> > +#ifdef CONFIG_STACKDEPOT
> >  int stack_depot_init(void);
> >  
> > -#ifdef CONFIG_STACKDEPOT_ALWAYS_INIT
> > -static inline int stack_depot_early_init(void)	{ return stack_depot_init(); }
> > +void __init stack_depot_want_early_init(void);
> > +
> > +/* This is supposed to be called only from mm_init() */
> > +int __init stack_depot_early_init(void);
> >  #else
> > +static inline int stack_depot_init(void) { return 0; }
> > +
> > +static inline void stack_depot_want_early_init(void) { }
> > +
> >  static inline int stack_depot_early_init(void)	{ return 0; }
> >  #endif
> >  
> > diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> > index bf5ba9af0500..6c4644c9ed44 100644
> > --- a/lib/stackdepot.c
> > +++ b/lib/stackdepot.c
> > @@ -66,6 +66,9 @@ struct stack_record {
> >  	unsigned long entries[];	/* Variable-sized array of entries. */
> >  };
> >  
> > +static bool __stack_depot_want_early_init __initdata = IS_ENABLED(CONFIG_STACKDEPOT_ALWAYS_INIT);
> > +static bool __stack_depot_early_init_passed __initdata;
> > +
> >  static void *stack_slabs[STACK_ALLOC_MAX_SLABS];
> >  
> >  static int depot_index;
> > @@ -162,38 +165,57 @@ static int __init is_stack_depot_disabled(char *str)
> >  }
> >  early_param("stack_depot_disable", is_stack_depot_disabled);
> >  
> > -/*
> > - * __ref because of memblock_alloc(), which will not be actually called after
> > - * the __init code is gone, because at that point slab_is_available() is true
> > - */
> > -__ref int stack_depot_init(void)
> > +void __init stack_depot_want_early_init(void)
> > +{
> > +	/* Too late to request early init now */
> > +	WARN_ON(__stack_depot_early_init_passed);
> > +
> > +	__stack_depot_want_early_init = true;
> > +}
> > +
> > +int __init stack_depot_early_init(void)
> > +{
> > +	size_t size;
> > +
> > +	/* This is supposed to be called only once, from mm_init() */
> > +	if (WARN_ON(__stack_depot_early_init_passed))
> > +		return 0;
> > +
> > +	__stack_depot_early_init_passed = true;
> > +
> > +	if (!__stack_depot_want_early_init || stack_depot_disable)
> > +		return 0;
> > +
> > +	pr_info("Stack Depot early init allocating hash table with memblock_alloc\n");
> > +	size = (STACK_HASH_SIZE * sizeof(struct stack_record *));
> 
> I think the kvcalloc() in the main init path is very unlikely to fail, but 
> perhaps this memblock_alloc() might?  If so, a nit might be to include 
> this size as part of the printk.

memblock_alloc() is even more unlikely to fail than kvcalloc() ;-)
But printing the size won't hurt.

> Either way:
> 
> Acked-by: David Rientjes <rientjes@google.com>

-- 
Sincerely yours,
Mike.
