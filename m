Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7941F4C87DD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbiCAJam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbiCAJal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:30:41 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134976C940
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 01:30:00 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id i1so12982907plr.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 01:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tOXanIeqoV4tge34B0/qTL2YOxSkwo0wt9c05w9sWp8=;
        b=XkqF0ayMLmXrjrs8YI7nDCz0XLMxOrO42LSpjKMpgUEoZyNbpdt2qYjLMPCZrs1jYC
         UEeDyR5dlmM19LPsOBSnv58Xzwv+A3BcNMGsHyByUr8PRlZ/LuLpPIz1haU8UvenHWJY
         Rs9RJU9YWbfsG8Y+OSVZg/qzeiMPBcN86gEQp74oXWw+PT8j/4revsfnaElY9d8oW8ex
         meBtL/Fc50V1hyBULeatutPrrqfaXl1XkB5uGsKtIVHfkGK7k1+HGQ8IyBixUYnMv8NT
         LG5/lcT9Y92AGjKIH7Sh6UxTF/0if5OyxcuY2lfZNSCswG38tl4rd9oIfJowwCo2lSkz
         3xFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tOXanIeqoV4tge34B0/qTL2YOxSkwo0wt9c05w9sWp8=;
        b=znoobNauNs04rVuu1DCGm9pcaZv7aHZF9uHgdORJW0WkztseDVxHB7CmrAm2/3R3LP
         AOWIlRce3BrpfufqCjknhSHCeHZJBAJhAOAkl+z6N6xtRZSKozqAp0YEkXyfvMiBYGml
         JBvoFTN7JwtSpUJCm+FG43MlW0rSOlRlhqTkqoXIOYRQikahWHh9CdQYPZHoya/uaUmb
         Mje6wRANIogbBFxc/r2c35E3aywgDzJvQPfr3VToGMikvLFp/R6h1Xi7jZnm/zRDqwey
         E/PiLSdj4fM0ucdrF0iTSZWbe9JEac+jMrw8FKNWSI++FM1jCBwGuERXGJx8VFVQrIOn
         y/SA==
X-Gm-Message-State: AOAM533IRwdRFJd0XqkWjz02LaSPsGH1wMKGBwSs9uMAFjsZj8m+RsUT
        e7wQNLjIAmJMvKLhmE9769g=
X-Google-Smtp-Source: ABdhPJx8mUuSlwUvLBTivxH4H6RTpz3AQeg9c7dsvL+JgzAHniNxPFsZtSQtktOYSw4/aEQDVjd/4Q==
X-Received: by 2002:a17:90a:de96:b0:1be:e427:8745 with SMTP id n22-20020a17090ade9600b001bee4278745mr866665pjv.175.1646126999545;
        Tue, 01 Mar 2022 01:29:59 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id b2-20020a056a000a8200b004e1414f0bb1sm15848730pfl.135.2022.03.01.01.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 01:29:59 -0800 (PST)
Date:   Tue, 1 Mar 2022 09:29:52 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Matteo Croce <mcroce@microsoft.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Zqiang <qiang.zhang@windriver.com>
Subject: Re: [PATCH v3] mm/slub: initialize stack depot in boot process
Message-ID: <Yh3nkGD2glQ0u+4A@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <Yh3erDM9anwFXkD8@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <3cc16aa0-c8b8-624d-bd39-1bb7a3ec5756@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cc16aa0-c8b8-624d-bd39-1bb7a3ec5756@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 10:14:30AM +0100, Vlastimil Babka wrote:
> On 3/1/22 09:51, Hyeonggon Yoo wrote:
> > commit ba10d4b46655 ("mm/slub: use stackdepot to save stack trace in
> > objects") initializes stack depot in cache creation if SLAB_STORE_USER
> > flag is set.
> 
> As pointed out, this is not a stable commit, the series was just posted for
> review and there will be v2. So instead of "this fixes the commit..." I
> suggest writing the patch assuming it's a preparation for the patch
> "mm/slub: use stackdepot"... and I can then make it part of the series.
> So it should instead explain that for slub_debug we will need a way to
> trigger stack_depot_early_init() based on boot options and so this patch
> introduces it...
>

Agreed.

> > This can make kernel crash because a cache can be crashed in various
> > contexts. For example if user sets slub_debug=U, kernel crashes
> > because create_boot_cache() calls stack_depot_init(), which tries to
> > allocate hash table using memblock_alloc() if slab is not available.
> > But memblock is also not available at that time.
> > 
> > This patch solves the problem by initializing stack depot early
> > in boot process if SLAB_STORE_USER debug flag is set globally
> > or the flag is set for at least one cache.
> > 
> > [ elver@google.com: initialize stack depot depending on slub_debug
> >   parameter instead of allowing stack_depot_init() to be called
> >   during kmem_cache_init() for simplicity. ]
> > 
> > [ vbabka@suse.cz: parse slub_debug parameter in setup_slub_debug()
> >   and initialize stack depot in stack_depot_early_init(). ]
> > 
> > [ lkp@intel.com: Fix build error. ]
> > 
> > Link: https://lore.kernel.org/all/YhyeaP8lrzKgKm5A@ip-172-31-19-208.ap-northeast-1.compute.internal/
> > Fixes: ba10d4b46655 ("mm/slub: use stackdepot to save stack trace in objects")
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > ---
> >  include/linux/slab.h       |  1 +
> >  include/linux/stackdepot.h |  3 ++-
> >  mm/slab.c                  |  5 +++++
> >  mm/slob.c                  |  5 +++++
> >  mm/slub.c                  | 19 ++++++++++++++++---
> >  5 files changed, 29 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index 37bde99b74af..d2b0f8f9e5e6 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -762,6 +762,7 @@ extern void kvfree_sensitive(const void *addr, size_t len);
> >  
> >  unsigned int kmem_cache_size(struct kmem_cache *s);
> >  void __init kmem_cache_init_late(void);
> > +int __init slab_stack_depot_init(void);
> >  
> >  #if defined(CONFIG_SMP) && defined(CONFIG_SLAB)
> >  int slab_prepare_cpu(unsigned int cpu);
> > diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
> > index 17f992fe6355..a813a2673c48 100644
> > --- a/include/linux/stackdepot.h
> > +++ b/include/linux/stackdepot.h
> > @@ -12,6 +12,7 @@
> >  #define _LINUX_STACKDEPOT_H
> >  
> >  #include <linux/gfp.h>
> > +#include <linux/slab.h>
> >  
> >  typedef u32 depot_stack_handle_t;
> >  
> > @@ -32,7 +33,7 @@ int stack_depot_init(void);
> >  #ifdef CONFIG_STACKDEPOT_ALWAYS_INIT
> >  static inline int stack_depot_early_init(void)	{ return stack_depot_init(); }
> >  #else
> > -static inline int stack_depot_early_init(void)	{ return 0; }
> > +static inline int stack_depot_early_init(void)	{ return slab_stack_depot_init(); }
> >  #endif
> 
> I think the approach should be generic for stackdepot, not tied to a
> function that belongs to slab with 3 different implementations.
> E.g. in stackdepot.h declare a variable e.g. "stack_depot_want_early_init"
> that is checked in stack_depot_early_init() above to call stack_depot_init().

Hmm yeah if we define it in stack depot, that would be nice.
I just didn't want to expose global variable that is specific to slub.

> >  depot_stack_handle_t stack_depot_save(unsigned long *entries,
> > diff --git a/mm/slab.c b/mm/slab.c
> > index ddf5737c63d9..c7f929665fbe 100644
> > --- a/mm/slab.c
> > +++ b/mm/slab.c
> > @@ -1196,6 +1196,11 @@ static void __init set_up_node(struct kmem_cache *cachep, int index)
> >  	}
> >  }
> >  
> > +int __init slab_stack_depot_init(void)
> > +{
> > +	return 0;
> > +}
> > +
> >  /*
> >   * Initialisation.  Called after the page allocator have been initialised and
> >   * before smp_init().
> > diff --git a/mm/slob.c b/mm/slob.c
> > index 60c5842215f1..7597c219f061 100644
> > --- a/mm/slob.c
> > +++ b/mm/slob.c
> > @@ -725,3 +725,8 @@ void __init kmem_cache_init_late(void)
> >  {
> >  	slab_state = FULL;
> >  }
> > +
> > +int __init slab_stack_depot_init(void)
> > +{
> > +	return 0;
> > +}
> > diff --git a/mm/slub.c b/mm/slub.c
> > index a74afe59a403..8f130f917977 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -646,6 +646,16 @@ static slab_flags_t slub_debug;
> >  
> >  static char *slub_debug_string;
> >  static int disable_higher_order_debug;
> > +static bool __initdata init_stack_depot;
> > +
> > +int __init slab_stack_depot_init(void)
> > +{
> > +#ifdef CONFIG_STACKDEPOT
> > +	if (init_stack_depot)
> > +		stack_depot_init();
> > +#endif
> > +	return 0;
> > +}
> 
> 
> 
> >  /*
> >   * slub is about to manipulate internal object metadata.  This memory lies
> > @@ -1531,6 +1541,8 @@ static int __init setup_slub_debug(char *str)
> >  			global_slub_debug_changed = true;
> >  		} else {
> >  			slab_list_specified = true;
> > +			if (flags & SLAB_STORE_USER)
> > +				init_stack_depot = true;
> >  		}
> >  	}
> >  
> > @@ -1546,6 +1558,10 @@ static int __init setup_slub_debug(char *str)
> >  			global_flags = slub_debug;
> >  		slub_debug_string = saved_str;
> >  	}
> > +
> > +	if (global_flags & SLAB_STORE_USER)
> > +		init_stack_depot = true;
> 
> This looks good, it would just set the "stack_depot_want_early_init"
> variable instead. But logically should be part of "mm/slub: use
> stackdepot...", not part of patch that introduces the variable. That so if
> you don't mind I would move it there with credit.
>

Oh I don't mind that.
Then I will expect this to be solved in next series...

I'm looking forward to next version. Thanks!
-- 
Thank you, You are awesome!
Hyeonggon :-)

> >  out:
> >  	slub_debug = global_flags;
> >  	if (slub_debug != 0 || slub_debug_string)
> > @@ -4221,9 +4237,6 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
> >  	s->remote_node_defrag_ratio = 1000;
> >  #endif
> >  
> > -	if (s->flags & SLAB_STORE_USER && IS_ENABLED(CONFIG_STACKDEPOT))
> > -		stack_depot_init();
> > -
> >  	/* Initialize the pre-computed randomized freelist if slab is up */
> >  	if (slab_state >= UP) {
> >  		if (init_cache_random_seq(s))
> 
