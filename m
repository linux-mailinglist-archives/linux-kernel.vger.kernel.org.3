Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D6446C995
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238712AbhLHAyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 19:54:38 -0500
Received: from mga14.intel.com ([192.55.52.115]:62743 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234627AbhLHAyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 19:54:38 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="237954309"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="237954309"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 16:51:07 -0800
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="580353148"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 16:51:07 -0800
Date:   Tue, 7 Dec 2021 16:51:06 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-mm@kvack.org
Subject: Re: [PATCH V7 03/18] x86/pks: Add additional PKEY helper macros
Message-ID: <20211208005106.GJ3538886@iweiny-DESK2.sc.intel.com>
References: <20210804043231.2655537-1-ira.weiny@intel.com>
 <20210804043231.2655537-4-ira.weiny@intel.com>
 <87lf1cl3cq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lf1cl3cq.ffs@tglx>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 03:25:09PM +0100, Thomas Gleixner wrote:
> On Tue, Aug 03 2021 at 21:32, ira weiny wrote:
> > @@ -200,16 +200,14 @@ __setup("init_pkru=", setup_init_pkru);
> >   */
> >  u32 update_pkey_val(u32 pk_reg, int pkey, unsigned int flags)
> >  {
> > -	int pkey_shift = pkey * PKR_BITS_PER_PKEY;
> > -
> >  	/*  Mask out old bit values */
> > -	pk_reg &= ~(((1 << PKR_BITS_PER_PKEY) - 1) << pkey_shift);
> > +	pk_reg &= ~PKR_PKEY_MASK(pkey);
> >  
> >  	/*  Or in new values */
> >  	if (flags & PKEY_DISABLE_ACCESS)
> > -		pk_reg |= PKR_AD_BIT << pkey_shift;
> > +		pk_reg |= PKR_AD_KEY(pkey);
> >  	if (flags & PKEY_DISABLE_WRITE)
> > -		pk_reg |= PKR_WD_BIT << pkey_shift;
> > +		pk_reg |= PKR_WD_KEY(pkey);
> 
> I'm not seeing how this is improving that code. Quite the contrary.

Fair enough.  Even more so when using the code you suggested for pkey_update_pkval().

In that case it boils down to:

diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index eb6d6b872652..b7127329d115 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -198,7 +198,7 @@ __setup("init_pkru=", setup_init_pkru);
  */
 u32 pkey_update_pkval(u32 pkval, int pkey, u32 accessbits)
 {
-        int shift = pkey * PKR_BITS_PER_PKEY;
+        int shift = PKR_PKEY_SHIFT(pkey);
 
         if (WARN_ON_ONCE(accessbits & ~PKEY_ACCESS_MASK))
                 accessbits &= PKEY_ACCESS_MASK;


Better?

As to the reason of why to put this patch after the other one.  Why would I
improve the old pre-refactoring code only to throw it away when moving it to
pkey_update_pkval()?  This reasoning is even stronger when pkey_update_pkval()
is implemented.

I agree with Dan regarding the macros though.  I think they make it easier to
see what is going on without dealing with masks and shifts directly.  But I can
remove this patch if you feel that strongly about it.

Ira

> 
> Thanks,
> 
>         tglx
