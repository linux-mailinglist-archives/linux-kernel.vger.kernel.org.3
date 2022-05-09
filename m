Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C281E520835
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 01:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiEIXQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 19:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiEIXQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 19:16:40 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E91E2A3BC2
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 16:12:45 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id i11so5666767ybq.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 16:12:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ZF0aaGxPgqlWytLFil+L87rXP/3Mh2LugmakMdLiHc=;
        b=uXpqT0xCF7vBrqs0KtzqrYI5dB+NVARskSozy72v17V+phYFohxqGKoCQmNGZiRNTf
         3Fx3Q9C322EYG2TGPF5myqFa/qInvw9sg+ZYf3OfFFr42/XArxTHnaFV/kDYECVH87YV
         atAKF4MJq42CnM/B72U1CjlzPZbRVhhxYm55LLlU2jVQmEraUWTgILXKzv96PlmDlH2t
         cutIzlOUwHX6qBLgIp1Ldc2c22miFNkOjhPuIUhoyW188TwxAFtiPl9MM+jE1tPURIPJ
         wQYXlMcUm6MRAU9AlN/Hb1vAny6dk+KsZqiLGnCZDYgMPuFxSD6UnPquzriaVEERvt+y
         ESpg==
X-Gm-Message-State: AOAM53126MAQ1kYzo3P/1/GlJxWmQWHU/wKap853AGTZ5SKcXPEUqGRL
        zem9HTYbnMdNpx4oteqCS6xR2EnLEzW1MMDKRqg=
X-Google-Smtp-Source: ABdhPJxtqzF8TkeIOVaFkQH8p/9uF9xftraHkwIFHfYD5qc8cA+oK1c0fxpmTkiTmRc3ZMnOTqLGGsGSJHAwSb2gfnU=
X-Received: by 2002:a25:76c6:0:b0:648:5616:ca50 with SMTP id
 r189-20020a2576c6000000b006485616ca50mr16718433ybc.423.1652137964457; Mon, 09
 May 2022 16:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220306171009.1973074-1-mailhol.vincent@wanadoo.fr>
 <20220508100907.61231-1-mailhol.vincent@wanadoo.fr> <CAK8P3a3Fw2T0WSkxv4DiTG2wGkKcs24StPx-BG_vi=ffa9OLVA@mail.gmail.com>
 <CAMZ6RqK9d0hFwYebaArKjod4LJVGQgfDygpbGdBu-4BCDUR_SA@mail.gmail.com>
 <YnhXgzhghfi17vMX@dev-arch.thelio-3990X> <CAMZ6RqL7543LFU7ywbr-FV9A3n+m7zNy-J00j=ZrNMkDonq2aw@mail.gmail.com>
 <CAKwvOdniSVMOwkBke2EcgONn_Vmv88M+B2FTYL_BKtWawCSLAw@mail.gmail.com>
In-Reply-To: <CAKwvOdniSVMOwkBke2EcgONn_Vmv88M+B2FTYL_BKtWawCSLAw@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 10 May 2022 08:12:33 +0900
Message-ID: <CAMZ6Rq+q44vAeqa7HN8mfoNXzv9GndnQDm1e4_kyMXf_+oADdQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v1] x86/build: add -fno-builtin flag to prevent shadowing
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Tom Rix <trix@redhat.com>, Kees Cook <keescook@chromium.org>
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

Hi Nick,

On Tue. 10 May 2022 at 04:50, Nick Desaulniers <ndesaulniers@google.com> wrote:
> On Mon, May 9, 2022 at 8:01 AM Vincent MAILHOL
> <mailhol.vincent@wanadoo.fr> wrote:
> >
> > Instead, I am thinking of just using -fno-builtin-ffs to remove
> > the annoying -Wshadow warning. Would that make more sense?
>
> Perhaps a pragma would be the best tool to silence this instance of
> -Wshadow?  I understand what GCC is trying to express, but the kernel
> does straddle a weird place between -ffreestanding and a "hosted" env.

I was a bit reluctant to propose the use of pragma because I received
negative feedback in another patch for using the __diag_ignore()
c.f.:
https://lore.kernel.org/all/YmhZSZWg9YZZLRHA@yury-laptop/

But the context here is a bit different, I guess. If I receive your support, I
am fully OK to silence this with some #pragma.

The patch would look as below (I just need to test with clang
before submitting).

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index a288ecd230ab..e44911253bdf 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -269,6 +269,9 @@ static __always_inline unsigned long
__fls(unsigned long word)
 #undef ADDR

 #ifdef __KERNEL__
+__diag_push();
+__diag_ignore_all("-Wshadow",
+                  "-fno-builtin-foo would remove optimization, just
silence it instead");
 /**
  * ffs - find first set bit in word
  * @x: the word to search
@@ -309,6 +312,7 @@ static __always_inline int ffs(int x)
 #endif
        return r + 1;
 }
+__diag_pop(); /* ignore -Wshadow */

 /**
  * fls - find last set bit in word
