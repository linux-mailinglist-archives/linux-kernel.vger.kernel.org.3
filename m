Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072794C92A3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 19:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236858AbiCASOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 13:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235929AbiCASOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:14:33 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B327A24BDA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 10:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646158432; x=1677694432;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eyJL07c9fgvnRU+ZPSiuOTMVvgv6cbmEG2Rg/8bgmzU=;
  b=dvJt3JmuexlpQCckiJaJytkxILOkEuKmFGjcREw3K5uD/mpq314Oj/R9
   DOxZndLmKPNXrlzvw4nGlI1yguHXFfzTJ3tekXzZ0A8VermW04JF/UV/i
   8lTQbdDMJuoUZa4Vvj9GQmm6N/CnRc2bMLyPkevOBSaxK3n3AgNjITaMp
   lv0CVYZxYsJLBDhayBLS715RrhTmWEHiUFGBYwvCC17xggp0IAAyY/cH/
   6sAiZGmuD0kz0qNYW/QpxSWBz86/yunVIM64WpMOD/uncMZitxoQqlNMF
   5bnPVgdRceoJyu96OY42ge3za/MmHAkaXbVaJE3UpST77aGF9Zqbdp/p3
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="252937935"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="252937935"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 10:13:52 -0800
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="535003514"
Received: from bklinvil-mobl.amr.corp.intel.com (HELO localhost) ([10.212.48.220])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 10:13:52 -0800
Date:   Tue, 1 Mar 2022 10:13:51 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 42/44] dax: Stray access protection for
 dax_direct_access()
Message-ID: <Yh5iX0WEKrwCg3/H@iweiny-desk3>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-43-ira.weiny@intel.com>
 <CAPcyv4gDBnUQCe7BSWzccWGfcPZRza3PSBLqReBQgobSf09JGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gDBnUQCe7BSWzccWGfcPZRza3PSBLqReBQgobSf09JGA@mail.gmail.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 09:19:58PM -0800, Dan Williams wrote:
> On Thu, Jan 27, 2022 at 9:55 AM <ira.weiny@intel.com> wrote:
> >
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > dax_direct_access() provides a way to obtain the direct map address of
> > PMEM memory.  Coordinate PKS protection with dax_direct_access() of
> > protected devmap pages.
> >
> > Introduce 3 new dax_operation calls .map_protected .mk_readwrite and
> > .mk_noaccess. These 3 calls do not have to be implemented by the dax
> > provider if no protection is implemented.
> >
> > Threads of execution can use dax_mk_{readwrite,noaccess}() to relax the
> > protection of the dax device and allow direct use of the kaddr returned
> > from dax_direct_access().  The dax_mk_{readwrite,noaccess}() calls only
> > need to be used to guard actual access to the memory.  Other uses of
> > dax_direct_access() do not need to use these guards.
> >
> > For users who require a permanent address to the dax device such as the
> > DM write cache.  dax_map_protected() indicates that the dax device has
> > additional protections and that user should create it's own permanent
> > mapping of the memory.  Update the DM write cache code to create this
> > permanent mapping.
> >
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> [..]
> > diff --git a/include/linux/dax.h b/include/linux/dax.h
> > index 9fc5f99a0ae2..261af298f89f 100644
> > --- a/include/linux/dax.h
> > +++ b/include/linux/dax.h
> > @@ -30,6 +30,10 @@ struct dax_operations {
> >                         sector_t, sector_t);
> >         /* zero_page_range: required operation. Zero page range   */
> >         int (*zero_page_range)(struct dax_device *, pgoff_t, size_t);
> > +
> > +       bool (*map_protected)(struct dax_device *dax_dev);
> > +       void (*mk_readwrite)(struct dax_device *dax_dev);
> > +       void (*mk_noaccess)(struct dax_device *dax_dev);
> 
> So the dax code just recently jettisoned -the >copy_{to,from}_iter()
> ops and it would be shame to grow more ops. Given that the
> implementation is pgmap generic I think all that is needed is way to
> go from a daxdev to a pgmap and then use the pgmap helpers directly
> rather than indirecting through the pmem driver just to get the pgmap.

Ok done.

dax_device now has knowledge of the pgmap which was pretty clean.

Ira
