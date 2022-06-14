Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B2754AD68
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbiFNJaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiFNJaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:30:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2606840E53;
        Tue, 14 Jun 2022 02:30:20 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LMjmY2nw7z6H7Tb;
        Tue, 14 Jun 2022 17:28:45 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 11:30:18 +0200
Received: from [10.195.33.253] (10.195.33.253) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 10:30:17 +0100
Message-ID: <731c26d2-5124-60a6-c8de-d979ee2af467@huawei.com>
Date:   Tue, 14 Jun 2022 10:33:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH RFC v2 02/18] scsi: core: Resurrect
 scsi_{get,free}_host_dev()
To:     Christoph Hellwig <hch@lst.de>
CC:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <brking@us.ibm.com>, <hare@suse.de>, <linux-block@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <chenxiang66@hisilicon.com>
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
 <1654770559-101375-3-git-send-email-john.garry@huawei.com>
 <20220614064403.GB31683@lst.de>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220614064403.GB31683@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.33.253]
X-ClientProxiedBy: lhreml746-chm.china.huawei.com (10.201.108.196) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2022 07:44, Christoph Hellwig wrote:
> On Thu, Jun 09, 2022 at 06:29:03PM +0800, John Garry wrote:
>> This reverts commit 6bd49b1a8d43ec118c55f3aaa7577729b52bde15.
> 
> Please add an actual text describing why you are doing this and how
> insteasd of this completely pointless revert line.
> 
> 
> .

OK. And in hindsight it would have been a good opportunity to mention 
something which I am undecided on - that is which scsi_device to use for 
these reserved commands?

In this series I use the scsi shost sdev for all reserved commands, but 
maybe we should use the target sdev.

Pros of using scsi host sdev:
- don't need to worry about request queue freezing
- don't need to worry about running out of request queue budget
- available when scsi host is added - libata adds target sdev after some 
internal commands are sent, and this would be a bit painful to change, 
however adding the sdev earlier would seem to be a good change to make

Cons:
- generally better to use same scsi device as target (or is it?). For 
example, it seems better to have reserved scsi_cmnd.device actually set 
to the target sdev.
- don't need to add stuff like ata_is_scmd_ata_internal() later in this 
series

Prob other reasons which I have forgot about. Please let me know if you 
have any thoughts on this.

Cheers,
John
