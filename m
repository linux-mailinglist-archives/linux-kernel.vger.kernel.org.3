Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01D852CB3F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 06:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbiESEm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 00:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiESEmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 00:42:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0551145F
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 21:42:53 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h5so4251860wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 21:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HogKyBwKgXkNm/0OXi7aXP5Km3lZ0CnNjy/LBYSuCpo=;
        b=fwy73yGliuV4DSO44DjeRkcoAiOvdAbWKYIaMeRa/rSK7BGBOHy5d4bgVlPw0/ceNo
         voxf6D2HE2TdUn22Mfgqpt3H3JBcaY1Kc7zXz9EdI/OLmmHCIaGJhu6xKcEYlDDBD+Yf
         u8Uu3+3OnZABk4o2Qc73CLxQcJBwd7LukDliyUIeznf/2YNbN/46/KKeosoJUK4IzV3f
         6J8Nb3uV1xk5xil99cSnFYIzNRTGreHHpxxv+N5AuezUfifhclmQPzWNRKtQ034nHZu7
         OmWXt3BKZp31oFI8IQxKbYxzxztPN0SbsF2y2rJFqLc732zEtYVa7q62m27gzFcd4JgV
         X+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HogKyBwKgXkNm/0OXi7aXP5Km3lZ0CnNjy/LBYSuCpo=;
        b=mlQi+MJMoswPlsgUKE7XCr+IP1ODdfFdiLlZnYlbRsIROgcXw1AUYN3c6e7l3yAefo
         DjZX3Cm87Q1k1x412BAxR071KUa8xo1LpcIWWZasH1Z+m0QxkFjxYTEDm1Q5v4eW9cxK
         PRH/cPFW0SkneNA2p15n6GqQMyysAQrUJvLcMwxcKjOHYMgZ5L1qGAiLwTd8A4nY/FFe
         mFFdG8NMI30adIDHENQGBMvMvOyOnwq3EB057TX+tTgAdbcSXyg8wZlKCFA7J/FNzQpX
         mZYUdPptN/sNW2yGBuVaqzfDI6M39x1g3DfCnWGalmeTuc0YVnJBEy08h9jJywreItqm
         +pLA==
X-Gm-Message-State: AOAM533akQKuL9WTnxVDg7Rk6VLtWAcGLnSAAbj+dw0pyxCX212VMOXH
        EoZJ0+tG419d0bF4swWNDSzy8ooaefyiY9U+FXsFdrVGtb0l2A==
X-Google-Smtp-Source: ABdhPJys+AN+D8dOG18/rDPFp4tLonyGq1+XeOFmGXVTjW0/9Bt80fofcMSxGa8n5+YODwTb0XxqxNEC++MDmx5pmMs=
X-Received: by 2002:adf:d1e9:0:b0:20c:6c76:14d5 with SMTP id
 g9-20020adfd1e9000000b0020c6c7614d5mr2241302wrd.375.1652935371776; Wed, 18
 May 2022 21:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220518085502.6914-1-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20220518085502.6914-1-atrajeev@linux.vnet.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 18 May 2022 21:42:39 -0700
Message-ID: <CAP-5=fWN3Sgyp_hTyYvDrLrnr-7dj6ozERn0tDm5MrU2SEJ2Fg@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] powerpc/perf: Add support for caps under sysfs in powerpc
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     acme@kernel.org, jolsa@kernel.org, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com,
        rnsastry@linux.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 1:55 AM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
> Add caps support under "/sys/bus/event_source/devices/<pmu>/"
> for powerpc. This directory can be used to expose some of the
> specific features that powerpc PMU supports to the user.
> Example: pmu_name. The name of PMU registered will depend on
> platform, say power9 or power10 or it could be Generic Compat
> PMU.
>
> Currently the only way to know which is the registered
> PMU is from the dmesg logs. But clearing the dmesg will make it
> difficult to know exact PMU backend used. And even extracting
> from dmesg will be complicated, as we need  to parse the dmesg
> logs and add filters for pmu name. Whereas by exposing it via
> caps will make it easy as we just need to directly read it from
> the sysfs.

For ARM and x86 in the perf tool this is normally done through a cpuid
like function, is there a reason to differ on Power?

Thanks,
Ian

> Add a caps directory to /sys/bus/event_source/devices/cpu/
> for power8, power9, power10 and generic compat PMU in respective
> PMU driver code. Update the pmu_name file under caps folder
> in core-book3s using "attr_update".
>
> The information exposed currently:
>  - pmu_name : Underlying PMU name from the driver
>
> Example result with power9 pmu:
>
>  # ls /sys/bus/event_source/devices/cpu/caps
> pmu_name
>
>  # cat /sys/bus/event_source/devices/cpu/caps/pmu_name
> POWER9
>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
> Changelog:
>  v1 -> v2:
>  Move the show function as generic in core-book3s
>  and update show function using sysfs_emit and ppmu->name
>  Added Documention for this ABI in patch 2.
>  Notes: The caps directory is implemented in PMU for other
>  architectures already. Reference commit for x86:
>  commit b00233b53065 ("perf/x86: Export some PMU attributes in caps/ directory")
>
>  arch/powerpc/perf/core-book3s.c        | 31 ++++++++++++++++++++++++++
>  arch/powerpc/perf/generic-compat-pmu.c | 10 +++++++++
>  arch/powerpc/perf/power10-pmu.c        | 10 +++++++++
>  arch/powerpc/perf/power8-pmu.c         | 10 +++++++++
>  arch/powerpc/perf/power9-pmu.c         | 10 +++++++++
>  5 files changed, 71 insertions(+)
>
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index b5b42cf0a703..a208f502a80b 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -2488,6 +2488,33 @@ static int power_pmu_prepare_cpu(unsigned int cpu)
>         return 0;
>  }
>
> +static ssize_t pmu_name_show(struct device *cdev,
> +               struct device_attribute *attr,
> +               char *buf)
> +{
> +       if (ppmu)
> +               return sysfs_emit(buf, "%s\n", ppmu->name);
> +
> +       return 0;
> +}
> +
> +static DEVICE_ATTR_RO(pmu_name);
> +
> +static struct attribute *pmu_caps_attrs[] = {
> +       &dev_attr_pmu_name.attr,
> +       NULL
> +};
> +
> +static const struct attribute_group pmu_caps_group = {
> +       .name  = "caps",
> +       .attrs = pmu_caps_attrs,
> +};
> +
> +static const struct attribute_group *pmu_caps_groups[] = {
> +       &pmu_caps_group,
> +       NULL,
> +};
> +
>  int __init register_power_pmu(struct power_pmu *pmu)
>  {
>         if (ppmu)
> @@ -2498,6 +2525,10 @@ int __init register_power_pmu(struct power_pmu *pmu)
>                 pmu->name);
>
>         power_pmu.attr_groups = ppmu->attr_groups;
> +
> +       if (ppmu->flags & PPMU_ARCH_207S)
> +               power_pmu.attr_update = pmu_caps_groups;
> +
>         power_pmu.capabilities |= (ppmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS);
>
>  #ifdef MSR_HV
> diff --git a/arch/powerpc/perf/generic-compat-pmu.c b/arch/powerpc/perf/generic-compat-pmu.c
> index f3db88aee4dd..817c69863038 100644
> --- a/arch/powerpc/perf/generic-compat-pmu.c
> +++ b/arch/powerpc/perf/generic-compat-pmu.c
> @@ -151,9 +151,19 @@ static const struct attribute_group generic_compat_pmu_format_group = {
>         .attrs = generic_compat_pmu_format_attr,
>  };
>
> +static struct attribute *generic_compat_pmu_caps_attrs[] = {
> +       NULL
> +};
> +
> +static struct attribute_group generic_compat_pmu_caps_group = {
> +       .name  = "caps",
> +       .attrs = generic_compat_pmu_caps_attrs,
> +};
> +
>  static const struct attribute_group *generic_compat_pmu_attr_groups[] = {
>         &generic_compat_pmu_format_group,
>         &generic_compat_pmu_events_group,
> +       &generic_compat_pmu_caps_group,
>         NULL,
>  };
>
> diff --git a/arch/powerpc/perf/power10-pmu.c b/arch/powerpc/perf/power10-pmu.c
> index c6d51e7093cf..d1adcd9f52e2 100644
> --- a/arch/powerpc/perf/power10-pmu.c
> +++ b/arch/powerpc/perf/power10-pmu.c
> @@ -258,6 +258,15 @@ static const struct attribute_group power10_pmu_format_group = {
>         .attrs = power10_pmu_format_attr,
>  };
>
> +static struct attribute *power10_pmu_caps_attrs[] = {
> +       NULL
> +};
> +
> +static struct attribute_group power10_pmu_caps_group = {
> +       .name  = "caps",
> +       .attrs = power10_pmu_caps_attrs,
> +};
> +
>  static const struct attribute_group *power10_pmu_attr_groups_dd1[] = {
>         &power10_pmu_format_group,
>         &power10_pmu_events_group_dd1,
> @@ -267,6 +276,7 @@ static const struct attribute_group *power10_pmu_attr_groups_dd1[] = {
>  static const struct attribute_group *power10_pmu_attr_groups[] = {
>         &power10_pmu_format_group,
>         &power10_pmu_events_group,
> +       &power10_pmu_caps_group,
>         NULL,
>  };
>
> diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
> index e37b1e714d2b..2518f5375d4a 100644
> --- a/arch/powerpc/perf/power8-pmu.c
> +++ b/arch/powerpc/perf/power8-pmu.c
> @@ -187,9 +187,19 @@ static const struct attribute_group power8_pmu_events_group = {
>         .attrs = power8_events_attr,
>  };
>
> +static struct attribute *power8_pmu_caps_attrs[] = {
> +       NULL
> +};
> +
> +static struct attribute_group power8_pmu_caps_group = {
> +       .name  = "caps",
> +       .attrs = power8_pmu_caps_attrs,
> +};
> +
>  static const struct attribute_group *power8_pmu_attr_groups[] = {
>         &isa207_pmu_format_group,
>         &power8_pmu_events_group,
> +       &power8_pmu_caps_group,
>         NULL,
>  };
>
> diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
> index c393e837648e..5c654ce1a417 100644
> --- a/arch/powerpc/perf/power9-pmu.c
> +++ b/arch/powerpc/perf/power9-pmu.c
> @@ -258,9 +258,19 @@ static const struct attribute_group power9_pmu_format_group = {
>         .attrs = power9_pmu_format_attr,
>  };
>
> +static struct attribute *power9_pmu_caps_attrs[] = {
> +       NULL
> +};
> +
> +static struct attribute_group power9_pmu_caps_group = {
> +       .name  = "caps",
> +       .attrs = power9_pmu_caps_attrs,
> +};
> +
>  static const struct attribute_group *power9_pmu_attr_groups[] = {
>         &power9_pmu_format_group,
>         &power9_pmu_events_group,
> +       &power9_pmu_caps_group,
>         NULL,
>  };
>
> --
> 2.31.1
>
