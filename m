Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634F64F5B11
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245441AbiDFKgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 06:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236518AbiDFKfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 06:35:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC14D4B47B9;
        Tue,  5 Apr 2022 23:56:34 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KYFcm6f5rzgYLw;
        Wed,  6 Apr 2022 14:54:48 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 6 Apr 2022 14:56:33 +0800
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 6 Apr 2022 14:56:32 +0800
From:   Wenchao Hao <haowenchao@huawei.com>
Subject: Re: [PATCH] scsi: core: always finish successfully aborted notry
 command
To:     Mike Christie <michael.christie@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>
References: <20220401035020.1043239-1-haowenchao@huawei.com>
 <775f75db-edb8-8f39-2592-862756811710@oracle.com>
Message-ID: <275178ca-1fe4-b00b-c1f4-c8c34e7f4686@huawei.com>
Date:   Wed, 6 Apr 2022 14:56:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <775f75db-edb8-8f39-2592-862756811710@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/4 0:58, Mike Christie wrote:
> On 3/31/22 10:50 PM, Wenchao Hao wrote:
>> If the abort command succeed and it does not need to be retired, do not add
>> it to error handle list. 
>>
>> Adding command to error handle list is an annoying flow which would stop I/O
>> of all LUNs which shared a same HBA.
>>
>> So here if we successfully abort a command, we can finish it via
>> scsi_finish_command() which would reduce time spent on scsi_error_handler()
>>
>> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
>> ---
>>  drivers/scsi/scsi_error.c | 55 +++++++++++++++++++++------------------
>>  1 file changed, 29 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
>> index cdaca13ac1f1..15299603b7ee 100644
>> --- a/drivers/scsi/scsi_error.c
>> +++ b/drivers/scsi/scsi_error.c
>> @@ -173,41 +173,44 @@ scmd_eh_abort_handler(struct work_struct *work)
>>  		goto out;
>>  	}
>>  	set_host_byte(scmd, DID_TIME_OUT);
>> -	if (scsi_host_eh_past_deadline(shost)) {
>> -		SCSI_LOG_ERROR_RECOVERY(3,
>> -			scmd_printk(KERN_INFO, scmd,
>> -				    "eh timeout, not retrying "
>> -				    "aborted command\n"));
>> -		goto out;
>> -	}
>>  
>> -	spin_lock_irqsave(shost->host_lock, flags);
>> -	list_del_init(&scmd->eh_entry);
>> +	if (scsi_noretry_cmd(scmd) ||
>> +	    !scsi_cmd_retry_allowed(scmd) &&
>> +	    !scsi_eh_should_retry_cmd(scmd)) {
> 
> 
> I don't think this test is correct. Did you want all ||s?

Sorry, I made a mistake, it should be "||" here.

> 
> For what the patch is trying to accomplish I'm not sure if it's
> the behavior people wanted. Do all drivers have configurable
> abort timeouts? If an abort takes N minutes to complete ok,
> and that's put us over the eh deadline maybe the user wanted
> that device to be offlined.
> .
> 

I think the changes would not affect the timeouts and deadline
because the logic changed is after command abort successfully.

We check if the command need to be retired after aborting command
successfully, if it does not need to retry, just finish it (only
commands aborted failed should be add to error handle list).

I submit this change because we want to reduce the time spent on 
scsi_error_handler().

Do you think the change is OK? Except previous wrong "&&" which should
be "||".

Thanks, looking forward to hearing from you.
