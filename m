Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A1C5A45C3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiH2JKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiH2JJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:09:59 -0400
Received: from out199-18.us.a.mail.aliyun.com (out199-18.us.a.mail.aliyun.com [47.90.199.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171D311469;
        Mon, 29 Aug 2022 02:09:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VNbuWhJ_1661764191;
Received: from 30.97.56.171(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VNbuWhJ_1661764191)
          by smtp.aliyun-inc.com;
          Mon, 29 Aug 2022 17:09:52 +0800
Message-ID: <58f89905-b1a5-273b-58a8-ceba8aa7c1a7@linux.alibaba.com>
Date:   Mon, 29 Aug 2022 17:09:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [RFC PATCH 4/9] ublk_drv: refactor __ublk_rq_task_work() and
 aborting machenism
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
References: <20220824054744.77812-1-ZiyangZhang@linux.alibaba.com>
 <20220824054744.77812-5-ZiyangZhang@linux.alibaba.com>
 <YwxRVEQlIw3oWmwE@T590>
 <35dd7300-12ea-62ba-393e-145eae318944@linux.alibaba.com>
 <Ywx0oUcqvE9JcpnT@T590>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <Ywx0oUcqvE9JcpnT@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/29 16:11, Ming Lei wrote:
> On Mon, Aug 29, 2022 at 02:13:12PM +0800, Ziyang Zhang wrote:
>> On 2022/8/29 13:40, Ming Lei wrote:
>>> On Wed, Aug 24, 2022 at 01:47:39PM +0800, ZiyangZhang wrote:
>>>> If one rq is handled by io_uring_cmd_complete_in_task(), after a crash
>>>> this rq is actually handled by an io_uring fallback wq. We have to
>>>> end(abort) this rq since this fallback wq is a task other than the
>>>> crashed task. However, current code does not call io_uring_cmd_done()
>>>> at the same time but do it in ublk_cancel_queue(). With current design,
>>>> this does work because ublk_cancel_queue() is called AFTER del_gendisk(),
>>>> which waits for the rq ended(aborted) in fallback wq. This implies that
>>>> fallback wq on this rq is scheduled BEFORE calling io_uring_cmd_done()
>>>> on the corresponding ioucmd in ublk_cancel_queue().
>>>
>>> Right.

[1]

>>>
>>>>
>>>> However, while considering recovery feature, we cannot rely on
>>>> del_gendisk() or blk_mq_freeze_queue() to wait for completion of all
>>>> rqs because we may not want any aborted rq. Besides, io_uring does not
>>>> provide "flush fallback" machenism so we cannot trace this ioucmd.
>>>
>>> Why not?
>>>
>>> If user recovery is enabled, del_gendisk() can be replaced with
>>> blk_mq_quiesce_queue(), then let abort work function do:
>>>
>>> - cancel all in-flight requests by holding them into requeue list
>>>   instead of finishing them as before, and this way is safe because
>>>   abort worker does know the ubq daemon is dying
>>> - cancel pending commands as before, because the situation is same
>>>   with disk deleted or queue frozen
>>
>> The problem is: we cannot control when fallback wq is scheduled.
>> So we are unsafe to call io_uring_cmd_done() in another process.
> 
> What is the other process?

Hi Ming.

Actually patch 1-5 are all preparations for patch 6-9. So I suggest
you may read patch 6-9 at the same time if you are confused on why
I say there is a 'problem'. In current ublk_drv we really do not need
to consider it(As I have explained in [1] and you replied 'Right').

Answer your question now: in the patchset, it is START_RECOVERY process,
which calls ublk_recover_rq(). Please see patch 8.

> 
> It can't be fallback wq since any ublk request is aborted at the beginning
> of __ublk_rq_task_work().

With recovery feature enabled, we cannot abort the rq, but just let
__ublk_rq_task_work() return. We will requeue the rq soon.

> 
> It shouldn't be the process calling ublk_cancel_dev(), since it is
> safe to call io_uring_cmd_done() if ubq->nr_io_ready > 0.
> 
> Or others?
It is START_RECOVERY process(or the 'abort_work' you proposed).
It is whatever that calls io_uring_cmd_done() on the old ioucmd
belonging to the dying ubq_daemon.

> 
>> Otherwise, there is a UAF, just as
>> (5804987b7272f437299011c76b7363b8df6f8515: ublk_drv: do not add a
>> re-issued request aborted previously to ioucmd's task_work).
> 
> As I mentioned, del_gendisk() can be replaced with
> blk_mq_quiesce_queue() in case of user recovery, then no any new
> request can be queued after blk_mq_quiesce_queue() returns.

For this, +1.

> 
>>
>> Yeah I know the answer is very simple: flush the fallback wq.
>> But here are two more questions:
> 
> I don't see why we need to flush fallback wq, care to provide some
> details?

Anyway, here is a case:

(1) Assume there is only one tag, only one ubq.

(2) The ublk_io is ACTIVE, which means an ioucmd(cmd_1) is sent from ublksrv
    and ublk_drv has not completed it yet(no io_uring_cmd_done() is called).

(3) New rq is coming, and ublk_queue_rq() is called.

(4) The ublksrv process crashes(PF_EXITING).

(5) io_uring_cmd_complete_in_task(cmd_1) is called in ublk_queue_rq(), and
    cmd_1 is put into a fallback_list.

(6) We want to re-attach a new process and assing a new ioucmd(cmd_2) to ublk_io.

(7) We try to complete the old cmd_1 now by io_uring_cmd_done(cmd_1)...

(8) Shortly after (7), io_uring exit work is scheduled and it finds that no
    inflight iocumd exists, so it starts to release some resources

(9) Shortly after (8), in fallback wq, a null-deref on cmd_1 or ctx->refs may
    happen, just like
    (5804987b7272f437299011c76b7363b8df6f8515: ublk_drv: do not add a
    re-issued request aborted previously to ioucmd's task_work).

If we flush fallback wq before (7), then everything is OKAY.

Why this happens? The root cause is that we do not ALWAYS complete io_uring cmd
in ublk_rq_task_work_cb(). The commit: "ublk_drv: do not add a re-issued request
aborted previously to ioucmd's task_work" does fix a problem. But I think we
really need to refactor ublk_rq_task_work_cb() which focuses on old ioucmd.

> 
>>
>> (1) Should ublk_drv rely on the fallback wq machenism?
>>     IMO, ublk_drv should not know detail of io_uring_cmd_complete_in_task()
>>     because its implementation may change in the future.
>>     BTW, I think current ublk_rq_task_work_cb() is not correct because
>>     it does not always call io_uring_cmd_done() before returning.
>>     nvme_uring_cmd_end_io() always calls io_uring_cmd_done() for each ioucmd
>>     no matter the rq succeeds or fails.
>>
>> (2) Suppose io_uring does export the symbol 'flush_fallback_work', should we call
>>     it before starting a new process(recovery)?
>>     What if fallback wq is not scheduled immediately if there are many processes
>>     running and the system overhead is heavy. In this case the recovery process
>>     may wait for too long. Really we should not depend on fallback wq and please
>>     let the fallback wq complete the ioucmd itself.
>>
>>>
>>> With this way, the current abort logic won't be changed much.
>>>
>>> And user recovery should only be started _after_ ublk device is found
>>> as aborted.
>>
>> START_RECOVERY will check if all ubq_daemons(the process) are PF_EXITING.
> 
> That is different. If START_RECOVERY is only run on aborted device, the
> recovery handler could be simplified.

But stop_dev could become complicated since with recovery enabled, stop_dev
has to do different things. Please see patch 5. Really we do not have to
do anything after the crash until user sends START_RECOVERY or STOP_DEV.

Regards,
Zhang

> 
>>
>>>
>>>>
>>>> The recovery machenism needs to complete all ioucmds of a dying ubq
>>>> to avoid leaking io_uring ctx. But as talked above, we are unsafe
>>>> to call io_uring_cmd_done() in the recovery task if fallback wq happens
>>>> to run simultaneously. This is a UAF case because io_uring ctx may be
>>>> freed. Actually a similar case happens in
>>>> (5804987b7272f437299011c76b7363b8df6f8515: ublk_drv: do not add a
>>>> re-issued request aborted previously to ioucmd's task_work).
>>>
>>> If you take the above approach, I guess there isn't such problem because
>>> abort can handle the case well as before.
>>
>> Ming, we did think this approach(quiesce, requeue rq/complete ioucmd)
>> at the very beginning. But we decided to drop it because we don not want
>> rely on 'flush fallback wq' machenism, which
>> makes ublk_drv rely on io_uring's internal implementation.
> 
> Then the focus is 'flush fallback wq', please see my above question.
> 
> 
> Thanks,
> Ming
