Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2551E4C3CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 05:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbiBYEA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 23:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbiBYEA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 23:00:28 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C2E23530A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 19:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645761597; x=1677297597;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=ZTlLlTrkyzrxoL/SKbX4p7t/lx+ysnaOrEF3UkE9zwc=;
  b=KdDgN9Z3J9b3MaFBq9pHp9RuWWDKy7HprEdc1pCCSR9osG+qfdKHzjcP
   G6AJQAV7AdF/qWcgfG4NiiW2ZxyG9uiv4sUfok4CjDqM8wbj87oxRYQKi
   6Ox7dURU4wpHf7mAPtC/O8eoWIaNYupqeWOZNzMxtHxnDKeJsPgAl6anu
   C6X9bmsTK1rcDG60BhUuwhnV0pVmxBuGywwzg4tfAdXsX4qPNJxSJWYd3
   uLoyNaS6kfWlaqvKc4JuquiOP4I+vBGbV8i/0Fa5EN5uI2+7VB/cbRCL5
   ye6qYFeboobN6fksGITt1Y/9DsqBro0R2jK/WlAIoxnxUv2x0uV5XvRUb
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="249996618"
X-IronPort-AV: E=Sophos;i="5.90,135,1643702400"; 
   d="scan'208";a="249996618"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 19:59:56 -0800
X-IronPort-AV: E=Sophos;i="5.90,135,1643702400"; 
   d="scan'208";a="707723350"
Received: from hthen-mobl2.amr.corp.intel.com (HELO [10.209.48.194]) ([10.209.48.194])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 19:59:56 -0800
Message-ID: <dd370f1e-e9f9-0843-da24-83ad6f99ec76@intel.com>
Date:   Thu, 24 Feb 2022 19:59:51 -0800
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
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-18-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 17/30] x86/tdx: Add port I/O emulation
In-Reply-To: <20220224155630.52734-18-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/22 07:56, Kirill A. Shutemov wrote:
> @@ -347,6 +399,8 @@ static bool virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
>  		return handle_cpuid(regs);
>  	case EXIT_REASON_EPT_VIOLATION:
>  		return handle_mmio(regs, ve);
> +	case EXIT_REASON_IO_INSTRUCTION:
> +		return handle_io(regs, ve->exit_qual);

Sorry to keep throwing random new things at this patch set.  Thanks for
bearing with me.

Is there anything to keep these port I/O #VE's from occurring in
userspace?  It's not how things are normally done, but is there
something fundamental to keep ioperm() and friends from working in TDX
guests?

As it stands with this set, userspace would probably
1. Succeed with the ioperm()
2. Do a port I/O instruction
3. Trigger a #VE
4. Get killed by the SIGSEGV that came from the #VE handler

That's not a horrible state of affairs.  But, if this *can* happen, it
might be nice to just refuse the ioperm() in the first place.
