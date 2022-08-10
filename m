Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A132858F4F3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 01:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbiHJXjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 19:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiHJXjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 19:39:07 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBE27170D
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 16:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660174747; x=1691710747;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=5U0CJAVTSwVbsYns1fNFFVKObm/jI/IktTM+T34toaQ=;
  b=j9tGoJFqQaYlj3SGxAnpw3WbmRy0mTzn1u3ulD6S5U0Gy6mOe8fGjpSq
   6NFGSRuMuB7RWKPYAdcnE+krdckBL2ibAj/Jy+lUXqi3Go41ellQM5PHB
   FUnMY2e5dTrinwHQAArjr5ZGHen7y8uvhL0rXRshkHQZAH4HlHWcZ+c8E
   RiW8ZyOzCkw7wIziX72x4vI6uir0NPBNAhNy0e5wXmLgRCHw1tAaxppuF
   I/FhcXRuIP//swBC42m1FjFSjdaFXH/SsbATdGyFzAFQBd7uzx8cAgjMm
   SJUwS7ChRj9Aono8dGcFjD8Ntr2KkukjqHcSOajvDRQ+fZWutQQSMZoH1
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="274274516"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="274274516"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 16:39:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="933092240"
Received: from sarava2x-mobl1.gar.corp.intel.com (HELO [10.254.67.234]) ([10.254.67.234])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 16:39:05 -0700
Message-ID: <bff78ad9-57d8-ca82-cc75-0b7e5024116d@linux.intel.com>
Date:   Wed, 10 Aug 2022 16:38:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Huang, Kai" <kai.huang@intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Gomez Iglesias, Antonio" <antonio.gomez.iglesias@intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
References: <20220809234000.783284-1-daniel.sneddon@linux.intel.com>
 <d6ffb489-7024-ff74-bd2f-d1e06573bb82@intel.com>
 <238ea612-5a25-9323-b31f-0a14493db2f7@linux.intel.com>
 <d4bcb22e-224c-d256-cb93-3ff6ed89a7d0@intel.com>
 <341ea6e9-d8f3-ee7a-6794-67408abbf047@linux.intel.com> <87r11nu52l.ffs@tglx>
 <83a0d220-1872-caba-4e7e-b6a366655cf2@linux.intel.com>
 <ba80b303-31bf-d44a-b05d-5c0f83038798@intel.com>
From:   Daniel Sneddon <daniel.sneddon@linux.intel.com>
Subject: Re: [PATCH] x86/apic: Don't disable x2APIC if locked
In-Reply-To: <ba80b303-31bf-d44a-b05d-5c0f83038798@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/22 16:09, Dave Hansen wrote:
> On 8/10/22 16:03, Daniel Sneddon wrote:
>> On 8/10/22 15:06, Thomas Gleixner wrote:
>>> So this affects already deployed systems and we have to
>>>
>>>   - backport the x2apic lock changes
>>>
>>>   - provide proper diagnostics
>>>
>>>   - make SGX and TDX depend on X2APIC support
>> I'll add the comments Dave mentioned earlier, and will make SGX and TDX depend
>> on X2APIC since that makes sense regardless of what hw ends up with this change.
>>  Unless we want to get rid of CONFIG_X86_X2APIC like Dave mentioned?
> 
> The TDX guest support in the kernel isn't _actually_ related to this*.
> It's the host-side support that matters and that isn't merged yet.  I've
> cc'd Kai so he doesn't forget to do this.
> 
> I agree on the SGX side, though.
> 
> * TDX guest support already has this dependency, but it's for unrelated
>   reasons:
> 
> config INTEL_TDX_GUEST
>         bool "Intel TDX (Trust Domain Extensions) - Guest Support"
>         depends on X86_64 && CPU_SUP_INTEL
>         depends on X86_X2APIC
So I got some more input.  SPR and newer will lock the APIC.  Older products
will get a ucode update, but that ucode update won't include the APIC lock.  So,
on non-SPR parts do we still want to make SGX depend on X2APIC?
