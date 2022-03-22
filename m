Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03B64E3DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 12:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbiCVLhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 07:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbiCVLhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:37:35 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD52E65B6;
        Tue, 22 Mar 2022 04:36:08 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KN8Y2430zz67yKG;
        Tue, 22 Mar 2022 19:35:02 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 22 Mar 2022 12:36:06 +0100
Received: from [10.47.85.68] (10.47.85.68) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 22 Mar
 2022 11:36:04 +0000
Message-ID: <8498ddc5-e5a5-16b3-bc70-2cfbc79d5258@huawei.com>
Date:   Tue, 22 Mar 2022 11:36:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
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
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220322112057.GC29270@lst.de>
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
> 
> Any reason to not just send them through an ATA_16 passthrough CDB and
> just use all the normal SCSI command handling?
> 
> .

No reason that I know about.

TBH, I was hoping that someone woud have a better idea on how to do this 
as what I was doing was messy.

Let me check it.

Cheers,
John
