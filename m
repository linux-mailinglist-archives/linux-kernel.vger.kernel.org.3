Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0161F59769A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 21:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238713AbiHQTeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 15:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241519AbiHQTdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:33:42 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EBEA61ED
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 12:32:31 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-334dc616f86so84777397b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 12:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=tqlyfTfg+lMoBys7TT54/b/VfkICPVbaqeuZmDgc944=;
        b=mER+XKZBMbF1Zlc0YPMTQfD/EtdLE1bUQKcsd8EpAI7eJc/OmEwc3aR9XnCAtXzBjm
         6arSAG5fwjKaarM/1WlzBzQ6Byh5ObhpJ2Fg15hBouQds8lZ2knIKRxZIQQU8RnW4Lxz
         eF4jNfZQI9I8W8nW/KBadL8p83r5pMm5dFsSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tqlyfTfg+lMoBys7TT54/b/VfkICPVbaqeuZmDgc944=;
        b=z7yytmC29LAobWLKv9WVEM1EoABvTzXwVhmJ2hYRNyBktBoo23w5fOZvHPeVgBSKO+
         nFW4ER+SxH3AYRtimyH3xmAPVfT3JKGy8ksy8Iy2ioseXx0+A4dDO6xxu4cpvx/NuYFv
         R9ax3n5j+CCL7+rd/FgQcgS9cbjvm+KV/Dl0W8ziaIlUcx83c37nU1a+b8sHTZQTPn2a
         WwQOseucnZY1q4i9tHrC3W69Nj6RcChetphYmOmHgowBb3siMmpd5tl7UOJOjCCyvWLZ
         MFnGB9jbsy0wZ+PVimaXKt8Z+AbduvLRGAYhIXfVaNcnJA77LHKecVxBj6TNqnttxHMN
         boGg==
X-Gm-Message-State: ACgBeo3QK1fO4usSpXeH0X/PiBXzWY2dRw6ZkFBorkAgDXKTyFFX49Qf
        Uxe1pjgE6eJD0Y1lZv9o180OLH4Sf1rttux1ANsH
X-Google-Smtp-Source: AA6agR4ddHiS7Khi1p81yeIBAyFwfAQSx7YE38wq6XSts0USTD23+WO3s3ipIuUXM0/aCdUOT7HFClKNuMp2LDp3ZdA=
X-Received: by 2002:a25:37c1:0:b0:67d:5e63:3f70 with SMTP id
 e184-20020a2537c1000000b0067d5e633f70mr21649897yba.312.1660764750854; Wed, 17
 Aug 2022 12:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220817111348.745527-1-heiko@sntech.de>
In-Reply-To: <20220817111348.745527-1-heiko@sntech.de>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 17 Aug 2022 12:32:20 -0700
Message-ID: <CAOnJCUJu1fr2qxOkX4Sz-kLhB64xkcjAbBAeTkp214ZHAa0btA@mail.gmail.com>
Subject: Re: [PATCH] drivers/perf: riscv_pmu_sbi: add support for PMU variant
 on T-Head C9xx cores
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     anup@brainfault.org, will@kernel.org, mark.rutland@arm.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, philipp.tomsich@vrull.eu,
        cmuellner@linux.com
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

On Wed, Aug 17, 2022 at 4:13 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> With the T-HEAD C9XX cores being designed before or during the ratification
> to the SSCOFPMF extension, they implement functionality very similar but
> not equal to it. So add some adaptions to allow the C9XX to still handle
> its PMU through the regular SBI PMU interface instead of defining new
> interfaces or drivers.
>

IMO, vendor specific workarounds in the generic implementation is not
a good idea.
If we have to support it, I think we should just put the IRQ number in
the DT and parse from the DT.
The initial sscofpmf series was based on the DT. It was removed later
as there was no need for it at that time.
We can always revive it.

Regarding the CSR number difference and static key enablement, can we
use code patching techniques here as well ?
At least all the T-HEAD C9XX core erratas are in one place.

The alternate would be just to say T-HEAD C9XX support SSCOFPMF but
with erratas. I don't prefer this approach
but it keeps the vendor specific checks out of the generic code.

> To work properly, this requires a matching change in SBI, though the actual
> interface between kernel and SBI does not change.
>

Do you have a working OpenSBI implementation for this ?

> The main differences are a the overflow CSR and irq number.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/perf/riscv_pmu_sbi.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 6f6681bbfd36..4589166e0de4 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -41,12 +41,17 @@ static const struct attribute_group *riscv_pmu_attr_groups[] = {
>         NULL,
>  };
>
> +#define THEAD_C9XX_RV_IRQ_PMU                  17
> +#define THEAD_C9XX_CSR_SCOUNTEROF              0x5c5
> +
>  /*
>   * RISC-V doesn't have hetergenous harts yet. This need to be part of
>   * per_cpu in case of harts with different pmu counters
>   */
>  static union sbi_pmu_ctr_info *pmu_ctr_list;
> +static unsigned int riscv_pmu_irq_num;
>  static unsigned int riscv_pmu_irq;
> +static bool is_thead_c9xx;
>
>  struct sbi_pmu_event_data {
>         union {
> @@ -575,7 +580,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>         fidx = find_first_bit(cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS);
>         event = cpu_hw_evt->events[fidx];
>         if (!event) {
> -               csr_clear(CSR_SIP, SIP_LCOFIP);
> +               csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
>                 return IRQ_NONE;
>         }
>
> @@ -583,13 +588,14 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>         pmu_sbi_stop_hw_ctrs(pmu);
>
>         /* Overflow status register should only be read after counter are stopped */
> -       overflow = csr_read(CSR_SSCOUNTOVF);
> +       overflow = !is_thead_c9xx ? csr_read(CSR_SSCOUNTOVF)
> +                                 : csr_read(THEAD_C9XX_CSR_SCOUNTEROF);
>
>         /*
>          * Overflow interrupt pending bit should only be cleared after stopping
>          * all the counters to avoid any race condition.
>          */
> -       csr_clear(CSR_SIP, SIP_LCOFIP);
> +       csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
>
>         /* No overflow bit is set */
>         if (!overflow)
> @@ -653,8 +659,8 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
>
>         if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
>                 cpu_hw_evt->irq = riscv_pmu_irq;
> -               csr_clear(CSR_IP, BIT(RV_IRQ_PMU));
> -               csr_set(CSR_IE, BIT(RV_IRQ_PMU));
> +               csr_clear(CSR_IP, BIT(riscv_pmu_irq_num));
> +               csr_set(CSR_IE, BIT(riscv_pmu_irq_num));
>                 enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
>         }
>
> @@ -665,7 +671,7 @@ static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node *node)
>  {
>         if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
>                 disable_percpu_irq(riscv_pmu_irq);
> -               csr_clear(CSR_IE, BIT(RV_IRQ_PMU));
> +               csr_clear(CSR_IE, BIT(riscv_pmu_irq_num));
>         }
>
>         /* Disable all counters access for user mode now */
> @@ -681,7 +687,11 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
>         struct device_node *cpu, *child;
>         struct irq_domain *domain = NULL;
>
> -       if (!riscv_isa_extension_available(NULL, SSCOFPMF))
> +       is_thead_c9xx = (sbi_get_mvendorid() == THEAD_VENDOR_ID &&
> +                        sbi_get_marchid() == 0 &&
> +                        sbi_get_mimpid() == 0);
> +
> +       if (!riscv_isa_extension_available(NULL, SSCOFPMF) && !is_thead_c9xx)
>                 return -EOPNOTSUPP;
>
>         for_each_of_cpu_node(cpu) {
> @@ -703,7 +713,8 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
>                 return -ENODEV;
>         }
>
> -       riscv_pmu_irq = irq_create_mapping(domain, RV_IRQ_PMU);
> +       riscv_pmu_irq_num = !is_thead_c9xx ? RV_IRQ_PMU : THEAD_C9XX_RV_IRQ_PMU;
> +       riscv_pmu_irq = irq_create_mapping(domain, riscv_pmu_irq_num);
>         if (!riscv_pmu_irq) {
>                 pr_err("Failed to map PMU interrupt for node\n");
>                 return -ENODEV;
> --
> 2.35.1
>


-- 
Regards,
Atish
