Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFAA50277F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351794AbiDOJm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351854AbiDOJmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:42:51 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF1148E64;
        Fri, 15 Apr 2022 02:40:23 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Kfrmd15sGzCr2p;
        Fri, 15 Apr 2022 17:36:01 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Apr 2022 17:40:21 +0800
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Apr 2022 17:40:20 +0800
Message-ID: <f587206a-4479-1748-9211-086d79249b95@huawei.com>
Date:   Fri, 15 Apr 2022 17:40:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] iscsi: set session to FREE state after unbind session
 in remove session
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Wenchao Hao <haowenchao@huawei.com>
CC:     <linfeilong@huawei.com>
References: <20220414014947.4168447-1-haowenchao@huawei.com>
 <20220414014947.4168447-3-haowenchao@huawei.com>
 <a8087705-2cea-f01c-ce67-639e97edc30a@oracle.com>
From:   Wenchao Hao <haowenchao@huawei.com>
In-Reply-To: <a8087705-2cea-f01c-ce67-639e97edc30a@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2022/4/14 23:30, Mike Christie wrote:
> On 4/13/22 8:49 PM, Wenchao Hao wrote:
>> __iscsi_unbind_session() set session state to ISCSI_SESSION_UNBOUND, which
>> would overwrite the ISCSI_SESSION_FREE state.
>>
>> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
>> ---
>>  drivers/scsi/scsi_transport_iscsi.c | 26 ++++++++++++++++----------
>>  1 file changed, 16 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
>> index 97a9fee02efa..d8dd9279cea8 100644
>> --- a/drivers/scsi/scsi_transport_iscsi.c
>> +++ b/drivers/scsi/scsi_transport_iscsi.c
>> @@ -2173,6 +2173,22 @@ void iscsi_remove_session(struct iscsi_cls_session *session)
>>  	if (!cancel_work_sync(&session->block_work))
>>  		cancel_delayed_work_sync(&session->recovery_work);
>>  	cancel_work_sync(&session->unblock_work);
>> +
>> +	scsi_target_unblock(&session->dev, SDEV_TRANSPORT_OFFLINE);
>> +	/*
>> +	 * qla4xxx can perform it's own scans when it runs in kernel only
>> +	 * mode. Make sure to flush those scans.
>> +	 */
>> +	flush_work(&session->scan_work);
>> +
>> +	/*
>> +	 * flush running unbind operations
>> +	 * if unbind work did not queued, call __iscsi_unbind_session
>> +	 * directly to perform target remove
> 
> We probably don't need the flush_work test because we are going to
> normally call __iscsi_unbind_session.
> 

I think we still need calling flush_work here. The introduce of flush_work
is to make sure sysfs objects are removed in an correct order. There is a
very low probability that __iscsi_unbind_session() triggered by queue_work()
has not been finished, and iscsi_remove_session() is called. So we need
flush_work() to make sure __iscsi_unbind_session() has done if it has been
activated by queue_work().

> If the unbind work had already run, which is the normal case, then
> flush_work returns false and we end up calling __iscsi_unbind_session
> like before. That function then checks if the target is really unbound.
> So the extra check doesn't normally buy us anything with your patches
> because in patch 1 you fixed it so __iscsi_unbind_session doesn't send
> the extra event.
> 
> 
>> +	 */
>> +	if (!flush_work(&session->unbind_work))
>> +		__iscsi_unbind_session(&session->unbind_work);
>> +
>>  	/*
>>  	 * If we are blocked let commands flow again. The lld or iscsi
>>  	 * layer should set up the queuecommand to fail commands.
>> @@ -2183,16 +2199,6 @@ void iscsi_remove_session(struct iscsi_cls_session *session)
>>  	session->state = ISCSI_SESSION_FREE;
>>  	spin_unlock_irqrestore(&session->lock, flags);
>>  
>> -	scsi_target_unblock(&session->dev, SDEV_TRANSPORT_OFFLINE);
>> -	/*
>> -	 * qla4xxx can perform it's own scans when it runs in kernel only
>> -	 * mode. Make sure to flush those scans.
>> -	 */
>> -	flush_work(&session->scan_work);
>> -	/* flush running unbind operations */
>> -	flush_work(&session->unbind_work);
>> -	__iscsi_unbind_session(&session->unbind_work);
>> -
>>  	/* hw iscsi may not have removed all connections from session */
>>  	err = device_for_each_child(&session->dev, NULL,
>>  				    iscsi_iter_destroy_conn_fn);
> 
> .

