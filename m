Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95B7545295
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 19:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344103AbiFIREZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 13:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237847AbiFIREX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:04:23 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B45B0D0E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 10:04:17 -0700 (PDT)
X-UUID: ea919fc6e7ff46d1ae53f09593b12f95-20220610
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:f3b7cb63-8a22-4c1f-aa9b-47610791aa59,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:2a19b09,CLOUDID:da00d37e-c8dc-403a-96e8-6237210dceee,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: ea919fc6e7ff46d1ae53f09593b12f95-20220610
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1294950020; Fri, 10 Jun 2022 01:04:13 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 10 Jun 2022 01:04:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 10 Jun 2022 01:04:12 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <yf.wang@mediatek.com>
CC:     <Libo.Kang@mediatek.com>, <Yong.Wu@mediatek.com>,
        <iommu@lists.linux-foundation.org>, <joro@8bytes.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <ning.li@mediatek.com>,
        <will@kernel.org>, <wsd_upstream@mediatek.com>
Subject: Re: [PATCH] iommu/dma: Fix race condition during iova_domain initialization
Date:   Fri, 10 Jun 2022 01:04:12 +0800
Message-ID: <20220609170412.30690-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220530120748.31733-1-yf.wang@mediatek.com>
References: <20220530120748.31733-1-yf.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YF,

>When many devices share the same iova domain, iommu_dma_init_domain()
>may be called at the same time. The checking of iovad->start_pfn will
>all get false in iommu_dma_init_domain() and both enter init_iova_domain()
>to do iovad initialization.

After reading this patch.
It means that we use iovad->start_pfn as a key to tell if an iovad is already initialized,
but we do not protect iovad->start_pfn from concurrent access.

So what's happening is like:

   cpu0                                    cpu1
of_dma_configure_id()              of_dma_configure_id()
  arch_setup_dma_ops()               arch_setup_dma_ops()
    iommu_setup_dma_ops()              iommu_setup_dma_ops()
      init_iova_domain()	 	 init_iova_domain()
         if (iovad->start_pfn) {           if (iovad->start_pfn) {
         }                                 }
         init_iova_domain()                init_iova_domain()


init_iova_domain() is called at the same time.

>Fix this by protecting init_iova_domain() with iommu_dma_cookie->mutex.

Reviewed-by: Miles Chen <miles.chen@mediatek.com> 

>Exception backtrace:
>rb_insert_color(param1=0xFFFFFF80CD2BDB40, param3=1) + 64
>init_iova_domain() + 180
>iommu_setup_dma_ops() + 260
>arch_setup_dma_ops() + 132
>of_dma_configure_id() + 468
>platform_dma_configure() + 32
>really_probe() + 1168
>driver_probe_device() + 268
>__device_attach_driver() + 524
>__device_attach() + 524
>bus_probe_device() + 64
>deferred_probe_work_func() + 260
>process_one_work() + 580
>worker_thread() + 1076
>kthread() + 332
>ret_from_fork() + 16
>
>Signed-off-by: Ning Li <ning.li@mediatek.com>
>Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
>---
> drivers/iommu/dma-iommu.c | 17 +++++++++++++----
> 1 file changed, 13 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>index 09f6e1c0f9c0..b38c5041eeab 100644
>--- a/drivers/iommu/dma-iommu.c
>+++ b/drivers/iommu/dma-iommu.c
>@@ -63,6 +63,7 @@ struct iommu_dma_cookie {
> 
> 	/* Domain for flush queue callback; NULL if flush queue not in use */
> 	struct iommu_domain		*fq_domain;
>+	struct mutex			mutex;
> };
> 
> static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled);
>@@ -309,6 +310,7 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
> 	if (!domain->iova_cookie)
> 		return -ENOMEM;
> 
>+	mutex_init(&domain->iova_cookie->mutex);
> 	return 0;
> }
> 
>@@ -549,26 +551,33 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
> 	}
> 
> 	/* start_pfn is always nonzero for an already-initialised domain */
>+	mutex_lock(&cookie->mutex);
>
> 	if (iovad->start_pfn) {
> 		if (1UL << order != iovad->granule ||
> 		    base_pfn != iovad->start_pfn) {
> 			pr_warn("Incompatible range for DMA domain\n");
>-			return -EFAULT;
>+			ret = -EFAULT;
>+			goto done_unlock;
> 		}
> 
>-		return 0;
>+		ret = 0;
>+		goto done_unlock;
> 	}
> 
> 	init_iova_domain(iovad, 1UL << order, base_pfn);
> 	ret = iova_domain_init_rcaches(iovad);
> 	if (ret)
>-		return ret;
>+		goto done_unlock;
> 
> 	/* If the FQ fails we can simply fall back to strict mode */
> 	if (domain->type == IOMMU_DOMAIN_DMA_FQ && iommu_dma_init_fq(domain))
> 		domain->type = IOMMU_DOMAIN_DMA;
> 
>-	return iova_reserve_iommu_regions(dev, domain);
>+	ret = iova_reserve_iommu_regions(dev, domain);
>+
>+done_unlock:
>+	mutex_unlock(&cookie->mutex);
>+	return ret;
> }
> 
> /**
>-- 
>2.18.0
>
>
>_______________________________________________
>Linux-mediatek mailing list
>Linux-mediatek@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-mediatek
>
