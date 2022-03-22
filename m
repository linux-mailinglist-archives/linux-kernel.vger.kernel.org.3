Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55544E42A5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238371AbiCVPTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238338AbiCVPS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:18:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4174F8878B;
        Tue, 22 Mar 2022 08:17:29 -0700 (PDT)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KNFRj3Vrfz67Ncp;
        Tue, 22 Mar 2022 23:15:45 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 22 Mar 2022 16:17:26 +0100
Received: from [10.47.85.68] (10.47.85.68) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 22 Mar
 2022 15:17:25 +0000
Message-ID: <0f7b9765-8835-25b5-4cdb-bc78edddad37@huawei.com>
Date:   Tue, 22 Mar 2022 15:17:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 01/11] blk-mq: Add blk_mq_init_queue_ops()
To:     Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
CC:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <bvanassche@acm.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <ming.lei@redhat.com>,
        <chenxiang66@hisilicon.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <dm-devel@redhat.com>,
        <beanhuo@micron.com>
References: <1647945585-197349-1-git-send-email-john.garry@huawei.com>
 <1647945585-197349-2-git-send-email-john.garry@huawei.com>
 <20220322111848.GA29270@lst.de>
 <cacc3f7b-c8be-0f72-1c52-562c15b468a4@huawei.com>
 <b5df2ef1-2d6d-340e-e4b4-09132dc0516b@suse.de>
 <a5e42012-c1fc-082e-e636-594abc07dd70@huawei.com>
 <306df4cf-0ee0-2b1e-044c-aed6c70122f9@suse.de>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <306df4cf-0ee0-2b1e-044c-aed6c70122f9@suse.de>
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

On 22/03/2022 14:03, Hannes Reinecke wrote:
>>
>> As mentioned in the cover letter response, it just seems best to keep 
>> the normal scsi_cmnd payload but have other means to add on the 
>> internal command data, like using host_scribble or scsi_cmnd priv data.
>>
> Well; I found that most drivers I had been looking at the scsi command 
> payload isn't used at all; the drivers primarily cared about the 
> (driver-provided) payload, and were completely ignoring the scsi command 
> payload.
> 
> Similar for ATA/libsas: you basically never issue real scsi commands, 
> but either 'raw' ATA requests or SCSI TMFs. None of which are scsi 
> commands, so providing them is a bit of a waste.
> 
> (And causes irritations, too, as a scsi command requires associated 
> pointers like ->device etc to be set up. Which makes it tricky to use 
> for the initial device setup.)

A problem I see is that in scsi_mq_init_request() we allocate memories 
like sense_buffer and prot_sdb and store the pointers in the scsi_cmnd 
payload. If we then reuse a scsi_cmnd payload as an "internal" command 
payload then this data may be lost.

It might be possible to reuse the scsi cmnd payload for the "internal", 
but I would rather not get hung up on it now if possible.

Thanks,
John
