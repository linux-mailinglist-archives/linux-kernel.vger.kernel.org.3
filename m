Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0368847C127
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 15:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238344AbhLUOFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 09:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238339AbhLUOFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 09:05:47 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF90C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 06:05:47 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id fo11so12509449qvb.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 06:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=EUOnHPowtx6q4q24zTCtJzxc21cmmOXKCgae/dYiG+E=;
        b=YB1ehYxKUttskAql2UTpddRguX0jF5Z+97LDNKvdkuz2lCu7++UE77+bG9GwoBsZk6
         b1BPZmviOj8Iyk2EGEZ39KEC7x4PapNyvy2/y/66k11nkSjpldmYmpBblReevEUZyZwu
         rzQbdO778yqstKdv4fV7nHCsd8R0PTS5S7RpLUpjx2GgMrQN4cvFKGvuLIsQ8yNsVg9Q
         RUc3SM7SsPzUONApMUM3mBOMIg/ZSioYVcLLo8b1+sKg+I9h5ITDwzoWK5BJeU8J/5eb
         gI8XP163ndqH7y+rM2DKV0zy1m6hk+VP4qpQOLNRHQ2oeCilvmD0sK1IB5nYzLFsYi16
         D6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=EUOnHPowtx6q4q24zTCtJzxc21cmmOXKCgae/dYiG+E=;
        b=1rCaGvtvNMWXFIhZfOoClvmezSYicTJrGjxE3ePCQqfR7qJSnPH7wmd+mNDQ6xRAoD
         5qpCY6Jk3DfGv/xBFWKRndiXXaDoP++Cdpig7/LBzIVlmj9IULimzSmKP8WLWt+zY5E6
         nar0GRvLVpnuUNYVei6Lgg9Hagc59PSs5pq19Er+/aKqfUI1VGRrNvFfyoI9N+kgq0jG
         dfFWxAQRBzDH8BgLoF1KCRaHgKn6BuP+EhCdp8imasipfT/oEMH0u4YebB85y8Uv97tC
         SIITEiPcqwXqmaIG4A+mQmYmRClzGpYUf3ItuF34IoX/2PrngKWw7wLzR0tA2lJ8gM6o
         cTDQ==
X-Gm-Message-State: AOAM533x5QDrpPoi0LjZQihf0M7E/PrYrOKVjq/a3taUHjEFO0RqsDns
        jyR1A+YBTIXZNXv0VfxfPUbZixECUw==
X-Google-Smtp-Source: ABdhPJy59iSnoogBCUs9whKRQz+C80MTK4n4/b8d5/sIL7la4xnj1O/Nw5ncXDq5ykyxHxdPNCA4/A==
X-Received: by 2002:a05:6214:410c:: with SMTP id kc12mr1938735qvb.53.1640095546397;
        Tue, 21 Dec 2021 06:05:46 -0800 (PST)
Received: from serve.minyard.net ([47.184.156.158])
        by smtp.gmail.com with ESMTPSA id s6sm14522820qko.43.2021.12.21.06.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 06:05:45 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:1461:51dd:3b2b:342d])
        by serve.minyard.net (Postfix) with ESMTPSA id C1243180013;
        Tue, 21 Dec 2021 14:05:44 +0000 (UTC)
Date:   Tue, 21 Dec 2021 08:05:43 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Wu Bo <wubo40@huawei.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linfeilong@huawei.com
Subject: Re: [PATCH v2] ipmi: Fix UAF when uninstall ipmi_si and
 ipmi_msghandler module
Message-ID: <20211221140543.GT14936@minyard.net>
Reply-To: minyard@acm.org
References: <1640070034-56671-1-git-send-email-wubo40@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1640070034-56671-1-git-send-email-wubo40@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 03:00:34PM +0800, Wu Bo wrote:
> Hi,
> 
> When testing install and uninstall of ipmi_si.ko and ipmi_msghandler.ko,
> the system crashed.

Thanks for the fix, it's in my queue.  I'll try to get it up soon.

-corey

> 
> The log as follows:
> [  141.087026] BUG: unable to handle kernel paging request at ffffffffc09b3a5a
> [  141.087241] PGD 8fe4c0d067 P4D 8fe4c0d067 PUD 8fe4c0f067 PMD 103ad89067 PTE 0
> [  141.087464] Oops: 0010 [#1] SMP NOPTI
> [  141.087580] CPU: 67 PID: 668 Comm: kworker/67:1 Kdump: loaded Not tainted 4.18.0.x86_64 #47
> [  141.088009] Workqueue: events 0xffffffffc09b3a40
> [  141.088009] RIP: 0010:0xffffffffc09b3a5a
> [  141.088009] Code: Bad RIP value.
> [  141.088009] RSP: 0018:ffffb9094e2c3e88 EFLAGS: 00010246
> [  141.088009] RAX: 0000000000000000 RBX: ffff9abfdb1f04a0 RCX: 0000000000000000
> [  141.088009] RDX: 0000000000000000 RSI: 0000000000000246 RDI: 0000000000000246
> [  141.088009] RBP: 0000000000000000 R08: ffff9abfffee3cb8 R09: 00000000000002e1
> [  141.088009] R10: ffffb9094cb73d90 R11: 00000000000f4240 R12: ffff9abfffee8700
> [  141.088009] R13: 0000000000000000 R14: ffff9abfdb1f04a0 R15: ffff9abfdb1f04a8
> [  141.088009] FS:  0000000000000000(0000) GS:ffff9abfffec0000(0000) knlGS:0000000000000000
> [  141.088009] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  141.088009] CR2: ffffffffc09b3a30 CR3: 0000008fe4c0a001 CR4: 00000000007606e0
> [  141.088009] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  141.088009] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  141.088009] PKRU: 55555554
> [  141.088009] Call Trace:
> [  141.088009]  ? process_one_work+0x195/0x390
> [  141.088009]  ? worker_thread+0x30/0x390
> [  141.088009]  ? process_one_work+0x390/0x390
> [  141.088009]  ? kthread+0x10d/0x130
> [  141.088009]  ? kthread_flush_work_fn+0x10/0x10
> [  141.088009]  ? ret_from_fork+0x35/0x40] BUG: unable to handle kernel paging request at ffffffffc0b28a5a
> [  200.223240] PGD 97fe00d067 P4D 97fe00d067 PUD 97fe00f067 PMD a580cbf067 PTE 0
> [  200.223464] Oops: 0010 [#1] SMP NOPTI
> [  200.223579] CPU: 63 PID: 664 Comm: kworker/63:1 Kdump: loaded Not tainted 4.18.0.x86_64 #46
> [  200.224008] Workqueue: events 0xffffffffc0b28a40
> [  200.224008] RIP: 0010:0xffffffffc0b28a5a
> [  200.224008] Code: Bad RIP value.
> [  200.224008] RSP: 0018:ffffbf3c8e2a3e88 EFLAGS: 00010246
> [  200.224008] RAX: 0000000000000000 RBX: ffffa0799ad6bca0 RCX: 0000000000000000
> [  200.224008] RDX: 0000000000000000 RSI: 0000000000000246 RDI: 0000000000000246
> [  200.224008] RBP: 0000000000000000 R08: ffff9fe43fde3cb8 R09: 00000000000000d5
> [  200.224008] R10: ffffbf3c8cb53d90 R11: 00000000000f4240 R12: ffff9fe43fde8700
> [  200.224008] R13: 0000000000000000 R14: ffffa0799ad6bca0 R15: ffffa0799ad6bca8
> [  200.224008] FS:  0000000000000000(0000) GS:ffff9fe43fdc0000(0000) knlGS:0000000000000000
> [  200.224008] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  200.224008] CR2: ffffffffc0b28a30 CR3: 00000097fe00a002 CR4: 00000000007606e0
> [  200.224008] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  200.224008] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  200.224008] PKRU: 55555554
> [  200.224008] Call Trace:
> [  200.224008]  ? process_one_work+0x195/0x390
> [  200.224008]  ? worker_thread+0x30/0x390
> [  200.224008]  ? process_one_work+0x390/0x390
> [  200.224008]  ? kthread+0x10d/0x130
> [  200.224008]  ? kthread_flush_work_fn+0x10/0x10
> [  200.224008]  ? ret_from_fork+0x35/0x40
> [  200.224008] kernel fault(0x1) notification starting on CPU 63
> [  200.224008] kernel fault(0x1) notification finished on CPU 63
> [  200.224008] CR2: ffffffffc0b28a5a
> [  200.224008] ---[ end trace c82a412d93f57412 ]---
> 
> The reason is as follows:
> T1: rmmod ipmi_si.
>     ->ipmi_unregister_smi()
>         -> ipmi_bmc_unregister()
>             -> __ipmi_bmc_unregister()
>                 -> kref_put(&bmc->usecount, cleanup_bmc_device);
>                     -> schedule_work(&bmc->remove_work);
> 
> T2: rmmod ipmi_msghandler.
>     ipmi_msghander module uninstalled, and the module space 
>     will be freed.
> 
> T3: bmc->remove_work doing cleanup the bmc resource.
>     -> cleanup_bmc_work()
>         -> platform_device_unregister(&bmc->pdev);
>             -> platform_device_del(pdev);
>                 -> device_del(&pdev->dev);
>                     -> kobject_uevent(&dev->kobj, KOBJ_REMOVE);
>                         -> kobject_uevent_env()
>                             -> dev_uevent()
>                                 -> if (dev->type && dev->type->name)
> 
>    'dev->type'(bmc_device_type) pointer space has freed when uninstall
>     ipmi_msghander module, 'dev->type->name' cause the system crash.
> 
> drivers/char/ipmi/ipmi_msghandler.c:
> 2820 static const struct device_type bmc_device_type = {
> 2821         .groups         = bmc_dev_attr_groups,
> 2822 };
> 
> Steps to reproduce:
> Add a time delay in cleanup_bmc_work() function,
> and uninstall ipmi_si and ipmi_msghandler module.
> 
> 2910 static void cleanup_bmc_work(struct work_struct *work)
> 2911 {
> 2912         struct bmc_device *bmc = container_of(work, struct bmc_device,
> 2913                                               remove_work);
> 2914         int id = bmc->pdev.id; /* Unregister overwrites id */
> 2915
> 2916         msleep(3000);   <---
> 2917         platform_device_unregister(&bmc->pdev);
> 2918         ida_simple_remove(&ipmi_bmc_ida, id);
> 2919 }
> 
> Use 'remove_work_wq' instead of 'system_wq' to solve this issues.
> 
> Fixes: b2cfd8ab4add ("ipmi: Rework device id and guid handling to catch changing BMCs")
> Signed-off-by: Wu Bo <wubo40@huawei.com>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index c837d54..d96184d 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -3031,7 +3031,7 @@ static void cleanup_bmc_work(struct work_struct *work)
>  	 * with removing the device attributes while reading a device
>  	 * attribute.
>  	 */
> -	schedule_work(&bmc->remove_work);
> +	queue_work(remove_work_wq, &bmc->remove_work);
>  }
>  
>  /*
> -- 
> 1.8.3.1
> 
