Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D371558F493
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiHJW4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiHJW4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:56:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B166647D9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660172204; x=1691708204;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=YKkBtzT3qUfVAd2APMnB/Z38nogl3svTGnsH+cFcuRE=;
  b=gvJjYUb3GqO66zBue7h2Sg31Tnqf4nO3XIWtKq+vNgcRZVFuWioMk//l
   t6FEgtA5Ts7MaYoDt02YIbv0j85jmMQVeKMOFu2sDDbghulmSeyvPnma7
   bNyScq6n7FnOsaDORS/U8qgHd3D7tVMpE+QKjRYr8B/bBuXKMpamEk0ay
   d6Ocm7gr8QqYQUCdaKfqOhTuKFx3w2qbfxREVw+mhYBywjnqi0ZvYkJqb
   DBh+IOWNn8QAs6nAxphQ336LLI0XUctzO+t6YnP3Wu/5Eg0NmCCufuPPJ
   OUzVRji170PfQLyIjE6LbduS7jw1rsXFOzoipUHmw2CyeeOv/u1XaeIGO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="377503840"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="377503840"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 15:56:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="933075526"
Received: from sarava2x-mobl1.gar.corp.intel.com (HELO [10.254.67.234]) ([10.254.67.234])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 15:56:42 -0700
Message-ID: <e0a95ff9-4567-aa2f-fdef-20793ba48c6a@linux.intel.com>
Date:   Wed, 10 Aug 2022 15:56:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Gomez Iglesias, Antonio" <antonio.gomez.iglesias@intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
References: <20220809234000.783284-1-daniel.sneddon@linux.intel.com>
 <d6ffb489-7024-ff74-bd2f-d1e06573bb82@intel.com>
 <238ea612-5a25-9323-b31f-0a14493db2f7@linux.intel.com>
 <d4bcb22e-224c-d256-cb93-3ff6ed89a7d0@intel.com>
 <341ea6e9-d8f3-ee7a-6794-67408abbf047@linux.intel.com> <87r11nu52l.ffs@tglx>
From:   Daniel Sneddon <daniel.sneddon@linux.intel.com>
Subject: Re: [PATCH] x86/apic: Don't disable x2APIC if locked
In-Reply-To: <87r11nu52l.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/22 15:06, Thomas Gleixner wrote:
> On Wed, Aug 10 2022 at 12:40, Daniel Sneddon wrote:
>> On 8/10/22 11:52, Dave Hansen wrote:
>>> On 8/10/22 11:30, Daniel Sneddon wrote:
>>>>> If it's going to be on one server CPU that's coming out in ten years,
>>>>> then we can hold off.
>>>> SPR will certainly be sooner than 10 years, and with distros running on LTS
>>>> kernels, it is probably worth backporting.  Since this isn't a bug fix (not a sw
>>>> bug anyway), is this something I can just CC stable or is there a better way to
>>>> say "Yes, this is a new feature, BUT, you really want it anyway"?
>>>
>>> It it going to be *forced* on those SPR system?  In other words, is it a
>>> little BIOS switch that users can flip?  Is there any non-kernel
>>> workaround if a user hits this, or is the entire burden of this going to
>>> be foisted on the kernel?
>> It won't be forced, BUT, certain features won't be available if the APIC isn't
>> locked.  According to the documentation SGX and TDX won't be available if you
>> don't lock the APIC.  So, yes, you don't have to fix it in the kernel, but you
>> may lose access to features if you don't.
>>>
>>> The worst case scenario would be if a user has managed to compile a
>>> CONFIG_X86_X2APIC=n kernel and is happily running along until they get a
>>> microcode update, reboot and can't boot any more.
>> That _shouldn't_ happen as it is only on new hardware, so a ucode update
>> _shouldn't_ cause a crash.
> 
> Only on new hardware? The lock mechanism has to be available on _all_
> affected systems which support SGX. See
> 
>  https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/resources/intel-sgx-software-and-tcb-recovery-guidance.html

I asked the architect and security team that came up with that new MSR if it was
going to be backported via ucode updates and I was told no.

"Only SPR and newer. See the IA32_XAPIC_DISABLE_STATUS documentation at
https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/cpuid-enumeration-and-architectural-msrs.html."

So, it appears we have a war between which documentation do we believe!

I do have a few follow up questions I'm waiting on being answered to help
clarify all this.

Thanks,
Dan
