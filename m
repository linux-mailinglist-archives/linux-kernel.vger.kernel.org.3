Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACA64B6703
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbiBOJJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:09:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbiBOJI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:08:59 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E2313DDF;
        Tue, 15 Feb 2022 01:08:49 -0800 (PST)
X-UUID: a343c793e3574cacafd8132a8f336585-20220215
X-UUID: a343c793e3574cacafd8132a8f336585-20220215
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1841779167; Tue, 15 Feb 2022 17:08:47 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 15 Feb 2022 17:08:46 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Feb
 2022 17:08:45 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Feb 2022 17:08:45 +0800
Message-ID: <eb4a903b90020e8220768e9bb674b9de477006e3.camel@mediatek.com>
Subject: Re: [PATCH v22 5/7] soc: mediatek: SVS: add debug commands
From:   Roger Lu <roger.lu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Guenter Roeck <linux@roeck-us.net>
Date:   Tue, 15 Feb 2022 17:08:45 +0800
In-Reply-To: <0846872b-03da-ee5d-6a9d-e6c9fa754191@collabora.com>
References: <20220127033956.24585-1-roger.lu@mediatek.com>
         <20220127033956.24585-6-roger.lu@mediatek.com>
         <0846872b-03da-ee5d-6a9d-e6c9fa754191@collabora.com>
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

Hi AngeloGioacchino,

Excuse me for the late reply.

On Mon, 2022-01-31 at 12:11 +0100, AngeloGioacchino Del Regno wrote:
> Il 27/01/22 04:39, Roger Lu ha scritto:
> > The purpose of SVS is to help find the suitable voltages
> > for DVFS. Therefore, if SVS bank voltages are concerned
> > to be wrong, we can adjust SVS bank voltages by this patch.
> > 
> > Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> 
> 
> Hello Roger,
> I was thinking about what this patch is adding... and I have a few
> considerations.
> 
> It's nice to have a debugging mechanism to read the status and dump registers,
> as
> that's very helpful when doing heavy debugging of the IP... but adding the
> possibility to write a voltage offset may be very dangerous: think about the
> case
> in which, either for misconfiguration, or for any other reason, the debugfs
> entry
> that allows writing voffset becomes user-writable, or a user writes an
> impossibly
> high voffset.
> In case a very low (negative) voffset is entered, the platform would crash
> (denial
> of service); if a very high voffset is entered, hardware damage may occur.
> 
> For this reason, there are two proposals:
> 1. If you want to keep the debugfs voffset write, please constrain the
> permissible
>     voffset to an acceptable range that at least makes it unlikely to damage
> the HW;
>     Moreover, since voffset write is a feature that would be used in very
> limited
>     debugging cases, I think that this should be implemented over a build-time
>     configuration barrier... something like CONFIG_MTK_SVS_DEBUG_ALLOW_WRITE,
> or
>     similar;
> 2. Since it's very unlikely for someone to really play that much with a
> voltage
>     offset during runtime, and since this looks like something very machine
> specific
>     (perhaps addressing board-specific quirks?), I would suggest to add this
> as a
>     device-tree parameter instead, such as "mediatek,svs-voffset", as it is
> indeed
>     possible to specify both positive or negative values in DT.
> 
> I would prefer proposal 2, as it looks generally cleaner and way less risky.

Thanks for raising the considerations and give these great suggestions for us to
think about. Since these voffset read/write commands are used seldomly, we
decide to remove them for better system security.

> 
> Regards,
> Angelo

