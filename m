Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4769351A5C5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353566AbiEDQqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353581AbiEDQqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:46:01 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4211646B14
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 09:42:20 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2f7b815ac06so21962577b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 09:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E92Kc9QSviCU9YuL/lueHEE6ZF2RofRyLsLK9SHZEnk=;
        b=R8J/TT07oYrufV49kAQ3YHUSBYTRi7VEcKUu2DfAyEmJj8PSITMqzsIwsc42rLW0Z0
         8nbWQlU/3RQsgiPhNrJHyn+j7/r1tHvcdC6pOIDDLMIUbbuQvWvEJ4v0ZwdnCpqcnsPy
         IHt0rZWHVl/W+W61m/2q9L4SKno8dnBt1LDMp/DSlvHFouKxP9qED+QMAElGsdC7DfnT
         EI2ogF/23MepFXVgjP+dbKj0WscxN2MPaSE6Hq2SP2VvUE7CEX0KNydbZL0JAY1rsn0A
         qaimhFH3XvY8D6dEErQUro/i8/3eN0G150VIlkGrGf3Zt+8rLud9fme683BmVndhj7Rf
         TTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E92Kc9QSviCU9YuL/lueHEE6ZF2RofRyLsLK9SHZEnk=;
        b=KgOcDfy+eL9IWG+cosauTX7MiEsfdIbvaYNJDY4S0zYiktpUjSPNNBCflCDVb+GV/3
         xl3DtKBfHTrqVGufRaQi7fGgSvceQ8qMZdUgt1mHeNWKHqLgFnowOGP6AUsikZ8StPYT
         vW5qjs+IHgDeqUAEI+2SqLWeWs8T1WX4kk6PHh+wxwj1f2egFrDNXpD5c02kbrIZjfMg
         t3ShKdd767+nf3BPbm9wkpLoGUaVtiAj4h2CdwlRDr+hdgiQPVNIM7H1GbRj1t2eLYd3
         BCkrsyBcR0Dr8C5BLDpCqO2K6V+BJzuQmylADCr/dP4jty5dsyfpNnx2IREJ++in75hx
         whEA==
X-Gm-Message-State: AOAM532YSYZHZUbs5wkqNvVbcSwq2q0vgsIV1kAlg3tkXkeu8lEwjuZU
        nwNkiUxOKFZ6+Nc/b1ThWWjg8LEJah7VFDGyFzyx0Q==
X-Google-Smtp-Source: ABdhPJwB5M3V9c+Qv29Mq6hOLNSkS/Cx5S+8NXTtckXjYvD9wrbuciGbXqgPOAtbV19GJMbODjTK/MWJYRMmEhMP+pU=
X-Received: by 2002:a81:1e14:0:b0:2f8:c348:9c62 with SMTP id
 e20-20020a811e14000000b002f8c3489c62mr20003528ywe.291.1651682539258; Wed, 04
 May 2022 09:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com> <YnKnLyyXPJl5Llc0@FVFF77S0Q05N>
In-Reply-To: <YnKnLyyXPJl5Llc0@FVFF77S0Q05N>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 4 May 2022 09:41:43 -0700
Message-ID: <CABCJKudT9r=r0an4BwNp0-E1wC94wLWiHvUX4_vA8tDkQ=uHKQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/21] KCFI support
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev
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

Hi Mark,

On Wed, May 4, 2022 at 9:18 AM Mark Rutland <mark.rutland@arm.com> wrote:
> I wanted to give this a spin on arm64, but I'm seeing some very odd toolchain
> behaviour. I'm not sure if I've done something wrong, or if I'm just hitting an
> edge-case, but it looks like using -fsanitize=kcfi causes the toolchain to hit
> out-of-memory errors and other issues which look like they could be memory
> corruption.

Thanks for the detailed bug report! It definitely looks like something
is wrong with the recent switch from std::string to Twine in the Clang
code. I didn't see this issue when compiling the arm64 kernel, but
I'll take a closer look and see if I can reproduce it.

Sami
