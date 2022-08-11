Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AA458F573
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 02:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiHKA7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 20:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiHKA7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 20:59:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791E676952
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 17:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660179556; x=1691715556;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=TUJhIrJ6uTfGYZ2zcKvEOT9MqdA7gEk1m688zpHRHYs=;
  b=jPIJ2PppY7xhufzQ8iWuwX2f9VO54Wr/BtDEd7YregiBa7xl7FWs3EwT
   WyWb+sk84tHNe1dqtrHhWhWQxzpsvgs5nE9rRjCqPOXb2YETTXv2hS5v7
   xQdhEUK4diWuCCywyb6KZkcL4b3tH+DbMx3ZEbd2OkIVqJZRL8OUgKKvw
   AHfxpIyKj2Mn1wSHmvwKoypK+AeFAd4+90Lagi+ObZNALy+mceitWNc7P
   pY5jWOe8vKd6K3TaxQ2BTM3FE91xxKRxgPfWXLEZ6P97CspX9s3arJsj+
   jEz3yPfgQtR2uVe5iLM7Jixdy9yh43X4SFJiMV4aY1o0Q+d63GH3o6Wmu
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="271004705"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="271004705"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 17:59:16 -0700
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="933114038"
Received: from sarava2x-mobl1.gar.corp.intel.com (HELO [10.254.67.234]) ([10.254.67.234])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 17:59:15 -0700
Message-ID: <b6da06e8-6d79-4dd6-4a98-fbbc8b990d54@linux.intel.com>
Date:   Wed, 10 Aug 2022 17:59:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
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
 <bff78ad9-57d8-ca82-cc75-0b7e5024116d@linux.intel.com>
 <9888a920-37b8-9a1f-b887-6630492955c6@intel.com>
 <1d81ef6a-7505-fc13-ecbf-f3ca7a6fbfce@linux.intel.com> <87lervty0h.ffs@tglx>
From:   Daniel Sneddon <daniel.sneddon@linux.intel.com>
Subject: Re: [PATCH] x86/apic: Don't disable x2APIC if locked
In-Reply-To: <87lervty0h.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/22 17:38, Thomas Gleixner wrote:
> On Wed, Aug 10 2022 at 17:01, Daniel Sneddon wrote:
>> On 8/10/22 16:44, Dave Hansen wrote:
>>> On 8/10/22 16:38, Daniel Sneddon wrote:
>>>>>
>>>>> config INTEL_TDX_GUEST
>>>>>         bool "Intel TDX (Trust Domain Extensions) - Guest Support"
>>>>>         depends on X86_64 && CPU_SUP_INTEL
>>>>>         depends on X86_X2APIC
>>>> So I got some more input.  SPR and newer will lock the APIC.  
>>>
>>> Could you get a _little_ more clarity on this, please?  Exactly how and
>>> when will it be locked?  What does the BIOS writer's guide say?  Will
>>> there be an explicit x2APIC lock option?  Or, will it be implicitly
>>> locked when SGX or TDX is enabled?
>>
>> The BIOS doesn't explicitly lock the APIC.  The APIC will be locked if X2APIC
>> mode is enabled when the BIOS does an MCHECK.  X2APIC mode will be enabled if
>> SGX or TDX are enabled.  So when exactly does the BIOS do an MCHECK?  That I'll
>> have to get clarification on.
> 
> Sorry, this is uncomprehensible word salad and none of this makes any
> sense at all to me.
> 
> Can you please explain this in comprehensible sentences understandable
> by mere mortals?

Basically if the BIOS is configured to enable SGX or TDX, it'll program the APIC
to use x2APIC mode.  At some point it'll have to run MCHECK (which is just an
MSR write).  When exactly the BIOS does this, I'm not sure.  I've asked for
clarification on that.  At the point the BIOS does the MCHECK, if X2APIC mode is
enabled, the ucode will set the LOCK bit, and any attempt after that to disable
the APIC will result in the fault.  Now, this assumes the BIOS will DTRT, and
always enable x2APIC when SGX or TDX are enabled AND always perform the MCHECK,
AND do those things in the right order.  I'm not a BIOS guy so I have no idea
where to even look to see if/where that is documented.  I can certainly try to
track that down if needed.

I'm not sure if that's any clearer?  I guess I could try some code:

if (SGX_enabled() || TDX_enabled()
	set_x2apic_mode();

.....

MCHECK <-----At this point if x2APIC mode is on then the ucode set's the lock bit.

.....


Hope that helps.

> 
> Thanks,
> 
>         tglx

