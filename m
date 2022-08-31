Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9484D5A8251
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 17:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbiHaPwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 11:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiHaPwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 11:52:45 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9C5AB405;
        Wed, 31 Aug 2022 08:52:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VNrdnpg_1661961144;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VNrdnpg_1661961144)
          by smtp.aliyun-inc.com;
          Wed, 31 Aug 2022 23:52:29 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com, axboe@kernel.dk
Cc:     xiaoguang.wang@linux.alibaba.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [RFC PATCH V2 0/6] ublk_drv: add USER_RECOVERY support
Date:   Wed, 31 Aug 2022 23:51:30 +0800
Message-Id: <20220831155136.23434-1-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ublk_drv is a driver simply passes all blk-mq rqs to ublksrv[1] in
userspace. For each ublk queue, there is one ubq_daemon(pthread).
All ubq_daemons share the same process which opens /dev/ublkcX.
The ubq_daemon code infinitely loops on io_uring_enter() to
send/receive io_uring cmds which pass information of blk-mq
rqs.

Since the real IO handler(the process opening /dev/ublkcX) is in
userspace, it could crash if:
(1) the user kills -9 it because of IO hang on backend, system
    reboot, etc...
(2) the process catches a exception(segfault, divisor error, oom...)
Therefore, the kernel driver has to deal with a dying process.

Now, if one ubq_daemon(pthread) or the process crashes, ublk_drv
must abort the dying ubq, stop the device and release everything.
This is not a good choice in practice because users do not expect
aborted requests, I/O errors and a released device. They may want
a recovery machenism so that no requests are aborted and no I/O
error occurs. Anyway, users just want everything works as uaual.

This RFC patchset implements USER_RECOVERY support. If the process
crashes, we allow ublksrv to provide new process and ubq_daemons.
We do not support single ubq_daemon(pthread) recovery because a
pthread rarely crashes.

Note: The responsibility of recovery belongs to the user who opens
/dev/ublkcX. After a process crash, the kernel driver only switch
the device's status to be ready for recovery or termination(STOP_DEV).
This patchset does not provide how to detect such a process crash in
userspace. A very straightfoward idea may be adding a watchdog.

Recovery feature is quite useful for real products. In detail,
we support this scenario:
(1) The /dev/ublkc0 is opened by process 0;
(2) Fio is running on /dev/ublkb0 exposed by ublk_drv and all
    rqs are handled by process 0.
(3) Process 0 suddenly crashes(e.g. segfault);
(4) Fio is still running and submit IOs(but these IOs cannot
    complete now)
(5) User recovers with process 1 and attach it to /dev/ublkc0
(6) All rqs are handled by process 1 now and IOs can be
    completed now.

Note: The backend must tolerate double-write because we re-issue
a rq sent to the old(dying) process before. We allow users to
choose whether re-issue these rqs or not, please see patch 7 for
more detail.

We provide a sample script here to simulate the above steps:

***************************script***************************
LOOPS=10

__ublk_get_pid() {
	pid=`./ublk list -n 0 | grep "pid" | awk '{print $7}'`
	echo $pid
}

ublk_recover_kill()
{
	for CNT in `seq $LOOPS`; do
		dmesg -C
                pid=`__ublk_get_pid`
                echo -e "*** kill $pid now ***"
		kill -9 $pid
		sleep 6
                echo -e "*** recover now ***"
                ./ublk recover -n 0
		sleep 6
	done
}

ublk_test()
{
        dmesg -C
        echo -e "*** add ublk device ***"
        ./ublk add -t null -d 4 -i 1
        sleep 2
        echo -e "*** start fio ***"
        fio --bs=4k \
            --filename=/dev/ublkb0 \
            --runtime=140s \
            --rw=read &
        sleep 4
        ublk_recover_kill
        wait
        echo -e "*** delete ublk device ***"
        ./ublk del -n 0
}

for CNT in `seq 4`; do
        modprobe -rv ublk_drv
        modprobe ublk_drv
        echo -e "************ round $CNT ************"
        ublk_test
        sleep 5
done
***************************script***************************

You may run it with our modified ublksrv[2] which supports
recovey feature. No I/O error occurs and you can verify it
by typing
    $ perf-tools/bin/tpoint block:block_rq_error

The basic idea of USER_RECOVERY is quite straightfoward:

(1) release/free everything belongs to the dying process.

    Note: Since ublk_drv does save information about user process,
    this work is important because we don't expect any resource
    lekage. Particularly, ioucmds from the dying ubq_daemons
    need to be completed(freed).

(2) init ublk queues including requeuing/aborting rqs.

(3) allow new ubq_daemons issue FETCH_REQ.

Here is steps to reocver:

(1) The monitor_work detects a crash, and it should requeue/abort inflight
    rqs, complete old ioucmds and quiesce request queue to ban any incoming
    ublk_queue_rq(). Then the ublk device is ready for a recovery/stop
    procedure.

(2) For a user, after a process crash, he sends START_USER_RECOVERY
    ctrl-cmd to /dev/ublk-control with a dev_id X (such as 3 for
    /dev/ublkc3).

(2) Then ublk_drv should perpare for a new process to attach /dev/ublkcX.
    All ublk_io structures are cleared and ubq_daemons are reset.

(3) Then, user should start a new process and ubq_daemons(pthreads) and
    send FETCH_REQ by io_uring_enter() to make all ubqs be ready. The
    user must correctly setup queues, flags and so on(how to persist
    user's information is not related to this patchset).

(4) The user sends END_USER_RECOVERY ctrl-cmd to /dev/ublk-control with a
    dev_id X.

(5) ublk_drv waits for all ubq_daemons getting ready. Then it unquiesces
    request queue and new rqs are allowed.

You should use ublksrv[2] and tests[3] provided by us. We add 2 additional
tests to verify that recovery feature works. Our code will be PR-ed to
Ming's repo soon.

[1] https://github.com/ming1/ubdsrv
[2] https://github.com/old-memories/ubdsrv/tree/recovery-v1
[3] https://github.com/old-memories/ubdsrv/tree/recovery-v1/tests/generic

Since V1:
(1) refactor cover letter. Add intruduction on "how to detect a crash" and
    "why we need recovery feature".
(2) do not refactor task_work and ublk_queue_rq().
(3) allow users freely stop/recover the device.
(4) add comment on ublk_cancel_queue().
(5) refactor monitor_work and aborting machenism since we add recovery
    machenism in monitor_work.

ZiyangZhang (6):
  ublk_drv: check 'current' instead of 'ubq_daemon'
  ublk_drv: refactor ublk_cancel_queue()
  ublk_drv: define macros for recovery feature and check them
  ublk_drv: requeue rqs with recovery feature enabled
  ublk_drv: consider recovery feature in aborting mechanism
  ublk_drv: add START_USER_RECOVERY and END_USER_RECOVERY support

 drivers/block/ublk_drv.c      | 439 +++++++++++++++++++++++++++++++---
 include/uapi/linux/ublk_cmd.h |   7 +
 2 files changed, 419 insertions(+), 27 deletions(-)

-- 
2.27.0

