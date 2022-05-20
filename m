Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B48252EDE9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350174AbiETOPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbiETOPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:15:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D391A1666B2;
        Fri, 20 May 2022 07:15:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7068661B1D;
        Fri, 20 May 2022 14:15:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E63C385A9;
        Fri, 20 May 2022 14:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653056106;
        bh=LexAD+My7zTkHhzGZZjrnNvnzF0U8YR8Me2dp0xadhk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kR78SDLgLc/MPLF4KmX2bXWOg0XpbZs1//f71+0Bx421j4MlvnuGU6bZOz6TT5lw9
         n28vlljHDouO/cC1yjq3PnDm0mT1KrFSbYzPssfdj7J2B53Ff9NCtNC8XjnezBZqVe
         ATuSTvkJsKxARQLFhShLnFhnSSUN8VTUUIQqszdeCS8V7pjBWdLUtcCu/uqfFrPYOB
         JHr0p1Q0NKTicxopblor5K7ACAaBSoq4PJRl7zJ6UgjIwlhe76aprA/1Hbdi5SlRDF
         TRo5WBjkUdiZqYh4Bomz4adi0rbsSgxxsxIRAjMC27AYpGgXFo7zEb77mADVFNQfiJ
         cOivSVNy2nJ/g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B5428400B1; Fri, 20 May 2022 11:15:02 -0300 (-03)
Date:   Fri, 20 May 2022 11:15:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     kan.liang@linux.intel.com, mingo@redhat.com, namhyung@kernel.org,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        zhengjun.xing@linux.intel.com, Ammy Yi <ammy.yi@intel.com>
Subject: Re: [PATCH] perf regs x86: Fix arch__intr_reg_mask() for the hybrid
 platform
Message-ID: <YoeiZh9SaRSvpB9r@kernel.org>
References: <20220518145125.1494156-1-kan.liang@linux.intel.com>
 <CAP-5=fWKmR-bDbiocSAd4qkrf7_ge+e1_gYLjQqRfGyc8FP4Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWKmR-bDbiocSAd4qkrf7_ge+e1_gYLjQqRfGyc8FP4Sw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 18, 2022 at 09:38:20PM -0700, Ian Rogers escreveu:
> On Wed, May 18, 2022 at 7:52 AM <kan.liang@linux.intel.com> wrote:
> >
> > From: Kan Liang <kan.liang@linux.intel.com>
> >
> > The X86 specific arch__intr_reg_mask() is to check whether the kernel
> > and hardware can collect XMM registers. But it doesn't work on some
> > hybrid platform.
> >
> > Without the patch on ADL-N,
> >
> > $perf record -I?
> > available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10
> > R11 R12 R13 R14 R15
> >
> > The config of the test event doesn't contain the PMU information. The
> > kernel may fail to initialize it on the correct hybrid PMU and return
> > the wrong non-supported information.
> >
> > Add the PMU information into the config for the hybrid platform. The
> > same register set is supported among different hybrid PMUs. Checking
> > the first available one is good enough.
> >
> > With the patch on ADL-N,
> >
> > $perf record -I?
> > available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10
> > R11 R12 R13 R14 R15 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 XMM9
> > XMM10 XMM11 XMM12 XMM13 XMM14 XMM15
> >
> > Fixes: 6466ec14aaf4 ("perf regs x86: Add X86 specific arch__intr_reg_mask()")
> > Reported-by: Ammy Yi <ammy.yi@intel.com>
> > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> > ---
> >  tools/perf/arch/x86/util/perf_regs.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
> > index 207c56805c55..0ed177991ad0 100644
> > --- a/tools/perf/arch/x86/util/perf_regs.c
> > +++ b/tools/perf/arch/x86/util/perf_regs.c
> > @@ -9,6 +9,8 @@
> >  #include "../../../util/perf_regs.h"
> >  #include "../../../util/debug.h"
> >  #include "../../../util/event.h"
> > +#include "../../../util/pmu.h"
> > +#include "../../../util/pmu-hybrid.h"
> >
> >  const struct sample_reg sample_reg_masks[] = {
> >         SMPL_REG(AX, PERF_REG_X86_AX),
> > @@ -284,12 +286,22 @@ uint64_t arch__intr_reg_mask(void)
> >                 .disabled               = 1,
> >                 .exclude_kernel         = 1,
> >         };
> > +       struct perf_pmu *pmu;
> 
> nit: this could have smaller scope if just be declared in the if-block.
> 
> Thanks,
> Ian
> 
> >         int fd;
> >         /*
> >          * In an unnamed union, init it here to build on older gcc versions
> >          */
> >         attr.sample_period = 1;
> >
> > +       if (perf_pmu__has_hybrid()) {
> > +               /*
> > +                * The same register set is supported among different hybrid PMUs.
> > +                * Only check the first available one.
> > +                */
> > +               pmu = list_first_entry(&perf_pmu__hybrid_pmus, typeof(*pmu), hybrid_list);
> > +               attr.config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
> > +       }
> > +
> >         event_attr_init(&attr);
> >
> >         fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
> > --
> > 2.35.1
> >

-- 

- Arnaldo
