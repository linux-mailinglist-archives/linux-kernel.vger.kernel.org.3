Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DDE50373F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 16:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiDPPCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 11:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbiDPPCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 11:02:14 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CF539BA5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 07:59:42 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k22so13732128wrd.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 07:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OO1451Z/51EUQiODYQcioXNtAk5WDJClp+v1gsb4O+A=;
        b=JsGelCQgSfft9VxIYkI97wbWG1Wnm7X9pfRoYqmEWOo9hpWdzwWLwiWQqwhnjSMUKt
         Kc14Sh6fqshzpxMj6q2WvlyVH2SL7rZH0iSVd62N/WQulajBAf6BLXeaiPaNQ/MvJlHO
         3s0/2yk8wxg0g7RgchbWU8lO9FupY6w+J/88Wl+mgkQwwQD5qJmpVQoZHMRB1etsUDUa
         DBKpijfWSZs6SQjStJ5SBH1LnUW3WJH5iLErJhnltNlsks4HmlbGGaUhXm+y9fYD0okl
         154Eh5cOsi2ONW+/sEeXldDTqdGXMjGX7e/S80TGZdqg+2c9JhJkl0/vZpOD6NrFy1fC
         XOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OO1451Z/51EUQiODYQcioXNtAk5WDJClp+v1gsb4O+A=;
        b=D4/Yydy65S3CprCEP4FEv3N6QowLp0T1Bz9uzi9frPfo3uPuruNsOuxv8vBw8J5NXW
         zD6d0TptX5S0TZ3G3giWjBOfDFMzhlj6TbH5RDKOcI+ByGQ/Pxn3DFW8GeR6hMilQCn9
         E02rjqyiN4qoEVSyc9Xg4oL48ri214aov9PHoTljfhVI/3kcpZLEfleocBz98Ah3PkoG
         vwHaaE0+O+KneUO/lGWtbe5N6P0+5K55C2Awm3eUk01/hq0HoCcdwlzoojJjIxXz0xwp
         o10TB2jcBHI9KsesmtStXbJMKdn2KisoKprjUZ68sv1YhnLsT1iChB1kuPyau6OWxId2
         HG3Q==
X-Gm-Message-State: AOAM533Cb55mQCCUYzTXt5QvibV1IfJTIwaCck/cTQxLoOJgCF3gnLJI
        M40c9znDaFuKm6Z57xuLFtCrjnPTxLeGvJnSv2Nq/g==
X-Google-Smtp-Source: ABdhPJygSfQudGHNGaIYA8AF4RqP8bQ81BW1Wk85dVq6W4Vll53M5oge7GeBZ1IPlzfuBne9ZZ6kH4WkXvpz8agqIAU=
X-Received: by 2002:adf:eb09:0:b0:207:bb77:9abb with SMTP id
 s9-20020adfeb09000000b00207bb779abbmr2770912wrn.375.1650121180438; Sat, 16
 Apr 2022 07:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220416004048.1514900-1-namhyung@kernel.org> <20220416004048.1514900-2-namhyung@kernel.org>
In-Reply-To: <20220416004048.1514900-2-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 16 Apr 2022 10:59:27 -0400
Message-ID: <CAP-5=fX5S2CR58REzAhXH4s8_27=D2LbKksS7mHoSoxYOOmN4g@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf symbol: Pass is_kallsyms to symbols__fixup_end()
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Song Liu <songliubraving@fb.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org
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

On Fri, Apr 15, 2022 at 8:40 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The symbol fixup is necessary for symbols in kallsyms since they don't
> have size info.  So we use the next symbol's address to calculate the
> size.  Now it's also used for user binaries because sometimes they
> miss size for hand-written asm functions.
>
> There's a arch-specific function to handle kallsyms differently but
> currently it cannot distinguish kallsyms from others.  Pass this
> information explicitly to handle it properly.  Note that those arch
> functions will be moved to the generic function so I didn't added it
> to the arch-functions.

Thanks Namhyung, in:
https://lore.kernel.org/linux-perf-users/20220412154817.2728324-3-irogers@google.com/
I used "dso->kernel != DSO_SPACE__USER" in symbol-elf to make this
more than just kallsyms as presumably kernel code is the issue. Do we
know elf kernel code has correctly sized symbols?

Thanks,
Ian

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/symbol-elf.c | 2 +-
>  tools/perf/util/symbol.c     | 7 ++++---
>  tools/perf/util/symbol.h     | 2 +-
>  3 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 31cd59a2b66e..ecd377938eea 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1290,7 +1290,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>          * For misannotated, zeroed, ASM function sizes.
>          */
>         if (nr > 0) {
> -               symbols__fixup_end(&dso->symbols);
> +               symbols__fixup_end(&dso->symbols, false);
>                 symbols__fixup_duplicate(&dso->symbols);
>                 if (kmap) {
>                         /*
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index dea0fc495185..1b85cc1422a9 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -217,7 +217,8 @@ void symbols__fixup_duplicate(struct rb_root_cached *symbols)
>         }
>  }
>
> -void symbols__fixup_end(struct rb_root_cached *symbols)
> +void symbols__fixup_end(struct rb_root_cached *symbols,
> +                       bool is_kallsyms __maybe_unused)
>  {
>         struct rb_node *nd, *prevnd = rb_first_cached(symbols);
>         struct symbol *curr, *prev;
> @@ -1467,7 +1468,7 @@ int __dso__load_kallsyms(struct dso *dso, const char *filename,
>         if (kallsyms__delta(kmap, filename, &delta))
>                 return -1;
>
> -       symbols__fixup_end(&dso->symbols);
> +       symbols__fixup_end(&dso->symbols, true);
>         symbols__fixup_duplicate(&dso->symbols);
>
>         if (dso->kernel == DSO_SPACE__KERNEL_GUEST)
> @@ -1659,7 +1660,7 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
>  #undef bfd_asymbol_section
>  #endif
>
> -       symbols__fixup_end(&dso->symbols);
> +       symbols__fixup_end(&dso->symbols, false);
>         symbols__fixup_duplicate(&dso->symbols);
>         dso->adjust_symbols = 1;
>
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index fbf866d82dcc..5fcdd1f94c56 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -203,7 +203,7 @@ void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym,
>                        bool kernel);
>  void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym);
>  void symbols__fixup_duplicate(struct rb_root_cached *symbols);
> -void symbols__fixup_end(struct rb_root_cached *symbols);
> +void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms);
>  void maps__fixup_end(struct maps *maps);
>
>  typedef int (*mapfn_t)(u64 start, u64 len, u64 pgoff, void *data);
> --
> 2.36.0.rc0.470.gd361397f0d-goog
>
