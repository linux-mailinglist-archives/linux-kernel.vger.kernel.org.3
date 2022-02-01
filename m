Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE62B4A650C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 20:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242426AbiBAT37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 14:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239468AbiBAT36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:29:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8471AC061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 11:29:58 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643743795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sqo/X1CBdJPoEwvfK08zJ6ZLUL+LTL7XqrzT6Vvi2ew=;
        b=uZToVoh/3+oHdBSkPQ/a6y1rsdhaunTajCkeKUrW03nM5M+w8gw2F27TAtz0Lm/A7Lifz2
        6uxMt3Vl9G5NOLLO8OY+TuDU/Ovgyht864eGVPhm+gra6+Mqg4oAu9B+5CNQVFrGoLYZG8
        +9SVrnqeVPSWTk3xdsvPt7wdbbur7iG+1eer7tUck2COqxYBPs0qG5p1aLUUDdMKxX8Opm
        jZpZqiO4FkD/VOYOkATJPatKOLcdwN8tdF+rjy1noIV1BBqdNUOhZA1Q/5+rneo3bI2mAF
        2BMW6cc/Vs3T9kaA4+I3XaVd5tOKYixA3IYTrre5Ii/799BJZYgH+f1UWMahPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643743795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sqo/X1CBdJPoEwvfK08zJ6ZLUL+LTL7XqrzT6Vvi2ew=;
        b=TxNtIOKH/5uvnScdV8+LlwMFkDYSzgEo3lcRwVhHSNbvw5UdP+XrsJa3Zc7Q8vhqzOgd5x
        ERY6exf45T/tVsDg==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 01/29] x86/tdx: Detect running as a TDX guest in early
 boot
In-Reply-To: <20220124150215.36893-2-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-2-kirill.shutemov@linux.intel.com>
Date:   Tue, 01 Feb 2022 20:29:55 +0100
Message-ID: <87fsp2z8p8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill,

On Mon, Jan 24 2022 at 18:01, Kirill A. Shutemov wrote:

Just a nitpick...

> +static bool tdx_guest_detected __ro_after_init;
> +
> +bool is_tdx_guest(void)
> +{
> +	return tdx_guest_detected;
> +}
> +
> +void __init tdx_early_init(void)
> +{
> +	u32 eax, sig[3];
> +
> +	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2],  &sig[1]);
> +
> +	if (memcmp(TDX_IDENT, sig, 12))
> +		return;
> +
> +	tdx_guest_detected = true;
> +
> +	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);

So with that we have two ways to detect a TDX guest:

   - tdx_guest_detected

   - X86_FEATURE_TDX_GUEST

Shouldn't X86_FEATURE_TDX_GUEST be good enough?

Thanks,

        tglx
