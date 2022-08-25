Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539DD5A0FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239713AbiHYL7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241145AbiHYL7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:59:08 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88797A925C;
        Thu, 25 Aug 2022 04:59:07 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-324ec5a9e97so533969597b3.7;
        Thu, 25 Aug 2022 04:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lai10eZsh43np55q3ZiidW+x4vXFnsDemizIRCSUTyY=;
        b=njcHgAR2xcbDyd+nzzMD6Y0IGaanesowxkyNOPx1hDUzfNbUGDlqhkwEkCwyvm4GPN
         u3M8GlQ/PurKMFu9IL63DyEDO8DXe2jC6WIJbXcjdHdcRJodBT4glxuTVyA6nL1y1JLQ
         kkZwvZPq56FC0Ct2e8rE/DnGc5n0owd4TEI1agDv3WRPVH1p6r/I7kcspkCMJM+MAHVb
         cuIozhuZXfVAkEflXGw/KFsPcvAyZLLkwsiS6g+TwVVhPYl8qJnwwSGDZNDw/NpBuedx
         cSQoYHH5Q9kcuPiAYKkhPxQ0rjCgxTcepGIq6aIu3moKRkaDBQQsw1IV919Xqar8KTbj
         U1ww==
X-Gm-Message-State: ACgBeo0rYWtU+TlewiwalOPqVpkAC18ajJnZ3uxSpeV43NWYTL4kZmSF
        XQtmKG5JL1ScMnbf1BS+gvNqKC/aN/rGR6rKya0=
X-Google-Smtp-Source: AA6agR4UXWLSTs4CsFhfLCv2tv2kzmuicrETB8F74Kr8Vw9xPPaCEhnR6oF0ZQD0ynEVhkjhWZQfnf89qMqWqEj8vQs=
X-Received: by 2002:a25:c204:0:b0:692:72b9:a778 with SMTP id
 s4-20020a25c204000000b0069272b9a778mr2916207ybf.81.1661428746734; Thu, 25 Aug
 2022 04:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220814164421.330891-1-Perry.Yuan@amd.com>
In-Reply-To: <20220814164421.330891-1-Perry.Yuan@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Aug 2022 13:58:55 +0200
Message-ID: <CAJZ5v0gdHvLLPrvj7cq2ki6xDH=X6qpXBfyVTFNa5wNqY7Sh5g@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: amd_pstate: Fix initial highest_perf value
To:     Perry Yuan <Perry.Yuan@amd.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Deepak Sharma <Deepak.Sharma@amd.com>,
        Mario Limonciello <Mario.Limonciello@amd.com>,
        Nathan Fontenot <Nathan.Fontenot@amd.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>, Shimmer.Huang@amd.com,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 6:57 PM Perry Yuan <Perry.Yuan@amd.com> wrote:
>
> To avoid some new AMD processors use wrong highest perf when amd pstate
> driver loaded, this fix will query the highest perf from MSR register
> MSR_AMD_CPPC_CAP1 and cppc_acpi interface firstly, then compare with the
> highest perf value got by calling amd_get_highest_perf() function.
>
> The lower value will be the correct highest perf we need to use.
> Otherwise the CPU max MHz will be incorrect if the
> amd_get_highest_perf() did not cover the new process family and model ID.
>
> Like this lscpu info, the max frequency is incorrect.
>
> Vendor ID:               AuthenticAMD
>     Socket(s):           1
>     Stepping:            2
>     CPU max MHz:         5410.0000
>     CPU min MHz:         400.0000
>     BogoMIPS:            5600.54
>
> Fixes: 3743d55b289c2 (x86, sched: Fix the AMD CPPC maximum performance value on certain AMD Ryzen generations)
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

This needs to be reviewed by the AMD P-state driver maintainer.

> ---
>  drivers/cpufreq/amd-pstate.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9f4375f7ab46..f778ab37e436 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -354,6 +354,7 @@ static inline int amd_pstate_enable(bool enable)
>  static int pstate_init_perf(struct amd_cpudata *cpudata)
>  {
>         u64 cap1;
> +       u32 highest_perf;
>
>         int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
>                                      &cap1);
> @@ -365,7 +366,11 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
>          *
>          * CPPC entry doesn't indicate the highest performance in some ASICs.
>          */
> -       WRITE_ONCE(cpudata->highest_perf, amd_get_highest_perf());
> +       highest_perf = amd_get_highest_perf();
> +       if (highest_perf > AMD_CPPC_HIGHEST_PERF(cap1))
> +               highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
> +
> +       WRITE_ONCE(cpudata->highest_perf, highest_perf);
>
>         WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
>         WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
> @@ -377,12 +382,17 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
>  static int cppc_init_perf(struct amd_cpudata *cpudata)
>  {
>         struct cppc_perf_caps cppc_perf;
> +       u32 highest_perf;
>
>         int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>         if (ret)
>                 return ret;
>
> -       WRITE_ONCE(cpudata->highest_perf, amd_get_highest_perf());
> +       highest_perf = amd_get_highest_perf();
> +       if (highest_perf > cppc_perf.highest_perf)
> +               highest_perf = cppc_perf.nominal_perf;
> +
> +       WRITE_ONCE(cpudata->highest_perf, highest_perf);
>
>         WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
>         WRITE_ONCE(cpudata->lowest_nonlinear_perf,
> --
> 2.34.1
>
