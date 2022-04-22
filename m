Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B280C50BC61
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377967AbiDVQCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237777AbiDVQCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:02:14 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C3D5DA79;
        Fri, 22 Apr 2022 08:59:20 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id i20so15248455ybj.7;
        Fri, 22 Apr 2022 08:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wz6qjemFOM+Uepl/wvMm48U+1/J/h3Mt/0mg1L+9Kqc=;
        b=R3oXRlgjim6/ydd6OtCZQPC7ETHGku9HUDKYkjTzpPSkmfLiM7Fxql3mA9z6jWzhjx
         4SpjGBfNmi5RJKIG1DNQcpbNQcbYpAHNt2D3BxU830GqRQ7Gk9GWiVT843+e9AS12P2u
         I1u76YK/A8mpt4PTRppitg1P7Fq1pJs3AzuijtnOIIhGuuMCd+uuDQ6lzTXH7HIfBBB3
         MoQP5lJpkxLFDq659+QwyYvab1nP8JtDpDKI/Td9ZFAd6v1DKWwazo1yJL0zTeGx21DY
         k/FG3/vN7eIOHg2t7bWac9PieUkHJbBjrJPY/ljOzkqwcHk4IW80K4kYFNfJXAZW8nk5
         dVZQ==
X-Gm-Message-State: AOAM532jZQH/28su0DC6hUilISbgXNEMS6k300eSe5+mwY1PilRfnz1G
        8QwQq67IJilxdLlISWpBgo69ugbjHr7X7jBiRs8=
X-Google-Smtp-Source: ABdhPJyu9/vdw+6xAgy8dMeVAXoOzN68Ncb0Z9/JmHIE9mWjvcrUf4BDBJZBFUpXYi5szII85Jly0YM/ZBs5EutRh5E=
X-Received: by 2002:a05:6902:1543:b0:642:3fd:316c with SMTP id
 r3-20020a056902154300b0064203fd316cmr5122231ybu.622.1650643160120; Fri, 22
 Apr 2022 08:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220420191541.99528-1-schspa@gmail.com> <CAJZ5v0guPiGx-ZnC0RcqVgDEp0bh4DcKC7QYjjO0PF_3kHdVGg@mail.gmail.com>
 <CAMA88TpEHTEYU3Z_sXFcCXmW+9q=Ks+OSkGNY3N+uAisb+G7Ow@mail.gmail.com>
In-Reply-To: <CAMA88TpEHTEYU3Z_sXFcCXmW+9q=Ks+OSkGNY3N+uAisb+G7Ow@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Apr 2022 17:59:09 +0200
Message-ID: <CAJZ5v0hxoU0nWKMVRfiMU_XSQE9n49CjmhmibEVmEo=+E4kBoA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: fix race on cpufreq online
To:     Schspa Shi <schspa@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
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

On Fri, Apr 22, 2022 at 5:10 PM Schspa Shi <schspa@gmail.com> wrote:
>
> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>
> > On Wed, Apr 20, 2022 at 9:16 PM Schspa Shi <schspa@gmail.com> wrote:
> >>
> >> When cpufreq online failed, policy->cpus are not empty while
> >> cpufreq sysfs file available, we may access some data freed.
> >>
> >> Take policy->clk as an example:
> >>
> >> static int cpufreq_online(unsigned int cpu)
> >> {
> >>   ...
> >>   // policy->cpus != 0 at this time
> >>   down_write(&policy->rwsem);
> >>   ret = cpufreq_add_dev_interface(policy);
> >>   up_write(&policy->rwsem);
> >>
> >>   return 0;
> >>
> >> out_destroy_policy:
> >>         for_each_cpu(j, policy->real_cpus)
> >>                 remove_cpu_dev_symlink(policy, get_cpu_device(j));
> >>     up_write(&policy->rwsem);
> >> ...
> >> out_exit_policy:
> >>   if (cpufreq_driver->exit)
> >>     cpufreq_driver->exit(policy);
> >>       clk_put(policy->clk);
> >>       // policy->clk is a wild pointer
> >> ...
> >>                                     ^
> >>                                     |
> >>                             Another process access
> >>                             __cpufreq_get
> >>                               cpufreq_verify_current_freq
> >>                                 cpufreq_generic_get
> >>                                   // acces wild pointer of policy->clk;
> >>                                     |
> >>                                     |
> >> out_offline_policy:                 |
> >>   cpufreq_policy_free(policy);      |
> >>     // deleted here, and will wait for no body reference
> >>     cpufreq_policy_put_kobj(policy);
> >> }
> >>
> >> Signed-off-by: Schspa Shi <schspa@gmail.com>
> >> ---
> >>  drivers/cpufreq/cpufreq.c | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> >> index 80f535cc8a75..0d58b0f8f3af 100644
> >> --- a/drivers/cpufreq/cpufreq.c
> >> +++ b/drivers/cpufreq/cpufreq.c
> >> @@ -1533,8 +1533,6 @@ static int cpufreq_online(unsigned int cpu)
> >>         for_each_cpu(j, policy->real_cpus)
> >>                 remove_cpu_dev_symlink(policy, get_cpu_device(j));
> >>
> >> -       up_write(&policy->rwsem);
> >> -
> >>  out_offline_policy:
> >>         if (cpufreq_driver->offline)
> >>                 cpufreq_driver->offline(policy);
> >> @@ -1543,6 +1541,9 @@ static int cpufreq_online(unsigned int cpu)
> >>         if (cpufreq_driver->exit)
> >>                 cpufreq_driver->exit(policy);
> >>
> >> +       cpumask_clear(policy->cpus);
> >> +       up_write(&policy->rwsem);
> >
> > This change is correct AFAICS, but it doesn't really fix the race,
> > because show_cpuinfo_cur_freq() uses __cpufreq_get() directly without
> > locking.
>
> There is a lock outside of show_cpuinfo_cur_freq(). Please check about
> static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
> {
>         ......
>         down_read(&policy->rwsem);
>         ret = fattr->show(policy, buf);
>         up_read(&policy->rwsem);
>
>     ......
> }

You are right, my mistake.

OK, I'll queue up the patch, then.
