Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843A14778F3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 17:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbhLPQ1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 11:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbhLPQ1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:27:34 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E535BC06173E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 08:27:33 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id o20so89336898eds.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 08:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UFhp72V3A+JFvpP9h1xR9ujFQr2UpojnH4OtFCU5ae0=;
        b=CVTc6B6Z7gJ0rj1AG8bvrr4yi3P9oAkqmDD9tbemwIn27DPsia+cue5o/2VStW6XCx
         5UkeAWYJuIo7vMQO+xnMKdUmyngQ7zrxcGBKy0t4kIUsqulpMuKY5kNB5nyvCmD/4uVl
         czGQo9dyocaJc/mSjRz91gHD++GxafVFK0VIu4R6DOI8VDpfdSKt3dAtDCx5Onhv9HIj
         sbnI8BJLlPy44OoHTaafKM//JmT57PzJ0f26ot/4MtBc6KD/062A/v23oca2G3GDX5ON
         Q1uDzcSG9kltao+s07gHDa/Boc3mv7Rq5xK7deeKvm5sHV7F3uvJZDgWdZiYuG/Hml93
         2H3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UFhp72V3A+JFvpP9h1xR9ujFQr2UpojnH4OtFCU5ae0=;
        b=GDGzMFjoCDOlNGn95B9cqho/JtsC7GXNOe1/A6BtFs4v9pz64AI6z2PTQgCgHAMeo0
         z1/mtTX3atyQULwKDB7c6kjz4sI4z9ihl1iWOZwRND1F4kZ1Oc4x/Krsw1KpdwrHXyNG
         YIr41a1eJVEjsjsMLP8iE9aZb+zxAITI+SVJSwxdjKuu2hweQCIcVeHafvox3Wg8aM/P
         Cwj1imFCZgfvA3h/FNFZZyJvltsRB2yJfBLIBqgQFTacgNNoGPtf5V60mPbquWI3Ui3m
         +Ct1A83OFL4AlLH27cKZEDKoWfRIWxin0qURgD6iENIDgd6xiH+DIJEoyfQhAIYZGItX
         nJLg==
X-Gm-Message-State: AOAM532uw5gQiBlxVEDJSN7y8fsVvk2L6ACzLuvaIgLOHVL6F+NtPGLs
        AqMYF3UFi6tauaFDDaQ0rmDcdA==
X-Google-Smtp-Source: ABdhPJyds4b6rojNCPo4aUx1OwXon/AzupQqBu4FNH2V/XOfbPL4KmrMnHOeyav8p8Z2zWmzpulzXQ==
X-Received: by 2002:a17:906:6c96:: with SMTP id s22mr7891111ejr.756.1639672052265;
        Thu, 16 Dec 2021 08:27:32 -0800 (PST)
Received: from [192.168.1.5] (net-93-70-85-238.cust.vodafonedsl.it. [93.70.85.238])
        by smtp.gmail.com with ESMTPSA id ga42sm1954318ejc.200.2021.12.16.08.27.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Dec 2021 08:27:31 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH -next v3] bfq: fix use-after-free in bfq_dispatch_request
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20211216122157.672159-1-zhangwensheng5@huawei.com>
Date:   Thu, 16 Dec 2021 17:27:30 +0100
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <42FD69CD-16CF-447D-AA69-621EE97CE3DC@linaro.org>
References: <20211216122157.672159-1-zhangwensheng5@huawei.com>
To:     Zhang Wensheng <zhangwensheng5@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 16 dic 2021, alle ore 13:21, Zhang Wensheng =
<zhangwensheng5@huawei.com> ha scritto:
>=20
> KASAN reports a use-after-free report when doing normal scsi-mq test
>=20
> [69832.239032] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [69832.241810] BUG: KASAN: use-after-free in =
bfq_dispatch_request+0x1045/0x44b0
> [69832.243267] Read of size 8 at addr ffff88802622ba88 by task =
kworker/3:1H/155
> [69832.244656]
> [69832.245007] CPU: 3 PID: 155 Comm: kworker/3:1H Not tainted =
5.10.0-10295-g576c6382529e #8
> [69832.246626] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), =
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [69832.249069] Workqueue: kblockd blk_mq_run_work_fn
> [69832.250022] Call Trace:
> [69832.250541]  dump_stack+0x9b/0xce
> [69832.251232]  ? bfq_dispatch_request+0x1045/0x44b0
> [69832.252243]  print_address_description.constprop.6+0x3e/0x60
> [69832.253381]  ? __cpuidle_text_end+0x5/0x5
> [69832.254211]  ? vprintk_func+0x6b/0x120
> [69832.254994]  ? bfq_dispatch_request+0x1045/0x44b0
> [69832.255952]  ? bfq_dispatch_request+0x1045/0x44b0
> [69832.256914]  kasan_report.cold.9+0x22/0x3a
> [69832.257753]  ? bfq_dispatch_request+0x1045/0x44b0
> [69832.258755]  check_memory_region+0x1c1/0x1e0
> [69832.260248]  bfq_dispatch_request+0x1045/0x44b0
> [69832.261181]  ? bfq_bfqq_expire+0x2440/0x2440
> [69832.262032]  ? blk_mq_delay_run_hw_queues+0xf9/0x170
> [69832.263022]  __blk_mq_do_dispatch_sched+0x52f/0x830
> [69832.264011]  ? blk_mq_sched_request_inserted+0x100/0x100
> [69832.265101]  __blk_mq_sched_dispatch_requests+0x398/0x4f0
> [69832.266206]  ? blk_mq_do_dispatch_ctx+0x570/0x570
> [69832.267147]  ? __switch_to+0x5f4/0xee0
> [69832.267898]  blk_mq_sched_dispatch_requests+0xdf/0x140
> [69832.268946]  __blk_mq_run_hw_queue+0xc0/0x270
> [69832.269840]  blk_mq_run_work_fn+0x51/0x60
> [69832.278170]  process_one_work+0x6d4/0xfe0
> [69832.278984]  worker_thread+0x91/0xc80
> [69832.279726]  ? __kthread_parkme+0xb0/0x110
> [69832.280554]  ? process_one_work+0xfe0/0xfe0
> [69832.281414]  kthread+0x32d/0x3f0
> [69832.282082]  ? kthread_park+0x170/0x170
> [69832.282849]  ret_from_fork+0x1f/0x30
> [69832.283573]
> [69832.283886] Allocated by task 7725:
> [69832.284599]  kasan_save_stack+0x19/0x40
> [69832.285385]  __kasan_kmalloc.constprop.2+0xc1/0xd0
> [69832.286350]  kmem_cache_alloc_node+0x13f/0x460
> [69832.287237]  bfq_get_queue+0x3d4/0x1140
> [69832.287993]  bfq_get_bfqq_handle_split+0x103/0x510
> [69832.289015]  bfq_init_rq+0x337/0x2d50
> [69832.289749]  bfq_insert_requests+0x304/0x4e10
> [69832.290634]  blk_mq_sched_insert_requests+0x13e/0x390
> [69832.291629]  blk_mq_flush_plug_list+0x4b4/0x760
> [69832.292538]  blk_flush_plug_list+0x2c5/0x480
> [69832.293392]  io_schedule_prepare+0xb2/0xd0
> [69832.294209]  io_schedule_timeout+0x13/0x80
> [69832.295014]  wait_for_common_io.constprop.1+0x13c/0x270
> [69832.296137]  submit_bio_wait+0x103/0x1a0
> [69832.296932]  blkdev_issue_discard+0xe6/0x160
> [69832.297794]  blk_ioctl_discard+0x219/0x290
> [69832.298614]  blkdev_common_ioctl+0x50a/0x1750
> [69832.304715]  blkdev_ioctl+0x470/0x600
> [69832.305474]  block_ioctl+0xde/0x120
> [69832.306232]  vfs_ioctl+0x6c/0xc0
> [69832.306877]  __se_sys_ioctl+0x90/0xa0
> [69832.307629]  do_syscall_64+0x2d/0x40
> [69832.308362]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [69832.309382]
> [69832.309701] Freed by task 155:
> [69832.310328]  kasan_save_stack+0x19/0x40
> [69832.311121]  kasan_set_track+0x1c/0x30
> [69832.311868]  kasan_set_free_info+0x1b/0x30
> [69832.312699]  __kasan_slab_free+0x111/0x160
> [69832.313524]  kmem_cache_free+0x94/0x460
> [69832.314367]  bfq_put_queue+0x582/0x940
> [69832.315112]  __bfq_bfqd_reset_in_service+0x166/0x1d0
> [69832.317275]  bfq_bfqq_expire+0xb27/0x2440
> [69832.318084]  bfq_dispatch_request+0x697/0x44b0
> [69832.318991]  __blk_mq_do_dispatch_sched+0x52f/0x830
> [69832.319984]  __blk_mq_sched_dispatch_requests+0x398/0x4f0
> [69832.321087]  blk_mq_sched_dispatch_requests+0xdf/0x140
> [69832.322225]  __blk_mq_run_hw_queue+0xc0/0x270
> [69832.323114]  blk_mq_run_work_fn+0x51/0x60
> [69832.323942]  process_one_work+0x6d4/0xfe0
> [69832.324772]  worker_thread+0x91/0xc80
> [69832.325518]  kthread+0x32d/0x3f0
> [69832.326205]  ret_from_fork+0x1f/0x30
> [69832.326932]
> [69832.338297] The buggy address belongs to the object at =
ffff88802622b968
> [69832.338297]  which belongs to the cache bfq_queue of size 512
> [69832.340766] The buggy address is located 288 bytes inside of
> [69832.340766]  512-byte region [ffff88802622b968, ffff88802622bb68)
> [69832.343091] The buggy address belongs to the page:
> [69832.344097] page:ffffea0000988a00 refcount:1 mapcount:0 =
mapping:0000000000000000 index:0xffff88802622a528 pfn:0x26228
> [69832.346214] head:ffffea0000988a00 order:2 compound_mapcount:0 =
compound_pincount:0
> [69832.347719] flags: 0x1fffff80010200(slab|head)
> [69832.348625] raw: 001fffff80010200 ffffea0000dbac08 ffff888017a57650 =
ffff8880179fe840
> [69832.354972] raw: ffff88802622a528 0000000000120008 00000001ffffffff =
0000000000000000
> [69832.356547] page dumped because: kasan: bad access detected
> [69832.357652]
> [69832.357970] Memory state around the buggy address:
> [69832.358926]  ffff88802622b980: fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb
> [69832.360358]  ffff88802622ba00: fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb
> [69832.361810] >ffff88802622ba80: fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb
> [69832.363273]                       ^
> [69832.363975]  ffff88802622bb00: fb fb fb fb fb fb fb fb fb fb fb fb =
fb fc fc fc
> [69832.375960]  ffff88802622bb80: fc fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc fc
> [69832.377405] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> In bfq_dispatch_requestfunction, it may have function call:
>=20
> bfq_dispatch_request
> 	__bfq_dispatch_request
> 		bfq_select_queue
> 			bfq_bfqq_expire
> 				__bfq_bfqd_reset_in_service
> 					bfq_put_queue
> 						kmem_cache_free
> In this function call, in_serv_queue has beed expired and meet
> the conditions to free. In the function bfq_dispatch_request,
> the address of in_serv_queue pointing to has been released. For
> getting the value of idle_timer_disabled, it will get flags
> value from the address which in_serv_queue pointing to, then
> the problem of use-after-free happens;
>=20
> Fix the problem by check in_serv_queue =3D=3D bfqd->in_service_queue,
> to get the value of idle_timer_disabled if in_serve_queue is equel
> to bfqd->in_service_queue. If the space of in_serv_queue pointing
> has been released, this judge will aviod use-after-free problem.
> And if in_serv_queue may be expired but it still exists, this judge
> may have little effects on the function bfqg_stats_update_idle_time
> in bfq_update_dispatch_stats.
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhang Wensheng <zhangwensheng5@huawei.com>
> ---
> block/bfq-iosched.c | 9 +++++----
> 1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index fec18118dc30..97533634b99e 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -5061,7 +5061,7 @@ static struct request =
*bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
> 	struct bfq_data *bfqd =3D hctx->queue->elevator->elevator_data;
> 	struct request *rq;
> 	struct bfq_queue *in_serv_queue;
> -	bool waiting_rq, idle_timer_disabled;
> +	bool waiting_rq, idle_timer_disabled =3D false;
>=20
> 	spin_lock_irq(&bfqd->lock);
>=20
> @@ -5070,9 +5070,10 @@ static struct request =
*bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
>=20
> 	rq =3D __bfq_dispatch_request(hctx);
>=20
> -	idle_timer_disabled =3D
> -		waiting_rq && !bfq_bfqq_wait_request(in_serv_queue);
> -
> +	if (in_serv_queue =3D=3D bfqd->in_service_queue) {
> +		idle_timer_disabled =3D
> +			waiting_rq && =
!bfq_bfqq_wait_request(in_serv_queue);
> +	}

Good catch!

> 	spin_unlock_irq(&bfqd->lock);
>=20
> 	bfq_update_dispatch_stats(hctx->queue, rq, in_serv_queue,

Yet, what about the above use of in_serv_queue then?

Thanks,
Paolo

> --=20
> 2.31.1
>=20

