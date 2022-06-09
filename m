Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE1E5441B8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 04:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237367AbiFIC6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 22:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiFIC6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 22:58:49 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED526E8EB;
        Wed,  8 Jun 2022 19:58:48 -0700 (PDT)
X-UUID: bf200434209c47ecbb24c360cc0a5148-20220609
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:8fb325ca-de2d-40f8-9c4c-80a2f91854e9,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:a8552ee5-2ba2-4dc1-b6c5-11feb6c769e0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: bf200434209c47ecbb24c360cc0a5148-20220609
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 615797572; Thu, 09 Jun 2022 10:58:44 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 9 Jun 2022 10:58:43 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 9 Jun 2022 10:58:42 +0800
Message-ID: <b3ab001a4a28767cf4f8a5b330b11ead80c5d48e.camel@mediatek.com>
Subject: Re: [PATCH v6 2/8] ASoC: mediatek: mt8186: add platform driver
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <robh+dt@kernel.org>, <angelogioacchino.delregno@collabora.com>,
        <aaronyu@google.com>, <matthias.bgg@gmail.com>,
        <trevor.wu@mediatek.com>, <tzungbi@google.com>,
        <julianbraha@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 9 Jun 2022 10:58:42 +0800
In-Reply-To: <YqCG+9YkuXsDeh/I@sirena.org.uk>
References: <20220607142046.28060-1-jiaxin.yu@mediatek.com>
         <20220607142046.28060-3-jiaxin.yu@mediatek.com>
         <YqCG+9YkuXsDeh/I@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-08 at 12:24 +0100, Mark Brown wrote:
> On Tue, Jun 07, 2022 at 10:20:40PM +0800, Jiaxin Yu wrote:
> 
> > +obj-$(CONFIG_SND_SOC_MT8186) += snd-soc-mt8186-afe.o
> > +obj-$(CONFIG_SND_SOC_MT8186_MT6366_DA7219_MAX98357) += mt8186-
> > mt6366-da7219-max98357.o
> > +obj-$(CONFIG_SND_SOC_MT8186_MT6366_RT1019_RT5682S) += mt8186-
> > mt6366-rt1019-rt5682s.o
> 
> This breaks bisection - these drivers are being added to the build
> here
> but the relevant source files aren't added until later on in the
> series
> so the commits in between won't build when the relevant Kconfig
> options
> are selected.  The Makefile and Kconfig updates should be moved into
> the
> driver patches.

I see, this is to ensure the independence of each patch. I will move
the Kconfig and Makefile changes related to the machine driver to the
corresponding patch.

Thanks,
Jiaxin.Yu

