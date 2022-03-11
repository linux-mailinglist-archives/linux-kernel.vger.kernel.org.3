Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B824D5872
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 03:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344499AbiCKC4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 21:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345789AbiCKC4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 21:56:00 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A011A6F8E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 18:54:57 -0800 (PST)
X-UUID: c4f7469888bc47e9aedb7a3f415e8672-20220311
X-UUID: c4f7469888bc47e9aedb7a3f415e8672-20220311
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1100491169; Fri, 11 Mar 2022 10:54:53 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 11 Mar 2022 10:54:52 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Mar 2022 10:54:51 +0800
Message-ID: <3a55f44998645308bb1b4fd65ef550682ebe6ba0.camel@mediatek.com>
Subject: Re: [PATCH v1] soc: mediatek: pm-domains: Fix the power glitch issue
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Miles Chen <miles.chen@mediatek.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <drinkcat@chromium.org>, <eballetbo@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <srv_heupstream@mediatek.com>
Date:   Fri, 11 Mar 2022 10:54:51 +0800
In-Reply-To: <20220310035938.20110-1-miles.chen@mediatek.com>
References: <20220310011548.2487-1-chun-jie.chen@mediatek.com>
         <20220310035938.20110-1-miles.chen@mediatek.com>
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

On Thu, 2022-03-10 at 11:59 +0800, Miles Chen wrote:
> Hi Chun-Jie,
> 
> > Power reset maybe generate unexpected signal. In order to avoid
> > the glitch issue, we need to enable isolation first to guarantee
> > the
> > stable signal when power reset is triggered.
> > 
> > Fixes: 59b644b01cf4 ("soc: mediatek: Add MediaTek SCPSYS power
> > domains")
> > Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> > ---
> > This patch is based on 5.17-rc1.
> > ---
> > drivers/soc/mediatek/mtk-pm-domains.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/soc/mediatek/mtk-pm-domains.c
> > b/drivers/soc/mediatek/mtk-pm-domains.c
> > index b762bc40f56b..0195f6c3396b 100644
> > --- a/drivers/soc/mediatek/mtk-pm-domains.c
> > +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> > @@ -272,9 +272,9 @@ static int scpsys_power_off(struct
> > generic_pm_domain *genpd)
> > 	clk_bulk_disable_unprepare(pd->num_subsys_clks, pd-
> > >subsys_clks);
> > 
> > 	/* subsys power off */
> > -	regmap_clear_bits(scpsys->base, pd->data->ctl_offs,
> > PWR_RST_B_BIT);
> > 	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT);
> > 	regmap_set_bits(scpsys->base, pd->data->ctl_offs,
> > PWR_CLK_DIS_BIT);
> > +	regmap_clear_bits(scpsys->base, pd->data->ctl_offs,
> > PWR_RST_B_BIT);
> > 	regmap_clear_bits(scpsys->base, pd->data->ctl_offs,
> > PWR_ON_2ND_BIT);
> > 	regmap_clear_bits(scpsys->base, pd->data->ctl_offs,
> > PWR_ON_BIT);
> 
>  
> Does it mean that we have to do power off by:
> regmap_set_bits(PWR_ISO_BIT)
> regmap_clear_bits(PWR_RST_B_BIT )
> 
> and do power on by:
> regmap_set_bits(PWR_RST_B_BIT)
> regmap_clear_bits(PWR_ISO_BIT)
> 
> But scpsys_power_on() has the following sequence:
> regmap_clear_bits(PWR_ISO_BIT)
> regmap_set_bits(PWR_RST_B_BIT)
> 
> Thanks,
> Miles

Hi Miles,

This control sequence is suggested by hardware designer,
and when PWR_RST_B from 0 -> 1, it will trigger to exit from reset
state to running state, if we still enable isolation then can't start
running normally, so we need to disable isolation first in power on
sequence.

Thanks!

