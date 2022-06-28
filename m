Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F2855ECAC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 20:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbiF1Sfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 14:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbiF1Sfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 14:35:46 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C0E1F63D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 11:35:44 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id by38so15945270ljb.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 11:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YV/ic2nJK86HnUIOMUgVla8Xt0B3UgI9C6gRscyJXgQ=;
        b=TfgzWfMWdQkzi71AmCMMQY4Hx0x50KxfNaYawdd+TrXKaMVm6bKgF/JHHjNF4kQmgH
         HVzC35MaljuGQC64pYn3EBiqFPnAodrVXJ5dHvf7zSVi05t2DyWke0fi5V4/YF2kx8Go
         e5o3quAXLrKt+By0EW6ATIDMamXytd+yGFlMy2euaMQ5gHLp4MmsI6VkMxdv0pgfhfFp
         n/Uwr/unhvIV9MCEr3uTixDkUxDXRH15i8rck+Nn3GTT6YgaUcjzlc6fXHUDr+nRtjgY
         MDMLE4W1rdWegt6wdapm+3Jd3ERV1e7bw6Z/k4JKIxEU0A5DubFnfIdtyC1rCRcshaA7
         ty5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YV/ic2nJK86HnUIOMUgVla8Xt0B3UgI9C6gRscyJXgQ=;
        b=uUeouvqGZcNd4rTgcZkqCHvwrlYvOBBCcOzsclTmCrSWim4nsfutjdhF+w3OSazTvr
         cBkHwByGSQj9yfQ7+H4/xQPfu3PYRehmDgojEGfN/twOoa45IR86GJqB9HtzxzoNep4l
         in4AYrZ6zoeIDu4Jo/4JCOcpKqEu2zlpXBhJsMinxDpFZCRPX585bjjrOXA/amaI+EGC
         /fBAEYndlIGZDLwuqwSPrYlGYJ2L9/zQGUMSS7YmSZCrzv9SmMUj6jmUWqgd/Q/YC683
         sdsFpWfvRXAh7DkHoQv7oagYvJ1ybGrjmEeSez8Rw6ETLw4y3NrTKpMOvvj7AD5D+5T/
         KgJA==
X-Gm-Message-State: AJIora8tiYaaxPYEagNH3z9wwaQg6yIozfxnTWumUXfST4QwyB39S1zg
        I3O40caylwlwBgeNWiX/yvpHRmzNGEN5xPRB2dvVUA==
X-Google-Smtp-Source: AGRyM1vrzSAkbrd6jdTE3ltMBBV/0dCh+11hEYGtlcNSC+F3qguOSt5a59CiQfEPPDvHkPSa3S3pXjfeVRYpy+1+J70=
X-Received: by 2002:a2e:8e94:0:b0:25a:83fd:eeec with SMTP id
 z20-20020a2e8e94000000b0025a83fdeeecmr10456342ljk.493.1656441342586; Tue, 28
 Jun 2022 11:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220628122741.93641-1-daniel.thompson@linaro.org> <20220628122741.93641-2-daniel.thompson@linaro.org>
In-Reply-To: <20220628122741.93641-2-daniel.thompson@linaro.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 28 Jun 2022 11:35:30 -0700
Message-ID: <CAKwvOdnUdCq4AUJQEsPkkBXfG-BN7ZJHOJ5KHh43SsfogeOeqQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] clang-tools: Generate clang compatible output even
 with gcc builds
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
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

On Tue, Jun 28, 2022 at 5:27 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently `make compile_commands.json` cannot produce useful output for
> kernels built with gcc. That is because kbuild will opportunistically

Right, compile_commands.json should reflect reality, as in what flags
were actually used for the build.

> enable gcc-specific command line options from recent versions of gcc.
> Options that are not compatible with clang cause trouble because most of
> the tools that consume compile_commands.json only understand the clang
> argument set. This is to be expected since it was the clang folks wrote
> the spec to help make those tools come alive (and AFAIK all the tools
> that consume the compilation database are closely linked to the clang
> tools):
> https://clang.llvm.org/docs/JSONCompilationDatabase.html

It sounds like the raison d'etre for this patch is to support
clang-tidy and clang-scan kernel Makefile targets when CC=gcc?

In that case, it sounds like compile_commands.json should be post
processed only when using those Makefile targets with CC=gcc.

As in:

$ make compile_commands.json

Should continue to produce a pristine/unmodified for this purpose
compile_commands.json.  Only when:

$ make clang-analyzer
or
$ make clang-tidy

are run should we:
1. produce a second compilation database in which we filter out
command line flags clang cannot consume.
2. pass that explicitly to clang-tidy via -p.

I suspect that second compile_commands.json will have to be placed in
a new dir as well.


I'm sympathetic to the intent of the series, but I think it corrupts
the compilation_commands.json for gcc builds in order to support one
new use case, at the cost of harming existing and future potential use
cases by stripping out information that is precise. Such loss of
fidelity makes me uncomfortable accepting this change as is.

>
> Let's fix this by adding code to gen_compile_commands.py that will
> automatically strip not-supported-by-clang command line options from
> the compilation database. This allows the common consumers of the
> compilation database (clang-tidy, clangd code completion engine,
> CodeChecker, etc) to work without requiring the developer to build the
> kernel using a different C compiler.
>
> In theory this could cause problems if/when a not-based-on-clang tool
> emerges that reuses the clang compilation database format. This is not
> expected to be a problem in practice since the heuristics added to
> gen_compile_commands.py are pretty conservative. The should only ever
> disable some rather esoteric compiler options ("they must be esoteric
> otherwise clang would have implemented them..."). It is hard to reason
> about what will/won't break tools that are not yet written but we can
> hope the removing esoteric options will be benign!
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  Makefile                                    |  5 +-
>  scripts/clang-tools/gen_compile_commands.py | 71 ++++++++++++++++++++-
>  2 files changed, 74 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 513c1fbf7888..9ea6867aaf9c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1886,8 +1886,11 @@ nsdeps: modules
>  # Clang Tooling
>  # ---------------------------------------------------------------------------
>
> +ifdef CONFIG_CC_IS_GCC
> +gen_compile_commands-flags += --gcc
> +endif
>  quiet_cmd_gen_compile_commands = GEN     $@
> -      cmd_gen_compile_commands = $(PYTHON3) $< -a $(AR) -o $@ $(filter-out $<, $(real-prereqs))
> +      cmd_gen_compile_commands = $(PYTHON3) $< $(gen_compile_commands-flags) -a $(AR) -o $@ $(filter-out $<, $(real-prereqs))
>
>  $(extmod_prefix)compile_commands.json: scripts/clang-tools/gen_compile_commands.py \
>         $(if $(KBUILD_EXTMOD),,$(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS)) \
> diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
> index 1d1bde1fd45e..02f6a1408968 100755
> --- a/scripts/clang-tools/gen_compile_commands.py
> +++ b/scripts/clang-tools/gen_compile_commands.py
> @@ -56,6 +56,9 @@ def parse_arguments():
>      ar_help = 'command used for parsing .a archives'
>      parser.add_argument('-a', '--ar', type=str, default='llvm-ar', help=ar_help)
>
> +    gcc_help = 'tidy up gcc invocations to work with clang'
> +    parser.add_argument('-g', '--gcc', action='store_true', help=gcc_help)
> +
>      paths_help = ('directories to search or files to parse '
>                    '(files should be *.o, *.a, or modules.order). '
>                    'If nothing is specified, the current directory is searched')
> @@ -67,6 +70,7 @@ def parse_arguments():
>              os.path.abspath(args.directory),
>              args.output,
>              args.ar,
> +            args.gcc,
>              args.paths if len(args.paths) > 0 else [args.directory])
>
>
> @@ -196,10 +200,73 @@ def process_line(root_directory, command_prefix, file_path):
>          'command': prefix + file_path,
>      }
>
> +clang_options = {}
> +
> +def check_clang_compatibility(target, flag):
> +    """Check that the supplied flag does not cause clang to return an error.
> +
> +    The results of the check, which is expensive if repeated many times, is
> +    cached in the clang_options variable and reused in subsequent calls.
> +    """
> +    global clang_options
> +    if flag in clang_options:
> +        return clang_options[flag]
> +
> +    c = 'echo "int f;"| clang {} {} - -E > /dev/null 2>&1'.format(target, flag)
> +    rc = os.system(c)
> +    compatible = rc == 0
> +    clang_options[flag] = compatible
> +    if not compatible:
> +        logging.info('Not supported by clang: %s', flag)
> +
> +    return compatible
> +
> +def make_clang_compatible(entry):
> +    """Scans and transforms the command line options to make the invocation
> +    compatible with clang.
> +
> +    There are two main heuristics:
> +
> +    1. Use the gcc compiler prefix to populate the clang --target variable
> +       (which is needed for cross-compiles to work correctly)
> +
> +    2. Scan for any -f or -m options that are not supported by clang and
> +       discard them.
> +
> +    This allows us to use clang tools on our kernel builds even if we built the
> +    kernel using gcc.
> +    """
> +    newcmd = []
> +    target = ''
> +
> +    # Splitting the command line like this isn't going to handle quoted
> +    # strings transparently. However assuming the quoted string does not
> +    # contain tabs, double spaces or words commencing with '-f' or '-c'
> +    # (which is fairly reasonable) then this simple approach will be
> +    # sufficient.
> +    atoms = entry['command'].split()
> +
> +    # Use the compiler prefix as the clang --target variable
> +    if atoms[0].endswith('-gcc'):
> +        target = '--target=' + os.path.basename(atoms[0][:-4])
> +        newcmd.append(atoms[0])
> +        newcmd.append(target)
> +        del atoms[0]
> +
> +    # Drop incompatible flags that provoke fatal errors for clang. Note that
> +    # unsupported -Wenable-warning flags are not fatal so we don't have to
> +    # worry about those.
> +    for atom in atoms:
> +        if atom.startswith('-f') or atom.startswith('-m'):
> +            if not check_clang_compatibility(target, atom):
> +                continue
> +        newcmd.append(atom)
> +
> +    entry['command'] = ' '.join(newcmd)
>
>  def main():
>      """Walks through the directory and finds and parses .cmd files."""
> -    log_level, directory, output, ar, paths = parse_arguments()
> +    log_level, directory, output, ar, gcc, paths = parse_arguments()
>
>      level = getattr(logging, log_level)
>      logging.basicConfig(format='%(levelname)s: %(message)s', level=level)
> @@ -232,6 +299,8 @@ def main():
>                      try:
>                          entry = process_line(directory, result.group(1),
>                                               result.group(2))
> +                        if gcc:
> +                            make_clang_compatible(entry)
>                          compile_commands.append(entry)
>                      except ValueError as err:
>                          logging.info('Could not add line from %s: %s',
> --
> 2.35.1
>


-- 
Thanks,
~Nick Desaulniers
