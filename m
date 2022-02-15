Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E196B4B766C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbiBOQ40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:56:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbiBOQ4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:56:25 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5059E119870
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:56:15 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id j12so35743953ybh.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YlbnjTvgntnfVcOa/EhaC2z63qHnpSdTA6htlssL+WQ=;
        b=bk46Vhc2ajd84HHhGeRXsqLbc/cGSRyxZX/c1Llf14vsw65KsEUPwwU9HPp51fw4Xq
         3q58SrpUFqhbH2GFeBSprgbQTqriEp3/k5p2gQ976nKGKFWKCxBix+9i5VvHuh02/sun
         oO+En9eTYtfeMyiHeEoOlNEcIyYqM54DuS3oAOG8pDKIjRaEFME7K5qYBUmK36bwP/4X
         GVpDqdTe1cmb79rWnDO0cRl7vsVSnibSGnWzvo809InInrTuGPFphqNB30AxGC1UcaYI
         FKoXi0Ewc+M7Rxg1/S59gYqmJurInYl7YAmAIcivnj9uXodYpXdUKOlQT/LoTJgQNuQF
         P0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YlbnjTvgntnfVcOa/EhaC2z63qHnpSdTA6htlssL+WQ=;
        b=qiPfgdgGSNI44bkRPJ6dwcQOCuBaHjwPnmmEXiy4H1TqT+st0gnsi7xQp175J4NycT
         OcoqFENbXrKs9yn9bWqbID/QSlP1BttCFeuGrrpTJn4mM1/0WQlJnsfE9xACKYpkAIvI
         cB1e6jzMJ+x4SaaDIwxCmt0j+1Ns2up/9zrDgCkUGmjnCNZPcCNxoSXzuEau+Je+heIM
         oDbIvdW2OyU+xJvutYfJQDeSG0JVaKbQ1LlcQqQ3vNsbARwGLRUuYIAKH1JQhKLLGr+q
         VBqBb/qLWzJrOWkE/39+eYaeUVVguFR/Q0JnDpIjNbQi3OwadghAOeWHUjb1XUSy6bXE
         6mng==
X-Gm-Message-State: AOAM530t6AgsN6CzfDDXyQc61twHKvpFqDhLuloIFU49fbEvQOD8q+oZ
        83V7DYiI5kCzzFH0oCjdpQjmXIqaqVpg3bzMC99jKA==
X-Google-Smtp-Source: ABdhPJzikU0YU5BH/siNLMr0CFiPW39DzXn9G0PWcetR0q2McVSRzNwb57LXXgFzjHK4V7Q5u7TpAbaWPvg5gf658uk=
X-Received: by 2002:a25:1845:: with SMTP id 66mr4653694yby.196.1644944174316;
 Tue, 15 Feb 2022 08:56:14 -0800 (PST)
MIME-Version: 1.0
References: <20211122170301.764232470@infradead.org> <20211122170805.338489412@infradead.org>
 <6ebb0ab131c522f20c094294d49091fc@overdrivepizza.com> <202202081541.900F9E1B@keescook>
 <ad6c2633f39e39583bc5c5eaf7ccbe52@overdrivepizza.com> <202202082003.FA77867@keescook>
 <9ea50c51ee8db366430c9dc697a83923@overdrivepizza.com> <20220211133803.GV23216@worktop.programming.kicks-ass.net>
 <CABCJKuciRBnz4JxBDJC=+kuJn4pU2uBkWPBov7-VL2o2j0F4SA@mail.gmail.com> <20220214222550.GB23216@worktop.programming.kicks-ass.net>
In-Reply-To: <20220214222550.GB23216@worktop.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 15 Feb 2022 08:56:03 -0800
Message-ID: <CABCJKuf-wouSCh4u43GPQHPPgG=mqOGboSoHPQRfmgQSBkFrMg@mail.gmail.com>
Subject: Re: [RFC][PATCH 6/6] objtool: Add IBT validation / fixups
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joao Moreira <joao@overdrivepizza.com>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        hjl.tools@gmail.com, Josh Poimboeuf <jpoimboe@redhat.com>,
        andrew.cooper3@citrix.com, LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 2:25 PM Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Feb 14, 2022 at 01:38:18PM -0800, Sami Tolvanen wrote:
> > I'm fine with adding a trap mode that's used by default, but having
> > more helpful diagnostics when something fails is useful even in
> > production systems in my experience. This change results in a vmlinux
> > that's another 0.92% smaller.
>
> You can easily have the exception generate a nice warning, you can even
> have it continue. You really don't need a call for that.

Sure, but wouldn't that require us to generate something like
__bug_table, so we know where the CFI specific traps are?

> > In this case the function has two indirect calls and Clang seems to
> > prefer to emit just one ud2.
>
> That will not allow you to recover from the exception. UD2 is not an
> unconditional fail. It should have an out-going edge in this case too.

Yes, CFI failures are not recoverable in that code. In fact, LLVM
assumes that the llvm.trap intrinsic (i.e. ud2) never returns, but I
suppose we could just use an int3 instead. I assume that's sufficient
to stop speculation?

> Also, you really should add a CS prefix to the retpoline thunk call if
> you insist on using r11 (or any of the higher regs).

I actually didn't touch the retpoline thunk call, that's exactly the
code Clang normally generates.

> > How would you like to deal with the 4-byte hashes in objtool? We
> > either need to annotate all function symbols in the kernel, or we need
> > a way to distinguish the hashes from random instructions, so we can
> > also have functions that don't have a type hash.
>
> Easiest would be to create a special section with all the hash offsets
> in I suppose. A bit like -mfentry-section=name.

OK, I'll take a look. With 64-bit hashes I was planning to use a known
prefix, but that's not really an option with a 32-bit hash.

Sami
