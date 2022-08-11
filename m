Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A24958F50C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 02:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiHKACA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 20:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiHKAB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 20:01:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7495E4D4CC
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 17:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660176117; x=1691712117;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=VIuh6HmQhaogAgt/cXp0prTG59cnR7hCc4YBw8Besag=;
  b=hH2t8s6mi6qQOvGNHNaKKbZwhbjeuo/IhUE6EaB21qLh89f+6D7ZZlk6
   w6iNr3KGf9Z426PacgGj0PYnTTBtOz85lVVK707hkjqmJbasIhhyCcodG
   sOkh4RUJ5JmxsssZVljfmrpp5QyDwMC3r8iomm1l3j0ETa6Xuaf0YRk6y
   bKi5wW/vokXEhNebsiYTtRkN7rJFZk1omw3ar+sPadU8fLizyFmuFyr+t
   dqt+lvHQM7P5DJ74svoxAM1EMAsBU19UtHGrizXZhQkf3hs6s0gocuc/Q
   Dcqwm8w+VvKqqU2yDTf6cAhpmlaPji80am/t5Df8ckrEiEk57URgNcXNe
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="377513219"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="377513219"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 17:01:57 -0700
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="933097690"
Received: from sarava2x-mobl1.gar.corp.intel.com (HELO [10.254.67.234]) ([10.254.67.234])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 17:01:56 -0700
Message-ID: <1d81ef6a-7505-fc13-ecbf-f3ca7a6fbfce@linux.intel.com>
Date:   Wed, 10 Aug 2022 17:01:55 -0700
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
 <bff78ad9-57d8-ca82-cc75-0b7e5024116d@linux.intel.com>
 <9888a920-37b8-9a1f-b887-6630492955c6@intel.com>
From:   Daniel Sneddon <daniel.sneddon@linux.intel.com>
Subject: Re: [PATCH] x86/apic: Don't disable x2APIC if locked
In-Reply-To: <9888a920-37b8-9a1f-b887-6630492955c6@intel.com>
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

On 8/10/22 16:44, Dave Hansen wrote:
> On 8/10/22 16:38, Daniel Sneddon wrote:
>>>
>>> config INTEL_TDX_GUEST
>>>         bool "Intel TDX (Trust Domain Extensions) - Guest Support"
>>>         depends on X86_64 && CPU_SUP_INTEL
>>>         depends on X86_X2APIC
>> So I got some more input.  SPR and newer will lock the APIC.  
> 
> Could you get a _little_ more clarity on this, please?  Exactly how and
> when will it be locked?  What does the BIOS writer's guide say?  Will
> there be an explicit x2APIC lock option?  Or, will it be implicitly
> locked when SGX or TDX is enabled?
The BIOS doesn't explicitly lock the APIC.  The APIC will be locked if X2APIC
mode is enabled when the BIOS does an MCHECK.  X2APIC mode will be enabled if
SGX or TDX are enabled.  So when exactly does the BIOS do an MCHECK?  That I'll
have to get clarification on.
> 
>> Older products will get a ucode update, but that ucode update won't
>> include the APIClock.  So, on non-SPR parts do we still want to make
>> SGX depend on X2APIC?
> Yes.  It's a small price to pay.

