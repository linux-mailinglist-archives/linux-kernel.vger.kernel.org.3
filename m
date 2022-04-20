Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080D8508E29
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380974AbiDTRQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380963AbiDTRQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:16:00 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C3A4578A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:13:13 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y32so4158518lfa.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5dGe0qngv+L+93UQbQHNnkXpcBsEewyzQy/wMObj+Nc=;
        b=f5aSqdCjDDoP8NmlVqBv11lXK22HHfelEZAHuO2Q3RlnonER4PNRt+pWybU0woxtpb
         k933TdkNKtExkoHwYewq/O80y5+/SAkc5ONd0wyiT+5LcOEiQzveFfyvmySEicZGFXfL
         fWGa2F5h/6PuVOwxHkksMn/su0NOdRQPbIBYVrQ555MiI7NqRS5JvuNpvPOGyC9IWPc7
         5VIpxjZKGRTepmcSmS3t4pFYO3lJFfQpUQv2jHuvOI5+oJZGFJpc1R2mensFZToI7tUJ
         BH3cVikq8hCb9P4TSMUOuscvSDm3Ho8Rr1Ls4HIVkOmpZphPE1cOrxXaplcEyCTNWVbz
         QmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5dGe0qngv+L+93UQbQHNnkXpcBsEewyzQy/wMObj+Nc=;
        b=2215BidBlNkBth3hxTO+Mb+LNxm86Y6iqbOIrVCmI9NSfKr84Ph5ufHMaTWb1FwzI6
         fbHZC2HLUOzrz4Kd4eYBjxyKSZW6ClZ9NiZY7iMMpu2/mUULA8ODRgjay/qjZE6+4l14
         192UOWUTw3Bq2e9mld9g21qJZDb33M0LlBUCVlhq5eAbxBvbrksXFR6HspxRi3mQs9Ka
         AcRoS8+qJAVce5RAUFQYJln+qBNnuWKQnPZzMsfe/gnFDPV0nBuwzhOXUoG3Ckjxn5rJ
         QAwIZAiL0hloGOB46zibi1eAOoJNEMlIUW9shrO6vob0i1dLrWq3I37UY5xwbyLaHgyF
         5qQA==
X-Gm-Message-State: AOAM532Bw/xzZGp3chw+acMcbMtx/YH0eOvNrPyXZZo9qAdpsi5c8HsY
        eYXeNS0z1FRqWZX62HZ6bzdUrw/Yy/KTKxw5IWslvg==
X-Google-Smtp-Source: ABdhPJyNTDnkoF9Lcp+RKRCyxOj9bhQxnHp8N7NPcBxwtrxuplq/4WR6PkoJ3PpJ4rQ68NVmdqQGHNEJGBvRjtTSooU=
X-Received: by 2002:ac2:5313:0:b0:46d:ef7:c2db with SMTP id
 c19-20020ac25313000000b0046d0ef7c2dbmr15460823lfh.392.1650474790504; Wed, 20
 Apr 2022 10:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <20220420074044.GC2731@worktop.programming.kicks-ass.net> <20220420151714.fderdz4dzea75rvg@treble>
In-Reply-To: <20220420151714.fderdz4dzea75rvg@treble>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 20 Apr 2022 10:12:59 -0700
Message-ID: <CAKwvOdm6J9TFUWJA2Q7VRjx1CpBme9z_Dp99+7YTjN5Jqp5=Aw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] Kernel FineIBT Support
To:     Josh Poimboeuf <jpoimboe@redhat.com>, joao@overdrivepizza.com,
        hjl.tools@gmail.com, Fangrui Song <maskray@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        andrew.cooper3@citrix.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@linux.intel.com, gabriel.gomes@linux.intel.com,
        rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 8:17 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Wed, Apr 20, 2022 at 09:40:44AM +0200, Peter Zijlstra wrote:
> > On Tue, Apr 19, 2022 at 05:42:30PM -0700, joao@overdrivepizza.com wrote:
> > > @PeterZ @JoshP
> > >
> > > I'm a bit unaware of the details on why the objtool approach to bypass ENDBRs
> > > was removed from the IBT series. Is this approach now sensible considering that
> > > it is a requirement for a new/enhanced feature? If not, how extending the Linker
> > > to emit already fixed offsets sounds like?
> >
> > Josh hates objtool modifying actualy code. He much prefers objtool only
> > emits out of band data.
> >
> > Now, I did sneak in that jump_label nop'ing, and necessity (broken
> > compilers) had us do the KCOV nop'ing in noinstr, but if you look at the
> > recent objtool series here:
> >
> >   https://lkml.kernel.org/r/cover.1650300597.git.jpoimboe@redhat.com
> >
> > you'll see his thoughs on that :-)
> >
> > Now, I obviously don't mind, it's easy enough to figure out what objtool
> > actually does with something like:
> >
> >   $ OBJTOOL_ARGS="--backup" make O=ibt-build/ -j$lots vmlinux
> >   $ objdiff.sh ibt-build/vmlinux.o
> >
> > Where objdiff.sh is the below crummy script.
> >
> > Now, one compromise that I did get out of Josh was that he objected less
> > to rewriting relocations than to rewriting the immediates. From my
> > testing the relocations got us the vast majority of direct call sites,
> > very few are immediates.
> >
> > Josh, any way you might reconsider all that? :-)
>
> If I remember correctly, the goal of --ibt-fix-direct was to avoid
> hitting unnecessary ENDBRs, which basically decode to NOPs, so the
> ghastly hack wasn't worth it.
>
> If FineIBT needs it, I could reconsider.  But I think there's a strong
> case to be made that the linker should be doing that instead.

That sounds reasonable to me (and reminds me of linker relaxation).
Joao, can you please work with Fangrui (LLD) and HJ (GNU binutils) to
determine how feasible this would be? I assume code outside the kernel
might enjoy such an optimization, too.  When that's the case, then it
probably makes more sense to "upstream" such "optimizations" from the
kernel-specific objtool into the toolchains.
-- 
Thanks,
~Nick Desaulniers
