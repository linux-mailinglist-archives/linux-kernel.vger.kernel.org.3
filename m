Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C95458F348
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 21:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbiHJTkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 15:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiHJTkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 15:40:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4520165812
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 12:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660160444; x=1691696444;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=MEtX1FvWGof9iq1WMdS/Z4PdVhN93vt9dVvNgsvNw+s=;
  b=Yu1BGEzFblrVtuyiG/SYTYHgZbtJHkL1JFRBY0GLLx2EjWhuH/JgsU9/
   2QtLQTjVc74D4Qyle6Qf1JPtEETEO9lbZArJa2y92zutoilwdzc82FGkx
   TdnB4ZLIqWaokfJnekTmkFTSrKg//x7ldDXExay0/EoR1H++tfTJu2oba
   hc5tR3EDmWg8BrFR8zzJ25WrlXPLF3HhAZRslUky2q5uod9aHnq/lD+Zz
   1EaAkt1xqTbuGpr33IAWisyrnR4c9rkoOdVD9joCuLxANWdolPMl9g9S6
   pJAiLUqkZHYEe95I1l8H9BfjjG/hVBKjgcsO/CUuxk9JdsXhdBv7rnWCW
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="291966423"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="291966423"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 12:40:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="605271778"
Received: from sarava2x-mobl1.gar.corp.intel.com (HELO [10.254.67.234]) ([10.254.67.234])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 12:40:43 -0700
Message-ID: <341ea6e9-d8f3-ee7a-6794-67408abbf047@linux.intel.com>
Date:   Wed, 10 Aug 2022 12:40:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
From:   Daniel Sneddon <daniel.sneddon@linux.intel.com>
Subject: Re: [PATCH] x86/apic: Don't disable x2APIC if locked
In-Reply-To: <d4bcb22e-224c-d256-cb93-3ff6ed89a7d0@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/22 11:52, Dave Hansen wrote:
> On 8/10/22 11:30, Daniel Sneddon wrote:
>>> If it's going to be on one server CPU that's coming out in ten years,
>>> then we can hold off.
>> SPR will certainly be sooner than 10 years, and with distros running on LTS
>> kernels, it is probably worth backporting.  Since this isn't a bug fix (not a sw
>> bug anyway), is this something I can just CC stable or is there a better way to
>> say "Yes, this is a new feature, BUT, you really want it anyway"?
> 
> It it going to be *forced* on those SPR system?  In other words, is it a
> little BIOS switch that users can flip?  Is there any non-kernel
> workaround if a user hits this, or is the entire burden of this going to
> be foisted on the kernel?
It won't be forced, BUT, certain features won't be available if the APIC isn't
locked.  According to the documentation SGX and TDX won't be available if you
don't lock the APIC.  So, yes, you don't have to fix it in the kernel, but you
may lose access to features if you don't.
> 
> The worst case scenario would be if a user has managed to compile a
> CONFIG_X86_X2APIC=n kernel and is happily running along until they get a
> microcode update, reboot and can't boot any more.
That _shouldn't_ happen as it is only on new hardware, so a ucode update
_shouldn't_ cause a crash.
> 
> A less-bad, but still nasty situation would be someone who is booting
> with nox2apic, who also suddenly loses the ability to boot until they
> figure out why their kernel is #GP'ing and oopsing early in boot and
> remove nox2apic.

That should only happen if they update their BIOS settings in such a way that
the APIC is locked (e.g, SGX or TDX is enabled) on an existing SPR system.
> I think we need a bit more information on how this thing will get
> deployed before we really know if it needs to be in stable kernels or
> not.  For instance, if Intel really views this as an always-on security
> mitigation, that's a different story than if this is, say, a performance
> tweak.
Well, it is certainly an always on thing if you want SGX or TDX.  If you're on
SPR or newer with either of those enabled, then the APIC will be locked.  If
you're using an image that works with nox2apic on pre-SPR hardware and put it on
SPR hardware, you'll hang trying to boot.  In that case you'll either have to
remove the nox2apic option or tweak your BIOS so you're not locked, BUT, I
suspect those BIOS options aren't going to be super clear about what to turn off
to make sure you're not locked.

You can boot an old kernel without this patch, or even without X2APIC support,
but you may have to mess with the BIOS to get there.  The good news is that it
should only affect new systems as this isn't on any existing production hardware
and isn't planned on being pushed out to existing products via ucode updates.
