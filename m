Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51667487A4D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 17:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348234AbiAGQ1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 11:27:44 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41532 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348227AbiAGQ1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 11:27:42 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B86331EC01A8;
        Fri,  7 Jan 2022 17:27:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1641572856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=V21xX9QiWWNkjlhs2feSc5Dlafm4kXvmjvNpwH1JrFE=;
        b=pdPONbDfYvp/b4p0+Qf8MGvNrXkJuAGD46XCDTxphviS7s/PPrOe/uTmD9iVGT7YFsTrKc
        JwxzVo/3NuWXmIA6k1tXc9XON649eWA3HhPYrPZSoEGyYqzV4uwJqAdlRea4ozqa7/mvCg
        6fuA7YELs/tqdoEoKIxt+8pqydzdWvo=
Date:   Fri, 7 Jan 2022 17:27:38 +0100
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
Subject: Re: [PATCH 09/26] x86/tdx: Detect TDX at early kernel decompression
 time
Message-ID: <Ydhp+kD71G2sQrfU@zn.tnic>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-10-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211214150304.62613-10-kirill.shutemov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 06:02:47PM +0300, Kirill A. Shutemov wrote:
> @@ -370,6 +370,14 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>  	lines = boot_params->screen_info.orig_video_lines;
>  	cols = boot_params->screen_info.orig_video_cols;
>  
> +	/*
> +	 * Detect if we are running in TDX guest environment.

Please use passive voice: no "we" or "I", etc,

> +	 *
> +	 * It has to be done before console_init() to use paravirtualized
						  ^
						  in order

...

> +void early_tdx_detect(void)
> +{
> +	u32 eax, sig[3];
> +
> +	if (cpuid_max_leaf() < TDX_CPUID_LEAF_ID)

What's the use of that helper?

AFAICT, none because you call cpuid_count below anyway. And you use that
helper only here.

IOW, you can simply use cpuid_count() and not add it.

> +		return;
> +
> +	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2],  &sig[1]);
> +
> +	if (memcmp(TDX_IDENT, sig, 12))
> +		return;
> +
> +	/* Cache TDX guest feature status */
> +	tdx_guest_detected = true;
> +}

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
