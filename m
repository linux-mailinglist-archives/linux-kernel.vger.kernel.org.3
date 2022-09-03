Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2076E5AC09E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 20:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbiICSXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 14:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiICSXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 14:23:15 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAA34E628;
        Sat,  3 Sep 2022 11:23:14 -0700 (PDT)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 283IMsO8020276;
        Sun, 4 Sep 2022 03:22:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 283IMsO8020276
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662229375;
        bh=Dxm2wQdJj73TakmQEfY+6pG1g4ZOeoTk/i+CCWeCWRE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g6ANVaL2IxQaEKpn8bW3eCUgMp4EGJuzH1wHH0A+ZmxW/4caNZflWADJibwYud3F2
         ophhKsX2aTL5gWJZs4kG5pDpXHNnPoF39sQ1qe7fpTbEKICMEZkfM3Ke9BpD4ScpIC
         7vcvftdQEXqiEKY/qG4SgmQAsuMf2EJ4LljkPaWIukixeqZW3lB0D+SfIBKfpHLAsj
         P1/JCk3t5oS4lgl2S6W7UoLKaPHXxOueK+SqMq1Faiv7i3IhlnhGbe8B5tv2LOy6C+
         ogBDucroXrBs4V1Dr7RIBQkl/yneAgVHiB4LLPnIQJP375TetytrkEl5eIJJ65Owjt
         GxM1H3qqH/kwQ==
X-Nifty-SrcIP: [209.85.160.54]
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-11ee4649dfcso12670407fac.1;
        Sat, 03 Sep 2022 11:22:54 -0700 (PDT)
X-Gm-Message-State: ACgBeo2bTWiaIO2I6790All7VU2gX+M+7vksiErlVBXSo0MNudpV7Jvp
        cJDwVOgAcha70ubyYMT/AQqLh8gJCfru+T9/J1A=
X-Google-Smtp-Source: AA6agR5XKsnppjDXu4BD9qugd41qLgY6/rMzviOWkZiuaL6QjvVlXtseU4fcnp90Ju6SmXMiKkvZPUbk0DFIfHubSNc=
X-Received: by 2002:a05:6870:f626:b0:10d:a798:f3aa with SMTP id
 ek38-20020a056870f62600b0010da798f3aamr5119106oab.194.1662229373859; Sat, 03
 Sep 2022 11:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiW_LjFRE9wFMj-j2gp9=u8jqrMVZtT3n4-oJWtQ6E0iQ@mail.gmail.com>
 <20220901175913.2183047-1-ndesaulniers@google.com>
In-Reply-To: <20220901175913.2183047-1-ndesaulniers@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 4 Sep 2022 03:22:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNARmhEE8Fxas5_VRKCzGYb9gMH-iDiKGo9yZaYSCzB0KsA@mail.gmail.com>
Message-ID: <CAK7LNARmhEE8Fxas5_VRKCzGYb9gMH-iDiKGo9yZaYSCzB0KsA@mail.gmail.com>
Subject: Re: [PATCH] Makefile.extrawarn: re-enable -Wformat for clang; take 2
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Justin Stitt <jstitt007@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 2, 2022 at 2:59 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> -Wformat was recently re-enabled for builds with clang, then quickly
> re-disabled, due to concerns stemming from the frequency of default
> argument promotion related warning instances.
>
> commit 258fafcd0683 ("Makefile.extrawarn: re-enable -Wformat for clang")
> commit 21f9c8a13bb2 ("Revert "Makefile.extrawarn: re-enable -Wformat for clang"")
>
> ISO WG14 has ratified N2562 to address default argument promotion
> explicitly for printf, as part of the upcoming ISO C2X standard.
>
> The behavior of clang was changed in clang-16 to not warn for the cited
> cases in all language modes.
>
> Add a version check, so that users of clang-16 now get the full effect
> of -Wformat. For older clang versions, re-enable flags under the
> -Wformat group that way users still get some useful checks related to
> format strings, without noisy default argument promotion warnings. I
> intentionally omitted -Wformat-y2k and -Wformat-security from being
> re-enabled, which are also part of -Wformat in clang-16.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Link: https://github.com/llvm/llvm-project/issues/57102
> Link: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2562.pdf
> Suggested-by: Justin Stitt <jstitt007@gmail.com>
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Youngmin Nam <youngmin.nam@samsung.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Linus, I figured I'd send this to you to see whether you'd prefer to
> apply it, or let it "ride the trains" up through the kbuild tree? I do
> have another series I'm working on to improve the compiler version
> checks
> <https://lore.kernel.org/llvm/20220831184408.2778264-4-ndesaulniers@google.com/>
> where I can/will improve the checks used here, but I'm also interested in
> having something that might backport cleanly to stable.

Linus was addressed, so I just reviewed it.

Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>


-- 
Best Regards
Masahiro Yamada
