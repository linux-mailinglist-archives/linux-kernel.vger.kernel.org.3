Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A45532027
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 03:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbiEXBH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 21:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiEXBHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 21:07:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6FE45AFA;
        Mon, 23 May 2022 18:07:52 -0700 (PDT)
Received: from kwepemi100022.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L6bd91NKdzjX1W;
        Tue, 24 May 2022 09:06:53 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100022.china.huawei.com (7.221.188.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 09:07:50 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 09:07:50 +0800
Subject: Re: [PATCH -next v3 3/6] nbd: don't clear 'NBD_CMD_INFLIGHT' flag if
 request is not completed
To:     Josef Bacik <josef@toxicpanda.com>
CC:     <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220521073749.3146892-1-yukuai3@huawei.com>
 <20220521073749.3146892-4-yukuai3@huawei.com>
 <YouWXEcyoBNUXLb7@localhost.localdomain>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <6a549193-909b-6f6e-532b-99cd2898ad80@huawei.com>
Date:   Tue, 24 May 2022 09:07:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YouWXEcyoBNUXLb7@localhost.localdomain>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2022/05/23 22:12, Josef Bacik Ð´µÀ:
> On Sat, May 21, 2022 at 03:37:46PM +0800, Yu Kuai wrote:
>> Otherwise io will hung because request will only be completed if the
>> cmd has the flag 'NBD_CMD_INFLIGHT'.
>>
>> Fixes: 07175cb1baf4 ("nbd: make sure request completion won't concurrent")
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/block/nbd.c | 18 ++++++++++++++----
>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index 2ee1e376d5c4..a0d0910dae2a 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -403,13 +403,14 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
>>   	if (!mutex_trylock(&cmd->lock))
>>   		return BLK_EH_RESET_TIMER;
>>   
>> -	if (!__test_and_clear_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
>> +	if (!test_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
>>   		mutex_unlock(&cmd->lock);
>>   		return BLK_EH_DONE;
>>   	}
>>   
>>   	if (!refcount_inc_not_zero(&nbd->config_refs)) {
>>   		cmd->status = BLK_STS_TIMEOUT;
>> +		__clear_bit(NBD_CMD_INFLIGHT, &cmd->flags);
>>   		mutex_unlock(&cmd->lock);
>>   		goto done;
>>   	}
>> @@ -478,6 +479,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
>>   	dev_err_ratelimited(nbd_to_dev(nbd), "Connection timed out\n");
>>   	set_bit(NBD_RT_TIMEDOUT, &config->runtime_flags);
>>   	cmd->status = BLK_STS_IOERR;
>> +	__clear_bit(NBD_CMD_INFLIGHT, &cmd->flags);
>>   	mutex_unlock(&cmd->lock);
>>   	sock_shutdown(nbd);
>>   	nbd_config_put(nbd);
>> @@ -745,7 +747,7 @@ static struct nbd_cmd *nbd_handle_reply(struct nbd_device *nbd, int index,
>>   	cmd = blk_mq_rq_to_pdu(req);
>>   
>>   	mutex_lock(&cmd->lock);
>> -	if (!__test_and_clear_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
>> +	if (!test_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
>>   		dev_err(disk_to_dev(nbd->disk), "Suspicious reply %d (status %u flags %lu)",
>>   			tag, cmd->status, cmd->flags);
>>   		ret = -ENOENT;
>> @@ -854,8 +856,16 @@ static void recv_work(struct work_struct *work)
>>   		}
>>   
>>   		rq = blk_mq_rq_from_pdu(cmd);
>> -		if (likely(!blk_should_fake_timeout(rq->q)))
>> -			blk_mq_complete_request(rq);
>> +		if (likely(!blk_should_fake_timeout(rq->q))) {
>> +			bool complete;
>> +
>> +			mutex_lock(&cmd->lock);
>> +			complete = __test_and_clear_bit(NBD_CMD_INFLIGHT,
>> +							&cmd->flags);
>> +			mutex_unlock(&cmd->lock);
>> +			if (complete)
>> +				blk_mq_complete_request(rq);
>> +		}
> 
> I'd rather this be handled in nbd_handle_reply.  We should return with it
> cleared if it's ready to be completed.  Thanks,
Hi,

Thanks for your advice, I'll do that in next version. I'll still have to
hold the lock to set the bit again in case blk_should_fake_timeout()
pass...

Thanks,
Kuai
> 
> Josef
> .
> 
