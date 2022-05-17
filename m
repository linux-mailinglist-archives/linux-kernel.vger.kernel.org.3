Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C2852ADEC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiEQWQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiEQWQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:16:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FEA37025
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 15:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652825804; x=1684361804;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6W6rvkplRpdMvYjau1H8ykuxkSdmIy9T0OZizqtcYdI=;
  b=MAM4O9sKE/XHk3UxpWre/N+eglN7HENKGJQaJGH2buIU4qtqQuJ1I50i
   deTiVesvrzFhkEk/w5on7ljWzp57F9IykS2iW5E8mjCBUK4rT637wYQLw
   kLRGVlu1P572yrSszzYqfFVb3LVtw+p+i2fYaKeij+pXAYEXQgjTqTpS6
   9xoKfy71B+rIBKfK6Il0PVcxJN0zS6lmNyKrTsJW0CZQK4rLS43ZI7+qB
   JYs1bWFA34pshVNfJDkDXUjn7SrC2KvDM5T/KfBK0anL+bstQbp532oR9
   erIMhuDfryYLrgk7Kax/Q4ziU5fdle93YUkSU6/etGk3hoQCCh/ofj4s/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="271047142"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="271047142"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 15:16:43 -0700
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="673081091"
Received: from danielga-mobl.amr.corp.intel.com (HELO [10.212.245.96]) ([10.212.245.96])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 15:16:42 -0700
Message-ID: <083519ab-752f-9815-7741-22b3fcc03322@intel.com>
Date:   Tue, 17 May 2022 15:16:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] x86/tdx: Handle load_unaligned_zeropad() page-cross to a
 shared page
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        seanjc@google.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
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
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220517201710.ixbpsaga5jzvokvy@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/22 13:17, Kirill A. Shutemov wrote:
>>> Given that we had to adjust IP in handle_mmio() anyway, do you still think
>>> "ve->instr_len = 0;" is wrong? I dislike ip_adjusted more.
>> Something is wrong about it.
>>
>> You could call it 've->instr_bytes_to_handle' or something. Then it
>> makes actual logical sense when you handle it to zero it out.  I just
>> want it to be more explicit when the upper levels need to do something.
>>
>> Does ve->instr_len==0 both when the TDX module isn't providing
>> instruction sizes *and* when no handling is necessary?  That seems like
>> an unfortunate logical multiplexing of 0.
> For EPT violation, ve->instr_len has *something* (not zero) that doesn't
> match the actual instruction size. I dig out that it is filled with data
> from VMREAD(0x440C), but I don't know where is the ultimate origin of the
> data.

The SDM has a breakdown:

	27.2.5 Information for VM Exits Due to Instruction Execution

I didn't realize it came from VMREAD.  I guess I assumed it came from
some TDX module magic.  Silly me.

The SDM makes it sound like we should be more judicious about using
've->instr_len' though.  "All VM exits other than those listed in the
above items leave this field undefined."  Looking over
virt_exception_kernel(), we've got five cases from CPU instructions that
cause unconditional VMEXITs:

        case EXIT_REASON_HLT:
        case EXIT_REASON_MSR_READ:
        case EXIT_REASON_MSR_WRITE:
        case EXIT_REASON_CPUID:
        case EXIT_REASON_IO_INSTRUCTION:

and should have that field filled out, plus one that doesn't:

        case EXIT_REASON_IO_INSTRUCTION:

It seems awfully fragile to me to have the hardware be providing the
'instr_len' in those cases, but not in one other one.  The data in there
is garbage for EXIT_REASON_IO_INSTRUCTION.  The reason we don't consume
garbage is that all the paths leading out of handle_mmio() that return
true also set 've->instr_len'.  But that logic is entirely opaque.

It's also borderline criminal to have six functions that look identical
(in that switch statement), but one of them has different behavior for
've->instr_len'.

I'd probably do it like this:

static int handle_halt(struct ve_info *ve)
{
        /*
         * Since non safe halt is mainly used in CPU offlining
         * and the guest will always stay in the halt state, don't
         * call the STI instruction (set do_sti as false).
         */
        const bool irq_disabled = irqs_disabled();
        const bool do_sti = false;

        if (__halt(irq_disabled, do_sti))
                return -EIO;

	/*
	 * VM-exit instruction length is defined for HLT.  See:
	 * "Information for VM Exits Due to Instruction Execution"
	 * in the SDM.
	 */
        return ve->insn_length;
}

Any >=0 return means the exception was handled and it tells the caller
hoe much to advance RIP.

Then handle_mmio() can say:

	/*
	 * VM-exit instruction length is not provided for the EPT
	 * violations that MMIO causes.  Use the insn_decode() length:
	 */
        return insn.length;

See?  Now everybody that goes and writes a new #VE exception helper has
a chance of actually getting this right.  As it stands, if someone adds
one more of these, they'll probably get random behavior.  This way, they
actually have to choose.  They _might_ even go looking at the SDM.
