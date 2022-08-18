Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DBB5988CE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 18:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343684AbiHRQ0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 12:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344574AbiHRQ0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:26:46 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE2911C14
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 09:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660840005; x=1692376005;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TDTCqvwONJ9lvtiZl8rJs38Odt3/WFT0/x2OJAds0j0=;
  b=mvfmbGhoZy9cZr0ZbUz6EUVFxnE/+kLwH7emD8RbE5pBceBHK6RgOK5i
   u/ra8xZ7i6rZvbsZ/O7C/xKwL8x64v4uqv/t5N8zeYxGarKLKJ5XzmLR6
   pV5MLMefGvL+Y5chuGy89yXnpiNaCi18mFMgdz7Z6HfeAwXJt7hGxaaw5
   4RKuTN8mQUxZHzltz5gqmmjNJZC30+IXycpz0PA50TYCy5GEN25lCed7c
   4fV8xYgib5S8GA7huPfZLpa6r8KW6dpiUgbsW1IjJsZYhDIL8hOXIdgRe
   PxtllWmHa1VbTeIuDxDHuSeV/mBA9qKJYe4Y0Ij+GIHe9eHUSQdJh1XfU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="275851033"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="275851033"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 09:25:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="853467645"
Received: from amalikya-mobl.amr.corp.intel.com (HELO [10.212.238.171]) ([10.212.238.171])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 09:25:58 -0700
Message-ID: <7b246fd0-d54e-2419-26b6-8c7088a280d0@intel.com>
Date:   Thu, 18 Aug 2022 09:25:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v9 1/6] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220728034420.648314-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220728034420.648314-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Yv5KNyX992ddvVtD@zn.tnic>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Yv5KNyX992ddvVtD@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/22 07:18, Borislav Petkov wrote:
>> +	/*
>> +	 * Generate TDREPORT using "TDG.MR.REPORT" TDCALL.
>> +	 *
>> +	 * Get the TDREPORT using REPORTDATA as input. Refer to
>> +	 * section 22.3.3 TDG.MR.REPORT leaf in the TDX Module 1.0
>> +	 * Specification for detailed information.
>> +	 */
>> +	ret = __tdx_module_call(TDX_GET_REPORT, virt_to_phys(tdreport),
>> +				virt_to_phys(reportdata), req.subtype,
> That subtype you're not checking either.

I'll chime in here a bit since you're touching on something that bugged
me too.  This whole mechanism is because of two TDX shortcuts.  (calling
them shortcuts is generous, but I digress...)

     1. TDX guest attestation relies on SGX.  TDX does not have its own
	attestation mechanism.
     2. TDX guests can not run SGX enclaves.  Only TDX hosts can.

As a result, any TDX guest that wants to do the attestation dance has to
talk to the host, who them talks to the SGX enclave.  There's actually a
nice diagram of it in here (Figure 5.8):

> https://www.intel.com/content/dam/develop/external/us/en/documents/tdx-whitepaper-v4.pdf

This "talking" can be done via any old communication mechanism.  Shared
memory, virtio, morse code, whatever.  TDX_GET_REPORT just happens to be
yet another communication mechanism dedicated *only* to these
attestation reports.

So, this is not a *STRICTLY* required ABI.  Guests _can_ use other
mechanisms to talk to an SGX attestation (quoting) enclave.  Second,
this ABI *is* TDX-specific because no other hardware architectures have
made the same design "choices".

That's why this was jettisoned for v10.  It might reappear later, though.
