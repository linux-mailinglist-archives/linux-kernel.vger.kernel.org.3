Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DBF5200BB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237940AbiEIPKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237897AbiEIPKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:10:08 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A4713CD7;
        Mon,  9 May 2022 08:06:13 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-deb9295679so15030223fac.6;
        Mon, 09 May 2022 08:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ec2kuE8yrar64udn0GgU+kpHfgIkfX/pJO2edCpILI=;
        b=lJPRcJ4PECBfMkWJDEH7P2x50CIidv1gXJGMvzJjcxKDPPsMXummz30cPUifBm366t
         Zl1PD1O8KPWNAHA8iVAQvpeIwOoFouCCruNfvs/T0O/ng9Jspt2BAh2VKGXc0nT80qx6
         Zdoqs+8+v3JMNsHkZdTzNONpkp72OAMvfaHDGtm74IbFH+4jcOjUzGvv0tFuAF7ULrWQ
         g+aiUvM8VytpnYwJssBSJ0Hwb3mXMsTCVDbiK50yKwF1UwnydKjSBfF4BnWiiNuBIKC7
         WHKEs5x6btMm/YMzjtyqsvpAirI+xTIV4mLBtgIHSJHpNDNpcm+9yV9l/PSqfcNDGivx
         VbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ec2kuE8yrar64udn0GgU+kpHfgIkfX/pJO2edCpILI=;
        b=KWXZ0X60dW8e9dDcvgjYaN84iA3uO1qMGbtPCm6ujhTfKe2iIzOTgcydSwBg1C6RHA
         QVNi+Kd87uBmfJGdD7jbybn20P8TiHdq+f0CDMFYNG4iV39dnPUGLKEzHVezxUcoGePQ
         Ce+mf1x+6I6RP6sWEHd38lkvyuW42sZG7lOMPzNbRN6USQjw7wNBXH+pYVsgq82U+lvx
         pfdO8oJSOV+czkgSffc/vDMYjqI5hqBOlz7Vzbb8/Ptx+YXHf4522RNas7FXUZiZslBM
         5SEXemyHa+oC/iTWWR+gnzpNhHm0+pN8Gg52U+KnKIg0Lpoqux4Z4+stBB47ulAqVF5O
         5T6A==
X-Gm-Message-State: AOAM532ikvIAnbI2SU1FDpL80M4XeabRa6CPRWiTaWu+qnb+7YFcJ5wy
        cJGVvlNhbHNc0ooDNRbyE9Ne0HuYGRyBzO+tXGhSKjbtnrM=
X-Google-Smtp-Source: ABdhPJwoAMCUS8TlUNJMnlWFfzOYmFNALm9ncaKkdfvUyLoOZGcRyBrdJB9FPdaoRG8XeW+rjvH1DeZiQfPZJZjjyws=
X-Received: by 2002:a05:6871:611:b0:ed:9b5e:261f with SMTP id
 w17-20020a056871061100b000ed9b5e261fmr7720784oan.276.1652108773221; Mon, 09
 May 2022 08:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220420191541.99528-1-schspa@gmail.com> <20220509035746.aeggm4cut2ewcmmk@vireshk-i7>
In-Reply-To: <20220509035746.aeggm4cut2ewcmmk@vireshk-i7>
From:   Schspa Shi <schspa@gmail.com>
Date:   Mon, 9 May 2022 23:06:01 +0800
Message-ID: <CAMA88ToT5Jx1xM20X0DPv9S7hyQY2DuvO0TY6VLJxSwty3PfVw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: fix race on cpufreq online
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

> I had to dig the old patch first before starting to review what your
> next one does.
>
> On 21-04-22, 03:15, Schspa Shi wrote:
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
>
> Please keep some code to help understand where we went from here. I am
> sure you meant that we will error out in this case, but you removed
> the relevant code.
>

Yes, I will add this to the next version of patch.

>>   up_write(&policy->rwsem);
>>
>>   return 0;
>>
>> out_destroy_policy:
>>      for_each_cpu(j, policy->real_cpus)
>>              remove_cpu_dev_symlink(policy, get_cpu_device(j));
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
>>      for_each_cpu(j, policy->real_cpus)
>>              remove_cpu_dev_symlink(policy, get_cpu_device(j));
>>
>> -    up_write(&policy->rwsem);
>> -
>>  out_offline_policy:
>>      if (cpufreq_driver->offline)
>>              cpufreq_driver->offline(policy);
>> @@ -1543,6 +1541,9 @@ static int cpufreq_online(unsigned int cpu)
>>      if (cpufreq_driver->exit)
>>              cpufreq_driver->exit(policy);
>>
>> +    cpumask_clear(policy->cpus);
>> +    up_write(&policy->rwsem);
>
> This is simply buggy as now an error out to out_offline_policy or
> out_exit_policy will try to release a semaphore which was never taken
> in the first place. This works fine only if we failed late, i.e. via
> out_destroy_policy.
>

I am very sorry for this oversight.

To fix this issue, there is no need to move cpufreq_driver->exit(policy)
and cpufreq_driver->offline(policy) to inside of &policy->rwsem.
I made this change because they are inside of &policy->rwsem write lock
at cpufreq_offline. I think we should keep offline & exit call inside of
policy->rwsem for better symmetry.

static int cpufreq_offline(unsigned int cpu)
{
        ...
        down_write(&policy->rwsem);
    ...
        /*
         * Perform the ->offline() during light-weight tear-down, as
         * that allows fast recovery when the CPU comes back.
         */
        if (cpufreq_driver->offline) {
                cpufreq_driver->offline(policy);
        } else if (cpufreq_driver->exit) {
                cpufreq_driver->exit(policy);
                policy->freq_table = NULL;
        }

unlock:
        up_write(&policy->rwsem);
        return 0;
}

> The very first thing we need to do now is revert this patch. Lemme
> send a patch for that and you can send a fresh fix over that once you
> have a stable fix.

For the next version of the stable fix, I'd be willing to keep exit and
offline calls inside of policy->rwsem. But it's OK for me to keep offline
& exit calls outside of policy->rwsem.

---
BRs


Schspa Shi
