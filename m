Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD48C523B72
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345499AbiEKRYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345444AbiEKRYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:24:23 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B0D2230A2;
        Wed, 11 May 2022 10:24:22 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id j2so5415536ybu.0;
        Wed, 11 May 2022 10:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TJO/Zn3MPmYiAzjRbG4V7TOcCMadCMhhJkknqYNpUp8=;
        b=h8U/ecdgqTmpTxl386pJEszwzHXiv+/P+gceaRub7Kgn9vErpyBd4fkNVG+ZvjS/rY
         5ddstadq7GZ5KwrQTbkuhmYcTwLkW/AeXty3hY+2mWhoQU6JA+5ZNj1D3t0kHNsR2DF9
         ktC7cChCt04/jNnCUDKfMslznNnSi65peS+li2toRGOOdDSqU/ASKPk1CzJM94TAWJAq
         ryM+NiRm1vdcnc+ckt7bxBl4HNRgP1hsJtA7StMVm+quFJvRqjSTYJNxt9H8kFPnv43u
         YxkSeMIaT8IhINcvFfDHvUbo6ytGzOsjYu7kb0gPgBqO1P/L/c23Rd9B8dleojiB6IZr
         2nVg==
X-Gm-Message-State: AOAM530t3vXrE9fZQ6S6gZDHewXDo4+EeRCYKLs2HRpFAiwm9NwmkEoM
        ypKls3J954FlzIvX17OrcWzGAkNU4j0FsQWRfPo=
X-Google-Smtp-Source: ABdhPJztC2WEyge9/kG78iWVoyrinUqiVqsdUMzH2GFAy+MUlCwRiman49itjCFJb7D1oSP2eMeDWsZqoiZpGmVkdFA=
X-Received: by 2002:a25:da84:0:b0:648:423e:57b0 with SMTP id
 n126-20020a25da84000000b00648423e57b0mr23829636ybf.137.1652289861658; Wed, 11
 May 2022 10:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <b44e39176bbba43c256ae75df26c1fd051353ff9.1652259889.git.viresh.kumar@linaro.org>
In-Reply-To: <b44e39176bbba43c256ae75df26c1fd051353ff9.1652259889.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 11 May 2022 19:24:10 +0200
Message-ID: <CAJZ5v0hD8k6W32MkU1Kp6aN0_xmPgXApswK1Wuxuf3RZYzSKbQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Clear real_cpus mask from remove_cpu_dev_symlink()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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

On Wed, May 11, 2022 at 11:06 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> add_cpu_dev_symlink() is responsible for setting the CPUs in the
> real_cpus mask, the reverse of which should be done from
> remove_cpu_dev_symlink() to make it look clean and avoid any breakage
> later on.
>
> Move the call to clear the mask to remove_cpu_dev_symlink().
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index fbaa8e6c7d23..c8bf6c68597c 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1020,11 +1020,12 @@ static void add_cpu_dev_symlink(struct cpufreq_policy *policy, unsigned int cpu,
>                 dev_err(dev, "cpufreq symlink creation failed\n");
>  }
>
> -static void remove_cpu_dev_symlink(struct cpufreq_policy *policy,
> +static void remove_cpu_dev_symlink(struct cpufreq_policy *policy, int cpu,
>                                    struct device *dev)
>  {
>         dev_dbg(dev, "%s: Removing symlink\n", __func__);
>         sysfs_remove_link(&dev->kobj, "cpufreq");
> +       cpumask_clear_cpu(cpu, policy->real_cpus);
>  }
>
>  static int cpufreq_add_dev_interface(struct cpufreq_policy *policy)
> @@ -1532,7 +1533,7 @@ static int cpufreq_online(unsigned int cpu)
>
>  out_destroy_policy:
>         for_each_cpu(j, policy->real_cpus)
> -               remove_cpu_dev_symlink(policy, get_cpu_device(j));
> +               remove_cpu_dev_symlink(policy, j, get_cpu_device(j));
>
>         up_write(&policy->rwsem);
>
> @@ -1657,8 +1658,7 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
>         if (cpu_online(cpu))
>                 cpufreq_offline(cpu);
>
> -       cpumask_clear_cpu(cpu, policy->real_cpus);
> -       remove_cpu_dev_symlink(policy, dev);
> +       remove_cpu_dev_symlink(policy, cpu, dev);
>
>         if (cpumask_empty(policy->real_cpus)) {
>                 /* We did light-weight exit earlier, do full tear down now */
> --

Applied as 5.19 material, thanks!
