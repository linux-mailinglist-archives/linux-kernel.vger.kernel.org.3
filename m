Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207F34DAE76
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 11:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355212AbiCPKsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 06:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355206AbiCPKsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 06:48:15 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2CE6353A;
        Wed, 16 Mar 2022 03:47:01 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KJRkZ1Wptz68649;
        Wed, 16 Mar 2022 18:45:26 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 16 Mar 2022 11:46:58 +0100
Received: from [10.47.84.96] (10.47.84.96) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 16 Mar
 2022 10:46:58 +0000
Message-ID: <4dfcddff-7736-e01e-7fcf-804de77ac623@huawei.com>
Date:   Wed, 16 Mar 2022 10:46:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH RFC 2/2] libata: Use scsi cmnd budget token for qc tag for
 SAS host
To:     Christoph Hellwig <hch@lst.de>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>, <hare@suse.de>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <martin.wilck@suse.com>
References: <1647340746-17600-1-git-send-email-john.garry@huawei.com>
 <1647340746-17600-3-git-send-email-john.garry@huawei.com>
 <99541f2d-2aea-6bd7-e3b6-21dbc355875d@opensource.wdc.com>
 <650c667f-ca55-821d-4e0f-29fce69a68fc@huawei.com>
 <20220316083439.GA6701@lst.de>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220316083439.GA6701@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.84.96]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
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

On 16/03/2022 08:34, Christoph Hellwig wrote:
> In addition to the comments from Damien:  I think we should kill
> ata_qc_new_init as well.  It is a bit pointless and having it in
> libata-core.c when it pokes into scsi internals also doesn't make sense.
> 
> So maybe something like:

Seems reasonable to me at least.

But I'd send these as 2x separate patches.

>    *	sata_async_notification - SATA async notification handler
>    *	@ap: ATA port where async notification is received
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index ed8be585a98f7c..5e0bc7b05a107e 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -638,24 +638,44 @@ EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
>   static struct ata_queued_cmd *ata_scsi_qc_new(struct ata_device *dev,
>   					      struct scsi_cmnd *cmd)
>   {
...

>   
> -		if (scsi_cmd_to_rq(cmd)->rq_flags & RQF_QUIET)
> -			qc->flags |= ATA_QCFLAG_QUIET;
> +	if (ap->flags & ATA_FLAG_SAS_HOST) {
> +		/* XXX: add a comment here why SAS is different */

I think this is simply because SAS hosts have shost.can_queue > 32

> +		if (WARN_ON_ONCE(cmd->budget_token >= ATA_MAX_QUEUE))
> +			goto fail;
> +		tag = cmd->budget_token;

thanks,
John
