Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318B4493B6E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 14:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354919AbiASNt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 08:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354925AbiASNtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 08:49:51 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8CBC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 05:49:50 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id c71so11989019edf.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 05:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ky19cv1Lut+8dGo0U+fVgWhB7XVrVuWGUw227TS3ew0=;
        b=X5CpHzk8VMF828rNfPcStnEFxlxgIbrGWZC9mb8YWAAKOe6wKxDqSJzNZPy2+l0qmT
         z6gj2S3bFr3sbs40zjsLU1PnmrtB5EJme9Gx+l3q/XFrlfrNHyj2jM0VqRBHH99U2Iak
         ggmSSXLkAxbvWDDhiFdTmQZf57H1vJtCrR4Mn02Xb95unTRYfGSUSRGfkpeuQ8iYa8YG
         yA7yvEZrxqAwwsGAS+1oHCTFs0F85wizdPuREj/esrNE8EpCnXSzfKHAeui9poB+1zBG
         P9hd4GUQs4JjO8s90rbs2YLB9qSamzWM1dlvsWbO5N5M2k58n22W0HrAGb6rfxz+S8QR
         /DkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ky19cv1Lut+8dGo0U+fVgWhB7XVrVuWGUw227TS3ew0=;
        b=UO06dKlLVlDkUtrnY0aCNLQMc0KXk2iU+gO1lZyxmfSUpFon2HqvexxwwlIQA6B6nN
         c491B0vFWTgDoTmp6Vp8FiCgE+CbdC+frM9ieg6wuqGDIkLfq9q7XpUuIhyh/pgErbQw
         eb64r3CJcQRcT7c4SW6L6re+aiHt2Nna3xLGo5VB47+McVIJxGW2TvHYX9HSaKn9I4sv
         5V+bDxf8Z1VQ6eiwgB2G+A1dk37GTzOiKUD4TrjtpWrXnA4ZqKBrFPMRKAECPbEn5Aof
         Yj9WT5vuZXfCZx96mwlXuoQ7B/g3MizFkg21XtZSUypVrJs7yprIOhmLHAzlZN1mNphq
         V2bg==
X-Gm-Message-State: AOAM532jBeobePmMWZWUzfgYtUoAr4DXaOvD/iJD5LIQT2WhJVOQl5g4
        APQqBNsgkzhwWhnqy4zpSuBFZJni8860IyGf
X-Google-Smtp-Source: ABdhPJx8R3WVqso+f6T5bbVgqhpiPxmwNFrAY/zv1L1P8MCcd+DtXr6iQU1nrfHeBk+IGsWaDJM6rQ==
X-Received: by 2002:a05:600c:3502:: with SMTP id h2mr3707488wmq.166.1642600189078;
        Wed, 19 Jan 2022 05:49:49 -0800 (PST)
Received: from wifi-122-dhcprange-122-30.wifi.unimo.it (wifi-122-dhcprange-122-30.wifi.unimo.it. [155.185.122.30])
        by smtp.gmail.com with ESMTPSA id g3sm10817900wri.110.2022.01.19.05.49.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jan 2022 05:49:48 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH -next v3] bfq: fix use-after-free in bfq_dispatch_request
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <ecbec03d147e441bb5b91a0cae3fb782@huawei.com>
Date:   Wed, 19 Jan 2022 14:49:46 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <00FA42CF-DDAC-41E4-88F6-0C0346BFF68F@linaro.org>
References: <20211216122157.672159-1-zhangwensheng5@huawei.com>
 <42FD69CD-16CF-447D-AA69-621EE97CE3DC@linaro.org>
 <ecbec03d147e441bb5b91a0cae3fb782@huawei.com>
To:     "zhangwensheng (E)" <zhangwensheng5@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 23 dic 2021, alle ore 03:06, zhangwensheng (E) =
<zhangwensheng5@huawei.com> ha scritto:
>=20
> ping...
>=20
> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: zhangwensheng (E)=20
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2021=E5=B9=B412=E6=9C=8820=E6=97=A5=
 10:35
> =E6=94=B6=E4=BB=B6=E4=BA=BA: 'Paolo Valente' =
<paolo.valente@linaro.org>
> =E6=8A=84=E9=80=81: Jens Axboe <axboe@kernel.dk>; =
linux-block@vger.kernel.org; linux-kernel@vger.kernel.org
> =E4=B8=BB=E9=A2=98: =E7=AD=94=E5=A4=8D: [PATCH -next v3] bfq: fix =
use-after-free in bfq_dispatch_request
>=20
> Hi paolo=EF=BC=9A
> 	Thanks for your question, it is my negligence.
> 	I have two ideas for repairing the problem:
>=20

Hi,
sorry for the delay.  I've been thinking of this UAF a little bit
more, and I've realized that in_serv_queue may become a pending
pointer only if in_serv_queue has no rq queued.  But, if in_serv_queue
has no rq queued, then idle_timer_disabled will necessarily be false.
And, if idle_timer_disabled is false, then the parameter in_serv_queue
will not be used inside bfq_update_dispatch_stats.  So, after your
initial fix, the rest of the code seems already correct, with no
change.

Maybe, if we don't like to pass a pending pointer, what about
something like

...
	bfq_update_dispatch_stats(hctx->queue, rq,
			idle_timer_disabled ? in_serv_queue : NULL,
				  idle_timer_disabled);

(the above is just to give express my idea, please write better code
if needed).

Thanks,
Paolo


> 1. use ref++ to avoid the in_serv_queue being released. Patch as =
follow:
>=20
> block/bfq-iosched.c | 5 +++++
> 1 file changed, 5 insertions(+)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c index =
fec18118dc30..70bd280170f9 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -5066,6 +5066,7 @@ static struct request =
*bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
>        spin_lock_irq(&bfqd->lock);
>=20
>        in_serv_queue =3D bfqd->in_service_queue;
> +       in_serv_queue->ref++; /* aviod in_serv_queue release */
>        waiting_rq =3D in_serv_queue && =
bfq_bfqq_wait_request(in_serv_queue);
>=20
>        rq =3D __bfq_dispatch_request(hctx); @@ -5077,6 +5078,10 @@ =
static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
>=20
>        bfq_update_dispatch_stats(hctx->queue, rq, in_serv_queue,
>                                  idle_timer_disabled);
> +       /* resume in_serv_queue */
> +       spin_lock_irq(&bfqd->lock);
> +       bfq_put_queue(in_serv_queue);
> +       spin_unlock_irq(&bfqd->lock);
>=20
>        return rq;
> }
>=20
> 2. add new changes to previous, taking out bfqq_group(in_serv_queue) =
from bfq_update_dispatch_stats. Patch as follow:
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -5007,7 +5007,7 @@ static struct request =
*__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)  #ifdef =
CONFIG_BFQ_CGROUP_DEBUG  static void bfq_update_dispatch_stats(struct =
request_queue *q,
>                                      struct request *rq,
> -                                     struct bfq_queue *in_serv_queue,
> +                                     struct bfq_group *bfqg_in_serv,
>                                      bool idle_timer_disabled)  {
>        struct bfq_queue *bfqq =3D rq ? RQ_BFQQ(rq) : NULL; @@ -5039,7 =
+5039,7 @@ static void bfq_update_dispatch_stats(struct request_queue =
*q,
>                 * therefore guaranteed to exist because of the above
>                 * arguments.
>                 */
> -               =
bfqg_stats_update_idle_time(bfqq_group(in_serv_queue));
> +               bfqg_stats_update_idle_time(bfqg_in_serv);
>        if (bfqq) {
>                struct bfq_group *bfqg =3D bfqq_group(bfqq);
>=20
> @@ -5052,7 +5052,7 @@ static void bfq_update_dispatch_stats(struct =
request_queue *q,  #else  static inline void =
bfq_update_dispatch_stats(struct request_queue *q,
>                                             struct request *rq,
> -                                            struct bfq_queue =
*in_serv_queue,
> +                                            struct bfq_group=20
> + *bfqg_in_serv,
>                                             bool idle_timer_disabled) =
{}  #endif /* CONFIG_BFQ_CGROUP_DEBUG */
>=20
> @@ -5062,20 +5062,23 @@ static struct request =
*bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
>        struct request *rq;
>        struct bfq_queue *in_serv_queue;
>        bool waiting_rq, idle_timer_disabled;
> +       struct bfq_group *bfqg_in_serv;
>=20
>        spin_lock_irq(&bfqd->lock);
>=20
>        in_serv_queue =3D bfqd->in_service_queue;
>        waiting_rq =3D in_serv_queue && =
bfq_bfqq_wait_request(in_serv_queue);
> +       bfqg_in_serv =3D bfqq_group(in_serv_queue);
>=20
>        rq =3D __bfq_dispatch_request(hctx);
>=20
> -       idle_timer_disabled =3D
> -               waiting_rq && !bfq_bfqq_wait_request(in_serv_queue);
> -
> +       if (in_serv_queue =3D=3D bfqd->in_service_queue) {
> +               idle_timer_disabled =3D
> +                       waiting_rq && =
!bfq_bfqq_wait_request(in_serv_queue);
> +       }
>        spin_unlock_irq(&bfqd->lock);
>=20
> -       bfq_update_dispatch_stats(hctx->queue, rq, in_serv_queue,
> +       bfq_update_dispatch_stats(hctx->queue, rq, bfqg_in_serv,
>                                  idle_timer_disabled);
>=20
>        return rq;
>=20
> 	what do you think?
> =09
> 	Thanks
> 	Zhang Wensheng
> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Paolo Valente =
[mailto:paolo.valente@linaro.org]
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2021=E5=B9=B412=E6=9C=8817=E6=97=A5=
 0:28
> =E6=94=B6=E4=BB=B6=E4=BA=BA: zhangwensheng (E) =
<zhangwensheng5@huawei.com>
> =E6=8A=84=E9=80=81: Jens Axboe <axboe@kernel.dk>; =
linux-block@vger.kernel.org; linux-kernel@vger.kernel.org
> =E4=B8=BB=E9=A2=98: Re: [PATCH -next v3] bfq: fix use-after-free in =
bfq_dispatch_request
>=20
>=20
>=20
>> Il giorno 16 dic 2021, alle ore 13:21, Zhang Wensheng =
<zhangwensheng5@huawei.com> ha scritto:
>>=20
>> KASAN reports a use-after-free report when doing normal scsi-mq test
>>=20
>> [69832.239032]=20
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [69832.241810] BUG: KASAN: use-after-free in=20
>> bfq_dispatch_request+0x1045/0x44b0
>> [69832.243267] Read of size 8 at addr ffff88802622ba88 by task=20
>> kworker/3:1H/155 [69832.244656] [69832.245007] CPU: 3 PID: 155 Comm:=20=

>> kworker/3:1H Not tainted 5.10.0-10295-g576c6382529e #8 [69832.246626]=20=

>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS=20
>> rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014 =
[69832.249069]=20
>> Workqueue: kblockd blk_mq_run_work_fn [69832.250022] Call Trace:
>> [69832.250541]  dump_stack+0x9b/0xce
>> [69832.251232]  ? bfq_dispatch_request+0x1045/0x44b0
>> [69832.252243]  print_address_description.constprop.6+0x3e/0x60
>> [69832.253381]  ? __cpuidle_text_end+0x5/0x5 [69832.254211]  ?=20
>> vprintk_func+0x6b/0x120 [69832.254994]  ?=20
>> bfq_dispatch_request+0x1045/0x44b0
>> [69832.255952]  ? bfq_dispatch_request+0x1045/0x44b0
>> [69832.256914]  kasan_report.cold.9+0x22/0x3a [69832.257753]  ?=20
>> bfq_dispatch_request+0x1045/0x44b0
>> [69832.258755]  check_memory_region+0x1c1/0x1e0 [69832.260248] =20
>> bfq_dispatch_request+0x1045/0x44b0
>> [69832.261181]  ? bfq_bfqq_expire+0x2440/0x2440 [69832.262032]  ?=20
>> blk_mq_delay_run_hw_queues+0xf9/0x170
>> [69832.263022]  __blk_mq_do_dispatch_sched+0x52f/0x830
>> [69832.264011]  ? blk_mq_sched_request_inserted+0x100/0x100
>> [69832.265101]  __blk_mq_sched_dispatch_requests+0x398/0x4f0
>> [69832.266206]  ? blk_mq_do_dispatch_ctx+0x570/0x570
>> [69832.267147]  ? __switch_to+0x5f4/0xee0 [69832.267898] =20
>> blk_mq_sched_dispatch_requests+0xdf/0x140
>> [69832.268946]  __blk_mq_run_hw_queue+0xc0/0x270 [69832.269840] =20
>> blk_mq_run_work_fn+0x51/0x60 [69832.278170] =20
>> process_one_work+0x6d4/0xfe0 [69832.278984]  worker_thread+0x91/0xc80=20=

>> [69832.279726]  ? __kthread_parkme+0xb0/0x110 [69832.280554]  ?=20
>> process_one_work+0xfe0/0xfe0 [69832.281414]  kthread+0x32d/0x3f0=20
>> [69832.282082]  ? kthread_park+0x170/0x170 [69832.282849] =20
>> ret_from_fork+0x1f/0x30 [69832.283573] [69832.283886] Allocated by=20
>> task 7725:
>> [69832.284599]  kasan_save_stack+0x19/0x40 [69832.285385] =20
>> __kasan_kmalloc.constprop.2+0xc1/0xd0
>> [69832.286350]  kmem_cache_alloc_node+0x13f/0x460 [69832.287237] =20
>> bfq_get_queue+0x3d4/0x1140 [69832.287993] =20
>> bfq_get_bfqq_handle_split+0x103/0x510
>> [69832.289015]  bfq_init_rq+0x337/0x2d50 [69832.289749] =20
>> bfq_insert_requests+0x304/0x4e10 [69832.290634] =20
>> blk_mq_sched_insert_requests+0x13e/0x390
>> [69832.291629]  blk_mq_flush_plug_list+0x4b4/0x760
>> [69832.292538]  blk_flush_plug_list+0x2c5/0x480 [69832.293392] =20
>> io_schedule_prepare+0xb2/0xd0 [69832.294209] =20
>> io_schedule_timeout+0x13/0x80 [69832.295014] =20
>> wait_for_common_io.constprop.1+0x13c/0x270
>> [69832.296137]  submit_bio_wait+0x103/0x1a0 [69832.296932] =20
>> blkdev_issue_discard+0xe6/0x160 [69832.297794] =20
>> blk_ioctl_discard+0x219/0x290 [69832.298614] =20
>> blkdev_common_ioctl+0x50a/0x1750 [69832.304715] =20
>> blkdev_ioctl+0x470/0x600 [69832.305474]  block_ioctl+0xde/0x120=20
>> [69832.306232]  vfs_ioctl+0x6c/0xc0 [69832.306877] =20
>> __se_sys_ioctl+0x90/0xa0 [69832.307629]  do_syscall_64+0x2d/0x40=20
>> [69832.308362]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [69832.309382]
>> [69832.309701] Freed by task 155:
>> [69832.310328]  kasan_save_stack+0x19/0x40 [69832.311121] =20
>> kasan_set_track+0x1c/0x30 [69832.311868] =20
>> kasan_set_free_info+0x1b/0x30 [69832.312699] =20
>> __kasan_slab_free+0x111/0x160 [69832.313524] =20
>> kmem_cache_free+0x94/0x460 [69832.314367]  bfq_put_queue+0x582/0x940=20=

>> [69832.315112]  __bfq_bfqd_reset_in_service+0x166/0x1d0
>> [69832.317275]  bfq_bfqq_expire+0xb27/0x2440 [69832.318084] =20
>> bfq_dispatch_request+0x697/0x44b0 [69832.318991] =20
>> __blk_mq_do_dispatch_sched+0x52f/0x830
>> [69832.319984]  __blk_mq_sched_dispatch_requests+0x398/0x4f0
>> [69832.321087]  blk_mq_sched_dispatch_requests+0xdf/0x140
>> [69832.322225]  __blk_mq_run_hw_queue+0xc0/0x270 [69832.323114] =20
>> blk_mq_run_work_fn+0x51/0x60 [69832.323942] =20
>> process_one_work+0x6d4/0xfe0 [69832.324772]  worker_thread+0x91/0xc80=20=

>> [69832.325518]  kthread+0x32d/0x3f0 [69832.326205] =20
>> ret_from_fork+0x1f/0x30 [69832.326932] [69832.338297] The buggy=20
>> address belongs to the object at ffff88802622b968 [69832.338297] =20
>> which belongs to the cache bfq_queue of size 512 [69832.340766] The=20=

>> buggy address is located 288 bytes inside of [69832.340766]  512-byte=20=

>> region [ffff88802622b968, ffff88802622bb68) [69832.343091] The buggy=20=

>> address belongs to the page:
>> [69832.344097] page:ffffea0000988a00 refcount:1 mapcount:0=20
>> mapping:0000000000000000 index:0xffff88802622a528 pfn:0x26228=20
>> [69832.346214] head:ffffea0000988a00 order:2 compound_mapcount:0=20
>> compound_pincount:0 [69832.347719] flags: 0x1fffff80010200(slab|head)=20=

>> [69832.348625] raw: 001fffff80010200 ffffea0000dbac08 =
ffff888017a57650=20
>> ffff8880179fe840 [69832.354972] raw: ffff88802622a528 =
0000000000120008=20
>> 00000001ffffffff 0000000000000000 [69832.356547] page dumped because:=20=

>> kasan: bad access detected [69832.357652] [69832.357970] Memory state =
around the buggy address:
>> [69832.358926]  ffff88802622b980: fb fb fb fb fb fb fb fb fb fb fb fb=20=

>> fb fb fb fb [69832.360358]  ffff88802622ba00: fb fb fb fb fb fb fb fb=20=

>> fb fb fb fb fb fb fb fb [69832.361810] >ffff88802622ba80: fb fb fb fb =
fb fb fb fb fb fb fb fb fb fb fb fb
>> [69832.363273]                       ^
>> [69832.363975]  ffff88802622bb00: fb fb fb fb fb fb fb fb fb fb fb fb=20=

>> fb fc fc fc [69832.375960]  ffff88802622bb80: fc fc fc fc fc fc fc fc=20=

>> fc fc fc fc fc fc fc fc [69832.377405]=20
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> In bfq_dispatch_requestfunction, it may have function call:
>>=20
>> bfq_dispatch_request
>> 	__bfq_dispatch_request
>> 		bfq_select_queue
>> 			bfq_bfqq_expire
>> 				__bfq_bfqd_reset_in_service
>> 					bfq_put_queue
>> 						kmem_cache_free
>> In this function call, in_serv_queue has beed expired and meet the=20
>> conditions to free. In the function bfq_dispatch_request, the address=20=

>> of in_serv_queue pointing to has been released. For getting the value=20=

>> of idle_timer_disabled, it will get flags value from the address =
which=20
>> in_serv_queue pointing to, then the problem of use-after-free =
happens;
>>=20
>> Fix the problem by check in_serv_queue =3D=3D bfqd->in_service_queue, =
to=20
>> get the value of idle_timer_disabled if in_serve_queue is equel to=20
>> bfqd->in_service_queue. If the space of in_serv_queue pointing has=20
>> been released, this judge will aviod use-after-free problem.
>> And if in_serv_queue may be expired but it still exists, this judge=20=

>> may have little effects on the function bfqg_stats_update_idle_time =
in=20
>> bfq_update_dispatch_stats.
>>=20
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Zhang Wensheng <zhangwensheng5@huawei.com>
>> ---
>> block/bfq-iosched.c | 9 +++++----
>> 1 file changed, 5 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c index=20
>> fec18118dc30..97533634b99e 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -5061,7 +5061,7 @@ static struct request =
*bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
>> 	struct bfq_data *bfqd =3D hctx->queue->elevator->elevator_data;
>> 	struct request *rq;
>> 	struct bfq_queue *in_serv_queue;
>> -	bool waiting_rq, idle_timer_disabled;
>> +	bool waiting_rq, idle_timer_disabled =3D false;
>>=20
>> 	spin_lock_irq(&bfqd->lock);
>>=20
>> @@ -5070,9 +5070,10 @@ static struct request=20
>> *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
>>=20
>> 	rq =3D __bfq_dispatch_request(hctx);
>>=20
>> -	idle_timer_disabled =3D
>> -		waiting_rq && !bfq_bfqq_wait_request(in_serv_queue);
>> -
>> +	if (in_serv_queue =3D=3D bfqd->in_service_queue) {
>> +		idle_timer_disabled =3D
>> +			waiting_rq && =
!bfq_bfqq_wait_request(in_serv_queue);
>> +	}
>=20
> Good catch!
>=20
>> 	spin_unlock_irq(&bfqd->lock);
>>=20
>> 	bfq_update_dispatch_stats(hctx->queue, rq, in_serv_queue,
>=20
> Yet, what about the above use of in_serv_queue then?
>=20
> Thanks,
> Paolo
>=20
>> --
>> 2.31.1
>>=20
>=20

