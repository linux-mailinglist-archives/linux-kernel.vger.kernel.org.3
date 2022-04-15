Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E3D50276A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351757AbiDOJfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351754AbiDOJft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:35:49 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992A5A7752;
        Fri, 15 Apr 2022 02:33:21 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kfrfj0HbPzFprm;
        Fri, 15 Apr 2022 17:30:53 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Apr 2022 17:33:19 +0800
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Apr 2022 17:33:19 +0800
Message-ID: <1e4b47e5-2bd3-2766-7d47-d14d3a4fbd65@huawei.com>
Date:   Fri, 15 Apr 2022 17:33:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] scsi: iscsi: introduce session UNBOUND state to avoid
 multiple unbind event
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Wenchao Hao <haowenchao@huawei.com>
CC:     <linfeilong@huawei.com>
References: <20220414014947.4168447-1-haowenchao@huawei.com>
 <20220414014947.4168447-2-haowenchao@huawei.com>
 <137ec5f5-dbdc-99f0-e9b7-deeef5001a01@oracle.com>
From:   Wenchao Hao <haowenchao@huawei.com>
In-Reply-To: <137ec5f5-dbdc-99f0-e9b7-deeef5001a01@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/14 23:22, Mike Christie wrote:
> On 4/13/22 8:49 PM, Wenchao Hao wrote:
>> Fix the issue of kernel send multiple ISCSI_KEVENT_UNBIND_SESSION event.
>> If session is in UNBOUND state, do not perform unbind operations anymore,
>> else unbind session and set session to UNBOUND state.
>>
> 
> I don't think we want this to be a state because you can have a session
> with no target or it could be partially deleted and it could be in the
> logged in or failed state. If scsi-ml is sending SYNC_CACHEs as part of
> the target/device removal operation, and we lose the session then we could
> go through recovery and the state will go from failed to logged in, and
> your new unbound state will have been overwritten.
> 
> I think it might be better to have a new sysfs file, target_state, for
> this where you could have values like scanning, bound, unbinding, and
> unbound, or just a sysfs file, target_bound, that is bool.
> 

Thanks for your review, I would modify and send another patch.

>> Reference:https://github.com/open-iscsi/open-iscsi/issues/338
>>
> 
> You should add a description of the problem in the commit, because that
> link might be gone one day.
> 
> 
>> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
>> ---
>>  drivers/scsi/scsi_transport_iscsi.c | 19 +++++++++++++++++--
>>  include/scsi/scsi_transport_iscsi.h |  1 +
>>  2 files changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
>> index 27951ea05dd4..97a9fee02efa 100644
>> --- a/drivers/scsi/scsi_transport_iscsi.c
>> +++ b/drivers/scsi/scsi_transport_iscsi.c
>> @@ -1656,6 +1656,7 @@ static struct {
>>  	{ ISCSI_SESSION_LOGGED_IN,	"LOGGED_IN" },
>>  	{ ISCSI_SESSION_FAILED,		"FAILED" },
>>  	{ ISCSI_SESSION_FREE,		"FREE" },
>> +	{ ISCSI_SESSION_UNBOUND,	"UNBOUND" },
>>  };
>>  
>>  static const char *iscsi_session_state_name(int state)
>> @@ -1686,6 +1687,9 @@ int iscsi_session_chkready(struct iscsi_cls_session *session)
>>  	case ISCSI_SESSION_FREE:
>>  		err = DID_TRANSPORT_FAILFAST << 16;
>>  		break;
>> +	case ISCSI_SESSION_UNBOUND:
>> +		err = DID_NO_CONNECT << 16;
>> +		break;
>>  	default:
>>  		err = DID_NO_CONNECT << 16;
>>  		break;
>> @@ -1838,7 +1842,8 @@ int iscsi_block_scsi_eh(struct scsi_cmnd *cmd)
>>  
>>  	spin_lock_irqsave(&session->lock, flags);
>>  	while (session->state != ISCSI_SESSION_LOGGED_IN) {
>> -		if (session->state == ISCSI_SESSION_FREE) {
>> +		if ((session->state == ISCSI_SESSION_FREE) ||
>> +		    (session->state == ISCSI_SESSION_UNBOUND)) {
>>  			ret = FAST_IO_FAIL;
>>  			break;
>>  		}
>> @@ -1869,6 +1874,7 @@ static void session_recovery_timedout(struct work_struct *work)
>>  		break;
>>  	case ISCSI_SESSION_LOGGED_IN:
>>  	case ISCSI_SESSION_FREE:
>> +	case ISCSI_SESSION_UNBOUND:
>>  		/* we raced with the unblock's flush */
>>  		spin_unlock_irqrestore(&session->lock, flags);
>>  		return;
>> @@ -1957,6 +1963,14 @@ static void __iscsi_unbind_session(struct work_struct *work)
>>  	unsigned long flags;
>>  	unsigned int target_id;
>>  
>> +	spin_lock_irqsave(&session->lock, flags);
>> +	if (session->state == ISCSI_SESSION_UNBOUND) {
>> +		spin_unlock_irqrestore(&session->lock, flags);
>> +		return;
>> +	}
>> +	session->state = ISCSI_SESSION_UNBOUND;
>> +	spin_unlock_irqrestore(&session->lock, flags);
>> +
>>  	ISCSI_DBG_TRANS_SESSION(session, "Unbinding session\n");
>>  
>>  	/* Prevent new scans and make sure scanning is not in progress */
>> @@ -4329,7 +4343,8 @@ store_priv_session_##field(struct device *dev,				\
>>  	struct iscsi_cls_session *session =				\
>>  		iscsi_dev_to_session(dev->parent);			\
>>  	if ((session->state == ISCSI_SESSION_FREE) ||			\
>> -	    (session->state == ISCSI_SESSION_FAILED))			\
>> +	    (session->state == ISCSI_SESSION_FAILED) ||			\
>> +	    (session->state == ISCSI_SESSION_UNBOUND))			\
>>  		return -EBUSY;						\
>>  	if (strncmp(buf, "off", 3) == 0) {				\
>>  		session->field = -1;					\
>> diff --git a/include/scsi/scsi_transport_iscsi.h b/include/scsi/scsi_transport_iscsi.h
>> index 38e4a67f5922..80149643cbcd 100644
>> --- a/include/scsi/scsi_transport_iscsi.h
>> +++ b/include/scsi/scsi_transport_iscsi.h
>> @@ -232,6 +232,7 @@ enum {
>>  	ISCSI_SESSION_LOGGED_IN,
>>  	ISCSI_SESSION_FAILED,
>>  	ISCSI_SESSION_FREE,
>> +	ISCSI_SESSION_UNBOUND,
>>  };
>>  
>>  #define ISCSI_MAX_TARGET -1
> 
> .

