Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EED50B9C3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448514AbiDVOPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379901AbiDVOPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:15:51 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61BB5AA4A;
        Fri, 22 Apr 2022 07:12:56 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id j2so14757297ybu.0;
        Fri, 22 Apr 2022 07:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AVjJ4/4/sBVZFXgvcVyVVH2TqTHfcQk5ZlaKlvfXzos=;
        b=v+TlfTq4bsp47JP8N3r+RXAlAKh+9bEXH+lgqAJZetf8tG2ZnBN7CI4O2+vsqGrRuu
         ydMGw9CSfBBgA6Ntj40ya2cPWaOJfcuGwAKmdMNGLFDcWOw4WkBPsA3upV4uIJGsrVEq
         4BmEz7cR4DKwJD60CEDVLAZugK2yKWIgVMyOAc2Cdrx2VYDvm0qb/uYropCIKiy0QcG3
         /EMV6tiaC0hYyKPw53D7rXg0174poHQWkIt1bVZFOfE2lvo19ac4goszdMJ5fOyss1W5
         PVtf3vZkR0spjoEbt0kzMioO7fbhSqc+I5ZUd2nbJlcKAGtZNx7b5CZYLZxqBD3KJmvW
         UZgA==
X-Gm-Message-State: AOAM532chGTI0jjOv2whjms7QVUqpak1mDn0rkM5F5rG1m0HLzmh+bTk
        y/Fq/WqUHPjBq4TUJ56tfptADPXr52s0jfO1uLY=
X-Google-Smtp-Source: ABdhPJx1Wa5TywhOhuAHthn5HihgTMye5WWMtbA/0wEBo/zfkQ8OqnF9MEUZGpEoGiUaTYEAB05WdS31RbGrnHXJbl0=
X-Received: by 2002:a05:6902:352:b0:63e:94c:883c with SMTP id
 e18-20020a056902035200b0063e094c883cmr4342711ybs.365.1650636776038; Fri, 22
 Apr 2022 07:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220419172916.440055-1-ulf.hansson@linaro.org>
In-Reply-To: <20220419172916.440055-1-ulf.hansson@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Apr 2022 16:12:45 +0200
Message-ID: <CAJZ5v0im-pdwemdx3B3SaF+PBoaLDWOdTT7-6kwn2GB0rW0kCQ@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Move genpd's time-accounting to ktime_get_mono_fast_ns()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 7:29 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> To move towards a more consistent behaviour between genpd and the runtime
> PM core, let's start by converting genpd's time-accounting from ktime_get()
> into ktime_get_mono_fast_ns().
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied as 5.19 material, thanks!

> ---
>  drivers/base/power/domain.c | 77 +++++++++++++++++++++----------------
>  include/linux/pm_domain.h   |  6 +--
>  2 files changed, 46 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 1ee878d126fd..18cd7965e5d6 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -225,24 +225,23 @@ static void genpd_debug_remove(struct generic_pm_domain *genpd)
>
>  static void genpd_update_accounting(struct generic_pm_domain *genpd)
>  {
> -       ktime_t delta, now;
> +       u64 delta, now;
>
> -       now = ktime_get();
> -       delta = ktime_sub(now, genpd->accounting_time);
> +       now = ktime_get_mono_fast_ns();
> +       if (now <= genpd->accounting_time)
> +               return;
> +
> +       delta = now - genpd->accounting_time;
>
>         /*
>          * If genpd->status is active, it means we are just
>          * out of off and so update the idle time and vice
>          * versa.
>          */
> -       if (genpd->status == GENPD_STATE_ON) {
> -               int state_idx = genpd->state_idx;
> -
> -               genpd->states[state_idx].idle_time =
> -                       ktime_add(genpd->states[state_idx].idle_time, delta);
> -       } else {
> -               genpd->on_time = ktime_add(genpd->on_time, delta);
> -       }
> +       if (genpd->status == GENPD_STATE_ON)
> +               genpd->states[genpd->state_idx].idle_time += delta;
> +       else
> +               genpd->on_time += delta;
>
>         genpd->accounting_time = now;
>  }
> @@ -1999,7 +1998,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>         genpd->max_off_time_changed = true;
>         genpd->provider = NULL;
>         genpd->has_provider = false;
> -       genpd->accounting_time = ktime_get();
> +       genpd->accounting_time = ktime_get_mono_fast_ns();
>         genpd->domain.ops.runtime_suspend = genpd_runtime_suspend;
>         genpd->domain.ops.runtime_resume = genpd_runtime_resume;
>         genpd->domain.ops.prepare = genpd_prepare;
> @@ -3163,6 +3162,7 @@ static int sub_domains_show(struct seq_file *s, void *data)
>  static int idle_states_show(struct seq_file *s, void *data)
>  {
>         struct generic_pm_domain *genpd = s->private;
> +       u64 now, delta, idle_time = 0;
>         unsigned int i;
>         int ret = 0;
>
> @@ -3173,17 +3173,19 @@ static int idle_states_show(struct seq_file *s, void *data)
>         seq_puts(s, "State          Time Spent(ms) Usage          Rejected\n");
>
>         for (i = 0; i < genpd->state_count; i++) {
> -               ktime_t delta = 0;
> -               s64 msecs;
> +               idle_time += genpd->states[i].idle_time;
>
> -               if ((genpd->status == GENPD_STATE_OFF) &&
> -                               (genpd->state_idx == i))
> -                       delta = ktime_sub(ktime_get(), genpd->accounting_time);
> +               if (genpd->status == GENPD_STATE_OFF && genpd->state_idx == i) {
> +                       now = ktime_get_mono_fast_ns();
> +                       if (now > genpd->accounting_time) {
> +                               delta = now - genpd->accounting_time;
> +                               idle_time += delta;
> +                       }
> +               }
>
> -               msecs = ktime_to_ms(
> -                       ktime_add(genpd->states[i].idle_time, delta));
> -               seq_printf(s, "S%-13i %-14lld %-14llu %llu\n", i, msecs,
> -                             genpd->states[i].usage, genpd->states[i].rejected);
> +               do_div(idle_time, NSEC_PER_MSEC);
> +               seq_printf(s, "S%-13i %-14llu %-14llu %llu\n", i, idle_time,
> +                          genpd->states[i].usage, genpd->states[i].rejected);
>         }
>
>         genpd_unlock(genpd);
> @@ -3193,18 +3195,22 @@ static int idle_states_show(struct seq_file *s, void *data)
>  static int active_time_show(struct seq_file *s, void *data)
>  {
>         struct generic_pm_domain *genpd = s->private;
> -       ktime_t delta = 0;
> +       u64 now, on_time, delta = 0;
>         int ret = 0;
>
>         ret = genpd_lock_interruptible(genpd);
>         if (ret)
>                 return -ERESTARTSYS;
>
> -       if (genpd->status == GENPD_STATE_ON)
> -               delta = ktime_sub(ktime_get(), genpd->accounting_time);
> +       if (genpd->status == GENPD_STATE_ON) {
> +               now = ktime_get_mono_fast_ns();
> +               if (now > genpd->accounting_time)
> +                       delta = now - genpd->accounting_time;
> +       }
>
> -       seq_printf(s, "%lld ms\n", ktime_to_ms(
> -                               ktime_add(genpd->on_time, delta)));
> +       on_time = genpd->on_time + delta;
> +       do_div(on_time, NSEC_PER_MSEC);
> +       seq_printf(s, "%llu ms\n", on_time);
>
>         genpd_unlock(genpd);
>         return ret;
> @@ -3213,7 +3219,7 @@ static int active_time_show(struct seq_file *s, void *data)
>  static int total_idle_time_show(struct seq_file *s, void *data)
>  {
>         struct generic_pm_domain *genpd = s->private;
> -       ktime_t delta = 0, total = 0;
> +       u64 now, delta, total = 0;
>         unsigned int i;
>         int ret = 0;
>
> @@ -3222,16 +3228,19 @@ static int total_idle_time_show(struct seq_file *s, void *data)
>                 return -ERESTARTSYS;
>
>         for (i = 0; i < genpd->state_count; i++) {
> +               total += genpd->states[i].idle_time;
>
> -               if ((genpd->status == GENPD_STATE_OFF) &&
> -                               (genpd->state_idx == i))
> -                       delta = ktime_sub(ktime_get(), genpd->accounting_time);
> -
> -               total = ktime_add(total, genpd->states[i].idle_time);
> +               if (genpd->status == GENPD_STATE_OFF && genpd->state_idx == i) {
> +                       now = ktime_get_mono_fast_ns();
> +                       if (now > genpd->accounting_time) {
> +                               delta = now - genpd->accounting_time;
> +                               total += delta;
> +                       }
> +               }
>         }
> -       total = ktime_add(total, delta);
>
> -       seq_printf(s, "%lld ms\n", ktime_to_ms(total));
> +       do_div(total, NSEC_PER_MSEC);
> +       seq_printf(s, "%llu ms\n", total);
>
>         genpd_unlock(genpd);
>         return ret;
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 67017c9390c8..043d48e4420a 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -98,7 +98,7 @@ struct genpd_power_state {
>         u64 usage;
>         u64 rejected;
>         struct fwnode_handle *fwnode;
> -       ktime_t idle_time;
> +       u64 idle_time;
>         void *data;
>  };
>
> @@ -149,8 +149,8 @@ struct generic_pm_domain {
>                             unsigned int state_count);
>         unsigned int state_count; /* number of states */
>         unsigned int state_idx; /* state that genpd will go to when off */
> -       ktime_t on_time;
> -       ktime_t accounting_time;
> +       u64 on_time;
> +       u64 accounting_time;
>         const struct genpd_lock_ops *lock_ops;
>         union {
>                 struct mutex mlock;
> --
> 2.25.1
>
