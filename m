Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139774CE514
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 14:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiCENwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 08:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiCENwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 08:52:14 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5901B0D36
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 05:51:23 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d17so1129136pfv.6
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 05:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=Xla4eqjNJ9GQHedmyVM3mQSTbX9I2hKxNtWlRG/DFqo=;
        b=vdyH0tEbArXiqM4iHAGSAbBnLqhkDuvHRzVsP5cnE+1m/fOQ+x625HGslnhARFvE1R
         0lS0KkMAB99i0nQBOKCNbD0TREbxIyUjEcTBTg/ocuC2zcVIHkm4rcBi1kO2pVjkzquI
         yGTWpF+4wxpib7DGSTDpJRsaXodZ5wPk7v32F1A3A2y+KQKSTc41tfPxG8Nltz5nX1xM
         wKEOLjWE+GWSduNhMCiRcZcYMNmsPBq15XFEzu9ckkeaQkDxsquc+NXGPZPsBUombatc
         BATSYo/Ix/ephSBHGWFRix5b6UDEBZV0oGPahilVHfv8DZfXHfXI61L9rW2FY31nvsPE
         QqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=Xla4eqjNJ9GQHedmyVM3mQSTbX9I2hKxNtWlRG/DFqo=;
        b=ybi5As5Qw1R+RUviWpeTF2XhDkAbhxdUA0Wl0RLPdbDtlslYDqG82REcPe8I+7hcAU
         9OPocMmt/Sl8WFGWyMfr/EXwrn4EonfGzlS32PDhn2DUZlgSCfY5AsGvJFNDKUQJk64z
         R/qdnXiQkOalUhT/M8h2tGZ83mTlAwofp2DN/R8feRc0FAKEECufuaKWXPnB7S1GBWD4
         gH1xfwLsWd77nYLj6Z9Zw1G8Thz9WYZrpq/uPUT1cXQFe8Fnq3yasC9P4EgFaPUX9TBD
         7Dab1nci7FOGW1NSptvqeIOaWs7emylGTryiCtZrlfEId+KzbvUfRUaAxxBMBGH6OXsa
         Ab2w==
X-Gm-Message-State: AOAM5321rRXypZMUUd6M9IV5aEFOIRpnHYFxYUrpWj5KBULmGcchII+3
        kdPEHAc0fhG2xcZpuMoVrJSm6jFcUFeByw==
X-Google-Smtp-Source: ABdhPJxM9QknaSYX/AMoScy78NrwgjAWfT1oesEuJSI8gneLt0ZgJtAcJEXg+tT1wcpjphPIhKyVsg==
X-Received: by 2002:a05:6a00:124f:b0:4c0:6242:c14e with SMTP id u15-20020a056a00124f00b004c06242c14emr3747568pfi.83.1646488282605;
        Sat, 05 Mar 2022 05:51:22 -0800 (PST)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e18-20020a056a001a9200b004bc82d0e125sm9447229pfv.119.2022.03.05.05.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 05:51:22 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     paolo.valente@linaro.org,
        Zhang Wensheng <zhangwensheng5@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com
In-Reply-To: <20220303070334.3020168-1-zhangwensheng5@huawei.com>
References: <20220303070334.3020168-1-zhangwensheng5@huawei.com>
Subject: Re: [PATCH -next v4] bfq: fix use-after-free in bfq_dispatch_request
Message-Id: <164648828123.4413.9071667484846165485.b4-ty@kernel.dk>
Date:   Sat, 05 Mar 2022 06:51:21 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2022 15:03:34 +0800, Zhang Wensheng wrote:
> KASAN reports a use-after-free report when doing normal scsi-mq test
> 
> [69832.239032] ==================================================================
> [69832.241810] BUG: KASAN: use-after-free in bfq_dispatch_request+0x1045/0x44b0
> [69832.243267] Read of size 8 at addr ffff88802622ba88 by task kworker/3:1H/155
> [69832.244656]
> [69832.245007] CPU: 3 PID: 155 Comm: kworker/3:1H Not tainted 5.10.0-10295-g576c6382529e #8
> [69832.246626] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
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
> [69832.338297] The buggy address belongs to the object at ffff88802622b968
> [69832.338297]  which belongs to the cache bfq_queue of size 512
> [69832.340766] The buggy address is located 288 bytes inside of
> [69832.340766]  512-byte region [ffff88802622b968, ffff88802622bb68)
> [69832.343091] The buggy address belongs to the page:
> [69832.344097] page:ffffea0000988a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88802622a528 pfn:0x26228
> [69832.346214] head:ffffea0000988a00 order:2 compound_mapcount:0 compound_pincount:0
> [69832.347719] flags: 0x1fffff80010200(slab|head)
> [69832.348625] raw: 001fffff80010200 ffffea0000dbac08 ffff888017a57650 ffff8880179fe840
> [69832.354972] raw: ffff88802622a528 0000000000120008 00000001ffffffff 0000000000000000
> [69832.356547] page dumped because: kasan: bad access detected
> [69832.357652]
> [69832.357970] Memory state around the buggy address:
> [69832.358926]  ffff88802622b980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [69832.360358]  ffff88802622ba00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [69832.361810] >ffff88802622ba80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [69832.363273]                       ^
> [69832.363975]  ffff88802622bb00: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
> [69832.375960]  ffff88802622bb80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [69832.377405] ==================================================================
> 
> [...]

Applied, thanks!

[1/1] bfq: fix use-after-free in bfq_dispatch_request
      commit: ab552fcb17cc9e4afe0e4ac4df95fc7b30e8490a

Best regards,
-- 
Jens Axboe


