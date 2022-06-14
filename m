Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F46354B287
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 15:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240718AbiFNNwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 09:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiFNNwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:52:00 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAD0377D8;
        Tue, 14 Jun 2022 06:51:58 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-30c2f288f13so30166727b3.7;
        Tue, 14 Jun 2022 06:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Oadu/kb7D/MBtdN1EAdB7NNOyY5NUmks3Xe0AFaOxI=;
        b=dQk5mdgbTjIBYsxJHcizJcK2dKFjjtFEVURIJZKRCrI2O9L8zGGTX8r8sT3nYicdRA
         xFly7bcHL7Dx/Jk19ythftYSyTrqO9Dq9GA1JdAqQUtyHay8JRJqror3Q0J3pJFmv5JZ
         WSBO768qdCGn2NQd9rwLWBYccB2+71QZ589qi/T38ZzEvFcEYucvxnYhQEkq0/OCJQIj
         JWC0vk3z4msX5Bm2c3ryJIN4RMtEbe6wkj35q6s8gpgK6E8J6j0R2RcntlSKS+YayAws
         NBR8pN0nACO6Afm0In3bk1K2VKRwJPA/bGPG6DX+ie7PtspVdpeguQvSEPJPrNawOB6Z
         CMpA==
X-Gm-Message-State: AJIora8SkuDWUhr1WEBmceW2Vse1eqhEZ7L0NxJsXa8LjNdV4qlzfP0l
        bCq63/POPTgBc537S2p0Iw7NpyA9q3mLtyLEiptlaTO7
X-Google-Smtp-Source: AGRyM1uw67Ese+5wWKuBtoiVnyFv1kAqhirRGL5uPSGAfXwx+M56IWRT9PkE/KNVqzBowTiEpNUWASkYQ0SQ5QdJXfQ=
X-Received: by 2002:a81:3dc6:0:b0:313:cc8a:e39e with SMTP id
 k189-20020a813dc6000000b00313cc8ae39emr5961765ywa.196.1655214718148; Tue, 14
 Jun 2022 06:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1653565641.git.viresh.kumar@linaro.org> <0a6620ff5a330126b21d00244d4fad62cff4f230.1653565641.git.viresh.kumar@linaro.org>
In-Reply-To: <0a6620ff5a330126b21d00244d4fad62cff4f230.1653565641.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Jun 2022 15:51:47 +0200
Message-ID: <CAJZ5v0hU0obSLwCxUX5Qa2Usa7hMoF23mAGxcRK2TCuAYiGZcg@mail.gmail.com>
Subject: Re: [PATCH 3/3] cpufreq: Drop unnecessary cpus locking from store()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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

On Thu, May 26, 2022 at 1:51 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> This change was introduced long back by:
>
> commit 4f750c930822 ("cpufreq: Synchronize the cpufreq store_*() routines with CPU hotplug")
>
> Since then, both cpufreq and hotplug core have been reworked and have
> much better locking in place. The race mentioned in commit 4f750c930822
> isn't possible anymore.
>
> Drop the unnecessary locking.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 53d163a84e06..bb237d1ce5e7 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -973,21 +973,10 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
>         if (!fattr->store)
>                 return -EIO;
>
> -       /*
> -        * cpus_read_trylock() is used here to work around a circular lock
> -        * dependency problem with respect to the cpufreq_register_driver().
> -        */
> -       if (!cpus_read_trylock())
> -               return -EBUSY;
> -
> -       if (cpu_online(policy->cpu)) {
> -               down_write(&policy->rwsem);
> -               if (likely(!policy_is_inactive(policy)))
> -                       ret = fattr->store(policy, buf, count);
> -               up_write(&policy->rwsem);
> -       }
> -
> -       cpus_read_unlock();
> +       down_write(&policy->rwsem);
> +       if (likely(!policy_is_inactive(policy)))
> +               ret = fattr->store(policy, buf, count);
> +       up_write(&policy->rwsem);
>
>         return ret;
>  }
> --

Applied along with the [1/3] as 5.20 material, thanks!
