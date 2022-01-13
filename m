Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15D148D227
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 07:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiAMGCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 01:02:44 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:40660 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229449AbiAMGCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 01:02:43 -0500
X-UUID: 0ff5dd1f6a9c40a6a5f99d60d556b070-20220113
X-UUID: 0ff5dd1f6a9c40a6a5f99d60d556b070-20220113
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1319419179; Thu, 13 Jan 2022 14:02:40 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 13 Jan 2022 14:02:38 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 13 Jan 2022 14:02:37 +0800
Message-ID: <6d2759f9d2ea74affa040bfec524e87b765c67af.camel@mediatek.com>
Subject: Re: [PATCH v2 5/6] memory: mtk-smi: Add sleep ctrl function
From:   Yong Wu <yong.wu@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Tomasz Figa" <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, <lc.kan@mediatek.com>,
        <yi.kuo@mediatek.com>, <anthony.huang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Date:   Thu, 13 Jan 2022 14:02:37 +0800
In-Reply-To: <22935ffa-469c-a609-c30b-919ba85b842c@canonical.com>
References: <20220111063904.7583-1-yong.wu@mediatek.com>
         <20220111063904.7583-6-yong.wu@mediatek.com>
         <22935ffa-469c-a609-c30b-919ba85b842c@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-01-12 at 11:27 +0100, Krzysztof Kozlowski wrote:
> On 11/01/2022 07:39, Yong Wu wrote:
> > Sleep control means that when the larb goes to sleep, we should
> > wait a bit
> > until all the current commands are finished. Thus, when the larb
> > runtime
> > suspends, we need to enable this function to wait until all the
> > existed
> > commands are finished. When the larb resumes, just disable this
> > function.
> > This function only improves the safety of bus. Add a new flag for
> > this
> > function. Prepare for mt8186.
> > 
> > Signed-off-by: Anan Sun <anan.sun@mediatek.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/memory/mtk-smi.c | 35 ++++++++++++++++++++++++++++++++++-
> >  1 file changed, 34 insertions(+), 1 deletion(-)

[...]

> > @@ -492,9 +521,13 @@ static int __maybe_unused
> > mtk_smi_larb_resume(struct device *dev)
> >  static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
> >  {
> >  	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> > +	int ret = 0;
> > +
> > +	if (MTK_SMI_CAPS(larb->larb_gen->flags_general,
> > MTK_SMI_FLAG_SLEEP_CTL))
> > +		ret = mtk_smi_larb_sleep_ctrl_enable(larb);
> >  
> >  	clk_bulk_disable_unprepare(larb->smi.clk_num, larb->smi.clks);
> > -	return 0;
> > +	return ret;
> 
> I am wondering whether disabling clocks in error case is a proper
> step.
> On suspend error, the PM core won't run any further callbacks on this
> device. This means, it won't be resumed and your clocks stay
> disabled. I
> think you should return early and leave the device in active state in
> case of error.

oh, Yes. Thanks for pointing this out.

I will fix this in next version.

> 
> 
> Best regards,
> Krzysztof
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

