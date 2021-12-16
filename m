Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D94C477B94
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 19:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240702AbhLPSdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 13:33:53 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52108 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239842AbhLPSdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 13:33:52 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 891D51EC059D;
        Thu, 16 Dec 2021 19:33:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639679627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2XAKT5ylKjRISpeqHPltyqnMBLx6AE41koW5i476JXw=;
        b=sNmNK8gXq5tHyjr1J+8kpr9Ef/hJnAtHeiisdnb9eBBRTt3hLb8K5xYnAOsqhBCkl7XPFz
        ddKWZzbOQtKPwB41GSth4K6WW2ohC3tI8nsa6bNgQ3Q7Z1WubSweEHyQzVhm/j+uo6u7ec
        LSDGVrox4BIHv4HYT+e3XrLDQIf9MAc=
Date:   Thu, 16 Dec 2021 19:33:50 +0100
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
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/26] x86/tdx: Extend the cc_platform_has() API to
 support TDX guests
Message-ID: <YbuGjtFhKFDGZE7q@zn.tnic>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-3-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211214150304.62613-3-kirill.shutemov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 06:02:40PM +0300, Kirill A. Shutemov wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Confidential Computing (CC) features (like string I/O unroll support,
> memory encryption/decryption support, etc) are conditionally enabled
> in the kernel using cc_platform_has() API. Since TDX guests also need
> to use these CC features, extend cc_platform_has() API and add TDX
> guest-specific CC attributes support.
> 
> Use is_tdx_guest() API to detect for the TDX guest status and return
> TDX-specific CC attributes. To enable use of CC APIs in the TDX guest,
> select ARCH_HAS_CC_PLATFORM in the CONFIG_INTEL_TDX_GUEST case.
> 
> This is a preparatory patch and just creates the framework for adding
> TDX guest specific CC attributes.
> 
> Since is_tdx_guest() function (through cc_platform_has() API) is used in
> the early boot code, disable the instrumentation flags and function
> tracer. This is similar to AMD SEV and cc_platform.c.
> 
> Since intel_cc_platform_has() function only gets triggered when

"... only gets called... "

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
