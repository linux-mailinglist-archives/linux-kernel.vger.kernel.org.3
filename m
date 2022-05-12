Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61AD5241F0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 03:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349859AbiELBS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 21:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349868AbiELBSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 21:18:54 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652FF7E587
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:18:52 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id m128so7121326ybm.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w4stT9a7FDgrQn5Qyvbf3ILrgD/C37efIbL6LozjRUM=;
        b=gzfYna/tFSGdr2hyUvQ/hJcSIG6oMTwyeQTlnODuHXSwe1zJpCids0p1FYB4+jAxj3
         yRfRr1HN4olh/ITBZmm8GV+3PXXje/vwhy/3GjAO3xHphsx44/x6RXbjwqW7qX3Cwg+n
         AY/4gYL6f82c+lRTZpgZFRZi8km7d0BET35G3mJP+dkgohXEoQvi//Ysaq5nJtL78Ofn
         S7XQCojpdqOntqrVxlgfPkFkkJEHU4K3KCruajCpLu6jzVXeahLfVomlUVyT/BY8HrGP
         EUWqMryFiZs4luLLDkMqNO+8lsFFrzR37B3hbo1OWQAEsYVeB7GghesvOY6yK+aItMRq
         nqdA==
X-Gm-Message-State: AOAM533LMmye/1VXbe9r8YN3UPNGTlgd7ZkrK5m1qtR1EXoZJy+VYDIr
        W+30dMLv+pLAnJPw+VeuCGTgXXE2w+ZXElqOcso=
X-Google-Smtp-Source: ABdhPJwcvEkxvkY7EbXbUN1ejuS/pf9M00xo1nrPv7jZAJkGKlmtUEKR6Ug3J5JY2M5YNk3sPr5W13L6HDUpJqQGhYQ=
X-Received: by 2002:a25:bbc5:0:b0:649:7ef0:1215 with SMTP id
 c5-20020a25bbc5000000b006497ef01215mr25915823ybk.142.1652318331641; Wed, 11
 May 2022 18:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
 <20220512000340.1171988-1-mailhol.vincent@wanadoo.fr> <20220512000340.1171988-2-mailhol.vincent@wanadoo.fr>
 <CAKwvOdnnDaiJcV1gr9vV+ya-jWxx7+2KJNTDThyFctVDOgt9zQ@mail.gmail.com>
In-Reply-To: <CAKwvOdnnDaiJcV1gr9vV+ya-jWxx7+2KJNTDThyFctVDOgt9zQ@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Thu, 12 May 2022 10:18:40 +0900
Message-ID: <CAMZ6RqJ_zU0DL1hiXE_xkOmHQFTxHPPt=c_bPUzGXWrjVJEKJg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] x86/asm/bitops: ffs: use __builtin_ffs to evaluate
 constant expressions
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Jan Beulich <JBeulich@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu. 12 May 2022 at 09:28, Nick Desaulniers <ndesaulniers@google.com> wrote:
> On Wed, May 11, 2022 at 5:04 PM Vincent Mailhol
> <mailhol.vincent@wanadoo.fr> wrote:
> >
> > And finally, Nick Desaulniers pointed out in [2] that this also fixes
> > a constant propagation missed-optimization in clang.
> >
> > [2] https://lore.kernel.org/all/CAKwvOdnH_gYv4qRN9pKY7jNTQK95xNeH1w1KZJJmvCkh8xJLBg@mail.gmail.com/
>
> Regarding
> https://github.com/llvm/llvm-project/issues/55394
> it seems that functions with static linkage cannot be considered
> library functions, so libcall optimization will not run on calls to
> them. So the compiler might be able to do a better job for constants
> if ffs() and friends indeed were not defined in a header as static
> inline.  But that relies on the compiler knowing these tricks; I think
> the kernel's approach is just fine (better in fact, because we should
> inline these tiny functions, regardless of LTO), but like this series
> shows, there may be room for improvement for other functions within
> the kernel that are defined as static inline in headers that are
> normally found in a libc.
>
> So I no longer think there's a missed optimization here, but at this
> point, it's not worth a respin of the series IMO to just let sleeping
> dogs lie.
>
> Unless the x86 maintainers wouldn't mind dropping that line and link
> when applying?

Let me send the v4, this will save the x86 maintainers some manual
editing effort (add will add your "Review-by" tag in patch 2 while
doing so).
