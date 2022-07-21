Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE4557D2FC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiGUSHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiGUSHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:07:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6479B8AB02
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:07:02 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id sz17so4499433ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LNrx/cOdHdHv2fbOK2gcOOrw3W1FcQH2zXTJeiwcOp4=;
        b=Togte2G5oCG/StzoNYsJZOWmfDBDfNTHPTQjvRoyOXrVl/DSN6cmsTN1v7xIzA89GT
         /5WBoDWWPF45JKj13vxqc4T1DXK9VMylucf0WlzfWB2orUhDxBOLomc08vTjmNxKma1S
         1w9IbcTp7sc41hkwy4HN3fo1OinV/SYkQG7J0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LNrx/cOdHdHv2fbOK2gcOOrw3W1FcQH2zXTJeiwcOp4=;
        b=c+40agFNZNzi9ndLFwTmeiqjBMKnXzEjmYTGCKgnE9OsGLLaxmDwXg5hCwbGOvD4fM
         E0VuFL6bjTaFJVpeufIZyyyh1zC50LkS9WXoj+6x1FB1Hbo3sNU/wgQa2b0mFOuODwGa
         xxAtu/UAz2M20qOEdZ4i2tKLEWhlrdr7FXhyPN4gKY0FTMIDr2O04yIBWmbNlFZ9xOVX
         CoqkL9vNrXTbS5Hp+AQvnSeAlDZ7xaw3cBBb1NqgU4xzynGcuQ644jdaXDI7B1d2Bdad
         hOilyZudy62bNHefD3SE2+jLSRC0pxpgVh0gNqn59FgLouAnlKqzdLGgfTlmbcp1u8xW
         ydtg==
X-Gm-Message-State: AJIora/rHKlJA1rALqe83gLQxs6+Joz7rRWL6nGRVFctcfx/sLphVHMY
        JeYVbphUdJ7q8caBqV/7DLKWDS1xUag+pMMab9c=
X-Google-Smtp-Source: AGRyM1tmKWCB02BHwm26ABOuiCxu0Ijc8JxT2v6N2J1vVJm3BKdYGS5RTBx4U8Sqs2r4s0OUrME/UQ==
X-Received: by 2002:a17:907:6295:b0:703:92b8:e113 with SMTP id nd21-20020a170907629500b0070392b8e113mr42008561ejc.594.1658426820573;
        Thu, 21 Jul 2022 11:07:00 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id y11-20020a170906518b00b0072b7d76211dsm1083763ejk.107.2022.07.21.11.06.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 11:06:59 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id k11so2923704wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:06:58 -0700 (PDT)
X-Received: by 2002:a05:6000:1049:b0:21e:584f:3574 with SMTP id
 c9-20020a056000104900b0021e584f3574mr2409225wrx.274.1658426818652; Thu, 21
 Jul 2022 11:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <CABCJKudvSv9bAOrDLHki5XPYNJK6=PS-x8v=E08es8w4LJpxBw@mail.gmail.com>
 <87fsiyuhyz.ffs@tglx> <CAHk-=wjEDJ4+xg0CWR7CaCKnO6Nhzn+vjJy7CjaVmf9R+g_3ag@mail.gmail.com>
 <CAHk-=wj6U3UamfLLV+rPu1WmKG_w3p0Bg=YbQcG1DxHpmP40Ag@mail.gmail.com>
 <YtXzgWnbTQH48JGR@worktop.programming.kicks-ass.net> <CAHk-=wiJNViWKCCrDPByGWmVVXuEKhRGykx4q8diXSxEqGfOMw@mail.gmail.com>
 <CAHk-=wjmUeB=_s6jcBUNoAT4GHv-aF1Mzqa6G1X4k+dcHDs1Mg@mail.gmail.com>
 <Ytbnlms90+LBLbrY@google.com> <Ythv7NqofIAHp3bf@worktop.programming.kicks-ass.net>
 <Ytl2vg15Hc0fh8Dl@worktop.programming.kicks-ass.net> <YtmTK93vHWQUFinE@worktop.programming.kicks-ass.net>
In-Reply-To: <YtmTK93vHWQUFinE@worktop.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Jul 2022 11:06:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLGENEkjME_v_3P1SwhwjzH4GK2RLA3fn=yQNuyKLBkg@mail.gmail.com>
Message-ID: <CAHk-=whLGENEkjME_v_3P1SwhwjzH4GK2RLA3fn=yQNuyKLBkg@mail.gmail.com>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joao Moreira <joao@overdrivepizza.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "Nuzman, Joseph" <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Gross, Jurgen" <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Collingbourne <pcc@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 10:56 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> this seems to work, let me go hack the kernel..

Am I missing something?

Isn't this generating

        movl $~IMM,%r10d
        negl %r10d
        cmpl %r10d,-4(%calldest)

for the sequence?

That seems bogus for two reasons:

 (a) 'neg' is not the opposite of '~'. Did you mean 'notl' or did you mean '-'?

     Or am I missing something entirely?

 (b) since you have that r10 use anyway, why can't you just generate the simpler

        movl $-IMM,%r10d
        addl -4(%calldest),%r10d

     instead? You only need ZF anyway.

     Maybe you need to add some "r10 is clobbered" thing, I don't know.

But again: I don't know llvm, so the above is basically me just doing
the "pattern matching monkey" thing.

             Linus
