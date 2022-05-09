Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CB052034A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 19:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239454AbiEIRMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 13:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbiEIRMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 13:12:51 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356391DF67E;
        Mon,  9 May 2022 10:08:57 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id y2so26111306ybi.7;
        Mon, 09 May 2022 10:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MlJ2kEMj8cXOg3SwHVjy6hDQMego6crqK0D4CKhudAE=;
        b=5o3JitCR6epNC9Guo6XV90Mhe4S2a5BCWK2B4iH/ovIh6Zb375JE6S9m4U51luNA29
         OnJLM1vTFaOIBMhFlMegBdO9NlF+lL8h7rCGgEbnhIHtKzTtjySQQulV5+Px9gRQjFEf
         Y2qdXvP/5xe1Um+4fkDZ+/jEvbCFqCFa2FWD1fkkdUYDnU/sRuFCQSmpn8SunXeqDmGQ
         y4oY4eVxlIc5DR0YCw8NVSS1r0D6RC7qOegVMXxKTRVe9JTKPdHOYXetFM1yAsgalC9n
         fx3+O40lF8TCU3ty0jt1p/z7zxFjMB5VWFojLuFPEKoYgWayxx5YIjoRo3e6oDzWQWGJ
         KXXQ==
X-Gm-Message-State: AOAM5327auYxNjD9Qn18lU1QwZcGJ4xA7gbYPYFpNfQplQHZBD8dh00w
        5DwXizOQ66KEmPL8/3PXPwinRuFcjN3mQKZRKeM=
X-Google-Smtp-Source: ABdhPJzNH7k0ngDG/21vShiiC41r6x0C2z0f1L0hOHknfZ/PUHBP5Votk2wmnb5CUh5LUjI5E+R/EwVD3cJ39tTZKB8=
X-Received: by 2002:a25:da84:0:b0:648:423e:57b0 with SMTP id
 n126-20020a25da84000000b00648423e57b0mr13738485ybf.137.1652116135342; Mon, 09
 May 2022 10:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <7f505491f4e8207bb5d79b1b7b34a28b6d1f03b6.1652068655.git.viresh.kumar@linaro.org>
In-Reply-To: <7f505491f4e8207bb5d79b1b7b34a28b6d1f03b6.1652068655.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 9 May 2022 19:08:44 +0200
Message-ID: <CAJZ5v0jVTQSe47hNeON-FmxTXXXTSkTpoJv==CT4c_zYkbV0OA@mail.gmail.com>
Subject: Re: [PATCH] Revert "cpufreq: Fix possible race in cpufreq online
 error path"
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Schspa Shi <schspa@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
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

On Mon, May 9, 2022 at 5:57 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> This reverts commit f346e96267cd76175d6c201b40f770c0116a8a04.
>
> The commit tried to fix a possible real bug but it made it even worse.
> The fix was simply buggy as now an error out to out_offline_policy or
> out_exit_policy will try to release a semaphore which was never taken in
> the first place. This works fine only if we failed late, i.e. via
> out_destroy_policy.
>
> Fixes: f346e96267cd ("cpufreq: Fix possible race in cpufreq online error path")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

I should have caught the breakage in this patch, sorry about missing it.

> ---
>  drivers/cpufreq/cpufreq.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 233e8af48848..fbaa8e6c7d23 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1534,6 +1534,8 @@ static int cpufreq_online(unsigned int cpu)
>         for_each_cpu(j, policy->real_cpus)
>                 remove_cpu_dev_symlink(policy, get_cpu_device(j));
>
> +       up_write(&policy->rwsem);
> +
>  out_offline_policy:
>         if (cpufreq_driver->offline)
>                 cpufreq_driver->offline(policy);
> @@ -1542,9 +1544,6 @@ static int cpufreq_online(unsigned int cpu)
>         if (cpufreq_driver->exit)
>                 cpufreq_driver->exit(policy);
>
> -       cpumask_clear(policy->cpus);
> -       up_write(&policy->rwsem);
> -
>  out_free_policy:
>         cpufreq_policy_free(policy);
>         return ret;
> --
> 2.31.1.272.g89b43f80a514
>
