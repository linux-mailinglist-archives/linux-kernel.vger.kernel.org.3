Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515CB5064A4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348925AbiDSGkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 02:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348926AbiDSGkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 02:40:32 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3A42FFC1;
        Mon, 18 Apr 2022 23:37:50 -0700 (PDT)
X-UUID: 5050a3e5fa2e473cadd4620c6b5a9e99-20220419
X-UUID: 5050a3e5fa2e473cadd4620c6b5a9e99-20220419
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 842969871; Tue, 19 Apr 2022 14:37:42 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 19 Apr 2022 14:37:40 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 19 Apr
 2022 14:37:40 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 19 Apr 2022 14:37:40 +0800
Message-ID: <a5da87dbed150b8de4495da4a7f9b98d88e176a8.camel@mediatek.com>
Subject: Re: [PATCH 2/7] clk: mediatek: reset: Rename reset function
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
Date:   Tue, 19 Apr 2022 14:37:40 +0800
In-Reply-To: <CAGXv+5F027EsJCG4zQarcoqCR8S4tew1n1DjeqU7_+HOzmZs2Q@mail.gmail.com>
References: <20220418132154.7401-1-rex-bc.chen@mediatek.com>
         <20220418132154.7401-3-rex-bc.chen@mediatek.com>
         <CAGXv+5F027EsJCG4zQarcoqCR8S4tew1n1DjeqU7_+HOzmZs2Q@mail.gmail.com>
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

On Tue, 2022-04-19 at 13:57 +0800, Chen-Yu Tsai wrote:
> On Mon, Apr 18, 2022 at 9:22 PM Rex-BC Chen <rex-bc.chen@mediatek.com
> > wrote:
> > 
> > There are two version for clock reset register control of MediaTek
> > SoCs.
> > Since MT8183, the version 2 is adopted.
> > 
> > To make the driver more readable,
> > - Rename them to v2 for MT8183 and v1 for previous SoCs.
> > - Adjust the fuinction order in reset.c.
> 
> I'm not sure that the renaming actually helps, since it is not given
> that
> people outside of MediaTek would know which chip use which version.
> The
> original name of "_set_clr" at least relays how the hardware works,
> which
> coupled with the register naming in the datasheets make it quite
> obvious
> if the hardware is using the "set/clr" variant.
> 
> On a different note, the v1 hardware, where a hardware bit represents
> the
> state, is quite common, and there is a common reset driver that
> handles it.
> Perhaps that could be reused instead of code duplicated?
> See drivers/reset/reset-simple.c.
> 
> 
> Thanks
> ChenYu

Hello ChenYu,

Thanks for your review.
I will use reset_simple_ops to replace v1 in next version.

What do you think the proper name of v2?
Or I just use mtk_reset_assert for v2?

BRs,
Rex

