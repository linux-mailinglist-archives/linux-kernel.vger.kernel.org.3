Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7334D0642
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244711AbiCGSU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244593AbiCGSU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:20:26 -0500
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D626180918;
        Mon,  7 Mar 2022 10:19:30 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id b35so32663559ybi.13;
        Mon, 07 Mar 2022 10:19:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JgPFBkbztEBtMJP0LHD1YxBIa8nGPhe2QaYONr9BDe4=;
        b=N1sByrSgmydVDzCrX6MVf1CUtJnVh2k5ns74hjT4mjKGuoMlPvgKTR/YIAfzwPtskI
         R9mhWM3y4O5EgIfAyPbQn7gVcrf27abHmq+YNhbhVrOtkIxBdp8EGaW6IkkKyZQVIeBh
         kFbX5UFnGAiWcCQ6/ERXDeoIBtQYqPUYkCalzn0pcfT9KvRs59xGLEg6V0MUxEtoAivE
         4/Bj/p+StAVWgjlTMuaXyHKYV1vReO1W9phtXqW4wwi42f2tuG6R+RdEVastCB1sA19b
         20EiuuzrLMfAP6UuPgzkVF0jwpZwgXKKOFjU1iaFSm6hqeFNO8Fx1TADV7rXea0ajiEH
         NGsw==
X-Gm-Message-State: AOAM531G2gVFni9/fVvgU4ZuPspv5un3laYjogFsg99rMaKCxGoQLSg3
        NSTzIA9BjV6+hffcsDf139LNbpIY0pQx355dHjh1+v/m
X-Google-Smtp-Source: ABdhPJwogE1aj2YG96J07EcXnP1zJdXUogLKnATGGthibnkbBDYrk8GRjd/ozgW/+hSunZzbBGvnRVxRx22XWjDGNuM=
X-Received: by 2002:a25:d7c2:0:b0:628:9d06:457b with SMTP id
 o185-20020a25d7c2000000b006289d06457bmr8997916ybg.137.1646677170081; Mon, 07
 Mar 2022 10:19:30 -0800 (PST)
MIME-Version: 1.0
References: <20220306021250.64315-1-zhanglianjie@uniontech.com>
In-Reply-To: <20220306021250.64315-1-zhanglianjie@uniontech.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Mar 2022 19:19:19 +0100
Message-ID: <CAJZ5v0iEc59fge6bDbwFV6gVDKp8dqf7zwL_fL=WkME5qoMgtw@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpufreq: unify the show() and store() styles of attr
To:     zhanglianjie <zhanglianjie@uniontech.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Sun, Mar 6, 2022 at 3:13 AM zhanglianjie <zhanglianjie@uniontech.com> wrote:
>
> Unify the show() and store() styles of attr,
> change show_xxx(), store_xxx() to xxx_show(), xxx_store().

You need to say something about motivation too.

> Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>
>
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index 08515f7e515f..b6bd0ff35323 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -146,7 +146,7 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>
>  /************************** sysfs interface ************************/
>
> -static ssize_t store_sampling_down_factor(struct gov_attr_set *attr_set,
> +static ssize_t sampling_down_factor_store(struct gov_attr_set *attr_set,
>                                           const char *buf, size_t count)
>  {
>         struct dbs_data *dbs_data = to_dbs_data(attr_set);
> @@ -161,7 +161,7 @@ static ssize_t store_sampling_down_factor(struct gov_attr_set *attr_set,
>         return count;
>  }
>
> -static ssize_t store_up_threshold(struct gov_attr_set *attr_set,
> +static ssize_t up_threshold_store(struct gov_attr_set *attr_set,
>                                   const char *buf, size_t count)
>  {
>         struct dbs_data *dbs_data = to_dbs_data(attr_set);
> @@ -177,7 +177,7 @@ static ssize_t store_up_threshold(struct gov_attr_set *attr_set,
>         return count;
>  }
>
> -static ssize_t store_down_threshold(struct gov_attr_set *attr_set,
> +static ssize_t down_threshold_store(struct gov_attr_set *attr_set,
>                                     const char *buf, size_t count)
>  {
>         struct dbs_data *dbs_data = to_dbs_data(attr_set);
> @@ -195,7 +195,7 @@ static ssize_t store_down_threshold(struct gov_attr_set *attr_set,
>         return count;
>  }
>
> -static ssize_t store_ignore_nice_load(struct gov_attr_set *attr_set,
> +static ssize_t ignore_nice_load_store(struct gov_attr_set *attr_set,
>                                       const char *buf, size_t count)
>  {
>         struct dbs_data *dbs_data = to_dbs_data(attr_set);
> @@ -220,7 +220,7 @@ static ssize_t store_ignore_nice_load(struct gov_attr_set *attr_set,
>         return count;
>  }
>
> -static ssize_t store_freq_step(struct gov_attr_set *attr_set, const char *buf,
> +static ssize_t freq_step_store(struct gov_attr_set *attr_set, const char *buf,
>                                size_t count)
>  {
>         struct dbs_data *dbs_data = to_dbs_data(attr_set);
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 63f7c219062b..0d42cf8b88d8 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -27,7 +27,7 @@ static DEFINE_MUTEX(gov_dbs_data_mutex);
>
>  /* Common sysfs tunables */
>  /*
> - * store_sampling_rate - update sampling rate effective immediately if needed.
> + * sampling_rate_store - update sampling rate effective immediately if needed.
>   *
>   * If new rate is smaller than the old, simply updating
>   * dbs.sampling_rate might not be appropriate. For example, if the
> @@ -41,7 +41,7 @@ static DEFINE_MUTEX(gov_dbs_data_mutex);
>   * This must be called with dbs_data->mutex held, otherwise traversing
>   * policy_dbs_list isn't safe.
>   */
> -ssize_t store_sampling_rate(struct gov_attr_set *attr_set, const char *buf,
> +ssize_t sampling_rate_store(struct gov_attr_set *attr_set, const char *buf,
>                             size_t count)
>  {
>         struct dbs_data *dbs_data = to_dbs_data(attr_set);
> @@ -80,7 +80,7 @@ ssize_t store_sampling_rate(struct gov_attr_set *attr_set, const char *buf,
>
>         return count;
>  }
> -EXPORT_SYMBOL_GPL(store_sampling_rate);
> +EXPORT_SYMBOL_GPL(sampling_rate_store);
>
>  /**
>   * gov_update_cpu_data - Update CPU load data.
> diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
> index bab8e6140377..65ecf32ba4f8 100644
> --- a/drivers/cpufreq/cpufreq_governor.h
> +++ b/drivers/cpufreq/cpufreq_governor.h
> @@ -51,7 +51,7 @@ static inline struct dbs_data *to_dbs_data(struct gov_attr_set *attr_set)
>  }
>
>  #define gov_show_one(_gov, file_name)                                  \
> -static ssize_t show_##file_name                                                \
> +static ssize_t file_name##_show                                                \
>  (struct gov_attr_set *attr_set, char *buf)                             \
>  {                                                                      \
>         struct dbs_data *dbs_data = to_dbs_data(attr_set);              \
> @@ -60,7 +60,7 @@ static ssize_t show_##file_name                                               \
>  }
>
>  #define gov_show_one_common(file_name)                                 \
> -static ssize_t show_##file_name                                                \
> +static ssize_t file_name##_show                                                \
>  (struct gov_attr_set *attr_set, char *buf)                             \
>  {                                                                      \
>         struct dbs_data *dbs_data = to_dbs_data(attr_set);              \
> @@ -69,11 +69,11 @@ static ssize_t show_##file_name                                             \
>
>  #define gov_attr_ro(_name)                                             \
>  static struct governor_attr _name =                                    \
> -__ATTR(_name, 0444, show_##_name, NULL)
> +__ATTR(_name, 0444, _name##_show, NULL)
>
>  #define gov_attr_rw(_name)                                             \
>  static struct governor_attr _name =                                    \
> -__ATTR(_name, 0644, show_##_name, store_##_name)
> +__ATTR(_name, 0644, _name##_show, _name##_store)
>
>  /* Common to all CPUs of a policy */
>  struct policy_dbs_info {
> @@ -176,7 +176,7 @@ void od_register_powersave_bias_handler(unsigned int (*f)
>                 (struct cpufreq_policy *, unsigned int, unsigned int),
>                 unsigned int powersave_bias);
>  void od_unregister_powersave_bias_handler(void);
> -ssize_t store_sampling_rate(struct gov_attr_set *attr_set, const char *buf,
> +ssize_t sampling_rate_store(struct gov_attr_set *attr_set, const char *buf,
>                             size_t count);
>  void gov_update_cpu_data(struct dbs_data *dbs_data);
>  #endif /* _CPUFREQ_GOVERNOR_H */
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> index 6a41ea4729b8..e8fbf970ff07 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -202,7 +202,7 @@ static unsigned int od_dbs_update(struct cpufreq_policy *policy)
>  /************************** sysfs interface ************************/
>  static struct dbs_governor od_dbs_gov;
>
> -static ssize_t store_io_is_busy(struct gov_attr_set *attr_set, const char *buf,
> +static ssize_t io_is_busy_store(struct gov_attr_set *attr_set, const char *buf,
>                                 size_t count)
>  {
>         struct dbs_data *dbs_data = to_dbs_data(attr_set);
> @@ -220,7 +220,7 @@ static ssize_t store_io_is_busy(struct gov_attr_set *attr_set, const char *buf,
>         return count;
>  }
>
> -static ssize_t store_up_threshold(struct gov_attr_set *attr_set,
> +static ssize_t up_threshold_store(struct gov_attr_set *attr_set,
>                                   const char *buf, size_t count)
>  {
>         struct dbs_data *dbs_data = to_dbs_data(attr_set);
> @@ -237,7 +237,7 @@ static ssize_t store_up_threshold(struct gov_attr_set *attr_set,
>         return count;
>  }
>
> -static ssize_t store_sampling_down_factor(struct gov_attr_set *attr_set,
> +static ssize_t sampling_down_factor_store(struct gov_attr_set *attr_set,
>                                           const char *buf, size_t count)
>  {
>         struct dbs_data *dbs_data = to_dbs_data(attr_set);
> @@ -265,7 +265,7 @@ static ssize_t store_sampling_down_factor(struct gov_attr_set *attr_set,
>         return count;
>  }
>
> -static ssize_t store_ignore_nice_load(struct gov_attr_set *attr_set,
> +static ssize_t ignore_nice_load_store(struct gov_attr_set *attr_set,
>                                       const char *buf, size_t count)
>  {
>         struct dbs_data *dbs_data = to_dbs_data(attr_set);
> @@ -290,7 +290,7 @@ static ssize_t store_ignore_nice_load(struct gov_attr_set *attr_set,
>         return count;
>  }
>
> -static ssize_t store_powersave_bias(struct gov_attr_set *attr_set,
> +static ssize_t powersave_bias_store(struct gov_attr_set *attr_set,
>                                     const char *buf, size_t count)
>  {
>         struct dbs_data *dbs_data = to_dbs_data(attr_set);
> --
> 2.20.1
>
>
>
