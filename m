Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955BD5251BF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356140AbiELQBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343533AbiELQBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:01:30 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EC147558;
        Thu, 12 May 2022 09:01:28 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-ed9a75c453so7131423fac.11;
        Thu, 12 May 2022 09:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BoY7g8nUQQ3BvW0xBl0eILMoOU8tGg7MZ9xjNiqrFPA=;
        b=TH7l9iasZncqnM5kUsqw7GwUDOgqZpjRQ9+dl4GQpL+/5cH5UVP+bjbrT+vsprLv4z
         pwVBaeaGBSBWxAGZoCgSSUQLvIlt1CRZ7/6Q7z1gts6rlcG7rHbH/oqfW51h86zVhfF2
         3s+pzxr/jBtnRXomw2dHHx7nV5kHJLKKJILZVH0eZNm5/YVPapJK4G7R0wFVVGFqs977
         UhSoI4uadPx+aSBHE9WgbJXilQ6BZl+oBec+wjMFL36cpvI/7PV/raWjk4iCKrmslGdn
         E768o01/UPTWFZ1EORuaBNU/7FugBRPrAzcdSKzQ5ETnXycI8Xtqgs0fYKzIkPJtdO+h
         ZWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BoY7g8nUQQ3BvW0xBl0eILMoOU8tGg7MZ9xjNiqrFPA=;
        b=3i9ndeOwYD+GYqFKeiGPOD/Pn6lT5pofZwquTJJQIduWL9nlROtdcvmmQD3pMCoSVQ
         3C7GfSyNemPJpGRDQFWW8fm0hIUiXUEtBXzKpwp6AXnU4O/kFAMYRLTqzMVHz+WO+AqE
         /+oDHonsUOa/g7jyLZYqa5Qz9p7Vrtmg2CFAcOOu9VudcH136hr4UEAfA3sHzc8EZmAp
         LNiYfgT0A6iKsExfbEwz4rTMb1yMyFgBVKdlUEdQt4m+bqwEzKJAGPRhmbnpCkCXGbzr
         6Q1N7Po8Rs3MwcUe/soqnIlGW4BfDunAhG6nY6fNvetgiJinl17WnqWIfSYFHCtK3CDC
         jBZw==
X-Gm-Message-State: AOAM533IGYxVm1FkobfYcGQC8n1F+F4Di9Q9OZV+qYQaC0S4fb4WrQ3S
        S2tDkin8GfSTvwO09L6KhKJVRb89xHeuv92CMZmaoAH7IpYADKLD
X-Google-Smtp-Source: ABdhPJx/2GOpXH2bLjEym/lKA2keUtwkdjxN/7bIy/NLe+vgD2VyAqthraR6XG9/mFx406495jSSJO8wXSUA4TmYxKo=
X-Received: by 2002:a05:6870:5b89:b0:e9:bb4c:a6f1 with SMTP id
 em9-20020a0568705b8900b000e9bb4ca6f1mr299361oab.52.1652371287934; Thu, 12 May
 2022 09:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220512135231.10076-1-schspa@gmail.com> <20220512135231.10076-2-schspa@gmail.com>
 <CAJZ5v0htGfZ3G+BWgZSxvcEAhNd_LONm8rNMetdPts3uZ=Tcxw@mail.gmail.com>
In-Reply-To: <CAJZ5v0htGfZ3G+BWgZSxvcEAhNd_LONm8rNMetdPts3uZ=Tcxw@mail.gmail.com>
From:   Schspa Shi <schspa@gmail.com>
Date:   Fri, 13 May 2022 00:01:16 +0800
Message-ID: <CAMA88TodZJYmd2GnWty=qCw7T=LG9jihEAmT+RPK8tSBqdiubA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] cpufreq: make interface functions and lock holding
 state clear
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
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

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Thu, May 12, 2022 at 3:52 PM Schspa Shi <schspa@gmail.com> wrote:
>>
>> cpufreq_offline() calls offline() and exit() under the policy rwsem
>> But they are called outside the rwsem in cpufreq_online().
>>
>> This patch move the offline(), exit(), online(), init() to be inside
>> of policy rwsem to achieve a clear lock relationship.
>>
>> All the init() online() implement only initialize policy object without
>> holding this lock and won't call cpufreq APIs need to hold this lock.
>>
>> Signed-off-by: Schspa Shi <schspa@gmail.com>
>
> IMV this still addresses 2 different issues and so it should be split
> into 2 different patches.
>
>> ---
>>  drivers/cpufreq/cpufreq.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 35dffd738580..f242d5488364 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>
> Patch 1:
>
>> @@ -1343,12 +1343,12 @@ static int cpufreq_online(unsigned int cpu)
>>                 down_write(&policy->rwsem);
>>                 policy->cpu = cpu;
>>                 policy->governor = NULL;
>> -               up_write(&policy->rwsem);
>>         } else {
>>                 new_policy = true;
>>                 policy = cpufreq_policy_alloc(cpu);
>>                 if (!policy)
>>                         return -ENOMEM;
>> +               down_write(&policy->rwsem);
>>         }
>>
>>         if (!new_policy && cpufreq_driver->online) {
>> @@ -1388,7 +1388,6 @@ static int cpufreq_online(unsigned int cpu)
>>                 cpumask_copy(policy->related_cpus, policy->cpus);
>>         }
>>
>> -       down_write(&policy->rwsem);
>>         /*
>>          * affected cpus must always be the one, which are online. We aren't
>>          * managing offline cpus here.
>
> which addresses the problem that cpufreq_online() updates the
> policy->cpus and related_cpus masks without holding the policy rwsem
> (since the policy kobject has been registered already at this point,
> this is generally unsafe).
>
> A side-effect of it is that ->online() and ->init() will be called
> under the policy rwsem now, but that should be fine and is more
> consistent than the current code too.
>
> Patch 2:
>
>> @@ -1540,7 +1539,6 @@ static int cpufreq_online(unsigned int cpu)
>>                 remove_cpu_dev_symlink(policy, get_cpu_device(j));
>>
>>         cpumask_clear(policy->cpus);
>> -       up_write(&policy->rwsem);
>>
>>  out_offline_policy:
>>         if (cpufreq_driver->offline)
>> @@ -1549,6 +1547,7 @@ static int cpufreq_online(unsigned int cpu)
>>  out_exit_policy:
>>         if (cpufreq_driver->exit)
>>                 cpufreq_driver->exit(policy);
>> +       up_write(&policy->rwsem);
>>
>>  out_free_policy:
>>         cpufreq_policy_free(policy);
>> --
>
> which addressed the issue of calling ->offline() and ->exit() without
> holding the policy rwsem that is at best inconsistent with
> cpufreq_offline().

No, we can't split this into two different patches. which will cause a
uninitialized unlock for policy rwsem.
This will make the git bitsec unusable.

Which Dan Carpenter reported, and cause the patch of the v1 version to
be reverted.

Link: https://lore.kernel.org/all/YnKZCGaig+EXSowf@kili/

---
BRs


Schspa Shi
