Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D37A5064AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348946AbiDSGlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 02:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348944AbiDSGlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 02:41:32 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40C42ED65;
        Mon, 18 Apr 2022 23:38:50 -0700 (PDT)
X-UUID: 76d3548de5da4a5aadd8b08a5b9e2abe-20220419
X-UUID: 76d3548de5da4a5aadd8b08a5b9e2abe-20220419
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1289611600; Tue, 19 Apr 2022 14:38:42 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 19 Apr 2022 14:38:41 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 19 Apr
 2022 14:38:40 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 19 Apr 2022 14:38:40 +0800
Message-ID: <7e6ca7055ad6c236cb43b73c0b32a435033bb37d.camel@mediatek.com>
Subject: Re: [PATCH 1/7] clk: mediatek: reset: Correct the logic of setting
 register
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
Date:   Tue, 19 Apr 2022 14:38:40 +0800
In-Reply-To: <CAGXv+5FXTft7-E5LnuZdNo8Tq6OKOKwt58GgJD_+z1N5u6B8yw@mail.gmail.com>
References: <20220418132154.7401-1-rex-bc.chen@mediatek.com>
         <20220418132154.7401-2-rex-bc.chen@mediatek.com>
         <CAGXv+5FXTft7-E5LnuZdNo8Tq6OKOKwt58GgJD_+z1N5u6B8yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-19 at 13:48 +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Mon, Apr 18, 2022 at 9:22 PM Rex-BC Chen <rex-bc.chen@mediatek.com
> > wrote:
> > 
> 
> The subject could be written as "Fix written reset bit offset" to
> make it
> more specific.

Hello ChenYu,

I will update the topic in next version.
Thanks for your suggestion.

BRs,
Rex

> 
> > Original assert/deassert bit is BIT(0), but it's more resonable to
> > modify
> > them to BIT(id % 32) which is based on id.
> > 
> > This patch will not influence any previous driver because the reset
> > is
> > only used for thermal. The id (MT8183_INFRACFG_AO_THERM_SW_RST) is
> > 0.
> > 
> > Fixes: 64ebb57a3df6 ("clk: reset: Modify reset-controller driver")
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> 
> Otherwise,
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

