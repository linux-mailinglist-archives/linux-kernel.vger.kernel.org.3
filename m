Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6704D4A6975
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 02:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243587AbiBBBA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 20:00:56 -0500
Received: from mga03.intel.com ([134.134.136.65]:20163 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229994AbiBBBAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 20:00:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643763655; x=1675299655;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vDbMgeOCMKbsw6F5Rtn4JMP/kbMOZMhb5AzDRkk3ig4=;
  b=Z7tbi7yA7IC0mElL/R17XN5xC2fLrSGlbUoR43RJ78PCHBbxI53Te2LM
   qnVc0MeDUgEufwaJrigqCNISNqAm4nUusA7Zbwmmd9v4WTKPKdOUuqMyh
   EdfMaPoMyFSdFeoJawXmQ2TQhrFhwGoSiQKAo15QEpOqJEZvEYh4xnhW1
   w/WUShv+WyLekTvIoVr/4zD7sXtes0qUPLvm9fusgLrGwZfbhz1WAFi+o
   teJCBx1vt0oAJEKbOnh5BsRLLhjdOKG+n25g5xgzj6gYUtYDurM1D8uso
   i7bcYmo97zT7aTRoLTuNktPiMeNZtnln+f/OpCQ9xrBkcIMCyW4mcgwXu
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="247778221"
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="247778221"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 17:00:54 -0800
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="538052810"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 17:00:53 -0800
Date:   Tue, 1 Feb 2022 17:00:53 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 03/44] x86/pkeys: Create pkeys_common.h
Message-ID: <20220202010053.GT785175@iweiny-DESK2.sc.intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-4-ira.weiny@intel.com>
 <7bb7d2be-9fa0-1b0d-17d1-adb7d58d5389@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bb7d2be-9fa0-1b0d-17d1-adb7d58d5389@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 02:43:54PM -0800, Dave Hansen wrote:
> On 1/27/22 09:54, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Protection Keys User (PKU) and Protection Keys Supervisor (PKS) work in
> > similar fashions and can share common defines.  Specifically PKS and PKU
> > each have:
> > 
> > 	1. A single control register
> > 	2. The same number of keys
> > 	3. The same number of bits in the register per key
> > 	4. Access and Write disable in the same bit locations
> > 
> > Given the above, share all the macros that synthesize and manipulate
> > register values between the two features.  Share these defines by moving
> > them into a new header, change their names to reflect the common use,
> > and include the header where needed.
> 
> I'd probably include *one* more sentence to prime the reader for the
> pattern they are about to see.  Perhaps:
> 
> 	This mostly takes the form of converting names from the PKU-
> 	specific "PKRU" to the U/S-agnostic "PKR".

Fair enough.

> 
> > Also while editing the code remove the use of 'we' from comments being
> > touched.
> > 
> > NOTE the checkpatch errors are ignored for the init_pkru_value to
> > align the values in the code.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Either way, this looks fine:
> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Thanks!
Ira
