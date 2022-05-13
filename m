Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3912525B2C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377154AbiEMGGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiEMGGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:06:43 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262E252B12;
        Thu, 12 May 2022 23:06:42 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id i66so9006503oia.11;
        Thu, 12 May 2022 23:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ta0zjWyQVAIpUStd+EoKjcOd35654cN/rN0ezD7IRCc=;
        b=HZOz6LoW70kiZkhv/HaavFOgCakQoNmJV3irPjIW9Z4eCKI4yKwe/gTy0W93k7QOWU
         sgHfxx4PgSkzDXejQy0qpOsD+K1akti9rx/KYOFdhK0ApZ2w8y08sC1E13DVg/0Vtcea
         HGOlnkAf0RP8kcNh+s/QhaSmasPRyeotWpcx7GWELD+021y83aJMPjTK88ml3besc/Ho
         Y+jOopX3P+QRebjFLdOCYPr/bqMur+EpA7IrdpXUO/RyismVjvbLa4cW4xX/xk9/PH/B
         GYXKFi93udIQDWRusf3fPbdQv9ICc8SwlNLIb3l25agRGvKlHH+6LeLu88+AkchnTLhN
         +nng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ta0zjWyQVAIpUStd+EoKjcOd35654cN/rN0ezD7IRCc=;
        b=TBSFQLhLixQVferlmuwbbt/k9dRv+9bn+z/e9b1xIa0/hPBvdJmhRNqtyTH4z3eMxg
         LyoDu9BMSukd+/ZfHZXmPZKAixFYKt0RreMLvWe/AVkUmCUZptF8SlC91RRz5mhGXxeR
         pnVntqkwWVI2zSoaO495tSeE92zWkitzbCEWgfxQuHLVkH6BRTg6CK0vMeWr6o8PYXWk
         vRhlWpvud74SmtKQSz5Z9VK9YlQ3y4zT7ihLI8ZYxr+kanGa1fF1EwSKQNAZpxlU8ljB
         Mfazwpnf+mtGQChROstBaDx52XZj7HaYiBOsai5joxeOJBHawdLBVxVmxd2xLqAkztFj
         J5Fg==
X-Gm-Message-State: AOAM530VAH+Csl64HTpL2Rs9cM9UPLEG50q+GK0+AV2k/IpdwA6qwRYh
        bO3cWF9uPQWaw1cnlwjxKM5var8/8q1FcMozR1IsBP+03IYHKg==
X-Google-Smtp-Source: ABdhPJzQrZjJI9PKYWEM7bZnZ4c2/TqdMP4L9BuzZP7RVV0nSvSNRcc6qWayEVx6dxUf9NgO679bICk+RuG12Or/V5U=
X-Received: by 2002:a05:6808:bd4:b0:326:c2e8:2d1e with SMTP id
 o20-20020a0568080bd400b00326c2e82d1emr1692884oik.52.1652422001409; Thu, 12
 May 2022 23:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220512135231.10076-1-schspa@gmail.com> <20220513041833.mcubozfhl2qd2rps@vireshk-i7>
In-Reply-To: <20220513041833.mcubozfhl2qd2rps@vireshk-i7>
From:   Schspa Shi <schspa@gmail.com>
Date:   Fri, 13 May 2022 14:06:29 +0800
Message-ID: <CAMA88Tpjms4HEos0GJHmQR5YZd4hhdqpgMO7JmxTxVpF0oMUCg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] cpufreq: fix race on cpufreq online
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

> On 12-05-22, 21:52, Schspa Shi wrote:
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
>>   down_write(&policy->rwsem);
>>   ...
>>   /* cpufreq nitialization fails in some cases */
>>   if (cpufreq_driver->get && has_target()) {
>>     policy->cur = cpufreq_driver->get(policy->cpu);
>>     if (!policy->cur) {
>>       ret = -EIO;
>>       pr_err("%s: ->get() failed\n", __func__);
>>       goto out_destroy_policy;
>>     }
>>   }
>>   ...
>>   up_write(&policy->rwsem);
>>   ...
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
>> We can fix it by clear the policy->cpus mask.
>> Both show_scaling_cur_freq and show_cpuinfo_cur_freq will return an
>> error by checking this mask, thus avoiding UAF.
>
> Instead of all above, what about this.
>
> Subject: Abort show/store for half initialized policy
>
> If policy initialization fails after the sysfs files are created,
> there is a possibility that we may end up running show()/store()
> callbacks for half initialized policies, which may have unpredictable
> outcomes.
>
> Abort show/store in such a case by making sure the policy is active.
> Also inactivate the policy on such failures.
>

Yes, I think it's OK, let me upload a new patch V5 for it ?

>> Signed-off-by: Schspa Shi <schspa@gmail.com>
>>
>> ---
>>
>> Changelog:
>> v1 -> v2:
>>         - Fix bad critical region enlarge which causes uninitialized
>>           unlock.
>>         - Move cpumask_clear(policy->cpus); before out_offline_policy
>> v2 -> v3:
>>         - Remove the missed down_write() before
>>           cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
>> v3 -> v4:
>>         - Seprate to two patchs.
>>         - Add policy_is_inactive check before sysfs access
>> ---
>>  drivers/cpufreq/cpufreq.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 80f535cc8a75..35dffd738580 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -953,7 +953,10 @@ static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
>>              return -EIO;
>>
>>      down_read(&policy->rwsem);
>> -    ret = fattr->show(policy, buf);
>> +    if (unlikely(policy_is_inactive(policy)))
>> +            ret = -EBUSY;
>> +    else
>> +            ret = fattr->show(policy, buf);
>
> I like it the way I have done earlier, initialize ret to -EBUSY and
> get rid of the else part and call show/store in if itself. Same for
> below.
>

I add a unlikely here, to avoid branch prediction failed. And move the
to the fail path to avoid a register assignment to -EBUSY.

I think it's better for performance.

You can verify this at the disassamble of show function.

(gdb) disassemble /s show
Dump of assembler code for function show:
   0x00000000000037b8 <+0>:     paciasp
   0x00000000000037bc <+4>:     stp     x29, x30, [sp, #-48]!
   0x00000000000037c0 <+8>:     ldr     x8, [x1, #16]
   0x00000000000037c4 <+12>:    stp     x22, x21, [sp, #16]
   0x00000000000037c8 <+16>:    stp     x20, x19, [sp, #32]
   0x00000000000037cc <+20>:    mov     x29, sp
   0x00000000000037d0 <+24>:    cbz     x8, 0x3820 <show+104>
   0x00000000000037d4 <+28>:    sub     x22, x0, #0x1b8
   0x00000000000037d8 <+32>:    add     x19, x22, #0x218
   0x00000000000037dc <+36>:    mov     x0, x19
   0x00000000000037e0 <+40>:    mov     x20, x2
   0x00000000000037e4 <+44>:    mov     x21, x1
   0x00000000000037e8 <+48>:    bl      0x37e8 <show+48>
   0x00000000000037ec <+52>:    mov     w1, #0x100                      // #256
   0x00000000000037f0 <+56>:    mov     x0, x22
   0x00000000000037f4 <+60>:    bl      0x37f4 <show+60>
   0x00000000000037f8 <+64>:    cmp     x0, #0x100
   0x00000000000037fc <+68>:    b.eq    0x383c <show+132>  // b.none
   // use unlikely to avoid branch prediction failed
   0x0000000000003800 <+72>:    ldr     x8, [x21, #16]
   0x0000000000003804 <+76>:    mov     x0, x22
   0x0000000000003808 <+80>:    mov     x1, x20
   0x000000000000380c <+84>:    blr     x8
   0x0000000000003810 <+88>:    mov     x20, x0
   0x0000000000003814 <+92>:    mov     x0, x19
   0x0000000000003818 <+96>:    bl      0x3818 <show+96>
   0x000000000000381c <+100>:   b       0x3824 <show+108>
   0x0000000000003820 <+104>:   mov     x20, #0xfffffffffffffffb        // #-5
   0x0000000000003824 <+108>:   mov     x0, x20
   0x0000000000003828 <+112>:   ldp     x20, x19, [sp, #32]
   0x000000000000382c <+116>:   ldp     x22, x21, [sp, #16]
   0x0000000000003830 <+120>:   ldp     x29, x30, [sp], #48
   0x0000000000003834 <+124>:   autiasp
   0x0000000000003838 <+128>:   ret
   0x000000000000383c <+132>:   mov     x20, #0xfffffffffffffff0        // #-16
   // this is    ret = -EBUSY, which will not be assigned under normal
circumstances
   0x0000000000003840 <+136>:   b       0x3814 <show+92>

>>      up_read(&policy->rwsem);
>>
>>      return ret;
>> @@ -978,7 +981,10 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
>>
>>      if (cpu_online(policy->cpu)) {
>>              down_write(&policy->rwsem);
>> -            ret = fattr->store(policy, buf, count);
>> +            if (unlikely(policy_is_inactive(policy)))
>> +                    ret = -EBUSY;
>> +            else
>> +                    ret = fattr->store(policy, buf, count);
>>              up_write(&policy->rwsem);
>>      }
>>
>> @@ -1533,6 +1539,7 @@ static int cpufreq_online(unsigned int cpu)
>>      for_each_cpu(j, policy->real_cpus)
>>              remove_cpu_dev_symlink(policy, get_cpu_device(j));
>>
>> +    cpumask_clear(policy->cpus);
>>      up_write(&policy->rwsem);
>>
>>  out_offline_policy:
>> --
>> 2.29.0


--
Schspa Shi
BRs
