Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035A452E860
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 11:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347582AbiETJIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 05:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347452AbiETJIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 05:08:44 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C37C13C1D5;
        Fri, 20 May 2022 02:08:43 -0700 (PDT)
X-UUID: fa57006af4d64a719e7146ce2c2c3ca2-20220520
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:4add1bdb-e9bd-4862-baff-fa1712f6496c,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:6946ff79-5ef6-470b-96c9-bdb8ced32786,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:-5,EDM:-3,IP:nil,URL:0,File:ni
        l,QS:0,BEC:nil
X-UUID: fa57006af4d64a719e7146ce2c2c3ca2-20220520
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1345200159; Fri, 20 May 2022 17:08:35 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 20 May 2022 17:08:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 20 May 2022 17:08:34 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <angelogioacchino.delregno@collabora.com>
CC:     <chun-jie.chen@mediatek.com>, <jose.exposito89@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <mturquette@baylibre.com>,
        <p.zabel@pengutronix.de>, <rex-bc.chen@mediatek.com>,
        <sboyd@kernel.org>, <wenst@chromium.org>,
        <y.oudjana@protonmail.com>, <yassine.oudjana@gmail.com>,
        <~postmarketos/upstreaming@lists.sr.ht>
Subject: Re: [PATCH 3/6] clk: mediatek: reset: Return reset data pointer on register
Date:   Fri, 20 May 2022 17:08:34 +0800
Message-ID: <20220520090834.28515-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <5b5f6656-8694-dc78-ef42-7ce301849aa4@collabora.com>
References: <5b5f6656-8694-dc78-ef42-7ce301849aa4@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Il 19/05/22 15:47, Yassine Oudjana ha scritto:
> > From: Yassine Oudjana <y.oudjana@protonmail.com>
> > 
> > Return a struct mtk_clk_rst_data * when registering a reset
> > controller in preparation for adding an unregister helper
> > that will take it as an argument. Make the necessary changes
> > in drivers that do not currently discard the return value
> > of register functions.
> > 
> > Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Hello Yassine,
> 
> Thanks for your efforts on helping to make the MediaTek clocks better - I agree
> (and I'm not the only one..) that there's a lot of work to do on this side.
> 
> Though... I don't think that this is the right direction: you're right about
> properly unregistering (in patch 4/6) the reset controllers on rmmod/failure
> but I'm not sure that this kind of noise brings any benefit.
> 
> Explaining:
> You definitely saw that there's a new register _with_dev, which uses devm ops
> and that's going to automatically cleanup in case of removal/failure.
> This is what we should do.
> 
> Hence, my proposal is to drop patch 3/6, 4/6, 5/6 and (slowly, steadily) migrate
> all of the MediaTek clocks from CLK_OF_DECLARE() to platform drivers (which also
> means that we can eventually change them to tristate!), so that we slowly remove
> all users of all functions that are not "_with_dev", and that we finally remove
> all of these then-unused functions as well.
> 
> Making sure that I don't get misunderstood:
>       I'm not implying that this huge migration work is on your shoulders!
> 
> P.S.: Chen-Yu, Miles: do you also agree? :-)

Agreed. 3/6, 4/6, 5/6 introduce mtk_simple_clk_controller, but we just got
ChenYu's patch merged to clk-next to switch to clk_hw_onecell_data, and
hoplefully we can test them in v5.18 or v5.19.
So I think we should wait for ChenYu's cleanup.

-	struct clk_hw_onecell_data *clk_data;
+	struct mtk_simple_clk_controller *clk_ctrl;

thanks,
Miles

> 
> Cheers,
> Angelo
> 
> 
