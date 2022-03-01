Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A2B4C8F7F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbiCAP50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbiCAP5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:57:17 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9776620C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 07:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646150196; x=1677686196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wkVALN3/qIQqFwnPf+wRUxVnXrAa2lYmcDvBiJAO14c=;
  b=igJDhxDQqAzK3qptF/0dY1Hu1R61bGSPKOFYGb9VGDe1WQkKRrvZ/3gj
   j7VDd/vbGSev4ZJ4PsSBiaNMRmHYtmOVxphmOhhjQcIjICcreRFTP9k72
   IVfO9/vc+rMaPWIU3DXuOMQ0uRjpiINYLOkwzt48Cu7PaROVVZsHxGmVY
   fVXjN/tpqZimWt4dK/9AkEB/QVeLrD/9EYzXOhfpYNop/Wp/1RuRiMuUI
   feRbsWf1ztxSxJ1/40Iy1+cycOBchmfwA1aambuwAwbeN0QgLVtSsiNnb
   GmrOux8xPXli8Fk3vi5VZBral8vwkxp43TuFkXgW57bgWbKiXKN6efP6R
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="251989783"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="251989783"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 07:56:36 -0800
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="778493375"
Received: from bklinvil-mobl.amr.corp.intel.com (HELO localhost) ([10.212.48.220])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 07:56:31 -0800
Date:   Tue, 1 Mar 2022 07:56:30 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 33/44] memremap_pages: Introduce
 pgmap_protection_available()
Message-ID: <Yh5CLkGeN7dlLxtr@iweiny-desk3>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-34-ira.weiny@intel.com>
 <CAPcyv4gWcs5u1vRMjzQwJque98u_6MPTWKOFb6XS273egyiXHA@mail.gmail.com>
 <Yhz/gK9K6KtON0bq@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yhz/gK9K6KtON0bq@iweiny-desk3>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 08:59:44AM -0800, Ira Weiny wrote:
> On Fri, Feb 04, 2022 at 08:19:43AM -0800, Dan Williams wrote:
> > On Thu, Jan 27, 2022 at 9:55 AM <ira.weiny@intel.com> wrote:
> 
> [snip]
> 
> > > @@ -63,6 +64,16 @@ static void devmap_managed_enable_put(struct dev_pagemap *pgmap)
> > >  }
> > >  #endif /* CONFIG_DEV_PAGEMAP_OPS */
> > >
> > > +#ifdef CONFIG_DEVMAP_ACCESS_PROTECTION
> > > +
> > > +bool pgmap_protection_available(void)
> > > +{
> > > +       return pks_available();
> > > +}
> > > +EXPORT_SYMBOL_GPL(pgmap_protection_available);
> > 
> > Any reason this was chosen to be an out-of-line function? Doesn't this
> > defeat the performance advantages of static_cpu_has()?
> 
> Unfortunately, yes.  pkeys.h includes mm.h which means I can't include pkeys.h
> here in mm.h.
> 
> Let me see what I can do.  In patch 11 I created pks-keys.h.  Let me see if I
> can leverage that header instead of pkeys.h.
> 
> When I created that header I was thinking that the user and supervisor pkey
> functions may need even more separation in the headers but I was fearful of
> putting too much in pks-keys.h because it was created to avoid conflicts in
> asm/processor.h.  Looking at it again I think pks_available() may be ok in
> pks-keys.h.

Ok I've reworked the series to allow for this.  However, pks-keys.h was not
sufficient.  That header needs to be specific to the definition of the keys
themselves (hence the name).

In order to facilitate this change I've introduced another header linux/pks.h
which separates out the supervisor specific calls from the user pkeys calls.
It worked out well and I think makes a lot of sense due to the different
functionality.  But I'm pretty bad at names so I'm open to changing the name of
the header if 'pks.h' seems too generic.

Ira

> 
> Ira
> 
> > 
> > > +
> > > +#endif /* CONFIG_DEVMAP_ACCESS_PROTECTION */
> > > +
> > >  static void pgmap_array_delete(struct range *range)
> > >  {
> > >         xa_store_range(&pgmap_array, PHYS_PFN(range->start), PHYS_PFN(range->end),
> > > --
> > > 2.31.1
> > >
