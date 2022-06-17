Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9691454F501
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381676AbiFQKKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381655AbiFQKKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:10:50 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB356A02C;
        Fri, 17 Jun 2022 03:10:48 -0700 (PDT)
X-UUID: c532be217fc54cc69614eaa295a05c49-20220617
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:b14705de-28a6-4434-a274-7c34c82fd3c1,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:b14ad71,CLOUDID:d181e748-4c92-421c-ad91-b806c0f58b2a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: c532be217fc54cc69614eaa295a05c49-20220617
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1485325868; Fri, 17 Jun 2022 18:10:43 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 17 Jun 2022 18:10:43 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 17 Jun 2022 18:10:43 +0800
Message-ID: <a3c480a3aa87b87c707b92bc80040764d2434a03.camel@mediatek.com>
Subject: Re: [PATCH v2 2/2] clk: mediatek: clk-mt8195-vdo1: Reparent and set
 rate on vdo1_dpintf's parent
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
CC:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "Miles Chen =?UTF-8?Q?=28=E9=99=B3=E6=B0=91=E6=A8=BA=29?=" 
        <Miles.Chen@mediatek.com>,
        "chun-jie.chen@mediatek.com" <chun-jie.chen@mediatek.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 17 Jun 2022 18:10:42 +0800
In-Reply-To: <20220617093424.75589-3-angelogioacchino.delregno@collabora.com>
References: <20220617093424.75589-1-angelogioacchino.delregno@collabora.com>
         <20220617093424.75589-3-angelogioacchino.delregno@collabora.com>
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

On Fri, 2022-06-17 at 17:34 +0800, AngeloGioacchino Del Regno wrote:
> Like it was done for the vdo0_dp_intf0_dp_intf clock (used for eDP),
> add the CLK_SET_RATE_PARENT flag to CLK_VDO1_DPINTF (used for DP)
> and also fix its parent clock name as it has to be "top_dp" for two
> reasons:
>  - This is its real parent!
>  - Likewise to eDP/VDO0 counterpart, we need clock source
>    selection on CLK_TOP_DP.
> 
> Signed-off-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> Fixes: 269987505ba9 ("clk: mediatek: Add MT8195 vdosys1 clock
> support")
> 
Hello Angelo,

Thanks for this series.
I can use this series to do modetest using MT8195 Tomato Chromebook for
both dp and edp in kernel v5.19-rc1.

Therefore,
Tested-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
and,
Reviewed-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>

BRs,
Bo-Chen

