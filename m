Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF9D4B9D8D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239322AbiBQKta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:49:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiBQKt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:49:28 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A651ED1DB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 02:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645094954; x=1676630954;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=4aTr7eMoH99dGdFEQX0pvGPd60mY46FyZOxXXitycb0=;
  b=FwylsGqZIBtenajNH/9dN8kqI78dME2hG4FqlRBJPc/LpKwm7+BqzlR4
   va1puFFjR6hsGtYjLh38lvjEI956HxcjZCBtgxbcnT7HmDs1KNYkhjwll
   MmelQWz9FgKYHMhipFkgabtvEXBfi2aXKvzn0U6Fo5nWK9H+PxZKx+8eg
   DG+urKB5ciZ5fM6HB2hLB1VQKQoAKVG5Dp2hjc3xSZW/xHT3cFfOD0CPW
   fGeY30wxYgdAXvOOarHjOMc6gsNYl2CHDFcaJlXrEnTlott74pC66Tj1n
   4Z+lSJ22p99+DBs0Nqx1dRvOwMZPXyf6srsTaZ9IrWISRDCtzqr4hTBVw
   w==;
X-IronPort-AV: E=Sophos;i="5.88,375,1635177600"; 
   d="scan'208";a="297293276"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2022 18:49:14 +0800
IronPort-SDR: 7ba2i35/ZD72kvsVHd1hOdQG6KcYfiAW1esvOYI36u5sgk9n8JOOh0P28EvtNOLVY21M2mKsEU
 R3lIG7a7GvYGgafHxCNSXQCxTsFKuRrRCjQpaez1NWiO3indMXKCGnKHqWqYdsR4gtAc/jpeFL
 5sda9um4ZjURxRVuMPa52WdYwp7DbFIaulqrltefY8wvRQUY9NPdTYQXwD2UrNra3QZmfWIBKu
 C72ph8dS6hmbis/J8cPrMEY5kmwr7hrXYxPOq3EcexTo/ptH9hcjjNAh0K8DtnlARlvyqKNlru
 oAbEnbCqHI4wtE+VHzKmXdQp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 02:20:53 -0800
IronPort-SDR: 4pZxlpiCFyHI7JRvb3cAuoOfxthUIkZzlL5B19tAPa3nwfQuXJ7Lffc/7rRCE/6zHWs1SgJXpd
 AU1q3bG45ml7mx4HrfnHB8gca3hNLfx7xp8S8Kl6jbTHS8zRIGf5eisEMvhAMi9HjErhdLeGTg
 e265EYk677kqLlTTkSzPc6gSl13GPnQ5JJ97aJrBcbsMt0ELinskamEhQ9wIr5rAjK0KD+uc6u
 ejILt1dPcrN6l4q3DxcxCuGioudOvt1SZrlG4atD/0zDc4V94J3kt22nZ9Al336GxURew6wXe5
 +5A=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 02:49:15 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jzs5Q01vdz1SVnx
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 02:49:13 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645094953; x=1647686954; bh=4aTr7eMoH99dGdFEQX0pvGPd60mY46FyZOx
        XXitycb0=; b=rRplEjKh2FkbC24wb/wJ3BraLnKq/2mDZyrb2IHi4gJh6OsxFhv
        SPEAcM1G5+Dla+Be8jg2Bd05RZ3X5qrsAyrM8q0CN0tUfNLG6vsSietJmxPgVI3V
        iH2S61Tq02Pi1JSw6SmpB9JiM05bKLF23xIuzdEdeotSeyr8gMJ9q1J/WNQL3Mtl
        G8QTbu9igsN2RJH9P9jtZYDuzqd1zT4+Hwpfor8amAgArSFLnJQUtRU5kd+BmYtI
        zeCK9zlqesOGErKVHj4NEQ/li5OaAhQIZHGBN4sFqhHx21jFP53qJGyyJ4MxgHbU
        4UMwYtTrfCEjUye3EvBeOfgrPG1C00PLdWA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5WEmHjwtjf4M for <linux-kernel@vger.kernel.org>;
        Thu, 17 Feb 2022 02:49:13 -0800 (PST)
Received: from [10.225.163.77] (unknown [10.225.163.77])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jzs5N4YMtz1Rwrw;
        Thu, 17 Feb 2022 02:49:12 -0800 (PST)
Message-ID: <1d287c7e-8aff-beea-1bd6-4b2226f9f3db@opensource.wdc.com>
Date:   Thu, 17 Feb 2022 19:49:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH RESEND v2] dm: Fix use-after-free in
 dm_cleanup_zoned_dev()
Content-Language: en-US
To:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        linux-kernel@vger.kernel.org
References: <c64d2143-284e-7621-440c-971e3405b4d8@virtuozzo.com>
 <d209a0b1-2514-79a0-257a-22bcb372785a@virtuozzo.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <d209a0b1-2514-79a0-257a-22bcb372785a@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/22 19:13, Kirill Tkhai wrote:
> 
> dm_cleanup_zoned_dev() uses queue, so it must be called
> before blk_cleanup_disk() starts its killing:
> 
> blk_cleanup_disk->blk_cleanup_queue()->kobject_put()->blk_release_queue()->
> ->...RCU...->blk_free_queue_rcu()->kmem_cache_free()
> 
> Otherwise, RCU callback may be executed first,
> and dm_cleanup_zoned_dev() touches freed memory:

Mike,

Can you queue this please ?

> 
>  BUG: KASAN: use-after-free in dm_cleanup_zoned_dev+0x33/0xd0
>  Read of size 8 at addr ffff88805ac6e430 by task dmsetup/681
> 
>  CPU: 4 PID: 681 Comm: dmsetup Not tainted 5.17.0-rc2+ #6
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x57/0x7d
>   print_address_description.constprop.0+0x1f/0x150
>   ? dm_cleanup_zoned_dev+0x33/0xd0
>   kasan_report.cold+0x7f/0x11b
>   ? dm_cleanup_zoned_dev+0x33/0xd0
>   dm_cleanup_zoned_dev+0x33/0xd0
>   __dm_destroy+0x26a/0x400
>   ? dm_blk_ioctl+0x230/0x230
>   ? up_write+0xd8/0x270
>   dev_remove+0x156/0x1d0
>   ctl_ioctl+0x269/0x530
>   ? table_clear+0x140/0x140
>   ? lock_release+0xb2/0x750
>   ? remove_all+0x40/0x40
>   ? rcu_read_lock_sched_held+0x12/0x70
>   ? lock_downgrade+0x3c0/0x3c0
>   ? rcu_read_lock_sched_held+0x12/0x70
>   dm_ctl_ioctl+0xa/0x10
>   __x64_sys_ioctl+0xb9/0xf0
>   do_syscall_64+0x3b/0x90
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>  RIP: 0033:0x7fb6dfa95c27
>  Code: 00 00 00 48 8b 05 69 92 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 92 0c 00 f7 d8 64 89 01 48
>  RSP: 002b:00007fff882c6c28 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
>  RAX: ffffffffffffffda RBX: 00007fb6dfb73a8e RCX: 00007fb6dfa95c27
>  RDX: 00007fb6e01d7ca0 RSI: 00000000c138fd04 RDI: 0000000000000003
>  RBP: 00007fff882c6ce0 R08: 00007fb6dfbc3558 R09: 00007fff882c6a90
>  R10: 00007fb6dfbc28a2 R11: 0000000000000206 R12: 00007fb6dfbc28a2
>  R13: 00007fb6dfbc28a2 R14: 00007fb6dfbc28a2 R15: 00007fb6dfbc28a2
>   </TASK>
> 
>  Allocated by task 673:
>   kasan_save_stack+0x1e/0x40
>   __kasan_slab_alloc+0x66/0x80
>   kmem_cache_alloc_node+0x1ca/0x460
>   blk_alloc_queue+0x33/0x4e0
>   __blk_alloc_disk+0x1b/0x60
>   dm_create+0x368/0xa20
>   dev_create+0xb9/0x170
>   ctl_ioctl+0x269/0x530
>   dm_ctl_ioctl+0xa/0x10
>   __x64_sys_ioctl+0xb9/0xf0
>   do_syscall_64+0x3b/0x90
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
>  Freed by task 0:
>   kasan_save_stack+0x1e/0x40
>   kasan_set_track+0x21/0x30
>   kasan_set_free_info+0x20/0x30
>   __kasan_slab_free+0xfb/0x130
>   slab_free_freelist_hook+0x7d/0x150
>   kmem_cache_free+0x13c/0x340
>   rcu_do_batch+0x2d9/0x820
>   rcu_core+0x3b8/0x570
>   __do_softirq+0x1c4/0x63d
> 
>  Last potentially related work creation:
>   kasan_save_stack+0x1e/0x40
>   __kasan_record_aux_stack+0x96/0xa0
>   call_rcu+0xc4/0x8f0
>   kobject_put+0xd9/0x270
>   disk_release+0xee/0x120
>   device_release+0x59/0xf0
>   kobject_put+0xd9/0x270
>   cleanup_mapped_device+0x12b/0x1b0
>   __dm_destroy+0x26a/0x400
>   dev_remove+0x156/0x1d0
>   ctl_ioctl+0x269/0x530
>   dm_ctl_ioctl+0xa/0x10
>   __x64_sys_ioctl+0xb9/0xf0
>   do_syscall_64+0x3b/0x90
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
>  The buggy address belongs to the object at ffff88805ac6e180
>   which belongs to the cache request_queue of size 2992
>  The buggy address is located 688 bytes inside of
>   2992-byte region [ffff88805ac6e180, ffff88805ac6ed30)
>  The buggy address belongs to the page:
>  page:000000000837df3c refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5ac68
>  head:000000000837df3c order:3 compound_mapcount:0 compound_pincount:0
>  flags: 0xfffffc0010200(slab|head|node=0|zone=1|lastcpupid=0x1fffff)
>  raw: 000fffffc0010200 0000000000000000 dead000000000122 ffff888001e58280
>  raw: 0000000000000000 00000000800a000a 00000001ffffffff 0000000000000000
>  page dumped because: kasan: bad access detected
> 
>  Memory state around the buggy address:
>   ffff88805ac6e300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff88805ac6e380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  >ffff88805ac6e400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                       ^
>   ffff88805ac6e480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff88805ac6e500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ==================================================================
> 
> Fixes: bb37d77239af "dm: introduce zone append emulation"
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
> v2: Split long commit message line and delete [xxx] time prefix from kernel output.
> 
>  drivers/md/dm.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index dcbd6d201619..d472fe5dbc1d 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1607,6 +1607,7 @@ static void cleanup_mapped_device(struct mapped_device *md)
>  		md->dax_dev = NULL;
>  	}
>  
> +	dm_cleanup_zoned_dev(md);
>  	if (md->disk) {
>  		spin_lock(&_minor_lock);
>  		md->disk->private_data = NULL;
> @@ -1627,7 +1628,6 @@ static void cleanup_mapped_device(struct mapped_device *md)
>  	mutex_destroy(&md->swap_bios_lock);
>  
>  	dm_mq_cleanup_mapped_device(md);
> -	dm_cleanup_zoned_dev(md);
>  }
>  
>  /*
> 


-- 
Damien Le Moal
Western Digital Research
