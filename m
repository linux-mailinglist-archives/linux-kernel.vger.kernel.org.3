Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD284FAE65
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 17:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240375AbiDJPR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 11:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiDJPRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 11:17:24 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A9F29806
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 08:15:13 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-d6ca46da48so14675118fac.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 08:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AykdxVkfek06fjXsLB9I2IRHzCOJ6nIrMbEtU2HTEq0=;
        b=A/nT1N5myhjcL/iH9Bw8eSo2yqIZp8xF1pBJy3wtyHqPNG0WBG5cVpRDBWUYwMadtc
         b6qXuao0UknR6L+QodumzaDlSmugfdvmQP65aTADnopUAQXHTAOPV0n5bGv3V96CxbbR
         V7P3W3C0wdGHBaxOMjM5uS1J1SN5DIw0YcSgR7XqrtddyoBNzZgcTQBQvdE/DQxMLYn/
         up01o53v/D+e1NyNX24m3Ff3TVZxISLbThUtbw7CnWvIPL36ujBBVMqKm9CwPuNnMJbN
         SzW9907FEjhnSyXOfFmBNbSiD1OxjakTAJsNxqr6cE6JXGrwYQdSRcegbFqdhUXYJdyE
         YGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AykdxVkfek06fjXsLB9I2IRHzCOJ6nIrMbEtU2HTEq0=;
        b=MxS283RVvLmLrxZxzfpcnIvRbHSI2+QKw8wY7BlIxwT2xQ//v+ikpwaaU8Wz3MZuVI
         LMb9IfRWO8Ng6zUCYfz7l3pl11julgZcMgf+WB3muhrBD9/gdQm9yJ3nxPNMNFGbLEyg
         6RhpjsbLo6QUQtHvt/bVy4pTXgowDK6mecKdsIAskhQML//2Yv2h8lWUgI2uqWod3GOm
         YeGJYZmEfIvbgbbRESsiI9Rm87C1ggHIbB236qvsy1rLeQ5wzkrdvmxXMvOGidiQS5ig
         FKICh5xD02vS6ZlWBzAFanFGIzJgncCNP88FPPIjU6Hdzp6LS5NDYqiqg4D64xeOP5sD
         xLSw==
X-Gm-Message-State: AOAM532ztaSvOEVM4/S5I6XUIELPxeRAW6t746h/wCCHBb5TVrfgTy9Y
        oi6MN6NDgu2nE0C979Kul9J/3+vJvBhL2Sq1pwfgqA==
X-Google-Smtp-Source: ABdhPJw4JlX7XrQmjaKV9AkjsvEklgyp/+SYdmSxL3OSV1KqjDA84a+/qb1G0521cTO8XAEfbAt1IhBKhpUfEDvvMME=
X-Received: by 2002:a05:6870:b021:b0:e1:dc43:9000 with SMTP id
 y33-20020a056870b02100b000e1dc439000mr12076705oae.172.1649603713127; Sun, 10
 Apr 2022 08:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220406142606.18464-1-eric.lin@sifive.com> <20220406142606.18464-2-eric.lin@sifive.com>
 <YlGgro3TupbOEnJC@kernel.org>
In-Reply-To: <YlGgro3TupbOEnJC@kernel.org>
From:   Eric Lin <eric.lin@sifive.com>
Date:   Sun, 10 Apr 2022 23:15:01 +0800
Message-ID: <CAPqJEFrh71h-UZF1=TQKWTrsL84R=nzoBTieAw6rtoyBbu7kRQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf jitdump: Add riscv64 support.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        jolsa@kernel.org, Namhyung Kim <namhyung@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        iii@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Sat, Apr 9, 2022 at 11:05 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Apr 06, 2022 at 10:26:06PM +0800, Eric Lin escreveu:
> > Signed-off-by: Eric Lin <eric.lin@sifive.com>
>
> Can you plese provide some series of commands demonstrating the usage of
> this functionality on riscv?
>
> A dump, for instance.
>
> - Arnaldo
>

OK, I got it. I'll show the series of commands in the commit message
in v2 patch.
Thanks.

> > ---
> >  tools/perf/arch/riscv/Makefile | 1 +
> >  tools/perf/util/genelf.h       | 3 +++
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/tools/perf/arch/riscv/Makefile b/tools/perf/arch/riscv/Makefile
> > index 1aa9dd772489..a8d25d005207 100644
> > --- a/tools/perf/arch/riscv/Makefile
> > +++ b/tools/perf/arch/riscv/Makefile
> > @@ -2,3 +2,4 @@ ifndef NO_DWARF
> >  PERF_HAVE_DWARF_REGS := 1
> >  endif
> >  PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
> > +PERF_HAVE_JITDUMP := 1
> > diff --git a/tools/perf/util/genelf.h b/tools/perf/util/genelf.h
> > index 3db3293213a9..ae138afe6c56 100644
> > --- a/tools/perf/util/genelf.h
> > +++ b/tools/perf/util/genelf.h
> > @@ -38,6 +38,9 @@ int jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_ent
> >  #elif defined(__s390x__)
> >  #define GEN_ELF_ARCH EM_S390
> >  #define GEN_ELF_CLASS        ELFCLASS64
> > +#elif defined(__riscv) && __riscv_xlen == 64
> > +#define GEN_ELF_ARCH EM_RISCV
> > +#define GEN_ELF_CLASS        ELFCLASS64
> >  #else
> >  #error "unsupported architecture"
> >  #endif
> > --
> > 2.35.1
>
> --
>
> - Arnaldo
