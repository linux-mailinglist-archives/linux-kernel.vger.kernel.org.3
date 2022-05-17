Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DB552A930
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 19:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351470AbiEQR0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 13:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351529AbiEQR0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 13:26:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81D027FC8
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 10:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652808393; x=1684344393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iRXhC22uu9RZQXmrMy9WWKSs6bsrvvpYjaA9TfYfJGQ=;
  b=OUKczpx6kTmV7WRbfE+HGqhoF9Uwa3awKw5HfR7Fc/lJtf0wdNuD7Hov
   hro2NBXOA7UzUa7vxUjn2w9OQ15fFPdbDf0U6saIJaIrAvIaceuIXIJKB
   wQLGCz60rNyYfRPCS35p1heYDRZYFo9wM7e/otSNsIbvm4ZaLzhgfk9Y4
   U3yF8E0shZXSym0Jz8RwWipxGJI/BV/EZY6VlH1CkWCxVm2tjaGDAPtbM
   +m7bChzmiJcUGnDpO0fkR1ONO3YCPBh/wlBveBaP46I8HO8PZNhxvFd84
   /1coQUZh6kjiDrEvoczPSqYP4jVc/Y8MlYGiy73+Mw/wL7bucdH3bncYW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="251156869"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="251156869"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 10:26:33 -0700
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="672957331"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 10:26:33 -0700
Date:   Tue, 17 May 2022 10:27:00 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org, babu.moger@amd.com, x86@kernel.org
Subject: Re: [PATCH v2] x86/resctrl: Fix zero cbm for AMD in cbm_validate
Message-ID: <YoPa5L2jNYl/sFhw@fyu1.sc.intel.com>
References: <20220517001234.3137157-1-eranian@google.com>
 <YoPOWC0waMuSlvI6@fyu1.sc.intel.com>
 <5a634c10-103e-6f3e-e51b-db26b2bc90a5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a634c10-103e-6f3e-e51b-db26b2bc90a5@intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Reinette,

On Tue, May 17, 2022 at 09:49:22AM -0700, Reinette Chatre wrote:
> Hi Fenghua,
> 
> On 5/17/2022 9:33 AM, Fenghua Yu wrote:
> > Hi, Eranian,
> > 
> > On Mon, May 16, 2022 at 05:12:34PM -0700, Stephane Eranian wrote:
> >> AMD supports cbm with no bits set as reflected in rdt_init_res_defs_amd() by:
> > ...
> >> @@ -107,6 +107,10 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
> >>  	first_bit = find_first_bit(&val, cbm_len);
> >>  	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
> >>  
> >> +	/* no need to check bits if arch supports no bits set */
> >> +	if (r->cache.arch_has_empty_bitmaps && val == 0)
> >> +		goto done;
> >> +
> >>  	/* Are non-contiguous bitmaps allowed? */
> >>  	if (!r->cache.arch_has_sparse_bitmaps &&
> >>  	    (find_next_bit(&val, cbm_len, zero_bit) < cbm_len)) {
> >> @@ -119,7 +123,7 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
> >>  				    r->cache.min_cbm_bits);
> >>  		return false;
> >>  	}
> >> -
> >> +done:
> >>  	*data = val;
> >>  	return true;
> >>  }
> > 
> > Isn't it AMD supports 0 minimal CBM bits? Then should set its min_cbm_bits as 0.
> > Is the following patch a better fix? I don't have AMD machine and cannot
> > test the patch.
> > 
> > diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> > index 6055d05af4cc..031d77dd982d 100644
> > --- a/arch/x86/kernel/cpu/resctrl/core.c
> > +++ b/arch/x86/kernel/cpu/resctrl/core.c
> > @@ -909,6 +909,7 @@ static __init void rdt_init_res_defs_amd(void)
> >  			r->cache.arch_has_sparse_bitmaps = true;
> >  			r->cache.arch_has_empty_bitmaps = true;
> >  			r->cache.arch_has_per_cpu_cfg = true;
> > +			r->cache.min_cbm_bits = 0;
> >  		} else if (r->rid == RDT_RESOURCE_MBA) {
> >  			hw_res->msr_base = MSR_IA32_MBA_BW_BASE;
> >  			hw_res->msr_update = mba_wrmsr_amd;
> 
> That is actually what Stephane's V1 [1] did and I proposed that
> he fixes it with (almost) what he has in V2 (I think the check
> can be moved earlier before any bits are searched for).
> 
> The reasons why I proposed this change are:
> - min_cbm_bits is a value that is exposed to user space and from the
>   time AMD was supported this has always been 1 for those systems. I
>   do not know how user space uses this value and unless I can be certain
>   making this 0 will not affect user space I would prefer not to
>   make such a change.

But a user visible mismatch is created by the V2 patch:
User queries min_cbm_bits and finds it is 1 but turns out 0 can be written
to the schemata.

Is it an acceptable behavior? Shouldn't user read right min_cbm_bits (0)
on AMD?

Without the V2 patch, at least min_cbm_bits and writing to the schemata
are matched: only 1 about above bits can be searched and written.

By setting min_cbm_bits=0, it reflects the right value and user can see
the value as 0 and set schemata as 0 as well. Seems all match each other.

> - this fix restores original behavior that was changed in the patch noted
>   in the Fixes link.
> 
> - this fix itself relies on math on error returns of bit checking on an empty
>   bitmap. I find that hides what the code does and this fix is more obvious.
>   You can see this feedback in my response to V1. 
> 
> - a fix like the above snippet is incomplete. To be appropriate 
>   the initialization of rdt_resources_all[] needs to be changed to
>   not initialize min_cbm_bits anymore and move the platform specific bits
>   to rdt_init_res_defs_amd() and rdt_init_res_defs_intel() respectively.

Maybe that's better.

> 
> 
> Reinette
> 
> [1] https://lore.kernel.org/lkml/20220516055055.2734840-1-eranian@google.com/

Thanks.

-Fenghua
