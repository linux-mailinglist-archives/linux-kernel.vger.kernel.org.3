Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7554E1EA8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 02:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343961AbiCUBZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 21:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242273AbiCUBZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 21:25:43 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2652716D;
        Sun, 20 Mar 2022 18:24:15 -0700 (PDT)
X-UUID: b29e7eacf5ae47559f6c5d9b61827a64-20220321
X-UUID: b29e7eacf5ae47559f6c5d9b61827a64-20220321
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2009333236; Mon, 21 Mar 2022 09:24:12 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Mar 2022 09:24:11 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 21 Mar
 2022 09:24:11 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Mar 2022 09:24:10 +0800
Message-ID: <e672b7192e47e5247dc5feeaf7ecbc1bb019292e.camel@mediatek.com>
Subject: Re: [PATCH V5 1/3] spi: mediatek: add spi memory support for ipm
 design
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Mark Brown" <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Date:   Mon, 21 Mar 2022 09:24:10 +0800
In-Reply-To: <a6844feb-98d5-4f44-f8fa-87f47aa9ec93@collabora.com>
References: <20220318025027.31281-1-leilk.liu@mediatek.com>
         <20220318025027.31281-2-leilk.liu@mediatek.com>
         <a6844feb-98d5-4f44-f8fa-87f47aa9ec93@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-03-18 at 12:29 +0100, AngeloGioacchino Del Regno wrote:
> Il 18/03/22 03:50, Leilk Liu ha scritto:
> > this patch add the support of spi-mem for ipm design.
> > 
> > Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> > ---
> >   drivers/spi/spi-mt65xx.c | 302
> > ++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 301 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> > index 1a0b3208dfca..ea6223259060 100644
> > --- a/drivers/spi/spi-mt65xx.c
> > +++ b/drivers/spi/spi-mt65xx.c
> 
> ...snip...
> 
> > @@ -78,8 +79,21 @@
> >   #define SPI_CMD_IPM_GET_TICKDLY_OFFSET    22
> >   
> >   #define SPI_CMD_IPM_GET_TICKDLY_MASK	GENMASK(24, 22)
> > +
> > +#define PIN_MODE_CFG(x)	((x) / 2)
> > +
> > +#define SPI_CFG3_IPM_PIN_MODE_OFFSET		0
> 
> This definition is useless, the offset is zero... and this is used
> to bitshift zero.
> 
> 
> Please remove that, after which:
OK, thanks for your comment.

> 
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>

