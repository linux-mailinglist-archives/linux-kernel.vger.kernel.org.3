Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DB14B35E6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 16:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbiBLPrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 10:47:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiBLPrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 10:47:48 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F35C212;
        Sat, 12 Feb 2022 07:47:45 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id p63so14902031iod.11;
        Sat, 12 Feb 2022 07:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NgeFCi+7UEK+nuh5x7QmJDaX6DxRBY5bpSpry5mSd78=;
        b=Y88Bnv1NDKvFo/zSY71RycxR2B/ACxpaW4T8kK3tqHqqQbpUAV2I1OqHKgzbSdhrDb
         QawjU0J+cVvOy4E4YoIvfXhs2SIP+8Wjor7UFfj9vJs/WzufHZgiGsGzq6HHh/Ihr3im
         3Q1+qditD4ehYRA0/AO80uTEFs6air76y7OZR7ruaDev3sQ47gRVfyCjN6xPjWtWX9gj
         rlTdZE9Q1bvJnL7TULLZH5Q2e/XqaeGAUzpl5Ym7KRemoqCta6NysmF5neqHTJWlPRAS
         KE5tVCBrM5IjxzNOqNkAwn4DNyaUgL5Vx2/ERkqh5aHXiGOirP9g4jhrBxji8VuhuUbZ
         63BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NgeFCi+7UEK+nuh5x7QmJDaX6DxRBY5bpSpry5mSd78=;
        b=B6KCr+L1lJFuw4fqUDLA4e67D2cVpo+LS006cUQlfkljieAqUhf3IOoTJTrAvu5fKN
         LwnIN7L7d+M2toA1oEMfVt0osG1MMpeJRpEtwESRp3Qp4Wsmbgqfgghw1D43U807U5uq
         WlrQRsbgYN/Xau6HH61+DjPe3U13zNk1cATobPblpE1+b/DzrAN3/Qys02+IFYDSfAap
         ih6tyBiqrKJseQoAr8d1tGt9Ak+Ewf5kQcWC34NukmiAnJPwWsu2OjFjKUJpVSNWI2oF
         CibHuO6CU7xAtc1cF7JFnnztYfM0HNB36qR5UttUQ5uHvH8l8PpMh4KOk9OvbwER4AcX
         dwKg==
X-Gm-Message-State: AOAM532tHtromcBYAZW5IJ3x4P21XVVN3v+v8ZV0XQVSe5vC7KDiCKik
        eabE9rOP4zBCNrT38oIGtpnK2ZaH4UuPCofjgMc=
X-Google-Smtp-Source: ABdhPJzH9YyzNLTg9POFjsMYEBvv50IYOenD6jjVc2LJHnBnXQzNscn5cyEPVT4EBKpUx2wAjYDcVqVZhEvJ8smZXfs=
X-Received: by 2002:a05:6638:4105:: with SMTP id ay5mr3853138jab.186.1644680864074;
 Sat, 12 Feb 2022 07:47:44 -0800 (PST)
MIME-Version: 1.0
References: <20220212130410.6901-1-ojeda@kernel.org> <20220212130410.6901-17-ojeda@kernel.org>
 <YgfBUhYdLXA46kOX@shell.armlinux.org.uk>
In-Reply-To: <YgfBUhYdLXA46kOX@shell.armlinux.org.uk>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 12 Feb 2022 16:47:33 +0100
Message-ID: <CANiq72nMhUH1s0HMeLb+hfp5=u3h20ryC4uqAgB1Znuq52e=Pw@mail.gmail.com>
Subject: Re: [PATCH v4 16/20] Kbuild: add Rust support
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Douglas Su <d0u9.su@outlook.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Daniel Xu <dxu@dxuuu.xyz>, Miguel Cano <macanroj@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Sat, Feb 12, 2022 at 3:17 PM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> Please don't use CPU_32v6* here.
>
> It probably makes more sense to add a symbol "HAVE_RUST" and have the
> appropriate architecture Kconfig files select HAVE_RUST.

We can do it whatever way arch maintainers prefer, of course. Why
would you prefer one over the other?

> Does Rust support Thumb on ARMv6 and ARMv7 architectures?

Yes, the main backend is LLVM. Some built-in targets and their support
level are listed here, if you want to take a look:

    https://doc.rust-lang.org/nightly/rustc/platform-support.html

There is also a GCC backend in `rustc` [1], which is making good
progress and may eventually give us access to architectures supported
by GCC. Furthermore, a from-scratch Rust frontend for GCC [2] is being
worked on, though this effort will likely take more time to reach a
point where it may be used for the kernel.

[1] https://github.com/rust-lang/rust/tree/master/compiler/rustc_codegen_gcc
[2] https://github.com/Rust-GCC/gccrs

> Please remove every utterance of "default n" from your patch; n is the
> default default which default defaults to, so you don't need to specify
> default n to make the option default to n. It will default to n purely
> because n is the default when no default is specified.

Certainly. I am curious, though: is there a reason for most of the
other 500+ instances in the kernel tree?

> As Rust doesn't support all the architectures that the kernel supports,
> Rust must not be used for core infrastructure.

Yeah, although I am not sure I understand what you are getting at here.

Cheers,
Miguel
