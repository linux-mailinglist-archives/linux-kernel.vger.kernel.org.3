Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802F34DAD24
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354797AbiCPJET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354794AbiCPJEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:04:16 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E4528988;
        Wed, 16 Mar 2022 02:03:01 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KJPQ16XdJzCqp7;
        Wed, 16 Mar 2022 17:00:57 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 17:02:59 +0800
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 17:02:58 +0800
Subject: Re: [PATCH] scsi:libiscsi: remove unnecessary memset in
 iscsi_conn_setup
To:     Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie <michael.christie@oracle.com>
CC:     Wu Bo <wubo40@huawei.com>, <open-iscsi@googlegroups.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Feilong Lin <linfeilong@huawei.com>
References: <20220316220936.191013-1-haowenchao@huawei.com>
From:   Wenchao Hao <haowenchao@huawei.com>
Message-ID: <44860f67-e626-411e-5ee6-9055ea2d5723@huawei.com>
Date:   Wed, 16 Mar 2022 17:02:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20220316220936.191013-1-haowenchao@huawei.com>
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

cc open-iscsi@googlegroups.com linux-scsi@vger.kernel.org

On 2022/3/17 6:09, Wenchao Hao wrote:
> iscsi_cls_conn is alloced by kzalloc(), the whole iscsi_cls_conn is
> zero filled already including the dd_data. So it is unnecessary to
> call memset again.
> 
> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
> Reviewed-by: Wu Bo <wubo40@huawei.com>
> ---
>   drivers/scsi/libiscsi.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
> index d09926e6c8a8..cf4211c6500d 100644
> --- a/drivers/scsi/libiscsi.c
> +++ b/drivers/scsi/libiscsi.c
> @@ -3045,7 +3045,6 @@ iscsi_conn_setup(struct iscsi_cls_session *cls_session, int dd_size,
>   	if (!cls_conn)
>   		return NULL;
>   	conn = cls_conn->dd_data;
> -	memset(conn, 0, sizeof(*conn) + dd_size);
>   
>   	conn->dd_data = cls_conn->dd_data + sizeof(*conn);
>   	conn->session = session;
> 

