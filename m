Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41EB587880
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbiHBH6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbiHBH6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:58:01 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E64E5F92;
        Tue,  2 Aug 2022 00:57:56 -0700 (PDT)
X-UUID: a169ae0a84e34b859d7434690ecdbb59-20220802
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:3c2ccd96-f64d-4764-b20b-09b95d6661ac,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:161b0ed0-a6cf-4fb6-be1b-c60094821ca2,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: a169ae0a84e34b859d7434690ecdbb59-20220802
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1596637531; Tue, 02 Aug 2022 15:57:50 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 2 Aug 2022 15:57:49 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 2 Aug 2022 15:57:49 +0800
Message-ID: <e51eb3017495fc77c52e7fde507acd33a2893f6f.camel@mediatek.com>
Subject: Re: [PATCH v15 05/11] drm/mediatek: Add MT8195 Embedded DisplayPort
 driver
From:   CK Hu <ck.hu@mediatek.com>
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, <chunkuang.hu@kernel.org>,
        <p.zabel@pengutronix.de>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <matthias.bgg@gmail.com>, <deller@gmx.de>,
        <airlied@linux.ie>
CC:     <msp@baylibre.com>, <granquet@baylibre.com>,
        <jitao.shi@mediatek.com>, <wenst@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        <liangxu.xu@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-fbdev@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 2 Aug 2022 15:57:49 +0800
In-Reply-To: <20220727045035.32225-6-rex-bc.chen@mediatek.com>
References: <20220727045035.32225-1-rex-bc.chen@mediatek.com>
         <20220727045035.32225-6-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RDNS_NONE,SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bo-Chen:

On Wed, 2022-07-27 at 12:50 +0800, Bo-Chen Chen wrote:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> This patch adds a embedded displayport driver for the MediaTek mt8195
> SoC.
> 
> It supports the MT8195, the embedded DisplayPort units. It offers
> DisplayPort 1.4 with up to 4 lanes.
> 
> The driver creates a child device for the phy. The child device will
> never exist without the parent being active. As they are sharing a
> register range, the parent passes a regmap pointer to the child so
> that
> both can work with the same register range. The phy driver sets
> device
> data that is read by the parent to get the phy device that can be
> used
> to control the phy properties.
> 
> This driver is based on an initial version by
> Jitao shi <jitao.shi@mediatek.com>
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---

[snip]

> +
> +static int mtk_dp_train_tps_2_3(struct mtk_dp *mtk_dp, u8
> target_linkrate,
> +				u8 target_lane_count, u8 *lane_adjust,
> +				int *status_control, u8
> *prev_lane_adjust)
> +{
> +	u8 val;
> +	u8 link_status[DP_LINK_STATUS_SIZE] = {};
> +
> +	if (*status_control == 1) {
> +		if (mtk_dp->train_info.tps4) {
> +			mtk_dp_train_set_pattern(mtk_dp, 4);
> +			val = DP_TRAINING_PATTERN_4;
> +		} else if (mtk_dp->train_info.tps3) {
> +			mtk_dp_train_set_pattern(mtk_dp, 3);
> +			val = DP_LINK_SCRAMBLING_DISABLE |
> +				DP_TRAINING_PATTERN_3;
> +		} else {
> +			mtk_dp_train_set_pattern(mtk_dp, 2);
> +			val = DP_LINK_SCRAMBLING_DISABLE |
> +				DP_TRAINING_PATTERN_2;
> +		}

Only one of tps2, tps3, tps4 would be process, and the priority is tps4
> tps3 > tps2, so I would like use one variable for this.

if support tps4, train_info.tps = 4.
else if support tps3, train_info.tps = 3.
else train_info.tps = 2.

And this part would be almost the same as the part in
mtk_dp_train_tps_1(), so separate this part to a function.

Regards,
CK


> +		drm_dp_dpcd_writeb(&mtk_dp->aux,
> +				   DP_TRAINING_PATTERN_SET, val);
> +		drm_dp_dpcd_read(&mtk_dp->aux,
> +				 DP_ADJUST_REQUEST_LANE0_1,
> lane_adjust,
> +				 sizeof(*lane_adjust) * 2);
> +
> +		mtk_dp_train_update_swing_pre(mtk_dp,
> +					      target_lane_count,
> lane_adjust);
> +		*status_control = 2;
> +	}
> +
> +	drm_dp_link_train_channel_eq_delay(&mtk_dp->aux, mtk_dp-
> >rx_cap);
> +
> +	drm_dp_dpcd_read_link_status(&mtk_dp->aux, link_status);
> +
> +	if (drm_dp_channel_eq_ok(link_status, target_lane_count)) {
> +		mtk_dp->train_info.eq_done = true;
> +		dev_dbg(mtk_dp->dev, "Link train EQ pass\n");
> +		return 0;
> +	}
> +
> +	dev_dbg(mtk_dp->dev, "Link train EQ fail\n");
> +
> +	if (*prev_lane_adjust != link_status[4])
> +		*prev_lane_adjust = link_status[4];
> +
> +	return -EAGAIN;
> +}
> +

