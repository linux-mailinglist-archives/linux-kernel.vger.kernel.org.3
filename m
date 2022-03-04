Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6214CCBCE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 03:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbiCDClE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 21:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbiCDClB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 21:41:01 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26924664A;
        Thu,  3 Mar 2022 18:40:13 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K8sVj3g22zdZx3;
        Fri,  4 Mar 2022 10:38:53 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 10:40:11 +0800
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 10:40:11 +0800
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
Message-ID: <8fbcbe4d-629f-aaba-494d-1102c8150daa@huawei.com>
Date:   Fri, 4 Mar 2022 10:40:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <e2b37e24-44dc-a159-e45d-2c720fe7ffc1@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
>> Following stack would be reported and kernel would panic.
>>
>> [449311.812887] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
>> [449311.812893] Mem abort info:
>> [449311.812895]   ESR = 0x96000004
>> [449311.812899]   Exception class = DABT (current EL), IL = 32 bits
>> [449311.812901]   SET = 0, FnV = 0
>> [449311.812903]   EA = 0, S1PTW = 0
>> [449311.812905] Data abort info:
>> [449311.812907]   ISV = 0, ISS = 0x00000004
>> [449311.812909]   CM = 0, WnR = 0
>> [449311.812915] user pgtable: 4k pages, 48-bit VAs, pgdp = 00000000e26e7ace
>> [449311.812918] [0000000000000008] pgd=0000000000000000
>> [449311.812925] Internal error: Oops: 96000004 [#1] SMP
>> [449311.814974] Process iscsiadm (pid: 8286, stack limit = 0xffff800010f78000)
>> [449311.815570] CPU: 0 PID: 8286 Comm: iscsiadm Kdump: loaded Tainted: G    B   W         4.19.90-vhulk2201.1.0.h1021.kasan.eulerosv2r10.aarch64 #1
>> [449311.816584] sd 1:0:0:1: [sdg] Attached SCSI disk
>> [449311.816695] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>> [449311.817677] pstate: 40400005 (nZcv daif +PAN -UAO)
>> [449311.818121] pc : iscsi_sw_tcp_conn_get_param+0xec/0x300 [iscsi_tcp]
>> [449311.818688] lr : iscsi_sw_tcp_conn_get_param+0xe8/0x300 [iscsi_tcp]
>> [449311.819244] sp : ffff800010f7f890
>> [449311.819542] x29: ffff800010f7f890 x28: ffff8000cb1bea38
>> [449311.820025] x27: ffff800010911010 x26: ffff2000028887a4
>> [449311.820500] x25: ffff800009200d98 x24: ffff800010911000
>> [449311.820973] x23: 0000000000000000 x22: ffff8000cb1bea28
>> [449311.821458] x21: 0000000000000015 x20: ffff200081afa000
>> [449311.821934] x19: 1ffff000021eff20 x18: 0000000000000000
>> [449311.822414] x17: 0000000000000000 x16: ffff200080618220
>> [449311.822891] x15: 0000000000000000 x14: 0000000000000000
>> [449311.823413] x13: 0000000000000000 x12: 0000000000000000
>> [449311.823897] x11: 1ffff0001ab4f41f x10: ffff10001ab4f41f
>> [449311.824373] x9 : 0000000000000000 x8 : ffff8000d5a7a100
>> [449311.824847] x7 : 0000000000000000 x6 : dfff200000000000
>> [449311.825329] x5 : ffff1000021eff20 x4 : ffff8000cb1bea30
>> [449311.825806] x3 : ffff200002911178 x2 : ffff2000841ff000
>> [449311.826281] x1 : e0c234eab8420c00 x0 : ffff8000cb1bea38
>> [449311.826756] Call trace:
>> [449311.826987]  iscsi_sw_tcp_conn_get_param+0xec/0x300 [iscsi_tcp]
>> [449311.827550]  show_conn_ep_param_ISCSI_PARAM_CONN_ADDRESS+0xe4/0x100 [scsi_transport_iscsi]
>> [449311.828304]  dev_attr_show+0x58/0xb0
>> [449311.828639]  sysfs_kf_seq_show+0x124/0x210
>> [449311.829014]  kernfs_seq_show+0x8c/0xa0
>> [449311.829362]  seq_read+0x188/0x8a0
>> [449311.829667]  kernfs_fop_read+0x250/0x398
>> [449311.830024]  __vfs_read+0xe0/0x350
>> [449311.830339]  vfs_read+0xbc/0x1c0
>> [449311.830635]  ksys_read+0xdc/0x1b8
>> [449311.830941]  __arm64_sys_read+0x50/0x60
>> [449311.831295]  el0_svc_common+0xc8/0x320
>> [449311.831642]  el0_svc_handler+0xf8/0x160
>> [449311.831998]  el0_svc+0x10/0x218
>> [449311.832292] Code: f94006d7 910022e0 940007bb aa1c03e0 (f94006f9)
>>
>> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
>> Signed-off-by: Wu Bo <wubo40@huawei.com>
>> ---
>>   drivers/scsi/iscsi_tcp.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
>> index 1bc37593c88f..14db224486be 100644
>> --- a/drivers/scsi/iscsi_tcp.c
>> +++ b/drivers/scsi/iscsi_tcp.c
>> @@ -741,11 +741,16 @@ static int iscsi_sw_tcp_conn_get_param(struct iscsi_cls_conn *cls_conn,
>>   {
>>   	struct iscsi_conn *conn = cls_conn->dd_data;
>>   	struct iscsi_tcp_conn *tcp_conn = conn->dd_data;
>> -	struct iscsi_sw_tcp_conn *tcp_sw_conn = tcp_conn->dd_data;
>> +	struct iscsi_sw_tcp_conn *tcp_sw_conn;
>>   	struct sockaddr_in6 addr;
>>   	struct socket *sock;
>>   	int rc;
>>   
>> +	if (!tcp_conn)
>> +		return -ENOTCONN;
>> +
>> +	tcp_sw_conn = tcp_conn->dd_data;
>> +
>>   	switch(param) {
>>   	case ISCSI_PARAM_CONN_PORT:
>>   	case ISCSI_PARAM_CONN_ADDRESS:
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

I agree with this, and I would try to split device_add() from 
iscsi_create_conn().

What's more I would do some check between sysfs files add/remove and 
kernel object initialize/release to make a micro-refactoring

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

