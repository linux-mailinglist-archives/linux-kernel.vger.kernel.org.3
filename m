Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B7F4CCBBB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 03:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237690AbiCDCZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 21:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiCDCZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 21:25:21 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F477BA74C;
        Thu,  3 Mar 2022 18:24:34 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K8s8149BczBrWT;
        Fri,  4 Mar 2022 10:22:41 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 10:24:32 +0800
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 10:24:31 +0800
Subject: Re: [PATCH 2/2] iscsi_tcp: Check if tcp_conn is valid in
To:     Mike Christie <michael.christie@oracle.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Wu Bo <wubo40@huawei.com>, Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>
References: <20220304025608.1874516-1-haowenchao@huawei.com>
 <20220304025608.1874516-2-haowenchao@huawei.com>
 <85a64450-99c8-268d-1ac7-86e70cbb3562@oracle.com>
From:   Wenchao Hao <haowenchao@huawei.com>
Message-ID: <f6055c4a-b32f-8025-f096-f6abda03e2d4@huawei.com>
Date:   Fri, 4 Mar 2022 10:24:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <85a64450-99c8-268d-1ac7-86e70cbb3562@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

On 2022/3/3 22:59, Mike Christie wrote:
> On 3/3/22 8:56 PM, Wenchao Hao wrote:
>> iscsi_create_conn() would add newly alloced iscsi_cls_conn to connlist,
>> it means when userspace sends ISCSI_UEVENT_SET_PARAM, iscsi_conn_lookup()
>> would found this iscsi_cls_conn and call the set_param callback which is
>> iscsi_sw_tcp_conn_set_param(). While the iscsi_conn's dd_data might not
>> been initialized.
>>
>> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
>> Signed-off-by: Wu Bo <wubo40@huawei.com>
>> ---
>>   drivers/scsi/iscsi_tcp.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
>> index 14db224486be..a42449df6156 100644
>> --- a/drivers/scsi/iscsi_tcp.c
>> +++ b/drivers/scsi/iscsi_tcp.c
>> @@ -716,13 +716,17 @@ static int iscsi_sw_tcp_conn_set_param(struct iscsi_cls_conn *cls_conn,
>>   {
>>   	struct iscsi_conn *conn = cls_conn->dd_data;
>>   	struct iscsi_tcp_conn *tcp_conn = conn->dd_data;
>> -	struct iscsi_sw_tcp_conn *tcp_sw_conn = tcp_conn->dd_data;
>> +	struct iscsi_sw_tcp_conn *tcp_sw_conn;
>>   
>>   	switch(param) {
>>   	case ISCSI_PARAM_HDRDGST_EN:
>>   		iscsi_set_param(cls_conn, param, buf, buflen);
>>   		break;
>>   	case ISCSI_PARAM_DATADGST_EN:
>> +		if (!tcp_conn || !tcp_conn->dd_data)
>> +			return -ENOTCONN;
>> +
>> +		tcp_sw_conn = tcp_conn->dd_data;
>>   		iscsi_set_param(cls_conn, param, buf, buflen);
>>   		tcp_sw_conn->sendpage = conn->datadgst_en ?
>>   			sock_no_sendpage : tcp_sw_conn->sock->ops->sendpage;
> 
> Is this something you hit or from code review?
> 

It's from code review. I reviewed the code because the panic mentioned 
in my first patch. The issue seems would not happen, so just ignore it.

> We have those state checks:
> 
> if ((conn->state == ISCSI_CONN_BOUND) ||
>      (conn->state == ISCSI_CONN_UP)) {
> 	err = transport->set_param(conn, ev->u.set_param.param,
> 
> so we don't call set_param until after we have bound the
> connection which will be after ISCSI_UEVENT_CREATE_CONN has returned.
> 
> Also for this specific bug iscsi_if_recv_msg is called with the
> rx_queue_mutex, so set_param can only be called after the
> ISCSI_UEVENT_CREATE_CONN cmd has returned.
> .
> 

