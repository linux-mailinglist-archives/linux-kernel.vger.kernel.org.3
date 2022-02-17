Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B5F4BA204
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240804AbiBQNxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:53:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241334AbiBQNxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:53:25 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A2523DCE6;
        Thu, 17 Feb 2022 05:53:09 -0800 (PST)
X-UUID: 7508a21f15cf42f68e8bd0d4720c2844-20220217
X-UUID: 7508a21f15cf42f68e8bd0d4720c2844-20220217
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 553058100; Thu, 17 Feb 2022 21:53:04 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 17 Feb 2022 21:53:03 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Feb 2022 21:53:02 +0800
Message-ID: <4958e2ad25f4940a0c0bbbf23ea027e7bdaf5ac7.camel@mediatek.com>
Subject: Re: [PATCH 10/15] ASoC: mediatek: mt8186: add platform driver
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <perex@perex.cz>,
        <p.zabel@pengutronix.de>, <geert+renesas@glider.be>,
        <trevor.wu@mediatek.com>, <tzungbi@google.com>,
        <zhangqilong3@huawei.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Thu, 17 Feb 2022 21:51:57 +0800
In-Reply-To: <YgaK4hiRjEJi9wQ4@sirena.org.uk>
References: <20220211103818.8266-1-jiaxin.yu@mediatek.com>
         <20220211103818.8266-11-jiaxin.yu@mediatek.com>
         <YgaK4hiRjEJi9wQ4@sirena.org.uk>
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

On Fri, 2022-02-11 at 16:12 +0000, Mark Brown wrote:
> On Fri, Feb 11, 2022 at 06:38:13PM +0800, Jiaxin Yu wrote:
> 
> >  sound/soc/mediatek/Kconfig                    |   44 +
> >  sound/soc/mediatek/Makefile                   |    1 +
> >  sound/soc/mediatek/mt8186/Makefile            |   21 +
> >  sound/soc/mediatek/mt8186/mt8186-afe-clk.c    |  719 ++++
> >  sound/soc/mediatek/mt8186/mt8186-afe-clk.h    |  210 +
> >  sound/soc/mediatek/mt8186/mt8186-afe-common.h |  245 ++
> >  .../soc/mediatek/mt8186/mt8186-afe-control.c  |  262 ++
> >  sound/soc/mediatek/mt8186/mt8186-afe-gpio.c   |  211 +
> >  sound/soc/mediatek/mt8186/mt8186-afe-gpio.h   |   19 +
> >  sound/soc/mediatek/mt8186/mt8186-afe-pcm.c    | 3030
> > +++++++++++++++
> >  .../mediatek/mt8186/mt8186-interconnection.h  |   69 +
> >  .../soc/mediatek/mt8186/mt8186-misc-control.c | 1729 +++++++++
> >  sound/soc/mediatek/mt8186/mt8186-reg.h        | 3433
> > +++++++++++++++++
> 
> I know it's already a long series but perhaps the clock and GPIO bits
> could be split out into separate patches?  This one patch is over
> 300K
> which is a bit much in one go, especially when it's not just all big
> tables.

Ok, I see. I've split them out into separate patches in v2 version.

