Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A00D4CF723
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238090AbiCGJoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237602AbiCGJdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:33:04 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B87E62125
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 01:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646645395; x=1678181395;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i5j1caJdqVJ0kTbO7103DrR0dBeK5IIEmJAv21zNSqA=;
  b=XBck555Gn0shtNBhO4NoCAbTrEKn3jevEzgTmOyuZ8kAPY+2xedSXLns
   le69AievqmStLxFRTh/z1xN/p9gnQQnL4HezAD9UqDWUg5K4qYD0MGY2X
   S72SsfCBfFEK559OE+gYIpyypENZr5CN2KQFs9m2BObO3W9ybj0hJ9APl
   9LUKj8/DFT6da8GjqnZ/3WlnswMDQq7VFD2UJmeOxeqqh4oGXTsm7hqRP
   VlBAi4kTCaEIg9st2JUWLuqmo9cF9l3eb98WrdflvnmFhk8NdG/rIfuCj
   4kmMi2k7g5hoL0K9CSXju6NI+ID83eE+lz5C3etZ4HJpCW5CrH/A8lT1P
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="315061531"
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="315061531"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 01:29:35 -0800
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="643178291"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.249.175.216]) ([10.249.175.216])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 01:29:29 -0800
Message-ID: <e8452e86-4063-c85b-5e21-c7cd6ce51423@intel.com>
Date:   Mon, 7 Mar 2022 17:29:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCHv5 23/30] x86/boot: Avoid #VE during boot for TDX platforms
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-24-kirill.shutemov@linux.intel.com>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20220302142806.51844-24-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/2022 10:27 PM, Kirill A. Shutemov wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> There are a few MSRs and control register bits that the kernel
> normally needs to modify during boot. But, TDX disallows
> modification of these registers to help provide consistent security
> guarantees. Fortunately, TDX ensures that these are all in the correct
> state before the kernel loads, which means the kernel does not need to
> modify them.
> 
> The conditions to avoid are:
> 
>   * Any writes to the EFER MSR
>   * Clearing CR3.MCE

typo. CR4.MCE

BTW, I remember there was a patch to clear X86_FEATURE_MCE for TDX 
guest. Why does that get dropped?

Even though CPUID reports MCE is supported, all the access to MCE 
related MSRs causes #VE. If they are accessed via mce_rdmsrl(), the #VE 
will be fixed up and goes to ex_handler_msr_mce(). Finally lead to panic().



