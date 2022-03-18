Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847A24DDD10
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238135AbiCRPgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238261AbiCRPgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:36:12 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06C0E6167
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647617681; x=1679153681;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tDH8y8H56kw42ru4l2FeHQVd5mygCEDJmX/rs5CR0vg=;
  b=MDvH+iy2x7HdcJUeDNvFM29FeJI1Ziu8DvwZEn/p5W3mupr3vSZsuu+c
   c6U/OD1WU623INPxua6ppDx1NC7k9CnrBDvhfgmE1RJWNFn5Q/cEvVajg
   Gb4pW8pYFMuCZYVii5xJKecxiA/5BU+A64om9SaKBGZSi7g4lOY1kNFqp
   PiwEit/4/taln4m6tC6tlrcD/4SaJ6Mnw48WHk28DqW0/c0bk41K4ZGDM
   AqQUpac+96WnjB0vsSMvkwQgQNGKuHJ71K9u1L4a4PZ1CAkhJDZ4tGnPL
   96Dy9hT7azURtaD3pbJejy0a0uf+w6g+qngIf1svuVk/8ajLncgjfX8FE
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="257344887"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="257344887"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 08:34:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="581753929"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 18 Mar 2022 08:34:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 8E23910E; Fri, 18 Mar 2022 17:34:54 +0200 (EET)
Date:   Fri, 18 Mar 2022 18:34:54 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        bp@alien8.de, dave.hansen@intel.com, luto@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCHv6 07/30] x86/traps: Add #VE support for TDX guest
Message-ID: <20220318153454.7ciwicqfghiwnv2t@black.fi.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-8-kirill.shutemov@linux.intel.com>
 <877d8t2ykp.ffs@tglx>
 <20220317173354.rqymufl37lcrtmjh@black.fi.intel.com>
 <20220317202141.GO8939@worktop.programming.kicks-ass.net>
 <87a6dncphl.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6dncphl.ffs@tglx>
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 03:19:34PM +0100, Thomas Gleixner wrote:
> On Thu, Mar 17 2022 at 21:21, Peter Zijlstra wrote:
> > On Thu, Mar 17, 2022 at 08:33:54PM +0300, Kirill A. Shutemov wrote:
> >>  - in NMI entry code (asm_exc_nmi()) before NMI nesting is safe:
> >>    + for NMI from user mode, before switched to thread stack
> >>    + for NMI from kernel, up to end_repead_nmi
> >> 
> >> After that points #VE is safe.
> >
> > In what way is it guaranteed that #VE isn't raised in those places? What
> > does an auditor / future coder looking to changes things, need to
> > consider to keep this so.
> >
> > From vague memories #VE can be raised on any memop, loading the stack
> > address in the syscall-gap is a memop. What makes that special? Can we
> > get a comment _there_ to explain how this is safe such that we can keep
> > it so?
> >
> > Same for the NMI path I suppose.
> 
> #VE is raised by HLT, CPUID, I/O-Port access, MSR read/write, EPT violations
> 
> So in the hairy places:
> 
>  - HLT:       No business
>  - I/O Ports: That would be outright stupid to use
> 
>  - CPUID:     Should never be used - Emphasis on should :)
>  - MSRs:      Same as CPUID
> 
>  - EPT:       Well....

EPT violation may result in #VE only on shared memory. If entry code
touches shared memory we have a bigger problem than syscall gap.

-- 
 Kirill A. Shutemov
