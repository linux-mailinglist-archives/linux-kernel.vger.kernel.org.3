Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3535F52AE51
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiEQWwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiEQWwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:52:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89FF4F459
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 15:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652827932; x=1684363932;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MXpnG781V44EHEn1EYFSevKxUEOq8K4Lyx6m+QH6iNg=;
  b=L1JKr0DJvAI6CpltNTq9bHWU2KOwFiCGarpfLqsV7HK9cKbG5O4+J/rD
   mGhxU6nriS6yUG8r0fEeF83cIOCgMkZQHtMGFfdA54zVh3N3KBpRdNYRb
   +rhDyXk3plpgQ+kNtwYsKEuzqszD3hJ1E/F72Nv+2hdJGQRb2lkmvJ8Rw
   wuwPvOyE3QhIMMC+4gmn28J6HYGgP0k3MPQI+NgUTBDKYr3DETArP1Fgg
   PHLksU+joR6ScLGz9CZoNmFNqgMwEkby7CdSAmSH7nwoXNznRHsAN7Hyj
   HLYtimRvOWX6jM2YCnXJVZqEE9ENIAde0ooJcoqA2I4chvUFtkzZH6nX6
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="271311934"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="271311934"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 15:52:05 -0700
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="673092894"
Received: from danielga-mobl.amr.corp.intel.com (HELO [10.212.245.96]) ([10.212.245.96])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 15:52:04 -0700
Message-ID: <4ee65514-2b08-9ca8-84e8-92a6ab1d9652@intel.com>
Date:   Tue, 17 May 2022 15:52:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] x86/tdx: Handle load_unaligned_zeropad() page-cross to a
 shared page
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220517153021.11116-1-kirill.shutemov@linux.intel.com>
 <e73cb19e-7dab-2fc1-b947-fac70fd607d2@intel.com>
 <20220517174042.v6s7wm3u5j2ebaoq@black.fi.intel.com>
 <c761e774-8014-6fa9-cf21-e7cd8f7aca54@intel.com>
 <20220517201710.ixbpsaga5jzvokvy@black.fi.intel.com>
 <083519ab-752f-9815-7741-22b3fcc03322@intel.com>
 <YoQkTtrMiU2bff9i@google.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <YoQkTtrMiU2bff9i@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/22 15:40, Sean Christopherson wrote:
> On Tue, May 17, 2022, Dave Hansen wrote:
>> The SDM makes it sound like we should be more judicious about using
>> 've->instr_len' though.  "All VM exits other than those listed in the
>> above items leave this field undefined."  Looking over
>> virt_exception_kernel(), we've got five cases from CPU instructions that
>> cause unconditional VMEXITs:
> 
> None of the below exit unconditionally.
...
>   For fault-like VM exits due to attempts to execute one of the following
>   instructions that cause VM exits unconditionally or based on the settings of
>   VM-execution controls.

Ahh, got it, thanks.  I bailed on reading that sentence before I got to
the "VM-execution controls" bit.

>> Then handle_mmio() can say:
>>
>> 	/*
>> 	 * VM-exit instruction length is not provided for the EPT
>> 	 * violations that MMIO causes.  Use the insn_decode() length:
> 
> This is inaccurate.  The instruction length _is_ provided on EPT Violation VM-Exits
> (it's also provided by all Intel CPUs on EPT Misconfigs even though the SDM doesn't
> say so).
> 
> The instruction length is wrong in the TDX case because there is no EPT Violation
> VM-Exit.  The EPT Violation is morphed to a #VE by the CPU, and the instruction
> length isn't one of the fields that's saved into the #VE info struct by the CPU.
> When the TDX Module gets control on the TDCALL, VMCS.INSTRUCTION_LENGTH will hold
> the length of the TDCALL, not the instruction that caused the #VE, i.e. the TDX
> Module can't provide the correct length.
> 
> For all other #VE cases in TDX, the #VE is injected by software (TDX module) after
> the instruction-based VM-Exit.  Before injecting the #VE, the TDX module grabs the
> length from the VMCS and manually records it in the #VE info struct.

That's horribly entertaining background. :)

But, it doesn't get us much closer to deciding when we can consume the
instruction length out of the ve_info.  It seems like magic that jut
happens to work at the moment.
