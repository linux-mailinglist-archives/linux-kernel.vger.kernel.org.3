Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4494F5A62A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiH3MAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiH3MAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:00:51 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1445F217
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:00:48 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oSzv8-0006Z3-06; Tue, 30 Aug 2022 14:00:42 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     anup@brainfault.org, will@kernel.org, mark.rutland@arm.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, philipp.tomsich@vrull.eu,
        cmuellner@linux.com, samuel@sholland.org, guoren@kernel.org
Subject: Re: [PATCH v2] drivers/perf: riscv_pmu_sbi: add support for PMU variant on T-Head C9xx cores
Date:   Tue, 30 Aug 2022 14:00:41 +0200
Message-ID: <3400713.q0ZmV6gNhb@diego>
In-Reply-To: <CAOnJCUKB2xu+RST2qh2zC7=vcLzBs_x7B3i49bTnkoBWu3-0xA@mail.gmail.com>
References: <20220826163500.1748653-1-heiko@sntech.de> <CAOnJCUKB2xu+RST2qh2zC7=vcLzBs_x7B3i49bTnkoBWu3-0xA@mail.gmail.com>
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

Hi Atish,

Am Samstag, 27. August 2022, 00:39:32 CEST schrieb Atish Patra:
> On Fri, Aug 26, 2022 at 9:35 AM Heiko Stuebner <heiko@sntech.de> wrote:
> 
> > With the T-HEAD C9XX cores being designed before or during the ratification
> > to the SSCOFPMF extension, they implement functionality very similar but
> > not equal to it. So add some adaptions to allow the C9XX to still handle
> > its PMU through the regular SBI PMU interface instead of defining new
> > interfaces or drivers.
> >
> >
> It would be good to include any reference to T-HEAD C9XX PMU details
> somewhere.
> Does it support event filtering based on privilege mode as well ?

Looking at the docs ... it does, at least for machine and supervisor mode.

I.e. the mcountinhibit seems to be part of the base spec, but the c9xx
also implement an scounterinhibit doing the same for supervisor mode.

Though there is no equivalent for user-mode.

> Because enabling riscv_pmu_use_irq enables the filtering too.

From what I see in the current sbi-pmu driver this is just forwarded to
the sbi-part, right? I.e. the part doing

	if (event->attr.exclude_kernel)
		cflags |= SBI_PMU_CFG_FLAG_SET_SINH;
	if (event->attr.exclude_user)
		cflags |= SBI_PMU_CFG_FLAG_SET_UINH;

Though this is simply done independently of any kernel-side feature-
detection it seems, so the would need to be handled on the sbi-side?
[Which I need to update still].


Heiko

> > To work properly, this requires a matching change in SBI, though the actual
> > interface between kernel and SBI does not change.
> >
> > The main differences are a the overflow CSR and irq number.
> >
> > As the reading of the overflow-csr is in the hot-path during irq handling
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
> > [0]
> > https://patchwork.ozlabs.org/project/opensbi/cover/20220817112004.745776-1-heiko@sntech.de/
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
> > diff --git a/arch/riscv/errata/thead/errata.c
> > b/arch/riscv/errata/thead/errata.c
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
> > +
> >         return cpu_req_errata;
> >  }
> >
> > diff --git a/arch/riscv/include/asm/errata_list.h
> > b/arch/riscv/include/asm/errata_list.h
> > index 19a771085781..4180312d2a70 100644
> > --- a/arch/riscv/include/asm/errata_list.h
> > +++ b/arch/riscv/include/asm/errata_list.h
> > @@ -6,6 +6,7 @@
> >  #define ASM_ERRATA_LIST_H
> >
> >  #include <asm/alternative.h>
> > +#include <asm/csr.h>
> >  #include <asm/vendorid_list.h>
> >
> >  #ifdef CONFIG_ERRATA_SIFIVE
> > @@ -17,7 +18,8 @@
> >  #ifdef CONFIG_ERRATA_THEAD
> >  #define        ERRATA_THEAD_PBMT 0
> >  #define        ERRATA_THEAD_CMO 1
> > -#define        ERRATA_THEAD_NUMBER 2
> > +#define        ERRATA_THEAD_PMU 2
> > +#define        ERRATA_THEAD_NUMBER 3
> >  #endif
> >
> >  #define        CPUFEATURE_SVPBMT 0
> > @@ -142,6 +144,18 @@ asm volatile(ALTERNATIVE_2(
> >                       \
> >             "r"((unsigned long)(_start) + (_size))                      \
> >         : "a0")
> >
> > +#define THEAD_C9XX_RV_IRQ_PMU                  17
> > +#define THEAD_C9XX_CSR_SCOUNTEROF              0x5c5
> > +
> > +#define ALT_SBI_PMU_OVERFLOW(__ovl)                                    \
> > +asm volatile(ALTERNATIVE(                                              \
> > +       "csrr %0, " __stringify(CSR_SSCOUNTOVF),                        \
> > +       "csrr %0, " __stringify(THEAD_C9XX_CSR_SCOUNTEROF),             \
> > +               THEAD_VENDOR_ID, ERRATA_THEAD_PMU,                      \
> > +               CONFIG_ERRATA_THEAD_PMU)                                \
> > +       : "=r" (__ovl) :                                                \
> > +       : "memory")
> > +
> >  #endif /* __ASSEMBLY__ */
> >
> >  #endif
> > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> > index 6f6681bbfd36..f814d3ce5ba2 100644
> > --- a/drivers/perf/riscv_pmu_sbi.c
> > +++ b/drivers/perf/riscv_pmu_sbi.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/of.h>
> >  #include <linux/cpu_pm.h>
> >
> > +#include <asm/errata_list.h>
> >  #include <asm/sbi.h>
> >  #include <asm/hwcap.h>
> >
> > @@ -46,6 +47,8 @@ static const struct attribute_group
> > *riscv_pmu_attr_groups[] = {
> >   * per_cpu in case of harts with different pmu counters
> >   */
> >  static union sbi_pmu_ctr_info *pmu_ctr_list;
> > +static bool riscv_pmu_use_irq;
> > +static unsigned int riscv_pmu_irq_num;
> >  static unsigned int riscv_pmu_irq;
> >
> >  struct sbi_pmu_event_data {
> > @@ -575,7 +578,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void
> > *dev)
> >         fidx = find_first_bit(cpu_hw_evt->used_hw_ctrs,
> > RISCV_MAX_COUNTERS);
> >         event = cpu_hw_evt->events[fidx];
> >         if (!event) {
> > -               csr_clear(CSR_SIP, SIP_LCOFIP);
> > +               csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
> >                 return IRQ_NONE;
> >         }
> >
> > @@ -583,13 +586,13 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void
> > *dev)
> >         pmu_sbi_stop_hw_ctrs(pmu);
> >
> >         /* Overflow status register should only be read after counter are
> > stopped */
> > -       overflow = csr_read(CSR_SSCOUNTOVF);
> > +       ALT_SBI_PMU_OVERFLOW(overflow);
> >
> >         /*
> >          * Overflow interrupt pending bit should only be cleared after
> > stopping
> >          * all the counters to avoid any race condition.
> >          */
> > -       csr_clear(CSR_SIP, SIP_LCOFIP);
> > +       csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
> >
> >         /* No overflow bit is set */
> >         if (!overflow)
> > @@ -651,10 +654,10 @@ static int pmu_sbi_starting_cpu(unsigned int cpu,
> > struct hlist_node *node)
> >         /* Stop all the counters so that they can be enabled from perf */
> >         pmu_sbi_stop_all(pmu);
> >
> > -       if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
> > +       if (riscv_pmu_use_irq) {
> >                 cpu_hw_evt->irq = riscv_pmu_irq;
> > -               csr_clear(CSR_IP, BIT(RV_IRQ_PMU));
> > -               csr_set(CSR_IE, BIT(RV_IRQ_PMU));
> > +               csr_clear(CSR_IP, BIT(riscv_pmu_irq_num));
> > +               csr_set(CSR_IE, BIT(riscv_pmu_irq_num));
> >                 enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
> >         }
> >
> > @@ -663,9 +666,9 @@ static int pmu_sbi_starting_cpu(unsigned int cpu,
> > struct hlist_node *node)
> >
> >  static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node *node)
> >  {
> > -       if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
> > +       if (riscv_pmu_use_irq) {
> >                 disable_percpu_irq(riscv_pmu_irq);
> > -               csr_clear(CSR_IE, BIT(RV_IRQ_PMU));
> > +               csr_clear(CSR_IE, BIT(riscv_pmu_irq_num));
> >         }
> >
> >         /* Disable all counters access for user mode now */
> > @@ -681,7 +684,16 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu,
> > struct platform_device *pde
> >         struct device_node *cpu, *child;
> >         struct irq_domain *domain = NULL;
> >
> > -       if (!riscv_isa_extension_available(NULL, SSCOFPMF))
> > +       if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
> > +               riscv_pmu_irq_num = RV_IRQ_PMU;
> > +               riscv_pmu_use_irq = true;
> > +       } else if (sbi_get_mvendorid() == THEAD_VENDOR_ID &&
> > +                  sbi_get_marchid() == 0 && sbi_get_mimpid() == 0) {
> > +               riscv_pmu_irq_num = THEAD_C9XX_RV_IRQ_PMU;
> > +               riscv_pmu_use_irq = true;
> > +       }
> > +
> > +       if (!riscv_pmu_use_irq)
> >                 return -EOPNOTSUPP;
> >
> >         for_each_of_cpu_node(cpu) {
> > @@ -703,7 +715,7 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu,
> > struct platform_device *pde
> >                 return -ENODEV;
> >         }
> >
> > -       riscv_pmu_irq = irq_create_mapping(domain, RV_IRQ_PMU);
> > +       riscv_pmu_irq = irq_create_mapping(domain, riscv_pmu_irq_num);
> >         if (!riscv_pmu_irq) {
> >                 pr_err("Failed to map PMU interrupt for node\n");
> >                 return -ENODEV;
> > --
> > 2.35.1
> >
> >
> 
> 
> 




