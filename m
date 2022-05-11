Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2817523390
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiEKM7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242905AbiEKM7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:59:35 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211BF23277E;
        Wed, 11 May 2022 05:59:34 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2f7bb893309so19616657b3.12;
        Wed, 11 May 2022 05:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hK0TWmQ63rIV8evSU7wMahZjYzTCokxgW35wpQHiwEI=;
        b=UrVeeYeOYoJMoHxBvXLENFGNKYR/C4jR/b1cyx2OIQk/hpYYlBLfBML8yjJDMQlb6z
         3geKhHxEJ5QaGvXMTi6/v6+nhQ6Xat52aH3DxkYEss7vxu0mwN0HqGe3BCa4yGKHw9Ir
         7n1zWySJJgFCytZ2q49eqoUc2jGQaGYNGcG5XcO3AgCO5GK+G2gEm7gqLFKrM6jg+cTz
         rYQC65qX+pOMZVhFQoSMgMpDgyv7CyPO7fPJe5gXZ0y4plGAHEB45G0Iiob0BzO4/tNa
         e2MNLghm8JuL42sdasloqSvS7+boNt+lQdAtPn8jFm/jsoGU11DlEFW3bwRb+/WajkcM
         iJ2g==
X-Gm-Message-State: AOAM532B3O970fzrf8VfwSKRAmCqnvTaM48dhq5StpKTiNYuYRZt7aLb
        M+FMDD/ClLZkv3TBxWllIUkehSdJXly50VBD+O8=
X-Google-Smtp-Source: ABdhPJw/DolRY5gOO990YFHm3Gj/sEt4PIleFoPUt49ZERYyxhwNVcXspcLiy+icS3i0Lr3/i+/ShW+ao45PNhXlers=
X-Received: by 2002:a0d:ddce:0:b0:2f8:c9f7:8f7c with SMTP id
 g197-20020a0dddce000000b002f8c9f78f7cmr25548602ywe.301.1652273973319; Wed, 11
 May 2022 05:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220510035259.5ep52sgahd2a6rie@vireshk-i7> <20220510154236.88753-1-schspa@gmail.com>
 <20220511043515.fn2gz6q3kcpdai5p@vireshk-i7> <CAMA88TpefB=rnqea2u1zEvNUJNE_kdj4mYito7SGCuMj-o071Q@mail.gmail.com>
 <20220511122114.wccgyur6g3qs6fps@vireshk-i7>
In-Reply-To: <20220511122114.wccgyur6g3qs6fps@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 11 May 2022 14:59:22 +0200
Message-ID: <CAJZ5v0gN_yDFpvCXRXv8rN-i3TugCi-HKpBKK2z4eWU0Zm1GUg@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: fix race on cpufreq online
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Schspa Shi <schspa@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
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

On Wed, May 11, 2022 at 2:21 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 11-05-22, 16:10, Schspa Shi wrote:
> > Viresh Kumar <viresh.kumar@linaro.org> writes:
> > > I am not sure, but maybe there were issues in calling init() with rwsem held, as
> > > it may want to call some API from there.
> > >
> >
> > I have checked all the init() implement of the fellowing files, It should be OK.
> > Function find command:
> >   ag "init[\s]+=" drivers/cpufreq
> >
> > All the init() implement only initialize policy object without holding this lock
> > and won't call cpufreq APIs need to hold this lock.
>
> Okay, we can see if someone complains later then :)
>
> > > I don't think you can do that safely. offline() or exit() may depend on
> > > policy->cpus being set to all CPUs.
> > OK, I will move this after exit(). and there will be no effect with those
> > two APIs. But policy->cpus must be clear before release policy->rwsem.
>
> Hmm, I don't think depending on the values of policy->cpus is a good idea to be
> honest. This design is inviting bugs to come in at another place. We need a
> clear flag for this, a new flag or something like policy_list.
>
> Also I see the same bug happening while the policy is removed. The kobject is
> put after the rwsem is dropped.
>
> > >  static inline bool policy_is_inactive(struct cpufreq_policy *policy)
> > >  {
> > > -     return cpumask_empty(policy->cpus);
> > > +     return unlikely(cpumask_empty(policy->cpus) ||
> > > +                     list_empty(&policy->policy_list));
> > >  }
> > >
> >
> > I don't think this fully solves my problem.
> > 1. There is some case which cpufreq_online failed after the policy is added to
> >    cpufreq_policy_list.
>
> And I missed that :(
>
> > 2. policy->policy_list is not protected by &policy->rwsem, and we
> > can't relay on this to
> >    indict the policy is fine.
>
> Ahh..
>
> > >From this point of view, we can fix this problem through the state of
> > this linked list.
> > But the above two problems need to be solved first.
>
> I feel overriding policy_list for this is going to make it complex/messy.
>
> Maybe something like this then:

There are two things.

One is the possible race with respect to the sysfs access occurring
during failing initialization and the other is that ->offline() or
->exit() can be called with or without holding the policy rwsem
depending on the code path.

Namely, cpufreq_offline() calls them under the policy rwsem, but
cpufreq_remove_dev() calls ->exit() outside the rwsem.  Also they are
called outside the rwsem in cpufreq_online().

Moreover, ->offline() and ->exit() cannot expect policy->cpus to be
populated, because they are called when it is empty from
cpufreq_offline().

So the $subject patch is correct AFAICS even though it doesn't address
all of the above.

>
> -------------------------8<-------------------------
>
> From dacc8d09d4d7b3d9a8bca8d78fc72199c16dc4a5 Mon Sep 17 00:00:00 2001
> Message-Id: <dacc8d09d4d7b3d9a8bca8d78fc72199c16dc4a5.1652271581.git.viresh.kumar@linaro.org>
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Wed, 11 May 2022 09:13:26 +0530
> Subject: [PATCH] cpufreq: Allow sysfs access only for active policies
>
> It is currently possible, in a corner case, to access the sysfs files
> and reach show_cpuinfo_cur_freq(), etc, for a partly initialized policy.
>
> This can happen for example if cpufreq_online() fails after adding the
> sysfs files, which are immediately accessed by another process. There
> can easily be other such cases, which aren't identified yet, like while
> the policy is getting freed.
>
> Process A:                                      Process B
>
> cpufreq_online()
>   down_write(&policy->rwsem);
>   if (new_policy) {
>     ret = cpufreq_add_dev_interface(policy);
>     /* This fails after adding few files */
>     if (ret)
>       goto out_destroy_policy;
>
>     ...
>   }
>
>   ...
>
> out_destroy_policy:
>   ...
>   up_write(&policy->rwsem);
>                                                 /*
>                                                  * This will end up accessing the policy
>                                                  * which isn't fully initialized.
>                                                  */
>                                                 show_cpuinfo_cur_freq()
>
> if (cpufreq_driver->offline)
>     cpufreq_driver->offline(policy);
>
>   if (cpufreq_driver->exit)
>     cpufreq_driver->exit(policy);
>
>   cpufreq_policy_free(policy);
>
> Fix these by checking in show/store if the policy is sysfs ready or not.
>
> Reported-by: Schspa Shi <schspa@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 18 ++++++++++++++----
>  include/linux/cpufreq.h   |  3 +++
>  2 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index c8bf6c68597c..65c2bbcf555d 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -948,13 +948,14 @@ static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
>  {
>         struct cpufreq_policy *policy = to_policy(kobj);
>         struct freq_attr *fattr = to_attr(attr);
> -       ssize_t ret;
> +       ssize_t ret = -EBUSY;
>
>         if (!fattr->show)
>                 return -EIO;
>
>         down_read(&policy->rwsem);
> -       ret = fattr->show(policy, buf);
> +       if (policy->sysfs_ready)
> +               ret = fattr->show(policy, buf);
>         up_read(&policy->rwsem);
>
>         return ret;
> @@ -965,7 +966,7 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
>  {
>         struct cpufreq_policy *policy = to_policy(kobj);
>         struct freq_attr *fattr = to_attr(attr);
> -       ssize_t ret = -EINVAL;
> +       ssize_t ret = -EBUSY;
>
>         if (!fattr->store)
>                 return -EIO;
> @@ -979,7 +980,8 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
>
>         if (cpu_online(policy->cpu)) {
>                 down_write(&policy->rwsem);
> -               ret = fattr->store(policy, buf, count);
> +               if (policy->sysfs_ready)
> +                       ret = fattr->store(policy, buf, count);
>                 up_write(&policy->rwsem);
>         }
>
> @@ -1280,6 +1282,11 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>         unsigned long flags;
>         int cpu;
>
> +       /* Disallow sysfs interactions now */
> +       down_write(&policy->rwsem);
> +       policy->sysfs_ready = false;
> +       up_write(&policy->rwsem);
> +
>         /* Remove policy from list */
>         write_lock_irqsave(&cpufreq_driver_lock, flags);
>         list_del(&policy->policy_list);
> @@ -1516,6 +1523,9 @@ static int cpufreq_online(unsigned int cpu)
>                 goto out_destroy_policy;
>         }
>
> +       /* We can allow sysfs interactions now */
> +       policy->sysfs_ready = true;
> +
>         up_write(&policy->rwsem);
>
>         kobject_uevent(&policy->kobj, KOBJ_ADD);
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 35c7d6db4139..7e4384e535fd 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -101,6 +101,9 @@ struct cpufreq_policy {
>          */
>         struct rw_semaphore     rwsem;
>
> +       /* Policy is ready for sysfs interactions */
> +       bool                    sysfs_ready;
> +
>         /*
>          * Fast switch flags:
>          * - fast_switch_possible should be set by the driver if it can
> --
> 2.31.1.272.g89b43f80a514
>
