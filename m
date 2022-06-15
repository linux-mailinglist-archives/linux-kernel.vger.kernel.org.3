Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C876554C48D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241597AbiFOJYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbiFOJY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:24:26 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153F315726
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:24:24 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 25F9O0B1025279
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 18:24:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 25F9O0B1025279
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1655285041;
        bh=z11ovVAKqI6ZA7KGXOW96R1KX78wxZ9sWHcYkCBNvWg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ApQ8fSYtWZBsD7TbE6Ktx2ZrVkQyDEepc6TLORaln5uOlE9z6x8Pys64Uuqt/4Hx0
         eSXlBMR7sJoLVjsw5oAUTjE0OJjJJJVx7TGeRyxRGG1ZJ7tw7He73J8M90jDcWtEU0
         +ZwPmJ0QxCClZ3WdbGAShZREpuD0c0Pi6VOq31tg1KzcHONPaQfHbVL4MptqEL6yP/
         GUyz8E4q9Fs2NeKEUQnXZtOOMK0M4teDpbbIhtKQvCYxyX08APMxj6IL1TXym6IUHd
         qh3Hd9c2BIobtwgt19gYjztzCXqJzN/rDEcfiIrCULo43gf5jQilvENycbiaMVefA7
         97kGQg4RYUK4w==
X-Nifty-SrcIP: [209.85.221.54]
Received: by mail-wr1-f54.google.com with SMTP id o8so14520603wro.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:24:01 -0700 (PDT)
X-Gm-Message-State: AJIora/bucf5LQlD2DAt/X/BifGhfzPxaDy9MH3oiIYCCDQTY/qyvIcE
        eOeHyi1XQmzXUc9Y4U8NlXJkuISR9+5I2HtXYvI=
X-Google-Smtp-Source: AGRyM1sqFYEVeX64ueL9l7/Y7mETTav4VvtRR1t9Qr1JlCTC/16FkyM+glftepeHKk6lexJFVxZcY9atNgWvoVVAmUM=
X-Received: by 2002:a05:6000:156d:b0:210:3135:ce1c with SMTP id
 13-20020a056000156d00b002103135ce1cmr9167065wrz.409.1655285039469; Wed, 15
 Jun 2022 02:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220615063315.279489-1-jhubbard@nvidia.com>
In-Reply-To: <20220615063315.279489-1-jhubbard@nvidia.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 15 Jun 2022 18:23:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNARsHxH1LF8Pq70EMAYW-p1btgAVC1cJMOkXSTjW5LZuKA@mail.gmail.com>
Message-ID: <CAK7LNARsHxH1LF8Pq70EMAYW-p1btgAVC1cJMOkXSTjW5LZuKA@mail.gmail.com>
Subject: Re: [PATCH] gen_compile_commands: fix overlooked module files
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 3:33 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> scripts/clang-tools/gen_compile_commands.py incorrectly assumes that
> each .mod file only contains one line.

Thanks for catching this.

That assumption was correct until recently.
  The first line contained member objects.
  The second line, if CONFIG_TRIM_UNUSED_KSYMS=y, contained unresolved symbols



Commit 9413e7640564 ("kbuild: split the second line of *.mod into *.usyms")
changed the format of *.mod so member objects are listed per-line.




> In fact, such files contain one
> entry per line, and for some subsystems, there can be many, many lines.
> For example, Nouveau has 762 entries, but only the first entry was being
> processed. This problem causes clangd to fail to provide references and
> definitions for valid files that are part of the current kernel
> configuration.
>
> This problem only occurs when using Kbuild to generate, like this:
>
>    make CC=clang compile_commands.json
>
> It does not occur if you just run gen_compile_commands.py "bare", like
> this (below):
>
>    scripts/clang-tools/gen_compile_commands.py/gen_compile_commands.py .
>
> Fix this by fully processing each .mod file. This fix causes the number
> of build commands that clangd finds in my kernel build (these numbers
> are heavily dependent upon .config), from 2848 to 5292, which is an 85%
> increase.
>
> Fixes: ecca4fea1ede4 ("gen_compile_commands: support *.o, *.a, modules.order in positional argument")

This should be

Fixes: 9413e7640564 ("kbuild: split the second line of *.mod into *.usyms")


Can you update the commit log?


> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  scripts/clang-tools/gen_compile_commands.py | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
> index 1d1bde1fd45e..53590e886889 100755
> --- a/scripts/clang-tools/gen_compile_commands.py
> +++ b/scripts/clang-tools/gen_compile_commands.py
> @@ -157,10 +157,11 @@ def cmdfiles_for_modorder(modorder):
>              if ext != '.ko':
>                  sys.exit('{}: module path must end with .ko'.format(ko))
>              mod = base + '.mod'
> -           # The first line of *.mod lists the objects that compose the module.
> +           # Read from *.mod, to get a list of objects that compose the module.
>              with open(mod) as m:
> -                for obj in m.readline().split():
> -                    yield to_cmdfile(obj)
> +                for line in m.readlines():


                    for line in m:

is simpler, (and maybe will work more efficiently).


One more note, the 'line' iterator is shadowing (overwriting)
the outer 'line' iterator, which has been used a few lines above.

    with open(modorder) as f:
        for line in f:



Maybe, it is safer to use a different name for the inner iterator
because shadowing does not work in Python.





> +                    for obj in line.split():

This loop is unneeded because each line
contains only one word.
.rstpip() will do.



To sum up, this part can be simpler,
for example like this:

           # Read from *.mod, to get a list of objects that compose the module.
            with open(mod) as m:
                for line2 in m:
                    yield to_cmdfile(line2.rstrip())





> +                        yield to_cmdfile(obj)
>
>
>  def process_line(root_directory, command_prefix, file_path):
> --
> 2.36.1
>


-- 
Best Regards
Masahiro Yamada
