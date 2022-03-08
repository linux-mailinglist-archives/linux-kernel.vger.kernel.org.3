Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED884D193B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345205AbiCHNez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbiCHNey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:34:54 -0500
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA0D4505C;
        Tue,  8 Mar 2022 05:33:57 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2d07ae0b1c0so201439697b3.2;
        Tue, 08 Mar 2022 05:33:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P1+YgTR0ISexRc1EcgJwqgm2rwOIfzVf4BT5VKtVbJE=;
        b=MZx+T0MbVNox6/Zr9tel1ZSeICclWtd9HFI5hMcXkFbZwYesEuGdfdmTkUF077Xfn8
         H+SYd/Y5iALRxs2OBVwNuljYtCrAKmMND1TVMxz0cY+OSV5gp+2E4yzG2tHJflbm/slX
         Ys4oqWBt7mPdh1gUhgbwEqZgK5IeiOZM6nwdxHZQk5BhSSTaiiRCi+Q0JaVuCNXb2N9c
         TwORl3o8aJkkmPZm5cxOdEmykaMm6pYEsZGFbStY19hX+bjE5iML3/BYLSC61OriDDsb
         YHTyPqqpM1ttDdxdb3C5wFxenV8wzwS9tNPaPjZ5iHDyrtvwak4l3JnFreP5I5LfHlVz
         1g2Q==
X-Gm-Message-State: AOAM531RyV7mgJxQ35sl39DUgvqRlqr/NJLeJlZdQ8Je5pyxHzXaxdvY
        8Is2ll6H9iODsMfNghvc3wgMmAJ2LeO3pYqrZrM=
X-Google-Smtp-Source: ABdhPJxLRyVIscE++TWDGzPgM2K+8ALM3ky4sjq/PG80YqJnZv4dpkGAPrVKvrQNUuvlpVdISyFXkU8ARQUWj5qoVec=
X-Received: by 2002:a81:19c3:0:b0:2dc:2686:14e3 with SMTP id
 186-20020a8119c3000000b002dc268614e3mr12633359ywz.515.1646746436784; Tue, 08
 Mar 2022 05:33:56 -0800 (PST)
MIME-Version: 1.0
References: <20220306021250.64315-1-zhanglianjie@uniontech.com>
 <CAJZ5v0iEc59fge6bDbwFV6gVDKp8dqf7zwL_fL=WkME5qoMgtw@mail.gmail.com> <6226ab8c.1c69fb81.15dff.3e7eSMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <6226ab8c.1c69fb81.15dff.3e7eSMTPIN_ADDED_BROKEN@mx.google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Mar 2022 14:33:44 +0100
Message-ID: <CAJZ5v0iOymgX2PSGkmO9Bp94oYz7jn-EZhdCWu0yz_JZdnxMfw@mail.gmail.com>
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

On Tue, Mar 8, 2022 at 2:04 AM zhanglianjie <zhanglianjie@uniontech.com> wrote:
>
> Hi,
>
> On 2022/3/8 02:19, Rafael J. Wysocki wrote:
> > On Sun, Mar 6, 2022 at 3:13 AM zhanglianjie <zhanglianjie@uniontech.com> wrote:
> >>
> >> Unify the show() and store() styles of attr,
> >> change show_xxx(), store_xxx() to xxx_show(), xxx_store().
> >
> > You need to say something about motivation too.
> Usually /sys directory under the file, the corresponding Attribute
> contains .show and .store, and their naming style is filename_show() and
> filename_store(). But all naming style in 'cpufreq' is show_filename()
> and store_filename(), resulting in __ATTR_RW() and __ATTR_RO() macros
> cannot be used to simplify code, So need to change naming style.

OK, so please put the above information into the patch changelog.

> >
> >> Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>
> >>
> >> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> >> index 08515f7e515f..b6bd0ff35323 100644
> >> --- a/drivers/cpufreq/cpufreq_conservative.c
> >> +++ b/drivers/cpufreq/cpufreq_conservative.c
> >> @@ -146,7 +146,7 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
> >>
> >>   /************************** sysfs interface ************************/
> >>
> >> -static ssize_t store_sampling_down_factor(struct gov_attr_set *attr_set,
> >> +static ssize_t sampling_down_factor_store(struct gov_attr_set *attr_set,
> >>                                            const char *buf, size_t count)
> >>   {
> >>          struct dbs_data *dbs_data = to_dbs_data(attr_set);
> >> @@ -161,7 +161,7 @@ static ssize_t store_sampling_down_factor(struct gov_attr_set *attr_set,
> >>          return count;
> >>   }
> >>
> >> -static ssize_t store_up_threshold(struct gov_attr_set *attr_set,
> >> +static ssize_t up_threshold_store(struct gov_attr_set *attr_set,
> >>                                    const char *buf, size_t count)
> >>   {
> >>          struct dbs_data *dbs_data = to_dbs_data(attr_set);
> >> @@ -177,7 +177,7 @@ static ssize_t store_up_threshold(struct gov_attr_set *attr_set,
> >>          return count;
> >>   }
> >>
> >> -static ssize_t store_down_threshold(struct gov_attr_set *attr_set,
> >> +static ssize_t down_threshold_store(struct gov_attr_set *attr_set,
> >>                                      const char *buf, size_t count)
> >>   {
> >>          struct dbs_data *dbs_data = to_dbs_data(attr_set);
> >> @@ -195,7 +195,7 @@ static ssize_t store_down_threshold(struct gov_attr_set *attr_set,
> >>          return count;
> >>   }
> >>
> >> -static ssize_t store_ignore_nice_load(struct gov_attr_set *attr_set,
> >> +static ssize_t ignore_nice_load_store(struct gov_attr_set *attr_set,
> >>                                        const char *buf, size_t count)
> >>   {
> >>          struct dbs_data *dbs_data = to_dbs_data(attr_set);
> >> @@ -220,7 +220,7 @@ static ssize_t store_ignore_nice_load(struct gov_attr_set *attr_set,
> >>          return count;
> >>   }
> >>
> >> -static ssize_t store_freq_step(struct gov_attr_set *attr_set, const char *buf,
> >> +static ssize_t freq_step_store(struct gov_attr_set *attr_set, const char *buf,
> >>                                 size_t count)
> >>   {
> >>          struct dbs_data *dbs_data = to_dbs_data(attr_set);
> >> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> >> index 63f7c219062b..0d42cf8b88d8 100644
> >> --- a/drivers/cpufreq/cpufreq_governor.c
> >> +++ b/drivers/cpufreq/cpufreq_governor.c
> >> @@ -27,7 +27,7 @@ static DEFINE_MUTEX(gov_dbs_data_mutex);
> >>
> >>   /* Common sysfs tunables */
> >>   /*
> >> - * store_sampling_rate - update sampling rate effective immediately if needed.
> >> + * sampling_rate_store - update sampling rate effective immediately if needed.
> >>    *
> >>    * If new rate is smaller than the old, simply updating
> >>    * dbs.sampling_rate might not be appropriate. For example, if the
> >> @@ -41,7 +41,7 @@ static DEFINE_MUTEX(gov_dbs_data_mutex);
> >>    * This must be called with dbs_data->mutex held, otherwise traversing
> >>    * policy_dbs_list isn't safe.
> >>    */
> >> -ssize_t store_sampling_rate(struct gov_attr_set *attr_set, const char *buf,
> >> +ssize_t sampling_rate_store(struct gov_attr_set *attr_set, const char *buf,
> >>                              size_t count)
> >>   {
> >>          struct dbs_data *dbs_data = to_dbs_data(attr_set);
> >> @@ -80,7 +80,7 @@ ssize_t store_sampling_rate(struct gov_attr_set *attr_set, const char *buf,
> >>
> >>          return count;
> >>   }
> >> -EXPORT_SYMBOL_GPL(store_sampling_rate);
> >> +EXPORT_SYMBOL_GPL(sampling_rate_store);
> >>
> >>   /**
> >>    * gov_update_cpu_data - Update CPU load data.
> >> diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
> >> index bab8e6140377..65ecf32ba4f8 100644
> >> --- a/drivers/cpufreq/cpufreq_governor.h
> >> +++ b/drivers/cpufreq/cpufreq_governor.h
> >> @@ -51,7 +51,7 @@ static inline struct dbs_data *to_dbs_data(struct gov_attr_set *attr_set)
> >>   }
> >>
> >>   #define gov_show_one(_gov, file_name)                                  \
> >> -static ssize_t show_##file_name                                                \
> >> +static ssize_t file_name##_show                                                \
> >>   (struct gov_attr_set *attr_set, char *buf)                             \
> >>   {                                                                      \
> >>          struct dbs_data *dbs_data = to_dbs_data(attr_set);              \
> >> @@ -60,7 +60,7 @@ static ssize_t show_##file_name                                               \
> >>   }
> >>
> >>   #define gov_show_one_common(file_name)                                 \
> >> -static ssize_t show_##file_name                                                \
> >> +static ssize_t file_name##_show                                                \
> >>   (struct gov_attr_set *attr_set, char *buf)                             \
> >>   {                                                                      \
> >>          struct dbs_data *dbs_data = to_dbs_data(attr_set);              \
> >> @@ -69,11 +69,11 @@ static ssize_t show_##file_name                                             \
> >>
> >>   #define gov_attr_ro(_name)                                             \
> >>   static struct governor_attr _name =                                    \
> >> -__ATTR(_name, 0444, show_##_name, NULL)
> >> +__ATTR(_name, 0444, _name##_show, NULL)
> >>
> >>   #define gov_attr_rw(_name)                                             \
> >>   static struct governor_attr _name =                                    \
> >> -__ATTR(_name, 0644, show_##_name, store_##_name)
> >> +__ATTR(_name, 0644, _name##_show, _name##_store)
> >>
> >>   /* Common to all CPUs of a policy */
> >>   struct policy_dbs_info {
> >> @@ -176,7 +176,7 @@ void od_register_powersave_bias_handler(unsigned int (*f)
> >>                  (struct cpufreq_policy *, unsigned int, unsigned int),
> >>                  unsigned int powersave_bias);
> >>   void od_unregister_powersave_bias_handler(void);
> >> -ssize_t store_sampling_rate(struct gov_attr_set *attr_set, const char *buf,
> >> +ssize_t sampling_rate_store(struct gov_attr_set *attr_set, const char *buf,
> >>                              size_t count);
> >>   void gov_update_cpu_data(struct dbs_data *dbs_data);
> >>   #endif /* _CPUFREQ_GOVERNOR_H */
> >> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> >> index 6a41ea4729b8..e8fbf970ff07 100644
> >> --- a/drivers/cpufreq/cpufreq_ondemand.c
> >> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> >> @@ -202,7 +202,7 @@ static unsigned int od_dbs_update(struct cpufreq_policy *policy)
> >>   /************************** sysfs interface ************************/
> >>   static struct dbs_governor od_dbs_gov;
> >>
> >> -static ssize_t store_io_is_busy(struct gov_attr_set *attr_set, const char *buf,
> >> +static ssize_t io_is_busy_store(struct gov_attr_set *attr_set, const char *buf,
> >>                                  size_t count)
> >>   {
> >>          struct dbs_data *dbs_data = to_dbs_data(attr_set);
> >> @@ -220,7 +220,7 @@ static ssize_t store_io_is_busy(struct gov_attr_set *attr_set, const char *buf,
> >>          return count;
> >>   }
> >>
> >> -static ssize_t store_up_threshold(struct gov_attr_set *attr_set,
> >> +static ssize_t up_threshold_store(struct gov_attr_set *attr_set,
> >>                                    const char *buf, size_t count)
> >>   {
> >>          struct dbs_data *dbs_data = to_dbs_data(attr_set);
> >> @@ -237,7 +237,7 @@ static ssize_t store_up_threshold(struct gov_attr_set *attr_set,
> >>          return count;
> >>   }
> >>
> >> -static ssize_t store_sampling_down_factor(struct gov_attr_set *attr_set,
> >> +static ssize_t sampling_down_factor_store(struct gov_attr_set *attr_set,
> >>                                            const char *buf, size_t count)
> >>   {
> >>          struct dbs_data *dbs_data = to_dbs_data(attr_set);
> >> @@ -265,7 +265,7 @@ static ssize_t store_sampling_down_factor(struct gov_attr_set *attr_set,
> >>          return count;
> >>   }
> >>
> >> -static ssize_t store_ignore_nice_load(struct gov_attr_set *attr_set,
> >> +static ssize_t ignore_nice_load_store(struct gov_attr_set *attr_set,
> >>                                        const char *buf, size_t count)
> >>   {
> >>          struct dbs_data *dbs_data = to_dbs_data(attr_set);
> >> @@ -290,7 +290,7 @@ static ssize_t store_ignore_nice_load(struct gov_attr_set *attr_set,
> >>          return count;
> >>   }
> >>
> >> -static ssize_t store_powersave_bias(struct gov_attr_set *attr_set,
> >> +static ssize_t powersave_bias_store(struct gov_attr_set *attr_set,
> >>                                      const char *buf, size_t count)
> >>   {
> >>          struct dbs_data *dbs_data = to_dbs_data(attr_set);
> >> --
> >> 2.20.1
> >>
> >>
> >>
> >
>
> --
> Kind regards,
> Lianjie
>
>
