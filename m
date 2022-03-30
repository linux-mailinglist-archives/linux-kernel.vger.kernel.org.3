Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B265F4EBD59
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244654AbiC3JNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238507AbiC3JNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:13:37 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8864321DF25;
        Wed, 30 Mar 2022 02:11:52 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KT0xY4XpTzDq8l;
        Wed, 30 Mar 2022 17:09:37 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 30 Mar 2022 17:11:37 +0800
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 30 Mar 2022 17:11:36 +0800
Subject: Re: [REQUEST DISCUSS]: speed up SCSI error handle for host with
 massive devices
To:     Hannes Reinecke <hare@suse.de>,
        Steffen Maier <maier@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        Lee Duncan <lduncan@suse.com>
CC:     Wu Bo <wubo40@huawei.com>, Feilong Lin <linfeilong@huawei.com>,
        <zhangjian013@huawei.com>, Wenchao Hao <haowenchao@huawei.com>
References: <71e09bb4-ff0a-23fe-38b4-fe6425670efa@huawei.com>
 <cd7bda98-2160-9271-9520-e98d1fe00ea5@linux.ibm.com>
 <331aafe1-df9b-cae4-c958-9cf1800e389a@huawei.com>
 <64d5a997-a1bf-7747-072d-711a8248874d@suse.de>
From:   Wenchao Hao <haowenchao@huawei.com>
Message-ID: <c4baacf1-0e86-9660-45f7-50ebc853e6af@huawei.com>
Date:   Wed, 30 Mar 2022 17:11:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <64d5a997-a1bf-7747-072d-711a8248874d@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/30 2:56, Hannes Reinecke wrote:
> On 3/29/22 14:40, Wenchao Hao wrote:
>> On 2022/3/29 18:56, Steffen Maier wrote:
>>> On 3/29/22 11:06, Wenchao Hao wrote:
>>>> SCSI timeout would call scsi_eh_scmd_add() on some conditions, host would be set
>>>> to SHOST_RECOVERY state. Once host enter SHOST_RECOVERY, IOs submitted to all
>>>> devices in this host would not succeed until the scsi_error_handler() finished.
>>>> The scsi_error_handler() might takes long time to be done, it's unbearable when
>>>> host has massive devices.
>>>>
>>>> I want to ask is anyone applying another error handler flow to address this
>>>> phenomenon?
>>>>
>>>> I think we can move some operations(like scsi get sense, scsi send startunit
>>>> and scsi device reset) out of scsi_unjam_host(), to perform these operations
>>>> without setting host to SHOST_RECOVERY? It would reduce the time of block the
>>>> whole host.
>>>>
>>>> Waiting for your discussion.
>>>
>>> We already have "async" aborts before even entering scsi_eh. So your use case seems to imply that those aborts fail and we enter scsi_eh?
>>>
>>
>> Yes, I mean when scsi_abort_command() failed and scsi_eh_scmd_add() is called.
>>
>>> There's eh_deadline for limiting the time spent in escalation of scsi_eh, and instead directly go to host reset. Would this help?
>>>
>>>
>>
>> The deadline seems not helpful. What we want to see is a single LUN's command error
>> would not stop other LUNs which share the same host. So my plan is to move reset LUN out
>> from scsi_unjam_host() which run with host set to SHOST_RECOVERY.
> 
> Nope. One of the key points of scsi_unjam_host() is that is has to stop all I/O before proceeding. Without doing so basically all SCSI parallel HBAs will fail EH as they _require_ I/O to be stopped.
> 

I still can not understand why we must stop all I/O. In my comprehension, stopping all I/O
is because we might reset host during scsi_error_handler() and we must wait host's number of
failed command equal to number of busy command then we can wake up scsi_error_handler(). 

If move reset LUN out of scsi_error_handler(), and perform single LUN reset, we only need
stop I/O of this single LUN, this would not affect other LUNs. If single LUN reset failed,
we can then call in the large scale error handle.

Here is a brief flow:

abort command
   ||
   || failed
   || 
   \/
stop single LUN's I/O (need to wait LUN's failed command number equal to busy command  number)
   ||
   || failed  (according to our statistic, 90% reset LUN would succeed)
   ||
   \/
stop all LUN's I/O (stage to call in origin error handler)
   ||
   ||
   ||
   \/
wait host's failed command number equal to busy command number
   ||
   ||
   ||
   \/
perform target reset, bus reset and host reset and so on. (do not need to reset LUN since it already failed)

As mentioned, we can reduce the time of setting host to SHOST_RECOVERY which would stop all I/Os.


How do you think? I look forward to hearing from you.
