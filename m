Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A19151E3B0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 04:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445393AbiEGC6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 22:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiEGC6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 22:58:15 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C64D4D610
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 19:54:30 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2f7c57ee6feso99017287b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 19:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Js6T5FnmzT+VTRJ0fJxYTdw7gn3tG/0UhS1qFWDzHNs=;
        b=MTcVyUbeLKrV9UiWRfsAIbuHd78S1jiNsOWP8lM3jFENHi6CaJSLVX8AGdJGHX1XCK
         m2JJ7lRqH6Twn5Qn+u2ZiR40flU2p8cFI4nKftGon/EwJtLRmOuQk3FW78X8/DDQlfC1
         bv8O3qYw+c8NressIHWodV6BnfHDFR/AT297PgXlTU2PM/+7JPoLFpTKpbhIHbKUV08V
         CB2L3+8e1WQJtIx1MecKgG0cs83GaZEEHqnMq9ul4o6FO0/loJKJGRvoSc/AzEopM0zV
         yeohSAv5G+BhzAVI7rsIecdBlAVSmtwF3MHsm/G0wbe4cZ32z/jU2vMjkcXWTSoy2p/5
         0Jpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Js6T5FnmzT+VTRJ0fJxYTdw7gn3tG/0UhS1qFWDzHNs=;
        b=gPObdf7JVdtYCbc7dB5A9QXENwOyD8lfBiMZk4n47aMROPoRMELH2Xgzl9/T8pllq8
         tMsFEj31OTDbNp6Tv7jK0vBYyEy9Mq+b76FUgDZnXLsve3Sk4Wmg6a+F2GjEJvhVPGZq
         DB9SEeOEjpF2lNhPZ4oM64SWatjp0vFgsBoRp3v0pvdvxssbRlvlzdvjcA4OchrGJciw
         +s+LgVjR1dor3iIW8tjeJS9z39nE7S03oE9jORL1udZO0kU5yKqFVKXb9o75QJKOeP0e
         GjWmSSBFBe1gAsGOpKl3eacQ71+XQEsU2XYM6UC6CxETeICQDp8EbOzBBYK+k6sy60EP
         MPpg==
X-Gm-Message-State: AOAM530UpS0Cqsb270ke06Bk02h+KQa8sbO7WLO+IgZljHkoYvwvQ3F9
        paDgRepUGTjVy+3h5DON5M5gylD8CPQX3OzJknc=
X-Google-Smtp-Source: ABdhPJxTDxirdi0yqbsOy3pTak1vGR9cGp7GDEGiy/Fo8VU8fGCZ/wyQLvK0uNsGWAAbsFNfR07Ix327HbpeA7R66Zk=
X-Received: by 2002:a81:2f8a:0:b0:2fb:5:acfd with SMTP id v132-20020a812f8a000000b002fb0005acfdmr5238751ywv.481.1651892069388;
 Fri, 06 May 2022 19:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220506121431.563656641@infradead.org> <20220506121631.293889636@infradead.org>
In-Reply-To: <20220506121631.293889636@infradead.org>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Sat, 7 May 2022 10:54:18 +0800
Message-ID: <CAJhGHyAYQv5YzyvQdpBO3yZ5g-omqYA9cCXu-SKp+3kT=U32pw@mail.gmail.com>
Subject: Re: [PATCH 3/6] x86/entry: Use PUSH_AND_CLEAR_REGS for compat
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@suse.de>
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

On Fri, May 6, 2022 at 8:20 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Since the upper regs don't exist for ia32 code, preserving them
> doesn't hurt and it simplifies the code.
>
> This doesn't add any attack surface that would not already be
> available through INT80.
>
> Notably:
>
>  - 32bit SYSENTER: didn't clear si, dx, cx.
>
>  - 32bit SYSCALL, INT80: *do* clear si since the C functions don't
>    take a second argument.
>
>  - 64bit: didn't clear si since the C functions take a second
>    argument; except the error_entry path might have only one argument,
>    so clearing si was missing here.
>
> 32b SYSENTER should be clearing all those 3 registers, nothing uses them
> and selftests pass.
>
> Unconditionally clear rsi since it simplifies code.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Borislav Petkov <bp@suse.de>


Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
