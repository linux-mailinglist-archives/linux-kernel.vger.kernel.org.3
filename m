Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BB7552BEC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347077AbiFUH1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347048AbiFUH1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:27:12 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A781F22B13;
        Tue, 21 Jun 2022 00:27:09 -0700 (PDT)
X-UUID: 19db8c8726654863b28f9c5b736b49bb-20220621
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:198fdd82-d505-403b-89c2-a5f042339be1,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:b14ad71,CLOUDID:c4ee0b38-5e4b-44d7-80b2-bb618cb09d29,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 19db8c8726654863b28f9c5b736b49bb-20220621
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 130421415; Tue, 21 Jun 2022 15:27:05 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 21 Jun 2022 15:27:03 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 21 Jun 2022 15:27:03 +0800
Message-ID: <d16d04776e20b01323df8fc7cc83b989be4cdd30.camel@mediatek.com>
Subject: Re: [PATCH v11 05/10] drm/mediatek: Add MT8195 Embedded DisplayPort
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
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-fbdev@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 21 Jun 2022 15:27:03 +0800
In-Reply-To: <20220610105522.13449-6-rex-bc.chen@mediatek.com>
References: <20220610105522.13449-1-rex-bc.chen@mediatek.com>
         <20220610105522.13449-6-rex-bc.chen@mediatek.com>
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

Hi, Bo-Chen:

On Fri, 2022-06-10 at 18:55 +0800, Bo-Chen Chen wrote:
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
> [Bo-Chen: Cleanup the drivers and modify comments from reviewers]
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---

[snip]

> +
> +static int mtk_dp_parse_capabilities(struct mtk_dp *mtk_dp)
> +{
> +	u8 val;
> +	struct mtk_dp_train_info *train_info = &mtk_dp->train_info;
> +
> +	drm_dp_dpcd_writeb(&mtk_dp->aux, DP_SET_POWER,
> DP_SET_POWER_D0);
> +	usleep_range(2000, 5000);
> +
> +	drm_dp_read_dpcd_caps(&mtk_dp->aux, mtk_dp->rx_cap);
> +
> +	mtk_dp->rx_cap[DP_TRAINING_AUX_RD_INTERVAL] &=
> DP_TRAINING_AUX_RD_MASK;
> +
> +	train_info->link_rate = min_t(int, mtk_dp->max_linkrate,
> +				      mtk_dp->rx_cap[mtk_dp-
> >max_linkrate]);

drm_dp_max_link_rate(mtk_dp->rx_cap)

Regards,
CK

> +	train_info->lane_count = min_t(int, mtk_dp->max_lanes,
> +				       drm_dp_max_lane_count(mtk_dp-
> >rx_cap));
> +
> +	train_info->tps3 = drm_dp_tps3_supported(mtk_dp->rx_cap);
> +	train_info->tps4 = drm_dp_tps4_supported(mtk_dp->rx_cap);
> +
> +	train_info->sink_ssc = !!(mtk_dp->rx_cap[DP_MAX_DOWNSPREAD] &
> +				  DP_MAX_DOWNSPREAD_0_5);
> +
> +	train_info->sink_ssc = false;
> +
> +	drm_dp_dpcd_readb(&mtk_dp->aux, DP_MSTM_CAP, &val);
> +	if (val & DP_MST_CAP) {
> +		/* Clear DP_DEVICE_SERVICE_IRQ_VECTOR_ESI0 */
> +		drm_dp_dpcd_readb(&mtk_dp->aux,
> +				  DP_DEVICE_SERVICE_IRQ_VECTOR_ESI0,
> &val);
> +		if (val)
> +			drm_dp_dpcd_writeb(&mtk_dp->aux,
> +					   DP_DEVICE_SERVICE_IRQ_VECTOR
> _ESI0,
> +					   val);
> +	}
> +
> +	return 0;
> +}

