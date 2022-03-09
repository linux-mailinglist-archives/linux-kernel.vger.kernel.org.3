Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3583F4D2D99
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiCILCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiCILCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:02:14 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C3116E7C2;
        Wed,  9 Mar 2022 03:01:15 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KD8NR02BJzdZhq;
        Wed,  9 Mar 2022 18:59:51 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 19:01:13 +0800
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 19:01:12 +0800
Subject: Re: [PATCH v2 1/3] scsi: iscsi: Add helper functions to manage
 iscsi_cls_conn
To:     Mike Christie <michael.christie@oracle.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Wu Bo <wubo40@huawei.com>, Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>
References: <20220309030916.2932316-1-haowenchao@huawei.com>
 <20220309030916.2932316-2-haowenchao@huawei.com>
 <8183661b-a513-9b04-b289-3707704084b2@oracle.com>
From:   Wenchao Hao <haowenchao@huawei.com>
Message-ID: <d7a0405f-f0df-1db0-e95e-562db1ef064f@huawei.com>
Date:   Wed, 9 Mar 2022 19:01:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <8183661b-a513-9b04-b289-3707704084b2@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2022/3/9 1:19, Mike Christie wrote:
> On 3/8/22 9:09 PM, Wenchao Hao wrote:
>> iscsi_alloc_conn(): alloc and initialize iscsi_cls_conn
>> iscsi_add_conn(): expose iscsi_cls_conn to userspace's via sysfs.
>> iscsi_remove_conn(): remove iscsi_cls_conn from sysfs
>> iscsi_free_conn(): free iscsi_cls_conn
>>
>> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
>> Signed-off-by: Wu Bo <wubo40@huawei.com>
>> ---
>>   drivers/scsi/scsi_transport_iscsi.c | 107 ++++++++++++++++++++++++++++
>>   include/scsi/scsi_transport_iscsi.h |   5 ++
>>   2 files changed, 112 insertions(+)
>>
>> diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
>> index 554b6f784223..8e97c6f88359 100644
>> --- a/drivers/scsi/scsi_transport_iscsi.c
>> +++ b/drivers/scsi/scsi_transport_iscsi.c
>> @@ -2340,6 +2340,113 @@ void iscsi_free_session(struct iscsi_cls_session *session)
>>   }
>>   EXPORT_SYMBOL_GPL(iscsi_free_session);
>>   
>> +/**
>> + * iscsi_alloc_conn - alloc iscsi class connection
>> + * @session: iscsi cls session
>> + * @dd_size: private driver data size
>> + * @cid: connection id
>> + *
>> + * This can be called from a LLD or iscsi_transport. The connection
>> + * is child of the session so cid must be unique for all connections
>> + * on the session.
>> + *
>> + * Since we do not support MCS, cid will normally be zero. In some cases
>> + * for software iscsi we could be trying to preallocate a connection struct
>> + * in which case there could be two connection structs and cid would be
>> + * non-zero.
> 
> Is that with the upstream iscsi tools or your version? I don't think the comment
> is needed or is needed somewhere else.
> 
> If this happens then they will have the same sysfs/device name so when we do the
> device_add it will spit an error about duplicate names.
> 
> 
>> + */
>> +struct iscsi_cls_conn *
>> +iscsi_alloc_conn(struct iscsi_cls_session *session, int dd_size, uint32_t cid)
>> +{
>> +	struct iscsi_transport *transport = session->transport;
>> +	struct iscsi_cls_conn *conn;
>> +
>> +	conn = kzalloc(sizeof(*conn) + dd_size, GFP_KERNEL);
>> +	if (!conn)
>> +		return NULL;
>> +	if (dd_size)
>> +		conn->dd_data = &conn[1];
>> +
>> +	mutex_init(&conn->ep_mutex);
>> +	INIT_LIST_HEAD(&conn->conn_list);
>> +	INIT_WORK(&conn->cleanup_work, iscsi_cleanup_conn_work_fn);
>> +	conn->transport = transport;
>> +	conn->cid = cid;
>> +	conn->state = ISCSI_CONN_DOWN;
>> +
>> +	/* this is released in the dev's release function */
>> +	if (!get_device(&session->dev))
>> +		goto free_conn;
>> +
>> +	dev_set_name(&conn->dev, "connection%d:%u", session->sid, cid);
>> +	device_initialize(&conn->dev);
>> +	conn->dev.parent = &session->dev;
>> +	conn->dev.release = iscsi_conn_release;
>> +
>> +	return conn;
>> +
>> +free_conn:
>> +	kfree(conn);
>> +	return NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(iscsi_alloc_conn);
>> +
>> +/**
>> + * iscsi_add_conn - add iscsi class connection
>> + * @conn: iscsi cls connection
>> + *
>> + * this would expose iscsi_cls_conn to sysfs, so make sure the related
>> + * resources when access sysfs attributes are initialized before calling this.
>> + */
>> +int iscsi_add_conn(struct iscsi_cls_conn *conn)
>> +{
>> +	int err;
>> +	unsigned long flags;
>> +	struct iscsi_cls_session *session = iscsi_dev_to_session(conn->dev.parent);
>> +
>> +	err = device_add(&conn->dev);
>> +	if (err) {
>> +		iscsi_cls_session_printk(KERN_ERR, session,
>> +					 "could not register connection's dev\n");
>> +		put_device(&session->dev);
> 
> I would call iscsi_free_conn. instead of put_device.
> 

Sorry I noticed it but forget to remove it. Here should not call 
put_device() or iscsi_free_conn(). If iscsi_add_conn() failed, we shoule 
not call any put operation which might cause resource free.

>> +		return err;
>> +	}
>> +	err = transport_register_device(&conn->dev);
>> +	if (err) {
>> +		iscsi_cls_session_printk(KERN_ERR, session,
>> +					 "could not register transport's dev\n");
>> +		device_del(&conn->dev);
>> +		put_device(&session->dev);
> 
> 
> Is for the get_device(&session->dev) in iscsi_alloc_conn? If so you don't need to
> do it because when the last put is done on the conn->dev, it will call
> iscsi_conn_release which does the put on the session when it does "put_device(parent).
> 
> Or did you mean to call put_device on the conn->dev?
> 

As above, we shouldn't call put_device() here.

> I would do device_el(&conn->dev) then do a goto free_conn at the bottom which
> does iscsi_free_conn. The place above should do the goto as well.
> 
> 
