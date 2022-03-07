Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEC14CFD7A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237304AbiCGL44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbiCGL4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:56:53 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235B76574;
        Mon,  7 Mar 2022 03:55:59 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KBxcb0R6jz1GBys;
        Mon,  7 Mar 2022 19:51:11 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 19:55:57 +0800
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 19:55:56 +0800
Subject: Re: [PATCH 1/2] iscsi_tcp: Fix NULL pointer dereference in
 iscsi_sw_tcp_conn_get_param()
To:     Mike Christie <michael.christie@oracle.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Wu Bo <wubo40@huawei.com>, Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>
References: <20220304025608.1874516-1-haowenchao@huawei.com>
 <e2b37e24-44dc-a159-e45d-2c720fe7ffc1@oracle.com>
From:   Wenchao Hao <haowenchao@huawei.com>
Message-ID: <c2891c08-5809-1f56-8783-357e6df1bc1a@huawei.com>
Date:   Mon, 7 Mar 2022 19:55:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <e2b37e24-44dc-a159-e45d-2c720fe7ffc1@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
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

On 2022/3/3 23:03, Mike Christie wrote:
> On 3/3/22 8:56 PM, Wenchao Hao wrote:
>> kernel might crash in iscsi_sw_tcp_conn_get_param() because it dereference
>> an invalid address.
>>
>> The initialization of iscsi_conn's dd_data is after device_register() of
>> struct iscsi_cls_conn, so iscsi_conn's dd_data might not initialized when
>> iscsi_sw_tcp_conn_get_param() is called.
>>
> 
> We are actually doing sysfs/device addition wrong.
> 
> We should be doing the 2 step setup where in step 1 we alloc/init.
> When everything is allocated and initialized, then we should do
> device_add which exposes us to sysfs. On the teardown side, we are
> then supposed to do 2 steps where the remove function does device_del
> which waits until sysfs accesses are completed. We can then tear
> the structs down and free them and call device_put.
> 

I reviewed the teardown flow of iscsi_cls_conn, it has already written 
as what you saied.


> The exposure to NL would be similar where it goes into the wrapper
> around device_add. However, see my comments on the other patch where
> I don't think we can hit the bug you mention because every nl cmd
> that calls into the drivers is done under the rx_queue_mutex.
> 
> I think we should separate the iscsi_create_conn function like we
> do for sessions. This is going to be a little more involved because
> you need to also convert iscsi_tcp_conn_setup and the drivers since
> we can call into the drivers for the get_conn_param callout.
> .
> 

I hesitated about when should we call device_add(). I think there are 
two places to call it.

The first one is in iscsi_conn_setup(), after some initialization of 
conn, it keeps same with previous's implement and need not to change 
drivers' code. What's more, the change can fix iscsi_tcp's NULL pointer 
access.  While this change can not make sure the LLDs related sources 
are already initialized when iscsi_cls_conn is exposed to sysfs. It 
means LLDs' callback are still responsible to check if the resources are 
accessible.

Another one is in create_conn callback for each driver's 
iscsi_transport.  This need us to change each driver's code.

I send 2 patches which make changes in iscsi_conn_setup(), it's ok with 
iscsi_tcp, would you help to review them?

