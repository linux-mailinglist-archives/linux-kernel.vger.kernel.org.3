Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D415A4209
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 06:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiH2Eue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 00:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiH2Euc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 00:50:32 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6B025C5B;
        Sun, 28 Aug 2022 21:50:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VNWpuCO_1661748626;
Received: from 30.97.56.171(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VNWpuCO_1661748626)
          by smtp.aliyun-inc.com;
          Mon, 29 Aug 2022 12:50:27 +0800
Message-ID: <a744992d-e222-6cb9-812a-0759f7d359e5@linux.alibaba.com>
Date:   Mon, 29 Aug 2022 12:50:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [RFC PATCH 2/9] ublk_drv: refactor ublk_cancel_queue()
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
References: <20220824054744.77812-1-ZiyangZhang@linux.alibaba.com>
 <20220824054744.77812-3-ZiyangZhang@linux.alibaba.com>
 <Ywwr9wWI4Hf06fMD@T590>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <Ywwr9wWI4Hf06fMD@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/29 11:01, Ming Lei wrote:
> On Wed, Aug 24, 2022 at 01:47:37PM +0800, ZiyangZhang wrote:
>> Assume only a few FETCH_REQ ioucmds are sent to ublk_drv, then the
>> ubq_daemon exits, We have to call io_uring_cmd_done() for all ioucmds
>> received so that io_uring ctx will not leak.
>>
>> ublk_cancel_queue() may be called before START_DEV or after STOP_DEV,
>> we decrease ubq->nr_io_ready and clear UBLK_IO_FLAG_ACTIVE so that we
>> won't call io_uring_cmd_done() twice for one ioucmd to avoid UAF. Also
>> clearing UBLK_IO_FLAG_ACTIVE makes the code more reasonable.
>>
>> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
>> ---
>>  drivers/block/ublk_drv.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>> index c39b67d7133d..e08f636b0b9d 100644
>> --- a/drivers/block/ublk_drv.c
>> +++ b/drivers/block/ublk_drv.c
>> @@ -967,18 +967,23 @@ static void ublk_cancel_queue(struct ublk_queue *ubq)
>>  {
>>  	int i;
>>  
>> -	if (!ublk_queue_ready(ubq))
>> +	if (!ubq->nr_io_ready)
>>  		return;
>>  
>>  	for (i = 0; i < ubq->q_depth; i++) {
>>  		struct ublk_io *io = &ubq->ios[i];
>>  
>> -		if (io->flags & UBLK_IO_FLAG_ACTIVE)
>> +		if (io->flags & UBLK_IO_FLAG_ACTIVE) {
>> +			pr_devel("%s: done old cmd: qid %d tag %d\n",
>> +					__func__, ubq->q_id, i);
>>  			io_uring_cmd_done(io->cmd, UBLK_IO_RES_ABORT, 0);
>> +			io->flags &= ~UBLK_IO_FLAG_ACTIVE;
>> +			ubq->nr_io_ready--;
>> +		}
>>  	}
>>  
>>  	/* all io commands are canceled */
>> -	ubq->nr_io_ready = 0;
>> +	WARN_ON_ONCE(ubq->nr_io_ready);
> 
> The change looks fine, but suggest to add comment like the
> following given the above WARN_ON_ONCE() change isn't obvious.
> 
> ```
> 1) ublk_cancel_dev() is called before sending START_DEV(), ->mutex
> provides protection on above update.
> 
> 2) ublk_cancel_dev() is called after sending START_DEV(), disk is
> deleted first, UBLK_IO_RES_ABORT is returned so that any new io
> command can't be issued to driver, so updating on io flags and
> nr_io_ready is safe here
> 
> Also ->nr_io_ready is guaranteed to become zero after ublk_cance_queue
> returns since request queue is either frozen or not present in both two cases.
> 
> ```
> 

Thanks for your advice, Ming.

Regards,
Zhang

