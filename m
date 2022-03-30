Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3DB4EBA88
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243139AbiC3GCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243134AbiC3GCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:02:31 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F213A1D0CA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:00:42 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id m67so35259181ybm.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l4H/jXM2Rm5a65oviYgvwa+04XGLXLD2DF5i6wOLQLk=;
        b=Vuks7XErLEhcNi2ye01c54I5fu+jCmDSOakCCznT+E5592ZGQeCDVgDLAC1Oe1j8Hc
         arjQm/015wC9O7r8EUYvWo1JdfnwHgit9pya3K0qKVHC8n1PrzsjO/1ililAl1IjhfQk
         hleVis9Kr1Qyf0mw+RYN0MImDkC2drk+l5C4qAnRAQdi2lixVi0nJFGc7a2kn+A8U/dS
         zFaSQ9GlIpLuif/J2hksClNYZAcORcG79/LOxU/aqKbHvarX2eDKn9oon1LeDe7mq9S6
         r9U7iAxmkiKOU586S5VakC690uQgl7swxVVhVIBZJflz9IirG0tQWmocB2Fd88MovWNQ
         j5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l4H/jXM2Rm5a65oviYgvwa+04XGLXLD2DF5i6wOLQLk=;
        b=62+FnxRI4RfjPcaZtmgvsjk3NdfmsdK890j5DGYFI03qYogsRn2jjqUs38UbxwSK7h
         e8+2qxLlLCxuAfvPDMgLHdKJl3cmYvUNwZdaUs44pBLAdCs9o5FioFzcoN8KoWE+XAgt
         ZeX+QPm24a6YXTtHXr0UmM5BgEMzGJUjGKsAnS+WONCZeebnpJ5SQxwb+P6OERUdW/ZI
         N+wd3dBUPu6jMj6CS3lG+cHRHR11E60s9ub2dAkwzD9jt6CCQnOPnvWUAdlY732mm12I
         5tm39P0JhsBa4kEqDGZG2j48jghWWy8tEh70CXEzGz9u519PI3a8mpYW4gPcdHrbEQAT
         BMgg==
X-Gm-Message-State: AOAM531/4SmqtjCIeaPXr8ERDX8Yc9wv8rTcYwcDFxvp5tv16oRuotPk
        pLS+Usl37XveTShuDoJCf3PU3d6f8H9V9JSEVsU1cQ==
X-Google-Smtp-Source: ABdhPJz5J5Vu63dqmmJtsEsyg5gp4hpxm11sB9Wij7Lc+9+3maHYDp7YZQF7jyhRhcglPFanYfN+0YeuhYyzXVsUg9Q=
X-Received: by 2002:a25:8251:0:b0:63d:662:4fcf with SMTP id
 d17-20020a258251000000b0063d06624fcfmr2942147ybn.533.1648620041949; Tue, 29
 Mar 2022 23:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220329124017.737571-1-glider@google.com> <20220329124017.737571-13-glider@google.com>
In-Reply-To: <20220329124017.737571-13-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 30 Mar 2022 08:00:00 +0200
Message-ID: <CANpmjNP7BG5OwV53UUZ8HZ0OwAk-Ownn44jiF2TwhAD-mu2YbQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/48] kcsan: clang: retire CONFIG_KCSAN_KCOV_BROKEN
To:     Alexander Potapenko <glider@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, 29 Mar 2022 at 14:41, Alexander Potapenko <glider@google.com> wrote:
>
> kcov used to be broken prior to Clang 11, but right now that version is
> already the minimum required to build with KCSAN, because no prior
> compiler has "-tsan-distinguish-volatile=1".
>
> Therefore KCSAN_KCOV_BROKEN is not needed anymore.
>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>

FYI, this is superseded by
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b027471adaf955efde6153d67f391fe1604b7292

> ---
> Link: https://linux-review.googlesource.com/id/Ida287421577f37de337139b5b5b9e977e4a6fee2
> ---
>  lib/Kconfig.kcsan | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> index 63b70b8c55519..de022445fbba5 100644
> --- a/lib/Kconfig.kcsan
> +++ b/lib/Kconfig.kcsan
> @@ -10,21 +10,10 @@ config HAVE_KCSAN_COMPILER
>           For the list of compilers that support KCSAN, please see
>           <file:Documentation/dev-tools/kcsan.rst>.
>
> -config KCSAN_KCOV_BROKEN
> -       def_bool KCOV && CC_HAS_SANCOV_TRACE_PC
> -       depends on CC_IS_CLANG
> -       depends on !$(cc-option,-Werror=unused-command-line-argument -fsanitize=thread -fsanitize-coverage=trace-pc)
> -       help
> -         Some versions of clang support either KCSAN and KCOV but not the
> -         combination of the two.
> -         See https://bugs.llvm.org/show_bug.cgi?id=45831 for the status
> -         in newer releases.
> -
>  menuconfig KCSAN
>         bool "KCSAN: dynamic data race detector"
>         depends on HAVE_ARCH_KCSAN && HAVE_KCSAN_COMPILER
>         depends on DEBUG_KERNEL && !KASAN
> -       depends on !KCSAN_KCOV_BROKEN
>         select STACKTRACE
>         help
>           The Kernel Concurrency Sanitizer (KCSAN) is a dynamic
> --
> 2.35.1.1021.g381101b075-goog
>
