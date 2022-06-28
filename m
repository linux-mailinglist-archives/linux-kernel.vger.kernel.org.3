Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBF555ECE9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 20:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbiF1SpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 14:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbiF1SpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 14:45:20 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD4F2409E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 11:45:19 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f39so23904266lfv.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 11:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4A7JptdsYkzAASzc4tkybkZDdctkCSB8PkmFN8uYVCI=;
        b=jKK9ituFZ+ubZapMzrh1ZUAkCQdnD2GwgEoK2/+06e9by7rYWo0M21RwB9RhuDTOV1
         sirjg4cgMk5iTnWIgO/+RUZo522q2VNlm3/BCjQf+4qD4a6c6eiPx5pIFCswicWwjnhh
         rhYcXDmIFoyQjq13x1jth2oavyXK/dUCXGEE4lWGNKeBIuydRbjvM1rGqIjKsa6Wkg/k
         YV939/4UKnIdOKjckr8oZEg0t/sPqlnXVdjgpGPnnVBInQGYes1UDs8hfszL7rdS3Ees
         9JNvIGIPqXvcy1JFsGvcZyroGMvo4EOcspdtr74iFRTQQU0H7qywfOosyr7VMYz/MnVg
         E8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4A7JptdsYkzAASzc4tkybkZDdctkCSB8PkmFN8uYVCI=;
        b=R5EOfmWHujggFoJj/5hDllobexBSyNosXv5WB3ZcqkFrlmJ/n190PU3Dl9co1oq3AA
         llRgYKzDHUM5ORS507WVWM2L94dhRz/lFBPtiFx1AgOozOsVgMJOi62zbDNUL7SxjKH2
         m5nlTfHn6F67CRZhtjDTfAoBg6JT13VpINE8vU3mf7tQQPaX/nUgyid9lU3zjFZg5ntw
         BTwsLyVU42ygfzpIZpsrmJvVJsE1Q4/vrE4I3YVlcizdHx6K82Fy3Ts7X1oRa2Fhrwh8
         sV4mwkmnUfkT+Y9jZIn5nzUHvP0kYii9wO2PtNgNT+LnvKELCToJBytAEOtzpLCVV5p0
         Bbvw==
X-Gm-Message-State: AJIora9AaXVbOrfmlxLw2Sde3sVPtov/50mfsvVmrJVy+Z49B4FdxJW1
        00hnz+rDnhwyjj+ZZtxEZqLhhq253WmZEMc+ULjtng==
X-Google-Smtp-Source: AGRyM1vT0A85nTZOQqS3XNPxs7XxozWywoh4CvpbznRddJchqP81sTLCvsoMEeNPd7QxyA7myNcILnRQ+L+b6muQqqw=
X-Received: by 2002:a05:6512:1307:b0:47f:baa4:52c5 with SMTP id
 x7-20020a056512130700b0047fbaa452c5mr11957896lfu.103.1656441917176; Tue, 28
 Jun 2022 11:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220628012353.13995-1-jhubbard@nvidia.com>
In-Reply-To: <20220628012353.13995-1-jhubbard@nvidia.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 28 Jun 2022 11:45:05 -0700
Message-ID: <CAKwvOd=FmKYse9NEvMt5MHev5wRzeZH6AcBd1uQEL5k0GLP+Zw@mail.gmail.com>
Subject: Re: [PATCH v3] gen_compile_commands: handle multiple lines per .mod file
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
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

On Mon, Jun 27, 2022 at 6:24 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> scripts/clang-tools/gen_compile_commands.py incorrectly assumes that
> each .mod file only contains one line. That assumption was correct when
> the script was originally created, but commit 9413e7640564 ("kbuild:
> split the second line of *.mod into *.usyms") changed the .mod file
> format so that there is one entry per line, and potentially many lines.
>
> The problem can be reproduced by using Kbuild to generate
> compile_commands.json, like this:
>
>     make CC=clang compile_commands.json
>
> In many cases, the problem might be overlooked because many subsystems
> only have one line anyway. However, in some subsystems (Nouveau, with
> 762 entries, is a notable example) it results in skipping most of the
> subsystem.
>
> Fix this by fully processing each .mod file.
>
> Fixes: 9413e7640564 ("kbuild: split the second line of *.mod into *.usyms")
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>

Thanks for the fix, John!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>
> Link to v2:
> https://lore.kernel.org/all/20220616021149.327587-1-jhubbard@nvidia.com/
>
> Changes since v2:
>
>   * Restored a blank line.
>
>   * Rewrote the commit description.
>
> thanks,
> John Hubbard
>
>
>  scripts/clang-tools/gen_compile_commands.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
> index 1d1bde1fd45e..47da25b3ba7d 100755
> --- a/scripts/clang-tools/gen_compile_commands.py
> +++ b/scripts/clang-tools/gen_compile_commands.py
> @@ -157,10 +157,10 @@ def cmdfiles_for_modorder(modorder):
>              if ext != '.ko':
>                  sys.exit('{}: module path must end with .ko'.format(ko))
>              mod = base + '.mod'
> -           # The first line of *.mod lists the objects that compose the module.
> +            # Read from *.mod, to get a list of objects that compose the module.
>              with open(mod) as m:
> -                for obj in m.readline().split():
> -                    yield to_cmdfile(obj)
> +                for mod_line in m:
> +                    yield to_cmdfile(mod_line.rstrip())
>
>
>  def process_line(root_directory, command_prefix, file_path):
> --
> 2.36.1
>


-- 
Thanks,
~Nick Desaulniers
