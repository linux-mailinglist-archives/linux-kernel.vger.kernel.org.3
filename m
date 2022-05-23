Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D5653089C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 07:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiEWFMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 01:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiEWFMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 01:12:25 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A01B7F9;
        Sun, 22 May 2022 22:12:23 -0700 (PDT)
X-UUID: 713976cac25843b38e3f1b02100ec3a0-20220523
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:cdc6de88-06bb-4378-b983-7ac67122d1ac,OB:40,L
        OB:10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:45
X-CID-INFO: VERSION:1.1.5,REQID:cdc6de88-06bb-4378-b983-7ac67122d1ac,OB:40,LOB
        :10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-META: VersionHash:2a19b09,CLOUDID:2a872ce3-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:c4fd7da82419,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:0,BEC:nil
X-UUID: 713976cac25843b38e3f1b02100ec3a0-20220523
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 672057008; Mon, 23 May 2022 13:12:21 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 23 May 2022 13:12:19 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 23 May 2022 13:12:19 +0800
Message-ID: <5484a9e2be7e71c3ecc86f4184f076be09ee9420.camel@mediatek.com>
Subject: Re: [PATCH v7 00/19] Cleanup MediaTek clk reset drivers and support
 SoCs
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     "=?ISO-8859-1?Q?N=EDcolas?= F. R. A. Prado" <nfraprado@collabora.com>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <p.zabel@pengutronix.de>,
        <angelogioacchino.delregno@collabora.com>,
        <chun-jie.chen@mediatek.com>, <wenst@chromium.org>,
        <runyang.chen@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 23 May 2022 13:12:19 +0800
In-Reply-To: <20220520154020.dywardvr3silhjwk@notapiano>
References: <20220519125527.18544-1-rex-bc.chen@mediatek.com>
         <20220520154020.dywardvr3silhjwk@notapiano>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-20 at 11:40 -0400, Nícolas F. R. A. Prado wrote:
> On Thu, May 19, 2022 at 08:55:08PM +0800, Rex-BC Chen wrote:
> > In this series, we cleanup MediaTek clock reset drivers in
> > clk/mediatek
> > folder. MediaTek clock reset driver is used to provide reset
> > control
> > of modules controlled in clk, like infra_ao.
> > 
> > Changes for v7:
> > 1. v7 is based on linux-next next-20220519 and Chen-Yu's series[1].
> > 2. Add support for MT8186.
> > 
> > [1]: 
> > https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/list/?series=643003__;!!CTRNKA9wMg0ARbw!3N_R1R2qXYd-vLUE-Bzrc1ZD_39liFO6Vz_RyJdPiuAyoMHO4TuaoOwWk1ka50bVe_0fdyJakB-FzCLGjzdVtsd6sQ$
> >  
> > 
> > Changes for v6:
> > 1. Add a new patch to support inuput argument index mode.
> > 2. Revise definition in reset.h to index.
> > 
> > Rex-BC Chen (19):
> >   clk: mediatek: reset: Add reset.h
> >   clk: mediatek: reset: Fix written reset bit offset
> >   clk: mediatek: reset: Refine and reorder functions in reset.c
> >   clk: mediatek: reset: Extract common drivers to update function
> >   clk: mediatek: reset: Merge and revise reset register function
> >   clk: mediatek: reset: Revise structure to control reset register
> >   clk: mediatek: reset: Support nonsequence base offsets of reset
> >     registers
> >   clk: mediatek: reset: Support inuput argument index mode
> >   clk: mediatek: reset: Change return type for clock reset register
> >     function
> >   clk: mediatek: reset: Add new register reset function with device
> >   clk: mediatek: reset: Add reset support for simple probe
> >   dt-bindings: arm: mediatek: Add #reset-cells property for
> >     MT8192/MT8195
> >   dt-bindings: reset: mediatek: Add infra_ao reset index for
> >     MT8192/MT8195
> >   clk: mediatek: reset: Add infra_ao reset support for
> > MT8192/MT8195
> >   arm64: dts: mediatek: Add infra #reset-cells property for MT8192
> >   arm64: dts: mediatek: Add infra #reset-cells property for MT8195
> >   dt-bindings: reset: mediatek: Add infra_ao reset index for MT8186
> >   dt-bindings: arm: mediatek: Add #reset-cells property for MT8186
> >   clk: mediatek: reset: Add infra_ao reset support for MT8186
> 
> For the whole series:
> 
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> And also
> 
> Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> on mt8192-asurada-spherion. PCIe resets work as intended by adding on
> the pcie
> node 
> 
> +                       resets = <&infracfg
> MT8192_INFRA_RST2_PEXTP_PHY_SWRST>,
> +                                <&infracfg
> MT8192_INFRA_RST4_PCIE_TOP_SWRST>;
> +                       reset-names = "phy", "mac";
> 
> Thanks for the great work on this series, Rex!
> 
> Nícolas

Hello Nícolas,

Thanks for helping me to test this series in MT8192.

BRs,
Rex

