Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A906D5847D7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 23:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiG1Vts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 17:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiG1Vtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 17:49:46 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F3856BB2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 14:49:44 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id s9so3762395edd.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 14:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=40gu5u7tBPIakSFyQ1m/t0Td9u6SRRjNaadPqP/jZYI=;
        b=Hf0dXQ1crSt6UjG6GCNAanYtmoH5RFrL3ms3meTf4tP7XcBC/a5R5s6JcGVLvIEUsy
         a/RaIlwv6SuFOkY1vJ/GYSoL0unFvjIf14SqAn44HnV/6DrRbJPZUstQ7gZmvYZmld2G
         +5unsNt9gMtZ03Cups9Dzi/s9o2Pzpt3RqSuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=40gu5u7tBPIakSFyQ1m/t0Td9u6SRRjNaadPqP/jZYI=;
        b=0gZd3l02gHbqTIAQ6cDewhhlduQ3nAhXNYlwl4uIbrWshAjK2OJjMXAtui6POqH7Ph
         rDmHCzNJrsMFfnZl7HUm0z+TeGU36u26B69GXnsZLD8FG28PTh6wWq7G7wRfzuoD3Nxq
         NcxAnFO6tQg59I6pSemK9V+xGx6nhPMj6W/51GdLqPfp7LdnV8Kax34Y2No5EeUb7Pek
         6alcvL1IYpUBGt+KhA2SpffT55EdWDxEiRbmTl+JnSwPFbzpLmXsRTrBAWu+hQzgIJPG
         +L1g4pIHgQ6tSKoOuNWcwC+48nyD27D0Ev2lGsc6Hgf6PZn14ooRKFFSf5SR+H2igR0U
         /drg==
X-Gm-Message-State: AJIora8UzrWfTL16n5AqBgFi0OgoHDUy6Nk7sWitflV0hpeAZt4Q+vNr
        GmS8j9P9s6zZoU/Nwa7KIaB4y9Kv+79oAPUH
X-Google-Smtp-Source: AGRyM1s1JjJJcQnLdgDc+e7KW6pt6Vjqrl9z7F3bZDVDoy/3+qjb0irbNgKt/FOOWuvCOq3HJY591w==
X-Received: by 2002:a05:6402:27cf:b0:43a:de0b:9a82 with SMTP id c15-20020a05640227cf00b0043ade0b9a82mr878312ede.427.1659044982532;
        Thu, 28 Jul 2022 14:49:42 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id u16-20020a056402065000b0043ab81e4230sm1362953edx.50.2022.07.28.14.49.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 14:49:41 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id i10-20020a1c3b0a000000b003a2fa488efdso1025173wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 14:49:41 -0700 (PDT)
X-Received: by 2002:a05:600c:21d7:b0:3a3:2088:bbc6 with SMTP id
 x23-20020a05600c21d700b003a32088bbc6mr798181wmj.68.1659044980827; Thu, 28 Jul
 2022 14:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220728161208.865420-1-yury.norov@gmail.com> <CAHk-=wiFJboHXZEXtMhDcHbEYXujTiDxkGbpONC=DJA7dJG6nw@mail.gmail.com>
In-Reply-To: <CAHk-=wiFJboHXZEXtMhDcHbEYXujTiDxkGbpONC=DJA7dJG6nw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Jul 2022 14:49:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgga5hrg5qgm4UwuOCjgBrobhZcdKTr1AFU7WSWgVKKZQ@mail.gmail.com>
Message-ID: <CAHk-=wgga5hrg5qgm4UwuOCjgBrobhZcdKTr1AFU7WSWgVKKZQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] lib/find: optimize find_bit() functions
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Jul 28, 2022 at 11:49 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It builds for me and seems to generate reasonable code, although I
> notice that clang messes up the "__ffs()" inline asm and forces the
> source into memory.

I have created a llvm issue for this at

        https://github.com/llvm/llvm-project/issues/56789

and while I noticed this while looking at the rather odd code
generation for the bit finding functions, it seems to be a general
issue with clang inline asm.

It looks like any instruction that takes a mod/rm input (so a register
or memory) will always force the thing to be in memory. Which is very
pointless in itself, but it actually causes some functions to have a
stack frame that they wouldn't otherwise need or want. So it actually
has secondary downsides too.

And yes, that particular case could be solved with __builtin_ctzl(),
which seems to DTRT. But that uses plain bsf, and we seem to really
want tzcnt ("rep bsf") here, although I didn't check why (the comment
explicitly says "Undefined if no bit exists", which is the main
difference between bsf and tzcnt).

I _think_ it's because tzcnt is faster when it exists exactly because
it always writes the destination, so 'bsf' is actually the inferior
op, and clang shouldn't generate it.

But the "rm" thing exists elsewhere too, and I just checked - this
same issue seems to happen with "g" too (ie "any general integer
input").

                      Linus
