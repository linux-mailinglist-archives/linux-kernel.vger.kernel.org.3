Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE1B585AF4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 17:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbiG3PVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 11:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiG3PV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 11:21:27 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CCF13F8D
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 08:21:25 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n185so3837887wmn.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 08:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oeJPSvj5hBBtzZgdZRdD8Nr7JBHHoqaGLY9X4WrPs+I=;
        b=qNK17BQrdYn5ZTA3L1fqZvzzgHTzMNSnLmpanzWsdS9AiYsWcz3CP2Kw/iOIrMXHx7
         QXOxliirIDdhwuHMKESMBqlKexCzESnFcQ+X61anRS3/UvCXGF4yP3HDryCv318emPQI
         xScHsNKVnxPhCJW8tAdS8z6MOyjPFxy7f9xa9kdE0OFf/WnGdU+Fcx3QhQ5nMN0oyOSa
         bTC/2MQfTfSY7CCy7q6COop1FH1AmCbuVprrpJFwd19DmBjt+zIUOzaI7c+O5UqoFNFS
         T8AFWvRaJaZTvBowbz5Y0vP2ZH+tSEmwNdI1iOVo2zOuaAcLMGAj+TJmyyXQmamHPuV3
         +zXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oeJPSvj5hBBtzZgdZRdD8Nr7JBHHoqaGLY9X4WrPs+I=;
        b=mZuV4Yt2dtVmKVeB8OlirSslqntggTNf/amo60ivqy5ItQXJWpC5OtwIVfJ7AQHrVc
         ILAOGFTzOX37HnZn8V5aRZl8yRL2X9xd3ZZNgXCMOqLT1gYHgpFk8HyZGT9trR6c4RaM
         CcCc3tRVfVlUDstPvJfbhlZfie32iA0ewktVh8CIuG4p16H3n9LS/M7q4DFOYRybTJbI
         /uAN7XkCU3R/HoccwBPiz+fuXm7IyorBCfZ0h1Qi7xwPekTyk3gqoBL/kGQoyZezbK42
         zVRJ90u+VzuJsZgRfi2/um9RvxZHeBdm46/QAS1VjC6FPKhQnjCdZoaZ0KZi1UI9/y0J
         B8bg==
X-Gm-Message-State: AJIora92qL7+Au+7noh0qf8BwXpvn8j1ibZN9KJWdpdA7tRMYI/uIuJI
        8ROmNseejIIgi/48zXhmFPHq5SlvAe02UHLQypPqUw==
X-Google-Smtp-Source: AGRyM1v9HReUSOdG7WurghjNT5BEL4pjfSC4V475aB2hHTv0gHjO3kSGpArGxEY5+vGaJpHiCGmg2bzE+Bc5B2o6SO4=
X-Received: by 2002:a7b:ce13:0:b0:3a3:102c:23d3 with SMTP id
 m19-20020a7bce13000000b003a3102c23d3mr5881343wmc.67.1659194483562; Sat, 30
 Jul 2022 08:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220724060013.171050-1-leo.yan@linaro.org> <20220724060013.171050-2-leo.yan@linaro.org>
 <CAP-5=fVY=_WUpke0sRMpvbJFu9JuYwqiwAmKdCS+=u7vEG-2uA@mail.gmail.com> <20220730093819.GA574473@leoy-ThinkPad-X240s>
In-Reply-To: <20220730093819.GA574473@leoy-ThinkPad-X240s>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 30 Jul 2022 08:21:10 -0700
Message-ID: <CAP-5=fWA8R9Ee5L9xgPtva9dvQ12uKqC1o4zgzPs0B9XWSMxhQ@mail.gmail.com>
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

On Sat, Jul 30, 2022 at 2:38 AM Leo Yan <leo.yan@linaro.org> wrote:
>
> Hi Ian,
>
> On Fri, Jul 29, 2022 at 10:13:04PM -0700, Ian Rogers wrote:
>
> [...]
>
> > I am seeing a problem with this patch with jvmti. To repro:
> >
> > 1) download a Java workload dacapo-9.12-MR1-bach.jar from
> > https://sourceforge.net/projects/dacapobench/
> > 2) build perf such as "make -C tools/perf O=/tmp/perf NO_LIBBFD=1" it
> > should detect Java and create /tmp/perf/libperf-jvmti.so
> > 3) run perf with the jvmti agent:
> > /tmp/perf/perf record -k 1 java -agentpath:/tmp/perf/libperf-jvmti.so
> > -jar dacapo-9.12-MR1-bach.jar -n 10 fop
> > 4) run perf inject:
> > /tmp/perf/perf inject -i perf.data -o perf-injected.data -j
> > 5) run perf report
> > /tmp/perf/perf report -i  perf-injected.data | grep org.apache.fop
> >
> > With this patch reverted I see lots of symbols like:
> >      0.00%  java             jitted-388040-4656.so  [.]
> > org.apache.fop.fo.FObj.bind(org.apache.fop.fo.PropertyList)
> >
> > With the patch I see lots of:
> > dso__load_sym_internal: failed to find program header for symbol:
> > Lorg/apache/fop/fo/FObj;bind(Lorg/apache/fop/fo/PropertyList;)V
> > st_value: 0x40
>
> Thanks for sharing the steps, I can reproduce the issue.
>
> I tried to add more logs to dump and hope can find specific pattern for
> these symbols, one thing I observed that if a symbol fails to find
> program header, it has the same values for st_value, shdr.sh_addr and
> shdr.sh_offset: all of them are 0x40.  So that means if with you
> proposed change in below, then we will get the file address is:
>
>   file_addr = st_value - shdr.sh_addr + shdr.sh_offset = 0x40
>
> Seems to me this is not reasonable: perf tries to add many symbols
> with the same file address 0x40.
>
> > Combining the old and new behaviors fixes the issue for me, wdyt?
>
> So far we don't answer a question is what's the purpose for these JAVA
> symbols.  I checked these symbols and concluded as:
>
> - They are not label, this is because sym.st_info is 0x2, so its
>   symbol type is STT_FUNC;
> - They are from ".text" section;
> - Symbol visibility is STV_DEFAULT;
> - Symbol's section index number is 0x1, which is different from some
>   special sections (STV_DEFAULT/SHN_COMMON/SHN_UNDEF/SHN_XINDEX).
>
> This is a rough summary, these symbols are likewise the normal function
> symbols, but they have special st_value (0x40) and has no matched the
> program header for them.
>
> If we rollback to use old offsets to calculate the symbol file address,
> it still is incorrect.
>
> I list all relevant symbols in: https://termbin.com/s0fb, for a reliable
> fixing, could anyone with java experience shed some lights for handling
> the symbols?
>
> On the other hand, I can accept to simply change pr_warning() to
> pr_debug4() to avoid warning flood, the log still can help us to find
> potential symbol parsing issue, so far they are not false-positive
> reporting.

Thanks, I suspect the ELF that the Java agent has created isn't good.
The Java agent is part of perf as and so is the ELF file generation
code:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/genelf.c?h=perf/core#n367
I took a quick look but most of the logic is in libelf - it seems less
obvious the bug would be there rather than perf. Could you take a
look? Ideally there'd be a quick fix that keeps all the benefits of
your change and the jvmti code working.

Thanks,
Ian


> Thanks,
> Leo
>
> > ```
> > --- a/tools/perf/util/symbol-elf.c
> > +++ b/tools/perf/util/symbol-elf.c
> > @@ -1305,16 +1305,21 @@ dso__load_sym_internal(struct dso *dso, struct
> > map *map, struct symsrc *syms
> > _ss,
> >
> >                        if (elf_read_program_header(syms_ss->elf,
> >                                                    (u64)sym.st_value, &phdr)) {
> > -                               pr_warning("%s: failed to find program
> > header for "
> > +                               pr_debug4("%s: failed to find program
> > header for "
> >                                           "symbol: %s st_value: %#" PRIx64 "\n",
> >                                           __func__, elf_name,
> > (u64)sym.st_value);
> > -                               continue;
> > +                               pr_debug4("%s: adjusting symbol:
> > st_value: %#" PRIx64 " "
> > +                                       "sh_addr: %#" PRIx64 "
> > sh_offset: %#" PRIx64 "\n",
> > +                                       __func__, (u64)sym.st_value,
> > (u64)shdr.sh_addr,
> > +                                       (u64)shdr.sh_offset);
> > +                               sym.st_value -= shdr.sh_addr - shdr.sh_offset;
> > +                       } else {
> > +                               pr_debug4("%s: adjusting symbol:
> > st_value: %#" PRIx64 " "
> > +                                       "p_vaddr: %#" PRIx64 "
> > p_offset: %#" PRIx64 "\n",
> > +                                       __func__, (u64)sym.st_value,
> > (u64)phdr.p_vaddr,
> > +                                       (u64)phdr.p_offset);
> > +                               sym.st_value -= phdr.p_vaddr - phdr.p_offset;
> >                        }
> > -                       pr_debug4("%s: adjusting symbol: st_value: %#"
> > PRIx64 " "
> > -                                 "p_vaddr: %#" PRIx64 " p_offset: %#"
> > PRIx64 "\n",
> > -                                 __func__, (u64)sym.st_value,
> > (u64)phdr.p_vaddr,
> > -                                 (u64)phdr.p_offset);
> > -                       sym.st_value -= phdr.p_vaddr - phdr.p_offset;
> >                }
> >
> >                demangled = demangle_sym(dso, kmodule, elf_name);
> > ```
> >
> > Thanks,
> > Ian
> >
> > >
> > >                 demangled = demangle_sym(dso, kmodule, elf_name);
> > > --
> > > 2.25.1
> > >
