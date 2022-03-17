Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722854DC854
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbiCQOGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbiCQOGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:06:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582F9BCAB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 07:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647525923; x=1679061923;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UJwH4Qp1MP8RYi0LZsv/gcqMk1tUiY30AAEZAqJEryo=;
  b=fVTysvw5gmSs0AdNt93Iy1kvXipX+nzUPuzpw/bENlmQa31g2usAACJj
   S1uB97NSUt9FxNdynDtgWv7SKl4ooBnixJoKXcjHeQKvZbpteDMJWLW/J
   tnxdvUZADxjbAP/0kro0mqOfCIrz4RlLcC0Ms3SYYZqvCPf4zUQuncO5K
   P7kj3GBYED4buSt4gLehXmaeh4Rhe/Zwo4ffXaWmQfzN7FDPW/BJn71iO
   X6YRWuswhFcIPD2dwNWJgAN56rQdIxroFezEuH9WW3H/yReds0SsfO9x3
   WeTOMzQrNlqxITYvsZ1SJkRZM1NVKfcLUz+Zw9miLKm9yjRsfRVXkUxQP
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="254430362"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="254430362"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 07:05:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="635370355"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Mar 2022 07:05:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 9B6D3150; Thu, 17 Mar 2022 16:05:36 +0200 (EET)
Date:   Thu, 17 Mar 2022 17:05:36 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCHv6 06/30] x86/traps: Refactor exc_general_protection()
Message-ID: <20220317140536.ebab2nenzr64mizp@black.fi.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-7-kirill.shutemov@linux.intel.com>
 <87a6dp2ztq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6dp2ztq.ffs@tglx>
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 01:21:53AM +0100, Thomas Gleixner wrote:
> On Wed, Mar 16 2022 at 05:08, Kirill A. Shutemov wrote:
> > TDX brings a new exception -- Virtualization Exception (#VE). Handling
> > of #VE structurally very similar to handling #GP.
> >
> > Extract two helpers from exc_general_protection() that can be reused for
> > handling #VE.
> >
> > No functional changes.
> >
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Not that I care much, but this is the second instance of something I
> suggested. We have tags for that...

Sorry, will add the tag.

By the other instance you meant common base for SEAMCALL and TDCALL C
wrappers, right? Will fix too.

> > +static bool gp_try_fixup_and_notify(struct pt_regs *regs, int trapnr,
> > +				    unsigned long error_code, const char *str)
> > +{
> > +	int ret;
> 
> Adding this to make my suggestion compile is the easy way out, but...
> 
> > +
> > +	if (fixup_exception(regs, trapnr, error_code, 0))
> > +		return true;
> > +
> > +	current->thread.error_code = error_code;
> > +	current->thread.trap_nr = trapnr;
> > +
> > +	/*
> > +	 * To be potentially processing a kprobe fault and to trust the result
> > +	 * from kprobe_running(), we have to be non-preemptible.
> > +	 */
> > +	if (!preemptible() && kprobe_running() &&
> > +	    kprobe_fault_handler(regs, trapnr))
> > +		return true;
> > +
> > +	ret = notify_die(DIE_GPF, str, regs, error_code, trapnr, SIGSEGV);
> > +	return ret == NOTIFY_STOP;
> 
> Why not doing the obvious:
> 
> 	return notify_die(DIE_GPF, str, regs, error_code, trapnr, SIGSEGV) == NOTIFY_STOP;
> 
> Hmm?

I don't like lines this long (although my variant doesn't look good too).

Will do your way.

-- 
 Kirill A. Shutemov
