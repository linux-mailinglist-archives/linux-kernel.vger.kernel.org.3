Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A413A5441D2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 05:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237565AbiFIDQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 23:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiFIDQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 23:16:28 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71375DF01;
        Wed,  8 Jun 2022 20:16:25 -0700 (PDT)
X-UUID: 370127a0762649d2af567f1e7da564b4-20220609
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:2c86a623-041b-4cd2-9cdc-4672b020aecc,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:2a19b09,CLOUDID:5893b97e-c8dc-403a-96e8-6237210dceee,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: 370127a0762649d2af567f1e7da564b4-20220609
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1193237865; Thu, 09 Jun 2022 11:16:20 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 9 Jun 2022 11:16:19 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 9 Jun 2022 11:16:19 +0800
Message-ID: <086c0102b772bd86c23c4fdcb5b145854d76042d.camel@mediatek.com>
Subject: Re: [PATCH] PM: runtime: Extend support for wakeirq for
 force_suspend|resume
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Tony Lindgren <tony@atomide.com>,
        Axe Yang <axe.yang@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        <linux-kernel@vger.kernel.org>
Date:   Thu, 9 Jun 2022 11:16:17 +0800
In-Reply-To: <20220608153120.303070-1-ulf.hansson@linaro.org>
References: <20220608153120.303070-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,SCC_BODY_URI_ONLY,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-08 at 17:31 +0200, Ulf Hansson wrote:
> A driver that makes use of pm_runtime_force_suspend|resume() to
> support
> system suspend/resume, currently needs to manage the wakeirq support
> itself. To avoid the boilerplate code in the driver's system
> suspend/resume
> callbacks in particular, let's extend
> pm_runtime_force_suspend|resume() to
> deal with the wakeirq.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Note that, the reason behind this patch came up while discussing an
> MMC patch
> for a Mediatek MMC host driver [1].
> 
> Kind regards
> Ulf Hansson
> 
> [1]
> https://lkml.org/lkml/2022/6/8/813
> 
> ---
>  drivers/base/power/runtime.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/base/power/runtime.c
> b/drivers/base/power/runtime.c
> index 676dc72d912d..445a724cbded 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1876,10 +1876,13 @@ int pm_runtime_force_suspend(struct device
> *dev)
>  
>  	callback = RPM_GET_CALLBACK(dev, runtime_suspend);
>  
> +	dev_pm_enable_wake_irq_check(dev, true);
>  	ret = callback ? callback(dev) : 0;
>  	if (ret)
>  		goto err;
>  
> +	dev_pm_enable_wake_irq_complete(dev);
> +
>  	/*
>  	 * If the device can stay in suspend after the system-wide
> transition
>  	 * to the working state that will follow, drop the children
> counter of
> @@ -1896,6 +1899,7 @@ int pm_runtime_force_suspend(struct device
> *dev)
>  	return 0;
>  
>  err:
> +	dev_pm_disable_wake_irq_check(dev, true);
>  	pm_runtime_enable(dev);
>  	return ret;
>  }
> @@ -1929,9 +1933,11 @@ int pm_runtime_force_resume(struct device
> *dev)
>  
>  	callback = RPM_GET_CALLBACK(dev, runtime_resume);
>  
> +	dev_pm_disable_wake_irq_check(dev, false);
>  	ret = callback ? callback(dev) : 0;
>  	if (ret) {
>  		pm_runtime_set_suspended(dev);
> +		dev_pm_enable_wake_irq_check(dev, false);
>  		goto out;
>  	}
>  
Reviewed-by Chunfeng Yun <chunfeng.yun@mediatek.com>


