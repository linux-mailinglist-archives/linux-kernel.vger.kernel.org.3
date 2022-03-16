Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C445B4DAC5D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 09:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354506AbiCPIYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 04:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238004AbiCPIYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 04:24:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A22DF49;
        Wed, 16 Mar 2022 01:23:40 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KJNYB2MP5z67MkT;
        Wed, 16 Mar 2022 16:22:06 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 16 Mar 2022 09:23:38 +0100
Received: from [10.47.84.96] (10.47.84.96) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 16 Mar
 2022 08:23:37 +0000
Message-ID: <650c667f-ca55-821d-4e0f-29fce69a68fc@huawei.com>
Date:   Wed, 16 Mar 2022 08:23:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH RFC 2/2] libata: Use scsi cmnd budget token for qc tag for
 SAS host
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>, <hch@lst.de>,
        <hare@suse.de>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <martin.wilck@suse.com>
References: <1647340746-17600-1-git-send-email-john.garry@huawei.com>
 <1647340746-17600-3-git-send-email-john.garry@huawei.com>
 <99541f2d-2aea-6bd7-e3b6-21dbc355875d@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <99541f2d-2aea-6bd7-e3b6-21dbc355875d@opensource.wdc.com>
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

Hi Damien,

>> -	}
>> -	return -1;
>> +	return scmd->budget_token;
>>   }
> Since this is now not actually allocating a tag, I would rename this
> something like ata_sas_get_tag(). Or even better, simply open code this
> in ata_qc_new_init() since that is the only caller.

ok, I think it might be better to open code in ata_qc_new_init(), as 
suggested. That should avoid the need for the return -1 call.

> 
>>   
>>   void ata_sas_free_tag(unsigned int tag, struct ata_port *ap)
>>   {
>> -	clear_bit(tag, &ap->sas_tag_allocated);
>>   }
> This is called only in ata_qc_free(). With this change, the function is
> empty, so let's completely remove it.
> 

ok

>>   
>>   /**
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index ed8be585a98f..45d63a2ba3ee 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -640,7 +640,7 @@ static struct ata_queued_cmd *ata_scsi_qc_new(struct ata_device *dev,
>>   {

Thanks,
John
