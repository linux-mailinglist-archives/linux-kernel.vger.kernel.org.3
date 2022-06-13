Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097A754832F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbiFMJbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbiFMJbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:31:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D89186D8;
        Mon, 13 Jun 2022 02:31:37 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LM5p33Dsxz67bVy;
        Mon, 13 Jun 2022 17:27:55 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 11:31:34 +0200
Received: from [10.195.33.253] (10.195.33.253) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 10:31:33 +0100
Message-ID: <53fa2856-54f2-c075-2eed-4f05c3459597@huawei.com>
Date:   Mon, 13 Jun 2022 10:34:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH RFC v2 03/18] scsi: core: Implement reserved command
 handling
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <axboe@kernel.dk>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <brking@us.ibm.com>, <hare@suse.de>,
        <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <chenxiang66@hisilicon.com>
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
 <1654770559-101375-4-git-send-email-john.garry@huawei.com>
 <b4a0ede5-95a3-4388-e808-7627b5484d01@opensource.wdc.com>
 <7f80f3b6-84f6-de48-4e69-4562c96e62c5@huawei.com>
 <e4b108ba-cbc9-5237-f873-2fcea94f2b85@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <e4b108ba-cbc9-5237-f873-2fcea94f2b85@opensource.wdc.com>
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

On 13/06/2022 10:06, Damien Le Moal wrote:
>>> We cannot have more than 32 tags.
>> We may have 32 regular tags and 1 reserved tag for SATA.
> Right. But that is the messy part though. That extra 1 tag is actually not
> a tag since all internal commands are non-NCQ commands that do not need a
> tag...

But apart from SATA, libsas LLDDs do need a real tag for the libata 
internal command.

> 
> I am working on command duration limits support currently. This feature
> set has a new horrendous "improvement": a command can be aborted by the
> device if it fails its duration limit, but the abort is done with a good
> status + sense data available bit set so that the device queue is not
> aborted entirely like with a regular NCQ command error.
> 
> For such aborted commands, the command sense data is set to
> "COMPLETED/DATA UNAVAILABLE". In this case, the host needs to go read the
> new "successful NCQ sense data log" to check that the command sense is
> indeed "COMPLETED/DATA UNAVAILABLE". And to go read that log page without
> stalling the device queue, we would need an internal NCQ (queuable) command.
> 
> Currently, that is not possible to do cleanly as there are no guarantees
> we can get a free tag (there is a race between block layer tag allocation
> and libata internal tag counting). So a reserved tag for that would be
> nice. We would end up with 31 IO tags at most + 1 reserved tag for NCQ
> commands + ATA_TAG_INTERNAL for non-NCQ. That last one would be rendered
> rather useless. But that also means that we kind-of go back to the days
> when Linux showed ATA drives max QD of 31...

So must the ATA_TAG_INTERNAL qc always be available for non-NCQ action 
like EH, and that is why you cannot reuse for this internal NCQ 
(queuable) command?

> 
> I am still struggling with this particular use case and trying to make it
> fit with your series. Trying out different things right now.
> 

ok

> 
>>> I think keeping can_queue as the max queue depth with at most
>>> nr_reserved_cmds tags reserved is better.
>> Maybe the wording in the comment can be improved as it originally
>> focused on SAS HBAs where there are no special rules for tagset depth or
>> how the tagset should be carved up to handle regular and reserved commands.
> Indeed. And that would be for HBAs that do*not*  use libsas/libata.
> Otherwise, the NCQ vs non-NCQ reserved tag mess is there.
> 

Thanks,
John
