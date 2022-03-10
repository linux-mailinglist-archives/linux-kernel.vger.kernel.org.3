Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4A74D4010
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 04:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239389AbiCJEAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 23:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbiCJEAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 23:00:45 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3FCC5DAB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 19:59:45 -0800 (PST)
X-UUID: 283f34977d2a49f78e8ca98ae27899c5-20220310
X-UUID: 283f34977d2a49f78e8ca98ae27899c5-20220310
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1625239036; Thu, 10 Mar 2022 11:59:39 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 10 Mar 2022 11:59:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Mar 2022 11:59:38 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <chun-jie.chen@mediatek.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <drinkcat@chromium.org>, <eballetbo@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <srv_heupstream@mediatek.com>
Subject: Re: [PATCH v1] soc: mediatek: pm-domains: Fix the power glitch issue
Date:   Thu, 10 Mar 2022 11:59:38 +0800
Message-ID: <20220310035938.20110-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220310011548.2487-1-chun-jie.chen@mediatek.com>
References: <20220310011548.2487-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Jie,

>Power reset maybe generate unexpected signal. In order to avoid
>the glitch issue, we need to enable isolation first to guarantee the
>stable signal when power reset is triggered.
>
>Fixes: 59b644b01cf4 ("soc: mediatek: Add MediaTek SCPSYS power domains")
>Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
>---
>This patch is based on 5.17-rc1.
>---
> drivers/soc/mediatek/mtk-pm-domains.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
>index b762bc40f56b..0195f6c3396b 100644
>--- a/drivers/soc/mediatek/mtk-pm-domains.c
>+++ b/drivers/soc/mediatek/mtk-pm-domains.c
>@@ -272,9 +272,9 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
> 	clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
> 
> 	/* subsys power off */
>-	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
> 	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT);
> 	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_CLK_DIS_BIT);
>+	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
> 	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_2ND_BIT);
> 	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_BIT);
 
Does it mean that we have to do power off by:
regmap_set_bits(PWR_ISO_BIT)
regmap_clear_bits(PWR_RST_B_BIT )

and do power on by:
regmap_set_bits(PWR_RST_B_BIT)
regmap_clear_bits(PWR_ISO_BIT)

But scpsys_power_on() has the following sequence:
regmap_clear_bits(PWR_ISO_BIT)
regmap_set_bits(PWR_RST_B_BIT)

Thanks,
Miles
