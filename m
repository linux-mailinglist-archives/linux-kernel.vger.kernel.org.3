Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0659C48A0B1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245370AbiAJUKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:10:16 -0500
Received: from mga06.intel.com ([134.134.136.31]:21424 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243576AbiAJUKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:10:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641845415; x=1673381415;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MddOv9rNWzwfEHFQm02jD0qYMPPpUJ+02HSYd6O59A8=;
  b=FHEskh7Z1tasmZeS/g3J+0q3WIhqgFq+RXsYtV5bNzI3aMCbt3Axoldr
   61NVunxVmJR3a68fqAyoudRU5pdk8ShgMxLnTSYpzC7Ri8hAblcbsfAYX
   juQ4xEiDGdyImXoI2NLRAIpurSmpCJYxw8PDw4dPha4+wWNW1DyWujRK4
   J0nIllKlxbfA8eJ8Et7catrpyODScrbztpYSTKrrkI63co0Z0zLd0yTin
   S4c0r1GxPbz6sJ+OyJfL3eswgHAcON2GjFiiFL6auPC31Oxsh3GbT/Ukc
   VRi7tBOfyqqzMT55pTBviohrGGuBcs1tD2N5Qa2bH4KyLTX59wB+rU9Zw
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="304050890"
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="304050890"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 12:10:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="474248797"
Received: from sandiko-mobl1.amr.corp.intel.com (HELO [10.209.94.191]) ([10.209.94.191])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 12:10:14 -0800
Message-ID: <265db742-0539-a66f-ff00-2b18cb2add88@intel.com>
Date:   Mon, 10 Jan 2022 12:10:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [GIT PULL] x86/cpu for v5.17
Content-Language: en-US
To:     Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>
References: <YdwVl0H54fmUIux0@zn.tnic>
 <CAHk-=wh+UbGrgH4CzKSoTYGPidyv5isiLMxJKAqnV3NFTiRdaQ@mail.gmail.com>
 <Ydx8fUCotPI++UEW@zn.tnic>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Ydx8fUCotPI++UEW@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/22 10:35, Borislav Petkov wrote:
>>
>> Not a big deal, I just thought I'd mention it since I reacted to it.
>> And we don't seem to have those vendor checks in any of the other code
>> that uses MSR_CSTAR (just grepping for that and seeing it mentioned in
>> kvm code etc)
> Right, the only point for doing the vendor check I see here is, well,
> because it is Intel who doesn't have CSTAR, let's check for Intel. But
> yeah, we do avoid the vendor checks if it can be helped.
> 
> We can do a synthetic X86_FEATURE flag but that would be a waste. So the
> _safe thing and keep the comment sounds optimal to me.
> 
> I can whip up a patch ontop if people agree.

There are four basic options here for TDX:

1. Paper over the #VE in the #VE handler itself
2. Do a check for TDX at the wrmsr(MSR_CSTAR) site
3. Do a check for X86_VENDOR_INTEL at the wrmsr(MSR_CSTAR) site
4. Use wrmsr*_safe() and rely on #VE -> fixup_exception()

TDX originally did #1, passed over #2 and settled on #3 because of a 
comment:

	It's an obvious optimization (avoiding the WRMSR with a
	conditional) without TDX because the write is pointless
	independent of TDX." [1]

I think doing wrmsr*_safe() is OK.  But, on TDX systems, it will end up 
taking a weird route:

       WRMSR -> #VE -> hypercall -> ve_raise_fault() -> fixup_exception()

instead of the "normal" _safe route which goes:

       WRMSR -> #GP -> ... -> fixup_exception()

So, we should probably make sure wrmsr*_safe() is fine on TDX before we 
subject ourselves to any additional churn.  Kirill, can you test that out?

1. https://lore.kernel.org/all/87sfvljf5q.ffs@tglx/
