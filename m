Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29584C720F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237696AbiB1RA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 12:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbiB1RAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:00:24 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9409F85BCD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646067585; x=1677603585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mt8s7io4bRnq3KbQhdcgmNlPex7ZeHertn8F1Onb4+0=;
  b=LxiqcWQg596AJudHJOYS3Iqi/GULvOV0zbcmfNnSym9O6mdSZ9FyF35+
   0tcyIf1jYpeO2JBoDwqUkfwCIC0ybJD0qLOgF7YL/QVHeLsR1vBTfAbG0
   GrGQGg/PThDZTPMzRCzQd1Q8E6AWEGGjde0s9coOVgQim2WpVMCyzpmab
   o2wYjcc7Rpd48JxGnDn1wMstx31jhNibw9MKU5VTYzF+w/uWfv/GLKl6E
   jze4xVo7ssJhPMsMplOZEZkD5MD84qe61gEhEN1wI+lk673pPZ8wgW9jk
   JGKhnzs8tkNIcNpku6ea4kK87GOjC/s5hf/2x3piwTRFit8kVTJQwIXv3
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="277589402"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="277589402"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 08:59:45 -0800
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="608512605"
Received: from chunhanz-mobl.amr.corp.intel.com (HELO localhost) ([10.212.29.175])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 08:59:44 -0800
Date:   Mon, 28 Feb 2022 08:59:44 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 33/44] memremap_pages: Introduce
 pgmap_protection_available()
Message-ID: <Yhz/gK9K6KtON0bq@iweiny-desk3>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-34-ira.weiny@intel.com>
 <CAPcyv4gWcs5u1vRMjzQwJque98u_6MPTWKOFb6XS273egyiXHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gWcs5u1vRMjzQwJque98u_6MPTWKOFb6XS273egyiXHA@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 08:19:43AM -0800, Dan Williams wrote:
> On Thu, Jan 27, 2022 at 9:55 AM <ira.weiny@intel.com> wrote:

[snip]

> > @@ -63,6 +64,16 @@ static void devmap_managed_enable_put(struct dev_pagemap *pgmap)
> >  }
> >  #endif /* CONFIG_DEV_PAGEMAP_OPS */
> >
> > +#ifdef CONFIG_DEVMAP_ACCESS_PROTECTION
> > +
> > +bool pgmap_protection_available(void)
> > +{
> > +       return pks_available();
> > +}
> > +EXPORT_SYMBOL_GPL(pgmap_protection_available);
> 
> Any reason this was chosen to be an out-of-line function? Doesn't this
> defeat the performance advantages of static_cpu_has()?

Unfortunately, yes.  pkeys.h includes mm.h which means I can't include pkeys.h
here in mm.h.

Let me see what I can do.  In patch 11 I created pks-keys.h.  Let me see if I
can leverage that header instead of pkeys.h.

When I created that header I was thinking that the user and supervisor pkey
functions may need even more separation in the headers but I was fearful of
putting too much in pks-keys.h because it was created to avoid conflicts in
asm/processor.h.  Looking at it again I think pks_available() may be ok in
pks-keys.h.

Ira

> 
> > +
> > +#endif /* CONFIG_DEVMAP_ACCESS_PROTECTION */
> > +
> >  static void pgmap_array_delete(struct range *range)
> >  {
> >         xa_store_range(&pgmap_array, PHYS_PFN(range->start), PHYS_PFN(range->end),
> > --
> > 2.31.1
> >
