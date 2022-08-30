Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171355A665F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 16:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiH3Odq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 10:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiH3Odl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 10:33:41 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8F2B5E76
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 07:33:39 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oT2Iy-0007M4-0n; Tue, 30 Aug 2022 16:33:28 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     atishp@atishpatra.org, anup@brainfault.org, will@kernel.org,
        mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, Conor.Dooley@microchip.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        philipp.tomsich@vrull.eu, cmuellner@linux.com, samuel@sholland.org,
        guoren@kernel.org
Subject: Re: [PATCH v2] drivers/perf: riscv_pmu_sbi: add support for PMU variant on T-Head C9xx cores
Date:   Tue, 30 Aug 2022 16:33:27 +0200
Message-ID: <3627040.SvYEEZNnvj@diego>
In-Reply-To: <5f72e3da-d87d-2d8d-bb4b-d95dca65d4f7@microchip.com>
References: <20220826163500.1748653-1-heiko@sntech.de> <5f72e3da-d87d-2d8d-bb4b-d95dca65d4f7@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

Am Freitag, 26. August 2022, 19:57:33 CEST schrieb Conor.Dooley@microchip.com:
> On 26/08/2022 17:35, Heiko Stuebner wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > With the T-HEAD C9XX cores being designed before or during the ratification
> > to the SSCOFPMF extension, they implement functionality very similar but
> > not equal to it. So add some adaptions to allow the C9XX to still handle
> > its PMU through the regular SBI PMU interface instead of defining new
> > interfaces or drivers.
> > 
> > To work properly, this requires a matching change in SBI, though the actual
> > interface between kernel and SBI does not change.
> > 
> > The main differences are a the overflow CSR and irq number.
> > 
> > As the reading of the overflow-csr is in the hot-path during irq handling
> 
> Hey Heiko,
> 
> Very nitpicky, but I had to read this twice to get it.. If you respin,
> it'd be worth adding a comma after "handling".

ok :-)


> > use an errata and alternatives to not introduce new conditionals there.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > changes in v2:
> > - use alternatives for the CSR access
> > - make the irq num selection a bit nicer
> > 
> > There is of course a matching opensbi-part whose current implementation can
> > be found on [0], but as comments show, this needs some more work still.
> > 
> > 
> > [0] https://patchwork.ozlabs.org/project/opensbi/cover/20220817112004.745776-1-heiko@sntech.de/
> > 
> >  arch/riscv/Kconfig.erratas           | 14 ++++++++++++
> >  arch/riscv/errata/thead/errata.c     | 19 +++++++++++++++++
> >  arch/riscv/include/asm/errata_list.h | 16 +++++++++++++-
> >  drivers/perf/riscv_pmu_sbi.c         | 32 +++++++++++++++++++---------
> >  4 files changed, 70 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
> > index 6850e9389930..f1eaac4c0073 100644
> > --- a/arch/riscv/Kconfig.erratas
> > +++ b/arch/riscv/Kconfig.erratas
> > @@ -66,4 +66,18 @@ config ERRATA_THEAD_CMO
> > 
> >           If you don't know what to do here, say "Y".
> > 
> > +config ERRATA_THEAD_PMU
> > +       bool "Apply T-Head PMU errata"
> > +       depends on ERRATA_THEAD
> > +       depends on RISCV_PMU_SBI
> > +       default y
> > +       help
> > +         The T-Head C9xx cores implement a PMU overflow extension very
> > +         similar to the core SSCOFPMF extension.
> > +
> > +         This will apply the overflow errata to handle the non-standard
> > +         behaviour via the regular SBI PMU driver and interface.
> > +
> > +         If you don't know what to do here, say "Y".
> > +
> >  endmenu # "CPU errata selection"
> > diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> > index 202c83f677b2..e6101eab25c8 100644
> > --- a/arch/riscv/errata/thead/errata.c
> > +++ b/arch/riscv/errata/thead/errata.c
> > @@ -44,6 +44,22 @@ static bool errata_probe_cmo(unsigned int stage,
> >  #endif
> >  }
> > 
> > +static bool errata_probe_pmu(unsigned int stage,
> > +                            unsigned long arch_id, unsigned long impid)
> > +{
> > +#ifdef CONFIG_ERRATA_THEAD_PMU
> 
> Is there a reason that all the alternatives use ifdef
> rather than if(IS_ENABLED())?

no real reason I guess - more like not enough thinking :-)

Using IS_ENABLED also makes it way nicer as we can just do

	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_PMU))
		return false;


> 
> > +       if (arch_id != 0 || impid != 0)
> > +               return false;
> > +
> > +       if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> > +               return false;
> > +
> > +       return true;
> > +#else
> > +       return false;
> > +#endif
> > +}
> > +
> >  static u32 thead_errata_probe(unsigned int stage,
> >                               unsigned long archid, unsigned long impid)
> >  {
> > @@ -55,6 +71,9 @@ static u32 thead_errata_probe(unsigned int stage,
> >         if (errata_probe_cmo(stage, archid, impid))
> >                 cpu_req_errata |= (1U << ERRATA_THEAD_CMO);
> > 
> > +       if (errata_probe_pmu(stage, archid, impid))
> > +               cpu_req_errata |= (1U << ERRATA_THEAD_PMU);
> 
> BIT(ERRATA_THEAD_PMU), no? Ditto for the CMO I guess..

and also the memory types - makes things quite a bit nicer :-)

So I'll include these fixes into the next revision.


Thanks
Heiko

> 
> > +
> >         return cpu_req_errata;
> >  }
> > 
> 
> Thanks,
> Conor.
> 
> 
> 




