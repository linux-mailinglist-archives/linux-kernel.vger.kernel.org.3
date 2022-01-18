Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D70F492FE1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 22:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349491AbiARVDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 16:03:24 -0500
Received: from mga04.intel.com ([192.55.52.120]:15035 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349484AbiARVDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 16:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642539802; x=1674075802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=P1yWwiO+/KLc5Fnql+MlQCaBmw+U58qRYKjO6YVvVEc=;
  b=Dy01biHQ9IyfCcy2B2IR+qZ1+s9luZ5efW22HS8dpRVvyXW2HM1qnRXe
   6KpQ0sC6FtvRbj8v5CYLaavT3FKFAtA9avz9VlrbE5nlTKfiBcbGVKZp8
   vobfpkVYL+UBxMZmVDZ6bgLHYYIzeZRjyXFERshWAKzSYpC4u0hcaRFXf
   1VUDsL4/oguNCVF+7b6cQmu+VPGibH/34HzxQqRC5XXJogzyXG33orGSj
   dxYm8g0RRsiZ8dOs+MC649dNXl2MguW9Wb5fRyUyisxHQz+cbN/GORoSk
   Kt/eRq3OFudSe9YowPii/kxvkepGE0PunrbucHhgu/6oSz9Ro1xvlx7uU
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="243738082"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="243738082"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 13:03:21 -0800
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="531956820"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 13:03:20 -0800
Date:   Tue, 18 Jan 2022 13:03:19 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Smita Koralahalli Channabasappa 
        <smita.koralahallichannabasappa@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, patches@lists.linux.dev
Subject: Re: [PATCH 1/5] x86/ras: Merge Intel and AMD ppin_init() functions
Message-ID: <YecrF15C0d0tudUN@agluck-desk2.amr.corp.intel.com>
References: <20220107225442.1690165-1-tony.luck@intel.com>
 <20220107225442.1690165-2-tony.luck@intel.com>
 <YecY/Ri6hvJGqNTT@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YecY/Ri6hvJGqNTT@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 09:02:41PM +0100, Borislav Petkov wrote:
> On Fri, Jan 07, 2022 at 02:54:38PM -0800, Tony Luck wrote:
> > +} ppin_info[] = {
> > +	[X86_VENDOR_INTEL] = {
> > +		.feature = X86_FEATURE_INTEL_PPIN,
> > +		.msr_ppin_ctl = MSR_PPIN_CTL,
> > +		.msr_ppin = MSR_PPIN
> > +	},
> > +	[X86_VENDOR_AMD] = {
> 
> X86_VENDOR_AMD is index 2 not 1 so ppin_info[1] is empty.
> 
> I wouldn't mind swapping the numbers here in a pre-patch:
> 
> #define X86_VENDOR_CYRIX        1
> #define X86_VENDOR_AMD          2
> 
> nothing would depend on those naked numbers, right? :)

You are much braver than I :-)  How confident are you
that nobody implicitly depends on those? Is it worth the
risk/churn just to save 12 bytes in the ppin_info[] array?

I'll fix up all the other stuff you found and post a V2
soon.  Thanks for the review.

-Tony
