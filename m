Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6940856318B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbiGAKgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbiGAKgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:36:41 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B199076EBB;
        Fri,  1 Jul 2022 03:36:40 -0700 (PDT)
X-UUID: b52a87f14af3438a92d23a4acad5b9a5-20220701
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:4d0ded8f-e5b4-4947-8b01-d315214e21a0,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:22,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:27
X-CID-INFO: VERSION:1.1.7,REQID:4d0ded8f-e5b4-4947-8b01-d315214e21a0,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:22,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:27
X-CID-META: VersionHash:87442a2,CLOUDID:a4f64c86-57f0-47ca-ba27-fe8c57fbf305,C
        OID:IGNORED,Recheck:0,SF:28|100|17|19|48|101,TC:nil,Content:0,EDM:-3,IP:ni
        l,URL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: b52a87f14af3438a92d23a4acad5b9a5-20220701
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <peter.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 689567004; Fri, 01 Jul 2022 18:36:29 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 1 Jul 2022 18:36:29 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Fri, 1 Jul 2022 18:36:26 +0800
Subject: Re: [PATCH] PM: runtime: Fix supplier device management during
 consumer probe
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Saravana Kannan <saravanak@google.com>
References: <4748074.GXAFRqVoOG@kreacher>
From:   Peter Wang <peter.wang@mediatek.com>
Message-ID: <04a046fd-d635-d9da-639a-1656c5283d86@mediatek.com>
Date:   Fri, 1 Jul 2022 18:36:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4748074.GXAFRqVoOG@kreacher>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/1/22 3:16 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Because pm_runtime_get_suppliers() bumps up the rpm_active counter
> of each device link to a supplier of the given device in addition
> to bumping up the supplier's PM-runtime usage counter, a runtime
> suspend of the consumer device may case the latter to go down to 0
> when pm_runtime_put_suppliers() is running on a remote CPU.  If that
> happens after pm_runtime_put_suppliers() has released power.lock for
> the consumer device, and a runtime resume of that device takes place
> immediately after it, before pm_runtime_put() is called for the
> supplier, that pm_runtime_put() call may cause the supplier to be
> suspended even though the consumer is active.
>
> To prevent that from happening, modify pm_runtime_get_suppliers() to
> call pm_runtime_get_sync() for the given device's suppliers without
> touching the rpm_active counters of the involved device links
> Accordingly, modify pm_runtime_put_suppliers() to call pm_runtime_put()
> for the given device's suppliers without looking at the rpm_active
> counters of the device links at hand.  [This is analogous to what
> happened before commit 4c06c4e6cf63 ("driver core: Fix possible
> supplier PM-usage counter imbalance").]
>
> Since pm_runtime_get_suppliers() sets supplier_preactivated for each
> device link where the supplier's PM-runtime usage counter has been
> incremented and pm_runtime_put_suppliers() calls pm_runtime_put() for
> the suppliers whose device links have supplier_preactivated set, the
> PM-runtime usage counter is balanced for each supplier and this is
> independent of the runtime suspend and resume of the consumer device.
>
> However, in case a device link with DL_FLAG_PM_RUNTIME set is dropped
> during the consumer device probe, so pm_runtime_get_suppliers() bumps
> up the supplier's PM-runtime usage counter, but it cannot be dropped by
> pm_runtime_put_suppliers(), make device_link_release_fn() take care of
> that.
>
> Fixes: 4c06c4e6cf63 ("driver core: Fix possible supplier PM-usage counter imbalance")
> Reported-by: Peter Wang <peter.wang@mediatek.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/base/core.c          |   10 ++++++++++
>   drivers/base/power/runtime.c |   14 +-------------
>   2 files changed, 11 insertions(+), 13 deletions(-)
>
> Index: linux-pm/drivers/base/power/runtime.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -1768,7 +1768,6 @@ void pm_runtime_get_suppliers(struct dev
>   		if (link->flags & DL_FLAG_PM_RUNTIME) {
>   			link->supplier_preactivated = true;
>   			pm_runtime_get_sync(link->supplier);
> -			refcount_inc(&link->rpm_active);
>   		}
>   
>   	device_links_read_unlock(idx);
> @@ -1788,19 +1787,8 @@ void pm_runtime_put_suppliers(struct dev
>   	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
>   				device_links_read_lock_held())
>   		if (link->supplier_preactivated) {
> -			bool put;
> -
>   			link->supplier_preactivated = false;
> -
> -			spin_lock_irq(&dev->power.lock);
> -
> -			put = pm_runtime_status_suspended(dev) &&
> -			      refcount_dec_not_one(&link->rpm_active);
> -
> -			spin_unlock_irq(&dev->power.lock);
> -
> -			if (put)
> -				pm_runtime_put(link->supplier);
> +			pm_runtime_put(link->supplier);
>   		}
>   
>   	device_links_read_unlock(idx);
> Index: linux-pm/drivers/base/core.c
> ===================================================================
> --- linux-pm.orig/drivers/base/core.c
> +++ linux-pm/drivers/base/core.c
> @@ -487,6 +487,16 @@ static void device_link_release_fn(struc
>   	device_link_synchronize_removal();
>   
>   	pm_runtime_release_supplier(link);
> +	/*
> +	 * If supplier_preactivated is set, the link has been dropped between
> +	 * the pm_runtime_get_suppliers() and pm_runtime_put_suppliers() calls
> +	 * in __driver_probe_device().  In that case, drop the supplier's
> +	 * PM-runtime usage counter to remove the reference taken by
> +	 * pm_runtime_get_suppliers().
> +	 */
> +	if (link->supplier_preactivated)
> +		pm_runtime_put_noidle(link->supplier);
> +
>   	pm_request_idle(link->supplier);
>   
>   	put_device(link->consumer);

Thanks for fix this bug.
Reviewed-by: Peter Wang <peter.wang@mediatek.com>


>
>
