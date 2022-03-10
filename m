Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCEE4D51F6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245689AbiCJS74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 13:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbiCJS7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 13:59:53 -0500
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498873DA5F;
        Thu, 10 Mar 2022 10:58:49 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2dc0364d2ceso69002217b3.7;
        Thu, 10 Mar 2022 10:58:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JbZwW4Q33oM0K6Ehmd6ut1YN/0anOjxbXg3ljY5Q01s=;
        b=fR/7p+0xwUdh9MqSD9Y5pKtzk7fpnyw2tEshfgrEB2Voo6PvuXYKb23VQrvXqIAPHK
         /MgsrCKSfDAkmCqh6t2R42+SSS5RLgfd+ToqOzRme2NWuevp9H5lZD4FZTntpcRh9ztC
         xou173jrFPDIwyW3/H8PZjV5CASlyj6XkEBWTLQpYwdYld0tnqpN/SXLs0uaeclxFKlB
         PO9md5A3xOHznkwGkdaT5lIOvFprz7V5webtYKSOWhnHZY54qg5V866TtOkYowdq6Af0
         k5/IQtEWAmHky0fF53OaNHjwEe4uKvMvng0rqtRC8HwBFcr4tkz9T9+g5nWgCPdGSeGl
         SROA==
X-Gm-Message-State: AOAM532GiLhKM2rXghuS5dWtso4NijZAGtgqtRHMkSxzZ67bHjIT2mup
        ZKgpXAiicaYybir5It0GkSfF/lNmry5SNNX2e7w=
X-Google-Smtp-Source: ABdhPJwrvUB5O6SlFInHoaBX+PG4cSRSMHjWror/Hm5x2o/qV9M6zpqbT05s7QtZl2DszwXMeceWjpfuhbcDi3uwqK0=
X-Received: by 2002:a81:f008:0:b0:2d0:cd72:74e5 with SMTP id
 p8-20020a81f008000000b002d0cd7274e5mr5331536ywm.301.1646938728285; Thu, 10
 Mar 2022 10:58:48 -0800 (PST)
MIME-Version: 1.0
References: <20220310143830.4677-1-zhanglianjie@uniontech.com>
In-Reply-To: <20220310143830.4677-1-zhanglianjie@uniontech.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Mar 2022 19:58:37 +0100
Message-ID: <CAJZ5v0jnVQ78EiaTpyaiRAj4x1HJcN_wpmsgu4xxjq5Jnp2eKA@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: unify the show() and store() styles of attr
 and use __ATTR_XX macro
To:     Lianjie Zhang <zhanglianjie@uniontech.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
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

On Thu, Mar 10, 2022 at 3:38 PM Lianjie Zhang
<zhanglianjie@uniontech.com> wrote:
>
> Usually /sys directory under the file, the corresponding Attribute
> contains .show and .store, and their naming style is filename_show() and
> filename_store(). But all naming style in 'cpufreq' is show_filename()
> and store_filename(), resulting in __ATTR_RW() and __ATTR_RO() macros
> cannot be used to simplify code, So need to change naming style.
> Use helper macro __ATTR_XX  to make code more clear.
>
> Signed-off-by: Lianjie Zhang <zhanglianjie@uniontech.com>
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
> index bab8e6140377..a5a0bc3cc23e 100644
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
> @@ -68,12 +68,10 @@ static ssize_t show_##file_name                                             \
>  }
>
>  #define gov_attr_ro(_name)                                             \
> -static struct governor_attr _name =                                    \
> -__ATTR(_name, 0444, show_##_name, NULL)
> +static struct governor_attr _name = __ATTR_RO(_name)
>
>  #define gov_attr_rw(_name)                                             \
> -static struct governor_attr _name =                                    \
> -__ATTR(_name, 0644, show_##_name, store_##_name)
> +static struct governor_attr _name = __ATTR_RW(_name)
>
>  /* Common to all CPUs of a policy */
>  struct policy_dbs_info {
> @@ -176,7 +174,7 @@ void od_register_powersave_bias_handler(unsigned int (*f)
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

Applied as 5.18 material with some edits in the subject and changelog.

Thanks!
