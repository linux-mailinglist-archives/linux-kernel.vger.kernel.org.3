Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EFF4DCAB2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 17:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbiCQQFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 12:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbiCQQFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 12:05:03 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4BCDF489
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 09:03:46 -0700 (PDT)
Received: from zn.tnic (p200300ea971561b0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9715:61b0:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 86C921EC05ED;
        Thu, 17 Mar 2022 17:03:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647533020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5VUfRHfWHVA+gcxjNm08CCSSttzTC3qvo8Yb9E+0C2k=;
        b=mBaP5fadVWXFH/Ybi9iJLJBoNCuVskrcwqBX7//yYlYnZzLbLBfeM+IL+WmaVexA9CatWt
        u+3Ydy6O2jq781W2vh9dDBPd7oWIp+cIq1vjM6WA0YKM1d/t2ps0rjGoC6OjzQl4rKbpz8
        TqDtO4dzyUYpkEMExNM/ftfGqWim2lQ=
Date:   Thu, 17 Mar 2022 17:03:37 +0100
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
Subject: Re: [PATCHv6 03/30] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
Message-ID: <YjNb2bTrlA4LyZKH@zn.tnic>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-4-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220316020856.24435-4-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 05:08:29AM +0300, Kirill A. Shutemov wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Guests communicate with VMMs with hypercalls. Historically, these
> are implemented using instructions that are known to cause VMEXITs
> like VMCALL, VMLAUNCH, etc. However, with TDX, VMEXITs no longer
> expose the guest state to the host. This prevents the old hypercall
> mechanisms from working. So, to communicate with VMM, TDX
> specification defines a new instruction called TDCALL.

...

> For registers used by the TDCALL instruction, please check TDX GHCI
> specification, the section titled "TDCALL instruction" and "TDG.VP.VMCALL
> Interface".
> 
> Based on previous patch by Sean Christopherson.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
>  arch/x86/coco/tdx/Makefile    |   2 +-
>  arch/x86/coco/tdx/tdcall.S    | 191 ++++++++++++++++++++++++++++++++++
>  arch/x86/coco/tdx/tdx.c       |  23 ++++
>  arch/x86/include/asm/tdx.h    |  27 +++++
>  arch/x86/kernel/asm-offsets.c |   8 ++
>  5 files changed, 250 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/coco/tdx/tdcall.S

With tglx's comment fixed:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
