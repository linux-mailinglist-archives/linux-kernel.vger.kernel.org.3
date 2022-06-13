Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EAF548375
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240866AbiFMJhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240304AbiFMJhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:37:42 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A52C1275F;
        Mon, 13 Jun 2022 02:37:41 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LM5vX2ft9z67PMv;
        Mon, 13 Jun 2022 17:32:40 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Mon, 13 Jun 2022 11:37:39 +0200
Received: from [10.195.33.253] (10.195.33.253) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 10:37:38 +0100
Message-ID: <04540488-ec07-3bc2-a997-b7f64b0ba606@huawei.com>
Date:   Mon, 13 Jun 2022 10:40:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH RFC v2 04/18] scsi: core: Add support to send reserved
 commands
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <axboe@kernel.dk>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <brking@us.ibm.com>, <hare@suse.de>,
        <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <chenxiang66@hisilicon.com>
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
 <1654770559-101375-5-git-send-email-john.garry@huawei.com>
 <3f519a72-bb43-b1f0-c85d-a2ea4596f2f2@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <3f519a72-bb43-b1f0-c85d-a2ea4596f2f2@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.33.253]
X-ClientProxiedBy: lhreml746-chm.china.huawei.com (10.201.108.196) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2022 08:03, Damien Le Moal wrote:
>> +	if (shost->nr_reserved_cmds && !sht->reserved_queuecommand) {
>> +		shost_printk(KERN_ERR, shost,
>> +			"nr_reserved_cmds set but no method to queue\n");
>> +		goto fail;
> This would be a driver implementation bug.

It would be a driver bug, but it probably makes the driver utterly 
useless and there is no point in continuing (to try to add). If the 
driver supports reserved commands then they are prob essential to make 
the driver function.

> So what about a WARN() here ?

Maybe but I really do not see a point in continuing

> 
>> +	}
>> +
>>   	/* Use min_t(int, ...) in case shost->can_queue exceeds SHRT_MAX */
>>   	shost->cmd_per_lun = min_t(int, shost->cmd_per_lun,
>>   				   shost->can_queue);
>> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
>> index f6e53c6d913c..8c8b4c6767d9 100644
>> --- a/drivers/scsi/scsi_lib.c
>> +++ b/drivers/scsi/scsi_lib.c
>> @@ -1422,6 +1422,16 @@ static void scsi_complete(struct request *rq)
>>   	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(rq);
>>   	enum scsi_disposition disposition;
>>   
>> +	if (scsi_is_reserved_cmd(cmd)) {
>> +		struct scsi_device *sdev = cmd->device;
>> +
>> +		scsi_mq_uninit_cmd(cmd);
>> +		scsi_device_unbusy(sdev, cmd);
>> +		__blk_mq_end_request(rq, 0);
>> +
>> +		return;
>> +	}
>> +
>>   	INIT_LIST_HEAD(&cmd->eh_entry);
>>   
>>   	atomic_inc(&cmd->device->iodone_cnt);
>> @@ -1706,6 +1716,28 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
>>   
>>   	WARN_ON_ONCE(cmd->budget_token < 0);
>>   
>> +	if (scsi_is_reserved_cmd(cmd)) {
>> +		unsigned char *host_scribble = cmd->host_scribble;
>> +
>> +		if (!(req->rq_flags & RQF_DONTPREP)) {
>> +			ret = scsi_prepare_cmd(req);
>> +			if (ret != BLK_STS_OK) {
>> +
> Stray blank line.

ok

> 
>> +				goto out_dec_host_busy;
>> +			}
> No need for the curly brackets here.

ok

> 
>> +
>> +			req->rq_flags |= RQF_DONTPREP;
>> +		} else {
>> +			clear_bit(SCMD_STATE_COMPLETE, &cmd->state);
>> +		}

Thanks,
John
