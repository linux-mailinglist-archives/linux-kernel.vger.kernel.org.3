Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3919D4C584E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 22:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiBZVf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 16:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiBZVfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 16:35:53 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C993EAB2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 13:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645911318; x=1677447318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ABHXPyLf9DH9P8AEQlAcCPueLZImr+LMg/WBjb5qjoc=;
  b=Q1I2jvNZ4u5OLQKwuegg3f4Lxi6AB5wVTPlD/YtCg5Hzi95w31bTm2EU
   k+gEwZ91gPGrYnFSXNk1dj39n6Ht804Q2OQuJ/qr+p1EnX6e9zJHGVb4R
   y9goT9UdzTi1SKrZKqgTIoiAh6fnUf4xG5x7eE1Uo4gCDHZQCsZHa5fCa
   z9RUCT4xTXLVNQWv6T/zwmZrAn3XjyzbdTMCE9UdBMfrvVyC8XEjwfsqh
   uz8WfmaPjf+VkWGcJcHo4PpEVpRq05agCVL/a3MWYpdXKrzBpnfoQaMb7
   CgDMjZixyIORhUeLpiLsMbeISxOrrdV/EKeNjOVIXfKCcgQZB2B+0T2W3
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="251517182"
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="251517182"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 13:35:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="574930008"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 26 Feb 2022 13:35:12 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 15F8894; Sat, 26 Feb 2022 23:35:28 +0200 (EET)
Date:   Sun, 27 Feb 2022 00:35:28 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 09/30] x86/tdx: Add MSR support for TDX guests
Message-ID: <20220226213528.tt5uchvmvo67w4tb@black.fi.intel.com>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-10-kirill.shutemov@linux.intel.com>
 <67dfdb0c-c483-ec3c-4fb8-57086ffde9bf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67dfdb0c-c483-ec3c-4fb8-57086ffde9bf@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 10:52:23AM -0800, Dave Hansen wrote:
> On 2/24/22 07:56, Kirill A. Shutemov wrote:
> > Use hypercall to emulate MSR read/write for the TDX platform.
> > 
> > There are two viable approaches for doing MSRs in a TD guest:
> > 
> > 1. Execute the RDMSR/WRMSR instructions like most VMs and bare metal
> >    do. Some will succeed, others will cause a #VE. All of those that
> >    cause a #VE will be handled with a TDCALL.
> > 2. Use paravirt infrastructure.  The paravirt hook has to keep a list
> >    of which MSRs would cause a #VE and use a TDCALL.  All other MSRs
> >    execute RDMSR/WRMSR instructions directly.
> > 
> > The second option can be ruled out because the list of MSRs was
> > challenging to maintain. That leaves option #1 as the only viable
> > solution for the minimal TDX support.
> > 
> > For performance-critical MSR writes (like TSC_DEADLINE), future patches
> > will replace the WRMSR/#VE sequence with the direct TDCALL.
> 
> This will still leave us with a list of non-#VE-inducing MSRs.  That's
> not great.

Em. No. TSC_DEADLINE is #VE-inducing MSR. So we will only maintain a list
of performance-critical MSR writes that do trigger #VE.

Here's how we do it now:

https://github.com/intel/tdx/commit/2cea8becaa5a287c93266c01fc7f2a4ed53c509d

The idea is if MSR is in the list, go for direct TDVMCALL. Otherwise go for
native WRMSR that may or may not trigger #VE.

> But, if we miss an MSR in the performance-critical list, the
> result is a slow WRMSR->#VE.  If we miss an MSR in the paravirt
> approach, we induce a fatal #VE.
> 
> Please add something to that effect if you revise this patch.

I'm not sure explaining mechanism of a future patch is a good idea.
It may change before it gets implemented.

-- 
 Kirill A. Shutemov
