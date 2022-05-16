Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8435529351
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 00:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349571AbiEPWDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238440AbiEPWDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:03:40 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94F728E09
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 15:03:38 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2ec42eae76bso168486957b3.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 15:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IjaOHrJPxQNUMk++gKnFcKFfTSw8FlwW+UyobtzjVj0=;
        b=CmIEj5n1Rl0HWNhLuhDFskWScqMt8sTZf+nhjXYfnm9nlgr/YXq9h82Fae9Y2KTq1g
         KryZOd70RTA6tPdFd6uEglWV6hKFFIZmg7ZFv30zU1JzLwvckRRLR0MEMdF00hjHIHDf
         hVEuQ8BqEIRE3mG//CqcrOWdJM1NQz8jL2LfiBTS0Uvbwue/yEjA0leJcwc3aoJbKFUo
         HsYsHIyfIVblYlpHWWLtcT5unFYiki04NZBQO/jfec+mhGllAxhTLo9QATAqOOLauq7u
         ckKDPDyG+lHdQjd1OuL/8h39HKfWcmiAhNYRkNnJwcWE1smI+GnPF/PAEkdRN2Dzzitq
         q0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IjaOHrJPxQNUMk++gKnFcKFfTSw8FlwW+UyobtzjVj0=;
        b=E+gXmMSyrgEGrwjoufVOBW89ymgjxJDqzaBuao8BLp8vof/9ZSOFL+dyYIxsTBI6k1
         d5EGAJeJbEeFvO33UfujOTfzvcptG9r7q9DgG+4QiMSzQoGFKsSoCdOihGseXR3Lo9x7
         bodxX2SQ3Sce82avEyrgencBvrwS1PIhdrrZsl7SHkL1dHxdo/hje4i/ZnbdULLuuLZV
         f78nVx1T5CT2ZzExlQVpXU1mmg/uhn+2+wlzU6qvMbvgT/I2g+1eww7neigiMeJaHgdl
         hwMnxDz6HUqkRDU6LDZUyBaDLThbII+7Sa+2iIUN8n7fa9yAhMwgO0FOWr9vfOxOqtZJ
         PzBQ==
X-Gm-Message-State: AOAM530ho6yBkdKv00nt9ZX/+LaVPGiTVjE3ZFLKi6cq6YaU/PwihJEC
        DeZZzy0WGhONfrExMaXRBbtGLSIoT9M074PQQDvezw==
X-Google-Smtp-Source: ABdhPJw3sBkLaeksICo+46rO2UaS3Fk7vsTQRrcZQqDXNASr5C339hIh2SUj2o4+spHZoBL4AtjH3f55xJ+hksTEK84=
X-Received: by 2002:a0d:d747:0:b0:2ff:22b9:9281 with SMTP id
 z68-20020a0dd747000000b002ff22b99281mr1573852ywd.305.1652738618031; Mon, 16
 May 2022 15:03:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-21-samitolvanen@google.com> <f65c01979b884174965802a13cf6b077@AcuMS.aculab.com>
 <CABCJKueo+cw1DHH6N2dUjD-U7OKqmkJUyimm0ychv1drt5U9Rg@mail.gmail.com>
 <19b3e040302d4d8aa240eee43427dfaa@AcuMS.aculab.com> <20220516214414.GR76023@worktop.programming.kicks-ass.net>
In-Reply-To: <20220516214414.GR76023@worktop.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 16 May 2022 15:03:02 -0700
Message-ID: <CABCJKucPMgMQ-D_yByvMSx6yutjsBXGAwirmheOYejWHARi9iQ@mail.gmail.com>
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

On Mon, May 16, 2022 at 2:44 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, May 16, 2022 at 09:32:55PM +0000, David Laight wrote:
>
> > > The compiler always generates this specific instruction sequence.
> >
> > Yes, but there are several ways to encode 'cmpl imm,-6(reg)'.
>
> Yes, but we don't care. This *always* uses the 32bit immediate form.
> Even if the immediate is small.

Yes, that part is not a problem, but it's a valid point that LLVM
might not always use r8-r15 here, so I will have to check for the REX
prefix before blindly attempting to decode the instruction.

Sami
