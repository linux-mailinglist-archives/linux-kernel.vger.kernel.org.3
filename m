Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BB052ACD1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353003AbiEQUg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353021AbiEQUgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:36:55 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AE317A8A
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 13:36:51 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2f83983782fso3450017b3.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 13:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ap6I3L4wAL2dCUYbfv592hI1CK5Q2LIvM0tZSX0GvuE=;
        b=ExlnNy27IdZuSeHWhoB+wChwCWqkCyYWFwRPPA2XWICoMp/0iSB+0UgbJlEzhwDYzV
         SMT40ZwqMBmRgOSYUTA2q+yp6FZR1llqfeaNClhztQ9J+UBKHhKcZ2VewvTL8xnNu+JB
         ZrEYCvyLXT4xEDs7VMFQHjLsulNCsHVAoMHChcme8bpk9vRy39GW3YuyIA69rH1CIUmd
         G8aheQL7oWM8YW6ttEAPmxVbCCeUNok07yUqRS4PzpeCGqjbuBIiBYxqAI7HDDKOLmO4
         XQl4kz19ESmGzRU2DTUhAwuZHs3mA88L2vWmBR5UdbPXrpeFe1MOLsz9GklUpir/x34f
         zVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ap6I3L4wAL2dCUYbfv592hI1CK5Q2LIvM0tZSX0GvuE=;
        b=PGjpEBYvwBVH99aJP0f8lK8Brofm928dT648RQ22ap9VujNG5KHjgzwv288xLT8ONn
         hC5aGBloMvYgLUEoNAFHXNKYjQDR4fSGAERB9WwL+5njkIENWNEEkVwH+ykiwduwP3nB
         MtKuEthehXYS8gBe8a+dhj5mMeuwtAI/VvwfCpEKbjHHJERX4VpXKLNebBkzaFDZHasC
         b5QQQFqOTfCl7j5KetGQNlDK9P0Mnh1h+8oOxqtq+8HjkEQ4e89E8KC95cqs+FuNPlaX
         Mc5OMJMmBPW+zG00CKLQXPAS10pFG24+fFLb8L8GO/I8m9YUkoyDQYehOS7RwH8VDtrr
         oVtg==
X-Gm-Message-State: AOAM531dWdjWEVVTCRwtP7r3+HMstU1kH/BpYF3Sw++RZf1UeJAbYD/q
        1xrOq64HI8eIu66pACEZZRAYTtywqCELAe6NNQWI0g==
X-Google-Smtp-Source: ABdhPJz6+ql5NLCT+TCJzkPXm3RGXLdJGWYcAV8GnmANmUz8/mfTMhwDLOzesEEUiMBMguVZLZHXbKZDvfTwj/yIcJU=
X-Received: by 2002:a0d:d747:0:b0:2ff:22b9:9281 with SMTP id
 z68-20020a0dd747000000b002ff22b99281mr7123980ywd.305.1652819810645; Tue, 17
 May 2022 13:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-21-samitolvanen@google.com> <f65c01979b884174965802a13cf6b077@AcuMS.aculab.com>
 <CABCJKueo+cw1DHH6N2dUjD-U7OKqmkJUyimm0ychv1drt5U9Rg@mail.gmail.com>
 <19b3e040302d4d8aa240eee43427dfaa@AcuMS.aculab.com> <20220516214414.GR76023@worktop.programming.kicks-ass.net>
 <CABCJKucPMgMQ-D_yByvMSx6yutjsBXGAwirmheOYejWHARi9iQ@mail.gmail.com> <YoNENqdLBK6tLmpa@hirez.programming.kicks-ass.net>
In-Reply-To: <YoNENqdLBK6tLmpa@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 17 May 2022 13:36:14 -0700
Message-ID: <CABCJKuePNjvcKqZ3ZRmv9ws_2-L2B+a1y_rSXS_cjprf=grLrw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 20/21] x86: Add support for CONFIG_CFI_CLANG
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
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

On Mon, May 16, 2022 at 11:44 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, May 16, 2022 at 03:03:02PM -0700, Sami Tolvanen wrote:
> > On Mon, May 16, 2022 at 2:44 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Mon, May 16, 2022 at 09:32:55PM +0000, David Laight wrote:
> > >
> > > > > The compiler always generates this specific instruction sequence.
> > > >
> > > > Yes, but there are several ways to encode 'cmpl imm,-6(reg)'.
> > >
> > > Yes, but we don't care. This *always* uses the 32bit immediate form.
> > > Even if the immediate is small.
> >
> > Yes, that part is not a problem, but it's a valid point that LLVM
> > might not always use r8-r15 here, so I will have to check for the REX
> > prefix before blindly attempting to decode the instruction.
>
> LLVM has always used r11 for indirect calls, will that change?

No, this won't change register allocation, but I will have to ensure
that the compiler won't do any unnecessary register shuffling for the
check itself.

Sami
