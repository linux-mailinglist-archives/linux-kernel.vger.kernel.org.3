Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F095A4304
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 08:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiH2GNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 02:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiH2GNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 02:13:20 -0400
Received: from out199-8.us.a.mail.aliyun.com (out199-8.us.a.mail.aliyun.com [47.90.199.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D591048C9C;
        Sun, 28 Aug 2022 23:13:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VNXnBDh_1661753593;
Received: from 30.97.56.171(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VNXnBDh_1661753593)
          by smtp.aliyun-inc.com;
          Mon, 29 Aug 2022 14:13:14 +0800
Message-ID: <35dd7300-12ea-62ba-393e-145eae318944@linux.alibaba.com>
Date:   Mon, 29 Aug 2022 14:13:12 +0800
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
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <YwxRVEQlIw3oWmwE@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/29 13:40, Ming Lei wrote:
> On Wed, Aug 24, 2022 at 01:47:39PM +0800, ZiyangZhang wrote:
>> If one rq is handled by io_uring_cmd_complete_in_task(), after a crash
>> this rq is actually handled by an io_uring fallback wq. We have to
>> end(abort) this rq since this fallback wq is a task other than the
>> crashed task. However, current code does not call io_uring_cmd_done()
>> at the same time but do it in ublk_cancel_queue(). With current design,
>> this does work because ublk_cancel_queue() is called AFTER del_gendisk(),
>> which waits for the rq ended(aborted) in fallback wq. This implies that
>> fallback wq on this rq is scheduled BEFORE calling io_uring_cmd_done()
>> on the corresponding ioucmd in ublk_cancel_queue().
> 
> Right.
> 
>>
>> However, while considering recovery feature, we cannot rely on
>> del_gendisk() or blk_mq_freeze_queue() to wait for completion of all
>> rqs because we may not want any aborted rq. Besides, io_uring does not
>> provide "flush fallback" machenism so we cannot trace this ioucmd.
> 
> Why not?
> 
> If user recovery is enabled, del_gendisk() can be replaced with
> blk_mq_quiesce_queue(), then let abort work function do:
> 
> - cancel all in-flight requests by holding them into requeue list
>   instead of finishing them as before, and this way is safe because
>   abort worker does know the ubq daemon is dying
> - cancel pending commands as before, because the situation is same
>   with disk deleted or queue frozen

The problem is: we cannot control when fallback wq is scheduled.
So we are unsafe to call io_uring_cmd_done() in another process.
Otherwise, there is a UAF, just as
(5804987b7272f437299011c76b7363b8df6f8515: ublk_drv: do not add a
re-issued request aborted previously to ioucmd's task_work).

Yeah I know the answer is very simple: flush the fallback wq.
But here are two more questions:

(1) Should ublk_drv rely on the fallback wq machenism?
    IMO, ublk_drv should not know detail of io_uring_cmd_complete_in_task()
    because its implementation may change in the future.
    BTW, I think current ublk_rq_task_work_cb() is not correct because
    it does not always call io_uring_cmd_done() before returning.
    nvme_uring_cmd_end_io() always calls io_uring_cmd_done() for each ioucmd
    no matter the rq succeeds or fails.

(2) Suppose io_uring does export the symbol 'flush_fallback_work', should we call
    it before starting a new process(recovery)?
    What if fallback wq is not scheduled immediately if there are many processes
    running and the system overhead is heavy. In this case the recovery process
    may wait for too long. Really we should not depend on fallback wq and please
    let the fallback wq complete the ioucmd itself.

> 
> With this way, the current abort logic won't be changed much.
> 
> And user recovery should only be started _after_ ublk device is found
> as aborted.

START_RECOVERY will check if all ubq_daemons(the process) are PF_EXITING.

> 
>>
>> The recovery machenism needs to complete all ioucmds of a dying ubq
>> to avoid leaking io_uring ctx. But as talked above, we are unsafe
>> to call io_uring_cmd_done() in the recovery task if fallback wq happens
>> to run simultaneously. This is a UAF case because io_uring ctx may be
>> freed. Actually a similar case happens in
>> (5804987b7272f437299011c76b7363b8df6f8515: ublk_drv: do not add a
>> re-issued request aborted previously to ioucmd's task_work).
> 
> If you take the above approach, I guess there isn't such problem because
> abort can handle the case well as before.

Ming, we did think this approach(quiesce, requeue rq/complete ioucmd)
at the very beginning. But we decided to drop it because we don not want
rely on 'flush fallback wq' machenism, which
makes ublk_drv rely on io_uring's internal implementation.

> 
>>
>> Besides, in order to implement recovery machenism, in ublk_queue_rq()
>> and __ublk_rq_task_work(), we should not end(abort) current rq while
>> ubq_daemon is dying.
> 
> Right, I believe one helper of ublk_abort_request() is helpful here.
> 
> 
> Thanks, 
> Ming
