Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43D8528EFE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 21:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345662AbiEPTmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 15:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345956AbiEPTlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 15:41:03 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4813F33E
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:39:56 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2ebf4b91212so165178327b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=99BWpQJkm6AArPPk7WzhPOholNHloGIEKeqo/lgHTyY=;
        b=HKQpIxEMC4GFsVb7vDVuur9BVqohtM/mXn0p1tH0Gcc2mwIz+1Tr22I3UprAMWSABk
         6xud03AVA7BWC54cAD97RMffWEB5L35VrUnFHlscjrrErL5W0hPpOCAJcTZL+Y007vUV
         jdFL+PVaXOmUgIAWJVRG3vPFljY9tUW2cVk9+nJ/5mSJqi/GSAR6t476Q0FiYvI2y42m
         sZvXIuXVVO4FakgC30CPAMbCdlNMeUf5MKxgMsgUOtKqD62rCULW3pro/bRAgZbvVwXM
         0cq3BLN4+NkCWUUcEedGxECqGNRpPkkusw29hef/tZVDtRTdG0FbBo5OE1bTREoX9qYF
         nAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=99BWpQJkm6AArPPk7WzhPOholNHloGIEKeqo/lgHTyY=;
        b=BAN9m4Jbp8dUJfG8wSkSfZezvQOjFux3LAEzeUD2xdimcE6p7Hgs7dNd9I1Xm/xpDG
         L2Wr4tDA9db2e0n6nVJv/swB9dxysB93TgDxHxNWJoOlWGQFjlbQoWydzhnZyNmU0q0W
         +wtkJyqqOHMYPjrhGEIzpdrYvGRj1LosYohdHm5TY2f1aOUBYpA76R765KL56l1aC7K3
         j3Xl4g2USGuDiQYc2GApz/ie2TjzRmV6uJ3ShMVoa1/aONqJd4Z2mGaN0mebgKqvIbM6
         AEynI24vpuivYCCmr2bF2NA3rFXcOr4ODxTV9u9XNlDmfWXKdp7SkvGdS/DzmGPckIs8
         qjLQ==
X-Gm-Message-State: AOAM532dg9XUqX5pa15T88cA6yjqvL8UN/V4L+tSvXfq0EgRu86tuuiE
        0DpwVRBDOBWcQmD6jthcHW73Jr2GTG46HiRfHAeaTQ==
X-Google-Smtp-Source: ABdhPJx5GvWkBqAu2Nm1IG231I1soql0HIjYv2G9Ay0REk/aLK0lMgQQ0OdtHS8Nmsne1YoyXIZh5EuOk5GnANhybGQ=
X-Received: by 2002:a81:9188:0:b0:2fe:d01a:6b09 with SMTP id
 i130-20020a819188000000b002fed01a6b09mr12922227ywg.243.1652729995504; Mon, 16
 May 2022 12:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-21-samitolvanen@google.com> <YoIfWENLV1AR2ijj@hirez.programming.kicks-ass.net>
 <CABCJKucXA2jbTc9TF1mLUsEDKu52t71tzxpnsGOXY3_ks+W4Bg@mail.gmail.com> <20220516183047.GM76023@worktop.programming.kicks-ass.net>
In-Reply-To: <20220516183047.GM76023@worktop.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 16 May 2022 12:39:19 -0700
Message-ID: <CABCJKudmrBOkoDvDPOA-aEyrs9evHPWpzMpDZ10n8vXDBRdCxQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 20/21] x86: Add support for CONFIG_CFI_CLANG
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 11:30 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, May 16, 2022 at 10:15:00AM -0700, Sami Tolvanen wrote:
> > On Mon, May 16, 2022 at 2:54 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Fri, May 13, 2022 at 01:21:58PM -0700, Sami Tolvanen wrote:
> > > > With CONFIG_CFI_CLANG, the compiler injects a type preamble
> > > > immediately before each function and a check to validate the target
> > > > function type before indirect calls:
> > > >
> > > >   ; type preamble
> > > >   __cfi_function:
> > > >     int3
> > > >     int3
> > > >     mov <id>, %eax
> > > >     int3
> > > >     int3
> > > >   function:
> > > >     ...
> > >
> > > When I enable CFI_CLANG and X86_KERNEL_IBT I get:
> > >
> > > 0000000000000c80 <__cfi_io_schedule_timeout>:
> > > c80:   cc                      int3
> > > c81:   cc                      int3
> > > c82:   b8 b5 b1 39 b3          mov    $0xb339b1b5,%eax
> > > c87:   cc                      int3
> > > c88:   cc                      int3
> > >
> > > 0000000000000c89 <io_schedule_timeout>:
> > > c89:   f3 0f 1e fa             endbr64
> > >
> > >
> > > That seems unfortunate. Would it be possible to get an additional
> > > compiler option to suppress the endbr for all symbols that get a __cfi_
> > > preaamble?
> >
> > What's the concern with the endbr? Dropping it would currently break
> > the CFI+IBT combination on newer hardware, no?
>
> Well, yes, but also that combination isn't very interesting. See,
>
>   https://lore.kernel.org/all/20220420004241.2093-1-joao@overdrivepizza.com/T/#m5d67fb010d488b2f8eee33f1eb39d12f769e4ad2
>
> and the patch I did down-thread:
>
>   https://lkml.kernel.org/r/YoJKhHluN4n0kZDm@hirez.programming.kicks-ass.net
>
> If we have IBT, then FineIBT is a much better option than kCFI+IBT.
> Removing that superfluous endbr also shrinks the whole thing by 4 bytes.
>
> So I'm fine with the compiler generating working code for that
> combination; but please get me an option to supress it in order to save
> those pointless bytes. All this CFI stuff is enough bloat as it is.

Sure, I'll take a look at what's the best way to accomplish this.

> > > >   ; indirect call check
> > > >     cmpl    <id>, -6(%r11)
> > > >     je      .Ltmp1
> > > >     ud2
> > > >   .Ltmp1:
> > > >     call    __x86_indirect_thunk_r11
> > >
> > > The first one I try and find looks like:
> > >
> > > 26:       41 81 7b fa a6 96 9e 38         cmpl   $0x389e96a6,-0x6(%r11)
> > > 2e:       74 02                   je     32 <__traceiter_sched_kthread_stop+0x29>
> > > 30:       0f 0b                   ud2
> > > 32:       4c 89 f6                mov    %r14,%rsi
> > > 35:       e8 00 00 00 00          call   3a <__traceiter_sched_kthread_stop+0x31> 36: R_X86_64_PLT32      __x86_indirect_thunk_r11-0x4
> > >
> > > This must not be. If I'm to rewrite that lot to:
> > >
> > >   movl  $\hash, %r10d
> > >   sub   $9, %r11
> > >   call  *%r11
> > >   .nop  4
> > >
> > > Then there must not be spurious instruction in between the ud2 and the
> > > indirect call/retpoline thing.
> >
> > With the current compiler patch, LLVM sets up function arguments after
> > the CFI check. if it's a problem, we can look into changing that.
>
> Yes, please fix that. Again see that same patch for why this is a
> problem. Objtool can trivially find retpoline calls, but finding this
> kCFI gadget is going to be hard work. If you ensure they're
> unconditionally stuck together, then the problem goes away find one,
> finds the other.

You can use .kcfi_traps to locate the check right now, but I agree,
it's not quite ideal.

Sami
