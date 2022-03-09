Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE1A4D38A9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbiCISXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236910AbiCISXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:23:02 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C104E3B9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 10:22:02 -0800 (PST)
Received: from zn.tnic (p200300ea971938593bb3add11194ca93.dip0.t-ipconnect.de [IPv6:2003:ea:9719:3859:3bb3:add1:1194:ca93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5FD5B1EC0432;
        Wed,  9 Mar 2022 19:21:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646850116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=IsOVpMPcizR6bHO4I45uLVnC2BgbB7S8cz/JByjSm34=;
        b=O8rVJVHJb5xJKgodufVOmkTaR58WFfDO13XI7sBhmii5TnMXuRZt3WuojLR6kCcd/1mlzt
        XdeSNVPD1Xu0Qg0/xgA1eCpt/bJkDriQ1JiBldozyHDb2IZB3wOOUDPfgvIi8+ucxQX3ry
        j8GQatue8Xa47A3uZsGXyVI75umlnmA=
Date:   Wed, 9 Mar 2022 19:22:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     aarcange@redhat.com, ak@linux.intel.com, brijesh.singh@amd.com,
        dan.j.williams@intel.com, dave.hansen@intel.com,
        dave.hansen@linux.intel.com, david@redhat.com, hpa@zytor.com,
        jgross@suse.com, jmattson@google.com, joro@8bytes.org,
        jpoimboe@redhat.com, knsathya@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tglx@linutronix.de, thomas.lendacky@amd.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
Subject: Re: [PATCHv5.1 01/30] x86/tdx: Detect running as a TDX guest in
 early boot
Message-ID: <YijwSjP2rlvwi0mi@zn.tnic>
References: <YiI4GXQt5YOXr4qW@nazgul.tnic>
 <20220307222456.2275-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220307222456.2275-1-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 01:24:56AM +0300, Kirill A. Shutemov wrote:
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
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
>  v5.1:
>    - Drop BUILD_BUG_ON()
> ---
>  arch/x86/Kconfig                         | 12 ++++++++++++
>  arch/x86/coco/Makefile                   |  2 ++
>  arch/x86/coco/tdx.c                      | 22 ++++++++++++++++++++++
>  arch/x86/include/asm/cpufeatures.h       |  1 +
>  arch/x86/include/asm/disabled-features.h |  8 +++++++-
>  arch/x86/include/asm/tdx.h               | 21 +++++++++++++++++++++
>  arch/x86/kernel/head64.c                 |  4 ++++
>  7 files changed, 69 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/coco/tdx.c
>  create mode 100644 arch/x86/include/asm/tdx.h

I don't know how many versions of this patch I've reviewed by now. Oh
well, finally:

Reviewed-by: Borislav Petkov <bp@suse.de>

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
