Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BAE5233C1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243171AbiEKNMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241031AbiEKNMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:12:49 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84B864BE5;
        Wed, 11 May 2022 06:12:44 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-ed9a75c453so2706254fac.11;
        Wed, 11 May 2022 06:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o2Dh4MeWdqreTOUPSop5Ro3qX7Qg777r5NKDOefdzYI=;
        b=JP1gLP2iArbL0gRgZOebzD4QRJhM8/73WMYOip6lL46f6sxYnNzOQAR8glUIPDxRDA
         a4VSj7vpIrR4OLcLk6yiPKftQNYDa8rlVa3fNHYP0TYHXqJR4+MkzovVsm35UfCoTF7l
         LsB7QEUcq4ZXpgs5mdEhjRnnBtG36CesUTlyT9S3eRxWPisI207au0WuI6js4SG0XPT7
         q6A8WIBOCTWk4c7V+4fb3Vge4R3WzDF+TQT6HdkiL3huNA8GQuUfw0xFXGfxtYuSto5d
         23me93dx/PLZN+KTl3Lbdz+h8QhBGM5/lLrIl/+u9MK/xz85iQnrUVxjM7xBn52UoAgb
         EzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o2Dh4MeWdqreTOUPSop5Ro3qX7Qg777r5NKDOefdzYI=;
        b=gUmMYNZQoEtHMCjs60c43t5rQbHGJYrRQJHKXd7Lc7QcSjk5Tr+yA8ZfMiN6UfAjom
         jHkDrYkBeCOk6T3/chU5oQ6O50Ykmo3ddFpV3Ld3r9Z6Zk9Fl1sXcVDvX8y4PWTjkRkB
         J8KHUW5a4OjyV/LfmD8xvqayJXFgqF7rGVKKOnBsC+UPsnAKVctqXylYGkIvNC1bOOCC
         KLQsxIrQgqJUpM+jxxOfryLM7WMsdjmt8zYCNoj4pTgVg4gBMcPS7on+7A6HTDBv9fV5
         4h1j5PKFdvhLR2l3HOXunFaLM5R17wjMJ43AQfUwC3TgxLUVDYcMKGrru5kcAdYdQN1m
         bXPQ==
X-Gm-Message-State: AOAM531ScZgV7Co0YTY36RULplyKxUKozxkzUoZbFT5sm5Z6S0ms8cqL
        37nh8aIhuRiwl0I/u+yEclYb+sfb0NUICvRwsJtiyn+mUjL42A==
X-Google-Smtp-Source: ABdhPJzWCldGy6T/GkQIddyJKIzOW7kgzLPYLyTXswCCWvM/3xXwo7eBomIUyZgUm74ivLDAgFHlh2s90rCjrtzTJ9c=
X-Received: by 2002:a05:6871:611:b0:ed:9b5e:261f with SMTP id
 w17-20020a056871061100b000ed9b5e261fmr2758397oan.276.1652274764103; Wed, 11
 May 2022 06:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220510035259.5ep52sgahd2a6rie@vireshk-i7> <20220510154236.88753-1-schspa@gmail.com>
 <20220511043515.fn2gz6q3kcpdai5p@vireshk-i7> <CAMA88TpefB=rnqea2u1zEvNUJNE_kdj4mYito7SGCuMj-o071Q@mail.gmail.com>
 <20220511122114.wccgyur6g3qs6fps@vireshk-i7>
In-Reply-To: <20220511122114.wccgyur6g3qs6fps@vireshk-i7>
From:   Schspa Shi <schspa@gmail.com>
Date:   Wed, 11 May 2022 21:12:32 +0800
Message-ID: <CAMA88TrJetex5OS6qDbB1T2nc=0Md2gzNsc3YdDk6ihy5w6S+Q@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: fix race on cpufreq online
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Viresh Kumar <viresh.kumar@linaro.org> writes:

> On 11-05-22, 16:10, Schspa Shi wrote:
>> Viresh Kumar <viresh.kumar@linaro.org> writes:
>> > I am not sure, but maybe there were issues in calling init() with rwsem held, as
>> > it may want to call some API from there.
>> >
>>
>> I have checked all the init() implement of the fellowing files, It should be OK.
>> Function find command:
>>   ag "init[\s]+=" drivers/cpufreq
>>
>> All the init() implement only initialize policy object without holding this lock
>> and won't call cpufreq APIs need to hold this lock.
>
> Okay, we can see if someone complains later then :)
>
>> > I don't think you can do that safely. offline() or exit() may depend on
>> > policy->cpus being set to all CPUs.
>> OK, I will move this after exit(). and there will be no effect with those
>> two APIs. But policy->cpus must be clear before release policy->rwsem.
>
> Hmm, I don't think depending on the values of policy->cpus is a good idea to be
> honest. This design is inviting bugs to come in at another place. We need a
> clear flag for this, a new flag or something like policy_list.
>
> Also I see the same bug happening while the policy is removed. The kobject is
> put after the rwsem is dropped.
>
>> >  static inline bool policy_is_inactive(struct cpufreq_policy *policy)
>> >  {
>> > -     return cpumask_empty(policy->cpus);
>> > +     return unlikely(cpumask_empty(policy->cpus) ||
>> > +                     list_empty(&policy->policy_list));
>> >  }
>> >
>>
>> I don't think this fully solves my problem.
>> 1. There is some case which cpufreq_online failed after the policy is added to
>>    cpufreq_policy_list.
>
> And I missed that :(
>
>> 2. policy->policy_list is not protected by &policy->rwsem, and we
>> can't relay on this to
>>    indict the policy is fine.
>
> Ahh..
>
>> >From this point of view, we can fix this problem through the state of
>> this linked list.
>> But the above two problems need to be solved first.
>
> I feel overriding policy_list for this is going to make it complex/messy.
>

Yes, I agree with it.

> Maybe something like this then:
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
> Process A:                                    Process B
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
>                                               /*
>                                                * This will end up accessing the policy
>                                                * which isn't fully initialized.
>                                                */
>                                               show_cpuinfo_cur_freq()
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
>       struct cpufreq_policy *policy = to_policy(kobj);
>       struct freq_attr *fattr = to_attr(attr);
> -     ssize_t ret;
> +     ssize_t ret = -EBUSY;
>
>       if (!fattr->show)
>               return -EIO;
>
>       down_read(&policy->rwsem);
> -     ret = fattr->show(policy, buf);
> +     if (policy->sysfs_ready)
> +             ret = fattr->show(policy, buf);
>       up_read(&policy->rwsem);
>
>       return ret;
> @@ -965,7 +966,7 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
>  {
>       struct cpufreq_policy *policy = to_policy(kobj);
>       struct freq_attr *fattr = to_attr(attr);
> -     ssize_t ret = -EINVAL;
> +     ssize_t ret = -EBUSY;
>
>       if (!fattr->store)
>               return -EIO;
> @@ -979,7 +980,8 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
>
>       if (cpu_online(policy->cpu)) {
>               down_write(&policy->rwsem);
> -             ret = fattr->store(policy, buf, count);
> +             if (policy->sysfs_ready)
> +                     ret = fattr->store(policy, buf, count);
>               up_write(&policy->rwsem);
>       }
>
> @@ -1280,6 +1282,11 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>       unsigned long flags;
>       int cpu;
>
> +     /* Disallow sysfs interactions now */
> +     down_write(&policy->rwsem);
> +     policy->sysfs_ready = false;
> +     up_write(&policy->rwsem);
> +
>       /* Remove policy from list */
>       write_lock_irqsave(&cpufreq_driver_lock, flags);
>       list_del(&policy->policy_list);
> @@ -1516,6 +1523,9 @@ static int cpufreq_online(unsigned int cpu)
>               goto out_destroy_policy;
>       }
>
> +     /* We can allow sysfs interactions now */
> +     policy->sysfs_ready = true;
> +
>       up_write(&policy->rwsem);
>
>       kobject_uevent(&policy->kobj, KOBJ_ADD);
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 35c7d6db4139..7e4384e535fd 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -101,6 +101,9 @@ struct cpufreq_policy {
>        */
>       struct rw_semaphore     rwsem;
>
> +     /* Policy is ready for sysfs interactions */
> +     bool                    sysfs_ready;
> +

Do we need to add this flag to some APIs like
  unsigned int cpufreq_get(unsigned int cpu);
  void refresh_frequency_limits(struct cpufreq_policy *policy);
too ?

But if we made this change it seems to have the same meaning as
policy_is_inactive.

>       /*
>        * Fast switch flags:
>        * - fast_switch_possible should be set by the driver if it can

---
BRs

Schspa Shi
