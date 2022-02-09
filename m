Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B534AF0AA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiBIMEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbiBIMDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:03:30 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F678C002146
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 03:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644407319; x=1675943319;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KIul0VRH8+851bLTssNY2JClhDKRKqDCUngDw8TQE8Y=;
  b=fBFDjLuLOGfSMbAdOdqo5OxtMhogq67Wb4RZZhufn0Bgn1YctTeNjhCa
   x/5KuOu9sYLLl9jUxcjySA+ALTEhmTPBff+m4aaLz6qp6cOmEuIiWf8gm
   Wmp+kWDiZbikqahrzms/ACIukuzErSzxsTfRVJj4StBArd0ThnHma+SIs
   YaCPGDkXOWaS5eI/IYhvAX4FFrVbb08DIwmtt+JOizySWfX271WPfHl5r
   OGxG3n7kTJJLbuNSBiZqwOPJeBHGAGDT1fP8oTn8+FHtaDfsvDB5cxoRl
   VHnylqH7Kfu9dSvNkXcX/tgjEHQM+Ybzxmh6zX4vT3siuPaH1vKgpQPOx
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="232752854"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="232752854"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 03:48:38 -0800
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="536905809"
Received: from ravicha1-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.255.88.114])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 03:48:33 -0800
Date:   Thu, 10 Feb 2022 00:48:31 +1300
From:   Kai Huang <kai.huang@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 00/29] TDX Guest: TDX core support
Message-Id: <20220210004831.03dea501738bee060003d040@intel.com>
In-Reply-To: <YgOoId+vyd1VhIqQ@zn.tnic>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
        <20220209235613.652f5720cd196331d7a220ec@intel.com>
        <YgOgog9Pb886lfsv@zn.tnic>
        <20220210003033.e57c2925b69bab5cfabf7292@intel.com>
        <YgOoId+vyd1VhIqQ@zn.tnic>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2022 12:40:17 +0100 Borislav Petkov wrote:
> On Thu, Feb 10, 2022 at 12:30:33AM +1300, Kai Huang wrote:
> > Because SEAM, P-SEAMLDR can logically be independent, so I feel it's better to
> > have separate C files for them.
> 
> Most of those look like small files. I don't see the point of having it
> all in separate files - you can just as well put them in tdx.c and carve
> out only then when the file becomes too unwieldy to handle.

arch/x86/kernel/tdx.c is already taken by this series.  This is the reason that
I think perhaps it's better to rename it to reflect it is for TDX guest support.

> 
> > Thanks for the information.  However, for now does it make sense to also put
> > TDX host files under arch/x86/kernel/, or maybe arch/x86/kernel/tdx_host/?
> 
> Didn't you just read what I wrote about "kernel"?
> 
> > As suggested by Thomas, host SEAMCALL can share TDX guest's __tdx_module_call()
> > implementation.  Kirill will have a arch/x86/kernel/tdxcall.S which implements
> > the core body of __tdx_module_call() and is supposed to be included by the new
> > assembly file to implement the host SEAMCALL function.  From this perspective,
> > it seems more reasonable to just put all TDX host files under arch/x86/kernel/?
> 
> It would be a lot harder to move them to a different location later,
> when they're upstream already. I'm talking from past experience here.

Are you suggesting even for now we can start to put TDX host support to
arch/x86/coco/tdx/ ?

> 
> But let's see what the others think first.

Sure thanks for comments.

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
