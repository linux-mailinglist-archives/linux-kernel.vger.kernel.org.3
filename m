Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34754AA4E6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 01:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378677AbiBEAJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 19:09:54 -0500
Received: from mga01.intel.com ([192.55.52.88]:10787 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345660AbiBEAJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 19:09:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644019793; x=1675555793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5n92rv9+fb3jUXaM752SnIxVcFeOkNjSKBOOTpk53t0=;
  b=C4ypq1HH467YNWl76RrmU2RBkx/q47oz5jRd8bc7Gx1Z3oSAMyHxfS9w
   s13WkAJVIBAV/JO9KoOcEY59Eao13AavHKj53DmzD+FXgXFUU/ZBo8jlQ
   z0ygWCUTaX+HqfV+Q1I8pPtjxNqDGqr+W6Cg3uhPsJmKvLno4KPA02IS8
   qL3D2z4IV/em2GMwB7JPW222qiRzAyRQNOHDROWvVVDOzU1dKf7G2K31o
   e1ajZhlkw+DQeXtEAMu9r98ESdxLk+2TcaSkZ5xfsoW6ntpDjI1T+jPnG
   2wBPcqru54IBz8cAUUYQHnngyQTpAIKDA585suFWGvrqGn6hiy5bkC9Kx
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="272972524"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="272972524"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 16:09:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="539357124"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 16:09:53 -0800
Date:   Fri, 4 Feb 2022 16:09:53 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 38/44] memremap_pages: Define
 pgmap_mk_{readwrite|noaccess}() calls
Message-ID: <20220205000953.GD785175@iweiny-DESK2.sc.intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-39-ira.weiny@intel.com>
 <CAPcyv4iYOGD2XpmO3RH+wViuXx8EYrq-BK7vuKv6we+KR60YCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iYOGD2XpmO3RH+wViuXx8EYrq-BK7vuKv6we+KR60YCg@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 10:35:59AM -0800, Dan Williams wrote:
> On Thu, Jan 27, 2022 at 9:55 AM <ira.weiny@intel.com> wrote:
> >

[snip]

I'll address the other comments later but wanted to address the idea below.

> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index f5b2be39a78c..5020ed7e67b7 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1492,6 +1492,13 @@ struct task_struct {
> >         struct callback_head            l1d_flush_kill;
> >  #endif
> >
> > +#ifdef CONFIG_DEVMAP_ACCESS_PROTECTION
> > +       /*
> > +        * NOTE: pgmap_prot_count is modified within a single thread of
> > +        * execution.  So it does not need to be atomic_t.
> > +        */
> > +       u32                             pgmap_prot_count;
> > +#endif
> 
> It's not at all clear why the task struct needs to be burdened with
> this accounting. Given that a devmap instance is needed to manage page
> protections, why not move the nested protection tracking to a percpu
> variable relative to an @pgmap arg? Something like:
> 
> void __pgmap_mk_readwrite(struct dev_pagemap *pgmap)
> {
>        migrate_disable();
>        preempt_disable();

Why burden threads like this?  kmap_local_page() is perfectly able to migrate
or be preempted?

I think this is way to restrictive.

>        if (this_cpu_add_return(pgmap->pgmap_prot_count, 1) == 1)
>                pks_mk_readwrite(PKS_KEY_PGMAP_PROTECTION);
> }
> EXPORT_SYMBOL_GPL(__pgmap_mk_readwrite);
> 
> void __pgmap_mk_noaccess(struct dev_pagemap *pgmap)
> {
>        if (!this_cpu_sub_return(pgmap->pgmap_prot_count, 1))
>                pks_mk_noaccess(PKS_KEY_PGMAP_PROTECTION);
>        preempt_enable();
>        migrate_enable();
> }
> EXPORT_SYMBOL_GPL(__pgmap_mk_noaccess);
> 
> The naming, which I had a hand in, is not aging well. When I see "mk"
> I expect it to be building some value like a page table entry that
> will be installed later. These helpers are directly enabling and
> disabling access and are meant to be called symmetrically. So I would
> expect symmetric names like:
> 
> pgmap_enable_access()
> pgmap_disable_access()

Names are easily changed.  I'll look at changing the names.

Ira

> 
> 
> >         /*
> >          * New fields for task_struct should be added above here, so that
> >          * they are included in the randomized portion of task_struct.
> > diff --git a/init/init_task.c b/init/init_task.c
> > index 73cc8f03511a..948b32cf8139 100644
> > --- a/init/init_task.c
> > +++ b/init/init_task.c
> > @@ -209,6 +209,9 @@ struct task_struct init_task
> >  #ifdef CONFIG_SECCOMP_FILTER
> >         .seccomp        = { .filter_count = ATOMIC_INIT(0) },
> >  #endif
> > +#ifdef CONFIG_DEVMAP_ACCESS_PROTECTION
> > +       .pgmap_prot_count = 0,
> > +#endif
> >  };
> >  EXPORT_SYMBOL(init_task);
> >
> > diff --git a/mm/memremap.c b/mm/memremap.c
> > index d3e6f328a711..b75c4f778c59 100644
> > --- a/mm/memremap.c
> > +++ b/mm/memremap.c
> > @@ -96,6 +96,20 @@ static void devmap_protection_disable(void)
> >         static_branch_dec(&dev_pgmap_protection_static_key);
> >  }
> >
> > +void __pgmap_mk_readwrite(struct dev_pagemap *pgmap)
> > +{
> > +       if (!current->pgmap_prot_count++)
> > +               pks_mk_readwrite(PKS_KEY_PGMAP_PROTECTION);
> > +}
> > +EXPORT_SYMBOL_GPL(__pgmap_mk_readwrite);
> > +
> > +void __pgmap_mk_noaccess(struct dev_pagemap *pgmap)
> > +{
> > +       if (!--current->pgmap_prot_count)
> > +               pks_mk_noaccess(PKS_KEY_PGMAP_PROTECTION);
> > +}
> > +EXPORT_SYMBOL_GPL(__pgmap_mk_noaccess);
> > +
> >  bool pgmap_protection_available(void)
> >  {
> >         return pks_available();
> > --
> > 2.31.1
> >
