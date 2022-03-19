Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F444DE8DD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 15:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243373AbiCSOtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 10:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbiCSOto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 10:49:44 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5CD15DAB5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 07:48:21 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4728C1EC01B7;
        Sat, 19 Mar 2022 15:48:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647701296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=A1lIPONa4OOmMy6w8rSCAQDgl4szx5g6Tyy1kQ+3xoI=;
        b=kbDSdgLtrI3LxND36biPT8CfQyGgvqEvl/innlbxfZtdkAjiCS7ivGdy8E0d3hVpQnZlIX
        qLsD4ZHYe+tMRJI1qf5E6EE1lqZVfoGd88woudhPCQJ3yUfoZYzQTJSMu+P9K3hRrC8B2U
        qfw2xOgJ2443fRxu09hfk/6T4SXW++A=
Date:   Sat, 19 Mar 2022 15:48:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
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
Subject: Re: [PATCHv7 02/30] x86/tdx: Provide common base for SEAMCALL and
 TDCALL C wrappers
Message-ID: <YjXtK4awY6utz3wE@zn.tnic>
References: <20220318153048.51177-1-kirill.shutemov@linux.intel.com>
 <20220318153048.51177-3-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220318153048.51177-3-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 06:30:20PM +0300, Kirill A. Shutemov wrote:
> Secure Arbitration Mode (SEAM) is an extension of VMX architecture.  It
> defines a new VMX root operation (SEAM VMX root) and a new VMX non-root
> operation (SEAM VMX non-root) which are both isolated from the legacy
> VMX operation where the host kernel runs.
> 
> A CPU-attested software module (called 'TDX module') runs in SEAM VMX
> root to manage and protect VMs running in SEAM VMX non-root.  SEAM VMX
> root is also used to host another CPU-attested software module (called
> 'P-SEAMLDR') to load and update the TDX module.
> 
> Host kernel transits to either P-SEAMLDR or TDX module via the new
> SEAMCALL instruction, which is essentially a VMExit from VMX root mode
> to SEAM VMX root mode.  SEAMCALLs are leaf functions defined by
> P-SEAMLDR and TDX module around the new SEAMCALL instruction.
> 
> A guest kernel can also communicate with TDX module via TDCALL
> instruction.
> 
> TDCALLs and SEAMCALLs use an ABI different from the x86-64 system-v ABI.
> RAX is used to carry both the SEAMCALL leaf function number (input) and
> the completion status (output).  Additional GPRs (RCX, RDX, R8-R11) may
> be further used as both input and output operands in individual leaf.
> 
> TDCALL and SEAMCALL share the same ABI and require the largely same
> code to pass down arguments and retrieve results.
> 
> Define an assembly macro that can be used to implement C wrapper for
> both TDCALL and SEAMCALL.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> TDCALL wrapper will be implemented using the macro later in the series.
> SEAMCALL wrapper is out-of-scope for the series and will be implemented
> as part of TDX host enabling.
> ---
>  arch/x86/include/asm/tdx.h      | 28 ++++++++++
>  arch/x86/kernel/asm-offsets.c   |  9 ++++
>  arch/x86/virt/vmx/tdx/tdxcall.S | 94 +++++++++++++++++++++++++++++++++
>  3 files changed, 131 insertions(+)
>  create mode 100644 arch/x86/virt/vmx/tdx/tdxcall.S

Instead of hurrying to send the set again two days after the v6 one -

  [ I frankly wonder why you're even in such a hurry - it seems people
    believe that hammering out the patches constantly would somehow get them
    upstreamed faster :-\ ]

- you should rather apply more diligence and take care of working in all
the comments from last review:

https://lore.kernel.org/r/87lex9321l.ffs@tglx

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
