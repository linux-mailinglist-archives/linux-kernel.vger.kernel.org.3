Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5D946447F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 02:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbhLABdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 20:33:02 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14999 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbhLABdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 20:33:00 -0500
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J3hJd2CkKzZdHM;
        Wed,  1 Dec 2021 09:26:57 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 09:29:38 +0800
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 1 Dec
 2021 09:29:37 +0800
Subject: Re: [PATCH] cpufreq: Fix get_cpu_device() failed in
 add_cpu_dev_symlink()
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
References: <20211129080248.46240-1-wangxiongfeng2@huawei.com>
 <20211129091039.s7bqq43o4ktuub6t@vireshk-i7>
 <CAJZ5v0hYskLTjSGOJgRRXD0cE0a5DMHh5qTvmgCmJh8bMicLzA@mail.gmail.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <558439df-9f0e-9c2a-6332-64e3e2a5c823@huawei.com>
Date:   Wed, 1 Dec 2021 09:29:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hYskLTjSGOJgRRXD0cE0a5DMHh5qTvmgCmJh8bMicLzA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2021/11/30 19:42, Rafael J. Wysocki wrote:
> On Mon, Nov 29, 2021 at 10:10 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>
>> On 29-11-21, 16:02, Xiongfeng Wang wrote:
>>> When I hot added a CPU, I found 'cpufreq' directory is not created below
>>> /sys/devices/system/cpu/cpuX/. It is because get_cpu_device() failed in
>>> add_cpu_dev_symlink().
>>>
>>> cpufreq_add_dev() is the .add_dev callback of a CPU subsys interface. It
>>> will be called when the CPU device registered into the system. The stack
>>> is as follows.
>>>   register_cpu()
>>>   ->device_register()
>>>    ->device_add()
>>>     ->bus_probe_device()
>>>      ->cpufreq_add_dev()
>>>
>>> But only after the CPU device has been registered, we can get the CPU
>>> device by get_cpu_device(), otherwise it will return NULL. Since we
>>> already have the CPU device in cpufreq_add_dev(), pass it to
>>> add_cpu_dev_symlink(). I noticed that the 'kobj' of the cpu device has
>>> been added into the system before cpufreq_add_dev().
>>>
>>> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>>> ---
>>>  drivers/cpufreq/cpufreq.c | 9 ++++-----
>>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>> index e338d2f010fe..22aa2793e4d2 100644
>>> --- a/drivers/cpufreq/cpufreq.c
>>> +++ b/drivers/cpufreq/cpufreq.c
>>> @@ -1004,10 +1004,9 @@ static struct kobj_type ktype_cpufreq = {
>>>       .release        = cpufreq_sysfs_release,
>>>  };
>>>
>>> -static void add_cpu_dev_symlink(struct cpufreq_policy *policy, unsigned int cpu)
>>> +static void add_cpu_dev_symlink(struct cpufreq_policy *policy, unsigned int cpu,
>>> +                             struct device *dev)
>>>  {
>>> -     struct device *dev = get_cpu_device(cpu);
>>> -
>>>       if (unlikely(!dev))
>>>               return;
>>>
>>> @@ -1391,7 +1390,7 @@ static int cpufreq_online(unsigned int cpu)
>>>       if (new_policy) {
>>>               for_each_cpu(j, policy->related_cpus) {
>>>                       per_cpu(cpufreq_cpu_data, j) = policy;
>>> -                     add_cpu_dev_symlink(policy, j);
>>> +                     add_cpu_dev_symlink(policy, j, get_cpu_device(j));
>>>               }
>>>
>>>               policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
>>> @@ -1565,7 +1564,7 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>>>       /* Create sysfs link on CPU registration */
>>>       policy = per_cpu(cpufreq_cpu_data, cpu);
>>>       if (policy)
>>> -             add_cpu_dev_symlink(policy, cpu);
>>> +             add_cpu_dev_symlink(policy, cpu, dev);
>>>
>>>       return 0;
>>>  }
>>
>> Interesting that I never hit it earlier despite doing rigorous testing of
>> hotplug stuff :(
> 
> This is the real hot-add path which isn't tested on a regular basis.
> 
>> Anyway the patch is okay,
> 
> It would be good to add a Fixes: tag to it, though.  Any idea about
> the commit this should point to?

When I look up the commit history, I found this one.
   2f0ba790df51 ("cpufreq: Fix creation of symbolic links to policy directories")
Before this commit, the 'dev' is passed to add_cpu_dev_symlink() in
cpufreq_add_dev(). Maybe we can point to this one.

> 
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> .
> 
