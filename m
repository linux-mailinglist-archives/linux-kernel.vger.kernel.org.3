Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A346E5B1042
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 01:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiIGXPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 19:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIGXPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 19:15:13 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C37F77576
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 16:15:12 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id n202so12735936iod.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 16:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=skhLfaOO9lv7TLZsn5jcW2c2pz0dmX1gkpRg+2lzHTE=;
        b=Txi4dTrWp/O1vsqSnSs/3PzL9qYizF1mJ5Mfwyue6kYL8iCMRyLZyyIrxzyN5hzIXs
         OdpUBnoYIJhOwbwexEg4pUJ0lBGM5ieCM9U/urm1V0bqJWcda4oUjUJkk9UsfV7reAo7
         g2i5Dz1m+9TjFwAgtco1D/hl1WWp9pcYFstuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=skhLfaOO9lv7TLZsn5jcW2c2pz0dmX1gkpRg+2lzHTE=;
        b=V0pF67ScigJh57BlWeXFukSyZ/AqV90DsqlwEIbIjK7PcDtQMpuYPqpWcfxmIo47W6
         lo01Z0WehZGFpC2+o/RqLoqxzOYhEu+g2vnZthiZYxxGjlYJTmzGcmmsXUoItoFGEsd/
         Lvwu4B5Gm0AUcZeFL+2xsauNWq6whYWs33h0zIhzRMEtlrV8XrEHyG8wCi2ghFgztlWS
         cnVppPtEbRWV1SaLOLmkJx2bxmL2JtsXCJrP5JJS4b4OQw5CIn/tXg0zaf4c6go7rjtP
         F+FNvo13CMZg0HCSyz24NbFvfOlOeoj3UDO1fpL2Hb+BpKY9/h7SRAL5QCYi3SUOXIq/
         Hj6A==
X-Gm-Message-State: ACgBeo08L7sNpgxt9BJA9ug/bjB2n9eicZpXfCPQ8VPe03dqzB1Uv1it
        pOdIBfQhIfUOINUheSUikjOo9JV/bjfK8xkvQZxx
X-Google-Smtp-Source: AA6agR7NM7FrEHAyOE18g3Q6533cCQQxXG4C9N4e3PGzkp86S57vj3Lkg/Qn+jVxXVp9xBCl2dKDyrMhjplQmnf1LqQ=
X-Received: by 2002:a05:6638:25d1:b0:346:c436:6974 with SMTP id
 u17-20020a05663825d100b00346c4366974mr3230504jat.308.1662592511503; Wed, 07
 Sep 2022 16:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220905141644.2468891-1-heiko@sntech.de> <CAOnJCU+SXQsho=t1vUQFiiDVU7-F0yaAH3ae4nUdYQWEyjmsjw@mail.gmail.com>
In-Reply-To: <CAOnJCU+SXQsho=t1vUQFiiDVU7-F0yaAH3ae4nUdYQWEyjmsjw@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 7 Sep 2022 16:15:00 -0700
Message-ID: <CAOnJCU+djj0eee0345hHD3ioLJcssGmwV6LiVeCQMU9H8=TcAw@mail.gmail.com>
Subject: Re: [PATCH v3] drivers/perf: riscv_pmu_sbi: add support for PMU
 variant on T-Head C9xx cores
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     anup@brainfault.org, will@kernel.org, mark.rutland@arm.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Conor.Dooley@microchip.com
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

On Wed, Sep 7, 2022 at 4:09 PM Atish Patra <atishp@atishpatra.org> wrote:
>
>
>
> On Mon, Sep 5, 2022 at 7:16 AM Heiko Stuebner <heiko@sntech.de> wrote:
>>
>> With the T-HEAD C9XX cores being designed before or during the ratification
>> to the SSCOFPMF extension, it implements functionality very similar but
>> not equal to it.
>>
>> It implements overflow handling and also some privilege-mode filtering.
>> While SSCOFPMF supports this for all modes, the C9XX only implements the
>> filtering for M-mode and S-mode but not user-mode.
>>
>> So add some adaptions to allow the C9XX to still handle
>> its PMU through the regular SBI PMU interface instead of defining new
>> interfaces or drivers.
>>
>> To work properly, this requires a matching change in SBI, though the actual
>> interface between kernel and SBI does not change.
>>
>> The main differences are a the overflow CSR and irq number.
>>
>> As the reading of the overflow-csr is in the hot-path during irq handling,
>> use an errata and alternatives to not introduce new conditionals there.
>>
>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>> ---
>> changes in v3:
>> - improve commit message (Atish, Conor)
>> - IS_ENABLED and BIT() in errata probe (Conor)
>>
>> The change depends on my cpufeature/t-head errata probe cleanup series [1].
>>
>>
>> changes in v2:
>> - use alternatives for the CSR access
>> - make the irq num selection a bit nicer
>>
>> There is of course a matching opensbi-part whose current implementation can
>> be found on [0], but as comments show, this needs some more work still.
>>
>>
>> [0] https://patchwork.ozlabs.org/project/opensbi/cover/20220817112004.745776-1-heiko@sntech.de/
>> [1] https://lore.kernel.org/all/20220905111027.2463297-1-heiko@sntech.de/
>>
>>  arch/riscv/Kconfig.erratas           | 14 ++++++++++++
>>  arch/riscv/errata/thead/errata.c     | 18 ++++++++++++++++
>>  arch/riscv/include/asm/errata_list.h | 16 +++++++++++++-
>>  drivers/perf/riscv_pmu_sbi.c         | 32 +++++++++++++++++++---------
>>  4 files changed, 69 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
>> index 6850e9389930..f1eaac4c0073 100644
>> --- a/arch/riscv/Kconfig.erratas
>> +++ b/arch/riscv/Kconfig.erratas
>> @@ -66,4 +66,18 @@ config ERRATA_THEAD_CMO
>>
>>           If you don't know what to do here, say "Y".
>>
>> +config ERRATA_THEAD_PMU
>> +       bool "Apply T-Head PMU errata"
>> +       depends on ERRATA_THEAD
>> +       depends on RISCV_PMU_SBI
>> +       default y
>> +       help
>> +         The T-Head C9xx cores implement a PMU overflow extension very
>> +         similar to the core SSCOFPMF extension.
>> +
>> +         This will apply the overflow errata to handle the non-standard
>> +         behaviour via the regular SBI PMU driver and interface.
>> +
>> +         If you don't know what to do here, say "Y".
>> +
>>  endmenu # "CPU errata selection"
>> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
>> index 902e12452821..d4b1526538ad 100644
>> --- a/arch/riscv/errata/thead/errata.c
>> +++ b/arch/riscv/errata/thead/errata.c
>> @@ -46,6 +46,21 @@ static bool errata_probe_cmo(unsigned int stage,
>>         return true;
>>  }
>>
>> +static bool errata_probe_pmu(unsigned int stage,
>> +                            unsigned long arch_id, unsigned long impid)
>> +{
>> +       if (!IS_ENABLED(CONFIG_ERRATA_THEAD_PMU))
>> +               return false;
>> +
>> +       if (arch_id != 0 || impid != 0)
>> +               return false;
>> +
>> +       if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
>> +               return false;
>> +
>> +       return true;
>> +}
>> +
>>  static u32 thead_errata_probe(unsigned int stage,
>>                               unsigned long archid, unsigned long impid)
>>  {
>> @@ -57,6 +72,9 @@ static u32 thead_errata_probe(unsigned int stage,
>>         if (errata_probe_cmo(stage, archid, impid))
>>                 cpu_req_errata |= BIT(ERRATA_THEAD_CMO);
>>
>> +       if (errata_probe_pmu(stage, archid, impid))
>> +               cpu_req_errata |= BIT(ERRATA_THEAD_PMU);
>> +
>>         return cpu_req_errata;
>>  }
>>
>> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
>> index 19a771085781..4180312d2a70 100644
>> --- a/arch/riscv/include/asm/errata_list.h
>> +++ b/arch/riscv/include/asm/errata_list.h
>> @@ -6,6 +6,7 @@
>>  #define ASM_ERRATA_LIST_H
>>
>>  #include <asm/alternative.h>
>> +#include <asm/csr.h>
>>  #include <asm/vendorid_list.h>
>>
>>  #ifdef CONFIG_ERRATA_SIFIVE
>> @@ -17,7 +18,8 @@
>>  #ifdef CONFIG_ERRATA_THEAD
>>  #define        ERRATA_THEAD_PBMT 0
>>  #define        ERRATA_THEAD_CMO 1
>> -#define        ERRATA_THEAD_NUMBER 2
>> +#define        ERRATA_THEAD_PMU 2
>> +#define        ERRATA_THEAD_NUMBER 3
>>  #endif
>>
>>  #define        CPUFEATURE_SVPBMT 0
>> @@ -142,6 +144,18 @@ asm volatile(ALTERNATIVE_2(                                                \
>>             "r"((unsigned long)(_start) + (_size))                      \
>>         : "a0")
>>
>> +#define THEAD_C9XX_RV_IRQ_PMU                  17
>> +#define THEAD_C9XX_CSR_SCOUNTEROF              0x5c5
>> +
>> +#define ALT_SBI_PMU_OVERFLOW(__ovl)                                    \
>> +asm volatile(ALTERNATIVE(                                              \
>> +       "csrr %0, " __stringify(CSR_SSCOUNTOVF),                        \
>> +       "csrr %0, " __stringify(THEAD_C9XX_CSR_SCOUNTEROF),             \
>> +               THEAD_VENDOR_ID, ERRATA_THEAD_PMU,                      \
>> +               CONFIG_ERRATA_THEAD_PMU)                                \
>> +       : "=r" (__ovl) :                                                \
>> +       : "memory")
>> +
>>  #endif /* __ASSEMBLY__ */
>>
>>  #endif
>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
>> index 6f6681bbfd36..f814d3ce5ba2 100644
>> --- a/drivers/perf/riscv_pmu_sbi.c
>> +++ b/drivers/perf/riscv_pmu_sbi.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/of.h>
>>  #include <linux/cpu_pm.h>
>>
>> +#include <asm/errata_list.h>
>>  #include <asm/sbi.h>
>>  #include <asm/hwcap.h>
>>
>> @@ -46,6 +47,8 @@ static const struct attribute_group *riscv_pmu_attr_groups[] = {
>>   * per_cpu in case of harts with different pmu counters
>>   */
>>  static union sbi_pmu_ctr_info *pmu_ctr_list;
>> +static bool riscv_pmu_use_irq;
>> +static unsigned int riscv_pmu_irq_num;
>>  static unsigned int riscv_pmu_irq;
>>
>>  struct sbi_pmu_event_data {
>> @@ -575,7 +578,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>>         fidx = find_first_bit(cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS);
>>         event = cpu_hw_evt->events[fidx];
>>         if (!event) {
>> -               csr_clear(CSR_SIP, SIP_LCOFIP);
>> +               csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
>>                 return IRQ_NONE;
>>         }
>>
>> @@ -583,13 +586,13 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>>         pmu_sbi_stop_hw_ctrs(pmu);
>>
>>         /* Overflow status register should only be read after counter are stopped */
>> -       overflow = csr_read(CSR_SSCOUNTOVF);
>> +       ALT_SBI_PMU_OVERFLOW(overflow);
>>
>>         /*
>>          * Overflow interrupt pending bit should only be cleared after stopping
>>          * all the counters to avoid any race condition.
>>          */
>> -       csr_clear(CSR_SIP, SIP_LCOFIP);
>> +       csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
>>
>>         /* No overflow bit is set */
>>         if (!overflow)
>> @@ -651,10 +654,10 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
>>         /* Stop all the counters so that they can be enabled from perf */
>>         pmu_sbi_stop_all(pmu);
>>
>> -       if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
>> +       if (riscv_pmu_use_irq) {
>>                 cpu_hw_evt->irq = riscv_pmu_irq;
>> -               csr_clear(CSR_IP, BIT(RV_IRQ_PMU));
>> -               csr_set(CSR_IE, BIT(RV_IRQ_PMU));
>> +               csr_clear(CSR_IP, BIT(riscv_pmu_irq_num));
>> +               csr_set(CSR_IE, BIT(riscv_pmu_irq_num));
>>                 enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
>>         }
>>
>> @@ -663,9 +666,9 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
>>
>>  static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node *node)
>>  {
>> -       if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
>> +       if (riscv_pmu_use_irq) {
>>                 disable_percpu_irq(riscv_pmu_irq);
>> -               csr_clear(CSR_IE, BIT(RV_IRQ_PMU));
>> +               csr_clear(CSR_IE, BIT(riscv_pmu_irq_num));
>>         }
>>
>>         /* Disable all counters access for user mode now */
>> @@ -681,7 +684,16 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
>>         struct device_node *cpu, *child;
>>         struct irq_domain *domain = NULL;
>>
>> -       if (!riscv_isa_extension_available(NULL, SSCOFPMF))
>> +       if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
>> +               riscv_pmu_irq_num = RV_IRQ_PMU;
>> +               riscv_pmu_use_irq = true;
>> +       } else if (sbi_get_mvendorid() == THEAD_VENDOR_ID &&
>> +                  sbi_get_marchid() == 0 && sbi_get_mimpid() == 0) {
>> +               riscv_pmu_irq_num = THEAD_C9XX_RV_IRQ_PMU;
>> +               riscv_pmu_use_irq = true;
>> +       }
>> +
>
>

Resending my response as gmail automatically switched compose format
to HTML for some reason.
Apologies for the spam.

We already have all the vendorid/marchid/mimipid information available
from the errata framework.
Can we just get these from errata instead of making another 3 SBI calls ?

Another option is that Anup's /proc/cpuinfo patch also makes the same
SBI calls. Maybe cache these three
 information in the SBI layer so that all other arch code can invoke that.

 I also think this else check should be part of the config ERRATA_THEAD_PMU.

>
>>
>> +       if (!riscv_pmu_use_irq)
>>                 return -EOPNOTSUPP;
>>
>>         for_each_of_cpu_node(cpu) {
>> @@ -703,7 +715,7 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
>>                 return -ENODEV;
>>         }
>>
>> -       riscv_pmu_irq = irq_create_mapping(domain, RV_IRQ_PMU);
>> +       riscv_pmu_irq = irq_create_mapping(domain, riscv_pmu_irq_num);
>>         if (!riscv_pmu_irq) {
>>                 pr_err("Failed to map PMU interrupt for node\n");
>>                 return -ENODEV;
>> --
>> 2.35.1
>>
>
>
> --
> Regards,
> Atish



-- 
Regards,
Atish
