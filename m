Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6184DB7D2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 19:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350920AbiCPSRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 14:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237715AbiCPSRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 14:17:30 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A684D622;
        Wed, 16 Mar 2022 11:16:15 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2e59939b862so32783857b3.10;
        Wed, 16 Mar 2022 11:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h3RBLpBbAryPqG6TuJAla1nVu9jViIKaNxDEE5urMbw=;
        b=CwVuvpDYGj3oW3UKb8V5GcaTMh2BTFiwTWxfWbGYfY8RkcsxUhd1HavDOb1r2MsyYO
         qZtoH2+umYYi/vIkyVT0G6WNcB/RkPm78M2aBVh7RC75UvhcOH5RUpLTBpxRM/ziugry
         q0zML6pKTLmmlXUHK3BDwm2mxvJtjG1Y+B4C0+fEumDCsYjcTmFIwRsvLOPV+BkWsQvP
         IBFNMEhAruNJKs4TlvUNcUKpayTKrWv6s3WsPliBafoWgMq2vhNdPxDQ4nDrh9wfEwJu
         M/L4B1thRAXtxVhpvusmUPW35ZsyZI3EkLu1ne3yfm9XFr5JLwmgCWue1iBwfD/UPI36
         vYcA==
X-Gm-Message-State: AOAM530lVJa1JbuJXHEvDVVOYz5IXJQw5+T6lq3LeBRbWXFS7mF6/7JU
        FSJTSY4naUbQ/Du11wyaci5QlXfcaq9maYzr9bg=
X-Google-Smtp-Source: ABdhPJzguP0ZdMTGW0S66n7AWLvsSCvC3k3Mm4FkLi+eluMHkzuCF4DOkF+CM0A9/LVaoIA1P6c6b2aI/X8+LVTemRY=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr1500029ywb.326.1647454575078; Wed, 16
 Mar 2022 11:16:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220310224223.684007-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20220310224223.684007-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Mar 2022 19:16:04 +0100
Message-ID: <CAJZ5v0i8PKdaF5mt4tHsqWy5wO2+c6sRxmW+UiR7_HOn=w4Y6A@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Use firmware default EPP
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Mar 10, 2022 at 11:42 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> For some specific platforms (E.g. AlderLake) the balance performance
> EPP is updated from the hard coded value in the driver. This acts as
> the default and balance_performance EPP. The purpose of this EPP
> update is to reach maximum 1 core turbo frequency (when possible) out
> of the box.
>
> Although we can achieve the objective by using hard coded value in the
> driver, there can be other EPP which can be better in terms of power.
> But that will be very subjective based on platform and use cases.
> This is not practical to have a per platform specific default hard coded
> in the driver.
>
> If a platform wants to specify default EPP, it can be set in the firmware.
> If this EPP is not the chipset default of 0x80 (balance_perf_epp unless
> driver changed it) and more performance oriented but not 0, the driver
> can use this as the default and balanced_perf EPP. In this case no driver
> update is required every time there is some new platform and default EPP.
>
> If the firmware didn't update the EPP from the chipset default then
> the hard coded value is used as per existing implementation.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 38 ++++++++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index bc7f7e6759bd..846bb3a78788 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1692,6 +1692,37 @@ static void intel_pstate_enable_hwp_interrupt(struct cpudata *cpudata)
>         }
>  }
>
> +static void intel_pstate_update_epp_defaults(struct cpudata *cpudata)
> +{
> +       cpudata->epp_default = intel_pstate_get_epp(cpudata, 0);
> +
> +       /*
> +        * If this CPU gen doesn't call for change in balance_perf
> +        * EPP return.
> +        */
> +       if (epp_values[EPP_INDEX_BALANCE_PERFORMANCE] == HWP_EPP_BALANCE_PERFORMANCE)
> +               return;
> +
> +       /*
> +        * If powerup EPP is something other than chipset default 0x80 and
> +        * - is more performance oriented than 0x80 (default balance_perf EPP)
> +        * - But less performance oriented than performance EPP
> +        *   then use this as new balance_perf EPP.
> +        */
> +       if (cpudata->epp_default < HWP_EPP_BALANCE_PERFORMANCE &&
> +           cpudata->epp_default > HWP_EPP_PERFORMANCE) {
> +               epp_values[EPP_INDEX_BALANCE_PERFORMANCE] = cpudata->epp_default;
> +               return;
> +       }
> +
> +       /*
> +        * Use hard coded value per gen to update the balance_perf
> +        * and default EPP.
> +        */
> +       cpudata->epp_default = epp_values[EPP_INDEX_BALANCE_PERFORMANCE];
> +       intel_pstate_set_epp(cpudata, cpudata->epp_default);
> +}
> +
>  static void intel_pstate_hwp_enable(struct cpudata *cpudata)
>  {
>         /* First disable HWP notification interrupt till we activate again */
> @@ -1705,12 +1736,7 @@ static void intel_pstate_hwp_enable(struct cpudata *cpudata)
>         if (cpudata->epp_default >= 0)
>                 return;
>
> -       if (epp_values[EPP_INDEX_BALANCE_PERFORMANCE] == HWP_EPP_BALANCE_PERFORMANCE) {
> -               cpudata->epp_default = intel_pstate_get_epp(cpudata, 0);
> -       } else {
> -               cpudata->epp_default = epp_values[EPP_INDEX_BALANCE_PERFORMANCE];
> -               intel_pstate_set_epp(cpudata, cpudata->epp_default);
> -       }
> +       intel_pstate_update_epp_defaults(cpudata);
>  }
>
>  static int atom_get_min_pstate(void)
> --

Applied as 5.18 material, thanks!
