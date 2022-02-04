Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304BC4A91D0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 01:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356346AbiBDA7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 19:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiBDA7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 19:59:09 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA92CC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 16:59:08 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id d10so14114388eje.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 16:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wx9zL515JtmLncGQm93eWQntb/DTkqy+sgfVCpkbAp4=;
        b=FPro4IaRcta3YpRSuo7Os1sx9brg4nB9U+Ay5jgMt/rH0CTtD4+2q8W5O8PmupD5rP
         X+ZDD0fbMdszPz+6S4QjxxPMM6QLRmuub03JdPQN9mFtLzP66Xjv+U4ZH4dgJCKwk508
         lbEZdqQf0jF79Za06EQzlV27DCn4i5bEzDBAxJQBOvzeGOzzkz+dvTu7HEYP5+OY1ouT
         5F/iY6i21ny22utCHBQh+87VywUISYY7iXzye4FUW10DsrNROis1J5vnxdylJ/l7w8xC
         /TFF65bRaLEqH9PxXnIOv6dSlh2ivxWgzN67uoQiF9J3zENr0wnK5S83if/VqLhEPF6a
         XxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wx9zL515JtmLncGQm93eWQntb/DTkqy+sgfVCpkbAp4=;
        b=1SDZiDv8eF0Ap2Z6XZyQMfHL73gWFuOTbJal7QDNtQcjm7MI7T8nbOZ4uasbi9b5vp
         FymODMvW1puKK/3okalpwPKbJ+blM8P8Dxqndy8E72m2W2ne/CVPPuwXh5nP4bJ9fd8l
         n6Y1SkPIqUgPWi6gJj/OAa9NIm4vUxbzW9CCt2k2ANVIVX9fveZPvTqVSk1K65KZSq/t
         OnzL7vrxV3MN8Vse7gMugZnN0gqxKdGFriRGkOq0r/Gx5WRJaeY/4MtxO55eQQhkT+Az
         bl8Z2hSX1rcgkM+HDAlEW3ZigmLzVIfXKi0B6Z4YXWX70vbYWTfLSBSCztiITY0638BM
         2v+g==
X-Gm-Message-State: AOAM5319uMcFmWTbUchvRWBWkMsMSy84O5sRoIUjbCQ4lBOewyq6qGnM
        h/MNGs8/qDSA+eU0xaExaHhEbQDR31juOb80eFqw/N7I0g==
X-Google-Smtp-Source: ABdhPJxZm8zlXltXg56zyniqAOvjtYuG3I9y6xBCgyqrjpAnGwwHKWd8QK8IhscrAzso7zlHoLO77uQ1pVrFth2RxPw=
X-Received: by 2002:a17:907:9804:: with SMTP id ji4mr433075ejc.232.1643936347092;
 Thu, 03 Feb 2022 16:59:07 -0800 (PST)
MIME-Version: 1.0
References: <20211215211847.206208-1-morbo@google.com> <20211229021258.176670-1-morbo@google.com>
 <87mtj7cwpa.ffs@tglx>
In-Reply-To: <87mtj7cwpa.ffs@tglx>
From:   Bill Wendling <morbo@google.com>
Date:   Thu, 3 Feb 2022 16:58:55 -0800
Message-ID: <CAGG=3QUie3qMTo68e6pgNu=_NDof6eA+h6=VtREm8Do1memOUg@mail.gmail.com>
Subject: Re: [PATCH v2] x86: use builtins to read eflags
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, llvm@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 3, 2022 at 4:16 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, Dec 28 2021 at 18:12, Bill Wendling wrote:
> > GCC and Clang both have builtins to read and write the EFLAGS register.
> > This allows the compiler to determine the best way to generate this
> > code, which can improve code generation.
> >
> > This issue arose due to Clang's issue with the "=rm" constraint.  Clang
> > chooses to be conservative in these situations, and so uses memory
> > instead of registers. This is a known issue, which is currently being
> > addressed.
> >
> > However, using builtins is benefiical in general, because it removes the
> > burden of determining what's the way to read the flags register from the
> > programmer and places it on to the compiler, which has the information
> > needed to make that decision. Indeed, this piece of code has had several
> > changes over the years, some of which were pinging back and forth to
> > determine the correct constraints to use.
> >
> > With this change, Clang generates better code:
> >
> > Original code:
> >         movq    $0, -48(%rbp)
> >         #APP
> >         # __raw_save_flags
> >         pushfq
> >         popq    -48(%rbp)
> >         #NO_APP
> >         movq    -48(%rbp), %rbx
> >
> > New code:
> >         pushfq
> >         popq    %rbx
> >         #APP
> >
> > Note that the stack slot in the original code is no longer needed in the
> > new code, saving a small amount of stack space.
>
> This still lacks any information about the effect on GCC. There is a
> world outside clang. It's not my job to validate that.
>
I never said you were the one required to validate that. I'm not sure
where you got that idea from. There of course is no change to GCC's
output. I updated the commit message and sent out v3. PTAL.

-bw
