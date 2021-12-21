Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C1F47BA02
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 07:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbhLUGYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 01:24:39 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16843 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhLUGYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 01:24:38 -0500
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JJ5xt68dqz91l3;
        Tue, 21 Dec 2021 14:23:46 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 14:24:36 +0800
Received: from [10.174.179.189] (10.174.179.189) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 14:24:35 +0800
Subject: Re: [PATCH] ipmi: Fix UAF when uninstall ipmi_si and ipmi_msghandler
 module
To:     <minyard@acm.org>
CC:     <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <linfeilong@huawei.com>
References: <1639983320-34222-1-git-send-email-wubo40@huawei.com>
 <20211220124522.GS14936@minyard.net>
From:   Wu Bo <wubo40@huawei.com>
Message-ID: <e081980c-c3b8-770d-dd9d-b61b2fe467b3@huawei.com>
Date:   Tue, 21 Dec 2021 14:24:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20211220124522.GS14936@minyard.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.189]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/20 20:45, Corey Minyard wrote:
> I believe this has already been fixed by change 1d49eb91e 'ipmi: Move
> remove_work to dedicated workqueue' by moving to a dedicated workqueue.
> Can you test against the bleeding edge kernel and see?
> 
> Thanks,
> 
> -corey

I tested with the latest kernel version and the problem still exists.
commit 1d49eb91e (ipmi: Move remove_work to dedicated workqueue)
not solved completely. cleanup_bmc_device() function still use the 
system's workqueue.

drivers/char/ipmi/ipmi_msghandler.c:
3024 static void
3025 cleanup_bmc_device(struct kref *ref)
3026 {
3027         struct bmc_device *bmc = container_of(ref, struct 
bmc_device, usecount);
3028
3029         /*
3030          * Remove the platform device in a work queue to avoid issues
3031          * with removing the device attributes while reading a device
3032          * attribute.
3033          */
3034         schedule_work(&bmc->remove_work);
3035 }

I will set v2 patch using 'remove_work_wq' instead of 'system_wq'
to solve this issues.

Thanks,

Wu Bo
> 
> On Mon, Dec 20, 2021 at 02:55:20PM +0800, Wu Bo wrote:
>> Hi,
>>
>> When testing install and uninstall of ipmi_si.ko and ipmi_msghandler.ko,
>> the system crashed.
>>
>> The log as follows:
>> [  141.087026] BUG: unable to handle kernel paging request at ffffffffc09b3a5a
>> [  141.087241] PGD 8fe4c0d067 P4D 8fe4c0d067 PUD 8fe4c0f067 PMD 103ad89067 PTE 0
>> [  141.087464] Oops: 0010 [#1] SMP NOPTI
>> [  141.087580] CPU: 67 PID: 668 Comm: kworker/67:1 Kdump: loaded Not tainted 4.18.0.x86_64 #47
>> [  141.088009] Workqueue: events 0xffffffffc09b3a40
>> [  141.088009] RIP: 0010:0xffffffffc09b3a5a
>> [  141.088009] Code: Bad RIP value.
>> [  141.088009] RSP: 0018:ffffb9094e2c3e88 EFLAGS: 00010246
>> [  141.088009] RAX: 0000000000000000 RBX: ffff9abfdb1f04a0 RCX: 0000000000000000
>> [  141.088009] RDX: 0000000000000000 RSI: 0000000000000246 RDI: 0000000000000246
>> [  141.088009] RBP: 0000000000000000 R08: ffff9abfffee3cb8 R09: 00000000000002e1
>> [  141.088009] R10: ffffb9094cb73d90 R11: 00000000000f4240 R12: ffff9abfffee8700
>> [  141.088009] R13: 0000000000000000 R14: ffff9abfdb1f04a0 R15: ffff9abfdb1f04a8
>> [  141.088009] FS:  0000000000000000(0000) GS:ffff9abfffec0000(0000) knlGS:0000000000000000
>> [  141.088009] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  141.088009] CR2: ffffffffc09b3a30 CR3: 0000008fe4c0a001 CR4: 00000000007606e0
>> [  141.088009] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [  141.088009] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [  141.088009] PKRU: 55555554
>> [  141.088009] Call Trace:
>> [  141.088009]  ? process_one_work+0x195/0x390
>> [  141.088009]  ? worker_thread+0x30/0x390
>> [  141.088009]  ? process_one_work+0x390/0x390
>> [  141.088009]  ? kthread+0x10d/0x130
>> [  141.088009]  ? kthread_flush_work_fn+0x10/0x10
>> [  141.088009]  ? ret_from_fork+0x35/0x40] BUG: unable to handle kernel paging request at ffffffffc0b28a5a
>> [  200.223240] PGD 97fe00d067 P4D 97fe00d067 PUD 97fe00f067 PMD a580cbf067 PTE 0
>> [  200.223464] Oops: 0010 [#1] SMP NOPTI
>> [  200.223579] CPU: 63 PID: 664 Comm: kworker/63:1 Kdump: loaded Not tainted 4.18.0.x86_64 #46
>> [  200.224008] Workqueue: events 0xffffffffc0b28a40
>> [  200.224008] RIP: 0010:0xffffffffc0b28a5a
>> [  200.224008] Code: Bad RIP value.
>> [  200.224008] RSP: 0018:ffffbf3c8e2a3e88 EFLAGS: 00010246
>> [  200.224008] RAX: 0000000000000000 RBX: ffffa0799ad6bca0 RCX: 0000000000000000
>> [  200.224008] RDX: 0000000000000000 RSI: 0000000000000246 RDI: 0000000000000246
>> [  200.224008] RBP: 0000000000000000 R08: ffff9fe43fde3cb8 R09: 00000000000000d5
>> [  200.224008] R10: ffffbf3c8cb53d90 R11: 00000000000f4240 R12: ffff9fe43fde8700
>> [  200.224008] R13: 0000000000000000 R14: ffffa0799ad6bca0 R15: ffffa0799ad6bca8
>> [  200.224008] FS:  0000000000000000(0000) GS:ffff9fe43fdc0000(0000) knlGS:0000000000000000
>> [  200.224008] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  200.224008] CR2: ffffffffc0b28a30 CR3: 00000097fe00a002 CR4: 00000000007606e0
>> [  200.224008] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [  200.224008] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [  200.224008] PKRU: 55555554
>> [  200.224008] Call Trace:
>> [  200.224008]  ? process_one_work+0x195/0x390
>> [  200.224008]  ? worker_thread+0x30/0x390
>> [  200.224008]  ? process_one_work+0x390/0x390
>> [  200.224008]  ? kthread+0x10d/0x130
>> [  200.224008]  ? kthread_flush_work_fn+0x10/0x10
>> [  200.224008]  ? ret_from_fork+0x35/0x40
>> [  200.224008] kernel fault(0x1) notification starting on CPU 63
>> [  200.224008] kernel fault(0x1) notification finished on CPU 63
>> [  200.224008] CR2: ffffffffc0b28a5a
>> [  200.224008] ---[ end trace c82a412d93f57412 ]---
>>
>> The reason is as follows:
>> T1: rmmod ipmi_si.
>>      ->ipmi_unregister_smi()
>>      	-> ipmi_bmc_unregister()
>> 	    -> __ipmi_bmc_unregister()
>> 		-> kref_put(&bmc->usecount, cleanup_bmc_device);
>> 		    -> schedule_work(&bmc->remove_work);
>>
>> T2: rmmod ipmi_msghandler.
>> 	ipmi_msghander module uninstalled, and the module space will be freed.
>>
>> T3: bmc->remove_work doing cleanup the bmc resource.
>>      -> cleanup_bmc_work()
>> 	-> platform_device_unregister(&bmc->pdev);
>> 	    -> platform_device_del(pdev);
>> 		-> device_del(&pdev->dev);
>> 		    -> kobject_uevent(&dev->kobj, KOBJ_REMOVE);
>> 			-> kobject_uevent_env()
>> 			    -> dev_uevent()
>> 				-> if (dev->type && dev->type->name)
>> 		
>>     'dev->type'(bmc_device_type) pointer space has freed when uninstall
>>      ipmi_msghander module, 'dev->type->name' cause the sysytem crash.
>> 		
>> drivers/char/ipmi/ipmi_msghandler.c:
>> 2820 static const struct device_type bmc_device_type = {
>> 2821         .groups         = bmc_dev_attr_groups,
>> 2822 };
>>
>> Steps to reproduce:
>> Add a time delay in cleanup_bmc_work() function,
>> and uninstall ipmi_si and ipmi_msghandler module.
>>
>> 2910 static void cleanup_bmc_work(struct work_struct *work)
>> 2911 {
>> 2912         struct bmc_device *bmc = container_of(work, struct bmc_device,
>> 2913                                               remove_work);
>> 2914         int id = bmc->pdev.id; /* Unregister overwrites id */
>> 2915
>> 2916         msleep(3000);   <---
>> 2917         platform_device_unregister(&bmc->pdev);
>> 2918         ida_simple_remove(&ipmi_bmc_ida, id);
>> 2919 }
>>
>> Fixes: b2cfd8ab4add ("ipmi: Rework device id and guid handling to catch changing BMCs")
>> Signed-off-by: Wu Bo <wubo40@huawei.com>
>> ---
>>   drivers/char/ipmi/ipmi_msghandler.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
>> index c837d54..4af3543 100644
>> --- a/drivers/char/ipmi/ipmi_msghandler.c
>> +++ b/drivers/char/ipmi/ipmi_msghandler.c
>> @@ -3008,6 +3008,7 @@ static struct bmc_device *ipmi_find_bmc_prod_dev_id(
>>   static void
>>   release_bmc_device(struct device *dev)
>>   {
>> +	module_put(THIS_MODULE);
>>   	kfree(to_bmc_device(dev));
>>   }
>>   
>> @@ -3195,7 +3196,7 @@ static int __ipmi_bmc_register(struct ipmi_smi *intf,
>>   	}
>>   
>>   	intf->bmc_registered = true;
>> -
>> +	__module_get(THIS_MODULE);
>>   out:
>>   	mutex_unlock(&ipmidriver_mutex);
>>   	mutex_lock(&intf->bmc_reg_mutex);
>> -- 
>> 2.33.1
>>
> .
> 


-- 
Wu Bo
