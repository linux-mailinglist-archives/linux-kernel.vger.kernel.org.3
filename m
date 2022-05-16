Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7B2528978
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 18:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245576AbiEPQFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 12:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238289AbiEPQFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 12:05:22 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FCB34B80
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 09:05:21 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2f16645872fso158539197b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 09:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pH8gn2feqHbJT1VIR+CqAKz2Vm1OI4IAH3XiEx/1r0M=;
        b=hxtlRvOYZfHTAJg87WazheoK+1Jp+3wCYPv/qQPT0w3Xc4g1MVT1EAxaMJwHK/p+C5
         n195YFtxr4dxqu/Ys7B5KxlCbsy5yIzGJs9tu7jy7SNu1kZ2JX9oLdZBYQUPptmKqazj
         KBMYT+1WYxUqZpoWveDxLGR/M5mOnI6k4zzkfRDzYsS9KUKHLC0FQoQAKI53lhQb6EYD
         VcFQ2h3buNKerCfHxbL/MfYeLCG/XK25UGojTz62VrxqXP9lPEUYxJksD81vTAtuacJC
         OBrXFPw3moxQx+QrTme3d7VCEv4n4HJA5S3h3SDkHHYHLdwCbsqQdCPnYLdqZ9KUhBvu
         +hjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pH8gn2feqHbJT1VIR+CqAKz2Vm1OI4IAH3XiEx/1r0M=;
        b=T9B5VUbVOHT04FJLVPEbIuy8fJAC7SeSyHdvzOyFvIT3nwi4SAvfOi5/1cyv362nmD
         WEoXKqko3zq7DXhGM8i/XlujqCbOOSGNks9hRdewzZ9BVe6Z6HFRMgcMvalRBFUy1JXj
         uFGcUcloxIgP4u3nD2RJrUntj2VRdYfeh0IbsuNQ+aBHSrtiB5ow9Uk39gayI4bWoEwU
         8bn9ghQVabo9DqTgWl1ESx150iAqt2nlqvImu6KqXphgZhc5ILHey0Qpp/eOMvtBUyCV
         tuGsJlGxxvMV2rixMntQx7HprORj+TyS9yzqHswjOlUYF0Kef5J6yg9VJEkA4GSO95CR
         zCYA==
X-Gm-Message-State: AOAM533eCHq7jxOrhRs+zo6cbVkQbv02y6jZii6lyAJYDaUI4D05vSqp
        +ynZpLPhycn0y0Jra0L4R8yTuRVNLYIzQvOhCjqa3w==
X-Google-Smtp-Source: ABdhPJxkNuFXhIjn2K2LehjJwRBe1s4mUIoU6C5Borv7+HLjg5MoQxKsHWIgoJh9hK6EYijZjjwv/zmdLvdC5pna+W0=
X-Received: by 2002:a81:4ecf:0:b0:2fe:d9f2:15b3 with SMTP id
 c198-20020a814ecf000000b002fed9f215b3mr10858246ywb.305.1652717120280; Mon, 16
 May 2022 09:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-8-samitolvanen@google.com> <202205141447.E3B5A29@keescook>
In-Reply-To: <202205141447.E3B5A29@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 16 May 2022 09:04:44 -0700
Message-ID: <CABCJKudrY2b4ZXUaXOmKEB-LG192u2PSfsT-=Vc1bcg3QwY6aw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 07/21] cfi: Add type helper macros
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2022 at 2:49 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, May 13, 2022 at 01:21:45PM -0700, Sami Tolvanen wrote:
> > With CONFIG_CFI_CLANG, assembly functions called indirectly
> > from C code must be annotated with type identifiers to pass CFI
> > checking. The compiler emits a __kcfi_typeid_<function> symbol for
> > each address-taken function declaration in C, which contains the
> > expected type identifier. Add typed versions of SYM_FUNC_START and
> > SYM_FUNC_START_ALIAS, which emit the type identifier before the
> > function.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>
> And the reason to not make this change universally (i.e. directly in
> SYM_FUNC_START) is to minimize how many of these symbol annotations get
> emitted? (And to more directly indicate which asm is called indirectly?)

The reason not to add this to SYM_FUNC_START is that the compiler
doesn't emit the type symbols for all functions. It currently emits
them for all address-taken function declarations in each translation
unit. We could potentially further limit this by emitting them only
for function declarations with a specific attribute, for example, but
that's something we can optimize later.

> What happens if an asm function is called indirectly and it doesn't have
> this annotation?

It will fail the CFI check.

> (Is this case detectable at compile-time?)

It's not. I'll update the commit message in the next version to
clarify these points.

Sami
