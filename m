Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9D8554290
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357049AbiFVGJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiFVGJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:09:29 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1EB1CB21;
        Tue, 21 Jun 2022 23:09:22 -0700 (PDT)
X-UUID: c1ce7ed61733451c84386834803eea27-20220622
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:c7d4467c-1ff9-4c03-bb4d-d48211e0bc06,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:0
X-CID-META: VersionHash:b14ad71,CLOUDID:9b602fea-f7af-4e69-92ee-0fd74a0c286c,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: c1ce7ed61733451c84386834803eea27-20220622
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <peter.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2137778895; Wed, 22 Jun 2022 14:09:18 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 22 Jun 2022 14:09:17 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 22 Jun 2022 14:09:16 +0800
Subject: Re: [PATCH v1] PM-runtime: Check supplier_preactivated before release
 supplier
To:     <matthias.bgg@gmail.com>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <rafael@kernel.org>, <gregkh@linuxfoundation.org>,
        <stanley.chu@mediatek.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <martin.petersen@oracle.com>, <avri.altman@wdc.com>,
        <alim.akhtar@samsung.com>, <jejb@linux.ibm.com>
CC:     <wsd_upstream@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        <chun-hung.wu@mediatek.com>, <alice.chao@mediatek.com>,
        <cc.chou@mediatek.com>, <chaotian.jing@mediatek.com>,
        <jiajie.hao@mediatek.com>, <powen.kao@mediatek.com>,
        <qilin.tan@mediatek.com>, <lin.gui@mediatek.com>,
        <tun-yu.yu@mediatek.com>
References: <20220613120755.14306-1-peter.wang@mediatek.com>
From:   Peter Wang <peter.wang@mediatek.com>
Message-ID: <a6ed562c-5ec0-231d-0eee-a35f2ba7a344@mediatek.com>
Date:   Wed, 22 Jun 2022 14:09:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220613120755.14306-1-peter.wang@mediatek.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RDNS_NONE,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,


gentle ping for this bug fix review.


Thanks.


On 6/13/22 8:07 PM, peter.wang@mediatek.com wrote:
> From: Peter Wang <peter.wang@mediatek.com>
>
> With divice link of DL_FLAG_PM_RUNTIME, if consumer call pm_runtime_get_suppliers
> to prevent supplier enter suspend, pm_runtime_release_supplier should
> check supplier_preactivated before let supplier enter suspend.
>
> If the link is drop or release, bypass check supplier_preactivated.
>
> Signed-off-by: Peter Wang <peter.wang@mediatek.com>
> ---
>   drivers/base/core.c          |  2 +-
>   drivers/base/power/runtime.c | 15 ++++++++++++---
>   include/linux/pm_runtime.h   |  5 +++--
>   3 files changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 7cd789c4985d..3b9cc559928f 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -486,7 +486,7 @@ static void device_link_release_fn(struct work_struct *work)
>   	/* Ensure that all references to the link object have been dropped. */
>   	device_link_synchronize_removal();
>   
> -	pm_runtime_release_supplier(link, true);
> +	pm_runtime_release_supplier(link, true, true);
>   
>   	put_device(link->consumer);
>   	put_device(link->supplier);
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 676dc72d912d..3c4f425937a1 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -314,10 +314,19 @@ static int rpm_get_suppliers(struct device *dev)
>    * and if @check_idle is set, check if that device is idle (and so it can be
>    * suspended).
>    */
> -void pm_runtime_release_supplier(struct device_link *link, bool check_idle)
> +void pm_runtime_release_supplier(struct device_link *link, bool check_idle,
> +	bool drop)
>   {
>   	struct device *supplier = link->supplier;
>   
> +	/*
> +	 * When consumer hold supplier, supplier cannot enter suspend.
> +	 * Driect release supplier and let supplier enter suspend is not allow.
> +	 * Unless the link is drop, direct relsease supplier should be okay.
> +	 */
> +	if (link->supplier_preactivated && !drop)
> +		return;
> +
>   	/*
>   	 * The additional power.usage_count check is a safety net in case
>   	 * the rpm_active refcount becomes saturated, in which case
> @@ -338,7 +347,7 @@ static void __rpm_put_suppliers(struct device *dev, bool try_to_suspend)
>   
>   	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
>   				device_links_read_lock_held())
> -		pm_runtime_release_supplier(link, try_to_suspend);
> +		pm_runtime_release_supplier(link, try_to_suspend, false);
>   }
>   
>   static void rpm_put_suppliers(struct device *dev)
> @@ -1838,7 +1847,7 @@ void pm_runtime_drop_link(struct device_link *link)
>   		return;
>   
>   	pm_runtime_drop_link_count(link->consumer);
> -	pm_runtime_release_supplier(link, true);
> +	pm_runtime_release_supplier(link, true, true);
>   }
>   
>   static bool pm_runtime_need_not_resume(struct device *dev)
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 9e4d056967c6..354ffb1eaec0 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -88,7 +88,8 @@ extern void pm_runtime_get_suppliers(struct device *dev);
>   extern void pm_runtime_put_suppliers(struct device *dev);
>   extern void pm_runtime_new_link(struct device *dev);
>   extern void pm_runtime_drop_link(struct device_link *link);
> -extern void pm_runtime_release_supplier(struct device_link *link, bool check_idle);
> +extern void pm_runtime_release_supplier(struct device_link *link,
> +	bool check_idle, bool drop);
>   
>   extern int devm_pm_runtime_enable(struct device *dev);
>   
> @@ -315,7 +316,7 @@ static inline void pm_runtime_put_suppliers(struct device *dev) {}
>   static inline void pm_runtime_new_link(struct device *dev) {}
>   static inline void pm_runtime_drop_link(struct device_link *link) {}
>   static inline void pm_runtime_release_supplier(struct device_link *link,
> -					       bool check_idle) {}
> +					       bool check_idle, bool drop) {}
>   
>   #endif /* !CONFIG_PM */
>   
