Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201624A9187
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 01:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356187AbiBDAQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 19:16:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56660 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245100AbiBDAQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 19:16:51 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643933809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y3pautk4858+TJ9acUt+lAWsSvXk3yXbgosZPH/JGB0=;
        b=lDl+divrl1HxJj7DuZlTTW/hUAVdkO4dlZVtUM/TjyS9/2dN4ITrrXY/CZSZoBF642Jdgt
        picK1Dq6DTcF0vGDvxrKQv+spk4SqsvePh2DC8pt3+A2296ub5yrqnOxQGVV/gLVV4bubf
        wA9GpUDVTkfcyXgpsvk75pR8IATm4Oqt4+7FV8iJ8rRC1SHhci1MY74O3RKqkV1CDq+Emc
        DgzSvuiCFJft0bxEAUdjfec4IrNKkHVxP5oXs9mdqOBoHvRJBFh9bvQe3zqaE/scPrcanR
        Q8G2I+2RuPG3k7NoN71n97IL7AoHVKZ3xoA94g273Rq5FFFTlmJtAccUXC97cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643933809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y3pautk4858+TJ9acUt+lAWsSvXk3yXbgosZPH/JGB0=;
        b=T/pAjUzAgPMK6ILlOcLrLAemCTNHEAYYWzD+tdSBMKXaKMFMlfVQj/kK/hA3rtA5NvEHXS
        rZkMX2SoR/AYssCg==
To:     Bill Wendling <morbo@google.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, llvm@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, Bill Wendling <morbo@google.com>
Subject: Re: [PATCH v2] x86: use builtins to read eflags
In-Reply-To: <20211229021258.176670-1-morbo@google.com>
References: <20211215211847.206208-1-morbo@google.com>
 <20211229021258.176670-1-morbo@google.com>
Date:   Fri, 04 Feb 2022 01:16:49 +0100
Message-ID: <87mtj7cwpa.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28 2021 at 18:12, Bill Wendling wrote:
> GCC and Clang both have builtins to read and write the EFLAGS register.
> This allows the compiler to determine the best way to generate this
> code, which can improve code generation.
>
> This issue arose due to Clang's issue with the "=rm" constraint.  Clang
> chooses to be conservative in these situations, and so uses memory
> instead of registers. This is a known issue, which is currently being
> addressed.
>
> However, using builtins is benefiical in general, because it removes the
> burden of determining what's the way to read the flags register from the
> programmer and places it on to the compiler, which has the information
> needed to make that decision. Indeed, this piece of code has had several
> changes over the years, some of which were pinging back and forth to
> determine the correct constraints to use.
>
> With this change, Clang generates better code:
>
> Original code:
>         movq    $0, -48(%rbp)
>         #APP
>         # __raw_save_flags
>         pushfq
>         popq    -48(%rbp)
>         #NO_APP
>         movq    -48(%rbp), %rbx
>
> New code:
>         pushfq
>         popq    %rbx
>         #APP
>
> Note that the stack slot in the original code is no longer needed in the
> new code, saving a small amount of stack space.

This still lacks any information about the effect on GCC. There is a
world outside clang. It's not my job to validate that.

Thanks,

        tglx
