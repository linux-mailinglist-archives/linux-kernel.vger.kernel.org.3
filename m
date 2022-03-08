Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3860E4D2221
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350118AbiCHUEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350113AbiCHUEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:04:38 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7DF3B3D9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 12:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646769821; x=1678305821;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=nsL+613Pxrt0yhI4ae85j0fvm9ma4B2FW0hzvIESbns=;
  b=BWB1TB2hHmJWCmfTUNEltrUBmA+cTaWZv9QPwrW2PRryG/ityLgMT4B8
   UpCwnvyQVQDCCtKTHfAYba+Mh+5KZLkBc+ASjuZeOTFf09UfG98G5kVaB
   rlvCOLeQgHwAjjBJRqFRMpUrUH/jZIRw6h2dRh1qWxqns3fsTeVlzBQYj
   +80RFvb8b27FU2LxtYvhKHnaqFxpwiHFLpAhCAsfX89M9K8Gye73DJrFo
   nnNFFkjFSPk1GRyPclQgaFHIaOzm7G9nMBLFevVksV0pocKkXHB/0NL08
   Gpda7kbIx+wV/TS4DQRqNw2+S3u4ZwWg60wr7ALJi9RaFAV/l7bOltqkP
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="341230025"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="341230025"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 12:03:40 -0800
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="547388678"
Received: from ntebyanx-mobl7.amr.corp.intel.com (HELO [10.212.224.65]) ([10.212.224.65])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 12:03:39 -0800
Message-ID: <30fde533-d80f-3b60-5b5a-f284f5751a22@intel.com>
Date:   Tue, 8 Mar 2022 12:03:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-4-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv5 03/30] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
In-Reply-To: <20220302142806.51844-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/22 06:27, Kirill A. Shutemov wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Guests communicate with VMMs with hypercalls. Historically, these
> are implemented using instructions that are known to cause VMEXITs
> like VMCALL, VMLAUNCH, etc. However, with TDX, VMEXITs no longer
> expose the guest state to the host. This prevents the old hypercall
> mechanisms from working. So, to communicate with VMM, TDX
> specification defines a new instruction called TDCALL.
> 
> In a TDX based VM, since the VMM is an untrusted entity, an intermediary
> layer -- TDX module -- facilitates secure communication between the host
> and the guest. TDX module is loaded like a firmware into a special CPU
> mode called SEAM. TDX guests communicate with the TDX module using the
> TDCALL instruction.
> 
> A guest uses TDCALL to communicate with both the TDX module and VMM.
> The value of the RAX register when executing the TDCALL instruction is
> used to determine the TDCALL type. A variant of TDCALL used to communicate
> with the VMM is called TDVMCALL.
> 
> Add generic interfaces to communicate with the TDX module and VMM
> (using the TDCALL instruction).
> 
> __tdx_hypercall()    - Used by the guest to request services from the
> 		       VMM (via TDVMCALL).
> __tdx_module_call()  - Used to communicate with the TDX module (via
> 		       TDCALL).
> 
> Also define an additional wrapper _tdx_hypercall(), which adds error
> handling support for the TDCALL failure.
> 
> The __tdx_module_call() and __tdx_hypercall() helper functions are
> implemented in assembly in a .S file.  The TDCALL ABI requires
> shuffling arguments in and out of registers, which proved to be
> awkward with inline assembly.
> 
> Just like syscalls, not all TDVMCALL use cases need to use the same
> number of argument registers. The implementation here picks the current
> worst-case scenario for TDCALL (4 registers). For TDCALLs with fewer
> than 4 arguments, there will end up being a few superfluous (cheap)
> instructions. But, this approach maximizes code reuse.
> 
> For registers used by the TDCALL instruction, please check TDX GHCI
> specification, the section titled "TDCALL instruction" and "TDG.VP.VMCALL
> Interface".
> 
> Based on previous patch by Sean Christopherson.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Looks good:

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>

BTW, if you revise this again, let me have a few minutes with the
changelog.  There are, again, a few things that we should make less
clunky.  But, they aren't deal breakers.
