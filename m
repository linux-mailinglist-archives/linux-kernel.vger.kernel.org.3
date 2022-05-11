Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4A8524048
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 00:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348768AbiEKWb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 18:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348764AbiEKWbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 18:31:23 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5AD42EDA
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:31:21 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id p10so5934595lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fbUOy/LO7pce3syrWgaW4CEkFhXFi5vc0wZxMBvogMQ=;
        b=b252l7y6kIta/PlC/sxvJu7dt3E+UghECcSvUXYwF4kkihtszWpLzwdXtBPGpv5Y6j
         P1rdxKBxSO7vcvrTcBuE7FapkycaYlYze9EOHE9VPJbL4KMZgx2dtHF8MpxxlqxLp0EE
         DoJuYppCH6NfeB3ZHBWd9BvozYAA+tVIcOaJNbvz5ejIJh/yqF1DZ6Sb07UJGUgLb8Kb
         ZexJRIcTGCi7/R6ZGcE+prpQ5SUtlZCq53XEtdnuRmC5KVNRt3nDps6lDgzUVvSIB0xr
         ahjfrP5z+rRM5kNK+cD4e9om1Pj7E5GC+IlIybW5nCwwUYIcTUKV/xfOuBrvQ5V22s3k
         CADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fbUOy/LO7pce3syrWgaW4CEkFhXFi5vc0wZxMBvogMQ=;
        b=KcKgwEJ7NrHOuQ/EYNElwIZiiJrGGkN552W56TUgV+w/NpIiNBQBH4b5eIrCA3eXSv
         1+TfSODL9MvAUKEPlGJjv13Mz8vzH2FFbBQWPGfqNWlnTK7gCOPJcVE9kLKnrIITYbRP
         1flv31uS5zxT/wxoeWAjCZKsTgiMjiKrjTCW8Zotc6Ezbb/nS1q6wyAnUtB8gwFdALOz
         PWP/TbQV+8gFcpuTLpwRZZ/3Rkw9+EnYa8iLnutV9xZgjB/mzLg+nRZlGkdtQdVcUdxg
         jIcBmWRs0uTwl9tHIYJK9hO1+CGoYI9wXjmovL5BKcrZe2cY1h05nIUwMPjlsTLr9IxF
         Im6g==
X-Gm-Message-State: AOAM532azTWzQ5S7UiEALFytOhO378IR46ymukeU6/tywo7IUShcB25C
        hS8s3RpV1PeWaBCBp0usKVvNGPhJUms4Kk0p46FCGjdh5aY=
X-Google-Smtp-Source: ABdhPJyrwg+caXPdLDJxrd+N/bnHoW3wXGl79dd3Ws8+i8WDRdA2wjLtLJ9Q7N0Q+nZdmhVnty5QrvsXc+kvgfzIxnA=
X-Received: by 2002:a19:4303:0:b0:473:f5fb:27b2 with SMTP id
 q3-20020a194303000000b00473f5fb27b2mr20535287lfa.626.1652308279822; Wed, 11
 May 2022 15:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220511164514.2741934-1-masahiroy@kernel.org> <20220511164514.2741934-2-masahiroy@kernel.org>
In-Reply-To: <20220511164514.2741934-2-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 11 May 2022 15:31:08 -0700
Message-ID: <CAKwvOdkMqyssbZ9imYM8Re+NL4U1K2tYj37_1XUtmjj8LSt5GQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/12] modpost: split the section mismatch checks into section-check.c
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules@vger.kernel.org, llvm@lists.linux.dev,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 9:49 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> -/* sections that we do not want to do full section mismatch check on */
> -static const char *const section_white_list[] =
> -{
> -       ".comment*",
> -       ".debug*",
> -       ".cranges",             /* sh64 */
> -       ".zdebug*",             /* Compressed debug sections. */
> -       ".GCC.command.line",    /* record-gcc-switches */
> -       ".mdebug*",        /* alpha, score, mips etc. */
> -       ".pdr",            /* alpha, score, mips etc. */
> -       ".stab*",
> -       ".note*",
> -       ".got*",
> -       ".toc*",
> -       ".xt.prop",                              /* xtensa */
> -       ".xt.lit",         /* xtensa */
> -       ".arcextmap*",                  /* arc */
> -       ".gnu.linkonce.arcext*",        /* arc : modules */
> -       ".cmem*",                       /* EZchip */
> -       ".fmt_slot*",                   /* EZchip */
> -       ".gnu.lto*",
> -       ".discard.*",
> -       NULL
> -};


> -/**
> - * Whitelist to allow certain references to pass with no warning.
> - *
> - * Pattern 1:
> - *   If a module parameter is declared __initdata and permissions=0
> - *   then this is legal despite the warning generated.
> - *   We cannot see value of permissions here, so just ignore
> - *   this pattern.
> - *   The pattern is identified by:
> - *   tosec   = .init.data
> - *   fromsec = .data*
> - *   atsym   =__param*
> - *
> - * Pattern 1a:
> - *   module_param_call() ops can refer to __init set function if permissions=0
> - *   The pattern is identified by:
> - *   tosec   = .init.text
> - *   fromsec = .data*
> - *   atsym   = __param_ops_*
> - *
> - * Pattern 2:
> - *   Many drivers utilise a *driver container with references to
> - *   add, remove, probe functions etc.
> - *   the pattern is identified by:
> - *   tosec   = init or exit section
> - *   fromsec = data section
> - *   atsym = *driver, *_template, *_sht, *_ops, *_probe,
> - *           *probe_one, *_console, *_timer
> - *
> - * Pattern 3:
> - *   Whitelist all references from .head.text to any init section
> - *
> - * Pattern 4:
> - *   Some symbols belong to init section but still it is ok to reference
> - *   these from non-init sections as these symbols don't have any memory
> - *   allocated for them and symbol address and value are same. So even
> - *   if init section is freed, its ok to reference those symbols.
> - *   For ex. symbols marking the init section boundaries.
> - *   This pattern is identified by
> - *   refsymname = __init_begin, _sinittext, _einittext
> - *
> - * Pattern 5:
> - *   GCC may optimize static inlines when fed constant arg(s) resulting
> - *   in functions like cpumask_empty() -- generating an associated symbol
> - *   cpumask_empty.constprop.3 that appears in the audit.  If the const that
> - *   is passed in comes from __init, like say nmi_ipi_mask, we get a
> - *   meaningless section warning.  May need to add isra symbols too...
> - *   This pattern is identified by
> - *   tosec   = init section
> - *   fromsec = text section
> - *   refsymname = *.constprop.*
> - *
> - * Pattern 6:
> - *   Hide section mismatch warnings for ELF local symbols.  The goal
> - *   is to eliminate false positive modpost warnings caused by
> - *   compiler-generated ELF local symbol names such as ".LANCHOR1".
> - *   Autogenerated symbol names bypass modpost's "Pattern 2"
> - *   whitelisting, which relies on pattern-matching against symbol
> - *   names to work.  (One situation where gcc can autogenerate ELF
> - *   local symbols is when "-fsection-anchors" is used.)
> - **/

Losing the ability to git blame (from the top level) the above lines
does cause me grief and mental anguish though. It's not gone, just
buried a bit deeper.
-- 
Thanks,
~Nick Desaulniers
