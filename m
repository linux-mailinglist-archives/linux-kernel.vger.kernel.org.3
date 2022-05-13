Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8335269CB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 21:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383354AbiEMTCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 15:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241084AbiEMTCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 15:02:49 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEE17A441
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 12:02:47 -0700 (PDT)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 24DJ2XmT019860
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 04:02:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 24DJ2XmT019860
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652468554;
        bh=iQTc2AO61Uzv/pzq5Xi9leCiTwHUn5EA24N23SAXkj0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BnnyHMMtQ4UjDy9edZIAPozQTVpIMBsqSz6xYHhRC/5iV1/iO2UneSaS9EbJHgvTj
         5fQsQfS8H4dP0gaHRTSECUur7+Vr5wnaqKkLWhJyg0J6uH4KRHZZxbLJt/vQsg3/dO
         4lF0mtdvzuOqeknxrk6/wVrcIvdhgrZ9GBvpcn9T2p9kYLoiJUG8ThZrtptYZGdmbX
         Gwkz6oDdPZS7sc5sAVox9c93LhvTSFNXPp9c+uP1miCYuhYS/xVOp5VwfxswoFFvpX
         w5l/U3Y3rBqx0dp9YQ4xoaOwzScjgkJKRfRGdZOcVXvp75rHULkLz5p51uuEjN+n6G
         agk5ZXmvZftPg==
X-Nifty-SrcIP: [209.85.216.44]
Received: by mail-pj1-f44.google.com with SMTP id cq17-20020a17090af99100b001dc0386cd8fso8562176pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 12:02:34 -0700 (PDT)
X-Gm-Message-State: AOAM531pObXryvwZMXoA14qDsBUKVEZMta2aYqJr4FWjXGvSUpMG58mL
        JP8zx+wYRFi3NDA7iqMiv90zaMjESvshFR9IAyU=
X-Google-Smtp-Source: ABdhPJygIulUBkKfBOm4BvrIqVuuNvQytkDnHnNySy88uZFqHTBmcY3l8GFLkJ8Erx9o18IOAKESEdc8lqwkKWE+4os=
X-Received: by 2002:a17:90a:e517:b0:1d7:5bbd:f9f0 with SMTP id
 t23-20020a17090ae51700b001d75bbdf9f0mr6213496pjy.77.1652468553283; Fri, 13
 May 2022 12:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220426155229.436681-1-mailhol.vincent@wanadoo.fr>
 <20220507131146.834810-1-mailhol.vincent@wanadoo.fr> <20220507131146.834810-3-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20220507131146.834810-3-mailhol.vincent@wanadoo.fr>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 14 May 2022 04:01:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNATuvQhiZZ8A9+RcLYKmbugi6S61Aw5CStc3xbfGM-L34Q@mail.gmail.com>
Message-ID: <CAK7LNATuvQhiZZ8A9+RcLYKmbugi6S61Aw5CStc3xbfGM-L34Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] kbuild: call check-atomics.sh only if
 prerequisites change
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 7, 2022 at 10:13 PM Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>
> check-atomics.sh is executed unconditionally. Most developers will not
> modify the files being checked by this script and thus do not need to
> execute it again for each iterative make.
>
> We first add an additional dependency to include/linux/atomic/* to
> make sure that the script gets executed again if the headers are
> modified. We then use the if_change macro instead of cmd. c.f. [1] and
> create the dot file scripts/atomic/.check-atomics which is used for
> the target timestamp. Finally, the dot file is added to the
> CLEAN_FILES target.
>
> [1] https://www.kernel.org/doc/html/latest/kbuild/makefiles.html#command-change-detection
>
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>


I do not like this approach.

I wrote a different patch.
https://lore.kernel.org/lkml/20220513185340.239753-1-masahiroy@kernel.org/T/#u

This naturally works by comparing the timestamp
between *_shipped and include/generated/*.







> ---
>  Kbuild   | 7 ++++---
>  Makefile | 3 ++-
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/Kbuild b/Kbuild
> index fa441b98c9f6..c3cb76ebcbaf 100644
> --- a/Kbuild
> +++ b/Kbuild
> @@ -50,10 +50,11 @@ missing-syscalls: scripts/checksyscalls.sh $(offsets-file) FORCE
>  #####
>  # Check atomic headers are up-to-date
>
> -always-y += old-atomics
> +always-y += scripts/atomic/.check-atomics
>
>  quiet_cmd_atomics = CALL    $<
>        cmd_atomics = $(CONFIG_SHELL) $<
>
> -old-atomics: scripts/atomic/check-atomics.sh FORCE
> -       $(call cmd,atomics)
> +scripts/atomic/.check-atomics: scripts/atomic/check-atomics.sh $(wildcard include/linux/atomic/*) FORCE
> +       $(call if_changed,atomics)
> +       @touch $@
> diff --git a/Makefile b/Makefile
> index 9a820c525b86..9e815c8bb0b6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1483,7 +1483,8 @@ endif # CONFIG_MODULES
>  # Directories & files removed with 'make clean'
>  CLEAN_FILES += include/ksym vmlinux.symvers modules-only.symvers \
>                modules.builtin modules.builtin.modinfo modules.nsdeps \
> -              compile_commands.json .thinlto-cache
> +              compile_commands.json .thinlto-cache \
> +              scripts/atomic/.check-atomics
>
>  # Directories & files removed with 'make mrproper'
>  MRPROPER_FILES += include/config include/generated          \
> --
> 2.35.1
>


-- 
Best Regards
Masahiro Yamada
