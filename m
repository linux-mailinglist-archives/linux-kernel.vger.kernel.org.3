Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6066153E76C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239178AbiFFNn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239142AbiFFNnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:43:53 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF298BD0E;
        Mon,  6 Jun 2022 06:43:51 -0700 (PDT)
X-UUID: fb63aed083094e08ada62d7feae598d0-20220606
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:296c43a7-6d5a-4d93-babb-619a964f38f4,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:3228c6ad-3171-4dd4-a2d9-73b846daf167,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: fb63aed083094e08ada62d7feae598d0-20220606
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 270677423; Mon, 06 Jun 2022 21:43:46 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with ShadowRedundancy id 15.2.792.3;
 Mon, 6 Jun 2022 13:43:46 +0000
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 6 Jun 2022 17:52:31 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 6 Jun 2022 17:52:31 +0800
Message-ID: <fe9fae165443f0db55f2bac2bbe214f3b018052d.camel@mediatek.com>
Subject: Re: [PATCH v1 05/15] remoteproc: mediatek: Add SCP core 1 driver
 for dual-core scp
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Dustin L. Howett" <dustin@howett.net>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        "Brian Norris" <briannorris@chromium.org>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <weishunc@google.com>
Date:   Mon, 6 Jun 2022 17:52:31 +0800
In-Reply-To: <dd12145b-bbb3-b771-b8f7-075ea20bee17@collabora.com>
References: <20220601112201.15510-1-tinghan.shen@mediatek.com>
         <20220601112201.15510-6-tinghan.shen@mediatek.com>
         <dd12145b-bbb3-b771-b8f7-075ea20bee17@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-06-06 at 11:15 +0200, AngeloGioacchino Del Regno wrote:
> Il 01/06/22 13:21, Tinghan Shen ha scritto:
> > MT8195 SCP is a dual-core processor. The mtk_scp.c driver only controls
> > SCP core 0. This patch adds a basic driver to control the another core.
> > 
> > Core 1 and core 0 of the SCP are housed in the same subsys.They see
> > registers and memory in the same way.
> > 
> > Core 1 of the SCP features its own set of core configuration registers,
> > interrupt controller, timers, and DMAs. The rest of the peripherals
> > in this subsystem are shared by core 0 and core 1.
> > 
> > As for memory, core 1 has its own cache memory, and the SCP SRAM is shared
> > by core 0 and core 1.
> > 
> 
> Hello Tinghan,
> 
> checking all the patches that are introducing support for the secondary SCP core,
> it's clear that you're practically reusing *most of* mtk_scp in mtk_scp_dual.
> 
> I don't think that adding a new configuration option for MTK_SCP_DUALCORE (nor a
> new file just for that) is a good idea... the code is "short enough" so you should
> really just add support for multi-core SCP in mtk_scp.c instead.
> 
> After doing so, I have a hunch that we'll be able to reduce the size of this
> implementation even more, as I see literally too much common code :-)
> 

Hi Angelo,

Thanks for your review.

This series has 2 new files, mtk_scp_dual.c and mtk_scp_subdev.c.
Is your advice to merge both files into mtk_scp.c, 
or to merely merge mtk_scp_dual.c to mtk_scp.c?

Thanks,
TingHan



