Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA7852C08A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240367AbiERQg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 12:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240526AbiERQga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:36:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C84D205C6
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 09:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652891789; x=1684427789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nfxk6QHzxTv2778lb7oSutOL+8TQsowLGTPneGlEfdk=;
  b=np1D3I2P8vPJU91+uO9KSc4MtyVPqitXnHHMGgUq8J2YNJtiNhCsG/az
   U2h2bSUBA1yodBowRjvDP+uNsPSOErfwk8CmHZQvopOYQ0j7/KlvjWA2n
   hIut5T+YIfTNArKd61QCMFxbWNjNfo1qh2fi6i53xP0R4SiS360GIT+bi
   jSTdtuHdGxbeKmQLxaH3pfdWQEjRlcb0gV1CJFuPWO0Qrn8Wjs8saQNWV
   bjMt1wawr4/pIubll45Vk5mHBtWIQLH7TUoHAEsg4T0TAcuCl1fBdzdbm
   coYv7AcLkvCiD+P11+imZ0K4c9CJTjLbtGqXBf4RTgGUy97iNwjpAJnhE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="259332717"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="259332717"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 09:34:21 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="605971356"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 09:34:21 -0700
Date:   Wed, 18 May 2022 09:34:48 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org, babu.moger@amd.com, x86@kernel.org
Subject: Re: [PATCH v2] x86/resctrl: Fix zero cbm for AMD in cbm_validate
Message-ID: <YoUgKB5svdI/blZa@fyu1.sc.intel.com>
References: <20220517001234.3137157-1-eranian@google.com>
 <YoPOWC0waMuSlvI6@fyu1.sc.intel.com>
 <5a634c10-103e-6f3e-e51b-db26b2bc90a5@intel.com>
 <YoPa5L2jNYl/sFhw@fyu1.sc.intel.com>
 <0077efdf-ab64-2924-c290-cd940977b818@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0077efdf-ab64-2924-c290-cd940977b818@intel.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Babu,

On Tue, May 17, 2022 at 11:10:40AM -0700, Reinette Chatre wrote:
> On 5/17/2022 10:27 AM, Fenghua Yu wrote:
> > On Tue, May 17, 2022 at 09:49:22AM -0700, Reinette Chatre wrote:
> >> On 5/17/2022 9:33 AM, Fenghua Yu wrote:
> >>> On Mon, May 16, 2022 at 05:12:34PM -0700, Stephane Eranian wrote:
> >>>> AMD supports cbm with no bits set as reflected in rdt_init_res_defs_amd() by:
> >>> ...
> >>>> @@ -107,6 +107,10 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
> >>>>  	first_bit = find_first_bit(&val, cbm_len);
> >>>>  	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
> >>>>  
> >>>> +	/* no need to check bits if arch supports no bits set */
> >>>> +	if (r->cache.arch_has_empty_bitmaps && val == 0)
> >>>> +		goto done;
> >>>> +
> >>>>  	/* Are non-contiguous bitmaps allowed? */
> >>>>  	if (!r->cache.arch_has_sparse_bitmaps &&
> >>>>  	    (find_next_bit(&val, cbm_len, zero_bit) < cbm_len)) {
> >>>> @@ -119,7 +123,7 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
> >>>>  				    r->cache.min_cbm_bits);
> >>>>  		return false;
> >>>>  	}
> >>>> -
> >>>> +done:
> >>>>  	*data = val;
> >>>>  	return true;
> >>>>  }
> >>>
> >>> Isn't it AMD supports 0 minimal CBM bits? Then should set its min_cbm_bits as 0.
> >>> Is the following patch a better fix? I don't have AMD machine and cannot
> >>> test the patch.
> >>>
> >>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> >>> index 6055d05af4cc..031d77dd982d 100644
> >>> --- a/arch/x86/kernel/cpu/resctrl/core.c
> >>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> >>> @@ -909,6 +909,7 @@ static __init void rdt_init_res_defs_amd(void)
> >>>  			r->cache.arch_has_sparse_bitmaps = true;
> >>>  			r->cache.arch_has_empty_bitmaps = true;
> >>>  			r->cache.arch_has_per_cpu_cfg = true;
> >>> +			r->cache.min_cbm_bits = 0;
> >>>  		} else if (r->rid == RDT_RESOURCE_MBA) {
> >>>  			hw_res->msr_base = MSR_IA32_MBA_BW_BASE;
> >>>  			hw_res->msr_update = mba_wrmsr_amd;
> >>
> >> That is actually what Stephane's V1 [1] did and I proposed that
> >> he fixes it with (almost) what he has in V2 (I think the check
> >> can be moved earlier before any bits are searched for).
> >>
> >> The reasons why I proposed this change are:
> >> - min_cbm_bits is a value that is exposed to user space and from the
> >>   time AMD was supported this has always been 1 for those systems. I
> >>   do not know how user space uses this value and unless I can be certain
> >>   making this 0 will not affect user space I would prefer not to
> >>   make such a change.
> > 
> > But a user visible mismatch is created by the V2 patch:
> 
> No. V2 does not create a user visible change, it restores original behavior.
> 
> > User queries min_cbm_bits and finds it is 1 but turns out 0 can be written
> > to the schemata.
> > 
> > Is it an acceptable behavior? Shouldn't user read right min_cbm_bits (0)
> > on AMD?
> 
> Original AMD enabling set min_cbm_bits as 1 while also supporting 0 to
> be written to schemata file. Supporting 0 to be written to schemata file
> was unintentionally broken during one of the MPAM prep patches. This
> patch fixes that.
> 
> You are proposing a change to original AMD support that impacts user
> space API while I find fixing to restore original behavior to
> be the safest option. Perhaps Babu could pick the preferred solution
> and I would step aside if you prefer to go with (an improved) V1.

Is it OK for you to set min_cbm_bits to 0 on AMD?

Thanks.

-Fenghua
