Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6750F575779
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 00:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241021AbiGNWPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 18:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGNWPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 18:15:16 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC11A4AD7A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 15:15:12 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e15so4162923edj.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 15:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=my5qru7kqzoTpYDlsQu0xITwTY0Hh5OwELAs4fo4zY8=;
        b=GlxE5oHtW5ud5Gv1JPWcbZYuF3saChl7AfUSHMcR8VnMAQUPu3EyIxoSwUEBh1Hgwk
         HF+iMgE2YpvcbSLjfG3zCrrHZFrev3/gq0aYQDBwtDW0Inkpe4XSpw1hB1mA6Vp2mRr2
         rUZibpS2GWUgVhEDprX250UIjPcUhfUQHcB3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=my5qru7kqzoTpYDlsQu0xITwTY0Hh5OwELAs4fo4zY8=;
        b=ZxnSH+dw67aCBRzoXysL5GVnRj5RSkdtwv/zLLdZ6xmwH9q2S7Fv9driLFIQB3uDsM
         eefmepqyPPCJT3eC08mH+cYFY/Xf2hZoVN58OMTPaN4oiF0R+i9VsfxtgfuT/bVE/M+J
         mrX98ROLHhkrfPIZ8GaMmw9Mn/KCdZK9ErQrLY4qu0ybGJn6wSWWhGbQEoAIV4Ky4z2c
         QQoFNWiHHoL5np6eveXTkqU8Hc4eumLz9+ZT9BHzg8al5f9FXL1Jbaz20dGfHld9kiJE
         LoO9jB45KHkIQ0wtyTceAnpTfEp1F97JmcUWZuP4BHKDsIj8YRZ8WSpifAgmCoAFqIBb
         ew6g==
X-Gm-Message-State: AJIora+cA1wEEjG+3DWtpo0y+9GpfS5w1e/ziFaQi9meiGfu5ymtg83P
        fp58s5jhLMFaxBWb5dYgxDBtS2rZPeO1naD/RIE=
X-Google-Smtp-Source: AGRyM1v1rzxNMrga/loOB9aq1wjuOlkvynwB4b4mddBPUoZU2g4mbe/RMT1x9emm5hpkhDNvvx/9Ug==
X-Received: by 2002:a05:6402:1011:b0:43a:76bf:6c40 with SMTP id c17-20020a056402101100b0043a76bf6c40mr15205153edu.352.1657836911324;
        Thu, 14 Jul 2022 15:15:11 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id kw20-20020a170907771400b006fe8ac6bc69sm1212854ejc.140.2022.07.14.15.15.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 15:15:10 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id ay11-20020a05600c1e0b00b003a3013da120so1874680wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 15:15:10 -0700 (PDT)
X-Received: by 2002:a05:600c:34c9:b0:3a0:5072:9abe with SMTP id
 d9-20020a05600c34c900b003a050729abemr11134747wmq.8.1657836910095; Thu, 14 Jul
 2022 15:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220713152436.2294819-1-nathan@kernel.org> <20220714143005.73c71cf8@kernel.org>
 <CAHk-=wi+O_3+uef45jxj1+GhT+H0vXs9iz8rpjk49vCiyLS4DA@mail.gmail.com> <20220714145652.22cf4878@kernel.org>
In-Reply-To: <20220714145652.22cf4878@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Jul 2022 15:14:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgqJFV45497fBfc1HS3Oaoqi3pfenZ0XM3uqFGYz8wTQQ@mail.gmail.com>
Message-ID: <CAHk-=wgqJFV45497fBfc1HS3Oaoqi3pfenZ0XM3uqFGYz8wTQQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/speculation: Use DECLARE_PER_CPU for x86_spec_ctrl_current
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        stable <stable@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 2:56 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> I have clang 13, let me double check this fix is enough for the build
> to complete without disabling WERROR.

I have clang 14 locally, and it builds fine with that (and doesn't
build without it).

I actually normally build the kernel with both gcc and clang. My
"upstream" kernel I build with gcc, and then I have my "private random
collection of patches" kernel that I build with clang and that are
just rebased on top of the kernel-of-the-day.

This is all entirely for historical reasons - part of my "private
random collection of patches" used to be the "asm goto with outputs",
which had clang support first.

But then the reason I never even noticed the build breakage with the
retbleed patches until much too late was that those I just had as a
third fork off my upstream kernel, so despite me usually building with
clang too, that only got attention from gcc.

So it's really just a microcosm version of the exact same bigger issue
we always have with those embargoed hw security patches: they end up
missing out on all the usual test environments.

Anyway, I cherry-picked Nathan's patch from my clang tree and pushed
it out as commit db886979683a ("x86/speculation: Use DECLARE_PER_CPU
for x86_spec_ctrl_current").

                 Linus
