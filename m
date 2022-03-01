Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDE54C92CA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 19:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbiCASTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 13:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiCASTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:19:35 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45BF1DA54
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 10:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646158733; x=1677694733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y7MLcmxs/qTtOX5+jon70+tyOS1su2n+mJJ5b6Y+P0M=;
  b=TBV6yS/E8rPXejOd0/MGR5zjDyDUrpV9BU1j9R2pl4VmPxpqFtV50FnR
   Dt2ZuVPxPLfZSfzcxYdhoJnU4coKSj+nQ1J+aHBwwaR/WunmJ34EvmVm0
   01fepCGUlN2BHc+QqaCz1zRDWMz159Et9WSwe/+1/2lGJUKUUrJGAbx3d
   Kj2vwOYnRnCgkpRCu4c6VMbovrcCSs/XIpPlOmLyfgeht5Lsq/Qm4+eFZ
   tp9jRPp95bgbvT2AgbygXtn8Bxuu0cKkU4lZPsgU3frMvQq5++7VVfp6D
   lAbqX1RH0UuPcgDbtqTxscsyFMaESkfPNVkLfYNgZI/dUCboTXpBMEcHm
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="253131715"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="253131715"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 10:18:53 -0800
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="575799440"
Received: from bklinvil-mobl.amr.corp.intel.com (HELO localhost) ([10.212.48.220])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 10:18:53 -0800
Date:   Tue, 1 Mar 2022 10:18:52 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 43/44] nvdimm/pmem: Enable stray access protection
Message-ID: <Yh5jjKMSNucV9J/D@iweiny-desk3>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-44-ira.weiny@intel.com>
 <CAPcyv4idgNDaxJfj2MZgJnuGyygFJ9ozvrEghSnsR7zXB=pj0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4idgNDaxJfj2MZgJnuGyygFJ9ozvrEghSnsR7zXB=pj0A@mail.gmail.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 01:10:53PM -0800, Dan Williams wrote:
> On Thu, Jan 27, 2022 at 9:55 AM <ira.weiny@intel.com> wrote:
> >
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > Now that all valid kernel access' to PMEM have been annotated with
> > {__}pgmap_mk_{readwrite,noaccess}() PGMAP_PROTECTION is safe to enable
> > in the pmem layer.
> >
> > Implement the pmem_map_protected() and pmem_mk_{readwrite,noaccess}() to
> > communicate this memory has extra protection to the upper layers if
> > PGMAP_PROTECTION is specified.
> >
> > Internally, the pmem driver uses a cached virtual address,
> > pmem->virt_addr (pmem_addr).  Use __pgmap_mk_{readwrite,noaccess}()
> > directly when PGMAP_PROTECTION is active on the device.
> >
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> >
> > ---
> > Changes for V8
> >         Rebase to 5.17-rc1
> >         Remove global param
> >         Add internal structure which uses the pmem device and pgmap
> >                 device directly in the *_mk_*() calls.
> >         Add pmem dax ops callbacks
> >         Use pgmap_protection_available()
> >         s/PGMAP_PKEY_PROTECT/PGMAP_PROTECTION
> > ---
> >  drivers/nvdimm/pmem.c | 52 ++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 51 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> > index 58d95242a836..2afff8157233 100644
> > --- a/drivers/nvdimm/pmem.c
> > +++ b/drivers/nvdimm/pmem.c
> > @@ -138,6 +138,18 @@ static blk_status_t read_pmem(struct page *page, unsigned int off,
> >         return BLK_STS_OK;
> >  }
> >
> > +static void __pmem_mk_readwrite(struct pmem_device *pmem)
> > +{
> > +       if (pmem->pgmap.flags & PGMAP_PROTECTION)
> > +               __pgmap_mk_readwrite(&pmem->pgmap);
> > +}
> > +
> > +static void __pmem_mk_noaccess(struct pmem_device *pmem)
> > +{
> > +       if (pmem->pgmap.flags & PGMAP_PROTECTION)
> > +               __pgmap_mk_noaccess(&pmem->pgmap);
> > +}
> > +
> 
> Per previous feedback let's find a way for the pmem driver to stay out
> of the loop, and just let these toggles by pgmap generic operations.

I want to clarify.  Yes the pmem driver is now out of the dax driver loop.
However, these calls must remain because the pmem driver caches pmem->virt_addr
and uses that address to access the maps directly.

Therefore these specific calls need to remain for the pmem drivers internal
use.  In addition to the commit message I've added comments to the call sites
to clarify this fact.

Ira
