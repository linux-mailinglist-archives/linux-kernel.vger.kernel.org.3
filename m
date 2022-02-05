Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E2C4AA6FE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 06:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343692AbiBEF4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 00:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243150AbiBEF4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 00:56:01 -0500
X-Greylist: delayed 38072 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Feb 2022 21:56:00 PST
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633B2C061346
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 21:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644040560; x=1675576560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yQ7E7TdXEEU3uNvWo8FZUSDdiTe2O3C8a8Gvtg3fBhw=;
  b=TL/W2rwhd5iXuYSke6cgJRRDvjo/8BGbZotOKXC/K74Qx1PX6pznymqF
   fhZG17QOn3jCaRC2v27s0fHA4JhRtrLHEz8qAdwVtqAOpjBL3cmDvpLTB
   03DupGRhUdDpzidsdt8HBqeOAdpi0hR3bJYrAO6JuZ+wjx4JgyhznlQip
   ovl33naZXRXd6iaSPx6rSPZfMFWASjT3MVS4u+2vUKxFu9x/fXrPZy+Ku
   ePsxMnWvYnvTTcI62Km8ZMHqYPmHhI4UHF5tR+uqC5OycgULddkpZtTWg
   JW1p1eOsiZ9QYNSoCDYEz4a16qPSrfVvw77mR2dXsYJH8RisRxOdVi7yH
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="229141521"
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="229141521"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 21:56:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="524543550"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 21:55:59 -0800
Date:   Fri, 4 Feb 2022 21:55:59 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 38/44] memremap_pages: Define
 pgmap_mk_{readwrite|noaccess}() calls
Message-ID: <20220205055559.GF785175@iweiny-DESK2.sc.intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-39-ira.weiny@intel.com>
 <CAPcyv4iYOGD2XpmO3RH+wViuXx8EYrq-BK7vuKv6we+KR60YCg@mail.gmail.com>
 <20220205000953.GD785175@iweiny-DESK2.sc.intel.com>
 <CAPcyv4jmnUbywDcXOAL9DwKxGaUf9cw9iDYbDcz6_CHyYPtytw@mail.gmail.com>
 <CAPcyv4iLVh_BesJLcZb=Pktd-h5x6-xuos5Cj4TzuWYC=Q-vLg@mail.gmail.com>
 <CAPcyv4gUSDwvOysAMM59yVsERtYpA_kY6s4=xunkjc2eJ8Mi1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gUSDwvOysAMM59yVsERtYpA_kY6s4=xunkjc2eJ8Mi1w@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 04:27:38PM -0800, Dan Williams wrote:
> On Fri, Feb 4, 2022 at 4:25 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Fri, Feb 4, 2022 at 4:19 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > On Fri, Feb 4, 2022 at 4:10 PM Ira Weiny <ira.weiny@intel.com> wrote:
> > > >
> > > > On Fri, Feb 04, 2022 at 10:35:59AM -0800, Dan Williams wrote:
> > > > > On Thu, Jan 27, 2022 at 9:55 AM <ira.weiny@intel.com> wrote:
> > > > > >
> > > >
> > > > [snip]
> > > >
> > > > I'll address the other comments later but wanted to address the idea below.
> > > >
> > > > > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > > > > index f5b2be39a78c..5020ed7e67b7 100644
> > > > > > --- a/include/linux/sched.h
> > > > > > +++ b/include/linux/sched.h
> > > > > > @@ -1492,6 +1492,13 @@ struct task_struct {
> > > > > >         struct callback_head            l1d_flush_kill;
> > > > > >  #endif
> > > > > >
> > > > > > +#ifdef CONFIG_DEVMAP_ACCESS_PROTECTION
> > > > > > +       /*
> > > > > > +        * NOTE: pgmap_prot_count is modified within a single thread of
> > > > > > +        * execution.  So it does not need to be atomic_t.
> > > > > > +        */
> > > > > > +       u32                             pgmap_prot_count;
> > > > > > +#endif
> > > > >
> > > > > It's not at all clear why the task struct needs to be burdened with
> > > > > this accounting. Given that a devmap instance is needed to manage page
> > > > > protections, why not move the nested protection tracking to a percpu
> > > > > variable relative to an @pgmap arg? Something like:
> > > > >
> > > > > void __pgmap_mk_readwrite(struct dev_pagemap *pgmap)
> > > > > {
> > > > >        migrate_disable();
> > > > >        preempt_disable();
> > > >
> > > > Why burden threads like this?  kmap_local_page() is perfectly able to migrate
> > > > or be preempted?
> > > >
> > > > I think this is way to restrictive.
> > >
> > > kmap_local_page() holds migrate_disable() over the entire mapping, so
> > > we're only talking about preempt_disable(). I tend to think that
> > > bloating task_struct for something that is rarely used "kmap on dax
> > > pmem pages" is not the right tradeoff.
> >
> > Now, I can see an argument that promoting kmap_local_page() to
> > preempt_disable() could cause problems, but I'd like help confirming
> > that before committing to extending task_struct.
> 
> ...as I say that it occurs to me that the whole point of
> kmap_local_page() is to be better than kmap_atomic() and this undoes
> that. I'd at least like that documented as the reason that task_struct
> needs to carry a new field.

I'll try and update the commit message but kmap_local_page() only disables
migrate on a highmem system.  The devmap/PKS use case is specifically not
supported on highmem systems.  Mainly because on highmem systems
kmap_local_page() actually creates a new mapping which is not covered by PKS
anyway.

So for the devmap/PKS use case kmap_local_page() is defined as:

 static inline void *kmap_local_page(struct page *page)
 {
+       pgmap_mk_readwrite(page);
        return page_address(page);
 }

...for the linear mapping.  I'll try and update the commit message with this
detail.

Ira
