Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD514632A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 12:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240916AbhK3Lpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 06:45:55 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:42730 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240909AbhK3Lpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:45:54 -0500
Received: by mail-oi1-f178.google.com with SMTP id n66so40666258oia.9;
        Tue, 30 Nov 2021 03:42:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Cob7MMgKwoqYxW2s32/u4cbUtlx4YeFwMg+KntbpTw=;
        b=XdEiLb43hwViatzrOQLCuOFbjtk9y1h86Nc3zVroBzbNsG19nCFfH2NdjI65rHO1Rh
         p3PF1O6SXE8o3WtM6lwYYz/L9Fpm88ZMdhcmQtjlSzU6K4B+c2dcgzkeghse3+Nqig/L
         bmaRerVKwJa8SMW60nSRtypmf7qjzRfda+tTraushVmuUKoPXgsKRerGs/Hw/15lNC73
         nLWvYGTH8I4Jjabj2Jcz/eYE3TlUchRn86e26mzGs8Zl6L2KJlSTqyCimr1JGePVJDqg
         TFz1ZGOoPoJB3HRtGjrhJ7BZNcY6asHOCJaS2zZiBF8lrqD5a0JzFX6bV9ZrcWAMDOn9
         EHVw==
X-Gm-Message-State: AOAM5333miZlki+wuAjlEaYQSeNV+TQeuLH9qJfcUkyuv46mhuyhmlgS
        3B6NnZnvzVWTKi1tMNdBAdcrpXh0dkdPcJN/uyA=
X-Google-Smtp-Source: ABdhPJzagIOGTdiXvf37ZRObRT6oviV/n9CZzeGBiLgxrUTmhACShGEKbirVavcYmox8WYqdmOKa10DnyO6kzeZxKwg=
X-Received: by 2002:a05:6808:14c2:: with SMTP id f2mr3494792oiw.154.1638272555405;
 Tue, 30 Nov 2021 03:42:35 -0800 (PST)
MIME-Version: 1.0
References: <20211129080248.46240-1-wangxiongfeng2@huawei.com> <20211129091039.s7bqq43o4ktuub6t@vireshk-i7>
In-Reply-To: <20211129091039.s7bqq43o4ktuub6t@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Nov 2021 12:42:18 +0100
Message-ID: <CAJZ5v0hYskLTjSGOJgRRXD0cE0a5DMHh5qTvmgCmJh8bMicLzA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Fix get_cpu_device() failed in add_cpu_dev_symlink()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 10:10 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 29-11-21, 16:02, Xiongfeng Wang wrote:
> > When I hot added a CPU, I found 'cpufreq' directory is not created below
> > /sys/devices/system/cpu/cpuX/. It is because get_cpu_device() failed in
> > add_cpu_dev_symlink().
> >
> > cpufreq_add_dev() is the .add_dev callback of a CPU subsys interface. It
> > will be called when the CPU device registered into the system. The stack
> > is as follows.
> >   register_cpu()
> >   ->device_register()
> >    ->device_add()
> >     ->bus_probe_device()
> >      ->cpufreq_add_dev()
> >
> > But only after the CPU device has been registered, we can get the CPU
> > device by get_cpu_device(), otherwise it will return NULL. Since we
> > already have the CPU device in cpufreq_add_dev(), pass it to
> > add_cpu_dev_symlink(). I noticed that the 'kobj' of the cpu device has
> > been added into the system before cpufreq_add_dev().
> >
> > Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index e338d2f010fe..22aa2793e4d2 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1004,10 +1004,9 @@ static struct kobj_type ktype_cpufreq = {
> >       .release        = cpufreq_sysfs_release,
> >  };
> >
> > -static void add_cpu_dev_symlink(struct cpufreq_policy *policy, unsigned int cpu)
> > +static void add_cpu_dev_symlink(struct cpufreq_policy *policy, unsigned int cpu,
> > +                             struct device *dev)
> >  {
> > -     struct device *dev = get_cpu_device(cpu);
> > -
> >       if (unlikely(!dev))
> >               return;
> >
> > @@ -1391,7 +1390,7 @@ static int cpufreq_online(unsigned int cpu)
> >       if (new_policy) {
> >               for_each_cpu(j, policy->related_cpus) {
> >                       per_cpu(cpufreq_cpu_data, j) = policy;
> > -                     add_cpu_dev_symlink(policy, j);
> > +                     add_cpu_dev_symlink(policy, j, get_cpu_device(j));
> >               }
> >
> >               policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
> > @@ -1565,7 +1564,7 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
> >       /* Create sysfs link on CPU registration */
> >       policy = per_cpu(cpufreq_cpu_data, cpu);
> >       if (policy)
> > -             add_cpu_dev_symlink(policy, cpu);
> > +             add_cpu_dev_symlink(policy, cpu, dev);
> >
> >       return 0;
> >  }
>
> Interesting that I never hit it earlier despite doing rigorous testing of
> hotplug stuff :(

This is the real hot-add path which isn't tested on a regular basis.

> Anyway the patch is okay,

It would be good to add a Fixes: tag to it, though.  Any idea about
the commit this should point to?

> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
