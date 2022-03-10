Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51894D4C71
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbiCJOz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 09:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346141AbiCJOtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:49:36 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D162617ED9A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 06:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646923433; x=1678459433;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z+11wkJOD/vA+fM8tCXnoUVYGs10iBcAgMPNdioXP5w=;
  b=j1c+jOyuK9V9SAE4jUawgjmHhd6KOFS7f9St0CBg0lnkuL2yHrpyrvkT
   0RBCUceZr8CPMJ4ImWS33NcplvZoec0XUEybzfniUA7oo5DYSb7obhEQ/
   rjDLmXwSnWAbaXq5PkG5eGBl6VmOfxIp6GVuof6OwnOmk33l3bE8CajIB
   Hy6jShLU/9A2UBUZd65dhJzf4oOCkWuf7SDUO8cYGa5bjQ1TDd5xBlehh
   Lhi7dFgDRGm3Nk03NSElEtKu0kL2kL/DNSGFu1TH3SsrHhBA49zmbJoQ4
   isYAQMPDQHR+F0EKYG+yYgGfBebt9MdlYGLwHcMgpFDj2PxwsCTTaVEmt
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="341692566"
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="341692566"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 06:43:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="554670639"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 10 Mar 2022 06:43:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 1A67B348; Thu, 10 Mar 2022 16:44:05 +0200 (EET)
Date:   Thu, 10 Mar 2022 17:44:04 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 02/30] x86/tdx: Provide common base for SEAMCALL and
 TDCALL C wrappers
Message-ID: <20220310144404.5g4asrzzxwon7v7u@black.fi.intel.com>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-3-kirill.shutemov@linux.intel.com>
 <Yinv6Dptnj0aTf/Y@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yinv6Dptnj0aTf/Y@zn.tnic>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 01:32:40PM +0100, Borislav Petkov wrote:
> On Wed, Mar 02, 2022 at 05:27:38PM +0300, Kirill A. Shutemov wrote:
> >  arch/x86/include/asm/tdx.h    | 28 +++++++++++
> >  arch/x86/kernel/asm-offsets.c |  9 ++++
> >  arch/x86/virt/tdxcall.S       | 95 +++++++++++++++++++++++++++++++++++
> 
> Right, you asked already about putting this under arch/x86/virt/ but on
> a second thought, this doesn't look like
> 
> "- generic host virtualization stuff: arch/x86/virt/"
> 
> to me:
> 
> https://lore.kernel.org/r/Yg5nh1RknPRwIrb8@zn.tnic
> 
> Rather, this looks like it wants to be under
> 
>  arch/x86/virt/vmx/tdx/
> 
> where we said that this should be the coco host code place.

I'm fine moving where you want. But I want to make sure we are on the same
page: this code is common for guest and host TDX. I think VMX referes more
to host side of the thing, no?

-- 
 Kirill A. Shutemov
