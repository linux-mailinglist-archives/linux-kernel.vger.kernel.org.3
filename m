Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22BF525079
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355135AbiELOot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiELOon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:44:43 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2670233A57;
        Thu, 12 May 2022 07:44:42 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2fb965b34easo59488137b3.1;
        Thu, 12 May 2022 07:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0uB1vg+wKEz0tKGd5rEWM9IxDTniQFNILDoFpPZL8Q=;
        b=o98JMmTneZERTGZVN1FInQDBea0XwolZqxt+g+mdMEClnVfaZlyJUflGOSNelPsXfc
         e1TXwJe3jXp6fiwP5uauEMpxgxnJ3udvTwTsbyBNYvCyRHwzR7Db+Zh1o0HaIZ/qLtkW
         h4RM3Aov7KOWLZycC765TNZnJQTkRoAJetgquMp9N7ZxFueUlhYwiYdfIFGTtazypY9V
         3yBaC2Hb4yIZDt3eTS2f8D84NMefdUmyeojFx/j8ay+9TjNv3D8LKc2j06UsdnRI7tW2
         mJg3sNHbZ8T5MNA2uI9gKP6ooTxv4Yj3csB+ATeTa3UzvEhUr2CiasI+g8YUZxLmHlv+
         k3iQ==
X-Gm-Message-State: AOAM533GPSzBITIfVTFFgS+swFuST21OVcR3a3/gAJLinpA4sttEXfpb
        Swz4Z/fmqI+V+uAfQXYlnIuyNoxL0wHbKM/OLAEoF8dv
X-Google-Smtp-Source: ABdhPJzqiPuNmgjY9WaEmbcKDsq8CTY+scvKZ2iZBd9fzQ7+9AutJTo0eVEnNCkBhXi+biMnrnrNH8aaI+zGW+6ZNKE=
X-Received: by 2002:a81:2f4e:0:b0:2fb:2c97:d66f with SMTP id
 v75-20020a812f4e000000b002fb2c97d66fmr433624ywv.196.1652366681348; Thu, 12
 May 2022 07:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220512135231.10076-1-schspa@gmail.com> <20220512135231.10076-2-schspa@gmail.com>
In-Reply-To: <20220512135231.10076-2-schspa@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 May 2022 16:44:30 +0200
Message-ID: <CAJZ5v0htGfZ3G+BWgZSxvcEAhNd_LONm8rNMetdPts3uZ=Tcxw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] cpufreq: make interface functions and lock holding
 state clear
To:     Schspa Shi <schspa@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
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

On Thu, May 12, 2022 at 3:52 PM Schspa Shi <schspa@gmail.com> wrote:
>
> cpufreq_offline() calls offline() and exit() under the policy rwsem
> But they are called outside the rwsem in cpufreq_online().
>
> This patch move the offline(), exit(), online(), init() to be inside
> of policy rwsem to achieve a clear lock relationship.
>
> All the init() online() implement only initialize policy object without
> holding this lock and won't call cpufreq APIs need to hold this lock.
>
> Signed-off-by: Schspa Shi <schspa@gmail.com>

IMV this still addresses 2 different issues and so it should be split
into 2 different patches.

> ---
>  drivers/cpufreq/cpufreq.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 35dffd738580..f242d5488364 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c

Patch 1:

> @@ -1343,12 +1343,12 @@ static int cpufreq_online(unsigned int cpu)
>                 down_write(&policy->rwsem);
>                 policy->cpu = cpu;
>                 policy->governor = NULL;
> -               up_write(&policy->rwsem);
>         } else {
>                 new_policy = true;
>                 policy = cpufreq_policy_alloc(cpu);
>                 if (!policy)
>                         return -ENOMEM;
> +               down_write(&policy->rwsem);
>         }
>
>         if (!new_policy && cpufreq_driver->online) {
> @@ -1388,7 +1388,6 @@ static int cpufreq_online(unsigned int cpu)
>                 cpumask_copy(policy->related_cpus, policy->cpus);
>         }
>
> -       down_write(&policy->rwsem);
>         /*
>          * affected cpus must always be the one, which are online. We aren't
>          * managing offline cpus here.

which addresses the problem that cpufreq_online() updates the
policy->cpus and related_cpus masks without holding the policy rwsem
(since the policy kobject has been registered already at this point,
this is generally unsafe).

A side-effect of it is that ->online() and ->init() will be called
under the policy rwsem now, but that should be fine and is more
consistent than the current code too.

Patch 2:

> @@ -1540,7 +1539,6 @@ static int cpufreq_online(unsigned int cpu)
>                 remove_cpu_dev_symlink(policy, get_cpu_device(j));
>
>         cpumask_clear(policy->cpus);
> -       up_write(&policy->rwsem);
>
>  out_offline_policy:
>         if (cpufreq_driver->offline)
> @@ -1549,6 +1547,7 @@ static int cpufreq_online(unsigned int cpu)
>  out_exit_policy:
>         if (cpufreq_driver->exit)
>                 cpufreq_driver->exit(policy);
> +       up_write(&policy->rwsem);
>
>  out_free_policy:
>         cpufreq_policy_free(policy);
> --

which addressed the issue of calling ->offline() and ->exit() without
holding the policy rwsem that is at best inconsistent with
cpufreq_offline().
