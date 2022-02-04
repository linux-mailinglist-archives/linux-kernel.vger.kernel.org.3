Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E0B4A985F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 12:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358361AbiBDL1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 06:27:33 -0500
Received: from mga14.intel.com ([192.55.52.115]:60091 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235838AbiBDL1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 06:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643974052; x=1675510052;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=Y6UZ0SjSJA1F74CTW0FQCbSTZ033l4FECAxp1xTEEhc=;
  b=jANpBXa0uPb92aCa6XEhOQOPoNbeH2wV73xzWZPHbOwvPUuF/94Cs69F
   zkbbJqT+g6/6b+iASiGI33cxRyqdlRPci5xfJPfCaMHqSXldMEd4kxCqt
   ++zuBRGdRTmGBgrDbP8oR3zmXTrhCS9s3cvLf3GzrWuGTVWytu07qvmYe
   Ugd1JI0HieS92yh83fq67qS3js9dK6qaUT1eYQxryfzdey4R9VetQWZzx
   G3jyjs2/jmABrRlreykepAx/qziHw/kr6h8gRRldLlwZ05+N/74bTwl3/
   ch2zMx/w0FDiVhj4FLV9ob4XFL0UNgVJfrNt1VXXIs/vOC4MACtqrLxHI
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="248565838"
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="248565838"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 03:27:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="772070902"
Received: from skuppusw-mobl.amr.corp.intel.com (HELO [10.215.206.241]) ([10.215.206.241])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 03:27:22 -0800
Message-ID: <25fec256-7feb-e94d-5e37-3a174b6c6a66@linux.intel.com>
Date:   Fri, 4 Feb 2022 03:27:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCHv2 16/29] x86/boot: Add a trampoline for booting APs via
 firmware handoff
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Kai Huang <kai.huang@intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-17-kirill.shutemov@linux.intel.com>
 <Yfpqk0amEbcyte+w@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
In-Reply-To: <Yfpqk0amEbcyte+w@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/2/2022 3:27 AM, Borislav Petkov wrote:
> On Mon, Jan 24, 2022 at 06:02:02PM +0300, Kirill A. Shutemov wrote:
>> From: Sean Christopherson <sean.j.christopherson@intel.com>
>>
>> Historically, x86 platforms have booted secondary processors (APs)
>> using INIT followed by the start up IPI (SIPI) messages. In regular
>> VMs, this boot sequence is supported by the VMM emulation. But such a
>> wakeup model is fatal for secure VMs like TDX in which VMM is an
>> untrusted entity. To address this issue, a new wakeup model was added
>> in ACPI v6.4, in which firmware (like TDX virtual BIOS) will help boot
>> the APs. More details about this wakeup model can be found in ACPI
>> specification v6.4, the section titled "Multiprocessor Wakeup Structure".
>>
>> Since the existing trampoline code requires processors to boot in real
>> mode with 16-bit addressing, it will not work for this wakeup model
>> (because it boots the AP in 64-bit mode). To handle it, extend the
>> trampoline code to support 64-bit mode firmware handoff. Also, extend
>> IDT and GDT pointers to support 64-bit mode hand off.
>>
>> There is no TDX-specific detection for this new boot method. The kernel
>> will rely on it as the sole boot method whenever the new ACPI structure
>> is present.
>>
>> The ACPI table parser for the MADT multiprocessor wake up structure and
>> the wakeup method that uses this structure will be added by the following
>> patch in this series.
>>
>> Reported-by: Kai Huang <kai.huang@intel.com>
> I wonder what that Reported-by tag means here for this is a feature
> patch, not a bug fix or so...

I think it was added when Sean created the original patch. I don't have the
full history.

Sean, since this is not a bug fix, shall we remove the Reported-by tag?

>
>> diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
>> index 331474b150f1..fd6f6e5b755a 100644
>> --- a/arch/x86/include/asm/realmode.h
>> +++ b/arch/x86/include/asm/realmode.h
>> @@ -25,6 +25,7 @@ struct real_mode_header {
>>   	u32	sev_es_trampoline_start;
>>   #endif
>>   #ifdef CONFIG_X86_64
>> +	u32	trampoline_start64;
>>   	u32	trampoline_pgd;
>>   #endif
> Hmm, so there's trampoline_start, sev_es_trampoline_start and
> trampoline_start64. If those are mutually exclusive, can we merge them
> all into a single trampoline_start?

trampoline_start and sev_es_trampoline_start are not mutually exclusive. 
Both are
used in arch/x86/kernel/sev.c.

arch/x86/kernel/sev.c:560:      startup_ip = 
(u16)(rmh->sev_es_trampoline_start -
arch/x86/kernel/sev.c:561: rmh->trampoline_start);

But trampoline_start64 can be removed and replaced with 
trampoline_start. But using
_*64 suffix makes it clear that is used for 64 bit(CONFIG_X86_64).

Adding it for clarity seems to be fine to me. But if you would prefer 
single variable, we
can remove it. Please let me know.

>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

