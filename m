Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BAF54C48B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239137AbiFOJYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbiFOJYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:24:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DFAE15714
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:24:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0086A152B;
        Wed, 15 Jun 2022 02:24:21 -0700 (PDT)
Received: from [10.57.84.206] (unknown [10.57.84.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 925E53F66F;
        Wed, 15 Jun 2022 02:24:19 -0700 (PDT)
Message-ID: <27643261-7e52-ed2c-3491-50a139ea9a06@arm.com>
Date:   Wed, 15 Jun 2022 10:24:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v2] coresight: configfs: Fix unload of configurations on
 module exit
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     mathieu.poirier@linaro.org, leo.yan@linaro.org,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220606152636.3996-1-mike.leach@linaro.org>
 <c58d1e20-9b2a-cba4-40b7-075d844f0ae7@arm.com>
In-Reply-To: <c58d1e20-9b2a-cba4-40b7-075d844f0ae7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: configfs folks.

Hi Mike

On 14/06/2022 23:00, Suzuki K Poulose wrote:
> Hi Mike,
> 
> Thanks for fixing this. Except for a minor nit, the patch looks good to me.

Spoke too soon. I am able to reproduce the original problem with this 
patch applied. Here is what I did :

# Load the coresight_etm4x module

$ modprobe coresight_etm4x

# enable autofdo configuration
$ echo 1 >  /sys/kernel/config/cs-syscfg/configurations/autofdo/enable

# Unload the coresight_etm4x module
$ rmmod coresight_etm4x
$ lsmod
Module                  Size  Used by
coresight              77824  0
$ cat  /sys/kernel/config/cs-syscfg/configurations/autofdo/enable
1

# Now unload the coresight module, this triggers the splat.
$ rmmod coresight


[  202.455667] cscfg: unloading preloaded configurations
[  202.455689] ====================================================== 
 
 
 

[  202.455691] WARNING: possible circular locking dependency detected
[  202.455695] 5.19.0-rc2+ #53 Tainted: G                T
[  202.455700] ------------------------------------------------------
[  202.455702] rmmod/454 is trying to acquire lock:
[  202.455707] ffff00080363f580 (&p->frag_sem){++++}-{4:4}, at: 
configfs_unregister_group+0x4c/0x190
[  202.455733]
                but task is already holding lock:
[  202.455735] ffff8000012e4b98 (cscfg_mutex){+.+.}-{4:4}, at: 
cscfg_clear_device+0x34/0xfc [coresight]
[  202.455777]
                which lock already depends on the new lock.

[  202.455779]
                the existing dependency chain (in reverse order) is:
[  202.455781]
                -> #1 (cscfg_mutex){+.+.}-{4:4}:
[  202.455791]        lock_acquire+0x68/0x8c
[  202.455801]        __mutex_lock+0xa0/0x464
[  202.455811]        mutex_lock_nested+0x44/0x70
[  202.455819]        cscfg_config_sysfs_activate+0x3c/0xec [coresight]
[  202.455846]        cscfg_cfg_enable_store+0x84/0xcc [coresight]
[  202.455872]        configfs_write_iter+0xd4/0x130
[  202.455878]        new_sync_write+0xdc/0x160
[  202.455885]        vfs_write+0x1c8/0x210
[  202.455892]        ksys_write+0x74/0x100
[  202.455897]        __arm64_sys_write+0x28/0x34
[  202.455904]        invoke_syscall+0x50/0x120
[  202.455913]        el0_svc_common.constprop.0+0x68/0x124
[  202.455921]        do_el0_svc+0x38/0xcc
[  202.455928]        el0_svc+0x58/0x100
[  202.455933]        el0t_64_sync_handler+0xf4/0x100
[  202.455938]        el0t_64_sync+0x18c/0x190
[  202.455944]
                -> #0 (&p->frag_sem){++++}-{4:4}:
[  202.455954]        __lock_acquire+0x11f4/0x1ddc
[  202.455961]        lock_acquire.part.0+0xe4/0x220
[  202.455967]        lock_acquire+0x68/0x8c
[  202.455973]        down_write+0x78/0x164
[  202.455980]        configfs_unregister_group+0x4c/0x190
[  202.455985]        cscfg_configfs_del_config+0x2c/0x40 [coresight]
[  202.456011]        cscfg_unload_owned_cfgs_feats+0x1d0/0x2c0 [coresight]
[  202.456036]        cscfg_clear_device+0xec/0xfc [coresight]
[  202.456060]        cscfg_exit+0x1c/0x90 [coresight]
[  202.456085]        coresight_exit+0x10/0xd80 [coresight]
[  202.456109]        __arm64_sys_delete_module+0x19c/0x250
[  202.456115]        invoke_syscall+0x50/0x120
[  202.456122]        el0_svc_common.constprop.0+0x68/0x124
[  202.456130]        do_el0_svc+0x38/0xcc
[  202.456138]        el0_svc+0x58/0x100
[  202.456142]        el0t_64_sync_handler+0xf4/0x100
[  202.456148]        el0t_64_sync+0x18c/0x190
[  202.456152]
                other info that might help us debug this:

[  202.456154]  Possible unsafe locking scenario:

[  202.456156]        CPU0                    CPU1
[  202.456158]        ----                    ----
[  202.456159]   lock(cscfg_mutex);
[  202.456164]                                lock(&p->frag_sem);
[  202.456169]                                lock(cscfg_mutex);
[  202.456173]   lock(&p->frag_sem);
[  202.456177]
                 *** DEADLOCK ***

[  202.456178] 1 lock held by rmmod/454:
[  202.456183]  #0: ffff8000012e4b98 (cscfg_mutex){+.+.}-{4:4}, at: 
cscfg_clear_device+0x34/0xfc [coresight]
[  202.456219]
                stack backtrace:
[  202.456222] CPU: 1 PID: 454 Comm: rmmod Tainted: G                T 
5.19.0-rc2+ #53
[  202.456230] Hardware name: ARM LTD ARM Juno Development Platform/ARM 
Juno Development Platform, BIOS EDK II Feb  1 2019
[  202.456234] Call trace:
[  202.456236]  dump_backtrace.part.0+0xd8/0xe4
[  202.456243]  show_stack+0x24/0x80
[  202.456248]  dump_stack_lvl+0x8c/0xb8
[  202.456257]  dump_stack+0x18/0x34
[  202.456264]  print_circular_bug+0x1f8/0x200
[  202.456271]  check_noncircular+0x130/0x144
[  202.456277]  __lock_acquire+0x11f4/0x1ddc
[  202.456284]  lock_acquire.part.0+0xe4/0x220
[  202.456290]  lock_acquire+0x68/0x8c
[  202.456295]  down_write+0x78/0x164
[  202.456302]  configfs_unregister_group+0x4c/0x190
[  202.456308]  cscfg_configfs_del_config+0x2c/0x40 [coresight]
[  202.456333]  cscfg_unload_owned_cfgs_feats+0x1d0/0x2c0 [coresight]
[  202.456357]  cscfg_clear_device+0xec/0xfc [coresight]
[  202.456381]  cscfg_exit+0x1c/0x90 [coresight]
[  202.456405]  coresight_exit+0x10/0xd80 [coresight]
[  202.456429]  __arm64_sys_delete_module+0x19c/0x250
[  202.456435]  invoke_syscall+0x50/0x120
[  202.456442]  el0_svc_common.constprop.0+0x68/0x124
[  202.456450]  do_el0_svc+0x38/0xcc
[  202.456458]  el0_svc+0x58/0x100
[  202.456462]  el0t_64_sync_handler+0xf4/0x100
[  202.456468]  el0t_64_sync+0x18c/0x190


Suzuki


> 
> On 06/06/2022 16:26, Mike Leach wrote:
>> Any loaded configurations must be correctly unloaded on coresight module
>> exit, or issues can arise with nested locking in the configfs directory
>> code if built with CONFIG_LOCKDEP.
>>
>> Prior to this patch, the preloaded configuration configfs directory 
>> entries
>> were being unloaded by the recursive code in
>> configfs_unregister_subsystem().
>>
>> However, when built with CONFIG_LOCKDEP, this caused a nested lock 
>> warning,
>> which was not mitigated by the LOCKDEP dependent code in 
>> fs/configfs/dir.c
>> designed to prevent this, due to the different directory levels for the
>> root of the directory being removed.
>>
>> As the preloaded (and all other) configurations are registered after
>> configfs_register_subsystem(), we now explicitly unload them before the
>> call to configfs_unregister_subsystem().
>>
>> The new routine cscfg_unload_cfgs_on_exit() iterates through the load
>> owner list to unload any remaining configurations that were not unloaded
>> by the user before the module exits. This covers both the
>> CSCFG_OWNER_PRELOAD and CSCFG_OWNER_MODULE owner types, and will be
>> extended to cover future load owner types for CoreSight configurations.
>>
>> Applies to coresight/next
>>
>> Fixes: eb2ec49606c2 ("coresight: syscfg: Update load API for config 
>> loadable modules")
>> Reported-by: Suzuki Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Mike Leach <mike.leach@linaro.org>
>> ---
>>
>> Changes since v1:
>> Altered ordering of init of cscfg_mgr to ensure lists valid for
>> potential exit path on error.
>>
>> ---
>>   .../hwtracing/coresight/coresight-syscfg.c    | 72 ++++++++++++++++---
>>   1 file changed, 61 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c 
>> b/drivers/hwtracing/coresight/coresight-syscfg.c
>> index 11850fd8c3b5..050a32f7e439 100644
>> --- a/drivers/hwtracing/coresight/coresight-syscfg.c
>> +++ b/drivers/hwtracing/coresight/coresight-syscfg.c
>> @@ -1042,6 +1042,13 @@ static int cscfg_create_device(void)
>>       if (!cscfg_mgr)
>>           goto create_dev_exit_unlock;
>> +    /* initialise the cscfg_mgr structure */
>> +    INIT_LIST_HEAD(&cscfg_mgr->csdev_desc_list);
>> +    INIT_LIST_HEAD(&cscfg_mgr->feat_desc_list);
>> +    INIT_LIST_HEAD(&cscfg_mgr->config_desc_list);
>> +    INIT_LIST_HEAD(&cscfg_mgr->load_order_list);
>> +    atomic_set(&cscfg_mgr->sys_active_cnt, 0);
>> +
>>       /* setup the device */
>>       dev = cscfg_device();
>>       dev->release = cscfg_dev_release;
>> @@ -1056,14 +1063,61 @@ static int cscfg_create_device(void)
>>       return err;
>>   }
>> -static void cscfg_clear_device(void)
>> +/*
>> + * Loading and unloading is generally on user discretion.
>> + * If exiting due to coresight module unload, we need to unload any 
>> configurations that remain,
>> + * before we unregister the configfs intrastructure.
>> + *
>> + * Do this by walking the load_owner list and taking appropriate 
>> action, depending on the load
>> + * owner type.
>> + *
>> + * called with the cscfg_mutex held
>> + */
>> +
>> +#define LOADABLE_MOD_ERR "cscfg: ERROR - a loadable module failed to 
>> unload configs on exit\n"
> 
> minor nit: Could we skip this ?
> 
>> +
>> +static void cscfg_unload_cfgs_on_exit(void)
>>   {
>> -    struct cscfg_config_desc *cfg_desc;
>> +    struct cscfg_load_owner_info *owner_info = NULL;
>> -    mutex_lock(&cscfg_mutex);
>> -    list_for_each_entry(cfg_desc, &cscfg_mgr->config_desc_list, item) {
>> -        etm_perf_del_symlink_cscfg(cfg_desc);
>> +    while (!list_empty(&cscfg_mgr->load_order_list)) {
>> +
>> +        /* remove in reverse order of loading */
>> +        owner_info = list_last_entry(&cscfg_mgr->load_order_list,
>> +                         struct cscfg_load_owner_info, item);
>> +
>> +        /* action according to type */
>> +        switch (owner_info->type) {
>> +        case CSCFG_OWNER_PRELOAD:
>> +            /*
>> +             * preloaded  descriptors are statically allocated in
>> +             * this module - just need to unload dynamic items from
>> +             * csdev lists, and remove from configfs directories.
>> +             */
>> +            pr_info("cscfg: unloading preloaded configurations\n");
>> +            cscfg_unload_owned_cfgs_feats(owner_info);
>> +            break;
>> +
>> +        case  CSCFG_OWNER_MODULE:
>> +            /*
>> +             * this is an error - the loadable module must have been 
>> unloaded prior
>> +             * to the coresight module unload. Therefore that module 
>> has not
>> +             * correctly unloaded configs in its own exit code.
>> +             * Nothing to do other than emit an error string.
>> +             */
>> +            pr_err(LOADABLE_MOD_ERR);
> 
> Instead :
>              pr_err("cscfg: ERROR - a loadable module failed"
>                  " to unload configs on exit\n");
> 
> Otherwise, I can confirm that the patch fixes the reported problem.
> 
>> +            break;
>> +        }
>> +
>> +        /* remove from load order list */
>> +        list_del(&owner_info->item);
>>       }
>> +}
>> +
>> +static void cscfg_clear_device(void)
>> +{
>> +    mutex_lock(&cscfg_mutex);
>> +    cscfg_unload_cfgs_on_exit();
>>       cscfg_configfs_release(cscfg_mgr);
>>       device_unregister(cscfg_device());
>>       mutex_unlock(&cscfg_mutex);
>> @@ -1074,20 +1128,16 @@ int __init cscfg_init(void)
>>   {
>>       int err = 0;
>> +    /* create the device and init cscfg_mgr */
>>       err = cscfg_create_device();
>>       if (err)
>>           return err;
>> +    /* initialise configfs subsystem */
>>       err = cscfg_configfs_init(cscfg_mgr);
>>       if (err)
>>           goto exit_err;
>> -    INIT_LIST_HEAD(&cscfg_mgr->csdev_desc_list);
>> -    INIT_LIST_HEAD(&cscfg_mgr->feat_desc_list);
>> -    INIT_LIST_HEAD(&cscfg_mgr->config_desc_list);
>> -    INIT_LIST_HEAD(&cscfg_mgr->load_order_list);
>> -    atomic_set(&cscfg_mgr->sys_active_cnt, 0);
>> -
>>       /* preload built-in configurations */
>>       err = cscfg_preload(THIS_MODULE);
>>       if (err)
> 

