Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2D14D15C1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346269AbiCHLKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346270AbiCHLKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:10:06 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABAA3D1EE;
        Tue,  8 Mar 2022 03:09:10 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id s18so3517037plp.1;
        Tue, 08 Mar 2022 03:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=861/rT/721223FdWsOC3qzYE3WVOjLIz8rVv6kjIKGM=;
        b=jyYyK6J9BxbgoL7xHG6kp1cXmUakeGS7Y5anj1UsF8NTj2w3t4YAHIKWxraw96YWdj
         WcAP7cZKBuwMV0rcBF+/VhLf7tJjM/qVr9wc9dlAUmZqjmydxsYJAuQFBwy0eJ0TmCL6
         zLr5uJ/qULcYFbct0VPQyFfDTjEhQLcm7sC9eXdKg7KreOtXT0XxPZZNxs1ZWEjvTSn6
         k+WbyR4XQCNu7vP5w1o5XHyAjaEfoKTd/vcMswpr5tQ6/tbg0wmLlnn7jTOmuQSPNPSG
         vgD9ghLVWvFuGdP1dvNWZZx4ooL5SrriekGODCSLlZ5K0qt7HumBqnZBthc6v9phnTrx
         oFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=861/rT/721223FdWsOC3qzYE3WVOjLIz8rVv6kjIKGM=;
        b=MKWCLxxjakK22gRPbwz62QuBlL1477qW+YP2a9dZj/WNw0I1P2aDB69cmpjVqVgkMx
         6mpczYYD6fBy4/DSK1e1Jn6A3FNQ/Dgt/z1+vzN5g7MIswduInGVLZ3HlLmaSbabbYLR
         2SJWWzJSGNie6LCqBypVO0XdJnDMVHoyB+QoNnVsiVMtt2K7pdh9s+yRMj57UU4LUweg
         CSXXTh6ec7j5LZn3FDvZZiHzwu1yAlVuvvTu1pt+iZCZwQTT0K77ouvxkjfgJfdkjchx
         XB0b/ScD42Qd5hBnOrtTwf/NDCrV2Myd0n0yN4sm0rmsanokTfEadHZ+HZLtoNpIdqsz
         L5aA==
X-Gm-Message-State: AOAM531ofgooCySEx69GfzRrYloFRkUmxG422qEpOhDBbERhjWIzyNK8
        PhNlT2a3xIUQXfZgXfFlpcEGHkkiwLq8zxf1iBJPyVWLyuIh
X-Google-Smtp-Source: ABdhPJzlfDhGKO539ONlOCeBGpj4DbgxjtgkvFGeLe9x9+NjVl6/db66OmTiRXhCyRo0aQE4cmoa47jeKJljHnPFEnY=
X-Received: by 2002:a17:90a:5407:b0:1bf:43ce:f11b with SMTP id
 z7-20020a17090a540700b001bf43cef11bmr3984060pjh.31.1646737749940; Tue, 08 Mar
 2022 03:09:09 -0800 (PST)
MIME-Version: 1.0
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Tue, 8 Mar 2022 19:08:58 +0800
Message-ID: <CAMhUBj=i4MJ6KH_UU5dy8e+DmviRg4EFA-D5zyD=XfRi9Ma=pg@mail.gmail.com>
Subject: [BUG] block: sx8: Invalid wait context in carm_queue_rq()
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found a bug in the sx8 driver when probing this driver.
I have no idea about how this happened, it seems like a misuse of the lock.

With LOCKDEP=y, the following log can reveal it:

[    3.403123] =============================
[    3.403205] [ BUG: Invalid wait context ]
[    3.403205] 5.16.0-rc1+ #29 Not tainted
[    3.403205] -----------------------------
[    3.403205] kworker/5:1/68 is trying to lock:
[    3.403205] ffff888012c80060 (&entry->access){+.+.}-{3:3}, at:
carm_queue_rq+0x110/0x1290
[    3.403205] other info that might help us debug this:
[    3.403205] context-{4:4}
[    3.403205] 3 locks held by kworker/5:1/68:
[    3.403205]  #0: ffff888100068d38
((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x644/0xaf0
[    3.403205]  #1: ffff888105f17d68
((work_completion)(&host->fsm_task)){+.+.}-{0:0}, at:
process_one_work+0x68c/0xaf0
[    3.403205]  #2: ffffffff8e441b60 (rcu_read_lock){....}-{1:2}, at:
rcu_lock_acquire+0x0/0x20
[    3.403205] stack backtrace:
[    3.403205] CPU: 5 PID: 68 Comm: kworker/5:1 Not tainted 5.16.0-rc1+ #29
[    3.403205] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
[    3.403205] Workqueue: events carm_fsm_task
[    3.403205] Call Trace:
[    3.403205]  <TASK>
[    3.403205]  dump_stack_lvl+0x5d/0x78
[    3.403205]  __lock_acquire+0x144a/0x1e20
[    3.403205]  lock_acquire+0x101/0x2d0
[    3.403205]  ? carm_queue_rq+0x110/0x1290
[    3.403205]  _raw_spin_lock+0x2a/0x40
[    3.403205]  ? carm_queue_rq+0x110/0x1290
[    3.403205]  carm_queue_rq+0x110/0x1290
[    3.403205]  ? __blk_mq_get_driver_tag+0x2da/0x780
[    3.403205]  blk_mq_dispatch_rq_list+0xcd0/0x24f0
[    3.403205]  ? rcu_read_lock_sched_held+0x2f/0x70
[    3.403205]  ? lock_release+0x47e/0x720
[    3.403205]  __blk_mq_sched_dispatch_requests+0x2f8/0x3a0
[    3.403205]  blk_mq_sched_dispatch_requests+0xc1/0xf0
[    3.403205]  __blk_mq_run_hw_queue+0x86/0xe0
[    3.403205]  __blk_mq_delay_run_hw_queue+0x1b3/0x490
[    3.403205]  ? rcu_lock_acquire+0x20/0x20
[    3.403205]  blk_mq_run_hw_queue+0x137/0x300
[    3.403205]  blk_mq_sched_insert_request+0x13e/0x2c0
[    3.403205]  process_one_work+0x6d8/0xaf0
[    3.403205]  worker_thread+0x9bd/0x14a0
[    3.403205]  kthread+0x38b/0x470
[    3.403205]  ? rcu_lock_release+0x20/0x20
[    3.403205]  ? kthread_unuse_mm+0x170/0x170
[    3.403205]  ret_from_fork+0x22/0x30
[    3.403205]  </TASK>

Regards,
Zheyu Ma
