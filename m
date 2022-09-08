Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E3B5B1A2C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 12:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiIHKiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 06:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiIHKis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 06:38:48 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18570D9EAA;
        Thu,  8 Sep 2022 03:38:43 -0700 (PDT)
X-UUID: c0a4d2d67b634c438c14f70f70c1498f-20220908
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=4EAQ100GUJ4755+8cZ4lBtaSz0v0TFrMx0G0ZmrS6II=;
        b=P2y57cVACONShty2dZ8tzIDBXIIMjXIcAsIdqY/KxkE8eycM8fGvumrhhzTtU6Ck+5uEaT0QRkmofnCv420qG6CcJCipDmIfM5smcv3uV/YlgdAPcQW/YzN5qPq01fH4mHa3CpdwK1yU56weJ1/b0f3U+ibBG3jAJ1lFWkIledk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:80043959-435d-4a1d-9ccb-cd8e325f5c58,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:66f0c9f5-6e85-48d9-afd8-0504bbfe04cb,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: c0a4d2d67b634c438c14f70f70c1498f-20220908
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 632540820; Thu, 08 Sep 2022 18:38:36 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 8 Sep 2022 18:38:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 8 Sep 2022 18:38:34 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     <mathieu.poirier@linaro.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <bjorn.andersson@linaro.org>, <bleung@chromium.org>,
        <chrome-platform@lists.linux.dev>, <devicetree@vger.kernel.org>,
        <dnojiri@chromium.org>, <enric.balletbo@collabora.com>,
        <groeck@chromium.org>, <gustavoars@kernel.org>,
        <keescook@chromium.org>, <krzk+dt@kernel.org>,
        <lee.jones@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <matthias.bgg@gmail.com>,
        <pmalani@chromium.org>, <robh+dt@kernel.org>,
        <sebastian.reichel@collabora.com>, <tinghan.shen@mediatek.com>,
        <weishunc@google.com>
Subject: Re: [PATCH v2 2/9] remoteproc: mediatek: Support hanlding scp core 1 wdt timeout
Date:   Thu, 8 Sep 2022 18:38:28 +0800
Message-ID: <20220908103828.23644-1-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220829174021.GA2264818@p14s>
References: <20220829174021.GA2264818@p14s>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

> Hi Tinghan,
> 
> I have started reviewing this set and I expect comments to be spread out over a few
> days.  I will tell you when I am done.
> 
> Please see below for comments...
> 
> On Wed, Jun 08, 2022 at 04:35:46PM +0800, Tinghan Shen wrote:
> > MT8195 SCP is a dual-core processor. The SCP core 1 watchdog timeout
> > interrupt uses the same interrupt line of SCP core 0 watchdog timeout
> > interrupt.
> > 
> > Add support for handling SCP core 1 watchdog timeout interrupt in the
> > SCP IRQ handler.
> > 
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > ---
> >  drivers/remoteproc/mtk_common.h |  4 ++++
> >  drivers/remoteproc/mtk_scp.c    | 27 ++++++++++++++++++++++++++-
> >  2 files changed, 30 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
> > index ea6fa1100a00..73e8adf00de3 100644
> > --- a/drivers/remoteproc/mtk_common.h
> > +++ b/drivers/remoteproc/mtk_common.h
> > @@ -54,6 +54,10 @@
> >  #define MT8192_CORE0_WDT_IRQ		0x10030
> >  #define MT8192_CORE0_WDT_CFG		0x10034
> >  
> > +#define MT8195_SYS_STATUS		0x4004
> > +#define MT8195_CORE0_WDT		BIT(16)
> > +#define MT8195_CORE1_WDT		BIT(17)
> > +
> >  #define MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS		GENMASK(7, 4)
> >  
> >  #define SCP_FW_VER_LEN			32
> > diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> > index 47b2a40e1b4a..3510c6d0bbc8 100644
> > --- a/drivers/remoteproc/mtk_scp.c
> > +++ b/drivers/remoteproc/mtk_scp.c
> > @@ -212,6 +212,31 @@ static void mt8192_scp_irq_handler(struct mtk_scp *scp)
> >  	}
> >  }
> >  
> > +static void mt8195_scp_irq_handler(struct mtk_scp *scp)
> > +{
> > +	u32 scp_to_host;
> > +
> > +	scp_to_host = readl(scp->reg_base + MT8192_SCP2APMCU_IPC_SET);
> > +
> > +	if (scp_to_host & MT8192_SCP_IPC_INT_BIT) {
> > +		scp_ipi_handler(scp);
> > +
> > +		/*
> > +		 * SCP won't send another interrupt until we clear
> > +		 * MT8192_SCP2APMCU_IPC.
> > +		 */
> > +		writel(MT8192_SCP_IPC_INT_BIT,
> > +		       scp->reg_base + MT8192_SCP2APMCU_IPC_CLR);
> > +	} else {
> > +		if (readl(scp->reg_base + MT8195_SYS_STATUS) & MT8195_CORE1_WDT) {
> > +			writel(1, scp->reg_base + MT8195_CORE1_WDT_IRQ);
> > +		} else {
> > +			writel(1, scp->reg_base + MT8192_CORE0_WDT_IRQ);
> > +			scp_wdt_handler(scp, scp_to_host);
> 
> Why is scp_wdt_handler() not called when CORE1 signals a watchdog failure?  If
> this is the intended behaviour there is no way for anyone but you to know that
> it is the case.  

It's becuase the handler of CORE1 timeout doesn't exist at this patch.
The CORE1 timeout handler is added at patch 7 of this series.

You're right. This makes people confused.
I'll combine this patch with the CORE1 timeout handler.

Best regards,
TingHan
