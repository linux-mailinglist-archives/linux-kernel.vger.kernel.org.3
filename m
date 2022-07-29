Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9CD584F98
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 13:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbiG2LZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 07:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236086AbiG2LZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 07:25:12 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A20ED77
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 04:25:10 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-31f661b3f89so47616367b3.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 04:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/+Xle1HhYZA4u0BpE2NkhWcW76kE9EOZDKtebTajiOs=;
        b=YqDKC1LJ8obrUBAHVtCKP1Ti7IQdF4dDyDOze3YncGCUVtr/bhbRmvw1cFb9pV2fb0
         W/x9ahW7e9DESOkTZtefKbXMf5Mz9nQwFLCJwMYBz+mpKcb7sASZrgCK2pcY8oT7DxMU
         j37ZZSrS/4u3LDCgyZAQZXVFCazQm/pzND+FSfq11oKnw0lrb4GQV5N5jvgtWHK+SpYN
         OPoGRXd+YyqputV1G3mwVYzkZHbrWrv1BPOSUOxqjNj3+AGWbYXbktoKDbb22jv9cTRJ
         ehMhxiLsIPep01YuP7XecIFupjEYKx0NQLbBh01eNTC8w94JNyS3Iw4Ey+vgyPAMuCwk
         mimA==
X-Gm-Message-State: ACgBeo20QRXn+1H8Ig/Oiu4oeQvOLXkt47L9h6wvN7JPPJbCSkWtL31+
        gcP0od+AkFLJsZI6PFA9tmpPlwIvVTcfiFBvfcg=
X-Google-Smtp-Source: AA6agR4vyF0x47Jgt80gnEl94cVYa+Ot/cwsvfn8nZQ1pVGqtBnuuInF9zUL3vVRiAm9LfYeN3e4a0I/onBCnkpLX2A=
X-Received: by 2002:a0d:e682:0:b0:322:b5e1:5ed4 with SMTP id
 p124-20020a0de682000000b00322b5e15ed4mr2611471ywe.220.1659093909158; Fri, 29
 Jul 2022 04:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr> <20220723151521.51451-1-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20220723151521.51451-1-mailhol.vincent@wanadoo.fr>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Fri, 29 Jul 2022 20:24:58 +0900
Message-ID: <CAMZ6Rq+KohWoRurA3cKog18D=NuXNj_k4+ZmPRiakZd7ZPS1OQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 0/2] x86/asm/bitops: optimize ff{s,z} functions
 for constant expressions
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Jan Beulich <JBeulich@suse.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Joe Perches <joe@perches.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 24 Jul. 2022 at 00:15, Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
> The compilers provide some builtin expression equivalent to the ffs(),
> __ffs() and ffz() function of the kernel. The kernel uses optimized
> assembly which produces better code than the builtin
> functions. However, such assembly code can not be optimized when used
> on constant expression.
>
> This series relies on __builtin_constant_p to select the optimal solution:
>
>   * use kernel assembly for non constant expressions
>
>   * use compiler's __builtin function for constant expressions.
>
>
> ** Statistics **
>
> Patch 1/2 optimizes 26.7% of ffs() calls and patch 2/2 optimizes 27.9%
> of __ffs() and ffz() calls (details of the calculation in each patch).
>
>
> ** Changelog **
>
> v3 -> v4:
>
>   * (no changes on code, only commit comment was modified)
>
>   * Remove note and link to Nick's message in patch 1/2, c.f.:
>   https://lore.kernel.org/all/CAKwvOdnnDaiJcV1gr9vV+ya-jWxx7+2KJNTDThyFctVDOgt9zQ@mail.gmail.com/
>
>   * Add Reviewed-by: Nick Desaulniers <ndesaulniers@google.com> in tag in patch 2/2.
>
>
> v2 -> v3:
>
>   * Redacted out the instructions after ret and before next function
>     in the assembly output.
>
>   * Added a note and a link to Nick's message on the constant
>     propagation missed-optimization in clang:
>     https://lore.kernel.org/all/CAKwvOdnH_gYv4qRN9pKY7jNTQK95xNeH1w1KZJJmvCkh8xJLBg@mail.gmail.com/
>
>   * Fix copy/paste typo in statistics of patch 1/2. Number of
>     occurences before patches are 1081 and not 3607 (percentage
>     reduction of 26.7% remains correct)
>
>   * Rename the functions as follow:
>     - __varible_ffs() -> variable___ffs()
>     - __variable_ffz() -> variable_ffz()
>
>   * Add Reviewed-by: Nick Desaulniers <ndesaulniers@google.com> in tag in patch 1/2.
>
> Vincent Mailhol (2):
>   x86/asm/bitops: ffs: use __builtin_ffs to evaluate constant
>     expressions
>   x86/asm/bitops: __ffs,ffz: use __builtin_ctzl to evaluate constant
>     expressions
>
>  arch/x86/include/asm/bitops.h | 64 +++++++++++++++++++++--------------
>  1 file changed, 38 insertions(+), 26 deletions(-)

Hi Thomas, Ingo, Borislav, Dave and Peter,

This patch series [1] has been waiting for more than two months
already. So far, I have not heard back from any of the x86 mainteners.
Do you see anything wrong with this series? If not, any chances to
have someone of you to pick it up?

[1] https://lore.kernel.org/all/20220625072645.251828-1-mailhol.vincent@wanadoo.fr/#t

Thank you,


Yours sincerely,
Vincent Mailhol
