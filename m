Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF2A598005
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 10:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbiHRIYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 04:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiHRIYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 04:24:47 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2015D868B7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 01:24:46 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id x25so1015752ljm.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 01:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Eh2ca1k897f/fpjj6GZcTMr0pxfwU8M3TTyUS5TvUjQ=;
        b=RFAr/7oW0zPoFkfRwvLBYI6LDgLSLVUN5klD12foZ9OmtfSkRvsOrWZEritkdGO1xL
         iJ3j3xORTEcKizlPkv86BZq2eENXcAAnZcM+ikePNVq43yw1OTAe+YIdHgFPjYvO9CJo
         ch0Kjfj8slEewPzXVdNSjziu7L/AWXRKfyfQSpHE4PMqBdkZYUAdH5zh+/LU8L5ROd40
         qCxAEYkwYGGFfuaQzIth8EdRpRgDLxw8RJuUFmtXNyr7g2Bmx8gGkrEnhSqv5Cta9EAN
         Mztj/sIcEGbcD050FLuHwxxsw+iGEvceb0c6CymKRtJZNmms48/Iqf1S6QAxNFlpp2Az
         IdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Eh2ca1k897f/fpjj6GZcTMr0pxfwU8M3TTyUS5TvUjQ=;
        b=2KFTJDdLOCv1BHQq7HXh50h0AfDHPl16NnqvC6hYhIT/COPg+WUgkGxEozO6BXeebj
         7XSKy5Tu4M8XJPY5dCB3GgjzdFmUx76nbRQcnSe5/CXdcaIUSiK5oMbvpWcTVSic7QNZ
         KV8Mz0sG7fPLkWzq9q8Oe8HTjZ+O2roRW4pAecgITJ5Pi6qoOF5/fMwU8lP5upyDQ1w5
         eYy5Wg9GR86r3xjeNzeyxobRSZzxXxvCIHqifUow4AO42KuKb++YjuOzBbb82Rvc+Pvx
         oonA/O3oytwMay2N/YIuxj1oCZW9QmcOFNIp6R5b5VxbupUfwNBUqAT7ME04Rs+1xIrB
         eGjQ==
X-Gm-Message-State: ACgBeo0vz5qlPoUaB6tpQyz+s7RJlcsvagFS0BB2LIHaW0w+S/0hkzrM
        cw8IogPp5ouNpofObQukBlaxkQReh93S8xv5Tsfwdg==
X-Google-Smtp-Source: AA6agR4kT1zW8SyEa7wWTUQD8xI3ALBqcvbJWB9om1QxAwEqviJpffov94G4tr/ClkhNvS6S7KPFKkPZgnDHkV01QSA=
X-Received: by 2002:a2e:a987:0:b0:25f:d70a:c63c with SMTP id
 x7-20020a2ea987000000b0025fd70ac63cmr589061ljq.34.1660811084327; Thu, 18 Aug
 2022 01:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220817111348.745527-1-heiko@sntech.de> <CAOnJCUJu1fr2qxOkX4Sz-kLhB64xkcjAbBAeTkp214ZHAa0btA@mail.gmail.com>
In-Reply-To: <CAOnJCUJu1fr2qxOkX4Sz-kLhB64xkcjAbBAeTkp214ZHAa0btA@mail.gmail.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 18 Aug 2022 13:54:33 +0530
Message-ID: <CAK9=C2U3OvUZmYTJ-C0wkSp8ViPA1+Nj2L6pd4CHTCuzaVtDJg@mail.gmail.com>
Subject: Re: [PATCH] drivers/perf: riscv_pmu_sbi: add support for PMU variant
 on T-Head C9xx cores
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, anup@brainfault.org,
        will@kernel.org, mark.rutland@arm.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        philipp.tomsich@vrull.eu, cmuellner@linux.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 1:03 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Wed, Aug 17, 2022 at 4:13 AM Heiko Stuebner <heiko@sntech.de> wrote:
> >
> > With the T-HEAD C9XX cores being designed before or during the ratification
> > to the SSCOFPMF extension, they implement functionality very similar but
> > not equal to it. So add some adaptions to allow the C9XX to still handle
> > its PMU through the regular SBI PMU interface instead of defining new
> > interfaces or drivers.
> >
>
> IMO, vendor specific workarounds in the generic implementation is not
> a good idea.
> If we have to support it, I think we should just put the IRQ number in
> the DT and parse from the DT.
> The initial sscofpmf series was based on the DT. It was removed later
> as there was no need for it at that time.
> We can always revive it.
>
> Regarding the CSR number difference and static key enablement, can we
> use code patching techniques here as well ?
> At least all the T-HEAD C9XX core erratas are in one place.
>
> The alternate would be just to say T-HEAD C9XX support SSCOFPMF but
> with erratas. I don't prefer this approach
> but it keeps the vendor specific checks out of the generic code.

Whether to have a DT node (or not) was already discussed and concluded
in the past.

We don't need a DT node just to get the IRQ number. The T-HEAD custom
IRQ number can be derived based on mvendorid.

Also, all these T-HEAD specific changes in SBI PMU driver should be
implemented as erratas using ALTERNATIVE() macros.

Regards,
Anup



>
> > To work properly, this requires a matching change in SBI, though the actual
> > interface between kernel and SBI does not change.
> >
>
> Do you have a working OpenSBI implementation for this ?
>
> > The main differences are a the overflow CSR and irq number.
> >
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  drivers/perf/riscv_pmu_sbi.c | 27 +++++++++++++++++++--------
> >  1 file changed, 19 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> > index 6f6681bbfd36..4589166e0de4 100644
> > --- a/drivers/perf/riscv_pmu_sbi.c
> > +++ b/drivers/perf/riscv_pmu_sbi.c
> > @@ -41,12 +41,17 @@ static const struct attribute_group *riscv_pmu_attr_groups[] = {
> >         NULL,
> >  };
> >
> > +#define THEAD_C9XX_RV_IRQ_PMU                  17
> > +#define THEAD_C9XX_CSR_SCOUNTEROF              0x5c5
> > +
> >  /*
> >   * RISC-V doesn't have hetergenous harts yet. This need to be part of
> >   * per_cpu in case of harts with different pmu counters
> >   */
> >  static union sbi_pmu_ctr_info *pmu_ctr_list;
> > +static unsigned int riscv_pmu_irq_num;
> >  static unsigned int riscv_pmu_irq;
> > +static bool is_thead_c9xx;
> >
> >  struct sbi_pmu_event_data {
> >         union {
> > @@ -575,7 +580,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
> >         fidx = find_first_bit(cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS);
> >         event = cpu_hw_evt->events[fidx];
> >         if (!event) {
> > -               csr_clear(CSR_SIP, SIP_LCOFIP);
> > +               csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
> >                 return IRQ_NONE;
> >         }
> >
> > @@ -583,13 +588,14 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
> >         pmu_sbi_stop_hw_ctrs(pmu);
> >
> >         /* Overflow status register should only be read after counter are stopped */
> > -       overflow = csr_read(CSR_SSCOUNTOVF);
> > +       overflow = !is_thead_c9xx ? csr_read(CSR_SSCOUNTOVF)
> > +                                 : csr_read(THEAD_C9XX_CSR_SCOUNTEROF);
> >
> >         /*
> >          * Overflow interrupt pending bit should only be cleared after stopping
> >          * all the counters to avoid any race condition.
> >          */
> > -       csr_clear(CSR_SIP, SIP_LCOFIP);
> > +       csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
> >
> >         /* No overflow bit is set */
> >         if (!overflow)
> > @@ -653,8 +659,8 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
> >
> >         if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
> >                 cpu_hw_evt->irq = riscv_pmu_irq;
> > -               csr_clear(CSR_IP, BIT(RV_IRQ_PMU));
> > -               csr_set(CSR_IE, BIT(RV_IRQ_PMU));
> > +               csr_clear(CSR_IP, BIT(riscv_pmu_irq_num));
> > +               csr_set(CSR_IE, BIT(riscv_pmu_irq_num));
> >                 enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
> >         }
> >
> > @@ -665,7 +671,7 @@ static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node *node)
> >  {
> >         if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
> >                 disable_percpu_irq(riscv_pmu_irq);
> > -               csr_clear(CSR_IE, BIT(RV_IRQ_PMU));
> > +               csr_clear(CSR_IE, BIT(riscv_pmu_irq_num));
> >         }
> >
> >         /* Disable all counters access for user mode now */
> > @@ -681,7 +687,11 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
> >         struct device_node *cpu, *child;
> >         struct irq_domain *domain = NULL;
> >
> > -       if (!riscv_isa_extension_available(NULL, SSCOFPMF))
> > +       is_thead_c9xx = (sbi_get_mvendorid() == THEAD_VENDOR_ID &&
> > +                        sbi_get_marchid() == 0 &&
> > +                        sbi_get_mimpid() == 0);
> > +
> > +       if (!riscv_isa_extension_available(NULL, SSCOFPMF) && !is_thead_c9xx)
> >                 return -EOPNOTSUPP;
> >
> >         for_each_of_cpu_node(cpu) {
> > @@ -703,7 +713,8 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
> >                 return -ENODEV;
> >         }
> >
> > -       riscv_pmu_irq = irq_create_mapping(domain, RV_IRQ_PMU);
> > +       riscv_pmu_irq_num = !is_thead_c9xx ? RV_IRQ_PMU : THEAD_C9XX_RV_IRQ_PMU;
> > +       riscv_pmu_irq = irq_create_mapping(domain, riscv_pmu_irq_num);
> >         if (!riscv_pmu_irq) {
> >                 pr_err("Failed to map PMU interrupt for node\n");
> >                 return -ENODEV;
> > --
> > 2.35.1
> >
>
>
> --
> Regards,
> Atish
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
