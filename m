Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4195A548436
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiFMKDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 06:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241439AbiFMKCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 06:02:31 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4F710A7;
        Mon, 13 Jun 2022 03:02:28 -0700 (PDT)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LM6Tf4bCNz682DK;
        Mon, 13 Jun 2022 17:58:46 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 12:02:26 +0200
Received: from [10.195.33.253] (10.195.33.253) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 11:02:25 +0100
Message-ID: <5a2047e3-5e71-141a-ec3a-2e22749d3c49@huawei.com>
Date:   Mon, 13 Jun 2022 11:05:33 +0100
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
 <53fa2856-54f2-c075-2eed-4f05c3459597@huawei.com>
 <d2e452cd-6a91-f25d-748e-94f560deb1bb@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <d2e452cd-6a91-f25d-748e-94f560deb1bb@opensource.wdc.com>
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

On 13/06/2022 10:43, Damien Le Moal wrote:
>>> Currently, that is not possible to do cleanly as there are no guarantees
>>> we can get a free tag (there is a race between block layer tag allocation
>>> and libata internal tag counting). So a reserved tag for that would be
>>> nice. We would end up with 31 IO tags at most + 1 reserved tag for NCQ
>>> commands + ATA_TAG_INTERNAL for non-NCQ. That last one would be rendered
>>> rather useless. But that also means that we kind-of go back to the days
>>> when Linux showed ATA drives max QD of 31...
>> So must the ATA_TAG_INTERNAL qc always be available for non-NCQ action
>> like EH, and that is why you cannot reuse for this internal NCQ
>> (queuable) command?
> Currently, ATA_TAG_INTERNAL is always used for non-NCQ commands. Seeing a
> qc with that tag means it is*not*  NCQ.
> 
> I am trying to see if I can reuse the tag from one of the commands that
> completed with that weird good status/sense data available. The problem
> though is that this all needs to be done*before*  calling
> qc->complete_fn() which will free the tag. So we endup with 2 qcs that
> have the same tag, the second one (for the read log command) temporarily
> using the tag but still going through the same completion path without the
> original command fully completed yet. It is a real mess.
> 

Reusing tags seems really messy, but then reserving an NCQ command seems 
wasteful.

Thanks,
John
