Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C2750DB7B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236519AbiDYIqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiDYIqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:46:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E147183022;
        Mon, 25 Apr 2022 01:43:12 -0700 (PDT)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kmz3y2955z67yLV;
        Mon, 25 Apr 2022 16:40:30 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 10:43:10 +0200
Received: from [10.47.92.213] (10.47.92.213) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 09:43:09 +0100
Message-ID: <380af884-94f2-231b-040b-2d89a544b8ed@huawei.com>
Date:   Mon, 25 Apr 2022 09:43:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 4/4] scsi: hisi_sas: Use libsas internal abort support
To:     Hannes Reinecke <hare@suse.de>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <jinpu.wang@cloud.ionos.com>,
        <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Ajish.Koshy@microchip.com>, <linuxarm@huawei.com>,
        <Viswas.G@microchip.com>, <hch@lst.de>, <liuqi115@huawei.com>,
        <chenxiang66@hisilicon.com>
References: <1646309930-138960-1-git-send-email-john.garry@huawei.com>
 <1646309930-138960-5-git-send-email-john.garry@huawei.com>
 <ce7c8535-a3dd-5549-1319-a3af1d0cee0b@suse.de>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <ce7c8535-a3dd-5549-1319-a3af1d0cee0b@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.92.213]
X-ClientProxiedBy: lhreml702-chm.china.huawei.com (10.201.108.51) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2022 13:29, Hannes Reinecke wrote:
> On 3/3/22 13:18, John Garry wrote:
>> Use the common libsas internal abort functionality.
>>
>> In addition, this driver has special handling for internal abort 
>> timeouts -
>> specifically whether to reset the controller in that instance, so extend
>> the API for that.
>>
> Huh? Is there a reason _not_ to reset the controller once abort times out?

There's a bug in v2 HW where the internal abort may timeout due to HW 
bug but it is not fatal, i.e. the HW state is not totally buggered, so 
can continue without a reset.

> And why isn't that delegated to SCSI EH?

For sure, SCSI EH will reset the host if all else fails. However, it may 
take some time to get to the point of deciding to reset - including lots 
of timeouts. To accelerate this, we set a host flag to say that we have 
a HW fault, and don't bother with nexus reset, LU reset, etc. once the 
initial task abort fails due to HW fault and fail straight away. Maybe 
the core code could do something similar but it seems messy/hard to 
generalise.

Thanks,
John
