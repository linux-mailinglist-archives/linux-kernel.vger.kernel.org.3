Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E0F4C0452
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 23:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235968AbiBVWGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 17:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiBVWGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 17:06:09 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195982980D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 14:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645567543; x=1677103543;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zxDF6HeUMvOYrIjXmnqNecEiD08WjMI9/PEHYcz/Uc8=;
  b=I6GiJIZEvEOZZsZld5FRgLODUcYQxZqAGUD6AnqQNuwYT3CTMy3hnZsl
   BOQa96pyAka5I74ihktosM/Pz6DOWtFmkfApnU1TST/wu2ZPZEqkireDr
   2moZc06Qd/hvFXUf8H2ErXeDx/4JLTOezJQiZzbN2mJDd3/PZPhL/QK26
   F0jQvn8sRLQSRFhJhIiCd3dyOHui/Mb1Tz0nbWl7TacoYDSh+BjTJJHn4
   RWHWGQ5+n/kNj7tgrrGDxte096onfRDtcLy/qLp7J2g38RTIYhtj59/gB
   SIk6J4olrMCPfDIpWXSe1v/ZUXhD/8N0RwpaIbUqufPKegGYkQ/44GI11
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="250650671"
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="250650671"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 14:05:42 -0800
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="543099817"
Received: from psillosx-mobl.amr.corp.intel.com (HELO localhost) ([10.134.65.119])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 14:05:42 -0800
Date:   Tue, 22 Feb 2022 14:05:42 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 38/44] memremap_pages: Define
 pgmap_mk_{readwrite|noaccess}() calls
Message-ID: <YhVeNunIve9s2cwn@iweiny-desk3>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-39-ira.weiny@intel.com>
 <CAPcyv4iYOGD2XpmO3RH+wViuXx8EYrq-BK7vuKv6we+KR60YCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iYOGD2XpmO3RH+wViuXx8EYrq-BK7vuKv6we+KR60YCg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 10:35:59AM -0800, Dan Williams wrote:
> On Thu, Jan 27, 2022 at 9:55 AM <ira.weiny@intel.com> wrote:
> >
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > Users will need a way to flag valid access to pages which have been
> > protected with PGMAP protections.  Provide this by defining pgmap_mk_*()
> > accessor functions.
> 
> I find the ambiguous use of "Users" not helpful to set the context. How about:
> 
> A thread that wants to access memory protected by PGMAP protections
> must first enable access, and then disable access when it is done.
> 
> >
> > pgmap_mk_{readwrite|noaccess}() take a struct page for convenience.
> > They determine if the page is protected by dev_pagemap protections.  If
> > so, they perform the requested operation.
> >
> > In addition, the lower level __pgmap_* functions are exported.  They
> > take the dev_pagemap object directly for internal users who have
> > knowledge of the of the dev_pagemap.
> >
> > All changes in the protections must be through the above calls.  They
> > abstract the protection implementation (currently the PKS api) from the
> > upper layer users.
> >
> > Furthermore, the calls are nestable by the use of a per task reference
> > count.  This ensures that the first call to re-enable protection does
> > not 'break' the last access of the device memory.
> >
> > Access to device memory during exceptions (#PF) is expected only from
> > user faults.  Therefore there is no need to maintain the reference count
> > when entering or exiting exceptions.  However, reference counting will
> > occur during the exception.  Recall that protection is automatically
> > enabled during exceptions by the PKS core.[1]
> >
> > NOTE: It is not anticipated that any code paths will directly nest these
> > calls.  For this reason multiple reviewers, including Dan and Thomas,
> > asked why this reference counting was needed at this level rather than
> > in a higher level call such as kmap_{atomic,local_page}().  The reason
> > is that pgmap_mk_readwrite() could nest with regards to other callers of
> > pgmap_mk_*() such as kmap_{atomic,local_page}().  Therefore push this
> > reference counting to the lower level and just ensure that these calls
> > are nestable.
> 
> I still don't think that explains why task struct has a role to play
> here, see below.
> 
> Another missing bit of clarification, maybe I missed it, is why are
> the protections toggled between read-write and noaccess. For
> stray-write protection toggling between read-write and read-only is
> sufficient. I can imagine speculative execution and debug rationales
> for noaccess, but those should be called out explicitly.
> 

I'll clarify in the commit message but it is very simply providing consistent
behavior for kmap'ing a page before and after this series.  kmap's allows for
both read and write access.

I know it was discussed to introduce the complexity of different mappings for
read vs write.  But I think that is something which could be added later rather
than being a requirement of this series.

[snip]

> 
> The naming, which I had a hand in, is not aging well. When I see "mk"
> I expect it to be building some value like a page table entry that
> will be installed later. These helpers are directly enabling and
> disabling access and are meant to be called symmetrically. So I would
> expect symmetric names like:
> 
> pgmap_enable_access()
> pgmap_disable_access()

For this Dave requested s/pks_mk_*/pks_set_*/.  So I've followed that
convention here.  New names are pgmap_set_*().  Although I'm not sure I'm happy
with that name now...

Enable may sound better but we had used 'enable_access' before and it got all
confusing for some reason...  :-/

pgmap_set_noaccess()
pgmap_set_readwrite()

Seems good I think.

Ira
