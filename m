Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A193E59F321
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 07:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbiHXFss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 01:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbiHXFsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 01:48:45 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E7C7D7AC;
        Tue, 23 Aug 2022 22:48:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VN5zTW6_1661320113;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VN5zTW6_1661320113)
          by smtp.aliyun-inc.com;
          Wed, 24 Aug 2022 13:48:39 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com, axboe@kernel.dk
Cc:     xiaoguang.wang@linux.alibaba.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [RFC PATCH 0/9] ublk_drv: add USER_RECOVERY support
Date:   Wed, 24 Aug 2022 13:47:35 +0800
Message-Id: <20220824054744.77812-1-ZiyangZhang@linux.alibaba.com>
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

Recovery feature is quite useful for products do not expect to
return any I/O error to frontend users. In detail, we support
this scenario:
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
		sleep 2
                echo -e "*** recover now ***"
                ./ublk recover -n 0
		sleep 4
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
            --runtime=100s \
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

You may run it with our modified ublksrv[3] which supports
recovey feature. No I/O error occurs and you can verify it
by typing
    $ perf-tools/bin/tpoint block:block_rq_error

The basic idea of USER_RECOVERY is quite straightfoward:

(1) release/free everything belongs to the dying process.

    Note: Since ublk_drv does save information about user process,
    this work is important because we don't expect any resource
    lekage. Particularly, ioucmds from the dying ubq_daemons
    need to be completed(freed). Current ublk_drv code cannot satisfy
    our need while considering USER_RECOVERY. So we refactor some code
    shown in patch 1-5 to gracefully free all ioucmds.

(2) init ublk queues including requeuing/aborting rqs.

(3) allow new ubq_daemons issue FETCH_REQ.

Here is steps to reocver:

(1) For a user, after a process crash(how he detect a crash is not related
    to this patchset), he sends START_USER_RECOVERY ctrl-cmd to
    /dev/ublk-control with a dev_id X (such as 3 for /dev/ublkc3).

(2) Then ublk_drv should perpare for a new process to attach /dev/ublkcX.
    We have described this before. The driver must quiesce the request
    queue to ban any incoming ublk_queue_rq().

(3) Then, user should start a new process and ubq_daemons(pthreads) and
    send FETCH_REQ by io_uring_enter() to make all ubqs be ready. The
    user must correctly setup queues, flags and so on(how to persist
    ublksrv information is not related to this patchset).

(4) The user sends END_USER_RECOVERY ctrl-cmd to /dev/ublk-control with a
    dev_id X.

(5) ublk_drv waits for all ubq_daemons getting ready. Then it unquiesces
    request queue and new rqs are allowed.

After applying refactor patches(patch 1-5), with current ublksrv[1], all
tests[2] passes. Note that refactor patches DO NOT involve any recovery
feature.

After applying all patches(patch 1-9), you should use ublksrv[3] and
tests[4] provided by us. We add 2 additional tests to verify that
recovery feature works. our code will be PR-ed to Ming's repo soon.

[1] https://github.com/ming1/ubdsrv
[2] https://github.com/ming1/ubdsrv/tree/master/tests
[3] https://github.com/old-memories/ubdsrv/tree/recovery-v1
[4] https://github.com/old-memories/ubdsrv/tree/recovery-v1/tests/generic

ZiyangZhang (9):
  ublk_drv: check 'current' instead of 'ubq_daemon'
  ublk_drv: refactor ublk_cancel_queue()
  ublk_drv: add a helper to get ioucmd from pdu
  ublk_drv: refactor __ublk_rq_task_work() and aborting machenism
  ublk_drv: refactor ublk_stop_dev()
  ublk_drv: add pr_devel() to prepare for recovery feature
  ublk_drv: define macros for recovery feature and check them
  ublk_drv: add START_USER_RECOVERY and END_USER_RECOVERY support
  ublk_drv: do not schedule monitor_work with recovery feature enabled

 drivers/block/ublk_drv.c      | 517 ++++++++++++++++++++++++++--------
 include/uapi/linux/ublk_cmd.h |   7 +
 2 files changed, 408 insertions(+), 116 deletions(-)

-- 
2.27.0

