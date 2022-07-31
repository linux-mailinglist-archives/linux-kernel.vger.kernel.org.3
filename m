Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E4F585EE6
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 14:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236926AbiGaMhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 08:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236907AbiGaMhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 08:37:12 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5572DFA2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 05:37:10 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v131-20020a1cac89000000b003a4bb3f786bso430733wme.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 05:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zxVdgJ1vux8TImW4FL6YxoljQySxzKuzGy0keBd2VZs=;
        b=hrxQFkCZKXjrqETbsKn775YJhevjC8fXOkPKFmvJIwughHVOAc0Va5Ye54CexdAbjU
         NhRt1YEQDznNumcmFp+UjMxYVDOd404Js2SfF+oFtYKBQ6e3hYH3OBK4n9xTE3fhv98R
         lZkK6e+f0bQT3XIG/Gy7kuPsY5HPUKvXcyx/xBlGA4cKrnNLhPeYY4Xurza93Y05b39F
         RP6aSFjh+LEzSrMZNZ+Y2TvrVZwiB8bkiKs7Q2c+mBODFvezaRUw8S51st6XhCRQF5t2
         uQn90+eK9GQQP4KDnBO102rdeHEXrvk98b4fp9W6BJ3vK+/7lVVolXTt5vGCjMTW6s5w
         QO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zxVdgJ1vux8TImW4FL6YxoljQySxzKuzGy0keBd2VZs=;
        b=SL53ckxoO57aNHWrr2DqoNCBWCoOBjPbDedl6IwFKw0FpvD5biCUlRQHOFMHNCcguC
         +mZ92vSmcGT9MPp9hVB47RXGnl9OYn2UVj1fnK8rDUbGJwRJdw4WjtPlKizg/bKKJox5
         efdADeKiHxeRKosjeFs2oOlx7q/TRsT1W0N5LTL0ymM/VIYmVtb8hUoVhr2xiaIz/AQV
         VGIz2QnHISKOiD4fO/n2ykgtseKQau2wuFl3J3aggMfBDIY2PyyKKft/e8i6nUPXwEpS
         S9f4MUI7hPKUFYO9LLyu6lgFbq/Bc3Easpeo8CYhL6MPPYrgqVLUmO3fWaOSzFAcOHCh
         KqAQ==
X-Gm-Message-State: AJIora901SePhE3KRsZbSEVu9K9spZjo4s6bwi4THVHHb2PJpqPNZq0B
        8H8sIP+nJtKlRKEG5iJVJfu4MA==
X-Google-Smtp-Source: AGRyM1uiZQBU3njm4/rwDhMvt2ByyGuE7PQ1bFjwUy9QZiIxSdge1D+P60ZNqQre1WQneMtuWhlx4A==
X-Received: by 2002:a05:600c:2652:b0:3a3:2a3e:a2de with SMTP id 18-20020a05600c265200b003a32a3ea2demr8460316wmy.174.1659271029326;
        Sun, 31 Jul 2022 05:37:09 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([167.71.129.183])
        by smtp.gmail.com with ESMTPSA id n186-20020a1ca4c3000000b003a2d87aea57sm15175048wme.10.2022.07.31.05.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 05:37:08 -0700 (PDT)
Date:   Sun, 31 Jul 2022 20:37:02 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ian Rogers <irogers@google.com>
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
Subject: Re: [PATCH v3 1/2] perf symbol: Correct address for bss symbols
Message-ID: <20220731123702.GA205142@leoy-ThinkPad-X240s>
References: <20220724060013.171050-1-leo.yan@linaro.org>
 <20220724060013.171050-2-leo.yan@linaro.org>
 <CAP-5=fVY=_WUpke0sRMpvbJFu9JuYwqiwAmKdCS+=u7vEG-2uA@mail.gmail.com>
 <20220730093819.GA574473@leoy-ThinkPad-X240s>
 <CAP-5=fWA8R9Ee5L9xgPtva9dvQ12uKqC1o4zgzPs0B9XWSMxhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWA8R9Ee5L9xgPtva9dvQ12uKqC1o4zgzPs0B9XWSMxhQ@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URI_HEX autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2022 at 08:21:10AM -0700, Ian Rogers wrote:

[...]

> > On the other hand, I can accept to simply change pr_warning() to
> > pr_debug4() to avoid warning flood, the log still can help us to find
> > potential symbol parsing issue, so far they are not false-positive
> > reporting.
> 
> Thanks, I suspect the ELF that the Java agent has created isn't good.
> The Java agent is part of perf as and so is the ELF file generation
> code:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/genelf.c?h=perf/core#n367

I think it's no need to change the function jit_write_elf(), please see
below comment.

> I took a quick look but most of the logic is in libelf - it seems less
> obvious the bug would be there rather than perf. Could you take a
> look? Ideally there'd be a quick fix that keeps all the benefits of
> your change and the jvmti code working.

A bit more finding for java JIT symbols.  Let's see below two samples:

     6.72%  java             /home/leoy/.debug/jit/java-jit-20220731.XXKRpgmR/jitted-214330-29.so    0x5b54             B [.] Interpreter
     0.90%  java             /home/leoy/.debug/jit/java-jit-20220731.XXKRpgmR/jitted-214330-3475.so  0x4fc              B [.] jdk.internal.math.FloatingDecimal$BinaryToASCIIBuffer.dtoa(int, long, int, boolean)

I can see the DSO "jitted-214330-29.so" only contains a java JIT symbol
"Interpreter", and I also observed the same behavior for other JIT
symbols, e.g. jitted-214330-3475.so only contains the symbol
"jdk.internal.math.FloatingDecimal$BinaryToASCIIBuffer.dtoa(int, long,
int, boolean)".

We always see these JIT symbols always have the consistent start file
address, but this would not introduce conflit since every JIT symbol has
its own DSO rather than share the same DSO.

I think now I understand your meaning, and your below change is fine for
me, I tested it and confirmed it can show up java JIT symbols properly.
Just a comment, it would be better to add a comment for why we need to
add symbols when failed to find program header, like:

  if (elf_read_program_header(syms_ss->elf,
                            (u64)sym.st_value, &phdr)) {
        pr_debug4("%s: failed to find program header for "
                  "symbol: %s\n", __func__, elf_name);
        pr_debug4("%s: adjusting symbol: st_value: %#" PRIx64 " "
                  "sh_addr: %#" PRIx64 " sh_offset: %#" PRIx64 "\n",
                  __func__, (u64)sym.st_value, (u64)shdr.sh_addr,
                  (u64)shdr.sh_offset);
        /*
         * Fail to find program header, let's rollback to use shdr.sh_addr
         * and shdr.sh_offset to calibrate symbol's file address, though
         * this is not necessary for normal C ELF file, we still need to
         * handle java JIT symbols in this case.
         */
        sym.st_value -= shdr.sh_addr - shdr.sh_offset;
  } else {
        ...
  }

Could you send a formal patch for this?  Thanks!

Leo

> > Thanks,
> > Leo
> >
> > > ```
> > > --- a/tools/perf/util/symbol-elf.c
> > > +++ b/tools/perf/util/symbol-elf.c
> > > @@ -1305,16 +1305,21 @@ dso__load_sym_internal(struct dso *dso, struct
> > > map *map, struct symsrc *syms
> > > _ss,
> > >
> > >                        if (elf_read_program_header(syms_ss->elf,
> > >                                                    (u64)sym.st_value, &phdr)) {
> > > -                               pr_warning("%s: failed to find program
> > > header for "
> > > +                               pr_debug4("%s: failed to find program
> > > header for "
> > >                                           "symbol: %s st_value: %#" PRIx64 "\n",
> > >                                           __func__, elf_name,
> > > (u64)sym.st_value);
> > > -                               continue;
> > > +                               pr_debug4("%s: adjusting symbol:
> > > st_value: %#" PRIx64 " "
> > > +                                       "sh_addr: %#" PRIx64 "
> > > sh_offset: %#" PRIx64 "\n",
> > > +                                       __func__, (u64)sym.st_value,
> > > (u64)shdr.sh_addr,
> > > +                                       (u64)shdr.sh_offset);
> > > +                               sym.st_value -= shdr.sh_addr - shdr.sh_offset;
> > > +                       } else {
> > > +                               pr_debug4("%s: adjusting symbol:
> > > st_value: %#" PRIx64 " "
> > > +                                       "p_vaddr: %#" PRIx64 "
> > > p_offset: %#" PRIx64 "\n",
> > > +                                       __func__, (u64)sym.st_value,
> > > (u64)phdr.p_vaddr,
> > > +                                       (u64)phdr.p_offset);
> > > +                               sym.st_value -= phdr.p_vaddr - phdr.p_offset;
> > >                        }
> > > -                       pr_debug4("%s: adjusting symbol: st_value: %#"
> > > PRIx64 " "
> > > -                                 "p_vaddr: %#" PRIx64 " p_offset: %#"
> > > PRIx64 "\n",
> > > -                                 __func__, (u64)sym.st_value,
> > > (u64)phdr.p_vaddr,
> > > -                                 (u64)phdr.p_offset);
> > > -                       sym.st_value -= phdr.p_vaddr - phdr.p_offset;
> > >                }
> > >
> > >                demangled = demangle_sym(dso, kmodule, elf_name);
> > > ```
> > >
> > > Thanks,
> > > Ian
> > >
> > > >
> > > >                 demangled = demangle_sym(dso, kmodule, elf_name);
> > > > --
> > > > 2.25.1
> > > >
