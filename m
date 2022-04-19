Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B9C5066AE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349880AbiDSISw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349892AbiDSIS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:18:27 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22AB2F009;
        Tue, 19 Apr 2022 01:15:43 -0700 (PDT)
X-UUID: ffc4d363a4fe484c94746d57181154b2-20220419
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:72a0743e-9742-4747-84d6-b10151435cbb,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.4,REQID:72a0743e-9742-4747-84d6-b10151435cbb,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:faefae9,CLOUDID:c2305bef-06b0-4305-bfbf-554bfc9d151a,C
        OID:IGNORED,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:0,EDM:-3,File:ni
        l,QS:0,BEC:nil
X-UUID: ffc4d363a4fe484c94746d57181154b2-20220419
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1300040232; Tue, 19 Apr 2022 16:15:36 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 19 Apr 2022 16:15:36 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 19 Apr 2022 16:15:36 +0800
Message-ID: <438d21a46fffebdf858c327c92155b5b91646376.camel@mediatek.com>
Subject: Re: [PATCH 3/7] clk: mediatek: reset: Merge and revise reset
 register function
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <matthias.bgg@gmail.com>, <p.zabel@pengutronix.de>,
        <angelogioacchino.delregno@collabora.com>,
        <chun-jie.chen@mediatek.com>, <yong.liang@mediatek.com>,
        <runyang.chen@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <allen-kh.cheng@mediatek.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 19 Apr 2022 16:15:36 +0800
In-Reply-To: <CAGXv+5GQR27+iomwHfwYb0gB_QVTZSy6TaZ+1qViMmNPka3Yjw@mail.gmail.com>
References: <20220418132154.7401-1-rex-bc.chen@mediatek.com>
         <20220418132154.7401-4-rex-bc.chen@mediatek.com>
         <CAGXv+5GQR27+iomwHfwYb0gB_QVTZSy6TaZ+1qViMmNPka3Yjw@mail.gmail.com>
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

On Tue, 2022-04-19 at 15:26 +0800, Chen-Yu Tsai wrote:
> On Mon, Apr 18, 2022 at 9:22 PM Rex-BC Chen <rex-bc.chen@mediatek.com
> > wrote:
> > 
> > Merge the reset register function of v1 and v2 into one function.
> > - Input the version number to determine which version we will use.
> > - Add return value of reset register function for error handling.
> 
> Please do this in a separate patch. Also you are adding error
> messages
> for when of_clk_add_provider() fails, which is not mentioned either.
> 
> Most of these platform drivers require a good cleanup of their error
> handling anyway. It might be a good idea to tackle them later. Or if
> they look the same, you could try using coccinelle to do a bulk
> cleanup.
> 
> 
> Thanks
> ChenYu

Hello ChenYu,

I will separate the error handle in another patch.
I think I will just add a return value. As for cleanup the clock error 
handling flow, it's not the purpose of this series.

BRs,
Rex
> 
> > - Rename reset register function to "mtk_clk_register_rst_ctrl"

