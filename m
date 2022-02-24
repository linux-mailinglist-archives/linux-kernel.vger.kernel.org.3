Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D212C4C319F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiBXQjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiBXQjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:39:15 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2C418647C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 08:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645720724; x=1677256724;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=do58zTcSW3wRCK7YgRM0MT0AqvfNz5U5/d4kKegF3ZI=;
  b=LfpeOD2PI9ddtF64wTb3ZTmVIyjbvz3htj/sSqwgCE98mMAAPnnN19B5
   r/og+i42ekh/6r4ItxoYl8PveUKd3A0w/sJsLn17JtYz+n9KM373DGl4g
   /LjZjT5X44t/0wdSvQm8tdNYMWbYzxDfaK+5PuymAqvZQ8Zz2F4G8RsgW
   3Nnp3r8AKoQNa4k2WPHXQrRv5WL87GG7YoM4cjs2ATj5bxQv1Vu6WAW7+
   bqkpR/0WU4bsJ+5VjGK6QeB4Q43oIyLnLPxQP9fMNsiceFN42xLZr3HmM
   P3Hy+oNpxQRcQlXVqpWXqqvY1cVcQ8T2p9AyNVZbo16sSW+1YjEhFsJkc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="232896806"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="232896806"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 08:16:14 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="548811314"
Received: from vpirogov-mobl.amr.corp.intel.com (HELO [10.252.137.68]) ([10.252.137.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 08:16:13 -0800
Message-ID: <938a31f5-d77b-ba95-ea24-46ac00b9cbb8@intel.com>
Date:   Thu, 24 Feb 2022 08:16:08 -0800
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
 <20220224155630.52734-3-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 02/30] x86/tdx: Detect running as a TDX guest in early
 boot
In-Reply-To: <20220224155630.52734-3-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/22 07:56, Kirill A. Shutemov wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> In preparation of extending cc_platform_has() API to support TDX guest,
> use CPUID instruction to detect support for TDX guests in the early
> boot code (via tdx_early_init()). Since copy_bootdata() is the first
> user of cc_platform_has() API, detect the TDX guest status before it.
> 
> Define a synthetic feature flag (X86_FEATURE_TDX_GUEST) and set this
> bit in a valid TDX guest platform.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

I'm glad this *finally* converged on an X86_FEATURE flag alone.  Thanks
for fixing up the text:

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
