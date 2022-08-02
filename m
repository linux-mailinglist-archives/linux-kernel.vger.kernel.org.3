Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366B35881C6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 20:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiHBSNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 14:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbiHBSNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 14:13:40 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CC44A83A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 11:13:37 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x39so13526609lfu.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 11:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RfAmeIhpMtEjE+n6tE+gFwawGbWrsqhmqXKSU+whqmc=;
        b=Sgh8aeC7x64vARyPgwe8pZ3HUDFse2tcOJvVUz8LPNYSEnSsIM/Is7UoaACkUvNPvG
         QGxPIiJNwQztYPTpWPhWpYkCc7MHsE242mjlSddOOhZj2BKJdCHM1tkOwn0tumvmq5U3
         UnHw/dMWaNxDSjU09BXg6STjRv9DpnHlIoFCCHWPDToo/9rBDOOKOYCxYpYGik5XYwG8
         R3lYXPsGxyct22bR6qgSmaXk818F1o0gne/oVg5ihBEPV3T8CnMZwFbxxlD1C7G5avOd
         Hm44bMeeXtFnYhw3ZgIq46NYqPXulCAxrXp4HqNpuM5vYp8gteiaNI+G8W6BdmI7HePo
         cVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RfAmeIhpMtEjE+n6tE+gFwawGbWrsqhmqXKSU+whqmc=;
        b=aoHeNMA29xMCRDaDwCPXFhXpOneQyQkukFWQWJbqouFHDZyR48wbI+SP4oQ2ndzZrV
         bptIXHaJSAbnAvvnmgG+mQ3SySNLmshKfCi3Xa1iy4i1XXemUHOXy9+5GCTpVpAd3eBp
         C4rKhPQC6kU5PRXw4+/XEXxKREbTKB7WFLHDM4ZNp1fAdxmWCs7zixUTZrJSYJZVn71s
         ltWXqOT72VWQjAU+82zYzQbEHd5EFWT3X/sm1xIIVahYnrplTfXTTMqpcfBEyp0TMkTv
         NMWAit42NZi/6E17CTxWbT8qD1xKHFBzFDQiJ0hFQwnjeRcBlRwZAbWkZM+naiCX57BK
         7J2A==
X-Gm-Message-State: ACgBeo1fx5HdPHuurM4mJGLA1ML8xnJtvv53np/uKG8VG9jOm0UP9DSy
        BRFoC2N3IIlTeKiY4nVve9tNqJ4j8DT+XulkBuvZac1tRCE=
X-Google-Smtp-Source: AA6agR5IZ3f2t5nb+xFmpy44jVFACoSxNadQbNDWn3Ir2XwLUgWDvka1g8gFJ9sJ4TgfG8IsHsST2MaWS+CO6SDDPoA=
X-Received: by 2002:a05:6512:158b:b0:48b:38:cff8 with SMTP id
 bp11-20020a056512158b00b0048b0038cff8mr2926407lfb.100.1659464016072; Tue, 02
 Aug 2022 11:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220801093902.1506297-1-masahiroy@kernel.org>
In-Reply-To: <20220801093902.1506297-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 2 Aug 2022 11:13:24 -0700
Message-ID: <CAKwvOd=cBXzA9SfYtK-h_dAqLyg=5iZ6YjztTfNschKUMBTK9Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] modpost: shorten warning messages in report_sec_mismatch()
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
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

On Mon, Aug 1, 2022 at 2:41 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Each section mismatch results in long warning messages. Too much.

:(

Yes; they are too verbose.  That said, I have found the
recommendations about annotations for function attributes handy in the
past and would be sad to see them go.  They remind me of "note"
diagnostics from the compiler that add additional context to
"warning"/"error" diagnostics on what the recommended next steps are
for fixing them.

Is there a "happy middle ground" here?

>
> Make each warning fit in one line, and remove a lot of messy code.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/mod/modpost.c | 179 +++---------------------------------------
>  1 file changed, 9 insertions(+), 170 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index a8ee27496da7..9e8ae2636ec1 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1238,42 +1238,6 @@ static Elf_Sym *find_elf_symbol2(struct elf_info *elf, Elf_Addr addr,
>         return near;
>  }
>
> -/*
> - * Convert a section name to the function/data attribute
> - * .init.text => __init
> - * .memexitconst => __memconst
> - * etc.
> - *
> - * The memory of returned value has been allocated on a heap. The user of this
> - * method should free it after usage.
> -*/
> -static char *sec2annotation(const char *s)
> -{
> -       if (match(s, init_exit_sections)) {
> -               char *p = NOFAIL(malloc(20));
> -               char *r = p;
> -
> -               *p++ = '_';
> -               *p++ = '_';
> -               if (*s == '.')
> -                       s++;
> -               while (*s && *s != '.')
> -                       *p++ = *s++;
> -               *p = '\0';
> -               if (*s == '.')
> -                       s++;
> -               if (strstr(s, "rodata") != NULL)
> -                       strcat(p, "const ");
> -               else if (strstr(s, "data") != NULL)
> -                       strcat(p, "data ");
> -               else
> -                       strcat(p, " ");
> -               return r;
> -       } else {
> -               return NOFAIL(strdup(""));
> -       }
> -}
> -
>  static int is_function(Elf_Sym *sym)
>  {
>         if (sym)
> @@ -1282,19 +1246,6 @@ static int is_function(Elf_Sym *sym)
>                 return -1;
>  }
>
> -static void print_section_list(const char * const list[20])
> -{
> -       const char *const *s = list;
> -
> -       while (*s) {
> -               fprintf(stderr, "%s", *s);
> -               s++;
> -               if (*s)
> -                       fprintf(stderr, ", ");
> -       }
> -       fprintf(stderr, "\n");
> -}
> -
>  static inline void get_pretty_name(int is_func, const char** name, const char** name_p)
>  {
>         switch (is_func) {
> @@ -1312,141 +1263,31 @@ static inline void get_pretty_name(int is_func, const char** name, const char**
>  static void report_sec_mismatch(const char *modname,
>                                 const struct sectioncheck *mismatch,
>                                 const char *fromsec,
> -                               unsigned long long fromaddr,
>                                 const char *fromsym,
> -                               int from_is_func,
> -                               const char *tosec, const char *tosym,
> -                               int to_is_func)
> +                               const char *tosec, const char *tosym)
>  {
> -       const char *from, *from_p;
> -       const char *to, *to_p;
> -       char *prl_from;
> -       char *prl_to;
> -
>         sec_mismatch_count++;
>
> -       get_pretty_name(from_is_func, &from, &from_p);
> -       get_pretty_name(to_is_func, &to, &to_p);
> -
> -       warn("%s(%s+0x%llx): Section mismatch in reference from the %s %s%s "
> -            "to the %s %s:%s%s\n",
> -            modname, fromsec, fromaddr, from, fromsym, from_p, to, tosec,
> -            tosym, to_p);
> -
>         switch (mismatch->mismatch) {
>         case TEXT_TO_ANY_INIT:
> -               prl_from = sec2annotation(fromsec);
> -               prl_to = sec2annotation(tosec);
> -               fprintf(stderr,
> -               "The function %s%s() references\n"
> -               "the %s %s%s%s.\n"
> -               "This is often because %s lacks a %s\n"
> -               "annotation or the annotation of %s is wrong.\n",
> -               prl_from, fromsym,
> -               to, prl_to, tosym, to_p,
> -               fromsym, prl_to, tosym);
> -               free(prl_from);
> -               free(prl_to);
> -               break;
> -       case DATA_TO_ANY_INIT: {
> -               prl_to = sec2annotation(tosec);
> -               fprintf(stderr,
> -               "The variable %s references\n"
> -               "the %s %s%s%s\n"
> -               "If the reference is valid then annotate the\n"
> -               "variable with __init* or __refdata (see linux/init.h) "
> -               "or name the variable:\n",
> -               fromsym, to, prl_to, tosym, to_p);
> -               print_section_list(mismatch->symbol_white_list);
> -               free(prl_to);
> -               break;
> -       }
> +       case DATA_TO_ANY_INIT:
>         case TEXT_TO_ANY_EXIT:
> -               prl_to = sec2annotation(tosec);
> -               fprintf(stderr,
> -               "The function %s() references a %s in an exit section.\n"
> -               "Often the %s %s%s has valid usage outside the exit section\n"
> -               "and the fix is to remove the %sannotation of %s.\n",
> -               fromsym, to, to, tosym, to_p, prl_to, tosym);
> -               free(prl_to);
> -               break;
> -       case DATA_TO_ANY_EXIT: {
> -               prl_to = sec2annotation(tosec);
> -               fprintf(stderr,
> -               "The variable %s references\n"
> -               "the %s %s%s%s\n"
> -               "If the reference is valid then annotate the\n"
> -               "variable with __exit* (see linux/init.h) or "
> -               "name the variable:\n",
> -               fromsym, to, prl_to, tosym, to_p);
> -               print_section_list(mismatch->symbol_white_list);
> -               free(prl_to);
> -               break;
> -       }
> +       case DATA_TO_ANY_EXIT:
>         case XXXINIT_TO_SOME_INIT:
>         case XXXEXIT_TO_SOME_EXIT:
> -               prl_from = sec2annotation(fromsec);
> -               prl_to = sec2annotation(tosec);
> -               fprintf(stderr,
> -               "The %s %s%s%s references\n"
> -               "a %s %s%s%s.\n"
> -               "If %s is only used by %s then\n"
> -               "annotate %s with a matching annotation.\n",
> -               from, prl_from, fromsym, from_p,
> -               to, prl_to, tosym, to_p,
> -               tosym, fromsym, tosym);
> -               free(prl_from);
> -               free(prl_to);
> -               break;
>         case ANY_INIT_TO_ANY_EXIT:
> -               prl_from = sec2annotation(fromsec);
> -               prl_to = sec2annotation(tosec);
> -               fprintf(stderr,
> -               "The %s %s%s%s references\n"
> -               "a %s %s%s%s.\n"
> -               "This is often seen when error handling "
> -               "in the init function\n"
> -               "uses functionality in the exit path.\n"
> -               "The fix is often to remove the %sannotation of\n"
> -               "%s%s so it may be used outside an exit section.\n",
> -               from, prl_from, fromsym, from_p,
> -               to, prl_to, tosym, to_p,
> -               prl_to, tosym, to_p);
> -               free(prl_from);
> -               free(prl_to);
> -               break;
>         case ANY_EXIT_TO_ANY_INIT:
> -               prl_from = sec2annotation(fromsec);
> -               prl_to = sec2annotation(tosec);
> -               fprintf(stderr,
> -               "The %s %s%s%s references\n"
> -               "a %s %s%s%s.\n"
> -               "This is often seen when error handling "
> -               "in the exit function\n"
> -               "uses functionality in the init path.\n"
> -               "The fix is often to remove the %sannotation of\n"
> -               "%s%s so it may be used outside an init section.\n",
> -               from, prl_from, fromsym, from_p,
> -               to, prl_to, tosym, to_p,
> -               prl_to, tosym, to_p);
> -               free(prl_from);
> -               free(prl_to);
> +               warn("%s: section mismatch in reference: %s (section: %s) -> %s (section: %s)\n",
> +                    modname, fromsym, fromsec, tosym, tosec);
>                 break;
>         case EXPORT_TO_INIT_EXIT:
> -               prl_to = sec2annotation(tosec);
> -               fprintf(stderr,
> -               "The symbol %s is exported and annotated %s\n"
> -               "Fix this by removing the %sannotation of %s "
> -               "or drop the export.\n",
> -               tosym, prl_to, prl_to, tosym);
> -               free(prl_to);
> +               warn("%s: EXPORT_SYMBOL used for init/exit symbol: %s (section: %s)\n",
> +                    modname, tosym, tosec);
>                 break;
>         case EXTABLE_TO_NON_TEXT:
> -               fatal("There's a special handler for this mismatch type, "
> -                     "we should never get here.");
> +               fatal("There's a special handler for this mismatch type, we should never get here.\n");
>                 break;
>         }
> -       fprintf(stderr, "\n");
>  }
>
>  static void default_mismatch_handler(const char *modname, struct elf_info *elf,
> @@ -1470,9 +1311,7 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
>         if (secref_whitelist(mismatch,
>                              fromsec, fromsym, tosec, tosym)) {
>                 report_sec_mismatch(modname, mismatch,
> -                                   fromsec, r->r_offset, fromsym,
> -                                   is_function(from), tosec, tosym,
> -                                   is_function(to));
> +                                   fromsec, fromsym, tosec, tosym);
>         }
>  }
>
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers
