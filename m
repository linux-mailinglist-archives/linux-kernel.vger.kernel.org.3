Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFA255D7EF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242795AbiF1Btz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240857AbiF1Btw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:49:52 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0A4B12;
        Mon, 27 Jun 2022 18:49:50 -0700 (PDT)
X-UUID: 8b1f629551ae440989a800a6c41902d9-20220628
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:f4d558a4-8fa9-494d-9c42-0fce62b98fea,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:87442a2,CLOUDID:b2edcb62-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 8b1f629551ae440989a800a6c41902d9-20220628
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <peter.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 444901962; Tue, 28 Jun 2022 09:49:48 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 28 Jun 2022 09:49:47 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 28 Jun 2022 09:49:46 +0800
Subject: Re: [PATCH v1] PM-runtime: Check supplier_preactivated before release
 supplier
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <matthias.bgg@gmail.com>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <rafael@kernel.org>, <stanley.chu@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <martin.petersen@oracle.com>, <avri.altman@wdc.com>,
        <alim.akhtar@samsung.com>, <jejb@linux.ibm.com>,
        <wsd_upstream@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        <chun-hung.wu@mediatek.com>, <alice.chao@mediatek.com>,
        <cc.chou@mediatek.com>, <chaotian.jing@mediatek.com>,
        <jiajie.hao@mediatek.com>, <powen.kao@mediatek.com>,
        <qilin.tan@mediatek.com>, <lin.gui@mediatek.com>,
        <tun-yu.yu@mediatek.com>
References: <20220613120755.14306-1-peter.wang@mediatek.com>
 <Yrm7QSRXKZg4/q7s@kroah.com>
From:   Peter Wang <peter.wang@mediatek.com>
Message-ID: <9946359f-8ceb-2bad-9a4e-1e8a1dfd24c6@mediatek.com>
Date:   Tue, 28 Jun 2022 09:49:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Yrm7QSRXKZg4/q7s@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/27/22 10:14 PM, Greg KH wrote:
> On Mon, Jun 13, 2022 at 08:07:55PM +0800, peter.wang@mediatek.com wrote:
>> From: Peter Wang <peter.wang@mediatek.com>
>>
>> With divice link of DL_FLAG_PM_RUNTIME, if consumer call pm_runtime_get_suppliers
>> to prevent supplier enter suspend, pm_runtime_release_supplier should
>> check supplier_preactivated before let supplier enter suspend.
>>
>> If the link is drop or release, bypass check supplier_preactivated.
>>
>> Signed-off-by: Peter Wang <peter.wang@mediatek.com>
>> ---
>>   drivers/base/core.c          |  2 +-
>>   drivers/base/power/runtime.c | 15 ++++++++++++---
>>   include/linux/pm_runtime.h   |  5 +++--
>>   3 files changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index 7cd789c4985d..3b9cc559928f 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -486,7 +486,7 @@ static void device_link_release_fn(struct work_struct *work)
>>   	/* Ensure that all references to the link object have been dropped. */
>>   	device_link_synchronize_removal();
>>   
>> -	pm_runtime_release_supplier(link, true);
>> +	pm_runtime_release_supplier(link, true, true);
>>   
>>   	put_device(link->consumer);
>>   	put_device(link->supplier);
>> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
>> index 676dc72d912d..3c4f425937a1 100644
>> --- a/drivers/base/power/runtime.c
>> +++ b/drivers/base/power/runtime.c
>> @@ -314,10 +314,19 @@ static int rpm_get_suppliers(struct device *dev)
>>    * and if @check_idle is set, check if that device is idle (and so it can be
>>    * suspended).
>>    */
>> -void pm_runtime_release_supplier(struct device_link *link, bool check_idle)
>> +void pm_runtime_release_supplier(struct device_link *link, bool check_idle,
>> +	bool drop)
> This is just making this horrible api even worse.  Now there are 2
> boolean flags required, 2 more than really should even be here at all.
> Every time you see this function being used, you will now have to look
> up the definition  to see what it really does.
>
> Please make a new function that calls the internal function with the
> flag set properly, so that it is obvious what is happening when the call
> is made.
>
> and really, the same thing should be done for the check_idle flag,
> that's not good either.
>
> thanks,

Hi Gerg,

Good point! you are right, I wont change api next version

Thank you for review


> greg k-h
