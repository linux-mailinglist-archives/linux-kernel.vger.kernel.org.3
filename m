Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6AA56451F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 06:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiGCE5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 00:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiGCE50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 00:57:26 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63099592;
        Sat,  2 Jul 2022 21:57:25 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 23so6026713pgc.8;
        Sat, 02 Jul 2022 21:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=0zAnyni5Vrc+oHO28/Vl9glMrviD0r1aRl+f2W+XCP0=;
        b=TW1PnzLppzQFL1P7oklyO9PYNyG9aTwZxQJaZyjGNlUj6GSEE2FApRPB/7J1v9M60p
         mobryRspQ8HsxlqoHowLswelyMPdgIUvWqaIYcSPUBh0AUzCzZeJqnnFx/uEEQg5vCPc
         gWnetOAMDnDi666Q/ODhvvUPxJ5HCoUdywVtjXeW7NNDV5HLMCfl8O44IJ+pB1BAQ2Ba
         mBadORhUfnTobCQeKpZaq4jMYLZT+5keoxkBnHHqmkBqgaS2cqujVmRgPB//omPUkd7O
         jDeRRLKVlX5HZCbFwQMr/ysPF561jjz8/jwDQ70eAwRPLZw6xnOwJjgbWlKV/CWG+moO
         Djqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=0zAnyni5Vrc+oHO28/Vl9glMrviD0r1aRl+f2W+XCP0=;
        b=6XhOZ7wvv0TfqW3QHh8lB9BWA9Czi2IZz01b/eeHDPkd+Ss+a+ipDvDJcnv4pSLIO3
         AbKOW7atB7ooS3YRHtzvRtVFmn/rHYTMz+Ln8VIxcZXhf5pahSiM8AgeeSBytH4y8FiZ
         iSydFOoqs+OmQEZDGONF084D0ZVGns0bnFnHUGhuzB/Udx2EZY3+ddst7lHMsZugDXRe
         hFhvrB401dMZQU+MUbaMWZ5OWeGJjVUSIiSyW5v81h0bxMTKB+OJ1VnVkffmCcX6H7hM
         CV7s2znXWpGJJuRNqlr3vqyM98r3sbIKx7IGdqp7MJ2aaCJ5ez2meJeZ4CHzXL+4NV8y
         FLBA==
X-Gm-Message-State: AJIora+Lx6SpJCwwJiMxZ09jESn89yV+sk4BqMiSLArDfbtIb/gk3Byw
        u9BDaMIBh/ZOG6u0x6VbLEcdcI9Fllg=
X-Google-Smtp-Source: AGRyM1v2vDCwQzbnh3bk0IN/7gz3BMZq4vYYyTtn9D5CMJvZ1xigEu4PeSPNcuQDRwj6Ud9qBgzB4A==
X-Received: by 2002:a05:6a00:cd1:b0:525:4c0e:d0a3 with SMTP id b17-20020a056a000cd100b005254c0ed0a3mr28282467pfv.67.1656824245238;
        Sat, 02 Jul 2022 21:57:25 -0700 (PDT)
Received: from archdragon (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id u10-20020a170903124a00b0016a01637620sm1311707plh.76.2022.07.02.21.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 21:57:24 -0700 (PDT)
Date:   Sun, 3 Jul 2022 13:57:20 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     axboe@kernel.dk, rostedt@goodmis.org, mingo@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: INFO: task hung in blk_trace_remove
Message-ID: <YsEhsEvhZyoJFtSO@archdragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We observed an issue "INFO: task hung in blk_trace_remove" during
fuzzing.

Unfortunately, we have not found a reproducer for the crash yet. We
will inform you if we have any update on this crash.

The crash information is attached at the end of this email.


Best regards,
Dae R. Jeong

------

- Kernel commit:
92f20ff72066d

- Crash report: 
INFO: task syz-executor.0:13658 blocked for more than 143 seconds.
      Not tainted 5.19.0-rc3-32288-g0f3b08299494 #3
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:27824 pid:13658 ppid:  6759 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x96c/0x10f0 kernel/sched/core.c:6458
 schedule+0xea/0x1b0 kernel/sched/core.c:6530
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6589
 __mutex_lock_common+0xe0f/0x25e0 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
 blk_trace_remove+0x1c/0x40 kernel/trace/blktrace.c:374
 sg_ioctl_common drivers/scsi/sg.c:1130 [inline]
 sg_ioctl+0x712/0x4be0 drivers/scsi/sg.c:1164
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0x152/0x1f0 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x4e/0xa0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x47268d
RSP: 002b:00007fab57574be8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000057d4a0 RCX: 000000000047268d
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000057d4a8
R13: 000000000057d4ac R14: 00007ffe9afe72f0 R15: 00007fab57574d80
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/40:
 #0: ffffffff92f1a3e0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
1 lock held by in:imklog/6420:
 #0: ffff88807d844368 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x3bf/0x530 fs/file.c:1036
4 locks held by syz-executor.0/13657:
1 lock held by syz-executor.0/13658:
 #0: ffff888022c78378 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1c/0x40 kernel/trace/blktrace.c:374

