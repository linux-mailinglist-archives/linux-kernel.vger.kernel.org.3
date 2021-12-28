Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E852D480C68
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 19:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbhL1SOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 13:14:34 -0500
Received: from mail-qk1-f177.google.com ([209.85.222.177]:39611 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbhL1SOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 13:14:33 -0500
Received: by mail-qk1-f177.google.com with SMTP id 69so17849577qkd.6;
        Tue, 28 Dec 2021 10:14:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EJ8aYnmOQRS5NqukNYSjs8nzRFdW5gCywT1c2u9vx3s=;
        b=IzAcjFH6UE1bIfFAGsqJmkVDCYuivWqmymmXx6kgbr5Y76M06mpdRp5RR2pH20wLJi
         nLL4kac2hFSHIClvNn/s3MzLCkoFjra9SlKvblVZVAyYHBUZsf9bqZdmJLW+hf5xuP9l
         Eqmblp651dDipU7zuWhw6IYloDQu1GoEZsZNHuYxZnZOjk9GqTk/c3aARpTEpMA8ufM1
         2qmIVYf9opwyiqyTafZEpcLHlbB1BBGalst8u1edYP2gJxLs4o4s9TlQe35WUFtzpIYu
         3qy6LDdn0ifOgku6orQoeS93GSY+YWWZtE02aJSBvRtoMHYqOOFh/+kLajTqNGTv3+4D
         Uf5g==
X-Gm-Message-State: AOAM533jlB4hlvRQYnBZPfJTT4bG9Pdv5MkhPfOfeb3WZFLVKBQv4BKJ
        v9f7dat1mJlFWRrI9LWXSvD1YJUQmx6SZEwlRTTBesTE
X-Google-Smtp-Source: ABdhPJzJgODOGj4mxAKBm0Dvn2T/fQlJABCF8qKzEAqAlsIEDnZ8Pm2+Bdajm698UVXnHFSwdcL4bQzdgdaLr3ZphYg=
X-Received: by 2002:a37:b702:: with SMTP id h2mr16333360qkf.135.1640715272805;
 Tue, 28 Dec 2021 10:14:32 -0800 (PST)
MIME-Version: 1.0
References: <20211228131912.260899-1-gregkh@linuxfoundation.org>
In-Reply-To: <20211228131912.260899-1-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Dec 2021 19:14:22 +0100
Message-ID: <CAJZ5v0gj4-ZOGPLzksvzB9Ed85P0qz=tC47Ntxnuc5G_C9GGVQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: use default_groups in kobj_type
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 2:19 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the cpufreq code to use default_groups field which has been
> the preferred way since aa30f47cf666 ("kobject: Add support for default
> attribute groups to kobj_type") so that we can soon get rid of the
> obsolete default_attrs field.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied as 5.17 material, thanks!

> ---
>  drivers/cpufreq/cpufreq.c              | 5 +++--
>  drivers/cpufreq/cpufreq_conservative.c | 5 +++--
>  drivers/cpufreq/cpufreq_ondemand.c     | 5 +++--
>  3 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e338d2f010fe..09d676d5237e 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -924,7 +924,7 @@ cpufreq_freq_attr_rw(scaling_max_freq);
>  cpufreq_freq_attr_rw(scaling_governor);
>  cpufreq_freq_attr_rw(scaling_setspeed);
>
> -static struct attribute *default_attrs[] = {
> +static struct attribute *cpufreq_attrs[] = {
>         &cpuinfo_min_freq.attr,
>         &cpuinfo_max_freq.attr,
>         &cpuinfo_transition_latency.attr,
> @@ -938,6 +938,7 @@ static struct attribute *default_attrs[] = {
>         &scaling_setspeed.attr,
>         NULL
>  };
> +ATTRIBUTE_GROUPS(cpufreq);
>
>  #define to_policy(k) container_of(k, struct cpufreq_policy, kobj)
>  #define to_attr(a) container_of(a, struct freq_attr, attr)
> @@ -1000,7 +1001,7 @@ static const struct sysfs_ops sysfs_ops = {
>
>  static struct kobj_type ktype_cpufreq = {
>         .sysfs_ops      = &sysfs_ops,
> -       .default_attrs  = default_attrs,
> +       .default_groups = cpufreq_groups,
>         .release        = cpufreq_sysfs_release,
>  };
>
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index 0879ec3c170c..08515f7e515f 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -257,7 +257,7 @@ gov_attr_rw(ignore_nice_load);
>  gov_attr_rw(down_threshold);
>  gov_attr_rw(freq_step);
>
> -static struct attribute *cs_attributes[] = {
> +static struct attribute *cs_attrs[] = {
>         &sampling_rate.attr,
>         &sampling_down_factor.attr,
>         &up_threshold.attr,
> @@ -266,6 +266,7 @@ static struct attribute *cs_attributes[] = {
>         &freq_step.attr,
>         NULL
>  };
> +ATTRIBUTE_GROUPS(cs);
>
>  /************************** sysfs end ************************/
>
> @@ -315,7 +316,7 @@ static void cs_start(struct cpufreq_policy *policy)
>
>  static struct dbs_governor cs_governor = {
>         .gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
> -       .kobj_type = { .default_attrs = cs_attributes },
> +       .kobj_type = { .default_groups = cs_groups },
>         .gov_dbs_update = cs_dbs_update,
>         .alloc = cs_alloc,
>         .free = cs_free,
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> index 3b8f924771b4..6a41ea4729b8 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -328,7 +328,7 @@ gov_attr_rw(sampling_down_factor);
>  gov_attr_rw(ignore_nice_load);
>  gov_attr_rw(powersave_bias);
>
> -static struct attribute *od_attributes[] = {
> +static struct attribute *od_attrs[] = {
>         &sampling_rate.attr,
>         &up_threshold.attr,
>         &sampling_down_factor.attr,
> @@ -337,6 +337,7 @@ static struct attribute *od_attributes[] = {
>         &io_is_busy.attr,
>         NULL
>  };
> +ATTRIBUTE_GROUPS(od);
>
>  /************************** sysfs end ************************/
>
> @@ -401,7 +402,7 @@ static struct od_ops od_ops = {
>
>  static struct dbs_governor od_dbs_gov = {
>         .gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("ondemand"),
> -       .kobj_type = { .default_attrs = od_attributes },
> +       .kobj_type = { .default_groups = od_groups },
>         .gov_dbs_update = od_dbs_update,
>         .alloc = od_alloc,
>         .free = od_free,
> --
> 2.34.1
>
