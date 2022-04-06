Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAF74F5F75
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbiDFNSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbiDFNSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:18:01 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00850612F02;
        Wed,  6 Apr 2022 02:56:10 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KYKFv47H7zgYRC;
        Wed,  6 Apr 2022 17:38:43 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 6 Apr 2022 17:40:21 +0800
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 6 Apr 2022 17:40:26 +0800
Subject: Re: [REQUEST DISCUSS]: speed up SCSI error handle for host with
 massive devices
To:     Mike Christie <michael.christie@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Steffen Maier <maier@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Lee Duncan <lduncan@suse.com>,
        John Garry <john.garry@huawei.com>
CC:     Wu Bo <wubo40@huawei.com>, Feilong Lin <linfeilong@huawei.com>,
        <zhangjian013@huawei.com>
References: <71e09bb4-ff0a-23fe-38b4-fe6425670efa@huawei.com>
 <cd7bda98-2160-9271-9520-e98d1fe00ea5@linux.ibm.com>
 <331aafe1-df9b-cae4-c958-9cf1800e389a@huawei.com>
 <64d5a997-a1bf-7747-072d-711a8248874d@suse.de>
 <c4baacf1-0e86-9660-45f7-50ebc853e6af@huawei.com>
 <1dd69d03-b4f6-ab20-4923-0995b40f045d@suse.de>
 <d2f2c89f-c048-4f04-4d95-27958f0fa46a@huawei.com>
 <78d41ec1-b30c-f6d2-811c-e0e4adbc8f01@oracle.com>
From:   Wenchao Hao <haowenchao@huawei.com>
Message-ID: <fd42ea1d-7b77-ba67-4dd6-7f5caac1c703@huawei.com>
Date:   Wed, 6 Apr 2022 17:40:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <78d41ec1-b30c-f6d2-811c-e0e4adbc8f01@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/4 1:14, Mike Christie wrote:
> On 3/30/22 5:59 AM, Wenchao Hao wrote:
>> On 2022/3/30 17:32, Hannes Reinecke wrote:
>>> On 3/30/22 11:11, Wenchao Hao wrote:
>>>> On 2022/3/30 2:56, Hannes Reinecke wrote:
>>>>> On 3/29/22 14:40, Wenchao Hao wrote:
>>>>>> On 2022/3/29 18:56, Steffen Maier wrote:
>>>>>>> On 3/29/22 11:06, Wenchao Hao wrote:
>>>>>>>> SCSI timeout would call scsi_eh_scmd_add() on some conditions, host would be set
>>>>>>>> to SHOST_RECOVERY state. Once host enter SHOST_RECOVERY, IOs submitted to all
>>>>>>>> devices in this host would not succeed until the scsi_error_handler() finished.
>>>>>>>> The scsi_error_handler() might takes long time to be done, it's unbearable when
>>>>>>>> host has massive devices.
>>>>>>>>
>>>>>>>> I want to ask is anyone applying another error handler flow to address this
>>>>>>>> phenomenon?
>>>>>>>>
>>>>>>>> I think we can move some operations(like scsi get sense, scsi send startunit
>>>>>>>> and scsi device reset) out of scsi_unjam_host(), to perform these operations
>>>>>>>> without setting host to SHOST_RECOVERY? It would reduce the time of block the
>>>>>>>> whole host.
>>>>>>>>
>>>>>>>> Waiting for your discussion.
>>>>>>>
>>>>>>> We already have "async" aborts before even entering scsi_eh. So your use case seems to imply that those aborts fail and we enter scsi_eh?
>>>>>>>
>>>>>>
>>>>>> Yes, I mean when scsi_abort_command() failed and scsi_eh_scmd_add() is called.
>>>>>>
>>>>>>> There's eh_deadline for limiting the time spent in escalation of scsi_eh, and instead directly go to host reset. Would this help?
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> The deadline seems not helpful. What we want to see is a single LUN's command error
>>>>>> would not stop other LUNs which share the same host. So my plan is to move reset LUN out
>>>>>> from scsi_unjam_host() which run with host set to SHOST_RECOVERY.
>>>>>
>>>>> Nope. One of the key points of scsi_unjam_host() is that is has to stop all I/O before proceeding. Without doing so basically all SCSI parallel HBAs will fail EH as they _require_ I/O to be stopped.
>>>>>
>>>>
>>>> I still can not understand why we must stop all I/O. In my comprehension, stopping all I/O
>>>> is because we might reset host during scsi_error_handler() and we must wait host's number of
>>>> failed command equal to number of busy command then we can wake up scsi_error_handler().
>>>>
>>>> If move reset LUN out of scsi_error_handler(), and perform single LUN reset, we only need
>>>> stop I/O of this single LUN, this would not affect other LUNs. If single LUN reset failed,
>>>> we can then call in the large scale error handle.
>>>>
>>> I know the EH flow.
>>>
>>> Problem here is the way parallel SCSI operates. Remember, parallel SCSI is a _bus_, and there can be only one command at a time on the bus.
>>> So if one command on the bus misfires and you have to start EH you have to stop all I/O on the bus to ensure that your EH command is the only one active on the bus.
>>>
>>
>> Thank you for you explanation, it's clear to me now.
>>
>>> For modern HBAs we sure can device other ways and means of error recovery, but I can't really see how we would do that on legacy HBAs.
>>>
>>
>> How about define a new return value of scsi_host_template's eh_timed_out callback which indicate this timeout
>> is totally handled by LLDs. Like following:
>>
>> --- a/drivers/scsi/scsi_error.c
>> +++ b/drivers/scsi/scsi_error.c
>> @@ -359,6 +359,8 @@ enum blk_eh_timer_return scsi_times_out(struct request *req)
>>                         set_host_byte(scmd, DID_TIME_OUT);
>>                         scsi_eh_scmd_add(scmd);
>>                 }
>> +       } else if (rtn == EH_HANDLED_BY_DRIVERS) {
>> +               return BLK_EH_DONE;
>>         }
>>
>> Or scsi_host_template's eh_timed_out should not do this, we can define another callback?
>> In the LLDs's timeout handler callback, apply single LUN reset first flow as previous mail metioned.
>>
> 
> You probably want to add a scsi_host_template field or new callouts
> because some drivers only preallocate enough resources for one TMF
> at a time so we have to do it on a driver by driver basis.
> 
> For driver's setting/implementing it then to escalate you can do something
> like:
> 
> 1. Block the queue for just the LU with scsi_internal_device_block.
> 2. You can then call the new callout or old one if we just added some
> new field.
> 3. If device/lun reset fails, then block the target. Then you can do
> the host.
> 

Thanks a lot for your guide. I want to wait hannes's change.

> We could share code with scsi_ioctl_reset as well. Drivers that support
> TMFs via that ioctl already expect queuecommand to be possibly in the
> middle of a run and IO not yet timed out. For example, the code to
> block a queue and reset the device could be used for the new EH and
> SG_SCSI_RESET_DEVICE handling.
> 
> 
> 
>> Anyway, what we need is a way to reduce the time of setting host to SHOST_RECOVERY.
>>
>>>> Here is a brief flow:
>>>>
>>>> abort command
>>>>     ||
>>>>     || failed
>>>>     ||
>>>>     \/
>>>> stop single LUN's I/O (need to wait LUN's failed command number equal to busy command  number)
>>>>     ||
>>>>     || failed  (according to our statistic, 90% reset LUN would succeed)
>>>>     ||
>>>>     \/
>>>
>>> Interesting. This does not match up with my experience, where 99% of the errors were due to a command timeout.
>>>
>>> So which errors do you see here? What are the causes?
>>
>> These error statistic are from our consumers' environment,they told me about 90% timeout triggered errors can be
>> handled by reset LUN.
>>
> 
> Is this with specific drivers, transport or targets?
> .
> 

Yes, it's based on specific hardware. Details about the statistic seems secret which can not send out.
