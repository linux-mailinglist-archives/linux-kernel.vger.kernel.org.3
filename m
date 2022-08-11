Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67A558F546
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 02:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbiHKAkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 20:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbiHKAkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 20:40:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C505C844C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 17:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660178408; x=1691714408;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=UCcCpZHkT/2Ti6lex3qs3h9kqGGdpHP3mvw5ujqgW3c=;
  b=LkbvJ+4lKEKJ7sp8A/yQQF7YmWF1ddA111xPf6du+AOSxExphWt76/Gj
   7A/fe6F8VPynnS2Le5FBdG+M0ai32ylHrRznFMrWGnznZXFs7D1lh1Thz
   Ep5p/JXSPWtzg98/pefXyEc6+3IswnJUZJiygXvmz4gcf3g9x8+1XsP6s
   jG8V9ISqMp1RKeiP3U6pU0U3/8ajLoubTC27RXVRVMEuFviAvWR6casiH
   4Qhcce6Ot5AC4BERJQyqp+pi9m9gnbEBgf0p6j2K5gphu3UjGrPUtO6bo
   gyMGxZnMaksVUluusXEWUFeFkK4gAO2K47acqxsT5wI8NsVTAhAi5yake
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="352965122"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="352965122"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 17:40:08 -0700
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="933108821"
Received: from sarava2x-mobl1.gar.corp.intel.com (HELO [10.254.67.234]) ([10.254.67.234])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 17:40:07 -0700
Message-ID: <244c4bc6-c5ec-dcca-1ffe-5f00fd0091f3@linux.intel.com>
Date:   Wed, 10 Aug 2022 17:40:02 -0700
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
 <bff78ad9-57d8-ca82-cc75-0b7e5024116d@linux.intel.com> <87o7wrtyze.ffs@tglx>
From:   Daniel Sneddon <daniel.sneddon@linux.intel.com>
Subject: Re: [PATCH] x86/apic: Don't disable x2APIC if locked
In-Reply-To: <87o7wrtyze.ffs@tglx>
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

On 8/10/22 17:17, Thomas Gleixner wrote:
> On Wed, Aug 10 2022 at 16:38, Daniel Sneddon wrote:
>> On 8/10/22 16:09, Dave Hansen wrote:
>>> config INTEL_TDX_GUEST
>>>         bool "Intel TDX (Trust Domain Extensions) - Guest Support"
>>>         depends on X86_64 && CPU_SUP_INTEL
>>>         depends on X86_X2APIC
>>
>> So I got some more input.  SPR and newer will lock the APIC.  Older products
>> will get a ucode update, but that ucode update won't include the APIC lock.  So,
>> on non-SPR parts do we still want to make SGX depend on X2APIC?
> 
> What is the ucode update doing on pre SPR parts?
> Just providing magic voodoo which pretends to be safe?
It'll be clearing the buffers so that when someone tries to read data from the
APIC it won't leak data anymore.
> 
> The public available documentation for this is a huge pile of void.
I don't disagree with that.
> 
> The point is that if the SGX attestation will fail when X2APIC is not
> enforced on the host as of 'some magic dates in 2023' according to the
> documentation I pointed to, then any pre SPR SGX capable system is going
> to be disfunctional vs. SGX at one of those magic dates.
>
> Some people inside a particular company need to get their act together
> and either make this consistent or provide some coherent information why
> this is not required for pre SPR parts and why SPR needs to have it.

I'll try to get more clarification, and more importantly, get that published
somewhere.

> 
> Thanks,
> 
>         tglx
> 
> 
Thanks for the input!


