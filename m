Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CF458F4A4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 01:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbiHJXJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 19:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbiHJXJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 19:09:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB0573338
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 16:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660172942; x=1691708942;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q4SxPdLSzVBG3OLsteoyYJUs7wpKwN1B3yE/EJ6LQ24=;
  b=gHfzq4v0C/yUvHguq+0thQ3ojv690zmYrfqX6cYvMMBRLWb/Fp9HM+N2
   /qFx9LRfjde2uW4Foho5QRSmTBsxptM8Kx2nhY1y26krsL0oo0p3off9s
   D/kBXTpYxZZmrTIrMgQj86esoMlmzksaH+bwchaB4Q75D8fbOzyjUzjsf
   QhlI48CnOs8O4P/5LbFSpy/hZPl8TNLln87796KRPH0rjUezs44Bb4d1q
   bcRblHcsMyIL8lLV+ZA4EUUjTEdlps3IMMH5jwijlwbrtyQuLBNjO8hs3
   dAWez3ShLsP6zt0qZ4xzvz0AbeOE7FbvfNZKgaiGKOhLNrEdy13G+ljeH
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="271599704"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="271599704"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 16:09:02 -0700
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="781398405"
Received: from snedunga-mobl2.amr.corp.intel.com (HELO [10.212.234.47]) ([10.212.234.47])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 16:09:01 -0700
Message-ID: <ba80b303-31bf-d44a-b05d-5c0f83038798@intel.com>
Date:   Wed, 10 Aug 2022 16:09:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/apic: Don't disable x2APIC if locked
Content-Language: en-US
To:     Daniel Sneddon <daniel.sneddon@linux.intel.com>,
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
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <83a0d220-1872-caba-4e7e-b6a366655cf2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/22 16:03, Daniel Sneddon wrote:
> On 8/10/22 15:06, Thomas Gleixner wrote:
>> So this affects already deployed systems and we have to
>>
>>   - backport the x2apic lock changes
>>
>>   - provide proper diagnostics
>>
>>   - make SGX and TDX depend on X2APIC support
> I'll add the comments Dave mentioned earlier, and will make SGX and TDX depend
> on X2APIC since that makes sense regardless of what hw ends up with this change.
>  Unless we want to get rid of CONFIG_X86_X2APIC like Dave mentioned?

The TDX guest support in the kernel isn't _actually_ related to this*.
It's the host-side support that matters and that isn't merged yet.  I've
cc'd Kai so he doesn't forget to do this.

I agree on the SGX side, though.

* TDX guest support already has this dependency, but it's for unrelated
  reasons:

config INTEL_TDX_GUEST
        bool "Intel TDX (Trust Domain Extensions) - Guest Support"
        depends on X86_64 && CPU_SUP_INTEL
        depends on X86_X2APIC
