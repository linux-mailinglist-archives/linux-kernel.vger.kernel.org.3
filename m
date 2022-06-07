Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0196553F458
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 05:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236220AbiFGDKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 23:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbiFGDKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 23:10:49 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7B4D0295;
        Mon,  6 Jun 2022 20:10:46 -0700 (PDT)
X-UUID: 549b59eda6404f65abd5b720e744a6f4-20220607
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:9e2bbc86-1cd8-49ab-8252-e5e5c7c7ebaf,OB:0,LO
        B:20,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:45
X-CID-INFO: VERSION:1.1.5,REQID:9e2bbc86-1cd8-49ab-8252-e5e5c7c7ebaf,OB:0,LOB:
        20,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:45
X-CID-META: VersionHash:2a19b09,CLOUDID:9a03687e-c8dc-403a-96e8-6237210dceee,C
        OID:e0ded3fc8b76,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:0,BEC:nil
X-UUID: 549b59eda6404f65abd5b720e744a6f4-20220607
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 516054270; Tue, 07 Jun 2022 11:10:38 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 7 Jun 2022 11:10:35 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 7 Jun 2022 11:10:35 +0800
Message-ID: <f971913e22a29b77df3a0eb3da3ea8d40a3b1be6.camel@mediatek.com>
Subject: Re: [PATCH v10 05/21] video/hdmi: Add audio_infoframe packing for DP
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Guillaume Ranquet <granquet@baylibre.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "Kishon Vijay Abraham I" <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, "Helge Deller" <deller@gmx.de>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>
CC:     Markus Schneider-Pargmann <msp@baylibre.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <linux-fbdev@vger.kernel.org>
Date:   Tue, 7 Jun 2022 11:10:35 +0800
In-Reply-To: <7ae7e42c-9225-2ff2-f167-8235ab4cadc3@collabora.com>
References: <20220523104758.29531-1-granquet@baylibre.com>
         <20220523104758.29531-6-granquet@baylibre.com>
         <7ae7e42c-9225-2ff2-f167-8235ab4cadc3@collabora.com>
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

On Wed, 2022-05-25 at 14:32 +0200, AngeloGioacchino Del Regno wrote:
> Il 23/05/22 12:47, Guillaume Ranquet ha scritto:
> > From: Markus Schneider-Pargmann <msp@baylibre.com>
> > 
> > Similar to HDMI, DP uses audio infoframes as well which are
> > structured
> > very similar to the HDMI ones.
> > 
> > This patch adds a helper function to pack the HDMI audio infoframe
> > for
> > DP, called hdmi_audio_infoframe_pack_for_dp().
> > hdmi_audio_infoframe_pack_only() is split into two parts. One of
> > them
> > packs the payload only and can be used for HDMI and DP.
> > 
> > Also constify the frame parameter in hdmi_audio_infoframe_check()
> > as
> > it is passed to hdmi_audio_infoframe_check_only() which expects a
> > const.
> > 
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> > ---
> >   drivers/video/hdmi.c           | 82 ++++++++++++++++++++++++++---
> > -----
> >   include/drm/dp/drm_dp_helper.h |  2 +
> 
> this has been moved... again... this time it's
> include/drm/display/drm_dp_helper.h
> 

Hello Angelo,

yes, I will rebase on 5.19-rc1 and fix this in next version.

BRs,
Bo-Chen
> >   include/linux/hdmi.h           |  7 ++-
> >   3 files changed, 71 insertions(+), 20 deletions(-)
> > 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

