Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C1B5859AB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 11:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbiG3Jib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 05:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbiG3Ji2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 05:38:28 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D53019003
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 02:38:27 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id j22so12255019ejs.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 02:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1QFiAl5mkhApEL9gxobGZqygkCmC9fEtDEUIIEoetyI=;
        b=x9q8s+afLiAddh7OeVRthXZuuCg/l/9AxmeqgaKW8J2hje57V/KclrAgBV/DegMX5y
         f+2vU8PqP2Uo5mwBYzs/rfFwptSe9XUZXoBmFRs4nbRMNMt4OiH8jCwHWr+xz0SEw+Bt
         RNtverRMkCGF94QrZJt+P2zTiHmwW4Kf9434lMDuCCljXgU6g4cmKfPf2p68AFUkxtfw
         +Z7/A2lMQhXaCTQJwbEhvKyI8nQD5gd7elo8q5w9kUMN3lbNCFIhDYzz9an0hvkBNIyx
         Q22aNmT79O6iIlMPtDq0CAW2WHQwlqx8xGrvOictVv/JRcsNSd4wANg/Vd+92lBq3tMS
         TL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1QFiAl5mkhApEL9gxobGZqygkCmC9fEtDEUIIEoetyI=;
        b=S7WHSTHp4yQyNMLnBN9gdFTBv4XPxLHPVrZo7lzcxK+eSvaJ0e/3CEACce/nJxZfA3
         5kOGf28e4CRAwLSV7lwIvXpTkPmUObox0MGCKENc1GlyZttNU/3Q3otocQao7cZws5fx
         GbdXsvBfnbImOP6FfsuQzFOZxjI91rGvZZnseHwPFPtvNPpXMjhofkn5G7frc0qIarEn
         m0SK7yLHkBvvu6/emVqsuR1RmCrGx21GaQDEP/IjuDwBxk0oIgqSW+z/IVoHA7/YDEqV
         LT7Hspm3GI6eJQdBfvfq+FWoF6+8/bdYo4SfN2d9bIDMs+8JPV/+q4+iRLCco+VeR+av
         Z7Wg==
X-Gm-Message-State: AJIora/2TSHztEkkBhupOmwhQzAuLHVx3oL7SIGFPr70r1RGNxAFuVvV
        i7RJOgLiiOepNGKAwmF5ZrRosA==
X-Google-Smtp-Source: AGRyM1v04iFdelPx45SAFt0tcMSTFwbriOuRv91g919AH34DqD9g+YUbdIbEaJk9+a+SWrd7tGEUdg==
X-Received: by 2002:a17:907:2bd3:b0:72b:44ed:6d6b with SMTP id gv19-20020a1709072bd300b0072b44ed6d6bmr5827662ejc.632.1659173905586;
        Sat, 30 Jul 2022 02:38:25 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.98.208])
        by smtp.gmail.com with ESMTPSA id b14-20020a1709064d4e00b007304d084c5esm464637ejv.166.2022.07.30.02.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 02:38:24 -0700 (PDT)
Date:   Sat, 30 Jul 2022 17:38:19 +0800
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
Message-ID: <20220730093819.GA574473@leoy-ThinkPad-X240s>
References: <20220724060013.171050-1-leo.yan@linaro.org>
 <20220724060013.171050-2-leo.yan@linaro.org>
 <CAP-5=fVY=_WUpke0sRMpvbJFu9JuYwqiwAmKdCS+=u7vEG-2uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVY=_WUpke0sRMpvbJFu9JuYwqiwAmKdCS+=u7vEG-2uA@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URI_HEX autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Fri, Jul 29, 2022 at 10:13:04PM -0700, Ian Rogers wrote:

[...]

> I am seeing a problem with this patch with jvmti. To repro:
> 
> 1) download a Java workload dacapo-9.12-MR1-bach.jar from
> https://sourceforge.net/projects/dacapobench/
> 2) build perf such as "make -C tools/perf O=/tmp/perf NO_LIBBFD=1" it
> should detect Java and create /tmp/perf/libperf-jvmti.so
> 3) run perf with the jvmti agent:
> /tmp/perf/perf record -k 1 java -agentpath:/tmp/perf/libperf-jvmti.so
> -jar dacapo-9.12-MR1-bach.jar -n 10 fop
> 4) run perf inject:
> /tmp/perf/perf inject -i perf.data -o perf-injected.data -j
> 5) run perf report
> /tmp/perf/perf report -i  perf-injected.data | grep org.apache.fop
> 
> With this patch reverted I see lots of symbols like:
>      0.00%  java             jitted-388040-4656.so  [.]
> org.apache.fop.fo.FObj.bind(org.apache.fop.fo.PropertyList)
> 
> With the patch I see lots of:
> dso__load_sym_internal: failed to find program header for symbol:
> Lorg/apache/fop/fo/FObj;bind(Lorg/apache/fop/fo/PropertyList;)V
> st_value: 0x40

Thanks for sharing the steps, I can reproduce the issue.

I tried to add more logs to dump and hope can find specific pattern for
these symbols, one thing I observed that if a symbol fails to find
program header, it has the same values for st_value, shdr.sh_addr and
shdr.sh_offset: all of them are 0x40.  So that means if with you
proposed change in below, then we will get the file address is:

  file_addr = st_value - shdr.sh_addr + shdr.sh_offset = 0x40

Seems to me this is not reasonable: perf tries to add many symbols
with the same file address 0x40.

> Combining the old and new behaviors fixes the issue for me, wdyt?

So far we don't answer a question is what's the purpose for these JAVA
symbols.  I checked these symbols and concluded as:

- They are not label, this is because sym.st_info is 0x2, so its
  symbol type is STT_FUNC;
- They are from ".text" section;
- Symbol visibility is STV_DEFAULT;
- Symbol's section index number is 0x1, which is different from some
  special sections (STV_DEFAULT/SHN_COMMON/SHN_UNDEF/SHN_XINDEX).

This is a rough summary, these symbols are likewise the normal function
symbols, but they have special st_value (0x40) and has no matched the
program header for them.

If we rollback to use old offsets to calculate the symbol file address,
it still is incorrect.

I list all relevant symbols in: https://termbin.com/s0fb, for a reliable
fixing, could anyone with java experience shed some lights for handling
the symbols?

On the other hand, I can accept to simply change pr_warning() to
pr_debug4() to avoid warning flood, the log still can help us to find
potential symbol parsing issue, so far they are not false-positive
reporting.

Thanks,
Leo

> ```
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1305,16 +1305,21 @@ dso__load_sym_internal(struct dso *dso, struct
> map *map, struct symsrc *syms
> _ss,
> 
>                        if (elf_read_program_header(syms_ss->elf,
>                                                    (u64)sym.st_value, &phdr)) {
> -                               pr_warning("%s: failed to find program
> header for "
> +                               pr_debug4("%s: failed to find program
> header for "
>                                           "symbol: %s st_value: %#" PRIx64 "\n",
>                                           __func__, elf_name,
> (u64)sym.st_value);
> -                               continue;
> +                               pr_debug4("%s: adjusting symbol:
> st_value: %#" PRIx64 " "
> +                                       "sh_addr: %#" PRIx64 "
> sh_offset: %#" PRIx64 "\n",
> +                                       __func__, (u64)sym.st_value,
> (u64)shdr.sh_addr,
> +                                       (u64)shdr.sh_offset);
> +                               sym.st_value -= shdr.sh_addr - shdr.sh_offset;
> +                       } else {
> +                               pr_debug4("%s: adjusting symbol:
> st_value: %#" PRIx64 " "
> +                                       "p_vaddr: %#" PRIx64 "
> p_offset: %#" PRIx64 "\n",
> +                                       __func__, (u64)sym.st_value,
> (u64)phdr.p_vaddr,
> +                                       (u64)phdr.p_offset);
> +                               sym.st_value -= phdr.p_vaddr - phdr.p_offset;
>                        }
> -                       pr_debug4("%s: adjusting symbol: st_value: %#"
> PRIx64 " "
> -                                 "p_vaddr: %#" PRIx64 " p_offset: %#"
> PRIx64 "\n",
> -                                 __func__, (u64)sym.st_value,
> (u64)phdr.p_vaddr,
> -                                 (u64)phdr.p_offset);
> -                       sym.st_value -= phdr.p_vaddr - phdr.p_offset;
>                }
> 
>                demangled = demangle_sym(dso, kmodule, elf_name);
> ```
> 
> Thanks,
> Ian
> 
> >
> >                 demangled = demangle_sym(dso, kmodule, elf_name);
> > --
> > 2.25.1
> >
