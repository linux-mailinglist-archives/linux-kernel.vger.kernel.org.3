Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CF14F217D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiDEEIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 00:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiDEEIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 00:08:35 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0051DA;
        Mon,  4 Apr 2022 21:06:35 -0700 (PDT)
X-UUID: 270c0d8d6eea477fa457c65fac8df177-20220405
X-UUID: 270c0d8d6eea477fa457c65fac8df177-20220405
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2092507740; Tue, 05 Apr 2022 12:06:31 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 5 Apr 2022 12:06:30 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 5 Apr
 2022 12:06:30 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 5 Apr 2022 12:06:29 +0800
Message-ID: <6a29c32f42c25ec6e19de0db999ac7ca25869c36.camel@mediatek.com>
Subject: Re: [v3 15/19] ASoC: mediatek: mt8186: add machine driver with
 mt6366, da7219 and max98357
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>
CC:     <aaronyu@google.com>, <matthias.bgg@gmail.com>,
        <trevor.wu@mediatek.com>, <tzungbi@google.com>,
        <julianbraha@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 5 Apr 2022 12:06:29 +0800
In-Reply-To: <d13b7bb3-989c-55eb-c7b9-41836ccb95a9@collabora.com>
References: <20220313151023.21229-1-jiaxin.yu@mediatek.com>
         <20220313151023.21229-16-jiaxin.yu@mediatek.com>
         <d13b7bb3-989c-55eb-c7b9-41836ccb95a9@collabora.com>
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

On Mon, 2022-03-14 at 11:44 +0100, AngeloGioacchino Del Regno wrote:
> Il 13/03/22 16:10, Jiaxin Yu ha scritto:
> > Add support for mt8186 board with mt6366, da7219 and max98357.
> > 
> > Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> > ---
> >   .../mt8186/mt8186-mt6366-da7219-max98357.c    | 924
> > ++++++++++++++++++
> >   1 file changed, 924 insertions(+)
> >   create mode 100644 sound/soc/mediatek/mt8186/mt8186-mt6366-
> > da7219-max98357.c
> > 
> 
> Hello Jiaxin,
> 
> I see some duplication between this one and the mt6366-rt1019-
> rt5682s....
> ....for this reason, I would propose to split out the MT6366 bits
> into a
> common file, something like mt8186-mt6366-common.c, as to reduce the
> duplication.
> 

Hello Angelo,

I'm sorry to reply so later about this comment. I've been thinking
about the repetition of these two machine driver recently. The biggest
difference between them are the .init .ops and .be_hw_params_fixup
callback functions of BE's dai_link. So I want break them down into
rt1019-rt5682s.c and da7219-max98357.c, the rest becomes mt8186-
mt6366.c.

SND_SOC_MT8186_MT6366 ==> mt8186-mt6366.c
SND_SOC_RT1019_RT5682S ==> rt1019-rt5682s.c
SND_SOC_DA7219_MAX98357 ==> da7219-max98357.c

Or put these three files in the same mt8186-mt6366.c, then distinguish
by different compatible string.

If it is expected to see MT8186 machines with DA7219 or MAX98357,
> then it'd be a
> good idea to also do something about preventively commonizing these
> ones, like
> it is being done in ... MT8192, if I remember correctly.
> 
> Regards,
> Angelo

Yes, I will change this part that being done in MT8192 to simplify the
code. But the part of mt8192 is being reviewed. I'm not sure if you
have any comments about this series.

Link: 
https://lore.kernel.org/linux-arm-kernel/20220402051754.17513-1-jiaxin.yu@mediatek.com/T/

Jiaxin.Yu
Thanks.



