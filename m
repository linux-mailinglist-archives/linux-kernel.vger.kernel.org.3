Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BEB52DCEC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244041AbiESSfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbiESSfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:35:38 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9435F56F90
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652985337; x=1684521337;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eXy8i7Ms7pnGUruejXu3xQWWY8IlWM67DQ4+m49di/A=;
  b=Z7I17IN99mh60Nk3/aUlG65zFFxAyZKiucb1333YXXcAlYQ0Eg/+VnfF
   UVNnnxK2vtRB7oidC4cNU+FEZUbwZzTXK8RZ0QGeEPhj8mFq4VNjAmgVg
   Nefagc3HAQDB8TRwKeAukhMnUtzgmbrSmvSaH8jPbS3vVPFohmAl2QqI8
   pwcyGo04A5JdzOJGiwvgGMFY/oU9mYoOuxjZQqVx5Bdf+n79VAqpU+FWD
   NR4G9w3ZCR7ag5PLPHc007c6skJTSh708kXZRndLVoYJ2psFTsXe1wx+f
   uAObKTH77Bm/BYM/d9VNbHNCTTZllZ65V5d2jNcqJRnZPosJdh7FqOCaQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="335371984"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="335371984"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 11:35:37 -0700
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="606624216"
Received: from rlsharma-mobl.amr.corp.intel.com (HELO [10.212.180.228]) ([10.212.180.228])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 11:35:36 -0700
Message-ID: <c75ffa6b-181b-bc4c-9fee-5476cfbc329a@intel.com>
Date:   Thu, 19 May 2022 11:35:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] x86/tdx: Handle load_unaligned_zeropad() page-cross to a
 shared page
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
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
 <083519ab-752f-9815-7741-22b3fcc03322@intel.com>
 <YoQkTtrMiU2bff9i@google.com> <YoQnQIfX8GuOgKqH@google.com>
 <20220519181958.libitxp2jws4prcr@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220519181958.libitxp2jws4prcr@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 11:19, Kirill A. Shutemov wrote:
>>>> The SDM has a breakdown:
>>>>
>>>> 	27.2.5 Information for VM Exits Due to Instruction Execution
>>>>
>>>> I didn't realize it came from VMREAD.  I guess I assumed it came from
>>>> some TDX module magic.  Silly me.
>>>>
>>>> The SDM makes it sound like we should be more judicious about using
>>>> 've->instr_len' though.  "All VM exits other than those listed in the
>>>> above items leave this field undefined."  Looking over
>>>> virt_exception_kernel(), we've got five cases from CPU instructions that
>>>> cause unconditional VMEXITs:
>> Ideally, what the SDM says wouldn't matter at all.  The TDX module spec really
>> should be the authorative source in this case, but it just punts to the SDM:
>>
>>   The 32-bit value that would have been saved into the VMCS as VM-exit instruction
>>   length if a legacy VM exit had occurred instead of the virtualization exception.
>>
>> Even if the TDX spec wants to punt to the SDM, it would save a lot of headache and
>> SDM reading if it also said something to the effect of:
>>
>>   The INSTRUCTION_LENGTH and INSTRUCTION_INFORMATION fields are valid for all
>>   #VEs injected by the Intel TDX Module.  The fields are undefined for #VEs
>>   injected by the CPU due to EPT Violations.
> I initiated update to the spec, but it will take time.

Understood, and thanks for doing that.

For now, let's just declare what we *expect* the spec will say and show
it to the folks doing the spec itself.  They will then have a chance to
balk at our interpretation if we got something wrong.
