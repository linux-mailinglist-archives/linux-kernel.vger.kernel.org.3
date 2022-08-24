Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D8D59FB33
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238170AbiHXNWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbiHXNWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:22:18 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79AE65838;
        Wed, 24 Aug 2022 06:22:16 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-335624d1e26so460202937b3.4;
        Wed, 24 Aug 2022 06:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tj5/16yhAX2zl12togbMkLyLKsw/5w7DUaktiPD9h7o=;
        b=Sh5lISq1nunvBUNxXeYs8/AHla7VsYwviHmAlfTVefSeCumEf+RlGUP8zvY+xSTUIo
         J/eL/t2fDTSGDRzTTnOKVxUlBRpR4GJDxbSWJ9QuxlJ6IWZeybHnRH8UthG0UkeZOcpy
         crl6/9f+n7LEEP3xGNz3hZykVCoWMbOcAaf+hPnjuZNH9Thav7bf4fvu0SuzxDowGWMB
         qf2KaGP+AxLiR3aoiseFeKCQ0ZJLVN1Hjk3fVq8GESIpgimfkDlGQUjQUvic9jPZN7uW
         yVWU8b8iQwPH3i/yH7j2HuGeokhMN+1zYhk+Y8xCRG+oW+IDqm2rnZvqxMEqUeqidsiJ
         4ssA==
X-Gm-Message-State: ACgBeo1pKNQCyU3+84YonFMQ6Nqohb764S6yotfbwwYIgdCls7oupJJg
        zwXOlkL5FfXp950mrJjDVkcKMwA7nhBGM8DfwJs=
X-Google-Smtp-Source: AA6agR7F6dL9fEItbSnwYeWeFsGP6YbP4X9nk9/auwvZtJqzztAZP+x7XYZ9ViIYo8p2bTePdHW2+36bkc3F46zQok8=
X-Received: by 2002:a81:4850:0:b0:33c:922b:5739 with SMTP id
 v77-20020a814850000000b0033c922b5739mr13285502ywa.515.1661347336143; Wed, 24
 Aug 2022 06:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220818211619.4193362-1-jeremy.linton@arm.com>
 <20220818211619.4193362-2-jeremy.linton@arm.com> <CAJZ5v0h7s0WnyBtwuQbTZXwq+jmYDF74gjc9-c-=Krt23KgF1w@mail.gmail.com>
 <cbbc3156-507c-9b88-06b9-c1e7bda50c32@arm.com>
In-Reply-To: <cbbc3156-507c-9b88-06b9-c1e7bda50c32@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Aug 2022 15:22:04 +0200
Message-ID: <CAJZ5v0jXxUmCRbaWF3B7NmhMcOhgH_MgKbrsttF=RccJFjPaoQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ACPI: CPPC: Disable FIE if registers in PCC regions
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        Punit Agrawal <punit.agrawal@bytedance.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 8:46 PM Jeremy Linton <jeremy.linton@arm.com> wrote:
>
> Hi,
>
> On 8/23/22 12:10, Rafael J. Wysocki wrote:
> > On Thu, Aug 18, 2022 at 11:24 PM Jeremy Linton <jeremy.linton@arm.com> wrote:
> >>
> >> PCC regions utilize a mailbox to set/retrieve register values used by
> >> the CPPC code. This is fine as long as the operations are
> >> infrequent. With the FIE code enabled though the overhead can range
> >> from 2-11% of system CPU overhead (ex: as measured by top) on Arm
> >> based machines.
> >>
> >> So, before enabling FIE assure none of the registers used by
> >> cppc_get_perf_ctrs() are in the PCC region. Furthermore lets also
> >> enable a module parameter which can also disable it at boot or module
> >> reload.
> >>
> >> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> >> ---
> >>   drivers/acpi/cppc_acpi.c       | 41 ++++++++++++++++++++++++++++++++++
> >>   drivers/cpufreq/cppc_cpufreq.c | 31 +++++++++++++++++++++----
> >>   include/acpi/cppc_acpi.h       |  5 +++++
> >>   3 files changed, 73 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> >> index 1e15a9f25ae9..c840bf606b30 100644
> >> --- a/drivers/acpi/cppc_acpi.c
> >> +++ b/drivers/acpi/cppc_acpi.c
> >> @@ -1240,6 +1240,47 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
> >>   }
> >>   EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
> >>
> >> +/**
> >> + * cppc_perf_ctrs_in_pcc - Check if any perf counters are in a PCC region.
> >> + *
> >> + * CPPC has flexibility about how counters describing CPU perf are delivered.
> >
> > "CPU performance counters are accessed"
>
> Sure,
>
> >
> >
> >> + * One of the choices is PCC regions, which can have a high access latency. This
> >> + * routine allows callers of cppc_get_perf_ctrs() to know this ahead of time.
> >> + *
> >> + * Return: true if any of the counters are in PCC regions, false otherwise
> >> + */
> >> +bool cppc_perf_ctrs_in_pcc(void)
> >> +{
> >> +       int cpu;
> >> +
> >> +       for_each_present_cpu(cpu) {
> >> +               struct cpc_register_resource *ref_perf_reg;
> >> +               struct cpc_desc *cpc_desc;
> >> +
> >> +               cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> >> +
> >> +               if (CPC_IN_PCC(&cpc_desc->cpc_regs[DELIVERED_CTR]) ||
> >> +                   CPC_IN_PCC(&cpc_desc->cpc_regs[REFERENCE_CTR]) ||
> >> +                   CPC_IN_PCC(&cpc_desc->cpc_regs[CTR_WRAP_TIME]))
> >> +                       return true;
> >> +
> >> +
> >> +               ref_perf_reg = &cpc_desc->cpc_regs[REFERENCE_PERF];
> >> +
> >> +               /*
> >> +                * If reference perf register is not supported then we should
> >> +                * use the nominal perf value
> >> +                */
> >> +               if (!CPC_SUPPORTED(ref_perf_reg))
> >> +                       ref_perf_reg = &cpc_desc->cpc_regs[NOMINAL_PERF];
> >> +
> >> +               if (CPC_IN_PCC(ref_perf_reg))
> >> +                       return true;
> >> +       }
> >> +       return false;
> >> +}
> >> +EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc);
> >> +
> >>   /**
> >>    * cppc_get_perf_ctrs - Read a CPU's performance feedback counters.
> >>    * @cpunum: CPU from which to read counters.
> >> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> >> index 24eaf0ec344d..32fcb0bf74a4 100644
> >> --- a/drivers/cpufreq/cppc_cpufreq.c
> >> +++ b/drivers/cpufreq/cppc_cpufreq.c
> >> @@ -63,7 +63,15 @@ static struct cppc_workaround_oem_info wa_info[] = {
> >>
> >>   static struct cpufreq_driver cppc_cpufreq_driver;
> >>
> >> +static enum {
> >> +       FIE_UNSET = -1,
> >> +       FIE_ENABLED,
> >> +       FIE_DISABLED
> >> +} fie_disabled = FIE_UNSET;
> >> +
> >>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
> >> +module_param(fie_disabled, int, 0444);
> >> +MODULE_PARM_DESC(fie_disabled, "Disable Frequency Invariance Engine (FIE)");
> >>
> >>   /* Frequency invariance support */
> >>   struct cppc_freq_invariance {
> >> @@ -158,7 +166,7 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
> >>          struct cppc_freq_invariance *cppc_fi;
> >>          int cpu, ret;
> >>
> >> -       if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> >> +       if (fie_disabled)
> >>                  return;
> >>
> >>          for_each_cpu(cpu, policy->cpus) {
> >> @@ -199,7 +207,7 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
> >>          struct cppc_freq_invariance *cppc_fi;
> >>          int cpu;
> >>
> >> -       if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> >> +       if (fie_disabled)
> >>                  return;
> >>
> >>          /* policy->cpus will be empty here, use related_cpus instead */
> >> @@ -229,7 +237,21 @@ static void __init cppc_freq_invariance_init(void)
> >>          };
> >>          int ret;
> >>
> >> -       if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> >> +       switch (fie_disabled) {
> >> +       /* honor user request */
> >> +       case FIE_DISABLED:
> >> +       case FIE_ENABLED:
> >> +               break;
> >> +       case FIE_UNSET:
> >> +       default:
> >
> > Would be more straightforward to do
> >
> > if (fie_disabled == FIE_UNSET) {
> >
> > here.
>
> Right, but then it wouldn't catch the other billion+ values that are the
> result of not being able to export a limit (AFAIK) on the module
> parameter. I could use an if:

Hmm.

I've missed the module_param() part.

It doesn't even make sense to use enum for the variable type in that case.

Also you can always do

if (fie_disabled < 0) {
...
}

> if !((fie_disabled == FIE_DISABLE) || (fie_disabled == FIE_ENABLED)) {
>
> }
>
>
> if that is preferable. I thought the case with the explict default:
> though made it clearer that it was treating all those other values as unset.
>
> >
> >> +               fie_disabled = FIE_ENABLED;
> >> +               if (cppc_perf_ctrs_in_pcc()) {
> >> +                       pr_info("FIE not enabled on systems with registers in PCC\n");
> >> +                       fie_disabled = FIE_DISABLED;
> >> +               }
> >> +               break;
> >> +       }
> >> +       if (fie_disabled)
> >>                  return;
> >>
> >>          kworker_fie = kthread_create_worker(0, "cppc_fie");
> >> @@ -247,7 +269,7 @@ static void __init cppc_freq_invariance_init(void)
> >>
> >>   static void cppc_freq_invariance_exit(void)
> >>   {
> >> -       if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> >> +       if (fie_disabled)
> >>                  return;
> >>
> >>          kthread_destroy_worker(kworker_fie);
> >> @@ -936,6 +958,7 @@ static void cppc_check_hisi_workaround(void)
> >>                      wa_info[i].oem_revision == tbl->oem_revision) {
> >>                          /* Overwrite the get() callback */
> >>                          cppc_cpufreq_driver.get = hisi_cppc_cpufreq_get_rate;
> >> +                       fie_disabled = FIE_DISABLED;
> >>                          break;
> >>                  }
> >>          }
> >> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> >> index f73d357ecdf5..c5614444031f 100644
> >> --- a/include/acpi/cppc_acpi.h
> >> +++ b/include/acpi/cppc_acpi.h
> >> @@ -140,6 +140,7 @@ extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
> >>   extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
> >>   extern int cppc_set_enable(int cpu, bool enable);
> >>   extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
> >> +extern bool cppc_perf_ctrs_in_pcc(void);
> >>   extern bool acpi_cpc_valid(void);
> >>   extern bool cppc_allow_fast_switch(void);
> >>   extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data);
> >> @@ -173,6 +174,10 @@ static inline int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps)
> >>   {
> >>          return -ENOTSUPP;
> >>   }
> >> +static inline bool cppc_perf_ctrs_in_pcc(void)
> >> +{
> >> +       return false;
> >> +}
> >>   static inline bool acpi_cpc_valid(void)
> >>   {
> >>          return false;
> >> --
> >
> > Apart from the above it looks fine to me, but I would like to get an
> > ACK from Viresh on the second patch.
> >
> > Thanks!
>
> Thanks for looking at this.
>
>
