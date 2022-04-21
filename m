Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD94350A3D8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389966AbiDUPVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiDUPVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:21:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547A638DBF;
        Thu, 21 Apr 2022 08:18:21 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kkh4h2c9RzhXw6;
        Thu, 21 Apr 2022 23:18:12 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 23:18:19 +0800
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 23:18:19 +0800
Message-ID: <b61cd444-ff43-4b4a-20f7-033800d1b48a@huawei.com>
Date:   Thu, 21 Apr 2022 23:18:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] scsi: iscsi: Fix multiple iscsi session unbind event
 sent to userspace
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>
References: <20220418000627.474784-1-haowenchao@huawei.com>
 <938bca13-2dcc-24c0-51b5-26f7e7238776@oracle.com>
From:   Wenchao Hao <haowenchao@huawei.com>
In-Reply-To: <938bca13-2dcc-24c0-51b5-26f7e7238776@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/21 0:28, Mike Christie wrote:
> On 4/17/22 7:06 PM, Wenchao Hao wrote:
>> I found an issue that kernel would send ISCSI_KEVENT_UNBIND_SESSION
>> for multiple times which should be fixed.
>>
>> This patch introduce target_unbound in iscsi_cls_session to make
>> sure session would send only one ISCSI_KEVENT_UNBIND_SESSION.
>>
>> But this would break issue fixed in commit 13e60d3ba287 ("scsi: iscsi:
>> Report unbind session event when the target has been removed"). The issue
>> is iscsid died for any reason after it send unbind session to kernel, once
>> iscsid restart again, it loss kernel's ISCSI_KEVENT_UNBIND_SESSION event.
>>
>> Now kernel think iscsi_cls_session has already sent an
>> ISCSI_KEVENT_UNBIND_SESSION event and would not send it any more. Which
>> would cause userspace unable to logout. Actually the session is in
>> invalid state(it's target_id is INVALID), iscsid should not sync this
>> session in it's restart.
>>
>> So we need to check session's target unbound state during iscsid restart,
>> if session is in unbound state, do not sync this session and perform
>> session teardown. It's reasonable because once a session is unbound, we
>> can not recover it any more(mainly because it's target id is INVALID)
>>
>> Changes from V1:
>> - Using target_unbound rather than state to indicate session has been
>>   unbound
>>
>> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
>> ---
>>  drivers/scsi/scsi_transport_iscsi.c | 21 +++++++++++++++++++++
>>  include/scsi/scsi_transport_iscsi.h |  1 +
>>  2 files changed, 22 insertions(+)
>>
>> diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
>> index 2c0dd64159b0..43ba31e595b4 100644
>> --- a/drivers/scsi/scsi_transport_iscsi.c
>> +++ b/drivers/scsi/scsi_transport_iscsi.c
>> @@ -1958,6 +1958,14 @@ static void __iscsi_unbind_session(struct work_struct *work)
>>  
>>  	ISCSI_DBG_TRANS_SESSION(session, "Unbinding session\n");
>>  
>> +	spin_lock_irqsave(&session->lock, flags);
>> +	if (session->target_unbound) {
>> +		spin_unlock_irqrestore(&session->lock, flags);
>> +		return;
>> +	}
>> +	session->target_unbound = 1;
> 
> Shoot, sorry, I think I gave you a bad review comment when I said we
> could do a bool or state kind or variable.
> 
> If we set unbound here and iscsid was restarting at this point then
> iscsid really only knows the target removal process is starting up. It
> doesn't know that the target is not yet removed. We could be doing sync
> caches and/or still tearing down scsi_devices/LUNs.
> 
> For the comments I gave you on the userspace PR parts, would it be
> easier if this was a state type of value? Above you would set it to
> REMOVING. When scsi_remove_target is done then we can set it to
> REMOVED. That combined with the session and conn states we can detect
> how far we got in the session removal process if iscsid dies in the
> middle of it.
> 
> What do you think?
> 

I thought about setting this bool to true after ISCSI_KEVENT_UNBIND_SESSION has
been sent in __iscsi_unbind_session(), it's not a good way too, the sync session
and unbind target would run concurrency.

If we need make sure iscsid call in session_conn_shutdown() after kernel's
scsi_remove_target() has finished, we must make it a state type.

We need think about how to set the initial value of this state. Since we only
cares about the removing state, the easiest way is setting it to INITED when allocing
session. When iscsid restart and found it's INITED, still sync this session.

Based on your REMOVING and REMOVED state, state is set to REMOVING at beginning
of __iscsi_unbind_session() and set to REMOVED after scsi_remove_target() done.
When iscsid restart and found this state is REMOVING, it do nothing, just waiting
for ISCSI_KEVENT_UNBIND_SESSION event. If the state is REMOVED, it should start
shutting down(both check session and conn state as you mentioned in my PR).

> 
>> +	spin_unlock_irqrestore(&session->lock, flags);
>> +
>>  	/* Prevent new scans and make sure scanning is not in progress */
>>  	mutex_lock(&ihost->mutex);
>>  	spin_lock_irqsave(&session->lock, flags)
> 
> ...
> 
>> diff --git a/include/scsi/scsi_transport_iscsi.h b/include/scsi/scsi_transport_iscsi.h
>> index 9acb8422f680..877632c25e56 100644
>> --- a/include/scsi/scsi_transport_iscsi.h
>> +++ b/include/scsi/scsi_transport_iscsi.h
>> @@ -256,6 +256,7 @@ struct iscsi_cls_session {
>>  	struct workqueue_struct *workq;
>>  
>>  	unsigned int target_id;
>> +	int target_unbound;   /* make sure unbind session only once */
> 
> 
> We don't need the comment since the code using this is so simple
> and the name of the variable tells us what it's for.
> 
> 
>>  	bool ida_used;
>>  
>>  	/*
> 
> .

