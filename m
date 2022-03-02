Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1483B4CAE81
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240332AbiCBTTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234699AbiCBTTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:19:06 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9534F25E8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:18:22 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id b9so4502387lfv.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 11:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VeHPbYUmDQhwRvLDR7SEcUbulwlYPwQ9kvkyCVmk6Cw=;
        b=Rz6tM8IHWtmgttApx6BQXB7nieWceAqjNI2q3DfeSvnaQJSxpDT0ODHPnt+x613KVn
         sNrtExKe2lavT0wn5a0zIgIXpCH2KtVD64NdWQ6FYfu/AZDQc03Doz/F9aIOw9GibMYE
         bndEBVlQUsbr3AmnJE01ivzb96YDeKZk3/xbs9wPClplCgN2INNCA7VRfb0lIWcUQTMu
         IhmZ1TjSkUz2MxAaXkP2QHUBhw7PtukHeUuez09hAnjFlppbanVdfKHHi7GM9bIFHuTa
         ZmFkzkQFF8L0u8PePaQ/oHLdEYdscE21liiS64teesMBTmkzOtnzryx7isr1vS8o4BCu
         89tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VeHPbYUmDQhwRvLDR7SEcUbulwlYPwQ9kvkyCVmk6Cw=;
        b=rjC4NCDBelalw3MQs8qKqIMuv6Jcx/hWtyxfJwd0UFrmz+zYeCKiAmUyHBH89LMuk9
         xfqY8aa4jjGGg6+f/FK42OimP+Y84ik1BUSyz5tcmveiYai/Yi5RfWsu7k0e1DYyg0OB
         xi8TI1HHRakc3BQ+kiwa/5IUJi+1Pbs2k2jIaKki+ISYW1Hu3umw/ho7pC33ADHkmmd2
         CjDsrTvmSzk9vZ36Dp9oN0cKf69rNV9ER/8iyxvdVByasvkxkXvHyw8MU6khqIGGmBEB
         su4aGPK8N+/KyFDv/zvNFRTPeXgooJhGnQrw6CF6WTs/4ZjIYywFzO3GrIfAYIKTmrrD
         YVeg==
X-Gm-Message-State: AOAM530VUXbd07LT9mdVP2xqBUyIXuMFSwTwYOTGxj/+xMpPKAKStvlk
        AbGLzo0YrXV8NKxXRZC2up70bCWcI9qsfLa7eLmfIA==
X-Google-Smtp-Source: ABdhPJzRvLSkr1+M7JPctvNy8x2Fc5YVU61qF2BkXtYbK0MwUxxB/LYCV47mAc7jqfVU0UlWeSGdxXi79ClgbxfgeZU=
X-Received: by 2002:a05:6512:3341:b0:433:b033:bd22 with SMTP id
 y1-20020a056512334100b00433b033bd22mr18699297lfd.190.1646248699637; Wed, 02
 Mar 2022 11:18:19 -0800 (PST)
MIME-Version: 1.0
References: <20220224145138.952963315@infradead.org> <20220224151322.072632223@infradead.org>
 <CAKwvOdkD2WY=hEHy8_0zs70AGx6LRQwxL5mEZyB30uqpruYJyA@mail.gmail.com> <Yh+dMJsH+ZMPfqwD@thelio-3990X>
In-Reply-To: <Yh+dMJsH+ZMPfqwD@thelio-3990X>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 2 Mar 2022 11:18:07 -0800
Message-ID: <CAKwvOdmouBTe5pH3JoP6EEfwNT5=6WvX3oCEZRxO0Dkf38S14w@mail.gmail.com>
Subject: Re: [PATCH v2 01/39] kbuild: Fix clang build
To:     Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, keescook@chromium.org
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, mhiramat@kernel.org,
        alexei.starovoitov@gmail.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 2, 2022 at 8:37 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Tue, Mar 01, 2022 at 01:16:04PM -0800, Nick Desaulniers wrote:
> > As per our previous discussion
> > https://lore.kernel.org/linux-kbuild/CAKwvOd=x9E=7WcCiieso-CDiiU-wMFcXL4W3V5j8dq7BL5QT+w@mail.gmail.com/
> > I'm still of the opionion that this should be solved by modifications
> > (permanent or one off) to one's $PATH.
>
> However, I think we could still address Peter's complaint of "there
> should be an easier way for me to use the tools that are already in my
> PATH" with his first iteration of this patch [1], which I feel is
> totally reasonable:
>
> $ make LLVM=-14
>
> It is still easy to use (in fact, it is shorter than 'CC=clang-14') and
> it does not change anything else about how we build with LLVM. We would
> just have to add something along the lines of
>
> "If your LLVM tools have a suffix like Debian's (clang-14, ld.lld-14,
> etc.), use LLVM=<suffix>.

"If your LLVM tools have a suffix and you prefer to test an explicit
version rather than the unsuffixed executables ..."

>
> $ make LLVM=-14"
>
> to Documentation/kbuild/llvm.rst.
>
> I might change the patch not to be so clever though:
>
> ifneq ($(LLVM),)
> ifneq ($(LLVM),1)
> LLVM_SFX := $(LLVM)
> endif
> endif
>
> [1]: https://lore.kernel.org/r/YXqpFHeY26sEbort@hirez.programming.kicks-ass.net/

I'd be much more amenable to that approach.
-- 
Thanks,
~Nick Desaulniers
