Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0293F50AF48
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 06:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444012AbiDVFAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 01:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiDVFAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 01:00:47 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9074161D;
        Thu, 21 Apr 2022 21:57:53 -0700 (PDT)
X-UUID: 328bd78e30b3457ba9ae9926a8bd7a54-20220422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:746fa042-cc83-4c4a-a458-acf131eb5b2d,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:1,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:1
X-CID-META: VersionHash:faefae9,CLOUDID:a37390f0-da02-41b4-b6df-58f4ccd36682,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:4,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 328bd78e30b3457ba9ae9926a8bd7a54-20220422
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1202006429; Fri, 22 Apr 2022 12:57:49 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 22 Apr 2022 12:57:47 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Apr 2022 12:57:47 +0800
Message-ID: <f68239ac05bf119134b3203af9bd74d5af1bc6ba.camel@mediatek.com>
Subject: Re: [PATCH V2 02/12] clk: mediatek: reset: Use simple reset
 operations
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <matthias.bgg@gmail.com>, <p.zabel@pengutronix.de>,
        <chun-jie.chen@mediatek.com>, <wenst@chromium.org>,
        <runyang.chen@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <allen-kh.cheng@mediatek.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 22 Apr 2022 12:57:47 +0800
In-Reply-To: <da6fed21-f661-773d-307f-0c7085e3eb9b@collabora.com>
References: <20220420130527.23200-1-rex-bc.chen@mediatek.com>
         <20220420130527.23200-3-rex-bc.chen@mediatek.com>
         <da6fed21-f661-773d-307f-0c7085e3eb9b@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-04-21 at 11:08 +0200, AngeloGioacchino Del Regno wrote:
> Il 20/04/22 15:05, Rex-BC Chen ha scritto:
> > There are two version for clock reset register control of MediaTek
> > SoCs.
> > The reset operations before MT8183 can use simple reset to cover.
> > Therefore, we replace mtk_reset_ops with reset_simple_ops.
> > In addition, we also rename mtk_register_reset_controller to
> > mtk_register_reset_controller_simple.
> > 
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> 
> Hello Rex,
> have you tested this? It won't work.
> 
> reset-simple is not using regmap, and it requires you to pass a
> struct
> reset_simple_data through drvdata.
> 
> Besides, I like that we are using regmap, while reset_simple simply
> uses
> readl/writel... so if you want to use that driver, which is good to
> reduce
> duplication, you should also implement support for regmap in the form
> of
> reset_simple_regmap_ops.
> 
> Regards,
> Angelo

Hello Angelo,

Yes, I also notice the error..
The data we used is not reset_simple_data.
I will drop using reset_simple_ops and remain original functions in
next version.

BRs,
Rex

