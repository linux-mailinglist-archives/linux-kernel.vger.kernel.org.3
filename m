Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AA14C98BF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 00:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbiCAXDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 18:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiCAXDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 18:03:53 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA8C4C7AD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 15:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646175791; x=1677711791;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ii8JBJeLg2PZQUVBI4MgCp2a7JXr5znlB/EJirm3SKc=;
  b=MazvfaFopk1Sg2py9/MaHLcBKJoJ9kCbjd53C0JnwafLcG42oHO975og
   awPPO907+46/EaKDTIe7gJPWWucp8cWM93p6kPy50vnvaRXjZ6nWvGKPL
   IWSKlCCZcHdWoHR9Wsa17zN3fVbqZ5i5jKiXlgwLYHjpDA2/mMhGCncaK
   nt0J5gsV1cHa0rGXu+yOYus1m39hFsfgiPqT/0BdU/1RP9mS7InX6rwwI
   bHTED2okv6XOt74vbPyUAwXJ9nbM8Sevj/B+9nqD5scp5iXNdlu3SRlTI
   T4KmQCPR4n4OrwXxswYO/GeVRiBaOiHR+stGD78M/0YM6nHouqGIe5R9C
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="316477355"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="316477355"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 15:03:10 -0800
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="641458346"
Received: from bklinvil-mobl.amr.corp.intel.com (HELO localhost) ([10.212.48.220])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 15:03:10 -0800
Date:   Tue, 1 Mar 2022 15:03:09 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 41/44] kmap: Ensure kmap works for devmap pages
Message-ID: <Yh6mLd8ORTcLx18A@iweiny-desk3>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-42-ira.weiny@intel.com>
 <CAPcyv4h1Q6H6_VApe3eFhEwe0McqbrFGRmy9rzFSPP0ATsTeTw@mail.gmail.com>
 <Yh535Zqe/GtuF/Xh@iweiny-desk3>
 <CAPcyv4g+Cbqk5bev8=SNz-8EwzofER0HrTzUiJ87ygdWSsXAiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4g+Cbqk5bev8=SNz-8EwzofER0HrTzUiJ87ygdWSsXAiA@mail.gmail.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 12:05:27PM -0800, Dan Williams wrote:
> On Tue, Mar 1, 2022 at 11:45 AM Ira Weiny <ira.weiny@intel.com> wrote:
> >
> > On Fri, Feb 04, 2022 at 01:07:10PM -0800, Dan Williams wrote:
> > > On Thu, Jan 27, 2022 at 9:55 AM <ira.weiny@intel.com> wrote:
> > > >
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > >
> > > > Users of devmap pages should not have to know that the pages they are
> > > > operating on are special.
> > >
> > > How about get straight to the point without any ambiguous references:
> > >
> > > Today, kmap_{local_page,atomic} handles granting access to HIGHMEM
> > > pages without the caller needing to know if the page is HIGHMEM, or
> > > not. Use that existing infrastructure to grant access to PKS/PGMAP
> > > access protected pages.
> >
> > This sounds better.  Thanks.
> >
> > >
> > > > Co-opt the kmap_{local_page,atomic}() to mediate access to PKS protected
> > > > pages via the devmap facility.  kmap_{local_page,atomic}() are both
> > > > thread local mappings so they work well with the thread specific
> > > > protections available.
> > > >
> > > > kmap(), on the other hand, allows for global mappings to be established,
> > > > Which is incompatible with the underlying PKS facility.
> > >
> > > Why is kmap incompatible with PKS? I know why, but this is a claim
> > > without evidence. If you documented that in a previous patch, there's
> > > no harm and copying and pasting into this one. A future git log user
> > > will thank you for not making them go to lore to try to find the one
> > > patch with the  details.
> >
> > Good point.
> >
> > > Extra credit for creating a PKS theory of
> > > operation document with this detail, unless I missed that?
> >
> > Well...  I've documented and mentioned the thread-local'ness of PKS a lot but
> > I'm pretty close to all of this so it is hard for me to remember where and to
> > what degree that is documented.  I've already reworked the PKS documentation a
> > bit.  So I'll review that.
> >
> > >
> > > > For this reason
> > > > kmap() is not supported.  Rather than leave the kmap mappings to fault
> > > > at random times when users may access them,
> > >
> > > Is that a problem?
> >
> > No.
> 
> What I meant was how random is random and is it distinguishable from
> direct page_address() usage where there is no explicit early failure
> path?

Ok you've convinced me.  I'll drop this.

> 
> >
> > > This instrumentation is also insufficient for
> > > legitimate usages of page_address().
> >
> > True.  Although with this protection those access' are no longer legitimate.
> > And it sounds like it may be worth putting a call in page_address() as well.
> >
> > > Might as well rely on the kernel
> > > developer community being able to debug PKS WARN() splats back to the
> > > source because that will need to be done regardless, given kmap() is
> > > not the only source of false positive access violations.
> >
> > I disagree but I'm happy to drop pgmap_protection_flag_invalid() if that is the
> > consensus.
> >
> > The reason I disagree is that it is generally better to catch errors early
> > rather than later.  Furthermore, this does not change the permissions.  Which
> > means the actual invalid access will also get flagged at the point of use.
> > This allows more debugging information for the user.
> >
> > Do you feel that strongly about removing pgmap_protection_flag_invalid()?
> 
> You haven't convinced me that it matters yet. Do you have an example
> of a kmap() pointer dereference PKS splat where it's not clear from
> the backtrace from the fault handler that a kmap path was involved?
> 
> At a minimum if it stays it seems like something that should be
> wrapped by VM_WARN_ON_ONCE_PAGE() like other page relative memory
> debugging extra checks that get disabled by CONFIG_DEBUG_VM, but the
> assertion that "early is better" needs evidence that "later is too
> ambiguous".

I'll drop this.  It is easier to just leave it out.

Ira
