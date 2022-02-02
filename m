Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036F34A7954
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347065AbiBBUWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:22:01 -0500
Received: from mga18.intel.com ([134.134.136.126]:18524 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230264AbiBBUWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:22:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643833320; x=1675369320;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RBLJAdtO15eXefuyOs8fnkGhxUD/MBEMGyuf6Js7lRk=;
  b=hPShXF0lstb7fmTEKm4/nUJTBDI00p3kvXiyNKUp6w0DYeJuo2ovcNJV
   gd1Q4B4SGqk4XO2tEizvl7IsKC9ZsUKuci9Qh46VF6XtotIh3hWzCsf0k
   9WhHfgvhOFfESmhN4E7GPhU4+ZqM0fpXd0gJMwelg9D7yAc1Id1y1Ejs3
   YLOtuXhYpswiTAFxvkN57ltc5T2T46h7vVfO31rqU20VyPa+Ww8Ljgppo
   MgteZGkRpc4qv3Oc3Z8B6yC7/O5fMcALp75LMuG62Z1dVKwYtrHBg2MV9
   xKMCoPwmlvBAfg0BbyiVf2WqTgaeLZ+qnSqSvNy3hZcvJtNAWF68HIvmv
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="231579816"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="231579816"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 12:21:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="538453563"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 12:21:59 -0800
Date:   Wed, 2 Feb 2022 12:21:59 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 04/44] x86/pkeys: Add additional PKEY helper macros
Message-ID: <20220202202159.GU785175@iweiny-DESK2.sc.intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-5-ira.weiny@intel.com>
 <8967ea5a-99bf-8990-6ee1-8e0d32031f16@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8967ea5a-99bf-8990-6ee1-8e0d32031f16@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 02:47:30PM -0800, Dave Hansen wrote:
> On 1/27/22 09:54, ira.weiny@intel.com wrote:
> > +#define PKR_AD_KEY(pkey)	(PKR_AD_BIT << PKR_PKEY_SHIFT(pkey))
> > +#define PKR_WD_KEY(pkey)	(PKR_WD_BIT << PKR_PKEY_SHIFT(pkey))
> 
> I don't _hate_ this, but naming here is wonky for me.  PKR_WD_KEY reads
> to me as "pkey register write-disable key", as in, please write-disable
> this key, or maybe "make a write-disable key".

Ok...  that is reasonable...

> 
> It's generating a mask, so I'd probably name it:
> 
> #define PKR_WD_MASK(pkey)	(PKR_WD_BIT << PKR_PKEY_SHIFT(pkey))
> 
> Which says, "generate a write-disabled mask for this pkey".

I think the confusion comes from me having used these as mask values rather
than what PKR_AD_KEY() was intended to be used for.

In the previous patch PKR_AD_KEY() is used to set up the default user pkey
value...

u32 init_pkru_value = PKR_AD_KEY( 1) | PKR_AD_KEY( 2) | PKR_AD_KEY( 3) |
		      PKR_AD_KEY( 4) | PKR_AD_KEY( 5) | PKR_AD_KEY( 6) |
		      PKR_AD_KEY( 7) | PKR_AD_KEY( 8) | PKR_AD_KEY( 9) |
		      PKR_AD_KEY(10) | PKR_AD_KEY(11) | PKR_AD_KEY(12) |
		      PKR_AD_KEY(13) | PKR_AD_KEY(14) | PKR_AD_KEY(15);

I'll have to think about it but I don't think I like the following...

u32 init_pkru_value = PKR_AD_MASK( 1) | PKR_AD_MASK( 2) | PKR_AD_MASK( 3) |
		      PKR_AD_MASK( 4) | PKR_AD_MASK( 5) | PKR_AD_MASK( 6) |
		      PKR_AD_MASK( 7) | PKR_AD_MASK( 8) | PKR_AD_MASK( 9) |
		      PKR_AD_MASK(10) | PKR_AD_MASK(11) | PKR_AD_MASK(12) |
		      PKR_AD_MASK(13) | PKR_AD_MASK(14) | PKR_AD_MASK(15);

It seems odd to me.  Does it seem odd to you?

Looking at the final code I think I'm going to just drop the usages in this
patch and add PKR_WD_KEY() where it is used first.

Also, how about PKR_KEY_INIT_{AD|WD|RW}() as a name?

Ira
