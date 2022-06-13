Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E2C548394
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240140AbiFMJlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiFMJlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:41:46 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CEA1835B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655113304; x=1686649304;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Dbh1Kt5aUfTddv+3/ts//tbVw7s2v0khnv5lCRcvwwk=;
  b=KIZ4rBIML6aR7yPaJUFzh869T8bIv6CbQKq1pBFjRstmUrO8asSA4NHL
   Zxablbl21p2hF5sEPVm/u7aWQ+UrsmXyBfIQ8Y80MkGc3b74TbXH6u6cT
   U02+3jVfv+c7Uv2J3/IaDbBE1d2dgWIEHxE+931k5iCpqTVGcuhY5/tkG
   s7D/4iT31Tii5QC2obVuVz2Ph0B9F5atkGmyA9nO9/cn1vk0lo34j1y/I
   WaCUggvp1beSqpsceLpyeoiJWJpd0zIrE8aLWBNYEpOnFDxdDWCRoHi+n
   YQKOPQQq/RhTGwI+YEeFJO9OH6nga/Q4Orh7SauAgvp6Yra2v/so5eu7F
   A==;
X-IronPort-AV: E=Sophos;i="5.91,297,1647273600"; 
   d="scan'208";a="202984733"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2022 17:41:42 +0800
IronPort-SDR: 1bwGAAb1sidgyaZP8Zwp2xcKHoYl6Q52y2dVp1GDE9vs15YGtszBLp3ZUPRWqsxO34Auqu8PTW
 hxMLhiKLEVlsZ9/liZVbJJ1IawBYo/3X3MIIayQwF4Pmb2c9JO0mzuSyXzUsIL4fPQZFyrSQUY
 wwfUOWfEo/aNq48af/rfRtu9CLz5V+N/ffwPy/WYyQ0V8gTIf6tFJ3zlgKyLKyTyK+UIF56KWA
 xFVOSiJsyq9Zy2t1Y1JMALsaMTOJ2GNpvxijrbQdq8hp+tUHxlfABKHBNG9bVZ4wEPow8v43oG
 zKBM6HZMKqka9+HfuwPGcyz1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jun 2022 02:00:23 -0700
IronPort-SDR: +a4mpC1xG4CCidh8NSreLZHKolgi8+NXFiWRtlFOZm1hrBocDza7Pxh+khlAO8WKQmFILHhmll
 bc544oId8i3wHeU8WOYvxAY7W0zYhdeSEdG6QrnR02S2ISz7OBi7HEhU431z9wb5IdmOG7jdn5
 vN0HkbDrdQyzAIwzxjPgc2Rbrhmrx7FOG0MllSEcJ487tjGg8iRInMPUuzUUJ71lCPHcwggSrN
 PQoYfOb/7I2faUsZv47yK+c95+KitQOWSS8ruF7PLhZQzbvGgN3ZjjP3DEdi5yJ/TBIOfb6CEA
 vcA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jun 2022 02:41:44 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LM65z0vV8z1SVp5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:41:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655113302; x=1657705303; bh=Dbh1Kt5aUfTddv+3/ts//tbVw7s2v0khnv5
        lCRcvwwk=; b=EIpF+MMSIejYQTyI5waxEUsC18jDjhptW2HHjDnGKSY8YQIn0Gg
        7l9ZbAN+5GMKXMZoMq7gjz7rs6oLfD58A/5z6t72tmfT2Y4Z5IprwO1FNpDOkUkM
        uIlInTwpt9TqkmCfF7Ju61+E6QGPQSyUw30J4C+l3tAyIXG/k8DVIFNN4Rvik0lX
        9FPMgTDJGcHf9YN6cBSKHmqxRZmGSSsJhr5Ju2EwVn4WdRXJJOxOc08XTAllwfJe
        Xgj+qxAj+IdREV2IiwK8jPUEKL3Qb/ypK0YHRRSSx224u/KrzYy4HDFPFgXBp14V
        WmbkEWzeMLLV8pijW75ckRMevm7bj7KMcyw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fzkqt-RwRvHC for <linux-kernel@vger.kernel.org>;
        Mon, 13 Jun 2022 02:41:42 -0700 (PDT)
Received: from [10.225.163.77] (unknown [10.225.163.77])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LM65w237Bz1Rvlc;
        Mon, 13 Jun 2022 02:41:40 -0700 (PDT)
Message-ID: <9b55ae8d-30be-ff70-85e0-61616e18f18a@opensource.wdc.com>
Date:   Mon, 13 Jun 2022 18:41:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RFC v2 04/18] scsi: core: Add support to send reserved
 commands
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com, brking@us.ibm.com,
        hare@suse.de, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        chenxiang66@hisilicon.com
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
 <1654770559-101375-5-git-send-email-john.garry@huawei.com>
 <3f519a72-bb43-b1f0-c85d-a2ea4596f2f2@opensource.wdc.com>
 <04540488-ec07-3bc2-a997-b7f64b0ba606@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <04540488-ec07-3bc2-a997-b7f64b0ba606@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/22 18:40, John Garry wrote:
> On 13/06/2022 08:03, Damien Le Moal wrote:
>>> +	if (shost->nr_reserved_cmds && !sht->reserved_queuecommand) {
>>> +		shost_printk(KERN_ERR, shost,
>>> +			"nr_reserved_cmds set but no method to queue\n");
>>> +		goto fail;
>> This would be a driver implementation bug.
> 
> It would be a driver bug, but it probably makes the driver utterly 
> useless and there is no point in continuing (to try to add). If the 
> driver supports reserved commands then they are prob essential to make 
> the driver function.
> 
>> So what about a WARN() here ?
> 
> Maybe but I really do not see a point in continuing

Completely agree. My suggestion is to replace the regular shost_printk()
error message with something "heavier" like WARN(). Since that is not an
expected error. Even a BUG_ON() may be acceptable :)

> 
>>
>>> +	}
>>> +
>>>   	/* Use min_t(int, ...) in case shost->can_queue exceeds SHRT_MAX */
>>>   	shost->cmd_per_lun = min_t(int, shost->cmd_per_lun,
>>>   				   shost->can_queue);
>>> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
>>> index f6e53c6d913c..8c8b4c6767d9 100644
>>> --- a/drivers/scsi/scsi_lib.c
>>> +++ b/drivers/scsi/scsi_lib.c
>>> @@ -1422,6 +1422,16 @@ static void scsi_complete(struct request *rq)
>>>   	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(rq);
>>>   	enum scsi_disposition disposition;
>>>   
>>> +	if (scsi_is_reserved_cmd(cmd)) {
>>> +		struct scsi_device *sdev = cmd->device;
>>> +
>>> +		scsi_mq_uninit_cmd(cmd);
>>> +		scsi_device_unbusy(sdev, cmd);
>>> +		__blk_mq_end_request(rq, 0);
>>> +
>>> +		return;
>>> +	}
>>> +
>>>   	INIT_LIST_HEAD(&cmd->eh_entry);
>>>   
>>>   	atomic_inc(&cmd->device->iodone_cnt);
>>> @@ -1706,6 +1716,28 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
>>>   
>>>   	WARN_ON_ONCE(cmd->budget_token < 0);
>>>   
>>> +	if (scsi_is_reserved_cmd(cmd)) {
>>> +		unsigned char *host_scribble = cmd->host_scribble;
>>> +
>>> +		if (!(req->rq_flags & RQF_DONTPREP)) {
>>> +			ret = scsi_prepare_cmd(req);
>>> +			if (ret != BLK_STS_OK) {
>>> +
>> Stray blank line.
> 
> ok
> 
>>
>>> +				goto out_dec_host_busy;
>>> +			}
>> No need for the curly brackets here.
> 
> ok
> 
>>
>>> +
>>> +			req->rq_flags |= RQF_DONTPREP;
>>> +		} else {
>>> +			clear_bit(SCMD_STATE_COMPLETE, &cmd->state);
>>> +		}
> 
> Thanks,
> John


-- 
Damien Le Moal
Western Digital Research
