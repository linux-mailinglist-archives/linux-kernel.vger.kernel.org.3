Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEA8580420
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 20:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbiGYSjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 14:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbiGYSjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 14:39:14 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8994812606;
        Mon, 25 Jul 2022 11:39:13 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id k85so21629298ybk.7;
        Mon, 25 Jul 2022 11:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=KNBJWlyA9+07rg2cUyhq9BlXYJZB1wgorDKxzUoss4M=;
        b=EVpfLVATxqGT4MAojDA8Agv3hxQH671FH00YMJMC85q8ddhnVawmHAovD0CLN1XTid
         SGS/eAagH1yvxA3Q2yx4Fq1YPcYXP9+JoCPnVA322D87ZXaWPYXOXCW6Y7/xh1FjZZpv
         upyX5twC7NqUASvakYBc2Q2Q0J1WJpr17LFYmkGiKyAlA8vP4YV0B5a0kFxI6L9PkHAX
         DnrOW7Fz36mymHgVvSeN1Go6XCeFjCnM5XrsMBG5sMEPJL6U149szq6U9CCCkbIkvY7m
         dF1Xl7M6MhSVPUCDN3ITLKHN+D0WNl+ozqvgNTpDmgwcAu5cGF1XrjBCxugtOZQwDHY+
         gckQ==
X-Gm-Message-State: AJIora/M0mFmPOu6Uw8ojE7cNfbgHqJ6dSo1CVMYZ2gi2gKFOC7FPess
        45qVMv0GCCkcbaBEdFuw4xh1JHRUYA8ov1hniaE=
X-Google-Smtp-Source: AGRyM1vh9F2FnMVnL1T6X58l+ieZbZtky/9sMNYl4tilyONYlbyKjxKkf81saKpTjncV4jZOSZKjfUh6W9RA0GdOs+I=
X-Received: by 2002:a25:664f:0:b0:66c:d0f4:36cc with SMTP id
 z15-20020a25664f000000b0066cd0f436ccmr9894684ybm.482.1658774352789; Mon, 25
 Jul 2022 11:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220722025024.454626-1-zhao1.liu@linux.intel.com> <20220725103053.o45ly6rnq7vyfdup@vireshk-i7>
In-Reply-To: <20220725103053.o45ly6rnq7vyfdup@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Jul 2022 20:39:01 +0200
Message-ID: <CAJZ5v0hMTNGWGd881_6hdeqL_69DA90m-wrePt0-aUu0RV6J3Q@mail.gmail.com>
Subject: Re: [patch] cpufreq: ondemand: Use cpumask_var_t for on-stack cpu mask
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Zhao Liu <zhao1.liu@linux.intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhao Liu <zhao1.liu@intel.com>
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

On Mon, Jul 25, 2022 at 12:30 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 22-07-22, 10:50, Zhao Liu wrote:
> > A cpumask structure on the stack can cause a warning with
> > CONFIG_NR_CPUS=8192 (e.g. Ubuntu 22.04 uses this):
> >
> > drivers/cpufreq/cpufreq_ondemand.c: In function 'od_set_powersave_bias':
> > drivers/cpufreq/cpufreq_ondemand.c:449:1: warning: the frame size of
> >       1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> >   449 | }
> >       | ^
> >
> > CONFIG_CPUMASK_OFFSTACK=y is enabled by default for most distros, and
> > hence we can work around the warning by using cpumask_var_t.
> >
> > Signed-off-by: Zhao Liu <zhao1.liu@linux.intel.com>
> > ---
> >  drivers/cpufreq/cpufreq_ondemand.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> > index e8fbf970ff07..c52d19d67557 100644
> > --- a/drivers/cpufreq/cpufreq_ondemand.c
> > +++ b/drivers/cpufreq/cpufreq_ondemand.c
> > @@ -416,10 +416,13 @@ static struct dbs_governor od_dbs_gov = {
> >  static void od_set_powersave_bias(unsigned int powersave_bias)
> >  {
> >       unsigned int cpu;
> > -     cpumask_t done;
> > +     cpumask_var_t done;
> > +
> > +     if (!alloc_cpumask_var(&done, GFP_KERNEL))
> > +             return;
> >
> >       default_powersave_bias = powersave_bias;
> > -     cpumask_clear(&done);
> > +     cpumask_clear(done);
> >
> >       cpus_read_lock();
> >       for_each_online_cpu(cpu) {
> > @@ -428,7 +431,7 @@ static void od_set_powersave_bias(unsigned int powersave_bias)
> >               struct dbs_data *dbs_data;
> >               struct od_dbs_tuners *od_tuners;
> >
> > -             if (cpumask_test_cpu(cpu, &done))
> > +             if (cpumask_test_cpu(cpu, done))
> >                       continue;
> >
> >               policy = cpufreq_cpu_get_raw(cpu);
> > @@ -439,13 +442,15 @@ static void od_set_powersave_bias(unsigned int powersave_bias)
> >               if (!policy_dbs)
> >                       continue;
> >
> > -             cpumask_or(&done, &done, policy->cpus);
> > +             cpumask_or(done, done, policy->cpus);
> >
> >               dbs_data = policy_dbs->dbs_data;
> >               od_tuners = dbs_data->tuners;
> >               od_tuners->powersave_bias = default_powersave_bias;
> >       }
> >       cpus_read_unlock();
> > +
> > +     free_cpumask_var(done);
> >  }
> >
> >  void od_register_powersave_bias_handler(unsigned int (*f)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 5.20 material, thanks!
