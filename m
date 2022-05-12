Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4035250D6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355694AbiELPFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355688AbiELPFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:05:05 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B551625509F;
        Thu, 12 May 2022 08:05:02 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id r1so10277730ybo.7;
        Thu, 12 May 2022 08:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3m1cLce0U7sWwoPRoIzSnGNl6tg1bkDp1pFDNxtbcTk=;
        b=Snwyg6vameeadNIw6m8ow8BvTqvyLwSzJ4Mn6PXHeIQjvszUQKGNXFGowc7D4lBeTg
         rPdvZN5ZCZNtj/Jsiv3kCNarNFebfoxrKFgmP6pk24jGc/74+D4zNO1w/Jh/YL+GovgH
         ByXTgB+DRZq5ehwtIDhIYEyJHYJyy+EjgsgfduS/m2RBcgAP3Fp4A9eI0ul3TeLKFMqD
         phKbXy5V1vj+CzL7Uv2GsEL6grSwd8EUV4ipcwkbtAmMJz4h9fHogtw3s9XhtSTn+KFV
         /flP74kyCUUkVfR44X+VD5F5UsKc3K+Sh1SdQNuOjEiNQrjJ4R1l01/1RfLxkEfAQ/Sv
         9W+g==
X-Gm-Message-State: AOAM530tUmSgd5EY+DfEBYeJrwT/qm/N4G9rSZmEeS1Rf0n1bsioFBTj
        XUws+h/w30xFmi0GJzyFwDjGTgVeua70rLlDKgehABOZ
X-Google-Smtp-Source: ABdhPJyVyp4by0cL7EufgP8w7GRukzsRyDSHhJZOpF+poV1MdPj+Aq7HO3eT2LyRF32MRAnkZMgy6LoFj0Yeo/byNy0=
X-Received: by 2002:a25:d288:0:b0:64b:4bb5:32be with SMTP id
 j130-20020a25d288000000b0064b4bb532bemr173435ybg.633.1652367901673; Thu, 12
 May 2022 08:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220511134559.1466925-1-pierre.gondois@arm.com>
 <20220511134559.1466925-3-pierre.gondois@arm.com> <20220511143001.ewba7sovabinnajz@bogus>
In-Reply-To: <20220511143001.ewba7sovabinnajz@bogus>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 May 2022 17:04:50 +0200
Message-ID: <CAJZ5v0i5h+JYd=jXsgfcuA8_XnUV0RenqFZ0ALhCVt1eZtKnrQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] ACPI: CPPC: Assume no transition latency if no PCCT
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ionela Voinescu <Ionela.Voinescu@arm.com>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
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

On Wed, May 11, 2022 at 4:30 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, May 11, 2022 at 03:45:57PM +0200, Pierre Gondois wrote:
> > From: Pierre Gondois <Pierre.Gondois@arm.com>
> >
> > The transition_delay_us (struct cpufreq_policy) is currently defined
> > as:
> >   Preferred average time interval between consecutive invocations of
> >   the driver to set the frequency for this policy.  To be set by the
> >   scaling driver (0, which is the default, means no preference).
> > The transition_latency represents the amount of time necessary for a
> > CPU to change its frequency.
> >
> > A PCCT table advertises mutliple values:
> > - pcc_nominal: Expected latency to process a command, in microseconds
> > - pcc_mpar: The maximum number of periodic requests that the subspace
> >   channel can support, reported in commands per minute. 0 indicates no
> >   limitation.
> > - pcc_mrtt: The minimum amount of time that OSPM must wait after the
> >   completion of a command before issuing the next command,
> >   in microseconds.
> > cppc_get_transition_latency() allows to get the max of them.
> >
> > commit d4f3388afd48 ("cpufreq / CPPC: Set platform specific
> > transition_delay_us") allows to select transition_delay_us based on
> > the platform, and fallbacks to cppc_get_transition_latency()
> > otherwise.
> >
> > If _CPC objects are not using PCC channels (no PPCT table), the
> > transition_delay_us is set to CPUFREQ_ETERNAL, leading to really long
> > periods between frequency updates (~4s).
> >
> > If the desired_reg, where performance requests are written, is in
> > SystemMemory or SystemIo ACPI address space, there is no delay
> > in requests. So return 0 instead of CPUFREQ_ETERNAL, leading to
> > transition_delay_us being set to LATENCY_MULTIPLIER us (1000 us).
> >
> > This patch also adds two macros to check the address spaces.
> >
> > Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> > ---
> >  drivers/acpi/cppc_acpi.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > index 6f09fe011544..cc932ec1b613 100644
> > --- a/drivers/acpi/cppc_acpi.c
> > +++ b/drivers/acpi/cppc_acpi.c
> > @@ -100,6 +100,16 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
> >                               (cpc)->cpc_entry.reg.space_id ==        \
> >                               ACPI_ADR_SPACE_PLATFORM_COMM)
> >
> > +/* Check if a CPC register is in SystemMemory */
> > +#define CPC_IN_SM(cpc) ((cpc)->type == ACPI_TYPE_BUFFER &&           \
> > +                             (cpc)->cpc_entry.reg.space_id ==        \
> > +                             ACPI_ADR_SPACE_SYSTEM_MEMORY)
> > +
>
> Again my taste or preference: s/SM/SYS_MEM or SYSTEM_MEM

SYSTEM_MEMORY even.

>
> > +/* Check if a CPC register is in SystemIo */
> > +#define CPC_IN_SIO(cpc) ((cpc)->type == ACPI_TYPE_BUFFER &&          \
> > +                             (cpc)->cpc_entry.reg.space_id ==        \
> > +                             ACPI_ADR_SPACE_SYSTEM_IO)
> > +
>
> Ditto, s/SM/SYS_IO or SYSTEM_IO
>
> I need not refer back to the macro when reading the code. SM/SIO is too
> short and makes it hard to infer from the name in general.

Right.

> >  /* Evaluates to True if reg is a NULL register descriptor */
> >  #define IS_NULL_REG(reg) ((reg)->space_id ==  ACPI_ADR_SPACE_SYSTEM_MEMORY && \
> >                               (reg)->address == 0 &&                  \
> > @@ -1456,6 +1466,9 @@ EXPORT_SYMBOL_GPL(cppc_set_perf);
> >   * transition latency for performance change requests. The closest we have
> >   * is the timing information from the PCCT tables which provides the info
> >   * on the number and frequency of PCC commands the platform can handle.
> > + *
> > + * If desired_reg is in the SystemMemory or SystemIo ACPI address space,
> > + * then assume there is no latency.
> >   */
> >  unsigned int cppc_get_transition_latency(int cpu_num)
> >  {
> > @@ -1481,7 +1494,9 @@ unsigned int cppc_get_transition_latency(int cpu_num)
> >               return CPUFREQ_ETERNAL;
> >
> >       desired_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
> > -     if (!CPC_IN_PCC(desired_reg))
> > +     if (CPC_IN_SM(desired_reg) || CPC_IN_SIO(desired_reg))
> > +             return 0;
> > +     else if (!CPC_IN_PCC(desired_reg))
> >               return CPUFREQ_ETERNAL;
