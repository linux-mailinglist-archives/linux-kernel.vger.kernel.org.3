Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7744A7962
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347089AbiBBU3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:29:01 -0500
Received: from mga06.intel.com ([134.134.136.31]:52092 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230454AbiBBU3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643833740; x=1675369740;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cnivvfzPDK1DJG2SQjROrdLQJyE7Pv+qUsJesn380xI=;
  b=Fl0QecceTA1xTXNjuXG7X+Cg4Cn5qLzgv9puP35SXRuXW2Uo3kbBHXsq
   zN6FqKL8ggQlGYDl9Etj3z1pCEbe2VT7T/Lc4sisEXgK45i6oQUTED1xJ
   1eEVfqaejeurrOs42kJxaUO1C5uZli0XaoDKMcdO5WHeWPcHqP8lnhBDz
   MKXNUDIOVh3Lf9n6p+wiC9VOgbxoV144ZsA9RhIveKCwqzqS7b4HLHpD1
   d0Oo2jCwHlXjzGTE6/t0LsZefQMxDP84ttw1IP++L0rzM2Oa2VkDzmhg4
   JPmLwqWCerkThmar+HWg3GD6ju1pC+vLs33hWWEQtp3e4r/aXpNtDIN8U
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="308742904"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="308742904"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 12:28:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="676564333"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 12:28:59 -0800
Date:   Wed, 2 Feb 2022 12:28:59 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 04/44] x86/pkeys: Add additional PKEY helper macros
Message-ID: <20220202202859.GW785175@iweiny-DESK2.sc.intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-5-ira.weiny@intel.com>
 <8967ea5a-99bf-8990-6ee1-8e0d32031f16@intel.com>
 <20220202202159.GU785175@iweiny-DESK2.sc.intel.com>
 <eff862e2-bfaa-9e12-42b5-a12467d72a22@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eff862e2-bfaa-9e12-42b5-a12467d72a22@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 12:26:44PM -0800, Dave Hansen wrote:
> On 2/2/22 12:21, Ira Weiny wrote:
> > On Fri, Jan 28, 2022 at 02:47:30PM -0800, Dave Hansen wrote:
> >> #define PKR_WD_MASK(pkey)	(PKR_WD_BIT << PKR_PKEY_SHIFT(pkey))
> >>
> >> Which says, "generate a write-disabled mask for this pkey".
> > 
> > I think the confusion comes from me having used these as mask values rather
> > than what PKR_AD_KEY() was intended to be used for.
> > 
> > In the previous patch PKR_AD_KEY() is used to set up the default user pkey
> > value...
> > 
> > u32 init_pkru_value = PKR_AD_KEY( 1) | PKR_AD_KEY( 2) | PKR_AD_KEY( 3) |
> > 		      PKR_AD_KEY( 4) | PKR_AD_KEY( 5) | PKR_AD_KEY( 6) |
> > 		      PKR_AD_KEY( 7) | PKR_AD_KEY( 8) | PKR_AD_KEY( 9) |
> > 		      PKR_AD_KEY(10) | PKR_AD_KEY(11) | PKR_AD_KEY(12) |
> > 		      PKR_AD_KEY(13) | PKR_AD_KEY(14) | PKR_AD_KEY(15);
> > 
> 
> Hah, I'm complaining about my own code.
> 
> > u32 init_pkru_value = PKR_AD_MASK( 1) | PKR_AD_MASK( 2) | PKR_AD_MASK( 3) |
> > 		      PKR_AD_MASK( 4) | PKR_AD_MASK( 5) | PKR_AD_MASK( 6) |
> > 		      PKR_AD_MASK( 7) | PKR_AD_MASK( 8) | PKR_AD_MASK( 9) |
> > 		      PKR_AD_MASK(10) | PKR_AD_MASK(11) | PKR_AD_MASK(12) |
> > 		      PKR_AD_MASK(13) | PKR_AD_MASK(14) | PKR_AD_MASK(15);
> > 
> > It seems odd to me.  Does it seem odd to you?
> 
> Looks OK to me.  It's build a "value" out of a bunch of individual masks.
> 
> > Looking at the final code I think I'm going to just drop the usages in this
> > patch and add PKR_WD_KEY() where it is used first.
> > 
> > Also, how about PKR_KEY_INIT_{AD|WD|RW}() as a name?
> 
> For the PKR_AD_KEY() macro?

Yes if I drop this patch then the only place these are used is to initialize
the registers.

Ira

