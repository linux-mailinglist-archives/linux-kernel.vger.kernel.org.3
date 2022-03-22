Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17224E435E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbiCVPzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbiCVPzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:55:21 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAB02DA;
        Tue, 22 Mar 2022 08:53:51 -0700 (PDT)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KNGF64BJTz67bJf;
        Tue, 22 Mar 2022 23:51:38 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 22 Mar 2022 16:53:49 +0100
Received: from [10.47.85.68] (10.47.85.68) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 22 Mar
 2022 15:53:48 +0000
Message-ID: <da17474f-205c-1b08-f12c-52cd87a8379a@huawei.com>
Date:   Tue, 22 Mar 2022 15:53:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] scsi: core: Refine how we set tag_set NUMA node
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hch@lst.de>, <ming.lei@redhat.com>, <bvanassche@acm.org>
References: <1647939438-187933-1-git-send-email-john.garry@huawei.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <1647939438-187933-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.85.68]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
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

On 22/03/2022 08:57, John Garry wrote:
>   	/*
>   	 * Increase usage count temporarily here so that calling
>   	 * scsi_autopm_put_host() will trigger runtime idle if there is
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 0a70aa763a96..7faa83b89fa4 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1982,7 +1982,11 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
>   	tag_set->nr_maps = shost->nr_maps ? : 1;
>   	tag_set->queue_depth = shost->can_queue;
>   	tag_set->cmd_size = cmd_size;
> +	#ifdef CONFIG_NUMA
> +	tag_set->numa_node = shost->dma_dev->numa_node;
> +	#else
>   	tag_set->numa_node = NUMA_NO_NODE;
> +	#endif

note to self: use dev_to_node()

>   	tag_set->flags = BLK_MQ_F_SHOULD_MERGE;
>   	tag_set->flags |=

