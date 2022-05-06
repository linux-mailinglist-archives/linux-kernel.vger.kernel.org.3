Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D211151CF5F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 05:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376581AbiEFD0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 23:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238827AbiEFD0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 23:26:40 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87405EDF7
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 20:22:57 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id w187so10831103ybe.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 20:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sYeOKYw6kwfaILJY6bEHCOKM5bFjhmE1ze1/LSaaovw=;
        b=BLsVEaTG9U91396ZOP2b2MwVake7ojEipUon5OHt1Gy89SB9TslU1tsdVRhaxC4q/1
         jR53S2m613SbxCgxn+k3UaVkQWznyQ9jxkBYcSvw3h+ZKQN0sfVfZucfjoplsMN+OlSp
         oj3a/RwNhQcS0xIC9KsOHEHLYceThRr9bvcs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sYeOKYw6kwfaILJY6bEHCOKM5bFjhmE1ze1/LSaaovw=;
        b=CW+Kx3cV+4Q8IYL8FcRQiYt04puwcRko/MI8Se9Xo+i6/bR/DjmF6qino/ZmNnK+JD
         ekjumNP+i9xPKoxOwQoKs4XK5MQUHz3UYx0g547MftL6GSyR/AkT5YIWCeYuOncujJo7
         WqMf6A0qBbqfzEZbOP3gHkY/ivRVny/wDIEKU4HU5Ccy03QxF+Bs2I8YhtVDYhNNC4Dd
         YVPgGmrEK4mJ6328WeGtvw6GDpwVd9yrOU1QhbDGnHwkCadN1Pe93UrIWaHYUk3eqoGo
         NkD2kukdtCUxmiLxXqwKfAPFahXkVFgYEbAeCxQ8JI0LgXOwvo8ZvtnFl3Yn8cSSbhNT
         0Q+A==
X-Gm-Message-State: AOAM5330bDn/Oofg30pv3y4Y4OsIEOpQmFVNKFcs4oov8zYWKwHd9PCf
        wE4Ydwj7ImEQwBPSNKgGWaNm4t87YaeXpL8z40ERrA==
X-Google-Smtp-Source: ABdhPJzFrU6lJVs+NCit9LuyTEGNDWdMffiHdTCFRjgdhz+G0uAPff2R6owz9lUHYA3QGONqEJvI6agU3HSeStN62Qk=
X-Received: by 2002:a25:4c2:0:b0:648:6a77:5da0 with SMTP id
 185-20020a2504c2000000b006486a775da0mr867811ybe.203.1651807376928; Thu, 05
 May 2022 20:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220505115226.20130-1-rex-bc.chen@mediatek.com>
 <20220505115226.20130-6-rex-bc.chen@mediatek.com> <89dc58a34ea080ca50a94187e24cabc22aba3304.camel@mediatek.com>
In-Reply-To: <89dc58a34ea080ca50a94187e24cabc22aba3304.camel@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 6 May 2022 11:22:45 +0800
Message-ID: <CAGXv+5EOdXFjwbtZWY4_KBdp6BaQdp389JqUS18ifAgdcQiAtQ@mail.gmail.com>
Subject: Re: [PATCH v6 05/10] cpufreq: mediatek: Add opp notification support
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com,
        jia-wei.chang@mediatek.com, roger.lu@mediatek.com,
        hsinyi@google.com, khilman@baylibre.com,
        angelogioacchino.delregno@collabora.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "Andrew-sh . Cheng" <andrew-sh.cheng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 6, 2022 at 9:56 AM Rex-BC Chen <rex-bc.chen@mediatek.com> wrote:
>
> On Thu, 2022-05-05 at 19:52 +0800, Rex-BC Chen wrote:
> > From this opp notifier, cpufreq should listen to opp notification and
> > do
>
> Hello Viresh,
>
> There is still ">" in this patch...
> I think the root cause could be the "From" word in the beginning of
> this message.
> I will not use "From" in next version..

Could this be a bug in lore?

I'm not seeing this extra ">" in either the email in my inbox, viewed
raw, nor the patch downloaded from patchwork [1].


ChenYu

[1] https://patchwork.kernel.org/project/linux-mediatek/patch/20220505115226.20130-6-rex-bc.chen@mediatek.com/mbox/


>
> BRs,
> Rex
>
> > proper actions when receiving events of disable and voltage
> > adjustment.
> >
> > One of the user for this opp notifier is MediaTek SVS.
> > The MediaTek Smart Voltage Scaling (SVS) is a hardware which
> > calculates
> > suitable SVS bank voltages to OPP voltage table.
> >
> > Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > ---
> >  drivers/cpufreq/mediatek-cpufreq.c | 91 +++++++++++++++++++++++++++-
> > --
> >  1 file changed, 83 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/cpufreq/mediatek-cpufreq.c
> > b/drivers/cpufreq/mediatek-cpufreq.c
> > index fe205eca657d..06d80ee06bbf 100644
> > --- a/drivers/cpufreq/mediatek-cpufreq.c
> > +++ b/drivers/cpufreq/mediatek-cpufreq.c
> > @@ -46,6 +46,11 @@ struct mtk_cpu_dvfs_info {
> >       int intermediate_voltage;
> >       bool need_voltage_tracking;
> >       int pre_vproc;
> > +     /* Avoid race condition for regulators between notify and
> > policy */
> > +     struct mutex reg_lock;
> > +     struct notifier_block opp_nb;
> > +     unsigned int opp_cpu;
> > +     unsigned long opp_freq;
> >       const struct mtk_cpufreq_platform_data *soc_data;
> >       int vtrack_max;
> >  };
> > @@ -182,6 +187,8 @@ static int mtk_cpufreq_set_target(struct
> > cpufreq_policy *policy,
> >
> >       pre_freq_hz = clk_get_rate(cpu_clk);
> >
> > +     mutex_lock(&info->reg_lock);
> > +
> >       if (unlikely(info->pre_vproc <= 0))
> >               pre_vproc = regulator_get_voltage(info->proc_reg);
> >       else
> > @@ -214,7 +221,7 @@ static int mtk_cpufreq_set_target(struct
> > cpufreq_policy *policy,
> >                       dev_err(cpu_dev,
> >                               "cpu%d: failed to scale up voltage!\n",
> > policy->cpu);
> >                       mtk_cpufreq_set_voltage(info, pre_vproc);
> > -                     return ret;
> > +                     goto out;
> >               }
> >       }
> >
> > @@ -224,8 +231,7 @@ static int mtk_cpufreq_set_target(struct
> > cpufreq_policy *policy,
> >               dev_err(cpu_dev,
> >                       "cpu%d: failed to re-parent cpu clock!\n",
> > policy->cpu);
> >               mtk_cpufreq_set_voltage(info, pre_vproc);
> > -             WARN_ON(1);
> > -             return ret;
> > +             goto out;
> >       }
> >
> >       /* Set the original PLL to target rate. */
> > @@ -235,7 +241,7 @@ static int mtk_cpufreq_set_target(struct
> > cpufreq_policy *policy,
> >                       "cpu%d: failed to scale cpu clock rate!\n",
> > policy->cpu);
> >               clk_set_parent(cpu_clk, armpll);
> >               mtk_cpufreq_set_voltage(info, pre_vproc);
> > -             return ret;
> > +             goto out;
> >       }
> >
> >       /* Set parent of CPU clock back to the original PLL. */
> > @@ -244,8 +250,7 @@ static int mtk_cpufreq_set_target(struct
> > cpufreq_policy *policy,
> >               dev_err(cpu_dev,
> >                       "cpu%d: failed to re-parent cpu clock!\n",
> > policy->cpu);
> >               mtk_cpufreq_set_voltage(info, inter_vproc);
> > -             WARN_ON(1);
> > -             return ret;
> > +             goto out;
> >       }
> >
> >       /*
> > @@ -260,15 +265,72 @@ static int mtk_cpufreq_set_target(struct
> > cpufreq_policy *policy,
> >                       clk_set_parent(cpu_clk, info->inter_clk);
> >                       clk_set_rate(armpll, pre_freq_hz);
> >                       clk_set_parent(cpu_clk, armpll);
> > -                     return ret;
> > +                     goto out;
> >               }
> >       }
> >
> > -     return 0;
> > +     info->opp_freq = freq_hz;
> > +
> > +out:
> > +     mutex_unlock(&info->reg_lock);
> > +
> > +     return ret;
> >  }
> >
> >  #define DYNAMIC_POWER "dynamic-power-coefficient"
> >
> > +static int mtk_cpufreq_opp_notifier(struct notifier_block *nb,
> > +                                 unsigned long event, void *data)
> > +{
> > +     struct dev_pm_opp *opp = data;
> > +     struct dev_pm_opp *new_opp;
> > +     struct mtk_cpu_dvfs_info *info;
> > +     unsigned long freq, volt;
> > +     struct cpufreq_policy *policy;
> > +     int ret = 0;
> > +
> > +     info = container_of(nb, struct mtk_cpu_dvfs_info, opp_nb);
> > +
> > +     if (event == OPP_EVENT_ADJUST_VOLTAGE) {
> > +             freq = dev_pm_opp_get_freq(opp);
> > +
> > +             mutex_lock(&info->reg_lock);
> > +             if (info->opp_freq == freq) {
> > +                     volt = dev_pm_opp_get_voltage(opp);
> > +                     ret = mtk_cpufreq_set_voltage(info, volt);
> > +                     if (ret)
> > +                             dev_err(info->cpu_dev,
> > +                                     "failed to scale voltage:
> > %d\n", ret);
> > +             }
> > +             mutex_unlock(&info->reg_lock);
> > +     } else if (event == OPP_EVENT_DISABLE) {
> > +             freq = dev_pm_opp_get_freq(opp);
> > +
> > +             /* case of current opp item is disabled */
> > +             if (info->opp_freq == freq) {
> > +                     freq = 1;
> > +                     new_opp = dev_pm_opp_find_freq_ceil(info-
> > >cpu_dev,
> > +                                                         &freq);
> > +                     if (IS_ERR(new_opp)) {
> > +                             dev_err(info->cpu_dev,
> > +                                     "all opp items are
> > disabled\n");
> > +                             ret = PTR_ERR(new_opp);
> > +                             return notifier_from_errno(ret);
> > +                     }
> > +
> > +                     dev_pm_opp_put(new_opp);
> > +                     policy = cpufreq_cpu_get(info->opp_cpu);
> > +                     if (policy) {
> > +                             cpufreq_driver_target(policy, freq /
> > 1000,
> > +                                                   CPUFREQ_RELATION_
> > L);
> > +                             cpufreq_cpu_put(policy);
> > +                     }
> > +             }
> > +     }
> > +
> > +     return notifier_from_errno(ret);
> > +}
> > +
> >  static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info,
> > int cpu)
> >  {
> >       struct device *cpu_dev;
> > @@ -357,6 +419,18 @@ static int mtk_cpu_dvfs_info_init(struct
> > mtk_cpu_dvfs_info *info, int cpu)
> >       info->intermediate_voltage = dev_pm_opp_get_voltage(opp);
> >       dev_pm_opp_put(opp);
> >
> > +     mutex_init(&info->reg_lock);
> > +
> > +     info->opp_cpu = cpu;
> > +     info->opp_nb.notifier_call = mtk_cpufreq_opp_notifier;
> > +     ret = dev_pm_opp_register_notifier(cpu_dev, &info->opp_nb);
> > +     if (ret) {
> > +             dev_err(cpu_dev, "cpu%d: failed to register opp
> > notifier\n", cpu);
> > +             goto out_disable_inter_clock;
> > +     }
> > +
> > +     info->opp_freq = clk_get_rate(info->cpu_clk);
> > +
> >       /*
> >        * If SRAM regulator is present, software "voltage tracking" is
> > needed
> >        * for this CPU power domain.
> > @@ -421,6 +495,7 @@ static void mtk_cpu_dvfs_info_release(struct
> > mtk_cpu_dvfs_info *info)
> >       }
> >
> >       dev_pm_opp_of_cpumask_remove_table(&info->cpus);
> > +     dev_pm_opp_unregister_notifier(info->cpu_dev, &info->opp_nb);
> >  }
> >
> >  static int mtk_cpufreq_init(struct cpufreq_policy *policy)
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
