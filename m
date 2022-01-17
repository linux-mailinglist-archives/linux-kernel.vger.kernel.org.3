Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1624C4908AA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbiAQMZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:25:37 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:37468 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231537AbiAQMZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:25:35 -0500
X-UUID: 0984eb39b4094fda8f758cd6e9dcc5da-20220117
X-UUID: 0984eb39b4094fda8f758cd6e9dcc5da-20220117
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 728321395; Mon, 17 Jan 2022 20:25:31 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 17 Jan 2022 20:25:30 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Jan 2022 20:25:29 +0800
Message-ID: <792f1119b9c848a01e8b8ddd196a1db7acc1f0ae.camel@mediatek.com>
Subject: Re: [PATCH v3 5/7] memory: mtk-smi: Fix the return value for
 clk_bulk_prepare_enable
From:   Yong Wu <yong.wu@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, <lc.kan@mediatek.com>,
        <yi.kuo@mediatek.com>, <anthony.huang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Joerg Roedel <jroedel@suse.de>
Date:   Mon, 17 Jan 2022 20:25:28 +0800
In-Reply-To: <7370f18b-e273-69f2-1cc9-a42495e04874@canonical.com>
References: <20220113111057.29918-1-yong.wu@mediatek.com>
         <20220113111057.29918-6-yong.wu@mediatek.com>
         <7370f18b-e273-69f2-1cc9-a42495e04874@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-01-17 at 13:01 +0100, Krzysztof Kozlowski wrote:
> On 13/01/2022 12:10, Yong Wu wrote:
> > Function clk_bulk_prepare_enable() returns 0 for success or a
> > negative
> > number for error. Fix this code style issue.
> 
> The message does not really make sense. If negative is returned, then
> the check (ret < 0) was correct.
> 
> I guess you wanted to say that common code style is to check for any
> non-zero return value, just like it's implementation in clk.h does.
> 
> I'll adjust the commit msg when applying.

Thanks for the help.

> 
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > ---
> >  drivers/memory/mtk-smi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > index b883dcc0bbfa..e7b1a22b12ea 100644
> > --- a/drivers/memory/mtk-smi.c
> > +++ b/drivers/memory/mtk-smi.c
> > @@ -480,7 +480,7 @@ static int __maybe_unused
> > mtk_smi_larb_resume(struct device *dev)
> >  	int ret;
> >  
> >  	ret = clk_bulk_prepare_enable(larb->smi.clk_num, larb-
> > >smi.clks);
> > -	if (ret < 0)
> > +	if (ret)
> >  		return ret;
> >  
> >  	/* Configure the basic setting for this larb */
> 
> Best regards,
> Krzysztof

