Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8678B567E4C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 08:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiGFGVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 02:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiGFGVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 02:21:24 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4646B15710
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 23:21:23 -0700 (PDT)
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2666LLBA006352;
        Wed, 6 Jul 2022 15:21:21 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Wed, 06 Jul 2022 15:21:21 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2666LKZO006347
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 6 Jul 2022 15:21:21 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7ddb25ff-60e5-75be-8080-2a7465cca68c@I-love.SAKURA.ne.jp>
Date:   Wed, 6 Jul 2022 15:21:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] char: misc: make misc_open() and misc_register() killable
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
References: <000000000000d9ff3a05bb37069e@google.com>
 <72e74af9-f1b6-e383-a2c3-6ee8a0aea5e0@I-love.SAKURA.ne.jp>
 <YsKW6VvWqvcMRBSl@kroah.com>
 <100f445e-9fa8-4f37-76aa-8359f0008c59@I-love.SAKURA.ne.jp>
 <YsLIepAXeBKT0AF/@kroah.com>
 <01a93294-e323-b9ca-7e95-a33d4b89dc47@I-love.SAKURA.ne.jp>
 <YsL5pUuydMWJ9dSQ@kroah.com>
 <617f64e3-74c8-f98b-3430-bd476867e483@I-love.SAKURA.ne.jp>
 <5665ccb2-b92b-9e1f-8bb5-a950986450ec@I-love.SAKURA.ne.jp>
 <YsRHwy6+5gask+KT@kroah.com>
 <064bbe2a-c18e-203e-9e01-b32fe9baa390@I-love.SAKURA.ne.jp>
In-Reply-To: <064bbe2a-c18e-203e-9e01-b32fe9baa390@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/07/05 23:35, Tetsuo Handa wrote:
> On 2022/07/05 23:16, Greg KH wrote:
>> Some device is being probed at the moment, maybe we have a deadlock
>> somewhere here...
> 
> Lockdep says __device_attach() from hub_event() was in progress.
> 
> ----------------------------------------
> [  237.376478][   T28] 5 locks held by kworker/1:1/26:
> [  237.381526][   T28]  #0: ffff888016b92538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610
> [  237.392798][   T28]  #1: ffffc90000c2fda8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610
> [  237.406354][   T28]  #2: ffff88801f7ee220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4680
> [  237.415920][   T28]  #3: ffff88801b6c6220 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0
> [  237.426682][   T28]  #4: ffff8880216bc1a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0
> ----------------------------------------
> 

The number returned by atomic_read(&probe_count) matched the number of works for hub_event()
in usb_hub_wq workqueue. The probe function is called from hub_event(), and
usb_stor_msg_common() calls wait_for_completion_interruptible_timeout(MAX_SCHEDULE_TIMEOUT)
via driver's init function.

But if the usb device is unresponsive, wait_for_completion_interruptible_timeout() sleeps
forever. And in this testcase (which emulates usb devices using /dev/raw-gadget interface),
the usb device became unresponsive because the process who is responsible with reading/writing
/dev/raw-gadget interface is blocked at mutex_lock(&misc_mtx) at misc_open(), and results in
an AB-BA deadlock condition. Making misc_open() killable solved this problem, by allowing
the opener of /dev/raw-gadget interface to call fput() upon "send SIGKILL after 5 seconds from
fork()" behavior.

Anyway,

        /*
         * Resuming.  We may need to wait for the image device to
         * appear.
         */
        wait_for_device_probe();

in snapshot_open() will sleep forever if some device became unresponsive.

How should we fix this problem?



SysRq-t output (location is based on Linux 5.18.0):
----------------------------------------
[  113.988455][ T4455] Calling probe_count=2
[  115.002350][    C2] sysrq: Show State

[  124.602603][    C2] task:kworker/2:2     state:S stack:11608 pid:  980 ppid:     2 flags:0x00004000
[  124.613409][    C2] Workqueue: usb_hub_wq hub_event
[  124.618941][    C2] Call Trace:
[  124.624046][    C2]  <TASK>
[  124.629122][    C2]  __schedule+0x3b6/0x1690
[  124.634575][    C2]  ? _raw_spin_unlock_irq+0x1f/0x40
[  124.640085][    C2]  schedule+0x49/0xb0
[  124.645280][    C2]  schedule_timeout+0x134/0x180
[  124.650574][    C2]  ? _raw_spin_unlock_irq+0x1f/0x40
[  124.655880][    C2]  ? lockdep_hardirqs_on+0x79/0x100
[  124.662294][    C2]  __wait_for_common+0xac/0x1f0
[  124.667740][    C2]  ? usleep_range_state+0xe0/0xe0
[  124.673449][    C2]  usb_stor_msg_common+0x157/0x1f0           usb_stor_msg_common at drivers/usb/storage/transport.c:166 (discriminator 4)
[  124.679074][    C2]  ? verify_cpu+0xf0/0x100
[  124.684774][    C2]  usb_stor_ctrl_transfer+0xc3/0xf0          usb_stor_ctrl_transfer at drivers/usb/storage/transport.c:344
[  124.690387][    C2]  usb_stor_sddr09_dpcm_init+0x63/0x1a0      sddr09_send_command at drivers/usb/storage/sddr09.c:307
                                                                  (inlined by) usb_stor_sddr09_dpcm_init at drivers/usb/storage/sddr09.c:1455
[  124.696087][    C2]  ? sddr09_get_cardinfo+0x530/0x530
[  124.701654][    C2]  usb_stor_probe2+0x24f/0x470               usb_stor_acquire_resources at drivers/usb/storage/usb.c:788
                                                                  (inlined by) usb_stor_probe2 at drivers/usb/storage/usb.c:1050
[  124.707024][    C2]  ? sddr09_transport+0x1940/0x1940
[  124.712690][    C2]  sddr09_probe+0xd6/0x110
[  124.717980][    C2]  usb_probe_interface+0x19b/0x3e0
[  124.723533][    C2]  ? usb_match_dynamic_id+0xe0/0xe0
[  124.728900][    C2]  really_probe+0x138/0x4c0
[  124.734058][    C2]  __driver_probe_device+0x191/0x220
[  124.739406][    C2]  driver_probe_device+0x2a/0x120
[  124.744649][    C2]  __device_attach_driver+0x105/0x1a0
[  124.749981][    C2]  ? driver_allows_async_probing+0x90/0x90
[  124.755600][    C2]  bus_for_each_drv+0xba/0x100
[  124.761136][    C2]  __device_attach+0x130/0x290
[  124.766408][    C2]  bus_probe_device+0xdb/0xf0
[  124.771735][    C2]  device_add+0x635/0xdf0
[  124.776770][    C2]  ? __mutex_unlock_slowpath+0x37/0x280
[  124.782189][    C2]  usb_set_configuration+0x9ca/0xd10
[  124.787516][    C2]  usb_generic_driver_probe+0x8c/0xc0
[  124.792906][    C2]  usb_probe_device+0x6c/0x180
[  124.798041][    C2]  ? usb_driver_release_interface+0xc0/0xc0
[  124.803416][    C2]  really_probe+0x138/0x4c0
[  124.808329][    C2]  __driver_probe_device+0x191/0x220
[  124.813373][    C2]  driver_probe_device+0x2a/0x120
[  124.818345][    C2]  __device_attach_driver+0x105/0x1a0
[  124.823436][    C2]  ? driver_allows_async_probing+0x90/0x90
[  124.828730][    C2]  bus_for_each_drv+0xba/0x100
[  124.834151][    C2]  __device_attach+0x130/0x290
[  124.840066][    C2]  bus_probe_device+0xdb/0xf0
[  124.845475][    C2]  device_add+0x635/0xdf0
[  124.850835][    C2]  usb_new_device.cold+0x110/0x5e9
[  124.856251][    C2]  hub_event+0x177c/0x26b0
[  124.861609][    C2]  process_one_work+0x3d4/0x9c0
[  124.866730][    C2]  worker_thread+0x5b/0x5d0
[  124.874165][    C2]  ? process_one_work+0x9c0/0x9c0
[  124.879966][    C2]  kthread+0x135/0x170
[  124.884870][    C2]  ? kthread_complete_and_exit+0x30/0x30
[  124.890628][    C2]  ret_from_fork+0x1f/0x30
[  124.896103][    C2]  </TASK>

[  143.975320][    C2] Showing all locks held in the system:
[  143.985599][    C2] 5 locks held by kworker/2:2/980:
[  143.991149][    C2]  #0: ffff88800d615938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x304/0x9c0
[  144.002742][    C2]  #1: ffffc90003ed3e70 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x304/0x9c0
[  144.015128][    C2]  #2: ffff88800fe66a20 (&dev->mutex){....}-{3:3}, at: hub_event+0xc4/0x26b0
[  144.022646][    C2]  #3: ffff88810e445a20 (&dev->mutex){....}-{3:3}, at: __device_attach+0x41/0x290
[  144.032770][    C2]  #4: ffff88810e4449a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x41/0x290
[  144.045877][    C2] 1 lock held by in:imklog/3844:
[  144.052399][    C2]  #0: ffff888106694ee8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x8d/0xa0
[  144.060131][    C2] 1 lock held by a.out/4425:
[  144.066811][    C2]  #0: ffffffff86863848 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x25/0x1e0
[  144.074587][    C2] 3 locks held by systemd-udevd/4439:
[  144.081494][    C2]  #0: ffff8880140bc688 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_read_iter+0x9d/0x2e0
[  144.095133][    C2]  #1: ffff88810ba50938 (kn->active#60){++++}-{0:0}, at: kernfs_fop_read_iter+0xa5/0x2e0
[  144.109502][    C2]  #2: ffff88810e445a20 (&dev->mutex){....}-{3:3}, at: read_descriptors+0x3c/0x1e0
[  144.123733][    C2] 2 locks held by a.out/4455:
[  144.131152][    C2]  #0: ffffffff86863848 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x25/0x1e0
[  144.139727][    C2]  #1: ffffffff8652d068 (system_transition_mutex){+.+.}-{3:3}, at: snapshot_open+0x40/0x160
[  144.154965][    C2] 1 lock held by a.out/4456:
[  144.162582][    C2]  #0: ffffffff86863848 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x25/0x1e0
[  144.171374][    C2] 1 lock held by a.out/4457:
[  144.179220][    C2]  #0: ffffffff86863848 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x25/0x1e0
[  144.188231][    C2] 1 lock held by a.out/4458:
[  144.196069][    C2]  #0: ffffffff86863848 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x25/0x1e0
[  144.204946][    C2] 1 lock held by a.out/4459:
[  144.214175][    C2]  #0: ffffffff86863848 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x25/0x1e0

[  144.246256][    C2] Showing busy workqueues and worker pools:
[  144.254448][    C2] workqueue usb_hub_wq: flags=0x4
[  144.262458][    C2]   pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=2/256 refcnt=3
[  144.262554][    C2]     in-flight: 980:hub_event hub_event
[  144.262743][    C2] pool 4: cpus=2 node=0 flags=0x0 nice=0 hung=29s workers=4 idle: 28 3084 53
[  144.290063][ T4455] Calling probe_count=2
----------------------------------------

