Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1478B4C94AF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbiCATq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiCATqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:46:24 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22683580C5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 11:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646163943; x=1677699943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ttO+5pHvtBzn3qsx2LtXJLrWvmeaJDhDh7Bz8cbh+gA=;
  b=kSfwR8U5+D6ezyYHP7a59IRKEmETtTrpL5ecFAmoMwGrXf8HrhvGhDpH
   Ve2J5dLqkBoHIhLnNhf7dCV1qiZtjw77sxpKoRJSmTUn2NcrEXfkL6ezA
   k5YMgcqoYr3wro9f7vAJUD9F5Myjols3R1glzGtYAmLYdnb/P0vWblsuB
   JaxXHqi+p6qF/Uw6XwWFEVF2EtHm1uki7blhcJLxKLUQES1e6ntpkJ3sV
   KhpX4bBmVrOhF6DVcpO9rjaTwerYbdtPHuIsq5Rx5Dlm4POpFub3SZ6xp
   y9Oho8S7Dqy2Nt1JzR2OML1nR/qx/gQdHigBfk/IOkw9lkDyRsctceIiG
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="277892164"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="277892164"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 11:45:42 -0800
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="493234798"
Received: from bklinvil-mobl.amr.corp.intel.com (HELO localhost) ([10.212.48.220])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 11:45:41 -0800
Date:   Tue, 1 Mar 2022 11:45:41 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 41/44] kmap: Ensure kmap works for devmap pages
Message-ID: <Yh535Zqe/GtuF/Xh@iweiny-desk3>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-42-ira.weiny@intel.com>
 <CAPcyv4h1Q6H6_VApe3eFhEwe0McqbrFGRmy9rzFSPP0ATsTeTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4h1Q6H6_VApe3eFhEwe0McqbrFGRmy9rzFSPP0ATsTeTw@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 01:07:10PM -0800, Dan Williams wrote:
> On Thu, Jan 27, 2022 at 9:55 AM <ira.weiny@intel.com> wrote:
> >
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > Users of devmap pages should not have to know that the pages they are
> > operating on are special.
> 
> How about get straight to the point without any ambiguous references:
> 
> Today, kmap_{local_page,atomic} handles granting access to HIGHMEM
> pages without the caller needing to know if the page is HIGHMEM, or
> not. Use that existing infrastructure to grant access to PKS/PGMAP
> access protected pages.

This sounds better.  Thanks.

> 
> > Co-opt the kmap_{local_page,atomic}() to mediate access to PKS protected
> > pages via the devmap facility.  kmap_{local_page,atomic}() are both
> > thread local mappings so they work well with the thread specific
> > protections available.
> >
> > kmap(), on the other hand, allows for global mappings to be established,
> > Which is incompatible with the underlying PKS facility.
> 
> Why is kmap incompatible with PKS? I know why, but this is a claim
> without evidence. If you documented that in a previous patch, there's
> no harm and copying and pasting into this one. A future git log user
> will thank you for not making them go to lore to try to find the one
> patch with the  details.

Good point.

> Extra credit for creating a PKS theory of
> operation document with this detail, unless I missed that?

Well...  I've documented and mentioned the thread-local'ness of PKS a lot but
I'm pretty close to all of this so it is hard for me to remember where and to
what degree that is documented.  I've already reworked the PKS documentation a
bit.  So I'll review that.

> 
> > For this reason
> > kmap() is not supported.  Rather than leave the kmap mappings to fault
> > at random times when users may access them,
> 
> Is that a problem?

No.

> This instrumentation is also insufficient for
> legitimate usages of page_address().

True.  Although with this protection those access' are no longer legitimate.
And it sounds like it may be worth putting a call in page_address() as well.

> Might as well rely on the kernel
> developer community being able to debug PKS WARN() splats back to the
> source because that will need to be done regardless, given kmap() is
> not the only source of false positive access violations.

I disagree but I'm happy to drop pgmap_protection_flag_invalid() if that is the
consensus.

The reason I disagree is that it is generally better to catch errors early
rather than later.  Furthermore, this does not change the permissions.  Which
means the actual invalid access will also get flagged at the point of use.
This allows more debugging information for the user.

Do you feel that strongly about removing pgmap_protection_flag_invalid()?

> 
> > call
> > pgmap_protection_flag_invalid() to show kmap() users the call stack of
> > where mapping was created.  This allows better debugging.
> >
> > This behavior is safe because neither of the 2 current DAX-capable
> > filesystems (ext4 and xfs) perform such global mappings.  And known
> > device drivers that would handle devmap pages are not using kmap().  Any
> > future filesystems that gain DAX support, or device drivers wanting to
> > support devmap protected pages will need to use kmap_local_page().
> >
> > Direct-map exposure is already mitigated by default on HIGHMEM systems
> > because by definition HIGHMEM systems do not have large capacities of
> > memory in the direct map.  And using kmap in those systems actually
> > creates a separate mapping.  Therefore, to reduce complexity HIGHMEM
> > systems are not supported.
> 
> It was only at the end of this paragraph did I understand why I was
> reading this paragraph. The change in topic was buried. I.e.
> 
> ---
> 
> Note: HIGHMEM support is mutually exclusive with PGMAP protection. The
> rationale is mainly to reduce complexity, but also because direct-map
> exposure is already mitigated by default on HIGHMEM systems  because
> by definition HIGHMEM systems do not have large capacities of memory
> in the direct map...

Sounds good.  Sorry about not being clear.

> 
> ---
> 
> That note and related change should probably go in the same patch that
> introduces CONFIG_DEVMAP_ACCESS_PROTECTION in the first place. It's an
> unrelated change to instrumenting kmap() to fail early, which again I
> don't think is strictly necessary.

I'm not sure about this.

Unfortunately I have not made the point of this patch clear.  This patch
is co-opting the highmem interface [kmap(), kmap_atomic(), and
kmap_local_page()] to support PKS protected mappings.

The global nature of the kmap() call is not supported and is special cased.
HIGHMEM systems are also not supported and special cased.

I'll try and clarify this in V9.

Ira

> 
> >
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Dave Hansen <dave.hansen@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> >
> > ---
> > Changes for V8
> >         Reword commit message
> > ---
> >  include/linux/highmem-internal.h | 5 +++++
> >  mm/Kconfig                       | 1 +
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
> > index 0a0b2b09b1b8..1a006558734c 100644
> > --- a/include/linux/highmem-internal.h
> > +++ b/include/linux/highmem-internal.h
> > @@ -159,6 +159,7 @@ static inline struct page *kmap_to_page(void *addr)
> >  static inline void *kmap(struct page *page)
> >  {
> >         might_sleep();
> > +       pgmap_protection_flag_invalid(page);
> >         return page_address(page);
> >  }
> >
> > @@ -174,6 +175,7 @@ static inline void kunmap(struct page *page)
> >
> >  static inline void *kmap_local_page(struct page *page)
> >  {
> > +       pgmap_mk_readwrite(page);
> >         return page_address(page);
> >  }
> >
> > @@ -197,6 +199,7 @@ static inline void __kunmap_local(void *addr)
> >  #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
> >         kunmap_flush_on_unmap(addr);
> >  #endif
> > +       pgmap_mk_noaccess(kmap_to_page(addr));
> >  }
> >
> >  static inline void *kmap_atomic(struct page *page)
> > @@ -206,6 +209,7 @@ static inline void *kmap_atomic(struct page *page)
> >         else
> >                 preempt_disable();
> >         pagefault_disable();
> > +       pgmap_mk_readwrite(page);
> >         return page_address(page);
> >  }
> >
> > @@ -224,6 +228,7 @@ static inline void __kunmap_atomic(void *addr)
> >  #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
> >         kunmap_flush_on_unmap(addr);
> >  #endif
> > +       pgmap_mk_noaccess(kmap_to_page(addr));
> >         pagefault_enable();
> >         if (IS_ENABLED(CONFIG_PREEMPT_RT))
> >                 migrate_enable();
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 67e0264acf7d..d537679448ae 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -779,6 +779,7 @@ config ZONE_DEVICE
> >  config DEVMAP_ACCESS_PROTECTION
> >         bool "Access protection for memremap_pages()"
> >         depends on NVDIMM_PFN
> > +       depends on !HIGHMEM
> >         depends on ARCH_HAS_SUPERVISOR_PKEYS
> >         select ARCH_ENABLE_SUPERVISOR_PKEYS
> >         default y
> > --
> > 2.31.1
> >
