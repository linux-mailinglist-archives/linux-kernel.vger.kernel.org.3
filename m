Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14194C2CA2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbiBXNFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234785AbiBXNFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:05:35 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4CA37B5A8;
        Thu, 24 Feb 2022 05:05:06 -0800 (PST)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K4Clg2Fgjz67w62;
        Thu, 24 Feb 2022 21:03:59 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 14:05:03 +0100
Received: from [10.47.86.126] (10.47.86.126) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 24 Feb
 2022 13:05:02 +0000
Message-ID: <06714ce6-40cd-653d-4e5f-4bafee355035@huawei.com>
Date:   Thu, 24 Feb 2022 13:05:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/2] scsi: libsas: Make sas_notify_{phy,port}_event()
 return void
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <chenxiang66@hisilicon.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
References: <1645700699-82369-1-git-send-email-john.garry@huawei.com>
 <1645700699-82369-2-git-send-email-john.garry@huawei.com>
 <014a69ed-7a99-2a67-fa3a-947d11601114@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <014a69ed-7a99-2a67-fa3a-947d11601114@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.86.126]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2022 12:43, Damien Le Moal wrote:
> On 2/24/22 20:04, John Garry wrote:
>> Nobody checks the return codes, so make them return void. Indeed, if the
>> LLDD cannot send an event, nothing much can be done in the LLDD about it.
> 
> It really sound like the LLDDs should be fixed to e.g. reset the adapter
> if things go south with these functions. No sure though.

But this is not an adapter fault. As an example of a scenario which we 
could be dealing with, it may be that a phyup event occurs in the 
adapter but libsas cannot allocate memory to process the event. There's 
not much the adapter/LLDD can do about that (nor does do).

> 
>>
>> Also remove prototype for sas_notify_phy_event() in sas_internal.h, which
>> should not be there.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> Reviewed-by: Xiang Chen <chenxiang66@hisilicon.com>
> 
> In any case, these changes do not make anything worse :)

Thanks,

> 
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> 
