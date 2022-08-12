Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26E25913EF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 18:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238734AbiHLQeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 12:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbiHLQeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:34:02 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9657A14004;
        Fri, 12 Aug 2022 09:34:01 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M48Pr4dSCz682NF;
        Sat, 13 Aug 2022 00:33:52 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 18:33:59 +0200
Received: from [10.48.157.254] (10.48.157.254) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 17:33:58 +0100
Message-ID: <34bdd9a8-26bf-95b0-ed62-a6af5db05654@huawei.com>
Date:   Fri, 12 Aug 2022 17:33:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/6] libsas and drivers: NCQ error handling
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <yangxingui@huawei.com>,
        <chenxiang66@hisilicon.com>, <hare@suse.de>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1658489049-232850-1-git-send-email-john.garry@huawei.com>
 <d2e27cb7-d90a-2f0a-1848-e1ec8faf7899@opensource.wdc.com>
 <437abe43-7ddd-6f49-9386-d8ed04c659bf@huawei.com>
 <15bfd5e0-7fcd-fdee-a546-7720b55eb108@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <15bfd5e0-7fcd-fdee-a546-7720b55eb108@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.157.254]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/2022 16:39, Damien Le Moal wrote:
>> For this specific test we don't seem to run a hardreset after the
>> autopsy, but we do seem to be getting an NCQ error. That's interesting.
>>
>> We have noticed this scenario for hisi_sas NCQ error, whereby the
>> autopsy decided a reset is not required or useful, such as a medium
>> error. Anyway the pm8001 driver relies on the reset being run always for
>> the NCQ error. So I am thinking of tweaking sas_ata_link_abort() as follows:
>>
>> void sas_ata_link_abort(struct domain_device *device)
>> {
>> 	struct ata_port *ap = device->sata_dev.ap;
>> 	struct ata_link *link = &ap->link;
>>
>> 	link->eh_info.err_mask |= AC_ERR_DEV;
>> +	link->eh_info.action |= ATA_EH_RESET;
>> 	ata_link_abort(link);
>> }
>>
>> This should force a reset.
> This is an unaligned write to a sequential write required zone on SMR. So
> definitely not worth a reset. Forcing hard resetting the link for such error is
> an overkill. I think it is better to let ata_link_abort() -> ... -> scsi & ata
> EH decide on the disposition.

Do you know if this triggered the pm8001 IO_XFER_ERROR_ABORTED_NCQ_MODE 
  error?

If I do not set ATA_EH_RESET then I need to trust that libata will 
always decide to do the reset for pm8001 IO_XFER_ERROR_ABORTED_NCQ_MODE 
error. That is because it is in the reset that I send the pm8001 "abort 
all" command - I could not find a better place for it.

> 
> Note that patch 3 did not apply cleanly to the current Linus tree. So a rebase
> for the series is needed.
> 

That might be just git am, which always seems temperamental. The patches 
still apply from cherry-pick'ing for me. Anyway, I'll send a new version 
next week.

Thanks,
John

