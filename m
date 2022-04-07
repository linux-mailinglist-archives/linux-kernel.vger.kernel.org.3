Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C014F81BA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344018AbiDGOeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344006AbiDGOeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:34:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9688D198526;
        Thu,  7 Apr 2022 07:32:12 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KZ3gw30svz681Z4;
        Thu,  7 Apr 2022 22:30:20 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Apr 2022 16:32:10 +0200
Received: from [10.47.80.129] (10.47.80.129) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 7 Apr
 2022 15:32:09 +0100
Message-ID: <3e1914a8-5f6b-8fcf-7fb3-2d1edb9766e1@huawei.com>
Date:   Thu, 7 Apr 2022 15:32:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 03/11] libata: Send internal commands through the block
 layer
To:     Christoph Hellwig <hch@lst.de>
CC:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <bvanassche@acm.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <ming.lei@redhat.com>,
        <hare@suse.de>, <chenxiang66@hisilicon.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <dm-devel@redhat.com>, <beanhuo@micron.com>
References: <1647945585-197349-1-git-send-email-john.garry@huawei.com>
 <1647945585-197349-4-git-send-email-john.garry@huawei.com>
 <20220322112057.GC29270@lst.de>
In-Reply-To: <20220322112057.GC29270@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.129]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2022 11:20, Christoph Hellwig wrote:
> On Tue, Mar 22, 2022 at 06:39:37PM +0800, John Garry wrote:
>> When SCSI HBA device drivers are required to process an ATA internal
>> command they still need a tag for the IO. This often requires the driver
>> to set aside a set of tags for these sorts of IOs and manage the tags
>> themselves.
>>
>> If we associate a SCSI command (and request) with an ATA internal command
>> then the tag is already provided, so introduce the change to send ATA
>> internal commands through the block layer with a set of custom blk-mq ops.
>>
>> note: I think that the timeout handling needs to be fixed up.

Hi Christoph,

> Any reason to not just send them through an ATA_16 passthrough CDB and
> just use all the normal SCSI command handling?

I had a go at implementing this but I have come up against a few issues:

- ATA_16 handling translates the passthrough CDB to a ATA TF. However 
ata_exec_internal_sg() is passed a TF already. So what to do? Change the 
callers to generate a ATA_16 CDB? I guess not. Otherwise we could put 
the already-generated TF in the SCSI cmd CDB somehow and use directly.

- We may have no SCSI device (yet) for the target when issuing an 
internal command, but only the ATA port+dev. So need a method to pass 
these pointers to ATA_16 handling

- we would need to change ata_scsi_translate(), ata_scsi_pass_thru() and 
other friends to deal with ATA_TAG_INTERNAL and its peculiarities - 
today it just deals with regular qc's.

It still does seem a reasonable idea to use ATA_16, but it looks like 
significant modifications would be required....

Thanks,
John
