Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71478513E08
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352676AbiD1VxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 17:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352703AbiD1Vww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:52:52 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D5DC42D0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 14:49:18 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id g16so2877842lja.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 14:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+PxAAmkjgu5tODqXDwsgtMxyhrqsec+04FO6jxzyCcc=;
        b=EgMf4wGlKR2P4qmTIR+eqAHCPohzmdgt/qhnbyKZ4lDdOt7a2A7KkIvmRUYj3ORv/2
         ctRYHxbEdH2bVz9z7jidHdTMqxGWNNbHKkOcq1JPkBTDkr2KywCmhFn1VIhFj07TRW0J
         tO44QxZ/hvGFifP6BvM1SsRBXK/Wpt80VuD+LYMULc1NK5J4u7qRHmwTQNRCnIocu6oc
         2gc0M+ITg74EzCn09TOpQVb2U+Eg/vp0XIn+OY99YAqNaTSkV7FhpYDzkZpuRwvbIak7
         cDYVACnvJB9wBAtQ/uz0O8N7txvXwNncqCpkJsJ7hXYhVonAw0nwosMtUU0Un9iCH/TS
         8wDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+PxAAmkjgu5tODqXDwsgtMxyhrqsec+04FO6jxzyCcc=;
        b=GLh/Z8VlI4N+lOCk2Decn8ny82HJGJZyqpvTaQDjzE2dYAdtHVCclF1QJtAWGrpcVI
         xU4iiadPKE/QW3l6LGnbclUEwF6SgKoRHjbRPJ86XJ52vPK16zdi0Gv1LirRVzRLE+kh
         FP1WSP4u1rSmClSbtrNm1PMEmPO/3pAcq082r3uyAf0yeHbA6G0HkQYeSkTG1A5r3D5T
         1ASoTG3U+lvQfiRDfx1vt5Hnz7+fCPYP07Lhn4K04pVSXf7B8VKaywfhND5ecvkm6XAV
         lCTcW47W649veflN5a9PkI+RPHZi9fTxemmuRh+x0G2fiR80NMSqBR9xU7hFT++uWCB8
         N0dA==
X-Gm-Message-State: AOAM53242uAaTEQjj0rU6g6CUq9JPf4VOUCojARdEUdNSZ1Y1hwGEENB
        a0gUCqNoSx+shGvV+NhT7/SZqXVdUv6T192LYahPrxffCVE=
X-Google-Smtp-Source: ABdhPJxeDVaq0Pvja4JeHCOk2oQ2ZlUxjPVKsJFApZLIQJQHRDw1GXu/scJSktw+wQosBxZQ2bpqpujznJscwVBecOQ=
X-Received: by 2002:a2e:854b:0:b0:24f:b98:e2d2 with SMTP id
 u11-20020a2e854b000000b0024f0b98e2d2mr17407442ljj.165.1651182556685; Thu, 28
 Apr 2022 14:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220424190811.1678416-1-masahiroy@kernel.org> <20220424190811.1678416-25-masahiroy@kernel.org>
In-Reply-To: <20220424190811.1678416-25-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 28 Apr 2022 14:49:04 -0700
Message-ID: <CAKwvOdkJJnJt_jj_1n6QP31UoTqcS5aVUYAExdR8wY61EmRDFQ@mail.gmail.com>
Subject: Re: [PATCH 24/27] modpost: generate linker script to collect symbol versions
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 12:10 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Merge version CRCs per vmlinux or per module.
>
> These linker scripts will be fed to the final link stage.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  .gitignore            |  1 +
>  Makefile              |  1 +
>  scripts/mod/modpost.c | 27 +++++++++++++++++++++++++++
>  3 files changed, 29 insertions(+)
>
> diff --git a/.gitignore b/.gitignore
> index 265959544978..f9dad6b917e6 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -42,6 +42,7 @@
>  *.so.dbg
>  *.su
>  *.symtypes
> +*.symver.lds
>  *.symversions
>  *.tab.[ch]
>  *.tar
> diff --git a/Makefile b/Makefile
> index 235d68fa1470..0779db3d1c0c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1859,6 +1859,7 @@ clean: $(clean-dirs)
>                 -o -name '*.c.[012]*.*' \
>                 -o -name '*.ll' \
>                 -o -name '*.gcno' \
> +               -o -name '*.symver.lds' \
>                 -o -name '*.*.symversions' \) -type f -print | xargs rm -f
>
>  # Generate tags for editors
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 43ab4f000ae3..ef779ada04c6 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -2577,6 +2577,30 @@ static void write_dump(const char *fname)
>         free(buf.p);
>  }
>
> +static void write_symversions_lds(struct module *mod)
> +{
> +       struct buffer buf = { };
> +       struct symbol *sym;
> +       char lds_file[PATH_MAX];
> +       int ret;
> +
> +       ret = snprintf(lds_file, sizeof(lds_file), "%s.symver.lds", mod->name);
> +       if (ret >= sizeof(lds_file)) {
> +               error("%s: too long path was truncated\n", lds_file);
> +               return;

If this exceptional case occurs, we should probably halt or return an
error code to main?

> +       }
> +
> +       list_for_each_entry(sym, &mod->exported_symbols, list) {
> +               if (!sym->crc_valid)
> +                       continue;
> +
> +               buf_printf(&buf, "__crc_%s = 0x%08x;\n", sym->name, sym->crc);
> +       }
> +
> +       write_if_changed(&buf, lds_file);
> +       free(buf.p);
> +}
> +
>  static void write_namespace_deps_files(const char *fname)
>  {
>         struct module *mod;
> @@ -2673,6 +2697,9 @@ int main(int argc, char **argv)
>                 char fname[PATH_MAX];
>                 int ret;
>
> +               if (modversions && !mod->from_dump)
> +                       write_symversions_lds(mod);
> +
>                 if (mod->is_vmlinux || mod->from_dump)
>                         continue;
>
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
