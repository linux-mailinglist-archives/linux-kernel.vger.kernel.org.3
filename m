Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7248B4C7D73
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiB1WgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiB1WgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:36:06 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B21113AD6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 14:35:25 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id u7so19399686ljk.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 14:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hYlTdB/zH2zblgmoJbVMlgCNjIMCACNfbfxIFy7zCbg=;
        b=YffGxEV3fEqsY9GWBppaPKRNBrzynzAbY4wbDhUWFOco26tpAhO0IuRkhq7R7kVeGy
         kCGrfkmtISOexCpSwD56tAqw/AgM/E4KcPGmW07tdJ8L7KV9gUJ5loOsfwzPzx4rL0ff
         cDYHSDoIMX0sKc/h1HNr8rms3/UCLLdxaGBGd9OeWf0ChoSiL3vBeXsk8eFWuBftDU/a
         tP6qLXNC7TQPjB0FwnoMgHIzJtGjjBMHmv+TRyXjAHe2aDuPsMDDre44MqC1PK1dHv8X
         Xsj8hrFOHzN0ZmXDvsA1dh0jx7fSDdb/YL2BnjlgcDV9DxoY/cQJ3kyd2y/5n3Lfne1V
         V0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hYlTdB/zH2zblgmoJbVMlgCNjIMCACNfbfxIFy7zCbg=;
        b=c1QQ6UkZuW6wi2K163llloWP7oN0wdrbc6jAbWlqzDilvs5Z4ElklpUVKHOLkQUL+Z
         1QklXBli1/I3rlAhd2ChxuAaR7IivpaBpshTue976lIfutg8Hr0Wlxha+zJHgrNrrvh0
         5l+CJx/H/IQGALYfY33nipWC7Q6oMwrRf2uEDOxIRElfbAzfsHc4i3cknrqMb7TmTg6J
         WOnClqEz48iX6OXPYojpOH3WmjplD4gWksZdsc9dfyat0fKYyp3hy/HSuRprlrGCthNr
         aYLBGFDt2XdZp8AINmiqL/I6EwDdWj/xN4FbiPTAUcPkDQDp/X6LxfjI8PpP8vKca/rh
         /k9Q==
X-Gm-Message-State: AOAM5301ZfAIYDC1nE/u2CQVYJzOCmhO+WrtjehaBhGCFTfV73F86BH1
        PnI0egPv9b7kJrIqASDaCE9ROYdSv4VKNUFRx7gQKw==
X-Google-Smtp-Source: ABdhPJwVHTz2zvTK0ayUxuiGwOqs9pIIC/w5dCvcb2CQUe352hz3nLfzoOWf5Dg7DKvOI2mQE9DiR//yb8ERcSUxlS4=
X-Received: by 2002:a2e:bf24:0:b0:246:801e:39d3 with SMTP id
 c36-20020a2ebf24000000b00246801e39d3mr8691548ljr.472.1646087723877; Mon, 28
 Feb 2022 14:35:23 -0800 (PST)
MIME-Version: 1.0
References: <20220225032410.25622-1-ashimida@linux.alibaba.com>
 <CANiq72kXoonDYk095XvBwEtRCRNECd1iQOqJHE2cNcgLyUMfcQ@mail.gmail.com> <26a0a816-bc3e-2ac0-d773-0819d9f225af@linux.alibaba.com>
In-Reply-To: <26a0a816-bc3e-2ac0-d773-0819d9f225af@linux.alibaba.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 28 Feb 2022 14:35:11 -0800
Message-ID: <CAKwvOdkykPtGTL6ud8qJZHSHKV2eSbpnZE-G4oyymD9BiQKHdg@mail.gmail.com>
Subject: Re: [PATCH] [PATCH v2] AARCH64: Add gcc Shadow Call Stack support
To:     Dan Li <ashimida@linux.alibaba.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Marco Elver <elver@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
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

On Sun, Feb 27, 2022 at 11:37 PM Dan Li <ashimida@linux.alibaba.com> wrote:
>
>
>
> On 2/25/22 12:47, Miguel Ojeda wrote:
> > On Fri, Feb 25, 2022 at 4:24 AM Dan Li <ashimida@linux.alibaba.com> wrote:
> >>
> >> +         - Clang (https://clang.llvm.org/docs/ShadowCallStack.html)
> >> +         - GCC (https://gcc.gnu.org/onlinedocs/gcc/Instrumentation-Options.html#Instrumentation-Options)
> >
> > Maybe Clang: and GCC: instead of the parenthesis?
> >
> Got it.
>
> >> +#ifdef CONFIG_SHADOW_CALL_STACK
> >> +#define __noscs __attribute__((__no_sanitize__("shadow-call-stack")))
> >> +#endif
> >
> > Since both compilers have it, and I guess the `#ifdef` condition would
> > work for both, could this be moved into `compiler_types.h` where the
> > empty `__noscs` definition is, and remove the one from
> > `compiler-clang.h`?
> >
> In the clang documentation I see __has_feature(shadow_call_stack) is
> used to check if -fsanitize=shadow-call-stack is enabled, so I think
> maybe it's fine to use "#ifdef CONFIG_SHADOW_CALL_STACK"
> instead of "#if __has_attribute(__no_sanitize_address__)" here, then
> move it to `compiler_types.h`.

Or simply add a #define for __noscs to include/linux/compiler-gcc.h
with appropriate guard and leave the existing #ifndef in
include/linux/compiler_types.h as is.  I'd prefer that when the
compilers differ in terms of feature detection since it's as explicit
as possible.

>
> And from the results of my local clang 12 compilation, this doesn't
> seem to be a problem.
>
> Link: https://clang.llvm.org/docs/ShadowCallStack.html#has-feature-shadow-call-stack



-- 
Thanks,
~Nick Desaulniers
