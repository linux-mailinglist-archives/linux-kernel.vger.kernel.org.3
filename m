Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA9E585FFC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 18:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237316AbiGaQwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 12:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiGaQwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 12:52:08 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2737BC11
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 09:52:06 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id ay11-20020a05600c1e0b00b003a3013da120so6335326wmb.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 09:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z1WQwnH+vUxlQu9SIjMUORiE1pIB6GKovp797CtaNYY=;
        b=GK+W5L3VdcugavZwk0SoDUmRg9mNxloRY59ml4fk+OiIArlIEgxhgehmr+jEr+dCha
         W53vW4JWF9sXMus7ySClo1QPGScpIWT/SX2D3KgC2JdVJw91D5ikKgxGtlTUaKQ1pomu
         /HALESqpmFJD1h7WmxJDJ/kGYlZJItNJb0dKSeRhRsCZOHRp2wz9Z7iJr/1bVRMMYCsg
         DJhxUUxZL8mfhZ9OSs5SzS2qv4dCYTNTnVPNYs7Xw9hanP21LwuASvP7FpmgWnp4rOd3
         OYVdKj/dZvaWf7AmnRPhClWgOgbySUcd4nH9/RA3wZ4N1cGRWgrYnHrIhSXmshrz1IA/
         yu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z1WQwnH+vUxlQu9SIjMUORiE1pIB6GKovp797CtaNYY=;
        b=mPrS59cWgwvicVmA9yvnoF3oZhsHvpQOS3I0d/eThQYMQfsJtR7CcA0txgM4/RKt03
         AA+sDCywoFNrjaWEUcn1ED1ycbXj4RLt3S5/xU06GaAHsFVdIaQjF6VAl9QSRk+j2lR/
         JGJb+NUVpUUuO1rrLasxGTP/OOb70IhJcJHVXHZLRi0M0YtEa1A68k9aZa2sKV/Gw6W4
         ZK9uzi1YvbDjpi71neVGts77fY0wdzozDnu3fRtmfAV2uqAeYzZk2dKhdQkP1wjYJ5Ci
         vrysetr78U8fx17MFB5ad6+H1oF8aQsGDuwUC36d57nL94eD1LKLKAwI+aGXQD+WspDZ
         TY+A==
X-Gm-Message-State: AJIora/Oeb0Xp6CnA4LmmroMjM72njtGHbW4cpipGmwLk5RRm11EdzSs
        DoOklky/5B18JNtGeWVdea5BoOy5vb0Qq6yq4PzaHg==
X-Google-Smtp-Source: AGRyM1vHe6Iv2uRPLoSH6jtHqRgVzhI/OO7bpECxIb/3aG3FQonSmRDAbDjem7FdSDeQLKOL9U+l8eAqGLDY/VQR0/I=
X-Received: by 2002:a05:600c:4e86:b0:3a3:417a:2fcd with SMTP id
 f6-20020a05600c4e8600b003a3417a2fcdmr8933328wmq.149.1659286325289; Sun, 31
 Jul 2022 09:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220724060013.171050-1-leo.yan@linaro.org> <20220724060013.171050-2-leo.yan@linaro.org>
 <CAP-5=fVY=_WUpke0sRMpvbJFu9JuYwqiwAmKdCS+=u7vEG-2uA@mail.gmail.com>
 <20220730093819.GA574473@leoy-ThinkPad-X240s> <CAP-5=fWA8R9Ee5L9xgPtva9dvQ12uKqC1o4zgzPs0B9XWSMxhQ@mail.gmail.com>
 <20220731123702.GA205142@leoy-ThinkPad-X240s>
In-Reply-To: <20220731123702.GA205142@leoy-ThinkPad-X240s>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 31 Jul 2022 09:51:53 -0700
Message-ID: <CAP-5=fVKkd92FP9D2qccmRHMJHbYNNpVC-XAuh5i7jrrTWHg8g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] perf symbol: Correct address for bss symbols
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Fangrui Song <maskray@google.com>,
        Chang Rui <changruinj@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URI_HEX,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2022 at 5:37 AM Leo Yan <leo.yan@linaro.org> wrote:
>
> On Sat, Jul 30, 2022 at 08:21:10AM -0700, Ian Rogers wrote:
>
> [...]
>
> > > On the other hand, I can accept to simply change pr_warning() to
> > > pr_debug4() to avoid warning flood, the log still can help us to find
> > > potential symbol parsing issue, so far they are not false-positive
> > > reporting.
> >
> > Thanks, I suspect the ELF that the Java agent has created isn't good.
> > The Java agent is part of perf as and so is the ELF file generation
> > code:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/genelf.c?h=perf/core#n367
>
> I think it's no need to change the function jit_write_elf(), please see
> below comment.
>
> > I took a quick look but most of the logic is in libelf - it seems less
> > obvious the bug would be there rather than perf. Could you take a
> > look? Ideally there'd be a quick fix that keeps all the benefits of
> > your change and the jvmti code working.
>
> A bit more finding for java JIT symbols.  Let's see below two samples:
>
>      6.72%  java             /home/leoy/.debug/jit/java-jit-20220731.XXKRpgmR/jitted-214330-29.so    0x5b54             B [.] Interpreter
>      0.90%  java             /home/leoy/.debug/jit/java-jit-20220731.XXKRpgmR/jitted-214330-3475.so  0x4fc              B [.] jdk.internal.math.FloatingDecimal$BinaryToASCIIBuffer.dtoa(int, long, int, boolean)
>
> I can see the DSO "jitted-214330-29.so" only contains a java JIT symbol
> "Interpreter", and I also observed the same behavior for other JIT
> symbols, e.g. jitted-214330-3475.so only contains the symbol
> "jdk.internal.math.FloatingDecimal$BinaryToASCIIBuffer.dtoa(int, long,
> int, boolean)".
>
> We always see these JIT symbols always have the consistent start file
> address, but this would not introduce conflit since every JIT symbol has
> its own DSO rather than share the same DSO.
>
> I think now I understand your meaning, and your below change is fine for
> me, I tested it and confirmed it can show up java JIT symbols properly.
> Just a comment, it would be better to add a comment for why we need to
> add symbols when failed to find program header, like:
>
>   if (elf_read_program_header(syms_ss->elf,
>                             (u64)sym.st_value, &phdr)) {
>         pr_debug4("%s: failed to find program header for "
>                   "symbol: %s\n", __func__, elf_name);
>         pr_debug4("%s: adjusting symbol: st_value: %#" PRIx64 " "
>                   "sh_addr: %#" PRIx64 " sh_offset: %#" PRIx64 "\n",
>                   __func__, (u64)sym.st_value, (u64)shdr.sh_addr,
>                   (u64)shdr.sh_offset);
>         /*
>          * Fail to find program header, let's rollback to use shdr.sh_addr
>          * and shdr.sh_offset to calibrate symbol's file address, though
>          * this is not necessary for normal C ELF file, we still need to
>          * handle java JIT symbols in this case.
>          */
>         sym.st_value -= shdr.sh_addr - shdr.sh_offset;
>   } else {
>         ...
>   }
>
> Could you send a formal patch for this?  Thanks!

Done. Thanks for sanity checking all of this! Please double check and
add the reviewed/acked-by:
https://lore.kernel.org/lkml/20220731164923.691193-1-irogers@google.com/

Thanks,
Ian

> Leo
>
> > > Thanks,
> > > Leo
> > >
> > > > ```
> > > > --- a/tools/perf/util/symbol-elf.c
> > > > +++ b/tools/perf/util/symbol-elf.c
> > > > @@ -1305,16 +1305,21 @@ dso__load_sym_internal(struct dso *dso, struct
> > > > map *map, struct symsrc *syms
> > > > _ss,
> > > >
> > > >                        if (elf_read_program_header(syms_ss->elf,
> > > >                                                    (u64)sym.st_value, &phdr)) {
> > > > -                               pr_warning("%s: failed to find program
> > > > header for "
> > > > +                               pr_debug4("%s: failed to find program
> > > > header for "
> > > >                                           "symbol: %s st_value: %#" PRIx64 "\n",
> > > >                                           __func__, elf_name,
> > > > (u64)sym.st_value);
> > > > -                               continue;
> > > > +                               pr_debug4("%s: adjusting symbol:
> > > > st_value: %#" PRIx64 " "
> > > > +                                       "sh_addr: %#" PRIx64 "
> > > > sh_offset: %#" PRIx64 "\n",
> > > > +                                       __func__, (u64)sym.st_value,
> > > > (u64)shdr.sh_addr,
> > > > +                                       (u64)shdr.sh_offset);
> > > > +                               sym.st_value -= shdr.sh_addr - shdr.sh_offset;
> > > > +                       } else {
> > > > +                               pr_debug4("%s: adjusting symbol:
> > > > st_value: %#" PRIx64 " "
> > > > +                                       "p_vaddr: %#" PRIx64 "
> > > > p_offset: %#" PRIx64 "\n",
> > > > +                                       __func__, (u64)sym.st_value,
> > > > (u64)phdr.p_vaddr,
> > > > +                                       (u64)phdr.p_offset);
> > > > +                               sym.st_value -= phdr.p_vaddr - phdr.p_offset;
> > > >                        }
> > > > -                       pr_debug4("%s: adjusting symbol: st_value: %#"
> > > > PRIx64 " "
> > > > -                                 "p_vaddr: %#" PRIx64 " p_offset: %#"
> > > > PRIx64 "\n",
> > > > -                                 __func__, (u64)sym.st_value,
> > > > (u64)phdr.p_vaddr,
> > > > -                                 (u64)phdr.p_offset);
> > > > -                       sym.st_value -= phdr.p_vaddr - phdr.p_offset;
> > > >                }
> > > >
> > > >                demangled = demangle_sym(dso, kmodule, elf_name);
> > > > ```
> > > >
> > > > Thanks,
> > > > Ian
> > > >
> > > > >
> > > > >                 demangled = demangle_sym(dso, kmodule, elf_name);
> > > > > --
> > > > > 2.25.1
> > > > >
