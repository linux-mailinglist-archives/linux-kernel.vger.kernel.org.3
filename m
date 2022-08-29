Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E166C5A40E0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 04:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiH2CI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 22:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH2CI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 22:08:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED7E2F007
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 19:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661738903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KIRE7tLozpF13xOfhfNz9hpJ1HAcNIfOccgt3ayzJTM=;
        b=Kzy3Tkh0Uslln9eDE9qe1jDF2ktNXVecV3nmLbo52J10gJ2io82P1mOyf9wV9K719FP2Eh
        lNOQ+mPccJ6gysoyahqOyu8KcPxhMpF3NIyy6J7555lYOjfqejTDV5zNiWr1zEUCFTde0W
        TUGU1kOiYbAOz/bwiV+bJfGPgst+EMw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-PO_VuX-wMBaFVBYLINPJrQ-1; Sun, 28 Aug 2022 22:08:22 -0400
X-MC-Unique: PO_VuX-wMBaFVBYLINPJrQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D563B1C05136;
        Mon, 29 Aug 2022 02:08:21 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 63B412026D64;
        Mon, 29 Aug 2022 02:08:15 +0000 (UTC)
Date:   Mon, 29 Aug 2022 10:08:11 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, ming.lei@redhat.com
Subject: Re: [RFC PATCH 0/9] ublk_drv: add USER_RECOVERY support
Message-ID: <Ywwfi7Dgi0JC2kQ/@T590>
References: <20220824054744.77812-1-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824054744.77812-1-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 01:47:35PM +0800, ZiyangZhang wrote:
> ublk_drv is a driver simply passes all blk-mq rqs to ublksrv[1] in
> userspace. For each ublk queue, there is one ubq_daemon(pthread).
> All ubq_daemons share the same process which opens /dev/ublkcX.
> The ubq_daemon code infinitely loops on io_uring_enter() to
> send/receive io_uring cmds which pass information of blk-mq
> rqs.
> 
> Now, if one ubq_daemon(pthread) or the process crashes, ublk_drv
> must abort the dying ubq, stop the device and release everything.
> This is not a good choice in practice because users do not expect
> aborted requests, I/O errors and a released device. They may want
> a recovery machenism so that no requests are aborted and no I/O
> error occurs. Anyway, users just want everything works as uaual.

I understand the requirement is that both /dev/ublkbN and /dev/ublkcN
won't be deleted & re-added from user viewpoint after user recovery,
so the device context won't be lost.

> 
> This RFC patchset implements USER_RECOVERY support. If the process
> crashes, we allow ublksrv to provide new process and ubq_daemons.
> We do not support single ubq_daemon(pthread) recovery because a
> pthread rarely crashes.
> 
> Recovery feature is quite useful for products do not expect to
> return any I/O error to frontend users.

That looks one very ideal requirement. To be honest, no any block driver
can guarantee that 100%, so it is just one soft requirement?

Cause memory allocation may fail, network may be disconnected,
re-creating pthread or process may fail too, ...

> In detail, we support
> this scenario:
> (1) The /dev/ublkc0 is opened by process 0;
> (2) Fio is running on /dev/ublkb0 exposed by ublk_drv and all
>     rqs are handled by process 0.
> (3) Process 0 suddenly crashes(e.g. segfault);
> (4) Fio is still running and submit IOs(but these IOs cannot
>     complete now)
> (5) User recovers with process 1 and attach it to /dev/ublkc0
> (6) All rqs are handled by process 1 now and IOs can be
>     completed now.
> 
> Note: The backend must tolerate double-write because we re-issue
> a rq sent to the old(dying) process before. We allow users to
> choose whether re-issue these rqs or not, please see patch 7 for
> more detail.
> 
> We provide a sample script here to simulate the above steps:
> 
> ***************************script***************************
> LOOPS=10
> 
> __ublk_get_pid() {
> 	pid=`./ublk list -n 0 | grep "pid" | awk '{print $7}'`
> 	echo $pid
> }
> 
> ublk_recover_kill()
> {
> 	for CNT in `seq $LOOPS`; do
> 		dmesg -C
>                 pid=`__ublk_get_pid`
>                 echo -e "*** kill $pid now ***"
> 		kill -9 $pid
> 		sleep 2
>                 echo -e "*** recover now ***"
>                 ./ublk recover -n 0

The current behavior is that /dev/ublkb* is removed after device is
aborted because ubq daemon is killed.

What if 'ublk recover' command isn't sent? So the current behavior
without recovery is changed? Or just changed with this feature enabled?

BTW, I do not mean the change isn't reasonable, but suggest to document
the user visible change, so it can get reviewed from either user
viewpoint and technical point.

> 		sleep 4
> 	done
> }
> 
> ublk_test()
> {
>         dmesg -C
>         echo -e "*** add ublk device ***"
>         ./ublk add -t null -d 4 -i 1
>         sleep 2
>         echo -e "*** start fio ***"
>         fio --bs=4k \
>             --filename=/dev/ublkb0 \
>             --runtime=100s \
>             --rw=read &
>         sleep 4
>         ublk_recover_kill
>         wait
>         echo -e "*** delete ublk device ***"
>         ./ublk del -n 0
> }
> 
> for CNT in `seq 4`; do
>         modprobe -rv ublk_drv
>         modprobe ublk_drv
>         echo -e "************ round $CNT ************"
>         ublk_test
>         sleep 5
> done
> ***************************script***************************
> 
> You may run it with our modified ublksrv[3] which supports
> recovey feature. No I/O error occurs and you can verify it
> by typing
>     $ perf-tools/bin/tpoint block:block_rq_error
> 
> The basic idea of USER_RECOVERY is quite straightfoward:
> 
> (1) release/free everything belongs to the dying process.
> 
>     Note: Since ublk_drv does save information about user process,
>     this work is important because we don't expect any resource
>     lekage. Particularly, ioucmds from the dying ubq_daemons
>     need to be completed(freed). Current ublk_drv code cannot satisfy
>     our need while considering USER_RECOVERY. So we refactor some code
>     shown in patch 1-5 to gracefully free all ioucmds.
> 
> (2) init ublk queues including requeuing/aborting rqs.
> 
> (3) allow new ubq_daemons issue FETCH_REQ.
> 
> Here is steps to reocver:
> 
> (1) For a user, after a process crash(how he detect a crash is not related
>     to this patchset), he sends START_USER_RECOVERY ctrl-cmd to

I'd suggest to describe crash detector a bit at least, as one whole use case,
crash detector should be the input of the use case of user recovery, which is
usually one part of use case when modeling software requirement/design.

Such as, crash is detected after the ubq daemon pthread/process is crashed?
Will you consider io hang in the daemon pthread/process? IMO, long-term,
the crash detector utility should be part of ublksrv.

We don't implement ublk driver's IO timeout yet, but that implementation may be
related with this recovery feature closely, such as, one simple approach is to
kill ubq-daemon if we can't move on after retrying several times, then
let userspace detect & recovery.


Thanks,
Ming

