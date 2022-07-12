Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80F9571C35
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbiGLOSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbiGLOR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:17:56 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF037B23FE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:17:54 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2ef5380669cso82284037b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BBNAmGtBjsKiAgWVGNt1epS6tn9dFMCvgo2fNVioNes=;
        b=s50HuPFgYbKen/bxFHp/HuYFIGEoTRrbQ/hn9+FX0DryxJbh3I2wjTB+ZqoXhGc1vF
         mefIGN7LwwVpoAKeN8uKzIaaj0R2z5on9iLq4c5JKv88W1Gtk6rtEkbHTKce6pJqoXso
         G/swJc2ySNFMa1ftgJM+l7qYjrVPgurj0mBwdLN0/nGKTw9F3TX0OG0BBlp9pWyECh7V
         +3ZCUQ7TwcVdDJlRCFDdPFcl6xhD9aPLCV5MzUYGyo3ixHOA5k+4V8hRnCuy0Twn4GF4
         tj3NaPsBPNgM3ufwGa6cwLnx24GIqfOuwYwszd7NUyClxQaoG80Qt+zdHO1TLhwI7kwv
         5Q4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BBNAmGtBjsKiAgWVGNt1epS6tn9dFMCvgo2fNVioNes=;
        b=1NpEodxwgEVZpGIHHl1bphefB8h9fz2IU1pH/MysOuXzhOJGw1k6t45QNR4a4RkwNx
         AjFe3ol/Jt0End46l3SPF0OWTceLfXQ05UeE+hLp4DHtv3NTD1VNc7o5y5h1cfr3CxSk
         qDilfhTfd5gH3LkOX0TJUdhpDebRS70QX6/jEvRCMlLsFHu26+rw+vtGcwEClHHBNpfC
         OLlLAIV+hROCG14+Bwq39uEwY9WeBvh73MqGF1Z/aolqlf7f0PgQGoq+Gnoc0a0L7a3i
         wb9ceoGSnaSFRilIWNuh3je82nQwQAe5qU1zj7cQFcfid1J1BeGd71HEw1RkDN46xFdX
         zrGw==
X-Gm-Message-State: AJIora9DSBrhPqIKTE+9sVCzk030iWLSy9lxsNlkXlBGLCmEUg/FT+ff
        uqUMFTGV2QLu2xsxqUdR4g73tOSd+j6fgNUaxISGjA==
X-Google-Smtp-Source: AGRyM1ugqmt9DDomYcxjZBCfHColnGRSwoMdU+8bT2TZSM+C2v9BWbIiEBZHHNxj556rRL/VmzE76DtGsOcOMTQT/sw=
X-Received: by 2002:a81:1492:0:b0:31c:a1ff:9ec with SMTP id
 140-20020a811492000000b0031ca1ff09ecmr24431681ywu.327.1657635473811; Tue, 12
 Jul 2022 07:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-9-glider@google.com>
In-Reply-To: <20220701142310.2188015-9-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 12 Jul 2022 16:17:18 +0200
Message-ID: <CANpmjNOb_aY5BrxKY=WzuDb7Y708XS1hSR0pJ8PKQi7Z8MDNCA@mail.gmail.com>
Subject: Re: [PATCH v4 08/45] kmsan: mark noinstr as __no_sanitize_memory
To:     Alexander Potapenko <glider@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
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
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, 1 Jul 2022 at 16:23, Alexander Potapenko <glider@google.com> wrote:
>
> noinstr functions should never be instrumented, so make KMSAN skip them
> by applying the __no_sanitize_memory attribute.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> v2:
>  -- moved this patch earlier in the series per Mark Rutland's request
>
> Link: https://linux-review.googlesource.com/id/I3c9abe860b97b49bc0c8026918b17a50448dec0d
> ---
>  include/linux/compiler_types.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index d08dfcb0ac687..fb5777e5228e7 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -227,7 +227,8 @@ struct ftrace_likely_data {
>  /* Section for code which can't be instrumented at all */
>  #define noinstr                                                                \
>         noinline notrace __attribute((__section__(".noinstr.text")))    \
> -       __no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
> +       __no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage \
> +       __no_sanitize_memory
>
>  #endif /* __KERNEL__ */
>
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
