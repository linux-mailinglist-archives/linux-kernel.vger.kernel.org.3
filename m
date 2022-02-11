Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C8F4B1D0E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 04:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237291AbiBKDtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 22:49:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236363AbiBKDtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 22:49:46 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABDF26E7;
        Thu, 10 Feb 2022 19:49:41 -0800 (PST)
X-UUID: d06ba2d611cb44b6af1db57bbff36032-20220211
X-UUID: d06ba2d611cb44b6af1db57bbff36032-20220211
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <dawei.chien@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 431359559; Fri, 11 Feb 2022 11:49:36 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 11 Feb 2022 11:49:34 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Feb 2022 11:49:34 +0800
Message-ID: <fa9336d8fb2b24538f4ebcc2474a37bd8f7b8653.camel@mediatek.com>
Subject: Re: [V11, PATCH 12/19] interconnect: mediatek: Add interconnect
 provider driver
From:   Dawei Chien <dawei.chien@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Fan Chen <fan.chen@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        "James Liao" <jamesjj.liao@mediatek.com>,
        Henry Chen <henryc.chen@mediatek.com>
Date:   Fri, 11 Feb 2022 11:49:34 +0800
In-Reply-To: <abf785dd-c1d8-b433-f280-3c42043e4684@collabora.com>
References: <20210812085846.2628-1-dawei.chien@mediatek.com>
         <20210812085846.2628-13-dawei.chien@mediatek.com>
         <abf785dd-c1d8-b433-f280-3c42043e4684@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-02-03 at 16:19 +0100, AngeloGioacchino Del Regno wrote:
> Il 12/08/21 10:58, Dawei Chien ha scritto:
> > From: Henry Chen <henryc.chen@mediatek.com>
> > 
> > Introduce Mediatek MT6873/MT8183/MT8192 specific provider driver
> > using the interconnect framework.
> > 
> >               ICC provider         ICC Nodes
> >                                ----          ----
> >               ---------       |CPU |   |--- |VPU |
> >      -----   |         |-----  ----    |     ----
> >     |DRAM |--|DRAM     |       ----    |     ----
> >     |     |--|scheduler|----- |GPU |   |--- |DISP|
> >     |     |--|(EMI)    |       ----    |     ----
> >     |     |--|         |       -----   |     ----
> >      -----   |         |----- |MMSYS|--|--- |VDEC|
> >               ---------        -----   |     ----
> >                 /|\                    |     ----
> >                  |change DRAM freq     |--- |VENC|
> >               ----------               |     ----
> >              |  DVFSR   |              |
> >              |          |              |     ----
> >               ----------               |--- |IMG |
> >                                        |     ----
> >                                        |     ----
> >                                        |--- |CAM |
> >                                              ----
> > Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> > Reviewed-by: Georgi Djakov <georgi.djakov@linaro.org>
> 
> This patch deserves my Reviewed-by tag, but I cannot release that if
> the
> driver is not properly signed-off.

I would add singed-off tag on next version, thank you.

