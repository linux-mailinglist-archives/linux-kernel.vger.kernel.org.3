Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC045599B5D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348886AbiHSMCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347622AbiHSMCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:02:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAD1100949
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660910524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bs/RGqRU1P8HkB78nxVTIBhoGgYEyiHtrF13FSc69Hk=;
        b=a7bjDp/FvqQxfpvo0H+8hd+Mj7MJI0P2RS+NmhQS3RohjEd8lz0ZKwGj+rpjZWy/YsIR7L
        3AxeuXblhA7sK5OS9jcrrzH5FcMoHr9mGntPl5v2uU2xbPFJF+d1Kc36UtLP7aSnDdCTlD
        zPZjxyPJouoRaWt2KMeP3ItJkWS+Q0A=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-658-JROjN_ykO1O58jIiC97YDA-1; Fri, 19 Aug 2022 08:02:03 -0400
X-MC-Unique: JROjN_ykO1O58jIiC97YDA-1
Received: by mail-ed1-f70.google.com with SMTP id q18-20020a056402519200b0043dd2ff50feso2693549edd.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=bs/RGqRU1P8HkB78nxVTIBhoGgYEyiHtrF13FSc69Hk=;
        b=NhW4R3S1yryoraUdZBnXQboTO9JVPDqPvgzKlId0+bjUuKsxy7dlWQfh00QIt4kRJO
         NIFCx+Y8Ijq5vbJSWSKz5Qs8gf7GFrlo2E1KICv9bcpyxz3UFh8rvNvbVwJcCEIVMOET
         2xMv2vykgNJziK8zsmNsaDXYSBSW10PfI5sO9mwCYTiSiGuECPjf9wUFcL9ueX6KSx5O
         aXLAie9knU8hnA1RKGnGTw9J+eXpoxvbMKm4iPYMrPiO8GzzSYE7gpysoEEIYMjCYjMa
         PZ0onq1H+KX43f/xyG7+9Ch3aJQrbPHxXfAyIEcpYwLThi27Bz9dTY2q8dOgLsuC3RMZ
         6s3Q==
X-Gm-Message-State: ACgBeo0OBQWo1C9WPw1pD0DZsDAO2MbtNlegHxIwt69kx3Wsc8vUvfnx
        cKIMc1WvN9GPTZAIhD6jW5F5WxJYVJhE5zpbDUr9UqbG1r3ezvk/BDKgZDzFEmQ8MDcHncs3DbY
        NWWGrvkN05MWIXOeGffA+Lu2ULkRIUqrY+oKEDOqaRR7uPKVYYm9sWZSkG4eGNv8ZmMivWSDmSM
        dW
X-Received: by 2002:a17:907:971e:b0:731:48b3:6fb7 with SMTP id jg30-20020a170907971e00b0073148b36fb7mr4765782ejc.267.1660910521374;
        Fri, 19 Aug 2022 05:02:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6Pq8KNfXUN3mOCREv9GJPMPra98QkIxCNGeAc7ZItf05+a7IlqY0LV4NcjgNnV7YHGHMdRbg==
X-Received: by 2002:a17:907:971e:b0:731:48b3:6fb7 with SMTP id jg30-20020a170907971e00b0073148b36fb7mr4765735ejc.267.1660910520400;
        Fri, 19 Aug 2022 05:02:00 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id q19-20020a17090676d300b0072af930cf97sm2190734ejn.115.2022.08.19.05.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 05:01:59 -0700 (PDT)
Message-ID: <dd6844e7-f338-a4e9-2dad-0960e25b2ca1@redhat.com>
Date:   Fri, 19 Aug 2022 14:01:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Jens Axboe <axboe@kernel.dk>
From:   Hans de Goede <hdegoede@redhat.com>
Subject: 6.0-rc1 regression block (blk_mq) / RCU task stuck errors + block-io
 hang
Cc:     linux-block@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I've been dogfooding 6.0-rc1 on my main workstation and I have hit
this pretty serious bug, serious enough for me to go back to 5.19

My dmesg is showing various blk_mq (RCU?) related lockdep splats
followed by some tasks getting stuck on disk-IO. E.g. "sync"
is guaranteed to hang, but other tasks too.

This seems to be mainly the case on "sd" disks (both sata
and USB) where as my main nvme drive seems fine, which has
probably saved me from worse issues...

Here are 4 task stuck reports from my last boot, where
I had to turn off the machine by keeping the power button
pressed for 4 seconds.

Aug 19 12:25:46 shalem kernel: INFO: task kworker/0:3:305 blocked for more than 122 seconds.
Aug 19 12:25:46 shalem kernel:       Tainted: G        W  OE     -------  ---  6.0.0-0.rc1.20220817git3cc40a443a04.14.fc38.x86_64 #1
Aug 19 12:25:46 shalem kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 19 12:25:46 shalem kernel: task:kworker/0:3     state:D stack:13008 pid:  305 ppid:     2 flags:0x00004000
Aug 19 12:25:46 shalem kernel: Workqueue: events ata_scsi_dev_rescan
Aug 19 12:25:46 shalem kernel: Call Trace:
Aug 19 12:25:46 shalem kernel:  <TASK>
Aug 19 12:25:46 shalem kernel:  __schedule+0x47f/0x16d0
Aug 19 12:25:46 shalem kernel:  ? mark_held_locks+0x50/0x80
Aug 19 12:25:46 shalem kernel:  ? _raw_spin_unlock_irq+0x24/0x50
Aug 19 12:25:46 shalem kernel:  schedule+0x5d/0xe0
Aug 19 12:25:46 shalem kernel:  blk_mq_freeze_queue_wait+0x57/0x90
Aug 19 12:25:46 shalem kernel:  ? prepare_to_wait_exclusive+0xd0/0xd0
Aug 19 12:25:46 shalem kernel:  disk_clear_zone_settings+0x19/0xa0
Aug 19 12:25:46 shalem kernel:  sd_revalidate_disk.isra.0+0x1660/0x2c60
Aug 19 12:25:46 shalem kernel:  ? slab_free_freelist_hook.constprop.0+0x11b/0x160
Aug 19 12:25:46 shalem kernel:  ? scsi_rescan_device+0x2c/0x90
Aug 19 12:25:46 shalem kernel:  scsi_rescan_device+0x77/0x90
Aug 19 12:25:46 shalem kernel:  ata_scsi_dev_rescan+0x9d/0x110
Aug 19 12:25:46 shalem kernel:  process_one_work+0x2a0/0x600
Aug 19 12:25:46 shalem kernel:  worker_thread+0x4f/0x3a0
Aug 19 12:25:46 shalem kernel:  ? process_one_work+0x600/0x600
Aug 19 12:25:46 shalem kernel:  kthread+0xf5/0x120
Aug 19 12:25:46 shalem kernel:  ? kthread_complete_and_exit+0x20/0x20
Aug 19 12:25:46 shalem kernel:  ret_from_fork+0x22/0x30
Aug 19 12:25:46 shalem kernel:  </TASK>
Aug 19 12:25:46 shalem kernel: INFO: task smartd:2557 blocked for more than 122 seconds.
Aug 19 12:25:46 shalem kernel:       Tainted: G        W  OE     -------  ---  6.0.0-0.rc1.20220817git3cc40a443a04.14.fc38.x86_64 #1
Aug 19 12:25:46 shalem kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 19 12:25:46 shalem kernel: task:smartd          state:D stack:13000 pid: 2557 ppid:     1 flags:0x00000002
Aug 19 12:25:46 shalem kernel: Call Trace:
Aug 19 12:25:46 shalem kernel:  <TASK>
Aug 19 12:25:46 shalem kernel:  __schedule+0x47f/0x16d0
Aug 19 12:25:46 shalem kernel:  ? lock_release+0x14f/0x460
Aug 19 12:25:46 shalem kernel:  ? _raw_spin_unlock_irqrestore+0x30/0x60
Aug 19 12:25:46 shalem kernel:  ? _raw_spin_unlock_irqrestore+0x40/0x60
Aug 19 12:25:46 shalem kernel:  schedule+0x5d/0xe0
Aug 19 12:25:46 shalem kernel:  blk_queue_enter+0xe5/0x190
Aug 19 12:25:46 shalem kernel:  ? prepare_to_wait_exclusive+0xd0/0xd0
Aug 19 12:25:46 shalem kernel:  blk_mq_alloc_request+0x50/0xb0
Aug 19 12:25:46 shalem kernel:  scsi_alloc_request+0xb/0x30
Aug 19 12:25:46 shalem kernel:  sg_io+0x6b/0x390
Aug 19 12:25:46 shalem kernel:  ? _copy_from_user+0x83/0xa0
Aug 19 12:25:46 shalem kernel:  ? get_sg_io_hdr+0x26/0xb0
Aug 19 12:25:46 shalem kernel:  scsi_ioctl+0x44c/0x960
Aug 19 12:25:46 shalem kernel:  ? scsi_ioctl_block_when_processing_errors+0x45/0x50
Aug 19 12:25:46 shalem kernel:  blkdev_ioctl+0x143/0x2c0
Aug 19 12:25:46 shalem kernel:  __x64_sys_ioctl+0x90/0xd0
Aug 19 12:25:46 shalem kernel:  do_syscall_64+0x5b/0x80
Aug 19 12:25:46 shalem kernel:  ? do_syscall_64+0x67/0x80
Aug 19 12:25:46 shalem kernel:  ? do_syscall_64+0x67/0x80
Aug 19 12:25:46 shalem kernel:  ? do_syscall_64+0x67/0x80
Aug 19 12:25:46 shalem kernel:  ? lockdep_hardirqs_on+0x7d/0x100
Aug 19 12:25:46 shalem kernel:  entry_SYSCALL_64_after_hwframe+0x63/0xcd
Aug 19 12:25:46 shalem kernel: RIP: 0033:0x7f9641245cdf
Aug 19 12:25:46 shalem kernel: RSP: 002b:00007ffc73d257d0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Aug 19 12:25:46 shalem kernel: RAX: ffffffffffffffda RBX: 00007ffc73d25ad0 RCX: 00007f9641245cdf
Aug 19 12:25:46 shalem kernel: RDX: 00007ffc73d25840 RSI: 0000000000002285 RDI: 0000000000000003
Aug 19 12:25:46 shalem kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
Aug 19 12:25:46 shalem kernel: R10: 000000000000003c R11: 0000000000000246 R12: 00007ffc73d25c50
Aug 19 12:25:46 shalem kernel: R13: 0000000000000001 R14: 0000000000000000 R15: 000055fbff0abd10
Aug 19 12:25:46 shalem kernel:  </TASK>
Aug 19 12:25:46 shalem kernel: INFO: task pool-udisksd:9404 blocked for more than 122 seconds.
Aug 19 12:25:46 shalem kernel:       Tainted: G        W  OE     -------  ---  6.0.0-0.rc1.20220817git3cc40a443a04.14.fc38.x86_64 #1
Aug 19 12:25:46 shalem kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 19 12:25:46 shalem kernel: task:pool-udisksd    state:D stack:14624 pid: 9404 ppid:     1 flags:0x00000002
Aug 19 12:25:46 shalem kernel: Call Trace:
Aug 19 12:25:46 shalem kernel:  <TASK>
Aug 19 12:25:46 shalem kernel:  __schedule+0x47f/0x16d0
Aug 19 12:25:46 shalem kernel:  ? lock_release+0x14f/0x460
Aug 19 12:25:46 shalem kernel:  ? _raw_spin_unlock_irqrestore+0x30/0x60
Aug 19 12:25:46 shalem kernel:  ? _raw_spin_unlock_irqrestore+0x40/0x60
Aug 19 12:25:46 shalem kernel:  schedule+0x5d/0xe0
Aug 19 12:25:46 shalem kernel:  blk_queue_enter+0xe5/0x190
Aug 19 12:25:46 shalem kernel:  ? prepare_to_wait_exclusive+0xd0/0xd0
Aug 19 12:25:46 shalem kernel:  blk_mq_alloc_request+0x50/0xb0
Aug 19 12:25:46 shalem kernel:  scsi_alloc_request+0xb/0x30
Aug 19 12:25:46 shalem kernel:  sg_io+0x6b/0x390
Aug 19 12:25:46 shalem kernel:  ? _copy_from_user+0x83/0xa0
Aug 19 12:25:46 shalem kernel:  ? get_sg_io_hdr+0x26/0xb0
Aug 19 12:25:46 shalem kernel:  scsi_ioctl+0x44c/0x960
Aug 19 12:25:46 shalem kernel:  ? scsi_ioctl_block_when_processing_errors+0x45/0x50
Aug 19 12:25:46 shalem kernel:  blkdev_ioctl+0x143/0x2c0
Aug 19 12:25:46 shalem kernel:  __x64_sys_ioctl+0x90/0xd0
Aug 19 12:25:46 shalem kernel:  do_syscall_64+0x5b/0x80
Aug 19 12:25:46 shalem kernel:  ? do_syscall_64+0x67/0x80
Aug 19 12:25:46 shalem kernel:  ? lockdep_hardirqs_on+0x7d/0x100
Aug 19 12:25:46 shalem kernel:  ? do_syscall_64+0x67/0x80
Aug 19 12:25:46 shalem kernel:  ? ret_from_fork+0x15/0x30
Aug 19 12:25:46 shalem kernel:  ? lockdep_hardirqs_on+0x7d/0x100
Aug 19 12:25:46 shalem kernel:  entry_SYSCALL_64_after_hwframe+0x63/0xcd
Aug 19 12:25:46 shalem kernel: RIP: 0033:0x7f0c77065cdf
Aug 19 12:25:46 shalem kernel: RSP: 002b:00007f0c75dfd7f0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Aug 19 12:25:46 shalem kernel: RAX: ffffffffffffffda RBX: 00007f0c75dfda00 RCX: 00007f0c77065cdf
Aug 19 12:25:46 shalem kernel: RDX: 00007f0c75dfd860 RSI: 0000000000002285 RDI: 0000000000000011
Aug 19 12:25:46 shalem kernel: RBP: 0000000000001388 R08: 00007f0c75dfd9e0 R09: 00007f0c75dfe550
Aug 19 12:25:46 shalem kernel: R10: 00007f0c75dfd960 R11: 0000000000000246 R12: 00007f0c75dfdb70
Aug 19 12:25:46 shalem kernel: R13: 0000000000000000 R14: 0000000000000011 R15: 00007f0c75dfd9e0
Aug 19 12:25:46 shalem kernel:  </TASK>
Aug 19 12:25:46 shalem kernel: 
                               Showing all locks held in the system:
Aug 19 12:25:46 shalem kernel: 1 lock held by rcu_tasks_kthre/11:
Aug 19 12:25:46 shalem kernel:  #0: ffffffff86168820 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2b/0x3e0
Aug 19 12:25:46 shalem kernel: 1 lock held by rcu_tasks_rude_/12:
Aug 19 12:25:46 shalem kernel:  #0: ffffffff86168560 (rcu_tasks_rude.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2b/0x3e0
Aug 19 12:25:46 shalem kernel: 1 lock held by rcu_tasks_trace/13:
Aug 19 12:25:46 shalem kernel:  #0: ffffffff86168260 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2b/0x3e0
Aug 19 12:25:46 shalem kernel: 1 lock held by khungtaskd/100:
Aug 19 12:25:46 shalem kernel:  #0: ffffffff86169320 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x15/0x16b
Aug 19 12:25:46 shalem kernel: 4 locks held by kworker/0:3/305:
Aug 19 12:25:46 shalem kernel:  #0: ffff8ac180051748 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x20b/0x600
Aug 19 12:25:46 shalem kernel:  #1: ffffa78dc4007e78 ((work_completion)(&ap->scsi_rescan_task)){+.+.}-{0:0}, at: process_one_work+0x20b/0x600
Aug 19 12:25:46 shalem kernel:  #2: ffff8ac18ba840a8 (&ap->scsi_scan_mutex){+.+.}-{3:3}, at: ata_scsi_dev_rescan+0x32/0x110
Aug 19 12:25:46 shalem kernel:  #3: ffff8ac1909b5390 (&dev->mutex){....}-{3:3}, at: scsi_rescan_device+0x24/0x90
Aug 19 12:25:46 shalem kernel: 1 lock held by LCDd/2542:
Aug 19 12:25:46 shalem kernel:  #0: ffffffff8635a578 (minors_rwsem){++++}-{3:3}, at: hidraw_write+0x1e/0x50
Aug 19 12:25:46 shalem kernel: 
Aug 19 12:25:46 shalem kernel: =============================================


Aug 19 12:27:49 shalem kernel: INFO: task kworker/0:3:305 blocked for more than 245 seconds.
Aug 19 12:27:49 shalem kernel:       Tainted: G        W  OE     -------  ---  6.0.0-0.rc1.20220817git3cc40a443a04.14.fc38.x86_64 #1
Aug 19 12:27:49 shalem kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 19 12:27:49 shalem kernel: task:kworker/0:3     state:D stack:13008 pid:  305 ppid:     2 flags:0x00004000
Aug 19 12:27:49 shalem kernel: Workqueue: events ata_scsi_dev_rescan
Aug 19 12:27:49 shalem kernel: Call Trace:
Aug 19 12:27:49 shalem kernel:  <TASK>
Aug 19 12:27:49 shalem kernel:  __schedule+0x47f/0x16d0
Aug 19 12:27:49 shalem kernel:  ? mark_held_locks+0x50/0x80
Aug 19 12:27:49 shalem kernel:  ? _raw_spin_unlock_irq+0x24/0x50
Aug 19 12:27:49 shalem kernel:  schedule+0x5d/0xe0
Aug 19 12:27:49 shalem kernel:  blk_mq_freeze_queue_wait+0x57/0x90
Aug 19 12:27:49 shalem kernel:  ? prepare_to_wait_exclusive+0xd0/0xd0
Aug 19 12:27:49 shalem kernel:  disk_clear_zone_settings+0x19/0xa0
Aug 19 12:27:49 shalem kernel:  sd_revalidate_disk.isra.0+0x1660/0x2c60
Aug 19 12:27:49 shalem kernel:  ? slab_free_freelist_hook.constprop.0+0x11b/0x160
Aug 19 12:27:49 shalem kernel:  ? scsi_rescan_device+0x2c/0x90
Aug 19 12:27:49 shalem kernel:  scsi_rescan_device+0x77/0x90
Aug 19 12:27:49 shalem kernel:  ata_scsi_dev_rescan+0x9d/0x110
Aug 19 12:27:49 shalem kernel:  process_one_work+0x2a0/0x600
Aug 19 12:27:49 shalem kernel:  worker_thread+0x4f/0x3a0
Aug 19 12:27:49 shalem kernel:  ? process_one_work+0x600/0x600
Aug 19 12:27:49 shalem kernel:  kthread+0xf5/0x120
Aug 19 12:27:49 shalem kernel:  ? kthread_complete_and_exit+0x20/0x20
Aug 19 12:27:49 shalem kernel:  ret_from_fork+0x22/0x30
Aug 19 12:27:49 shalem kernel:  </TASK>
Aug 19 12:27:49 shalem kernel: INFO: task smartd:2557 blocked for more than 245 seconds.
Aug 19 12:27:49 shalem kernel:       Tainted: G        W  OE     -------  ---  6.0.0-0.rc1.20220817git3cc40a443a04.14.fc38.x86_64 #1
Aug 19 12:27:49 shalem kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 19 12:27:49 shalem kernel: task:smartd          state:D stack:13000 pid: 2557 ppid:     1 flags:0x00000002
Aug 19 12:27:49 shalem kernel: Call Trace:
Aug 19 12:27:49 shalem kernel:  <TASK>
Aug 19 12:27:49 shalem kernel:  __schedule+0x47f/0x16d0
Aug 19 12:27:49 shalem kernel:  ? lock_release+0x14f/0x460
Aug 19 12:27:49 shalem kernel:  ? _raw_spin_unlock_irqrestore+0x30/0x60
Aug 19 12:27:49 shalem kernel:  ? _raw_spin_unlock_irqrestore+0x40/0x60
Aug 19 12:27:49 shalem kernel:  schedule+0x5d/0xe0
Aug 19 12:27:49 shalem kernel:  blk_queue_enter+0xe5/0x190
Aug 19 12:27:49 shalem kernel:  ? prepare_to_wait_exclusive+0xd0/0xd0
Aug 19 12:27:49 shalem kernel:  blk_mq_alloc_request+0x50/0xb0
Aug 19 12:27:49 shalem kernel:  scsi_alloc_request+0xb/0x30
Aug 19 12:27:49 shalem kernel:  sg_io+0x6b/0x390
Aug 19 12:27:49 shalem kernel:  ? _copy_from_user+0x83/0xa0
Aug 19 12:27:49 shalem kernel:  ? get_sg_io_hdr+0x26/0xb0
Aug 19 12:27:49 shalem kernel:  scsi_ioctl+0x44c/0x960
Aug 19 12:27:49 shalem kernel:  ? scsi_ioctl_block_when_processing_errors+0x45/0x50
Aug 19 12:27:49 shalem kernel:  blkdev_ioctl+0x143/0x2c0
Aug 19 12:27:49 shalem kernel:  __x64_sys_ioctl+0x90/0xd0
Aug 19 12:27:49 shalem kernel:  do_syscall_64+0x5b/0x80
Aug 19 12:27:49 shalem kernel:  ? do_syscall_64+0x67/0x80
Aug 19 12:27:49 shalem kernel:  ? do_syscall_64+0x67/0x80
Aug 19 12:27:49 shalem kernel:  ? do_syscall_64+0x67/0x80
Aug 19 12:27:49 shalem kernel:  ? lockdep_hardirqs_on+0x7d/0x100
Aug 19 12:27:49 shalem kernel:  entry_SYSCALL_64_after_hwframe+0x63/0xcd
Aug 19 12:27:49 shalem kernel: RIP: 0033:0x7f9641245cdf
Aug 19 12:27:49 shalem kernel: RSP: 002b:00007ffc73d257d0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Aug 19 12:27:49 shalem kernel: RAX: ffffffffffffffda RBX: 00007ffc73d25ad0 RCX: 00007f9641245cdf
Aug 19 12:27:49 shalem kernel: RDX: 00007ffc73d25840 RSI: 0000000000002285 RDI: 0000000000000003
Aug 19 12:27:49 shalem kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
Aug 19 12:27:49 shalem kernel: R10: 000000000000003c R11: 0000000000000246 R12: 00007ffc73d25c50
Aug 19 12:27:49 shalem kernel: R13: 0000000000000001 R14: 0000000000000000 R15: 000055fbff0abd10
Aug 19 12:27:49 shalem kernel:  </TASK>
Aug 19 12:27:49 shalem kernel: INFO: task pool-udisksd:9404 blocked for more than 245 seconds.
Aug 19 12:27:49 shalem kernel:       Tainted: G        W  OE     -------  ---  6.0.0-0.rc1.20220817git3cc40a443a04.14.fc38.x86_64 #1
Aug 19 12:27:49 shalem kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 19 12:27:49 shalem kernel: task:pool-udisksd    state:D stack:14624 pid: 9404 ppid:     1 flags:0x00000002
Aug 19 12:27:49 shalem kernel: Call Trace:
Aug 19 12:27:49 shalem kernel:  <TASK>
Aug 19 12:27:49 shalem kernel:  __schedule+0x47f/0x16d0
Aug 19 12:27:49 shalem kernel:  ? lock_release+0x14f/0x460
Aug 19 12:27:49 shalem kernel:  ? _raw_spin_unlock_irqrestore+0x30/0x60
Aug 19 12:27:49 shalem kernel:  ? _raw_spin_unlock_irqrestore+0x40/0x60
Aug 19 12:27:49 shalem kernel:  schedule+0x5d/0xe0
Aug 19 12:27:49 shalem kernel:  blk_queue_enter+0xe5/0x190
Aug 19 12:27:49 shalem kernel:  ? prepare_to_wait_exclusive+0xd0/0xd0
Aug 19 12:27:49 shalem kernel:  blk_mq_alloc_request+0x50/0xb0
Aug 19 12:27:49 shalem kernel:  scsi_alloc_request+0xb/0x30
Aug 19 12:27:49 shalem kernel:  sg_io+0x6b/0x390
Aug 19 12:27:49 shalem kernel:  ? _copy_from_user+0x83/0xa0
Aug 19 12:27:49 shalem kernel:  ? get_sg_io_hdr+0x26/0xb0
Aug 19 12:27:49 shalem kernel:  scsi_ioctl+0x44c/0x960
Aug 19 12:27:49 shalem kernel:  ? scsi_ioctl_block_when_processing_errors+0x45/0x50
Aug 19 12:27:49 shalem kernel:  blkdev_ioctl+0x143/0x2c0
Aug 19 12:27:49 shalem kernel:  __x64_sys_ioctl+0x90/0xd0
Aug 19 12:27:49 shalem kernel:  do_syscall_64+0x5b/0x80
Aug 19 12:27:49 shalem kernel:  ? do_syscall_64+0x67/0x80
Aug 19 12:27:49 shalem kernel:  ? lockdep_hardirqs_on+0x7d/0x100
Aug 19 12:27:49 shalem kernel:  ? do_syscall_64+0x67/0x80
Aug 19 12:27:49 shalem kernel:  ? ret_from_fork+0x15/0x30
Aug 19 12:27:49 shalem kernel:  ? lockdep_hardirqs_on+0x7d/0x100
Aug 19 12:27:49 shalem kernel:  entry_SYSCALL_64_after_hwframe+0x63/0xcd
Aug 19 12:27:49 shalem kernel: RIP: 0033:0x7f0c77065cdf
Aug 19 12:27:49 shalem kernel: RSP: 002b:00007f0c75dfd7f0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Aug 19 12:27:49 shalem kernel: RAX: ffffffffffffffda RBX: 00007f0c75dfda00 RCX: 00007f0c77065cdf
Aug 19 12:27:49 shalem kernel: RDX: 00007f0c75dfd860 RSI: 0000000000002285 RDI: 0000000000000011
Aug 19 12:27:49 shalem kernel: RBP: 0000000000001388 R08: 00007f0c75dfd9e0 R09: 00007f0c75dfe550
Aug 19 12:27:49 shalem kernel: R10: 00007f0c75dfd960 R11: 0000000000000246 R12: 00007f0c75dfdb70
Aug 19 12:27:49 shalem kernel: R13: 0000000000000000 R14: 0000000000000011 R15: 00007f0c75dfd9e0
Aug 19 12:27:49 shalem kernel:  </TASK>
Aug 19 12:27:49 shalem kernel: 
                               Showing all locks held in the system:
Aug 19 12:27:49 shalem kernel: 1 lock held by rcu_tasks_kthre/11:
Aug 19 12:27:49 shalem kernel:  #0: ffffffff86168820 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2b/0x3e0
Aug 19 12:27:49 shalem kernel: 1 lock held by rcu_tasks_rude_/12:
Aug 19 12:27:49 shalem kernel:  #0: ffffffff86168560 (rcu_tasks_rude.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2b/0x3e0
Aug 19 12:27:49 shalem kernel: 1 lock held by rcu_tasks_trace/13:
Aug 19 12:27:49 shalem kernel:  #0: ffffffff86168260 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2b/0x3e0
Aug 19 12:27:49 shalem kernel: 1 lock held by khungtaskd/100:
Aug 19 12:27:49 shalem kernel:  #0: ffffffff86169320 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x15/0x16b
Aug 19 12:27:49 shalem kernel: 4 locks held by kworker/0:3/305:
Aug 19 12:27:49 shalem kernel:  #0: ffff8ac180051748 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x20b/0x600
Aug 19 12:27:49 shalem kernel:  #1: ffffa78dc4007e78 ((work_completion)(&ap->scsi_rescan_task)){+.+.}-{0:0}, at: process_one_work+0x20b/0x600
Aug 19 12:27:49 shalem kernel:  #2: ffff8ac18ba840a8 (&ap->scsi_scan_mutex){+.+.}-{3:3}, at: ata_scsi_dev_rescan+0x32/0x110
Aug 19 12:27:49 shalem kernel:  #3: ffff8ac1909b5390 (&dev->mutex){....}-{3:3}, at: scsi_rescan_device+0x24/0x90
Aug 19 12:27:49 shalem kernel: 1 lock held by systemd-journal/2096:
Aug 19 12:27:49 shalem kernel: 1 lock held by LCDd/2542:
Aug 19 12:27:49 shalem kernel:  #0: ffffffff8635a578 (minors_rwsem){++++}-{3:3}, at: hidraw_write+0x1e/0x50
Aug 19 12:27:49 shalem kernel: 
Aug 19 12:27:49 shalem kernel: =============================================


Aug 19 12:29:51 shalem kernel: INFO: task kworker/0:3:305 blocked for more than 368 seconds.
Aug 19 12:29:51 shalem kernel:       Tainted: G        W  OE     -------  ---  6.0.0-0.rc1.20220817git3cc40a443a04.14.fc38.x86_64 #1
Aug 19 12:29:51 shalem kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 19 12:29:51 shalem kernel: task:kworker/0:3     state:D stack:13008 pid:  305 ppid:     2 flags:0x00004000
Aug 19 12:29:51 shalem kernel: Workqueue: events ata_scsi_dev_rescan
Aug 19 12:29:51 shalem kernel: Call Trace:
Aug 19 12:29:51 shalem kernel:  <TASK>
Aug 19 12:29:51 shalem kernel:  __schedule+0x47f/0x16d0
Aug 19 12:29:51 shalem kernel:  ? mark_held_locks+0x50/0x80
Aug 19 12:29:51 shalem kernel:  ? _raw_spin_unlock_irq+0x24/0x50
Aug 19 12:29:51 shalem kernel:  schedule+0x5d/0xe0
Aug 19 12:29:51 shalem kernel:  blk_mq_freeze_queue_wait+0x57/0x90
Aug 19 12:29:51 shalem kernel:  ? prepare_to_wait_exclusive+0xd0/0xd0
Aug 19 12:29:51 shalem kernel:  disk_clear_zone_settings+0x19/0xa0
Aug 19 12:29:51 shalem kernel:  sd_revalidate_disk.isra.0+0x1660/0x2c60
Aug 19 12:29:51 shalem kernel:  ? slab_free_freelist_hook.constprop.0+0x11b/0x160
Aug 19 12:29:51 shalem kernel:  ? scsi_rescan_device+0x2c/0x90
Aug 19 12:29:51 shalem kernel:  scsi_rescan_device+0x77/0x90
Aug 19 12:29:51 shalem kernel:  ata_scsi_dev_rescan+0x9d/0x110
Aug 19 12:29:51 shalem kernel:  process_one_work+0x2a0/0x600
Aug 19 12:29:51 shalem kernel:  worker_thread+0x4f/0x3a0
Aug 19 12:29:51 shalem kernel:  ? process_one_work+0x600/0x600
Aug 19 12:29:51 shalem kernel:  kthread+0xf5/0x120
Aug 19 12:29:51 shalem kernel:  ? kthread_complete_and_exit+0x20/0x20
Aug 19 12:29:51 shalem kernel:  ret_from_fork+0x22/0x30
Aug 19 12:29:51 shalem kernel:  </TASK>
Aug 19 12:29:51 shalem kernel: INFO: task smartd:2557 blocked for more than 368 seconds.
Aug 19 12:29:51 shalem kernel:       Tainted: G        W  OE     -------  ---  6.0.0-0.rc1.20220817git3cc40a443a04.14.fc38.x86_64 #1
Aug 19 12:29:51 shalem kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 19 12:29:51 shalem kernel: task:smartd          state:D stack:13000 pid: 2557 ppid:     1 flags:0x00000002
Aug 19 12:29:51 shalem kernel: Call Trace:
Aug 19 12:29:51 shalem kernel:  <TASK>
Aug 19 12:29:51 shalem kernel:  __schedule+0x47f/0x16d0
Aug 19 12:29:51 shalem kernel:  ? lock_release+0x14f/0x460
Aug 19 12:29:51 shalem kernel:  ? _raw_spin_unlock_irqrestore+0x30/0x60
Aug 19 12:29:51 shalem kernel:  ? _raw_spin_unlock_irqrestore+0x40/0x60
Aug 19 12:29:51 shalem kernel:  schedule+0x5d/0xe0
Aug 19 12:29:51 shalem kernel:  blk_queue_enter+0xe5/0x190
Aug 19 12:29:51 shalem kernel:  ? prepare_to_wait_exclusive+0xd0/0xd0
Aug 19 12:29:51 shalem kernel:  blk_mq_alloc_request+0x50/0xb0
Aug 19 12:29:51 shalem kernel:  scsi_alloc_request+0xb/0x30
Aug 19 12:29:51 shalem kernel:  sg_io+0x6b/0x390
Aug 19 12:29:51 shalem kernel:  ? _copy_from_user+0x83/0xa0
Aug 19 12:29:51 shalem kernel:  ? get_sg_io_hdr+0x26/0xb0
Aug 19 12:29:51 shalem kernel:  scsi_ioctl+0x44c/0x960
Aug 19 12:29:51 shalem kernel:  ? scsi_ioctl_block_when_processing_errors+0x45/0x50
Aug 19 12:29:51 shalem kernel:  blkdev_ioctl+0x143/0x2c0
Aug 19 12:29:51 shalem kernel:  __x64_sys_ioctl+0x90/0xd0
Aug 19 12:29:51 shalem kernel:  do_syscall_64+0x5b/0x80
Aug 19 12:29:51 shalem kernel:  ? do_syscall_64+0x67/0x80
Aug 19 12:29:51 shalem kernel:  ? do_syscall_64+0x67/0x80
Aug 19 12:29:51 shalem kernel:  ? do_syscall_64+0x67/0x80
Aug 19 12:29:51 shalem kernel:  ? lockdep_hardirqs_on+0x7d/0x100
Aug 19 12:29:51 shalem kernel:  entry_SYSCALL_64_after_hwframe+0x63/0xcd
Aug 19 12:29:51 shalem kernel: RIP: 0033:0x7f9641245cdf
Aug 19 12:29:51 shalem kernel: RSP: 002b:00007ffc73d257d0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Aug 19 12:29:51 shalem kernel: RAX: ffffffffffffffda RBX: 00007ffc73d25ad0 RCX: 00007f9641245cdf
Aug 19 12:29:51 shalem kernel: RDX: 00007ffc73d25840 RSI: 0000000000002285 RDI: 0000000000000003
Aug 19 12:29:51 shalem kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
Aug 19 12:29:51 shalem kernel: R10: 000000000000003c R11: 0000000000000246 R12: 00007ffc73d25c50
Aug 19 12:29:51 shalem kernel: R13: 0000000000000001 R14: 0000000000000000 R15: 000055fbff0abd10
Aug 19 12:29:51 shalem kernel:  </TASK>
Aug 19 12:29:51 shalem kernel: INFO: task pool-udisksd:9404 blocked for more than 368 seconds.
Aug 19 12:29:51 shalem kernel:       Tainted: G        W  OE     -------  ---  6.0.0-0.rc1.20220817git3cc40a443a04.14.fc38.x86_64 #1
Aug 19 12:29:51 shalem kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 19 12:29:51 shalem kernel: task:pool-udisksd    state:D stack:14624 pid: 9404 ppid:     1 flags:0x00000002
Aug 19 12:29:51 shalem kernel: Call Trace:
Aug 19 12:29:51 shalem kernel:  <TASK>
Aug 19 12:29:51 shalem kernel:  __schedule+0x47f/0x16d0
Aug 19 12:29:51 shalem kernel:  ? lock_release+0x14f/0x460
Aug 19 12:29:51 shalem kernel:  ? _raw_spin_unlock_irqrestore+0x30/0x60
Aug 19 12:29:51 shalem kernel:  ? _raw_spin_unlock_irqrestore+0x40/0x60
Aug 19 12:29:51 shalem kernel:  schedule+0x5d/0xe0
Aug 19 12:29:51 shalem kernel:  blk_queue_enter+0xe5/0x190
Aug 19 12:29:51 shalem kernel:  ? prepare_to_wait_exclusive+0xd0/0xd0
Aug 19 12:29:51 shalem kernel:  blk_mq_alloc_request+0x50/0xb0
Aug 19 12:29:51 shalem kernel:  scsi_alloc_request+0xb/0x30
Aug 19 12:29:51 shalem kernel:  sg_io+0x6b/0x390
Aug 19 12:29:51 shalem kernel:  ? _copy_from_user+0x83/0xa0
Aug 19 12:29:51 shalem kernel:  ? get_sg_io_hdr+0x26/0xb0
Aug 19 12:29:51 shalem kernel:  scsi_ioctl+0x44c/0x960
Aug 19 12:29:51 shalem kernel:  ? scsi_ioctl_block_when_processing_errors+0x45/0x50
Aug 19 12:29:51 shalem kernel:  blkdev_ioctl+0x143/0x2c0
Aug 19 12:29:51 shalem kernel:  __x64_sys_ioctl+0x90/0xd0
Aug 19 12:29:51 shalem kernel:  do_syscall_64+0x5b/0x80
Aug 19 12:29:51 shalem kernel:  ? do_syscall_64+0x67/0x80
Aug 19 12:29:51 shalem kernel:  ? lockdep_hardirqs_on+0x7d/0x100
Aug 19 12:29:51 shalem kernel:  ? do_syscall_64+0x67/0x80
Aug 19 12:29:51 shalem kernel:  ? ret_from_fork+0x15/0x30
Aug 19 12:29:51 shalem kernel:  ? lockdep_hardirqs_on+0x7d/0x100
Aug 19 12:29:51 shalem kernel:  entry_SYSCALL_64_after_hwframe+0x63/0xcd
Aug 19 12:29:51 shalem kernel: RIP: 0033:0x7f0c77065cdf
Aug 19 12:29:51 shalem kernel: RSP: 002b:00007f0c75dfd7f0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Aug 19 12:29:51 shalem kernel: RAX: ffffffffffffffda RBX: 00007f0c75dfda00 RCX: 00007f0c77065cdf
Aug 19 12:29:51 shalem kernel: RDX: 00007f0c75dfd860 RSI: 0000000000002285 RDI: 0000000000000011
Aug 19 12:29:51 shalem kernel: RBP: 0000000000001388 R08: 00007f0c75dfd9e0 R09: 00007f0c75dfe550
Aug 19 12:29:51 shalem kernel: R10: 00007f0c75dfd960 R11: 0000000000000246 R12: 00007f0c75dfdb70
Aug 19 12:29:51 shalem kernel: R13: 0000000000000000 R14: 0000000000000011 R15: 00007f0c75dfd9e0
Aug 19 12:29:51 shalem kernel:  </TASK>
Aug 19 12:29:51 shalem kernel: 
                               Showing all locks held in the system:
Aug 19 12:29:51 shalem kernel: 1 lock held by rcu_tasks_kthre/11:
Aug 19 12:29:51 shalem kernel:  #0: ffffffff86168820 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2b/0x3e0
Aug 19 12:29:51 shalem kernel: 1 lock held by rcu_tasks_rude_/12:
Aug 19 12:29:51 shalem kernel:  #0: ffffffff86168560 (rcu_tasks_rude.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2b/0x3e0
Aug 19 12:29:51 shalem kernel: 1 lock held by rcu_tasks_trace/13:
Aug 19 12:29:51 shalem kernel:  #0: ffffffff86168260 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2b/0x3e0
Aug 19 12:29:51 shalem kernel: 1 lock held by khungtaskd/100:
Aug 19 12:29:51 shalem kernel:  #0: ffffffff86169320 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x15/0x16b
Aug 19 12:29:51 shalem kernel: 4 locks held by kworker/0:3/305:
Aug 19 12:29:51 shalem kernel:  #0: ffff8ac180051748 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x20b/0x600
Aug 19 12:29:51 shalem kernel:  #1: ffffa78dc4007e78 ((work_completion)(&ap->scsi_rescan_task)){+.+.}-{0:0}, at: process_one_work+0x20b/0x600
Aug 19 12:29:51 shalem kernel:  #2: ffff8ac18ba840a8 (&ap->scsi_scan_mutex){+.+.}-{3:3}, at: ata_scsi_dev_rescan+0x32/0x110
Aug 19 12:29:51 shalem kernel:  #3: ffff8ac1909b5390 (&dev->mutex){....}-{3:3}, at: scsi_rescan_device+0x24/0x90
Aug 19 12:29:51 shalem kernel: 1 lock held by LCDd/2542:
Aug 19 12:29:51 shalem kernel:  #0: ffffffff8635a578 (minors_rwsem){++++}-{3:3}, at: hidraw_write+0x1e/0x50
Aug 19 12:29:51 shalem kernel: 
Aug 19 12:29:51 shalem kernel: =============================================


Aug 19 12:31:54 shalem kernel: INFO: task kworker/0:3:305 blocked for more than 491 seconds.
Aug 19 12:31:54 shalem kernel:       Tainted: G        W  OE     -------  ---  6.0.0-0.rc1.20220817git3cc40a443a04.14.fc38.x86_64 #1
Aug 19 12:31:54 shalem kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 19 12:31:54 shalem kernel: task:kworker/0:3     state:D stack:13008 pid:  305 ppid:     2 flags:0x00004000
Aug 19 12:31:54 shalem kernel: Workqueue: events ata_scsi_dev_rescan
Aug 19 12:31:54 shalem kernel: Call Trace:
Aug 19 12:31:54 shalem kernel:  <TASK>
Aug 19 12:31:54 shalem kernel:  __schedule+0x47f/0x16d0
Aug 19 12:31:54 shalem kernel:  ? mark_held_locks+0x50/0x80
Aug 19 12:31:54 shalem kernel:  ? _raw_spin_unlock_irq+0x24/0x50
Aug 19 12:31:54 shalem kernel:  schedule+0x5d/0xe0
Aug 19 12:31:54 shalem kernel:  blk_mq_freeze_queue_wait+0x57/0x90
Aug 19 12:31:54 shalem kernel:  ? prepare_to_wait_exclusive+0xd0/0xd0
Aug 19 12:31:54 shalem kernel:  disk_clear_zone_settings+0x19/0xa0
Aug 19 12:31:54 shalem kernel:  sd_revalidate_disk.isra.0+0x1660/0x2c60
Aug 19 12:31:54 shalem kernel:  ? slab_free_freelist_hook.constprop.0+0x11b/0x160
Aug 19 12:31:54 shalem kernel:  ? scsi_rescan_device+0x2c/0x90
Aug 19 12:31:54 shalem kernel:  scsi_rescan_device+0x77/0x90
Aug 19 12:31:54 shalem kernel:  ata_scsi_dev_rescan+0x9d/0x110
Aug 19 12:31:54 shalem kernel:  process_one_work+0x2a0/0x600
Aug 19 12:31:54 shalem kernel:  worker_thread+0x4f/0x3a0
Aug 19 12:31:54 shalem kernel:  ? process_one_work+0x600/0x600
Aug 19 12:31:54 shalem kernel:  kthread+0xf5/0x120
Aug 19 12:31:54 shalem kernel:  ? kthread_complete_and_exit+0x20/0x20
Aug 19 12:31:54 shalem kernel:  ret_from_fork+0x22/0x30
Aug 19 12:31:54 shalem kernel:  </TASK>
Aug 19 12:31:54 shalem kernel: 
                               Showing all locks held in the system:
Aug 19 12:31:54 shalem kernel: 1 lock held by rcu_tasks_kthre/11:
Aug 19 12:31:54 shalem kernel:  #0: ffffffff86168820 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2b/0x3e0
Aug 19 12:31:54 shalem kernel: 1 lock held by rcu_tasks_rude_/12:
Aug 19 12:31:54 shalem kernel:  #0: ffffffff86168560 (rcu_tasks_rude.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2b/0x3e0
Aug 19 12:31:54 shalem kernel: 1 lock held by rcu_tasks_trace/13:
Aug 19 12:31:54 shalem kernel:  #0: ffffffff86168260 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2b/0x3e0
Aug 19 12:31:54 shalem kernel: 1 lock held by khungtaskd/100:
Aug 19 12:31:54 shalem kernel:  #0: ffffffff86169320 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x15/0x16b
Aug 19 12:31:54 shalem kernel: 4 locks held by kworker/0:3/305:
Aug 19 12:31:54 shalem kernel:  #0: ffff8ac180051748 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x20b/0x600
Aug 19 12:31:54 shalem kernel:  #1: ffffa78dc4007e78 ((work_completion)(&ap->scsi_rescan_task)){+.+.}-{0:0}, at: process_one_work+0x20b/0x600
Aug 19 12:31:54 shalem kernel:  #2: ffff8ac18ba840a8 (&ap->scsi_scan_mutex){+.+.}-{3:3}, at: ata_scsi_dev_rescan+0x32/0x110
Aug 19 12:31:54 shalem kernel:  #3: ffff8ac1909b5390 (&dev->mutex){....}-{3:3}, at: scsi_rescan_device+0x24/0x90
Aug 19 12:31:54 shalem kernel: 1 lock held by gfx/688:
Aug 19 12:31:54 shalem kernel:  #0: ffffffff86169320 (rcu_read_lock){....}-{1:2}, at: raw_spin_rq_lock_nested+0x24/0x80
Aug 19 12:31:54 shalem kernel: 1 lock held by LCDd/2542:
Aug 19 12:31:54 shalem kernel:  #0: ffffffff8635a578 (minors_rwsem){++++}-{3:3}, at: hidraw_write+0x1e/0x50
Aug 19 12:31:54 shalem kernel: 2 locks held by kworker/u64:119/8383:
Aug 19 12:31:54 shalem kernel: 1 lock held by WRRende~ckend#1/9586:
Aug 19 12:31:54 shalem kernel: 
Aug 19 12:31:54 shalem kernel: =============================================

Sorry for not being able to write a better bug-report but I don't have
the time to dive into this deeper. I hope this report is enough for
someone to have a clue what is going on.

Regards,

Hans

