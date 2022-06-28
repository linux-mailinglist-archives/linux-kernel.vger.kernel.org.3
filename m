Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F40855E360
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242079AbiF1Bxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243289AbiF1Bxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:53:37 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8BDB860;
        Mon, 27 Jun 2022 18:53:35 -0700 (PDT)
X-UUID: 59c97e923145422c9af9f4e65f313468-20220628
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:340a9956-5ffe-49e2-a147-fe9a61b949f0,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:56
X-CID-INFO: VERSION:1.1.7,REQID:340a9956-5ffe-49e2-a147-fe9a61b949f0,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:56
X-CID-META: VersionHash:87442a2,CLOUDID:3b3cfed5-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:ecf55dad5c57,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 59c97e923145422c9af9f4e65f313468-20220628
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <peter.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 276109738; Tue, 28 Jun 2022 09:53:31 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 28 Jun 2022 09:53:31 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 28 Jun 2022 09:53:30 +0800
Subject: Re: [PATCH v1] PM-runtime: Check supplier_preactivated before release
 supplier
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Avri Altman <avri.altman@wdc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>, <chun-hung.wu@mediatek.com>,
        <alice.chao@mediatek.com>, <cc.chou@mediatek.com>,
        <chaotian.jing@mediatek.com>, <jiajie.hao@mediatek.com>,
        <powen.kao@mediatek.com>, <qilin.tan@mediatek.com>,
        <lin.gui@mediatek.com>, <tun-yu.yu@mediatek.com>
References: <20220613120755.14306-1-peter.wang@mediatek.com>
 <CAJZ5v0ipi5frHBGWWcFpGCYL7au=dF6vUG772h0r0pnCYsi5Zg@mail.gmail.com>
From:   Peter Wang <peter.wang@mediatek.com>
Message-ID: <028eba89-8176-740f-42df-736a0fcf26e7@mediatek.com>
Date:   Tue, 28 Jun 2022 09:53:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0ipi5frHBGWWcFpGCYL7au=dF6vUG772h0r0pnCYsi5Zg@mail.gmail.com>
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


On 6/28/22 3:00 AM, Rafael J. Wysocki wrote:
> On Mon, Jun 13, 2022 at 2:08 PM <peter.wang@mediatek.com> wrote:
>> From: Peter Wang <peter.wang@mediatek.com>
>>
>> With divice link of DL_FLAG_PM_RUNTIME, if consumer call pm_runtime_get_suppliers
>> to prevent supplier enter suspend, pm_runtime_release_supplier should
>> check supplier_preactivated before let supplier enter suspend.
> Why?

because supplier_preactivated is true means supplier cannot enter 
suspend, right?


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
>>          /* Ensure that all references to the link object have been dropped. */
>>          device_link_synchronize_removal();
>>
>> -       pm_runtime_release_supplier(link, true);
>> +       pm_runtime_release_supplier(link, true, true);
>>
>>          put_device(link->consumer);
>>          put_device(link->supplier);
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
>> +       bool drop)
>>   {
>>          struct device *supplier = link->supplier;
>>
>> +       /*
>> +        * When consumer hold supplier, supplier cannot enter suspend.
>> +        * Driect release supplier and let supplier enter suspend is not allow.
>> +        * Unless the link is drop, direct relsease supplier should be okay.
>> +        */
>> +       if (link->supplier_preactivated && !drop)
>> +               return;
>> +
>>          /*
>>           * The additional power.usage_count check is a safety net in case
>>           * the rpm_active refcount becomes saturated, in which case
>> @@ -338,7 +347,7 @@ static void __rpm_put_suppliers(struct device *dev, bool try_to_suspend)
>>
>>          list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
>>                                  device_links_read_lock_held())
>> -               pm_runtime_release_supplier(link, try_to_suspend);
>> +               pm_runtime_release_supplier(link, try_to_suspend, false);
>>   }
>>
>>   static void rpm_put_suppliers(struct device *dev)
>> @@ -1838,7 +1847,7 @@ void pm_runtime_drop_link(struct device_link *link)
>>                  return;
>>
>>          pm_runtime_drop_link_count(link->consumer);
>> -       pm_runtime_release_supplier(link, true);
>> +       pm_runtime_release_supplier(link, true, true);
>>   }
>>
>>   static bool pm_runtime_need_not_resume(struct device *dev)
>> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
>> index 9e4d056967c6..354ffb1eaec0 100644
>> --- a/include/linux/pm_runtime.h
>> +++ b/include/linux/pm_runtime.h
>> @@ -88,7 +88,8 @@ extern void pm_runtime_get_suppliers(struct device *dev);
>>   extern void pm_runtime_put_suppliers(struct device *dev);
>>   extern void pm_runtime_new_link(struct device *dev);
>>   extern void pm_runtime_drop_link(struct device_link *link);
>> -extern void pm_runtime_release_supplier(struct device_link *link, bool check_idle);
>> +extern void pm_runtime_release_supplier(struct device_link *link,
>> +       bool check_idle, bool drop);
>>
>>   extern int devm_pm_runtime_enable(struct device *dev);
>>
>> @@ -315,7 +316,7 @@ static inline void pm_runtime_put_suppliers(struct device *dev) {}
>>   static inline void pm_runtime_new_link(struct device *dev) {}
>>   static inline void pm_runtime_drop_link(struct device_link *link) {}
>>   static inline void pm_runtime_release_supplier(struct device_link *link,
>> -                                              bool check_idle) {}
>> +                                              bool check_idle, bool drop) {}
>>
>>   #endif /* !CONFIG_PM */
>>
>> --
>> 2.18.0
>>
