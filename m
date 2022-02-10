Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD4A4B0BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 12:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240465AbiBJLDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 06:03:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbiBJLDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 06:03:39 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF84FE2;
        Thu, 10 Feb 2022 03:03:40 -0800 (PST)
X-UUID: f16f89fe7ede40bcb9dc9a77101ecd2b-20220210
X-UUID: f16f89fe7ede40bcb9dc9a77101ecd2b-20220210
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1689102185; Thu, 10 Feb 2022 19:03:37 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 10 Feb 2022 19:03:36 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Feb 2022 19:03:35 +0800
Message-ID: <7c517b787d1dd768372d0141f5078e3089e883cb.camel@mediatek.com>
Subject: Re: [PATCH v6 25/35] iommu/mediatek: Migrate to aggregate driver
From:   Yong Wu <yong.wu@mediatek.com>
To:     Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>,
        "Joerg Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rob Clark" <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Date:   Thu, 10 Feb 2022 19:03:35 +0800
In-Reply-To: <20220127200141.1295328-26-swboyd@chromium.org>
References: <20220127200141.1295328-1-swboyd@chromium.org>
         <20220127200141.1295328-26-swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-01-27 at 12:01 -0800, Stephen Boyd wrote:
> Use an aggregate driver instead of component ops so that we can get
> proper driver probe ordering of the aggregate device with respect to
> all
> the component devices that make up the aggregate device.
> 
> Cc: Yong Wu <yong.wu@mediatek.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

+ Krzysztof

The memory/mtk-smi.c is expected to get Ack from Krzysztof.

Tested-by: Yong Wu <yong.wu@mediatek.com>

> ---
>  drivers/iommu/mtk_iommu.c    | 14 +++++++++-----
>  drivers/iommu/mtk_iommu.h    |  6 ++++--
>  drivers/iommu/mtk_iommu_v1.c | 14 +++++++++-----
>  drivers/memory/mtk-smi.c     | 10 ++++------
>  4 files changed, 26 insertions(+), 18 deletions(-)

[...]

> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index e201e5976f34..0910fe109f53 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -175,6 +175,8 @@ mtk_smi_larb_bind(struct device *dev, struct
> device *master, void *data)
>  			larb->larbid = i;
>  			larb->mmu = &larb_mmu[i].mmu;
>  			larb->bank = larb_mmu[i].bank;
> +
> +			pm_runtime_enable(dev);
>  			return 0;
>  		}
>  	}
> @@ -450,15 +452,11 @@ static int mtk_smi_larb_probe(struct
> platform_device *pdev)
>  	if (ret < 0)
>  		return ret;
>  
> -	pm_runtime_enable(dev);
>  	platform_set_drvdata(pdev, larb);
>  	ret = component_add(dev, &mtk_smi_larb_component_ops);
> -	if (ret)
> -		goto err_pm_disable;
> -	return 0;
> +	if (!ret)
> +		return 0;
>  
> -err_pm_disable:
> -	pm_runtime_disable(dev);
>  	device_link_remove(dev, larb->smi_common_dev);

Here is right. But at a glance code here, I was confused why it always
call device_link_remove here. If we have v7, Could you help keep the
original format? something like below. This may be helpful when we add
new error flow in future.

        if (ret)
              goto dev_link_remove;
        return ret;

dev_link_remove:
        device_link_remove(dev, larb->smi_common_dev);

Thanks.     

>  	return ret;
>  }

