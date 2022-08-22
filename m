Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DF759C459
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237145AbiHVQpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237131AbiHVQpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:45:46 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EFF30568
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:45:43 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id d8so3712833lfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=c8213vY56JPgpNVjirb5hpOo+919ft+msz2yWaNpPZI=;
        b=sVGHevnabAGTzofmnF3jp/fLog8EfKc0DKAPZbFU2sgZdYKZkmzADOntd2mGXPL1CG
         izSHAg1fHkqd6KO4NofkUQcrCC3EF4RZNR2fHe7TxJ/eXsZcBkr0isVIg3M8bqlKNq5A
         do3tL8pk8wZT2ZgacoITiaRGrVACzxT14bXyCWUmGwAMl3VRpJVorhl0DZ61raANYhl4
         cWEz4DDmvgj7lvd9tg4EW2fdqY8bYQ1dPArbXiGS/asbl75JpQ7qCSvcl2elqbB6SSmC
         W+qgidYejdBaaNaFs9Ex8WDMQK60Gmh1F1SY7b7FPG8EZrfQPa7RG10cu0eaZcT9y15Q
         MsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=c8213vY56JPgpNVjirb5hpOo+919ft+msz2yWaNpPZI=;
        b=5ex0YLLYsQY0BqUcBcDExS11AqwEGdfpPmpeKUk/ZPuJ0sTtvwt40mPNvhLFmMmfgA
         BL4G5UdZ6k8sEFbRdGluJGRwAQMMiCPljtQlJYe8jiaP+Gdlr1JSOuZHqCrgrRFnabS0
         PPynWnllcTiL3wGQe9j42XEHctONsdkvWBixS3oa/I216UyY4ftlHb0ztv4qCFaXZ7ID
         2r/z5pqEeJ7nmWJh1zfrJ4LTntSkrjwn+gcJxMM63rwDj+nJiiGVxtTIowwoRA/YmNqh
         L3GF4qg/BZZj6rSw0s0bXnPjYmLV8cygaSf+GgaM7j4jmiS8JN56Gf5BJo7QoryfjkzE
         DPSQ==
X-Gm-Message-State: ACgBeo2zEBXfH1+zqc4kx8TReoADx6UkXyik0MCC4A4PSPFjpJuvR5T+
        uzvTvuM8Ah3YU6X3swPyxvWrR85dV0cM75FbpURhkw==
X-Google-Smtp-Source: AA6agR7bzbop2QQFAsGGE7kJOaXMj9YwmQlZlHYeH4IWfCINA6AxrWn2ao3yspUUtbDO2bplWpt7ZFA9tDk61kPzMv0=
X-Received: by 2002:a05:6512:1316:b0:48d:2549:1158 with SMTP id
 x22-20020a056512131600b0048d25491158mr6862876lfu.626.1661186740924; Mon, 22
 Aug 2022 09:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <CANXV_XwgZMCGXijfoUyZ9+KyM6Rgeqiq-sCfubyj_16d-2CN=A@mail.gmail.com>
 <20220815013317.26121-1-dmitrii.bundin.a@gmail.com> <CAKwvOdnnSAozX8bQ9HeSw12BV9OjpzyDmXk_BGczjVVQNN+7tQ@mail.gmail.com>
 <CANXV_Xw2wzwDdJkyV1nHPQm2JTt48SLrNc7YwrfcxOwuFA-z3w@mail.gmail.com>
In-Reply-To: <CANXV_Xw2wzwDdJkyV1nHPQm2JTt48SLrNc7YwrfcxOwuFA-z3w@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 Aug 2022 09:45:28 -0700
Message-ID: <CAKwvOdkiq_byi1QeCvSGb2fd+0AJ1k9WNnsHJMeaaQcPRy1Wxg@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: add debug level and macro defs options
To:     Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Fangrui Song <maskray@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
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

On Fri, Aug 19, 2022 at 3:52 PM Dmitrii Bundin
<dmitrii.bundin.a@gmail.com> wrote:
>
> On Fri, Aug 19, 2022 at 8:42 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > Is any of this really necessary?
>
> Consider the case if CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y.
> Prior to GCC11/Clang12 -gsplit-dwarf implied -g2. So on newer
> compilers with -gsplit-dwarf in use there would be no debug symbols
> produced.

```
diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
index 9f39b0130551..a881954c1382 100644
--- a/scripts/Makefile.debug
+++ b/scripts/Makefile.debug
@@ -1,7 +1,7 @@
 DEBUG_CFLAGS   :=

 ifdef CONFIG_DEBUG_INFO_SPLIT
-DEBUG_CFLAGS   += -gsplit-dwarf
+DEBUG_CFLAGS   += -gsplit-dwarf -g2
 else
 DEBUG_CFLAGS   += -g
 endif
```

or perhaps that simply needs to be `-g -gsplit-dwarf`?  In which case,
that if/else could just be re-arranged.

> -gdwarf-4/5 still implies -g2, but in case
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y neither of the options are
> set.

-g is set, which has an implicit default level.

> So it seems like a reasonable choice to provide a debug info
> level config that would explicitly set the level without relying on
> implicits. The default value of the config is set to -g2 to not change
> the build behavior that was before introducing the option. And it
> works for both older and newer versions of GCC/Clang in the same way.
> The benefits of the -g1 option are indeed questionable except that it
> produces an image with ~20% less in size.

Until there's a concrete need, YAGNI.

>
> > It seems like a great way to bloat
> > vmlinux artifacts built with CONFIG_DEBUG_INFO even further.
> The defaults were chosen to not change the build behavior that was
> before introducing the options. Or did you mean something else?
>
> > The
> > above link mentions "when debugging with GDB."  In that case, please
> > don't add new Kconfigs for these; just set -g3 when
> > CONFIG_GDB_SCRIPTS=y.
>
> CONFIG_GDB_SCRIPTS does not necessarily mean that -g3 is wanted, -g2
> (default) is usually a reasonable choice. The -g3 option is very
> useful when debugging macro-intensive code, but requires much more
> disk space to build. I documented it explicitly in the help section of
> DEBUG_INFO_LEVEL. GCC and Clang use different options to include macro
> definitions so it was handled depending on the compiler used.

Honestly, I really don't think we need to be wrapping every compiler
command line flag under the sun in a kconfig option.

-- 
Thanks,
~Nick Desaulniers
