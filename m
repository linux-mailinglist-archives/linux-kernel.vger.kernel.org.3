Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACE9522DEC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243369AbiEKIL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiEKILJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:11:09 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43F131DE4;
        Wed, 11 May 2022 01:11:07 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id w123so1841756oiw.5;
        Wed, 11 May 2022 01:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LL7zyeqvib7IGmz5nbaESRxDz7/dY89psh4zs1gsh5g=;
        b=WB2mdfEqPIalZNpqFgJL8HTWuwajYAhaxZ/k7adAH1+11ibSOQ6TKi2/ipQv6M9lgM
         /a0pwZ8isMma22yRqZIOTcTZXApaPwBZgy6h/CrEyzlRzdG09G2Ig9MaLSQtTRqBd+Br
         sJR7qhG4vowOI+7kXENAex9blW48ICtFPQY5A3riUwJnjLlHvomAuRTPAsF0Z0jbtg01
         QeBMYLOeKIu4MEnjWRuS1TDyMWxC7vNsRROdrlUOOhGfjZ0ka/TPK40OuBqsg9g8aj0n
         wG6vktlcTyuW5MBd0mcYh9K682LVTnUEbd5F8mMlKVbXUpyrHLkVNgtuoc5d9SMeOgmV
         O78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LL7zyeqvib7IGmz5nbaESRxDz7/dY89psh4zs1gsh5g=;
        b=q19Cccu9QHTcsIjZHZ3xpeoW0j6G9rNwpySSERznUVCx8VyleC5bOGrnq+k49HW5eP
         0tI485SMrCjtCA9jQ1RpvJRuVraN14Yu2IIfYBCVox9hekEkt1XiCGV3Oy2vZ813jS/P
         7EzZBsh+Th47NL8dAcwyPOILgvK0DFg9kIvEscH04NYMp6rWetroG7pVzwAOUG3CX1km
         dt5Y+E8N7APcw6UxrZlA9hkMZ2jQXT7OeR6jLgLvzaF8zGnZKu1GbZpXyftCccOkyVRO
         pKje1660R5c6v76Lll/6QuC3irAmQTvOkciY45mONBCXKdXucuUtkDVrI1pnpwjh6o5o
         1F1Q==
X-Gm-Message-State: AOAM5315AwlJFehAyeEB92uWhb9ZH8P8owNnKWyMqesffSi4+RHzVuVn
        f4xbJm7xrAvsslqvxLMFiX6hnlt9A3nfjm6tAvSlpol1u6Mxog==
X-Google-Smtp-Source: ABdhPJxj1LRPe88Kw0XzjKR8Bwvz0ZZPS9j/1KFZyC5ekHcWDdYWz9dq7zrgEenLSO5YDJyt5pzHJrnY4y2nhsYRWyA=
X-Received: by 2002:a05:6808:bd4:b0:326:c2e8:2d1e with SMTP id
 o20-20020a0568080bd400b00326c2e82d1emr1873075oik.52.1652256667187; Wed, 11
 May 2022 01:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220510035259.5ep52sgahd2a6rie@vireshk-i7> <20220510154236.88753-1-schspa@gmail.com>
 <20220511043515.fn2gz6q3kcpdai5p@vireshk-i7>
In-Reply-To: <20220511043515.fn2gz6q3kcpdai5p@vireshk-i7>
From:   Schspa Shi <schspa@gmail.com>
Date:   Wed, 11 May 2022 16:10:55 +0800
Message-ID: <CAMA88TpefB=rnqea2u1zEvNUJNE_kdj4mYito7SGCuMj-o071Q@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: fix race on cpufreq online
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
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

> Don't use in-reply-to for single patches. It is mostly used when you are
> updating a single patch in a patchset and it makes sense to continue the
> discussion in the same thread. In this case, we have a fresh patchset and it
> makes the same thread messy.

Thanks for reminding me. will send a new thread for the next time.

>
> On 10-05-22, 23:42, Schspa Shi wrote:
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 80f535cc8a75..d93958dbdab8 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1337,12 +1337,12 @@ static int cpufreq_online(unsigned int cpu)
>>              down_write(&policy->rwsem);
>>              policy->cpu = cpu;
>>              policy->governor = NULL;
>> -            up_write(&policy->rwsem);
>>      } else {
>>              new_policy = true;
>>              policy = cpufreq_policy_alloc(cpu);
>>              if (!policy)
>>                      return -ENOMEM;
>> +            down_write(&policy->rwsem);
>>      }
>
> I am not sure, but maybe there were issues in calling init() with rwsem held, as
> it may want to call some API from there.
>

I have checked all the init() implement of the fellowing files, It should be OK.
Function find command:
  ag "init[\s]+=" drivers/cpufreq

All the init() implement only initialize policy object without holding this lock
and won't call cpufreq APIs need to hold this lock.

drivers/cpufreq/pxa3xx-cpufreq.c
205:    .init           = pxa3xx_cpufreq_init,

drivers/cpufreq/powernow-k7.c
668:    .init           = powernow_cpu_init,

drivers/cpufreq/sparc-us2e-cpufreq.c
334:            driver->init = us2e_freq_cpu_init;

drivers/cpufreq/s5pv210-cpufreq.c
581:    .init           = s5pv210_cpu_init,

drivers/cpufreq/amd-pstate.c
637:    .init           = amd_pstate_cpu_init,

drivers/cpufreq/sc520_freq.c
93:     .init   = sc520_freq_cpu_init,

drivers/cpufreq/tegra186-cpufreq.c
125:    .init = tegra186_cpufreq_init,

drivers/cpufreq/davinci-cpufreq.c
102:    .init           = davinci_cpu_init,

drivers/cpufreq/spear-cpufreq.c
167:    .init           = spear_cpufreq_init,

drivers/cpufreq/acpi-cpufreq.c
950:    .init           = acpi_cpufreq_cpu_init,

drivers/cpufreq/mediatek-cpufreq-hw.c
286:    .init           = mtk_cpufreq_hw_cpu_init,

drivers/cpufreq/cpufreq_conservative.c
323:    .init = cs_init,

drivers/cpufreq/sa1100-cpufreq.c
194:    .init           = sa1100_cpu_init,

drivers/cpufreq/tegra194-cpufreq.c
279:    .init = tegra194_cpufreq_init,

drivers/cpufreq/longrun.c
279:    .init           = longrun_cpu_init,

drivers/cpufreq/cpufreq_userspace.c
119:    .init           = cpufreq_userspace_policy_init,

drivers/cpufreq/brcmstb-avs-cpufreq.c
730:    .init           = brcm_avs_cpufreq_init,

drivers/cpufreq/ia64-acpi-cpufreq.c
328:    .init           = acpi_cpufreq_cpu_init,

drivers/cpufreq/loongson2_cpufreq.c
95:     .init = loongson2_cpufreq_cpu_init,

drivers/cpufreq/omap-cpufreq.c
150:    .init           = omap_cpu_init,

drivers/cpufreq/e_powersaver.c
376:    .init           = eps_cpu_init,

drivers/cpufreq/cpufreq_ondemand.c
409:    .init = od_init,

drivers/cpufreq/s3c24xx-cpufreq.c
426:    .init           = s3c_cpufreq_init,

drivers/cpufreq/scmi-cpufreq.c
280:    .init   = scmi_cpufreq_init,

drivers/cpufreq/scpi-cpufreq.c
198:    .init   = scpi_cpufreq_init,

drivers/cpufreq/gx-suspmod.c
440:    .init           = cpufreq_gx_cpu_init,

drivers/cpufreq/speedstep-centrino.c
509:    .init           = centrino_cpu_init,

drivers/cpufreq/intel_pstate.c
2788:   .init           = intel_pstate_cpu_init,
3110:   .init           = intel_cpufreq_cpu_init,

drivers/cpufreq/kirkwood-cpufreq.c
97:     .init   = kirkwood_cpufreq_cpu_init,

drivers/cpufreq/pasemi-cpufreq.c
247:    .init           = pas_cpufreq_cpu_init,

drivers/cpufreq/elanfreq.c
195:    .init           = elanfreq_cpu_init,

drivers/cpufreq/speedstep-ich.c
316:    .init   = speedstep_cpu_init,

drivers/cpufreq/ppc_cbe_cpufreq.c
138:    .init           = cbe_cpufreq_cpu_init,

drivers/cpufreq/sa1110-cpufreq.c
318:    .init           = sa1110_cpu_init,

drivers/cpufreq/sparc-us3-cpufreq.c
182:            driver->init = us3_freq_cpu_init;

drivers/cpufreq/s3c64xx-cpufreq.c
200:    .init           = s3c64xx_cpufreq_driver_init,

drivers/cpufreq/cppc_cpufreq.c
684:    .init = cppc_cpufreq_cpu_init,

drivers/cpufreq/cpufreq_governor.h
159:            .init = cpufreq_dbs_governor_init,                      \

drivers/cpufreq/qoriq-cpufreq.c
254:    .init           = qoriq_cpufreq_cpu_init,

drivers/cpufreq/vexpress-spc-cpufreq.c
473:    .init                   = ve_spc_cpufreq_init,

drivers/cpufreq/pmac64-cpufreq.c
331:    .init           = g5_cpufreq_cpu_init,

drivers/cpufreq/pmac32-cpufreq.c
439:    .init           = pmac_cpufreq_cpu_init,

drivers/cpufreq/longhaul.c
906:    .init   = longhaul_cpu_init,

drivers/cpufreq/pxa2xx-cpufreq.c
296:    .init   = pxa_cpufreq_init,

drivers/cpufreq/pcc-cpufreq.c
574:    .init = pcc_cpufreq_cpu_init,

drivers/cpufreq/loongson1-cpufreq.c
123:    .init           = ls1x_cpufreq_init,

drivers/cpufreq/s3c2416-cpufreq.c
483:    .init           = s3c2416_cpufreq_driver_init,

drivers/cpufreq/powernow-k6.c
253:    .init           = powernow_k6_cpu_init,

drivers/cpufreq/p4-clockmod.c
227:    .init           = cpufreq_p4_cpu_init,

drivers/cpufreq/powernv-cpufreq.c
1036:   .init           = powernv_cpufreq_cpu_init,

drivers/cpufreq/imx6q-cpufreq.c
205:    .init = imx6q_cpufreq_init,

drivers/cpufreq/sh-cpufreq.c
154:    .init           = sh_cpufreq_cpu_init,

drivers/cpufreq/powernow-k8.c
1143:   .init           = powernowk8_cpu_init,

drivers/cpufreq/maple-cpufreq.c
150:    .init           = maple_cpufreq_cpu_init,

drivers/cpufreq/cpufreq-dt.c
181:    .init = cpufreq_init,

drivers/cpufreq/speedstep-smi.c
295:    .init           = speedstep_cpu_init,

drivers/cpufreq/qcom-cpufreq-hw.c
626:    .init           = qcom_cpufreq_hw_cpu_init,

drivers/cpufreq/mediatek-cpufreq.c
470:    .init = mtk_cpufreq_init,

drivers/cpufreq/bmips-cpufreq.c
153:    .init           = bmips_cpufreq_init,

drivers/cpufreq/cpufreq-nforce2.c
373:    .init = nforce2_cpu_init,

>>      if (!new_policy && cpufreq_driver->online) {
>> @@ -1382,7 +1382,6 @@ static int cpufreq_online(unsigned int cpu)
>>              cpumask_copy(policy->related_cpus, policy->cpus);
>>      }
>>
>> -    down_write(&policy->rwsem);
>>      /*
>>       * affected cpus must always be the one, which are online. We aren't
>>       * managing offline cpus here.
>> @@ -1533,7 +1532,7 @@ static int cpufreq_online(unsigned int cpu)
>>      for_each_cpu(j, policy->real_cpus)
>>              remove_cpu_dev_symlink(policy, get_cpu_device(j));
>>
>> -    up_write(&policy->rwsem);
>> +    cpumask_clear(policy->cpus);
>
> I don't think you can do that safely. offline() or exit() may depend on
> policy->cpus being set to all CPUs.
>

OK, I will move this after exit(). and there will be no effect with those
two APIs. But policy->cpus must be clear before release policy->rwsem.

>>
>>  out_offline_policy:
>>      if (cpufreq_driver->offline)
>> @@ -1542,6 +1541,7 @@ static int cpufreq_online(unsigned int cpu)
>>  out_exit_policy:
>>      if (cpufreq_driver->exit)
>>              cpufreq_driver->exit(policy);
>> +    up_write(&policy->rwsem);
>>
>>  out_free_policy:
>>      cpufreq_policy_free(policy);
>
> Apart from the issues highlighted about, I think we are trying to fix an issue
> locally which can happen at other places as well. Does something like this fix
> your problem at hand ?
>
> Untested.
>
> --
> viresh
>
> -------------------------8<-------------------------
>
> From e379921d3efa58a40d9565a4506a2580318a437d Mon Sep 17 00:00:00 2001
> Message-Id: <e379921d3efa58a40d9565a4506a2580318a437d.1652243573.git.viresh.kumar@linaro.org>
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Wed, 11 May 2022 09:13:26 +0530
> Subject: [PATCH] cpufreq: Allow sysfs access only for active policies
>
> It is currently possible, in a corner case, to access the sysfs files
> and reach show_cpuinfo_cur_freq(), etc, for a partly initialized policy.
>
> This can happen for example if cpufreq_online() fails after adding the
> sysfs files, which are immediately accessed by another process. There
> can easily be other such cases, which aren't identified yet.
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
> Fix these by checking in show/store if the policy is active or not and
> update policy_is_inactive() to also check if the policy is added to the
> global list or not.
>
> Reported-by: Schspa Shi <schspa@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 10 ++++++----
>  include/linux/cpufreq.h   |  3 ++-
>  2 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index fbaa8e6c7d23..036314d05ded 100644
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
> +     if (!policy_is_inactive(policy))
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
> +             if (!policy_is_inactive(policy))
> +                     ret = fattr->store(policy, buf, count);
>               up_write(&policy->rwsem);
>       }
>
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 35c7d6db4139..03e5e114c996 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -209,7 +209,8 @@ static inline void cpufreq_cpu_put(struct cpufreq_policy *policy) { }
>
>  static inline bool policy_is_inactive(struct cpufreq_policy *policy)
>  {
> -     return cpumask_empty(policy->cpus);
> +     return unlikely(cpumask_empty(policy->cpus) ||
> +                     list_empty(&policy->policy_list));
>  }
>

I don't think this fully solves my problem.
1. There is some case which cpufreq_online failed after the policy is added to
   cpufreq_policy_list.
2. policy->policy_list is not protected by &policy->rwsem, and we
can't relay on this to
   indict the policy is fine.

From this point of view, we can fix this problem through the state of
this linked list.
But the above two problems need to be solved first.

1. Remove policy from cpufreq_policy_list when cpufreq_init_policy failed.
>  static inline bool policy_is_shared(struct cpufreq_policy *policy)

static int cpufreq_online(unsigned int cpu)
{
        ......
        if (new_policy) {
                ret = cpufreq_add_dev_interface(policy);
                if (ret)
                        goto out_destroy_policy;

                cpufreq_stats_create_table(policy);

                write_lock_irqsave(&cpufreq_driver_lock, flags);
                list_add(&policy->policy_list, &cpufreq_policy_list);
                write_unlock_irqrestore(&cpufreq_driver_lock, flags);
        }
        ret = cpufreq_init_policy(policy);
        if (ret) {
                pr_err("%s: Failed to initialize policy for cpu: %d (%d)\n",
                       __func__, cpu, ret);
                goto out_destroy_policy;
        }

        up_write(&policy->rwsem);
        ......
        return 0;

out_destroy_policy:
        for_each_cpu(j, policy->real_cpus)
                remove_cpu_dev_symlink(policy, get_cpu_device(j));

        if (new_policy) {
                write_lock_irqsave(&cpufreq_driver_lock, flags);
                list_del(&policy->policy_list);
                write_unlock_irqrestore(&cpufreq_driver_lock, flags);
    }

        up_write(&policy->rwsem);

2. we need to add lock to cpufreq_policy_free.
static void cpufreq_policy_free(struct cpufreq_policy *policy)
{
        unsigned long flags;
        int cpu;

        /* add write lock to make &policy->policy_list stable. */
        down_write(&policy->rwsem);
        /* Remove policy from list */
        write_lock_irqsave(&cpufreq_driver_lock, flags);
        list_del(&policy->policy_list);
        ......
        kfree(policy->min_freq_req);

        up_write(&policy->rwsem);
        cpufreq_policy_put_kobj(policy);
        free_cpumask_var(policy->real_cpus);
        free_cpumask_var(policy->related_cpus);
        free_cpumask_var(policy->cpus);
        kfree(policy);
        ......
}


--
Zhaohui Shi
BRs
