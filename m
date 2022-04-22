Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563CD50BB53
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444669AbiDVPOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354558AbiDVPNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:13:48 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88325D5D1;
        Fri, 22 Apr 2022 08:10:51 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id bc42so3956664vkb.12;
        Fri, 22 Apr 2022 08:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oDJ25/TckqjulH3Kz4Oc6VlKVfCbM4oJIYil6OeGKgs=;
        b=qf+tYKgkgctIGlv3XQUSJG8kmbBYRFP1CtoIpeLiC3ROiDcWqMZc5fwfeNsHvQaOIv
         GrttfdFBuJ88iHN/2Cp+jZO1yFJQb4VBt0XkdNBuoO2QLu2GlDK0Pqaa0yGMKlV4D2pI
         1TuyvXqOg+zlLW1zlju9UgIaZUAFphl6N1RQzBzDbQzoo4c7Vhap80K/NKLPQuRFGD2w
         Ee8q7f3tiEQU8igesrCEsEWbPPsBQnln8TM1M0E4osrUKR7ANN2eF8Brc1J1U+bM0UBg
         s4bYXKtR+lHbQ9s3jiEqRR10WLsQdgAY/L4zu/Y7X6tgoRMCFCpR7uSpIg0k3HQCIje9
         6M8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oDJ25/TckqjulH3Kz4Oc6VlKVfCbM4oJIYil6OeGKgs=;
        b=RtBJ7lq/8gARipWQj7Ce1LGSxvtKgXUSFKCnXyg6uer8Iefen8NOVOCiArAxuV23ps
         CP/XlCSFT1pzUbld4igWzkxdW6RR2mRJ3FUsBgo5EcJEx+FhvJf1buoN+cZp3Eff6RZi
         ohDUCeTxPB3ITtYpoCY/Vk7dG9bS2aY6PAhiesWRPba1buB8n3cv2HMR7jI66AUOwlGq
         oXd4iBJ8ZzQWYieLVGD+HiRN296AI4lp9Ob7wlIUf6XXWPQRHGPNMoK2kquZkvR7Mhjd
         OtOjTLT9/Zc7gIFDjCuFimBCJD33uGV+83Z9X0UQVuoWfNiwU2sAYdUDY+5oktZ46gaJ
         E+zA==
X-Gm-Message-State: AOAM533CZDhMQF5xLiL2pftRYQmr014GIY0fzITBLd+mLbwp0S3Si0lL
        S5PH0WzDU9/WAiOyS+aFTlf/gQScDnklYPR4UJrw1abz
X-Google-Smtp-Source: ABdhPJzkQoGKG2TY6Zox/4S1noDfPT/RID/EUBV3B3Lb692c42FvomcVLfSE/jve7rFcWk2x6WkDE8JAs0t3srD1/CE=
X-Received: by 2002:a1f:2494:0:b0:348:491:d046 with SMTP id
 k142-20020a1f2494000000b003480491d046mr1967180vkk.22.1650640250738; Fri, 22
 Apr 2022 08:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220420191541.99528-1-schspa@gmail.com> <CAJZ5v0guPiGx-ZnC0RcqVgDEp0bh4DcKC7QYjjO0PF_3kHdVGg@mail.gmail.com>
In-Reply-To: <CAJZ5v0guPiGx-ZnC0RcqVgDEp0bh4DcKC7QYjjO0PF_3kHdVGg@mail.gmail.com>
From:   Schspa Shi <schspa@gmail.com>
Date:   Fri, 22 Apr 2022 23:10:39 +0800
Message-ID: <CAMA88TpEHTEYU3Z_sXFcCXmW+9q=Ks+OSkGNY3N+uAisb+G7Ow@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: fix race on cpufreq online
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Wed, Apr 20, 2022 at 9:16 PM Schspa Shi <schspa@gmail.com> wrote:
>>
>> When cpufreq online failed, policy->cpus are not empty while
>> cpufreq sysfs file available, we may access some data freed.
>>
>> Take policy->clk as an example:
>>
>> static int cpufreq_online(unsigned int cpu)
>> {
>>   ...
>>   // policy->cpus != 0 at this time
>>   down_write(&policy->rwsem);
>>   ret = cpufreq_add_dev_interface(policy);
>>   up_write(&policy->rwsem);
>>
>>   return 0;
>>
>> out_destroy_policy:
>>         for_each_cpu(j, policy->real_cpus)
>>                 remove_cpu_dev_symlink(policy, get_cpu_device(j));
>>     up_write(&policy->rwsem);
>> ...
>> out_exit_policy:
>>   if (cpufreq_driver->exit)
>>     cpufreq_driver->exit(policy);
>>       clk_put(policy->clk);
>>       // policy->clk is a wild pointer
>> ...
>>                                     ^
>>                                     |
>>                             Another process access
>>                             __cpufreq_get
>>                               cpufreq_verify_current_freq
>>                                 cpufreq_generic_get
>>                                   // acces wild pointer of policy->clk;
>>                                     |
>>                                     |
>> out_offline_policy:                 |
>>   cpufreq_policy_free(policy);      |
>>     // deleted here, and will wait for no body reference
>>     cpufreq_policy_put_kobj(policy);
>> }
>>
>> Signed-off-by: Schspa Shi <schspa@gmail.com>
>> ---
>>  drivers/cpufreq/cpufreq.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 80f535cc8a75..0d58b0f8f3af 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1533,8 +1533,6 @@ static int cpufreq_online(unsigned int cpu)
>>         for_each_cpu(j, policy->real_cpus)
>>                 remove_cpu_dev_symlink(policy, get_cpu_device(j));
>>
>> -       up_write(&policy->rwsem);
>> -
>>  out_offline_policy:
>>         if (cpufreq_driver->offline)
>>                 cpufreq_driver->offline(policy);
>> @@ -1543,6 +1541,9 @@ static int cpufreq_online(unsigned int cpu)
>>         if (cpufreq_driver->exit)
>>                 cpufreq_driver->exit(policy);
>>
>> +       cpumask_clear(policy->cpus);
>> +       up_write(&policy->rwsem);
>
> This change is correct AFAICS, but it doesn't really fix the race,
> because show_cpuinfo_cur_freq() uses __cpufreq_get() directly without
> locking.

There is a lock outside of show_cpuinfo_cur_freq(). Please check about
static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
{
        ......
        down_read(&policy->rwsem);
        ret = fattr->show(policy, buf);
        up_read(&policy->rwsem);

    ......
}

>
> It should use cpufreq_get() instead.
>
>> +
>>  out_free_policy:
>>         cpufreq_policy_free(policy);
>>         return ret;
>> --

--
Schspa Shi
BRs
