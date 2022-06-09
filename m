Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BF6544513
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 09:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiFIHr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 03:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240274AbiFIHr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 03:47:56 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83114BFFC;
        Thu,  9 Jun 2022 00:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1654760872; x=1686296872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fsa5EmOiQ2/qJ8yHiEDRmMuiNITD7r+Q103FUs88anw=;
  b=TcsLegAz7oATkTWm6e1u3spl3O9G2eRdF/M7Gka+Sk0SX4JsHhDQL7oN
   VXkc/2/aEUoLZShDbRs9wAhm0OVESqX/EI1uEuYfnPUWU68OFtVbfKVF6
   5QTPyD2J8vH2Dvrmu2p0cR/rol7ifBfYFJpBxmOYn0PpnQ+aFrHGmCWcN
   F2wazhqs2qVvR6ofpud+4Lq22C58+XmUIrhfAwUJCB3e6kOlsR1PyUZzB
   6/UQN0nEJE318xDjf99Uex630AjbR97XO7G0+uOMZbols1Tbbu/01QJJn
   8YXkEbSUA9vk2byXg5Xd4L26pqvLGMtUzSt3sf+9bwIv1OwkqxZ1cNgFF
   A==;
X-IronPort-AV: E=Sophos;i="5.91,287,1647298800"; 
   d="scan'208";a="24347917"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 09 Jun 2022 09:47:46 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 09 Jun 2022 09:47:46 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 09 Jun 2022 09:47:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1654760866; x=1686296866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fsa5EmOiQ2/qJ8yHiEDRmMuiNITD7r+Q103FUs88anw=;
  b=eiUf5qa+zvPNseiSzGs6puPAV28lOewCA/i0FmeD6NpgjxxMULpLw/xi
   EywfgVAsD9FZAZ2h/Eo6GsYbCdyfLtXdyaDOqCrn2iZfBRar4kmhIYJqw
   6V8YU9EPM5kEy4UyXI+zA8Rd7S4TrQNHwyFc8SiWQTHzI4ctTxqDEzEW2
   qrQoZZsjmy2Qorti025pLBY3akLDueDu+AO1Gd9/GxBYlsDBpYBMwztEf
   PmlgEXRuLi0rLwh9SKG+tUHCck3+A/N1aljSDvmB06JfKRKu9zqqvx8x+
   J3ALBmXrDPF+hVJ/AEMNjjZ5uNdRtHzg282jRvC/wnkZKVHcdfBxI1HLp
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,287,1647298800"; 
   d="scan'208";a="24347916"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 09 Jun 2022 09:47:46 +0200
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 608F6280056;
        Thu,  9 Jun 2022 09:47:45 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, andrzej.hajda@intel.com,
        narmstrong@baylibre.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, lee.jones@linaro.org,
        mchehab@kernel.org, marcel.ziswiler@toradex.com
Subject: Re: (EXT) [PATCH v8 09/14] drm/bridge: imx: Add LDB driver helper support
Date:   Thu, 09 Jun 2022 09:47:43 +0200
Message-ID: <4748166.31r3eYUQgx@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20220609064931.3068601-10-victor.liu@nxp.com>
References: <20220609064931.3068601-1-victor.liu@nxp.com> <20220609064931.3068601-10-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 9. Juni 2022, 08:49:26 CEST schrieb Liu Ying:
> This patch adds a helper to support LDB drm bridge drivers for
> i.MX SoCs.  Helper functions supported by this helper should
> implement common logics for all LDB modules embedded in i.MX SoCs.
> 
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com> # Colibri iMX8X,
> LT170410-2WHC, LP156WF1 Reviewed-by: Robert Foss <robert.foss@linaro.org>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---

Hi,

reading this I got reminded of fsl-ldb [1], which is accepted already. At a 
first glance reading the RM the LDB peripheral are similar, although not 
identical. Is it worth merging them into one driver (at some point)?

Best regards,
Alexander

[1] https://patchwork.freedesktop.org/patch/msgid/20220426193645.244792-2-marex@denx.de

> Marcel, I add your T-b tag from v6, let me know if you want me to drop it,
> as the checkpatch fix in v7 and the rebase in v8 are trivial.
> 
> v7->v8:
> * Use devm_drm_of_get_bridge() due to the rebase upon v5.19-rc1.
> 
> v6->v7:
> * Fix below complaints from 'checkpatch.pl --strict'. (Robert)
>    - 'Alignment should match open parenthesis'
>    - 'Prefer using the BIT macro'
> * Add Marcel's T-b tag.
> * Add Robert's R-b tag.
> 
> v5->v6:
> * No change.
> 
> v4->v5:
> * Make imx-ldb-helper be a pure object to be linked with i.MX8qxp LDB bridge
> driver and i.MX8qm LDB bridge driver. (Robert)
> * Move 'imx_ldb_helper.h' to 'drivers/gpu/drm/bridge/imx/imx-ldb-helper.h'.
>   (Robert)
> * s/__FSL_IMX_LDB__/__IMX_LDB_HELPER__/  for 'imx-ldb-helper.h'.
> 
> v3->v4:
> * No change.
> 
> v2->v3:
> * Call syscon_node_to_regmap() to get regmap instead of
>   syscon_regmap_lookup_by_phandle().
> 
> v1->v2:
> * No change.
> 
>  drivers/gpu/drm/bridge/imx/imx-ldb-helper.c | 220 ++++++++++++++++++++
>  drivers/gpu/drm/bridge/imx/imx-ldb-helper.h |  96 +++++++++
>  2 files changed, 316 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/imx/imx-ldb-helper.c
>  create mode 100644 drivers/gpu/drm/bridge/imx/imx-ldb-helper.h
> 
> diff --git a/drivers/gpu/drm/bridge/imx/imx-ldb-helper.c
> b/drivers/gpu/drm/bridge/imx/imx-ldb-helper.c new file mode 100644
> index 000000000000..e85eb9ab5947
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/imx/imx-ldb-helper.c
> @@ -0,0 +1,220 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2012 Sascha Hauer, Pengutronix
> + * Copyright 2019,2020,2022 NXP
> + */
> +
> +#include <linux/mfd/syscon.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +
> +#include <drm/drm_bridge.h>
> +#include <drm/drm_of.h>
> +#include <drm/drm_print.h>
> +
> +#include "imx-ldb-helper.h"
> +
> +bool ldb_channel_is_single_link(struct ldb_channel *ldb_ch)
> +{
> +	return ldb_ch->link_type == LDB_CH_SINGLE_LINK;
> +}
> +
> +bool ldb_channel_is_split_link(struct ldb_channel *ldb_ch)
> +{
> +	return ldb_ch->link_type == LDB_CH_DUAL_LINK_EVEN_ODD_PIXELS ||
> +	       ldb_ch->link_type == LDB_CH_DUAL_LINK_ODD_EVEN_PIXELS;
> +}
> +
> +int ldb_bridge_atomic_check_helper(struct drm_bridge *bridge,
> +				   struct drm_bridge_state 
*bridge_state,
> +				   struct drm_crtc_state 
*crtc_state,
> +				   struct drm_connector_state 
*conn_state)
> +{
> +	struct ldb_channel *ldb_ch = bridge->driver_private;
> +
> +	ldb_ch->in_bus_format = bridge_state->input_bus_cfg.format;
> +	ldb_ch->out_bus_format = bridge_state->output_bus_cfg.format;
> +
> +	return 0;
> +}
> +
> +void ldb_bridge_mode_set_helper(struct drm_bridge *bridge,
> +				const struct drm_display_mode 
*mode,
> +				const struct drm_display_mode 
*adjusted_mode)
> +{
> +	struct ldb_channel *ldb_ch = bridge->driver_private;
> +	struct ldb *ldb = ldb_ch->ldb;
> +	bool is_split = ldb_channel_is_split_link(ldb_ch);
> +
> +	if (is_split)
> +		ldb->ldb_ctrl |= LDB_SPLIT_MODE_EN;
> +
> +	switch (ldb_ch->out_bus_format) {
> +	case MEDIA_BUS_FMT_RGB666_1X7X3_SPWG:
> +		break;
> +	case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG:
> +		if (ldb_ch->chno == 0 || is_split)
> +			ldb->ldb_ctrl |= LDB_DATA_WIDTH_CH0_24;
> +		if (ldb_ch->chno == 1 || is_split)
> +			ldb->ldb_ctrl |= LDB_DATA_WIDTH_CH1_24;
> +		break;
> +	case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA:
> +		if (ldb_ch->chno == 0 || is_split)
> +			ldb->ldb_ctrl |= LDB_DATA_WIDTH_CH0_24 |
> +					 LDB_BIT_MAP_CH0_JEIDA;
> +		if (ldb_ch->chno == 1 || is_split)
> +			ldb->ldb_ctrl |= LDB_DATA_WIDTH_CH1_24 |
> +					 LDB_BIT_MAP_CH1_JEIDA;
> +		break;
> +	}
> +}
> +
> +void ldb_bridge_enable_helper(struct drm_bridge *bridge)
> +{
> +	struct ldb_channel *ldb_ch = bridge->driver_private;
> +	struct ldb *ldb = ldb_ch->ldb;
> +
> +	/*
> +	 * Platform specific bridge drivers should set ldb_ctrl properly
> +	 * for the enablement, so just write the ctrl_reg here.
> +	 */
> +	regmap_write(ldb->regmap, ldb->ctrl_reg, ldb->ldb_ctrl);
> +}
> +
> +void ldb_bridge_disable_helper(struct drm_bridge *bridge)
> +{
> +	struct ldb_channel *ldb_ch = bridge->driver_private;
> +	struct ldb *ldb = ldb_ch->ldb;
> +	bool is_split = ldb_channel_is_split_link(ldb_ch);
> +
> +	if (ldb_ch->chno == 0 || is_split)
> +		ldb->ldb_ctrl &= ~LDB_CH0_MODE_EN_MASK;
> +	if (ldb_ch->chno == 1 || is_split)
> +		ldb->ldb_ctrl &= ~LDB_CH1_MODE_EN_MASK;
> +
> +	regmap_write(ldb->regmap, ldb->ctrl_reg, ldb->ldb_ctrl);
> +}
> +
> +int ldb_bridge_attach_helper(struct drm_bridge *bridge,
> +			     enum drm_bridge_attach_flags flags)
> +{
> +	struct ldb_channel *ldb_ch = bridge->driver_private;
> +	struct ldb *ldb = ldb_ch->ldb;
> +
> +	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)) {
> +		DRM_DEV_ERROR(ldb->dev,
> +			      "do not support creating a 
drm_connector\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!bridge->encoder) {
> +		DRM_DEV_ERROR(ldb->dev, "missing encoder\n");
> +		return -ENODEV;
> +	}
> +
> +	return drm_bridge_attach(bridge->encoder,
> +				ldb_ch->next_bridge, bridge,
> +				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> +}
> +
> +int ldb_init_helper(struct ldb *ldb)
> +{
> +	struct device *dev = ldb->dev;
> +	struct device_node *np = dev->of_node;
> +	struct device_node *child;
> +	int ret;
> +	u32 i;
> +
> +	ldb->regmap = syscon_node_to_regmap(np->parent);
> +	if (IS_ERR(ldb->regmap)) {
> +		ret = PTR_ERR(ldb->regmap);
> +		if (ret != -EPROBE_DEFER)
> +			DRM_DEV_ERROR(dev, "failed to get regmap: 
%d\n", ret);
> +		return ret;
> +	}
> +
> +	for_each_available_child_of_node(np, child) {
> +		struct ldb_channel *ldb_ch;
> +
> +		ret = of_property_read_u32(child, "reg", &i);
> +		if (ret || i > MAX_LDB_CHAN_NUM - 1) {
> +			ret = -EINVAL;
> +			DRM_DEV_ERROR(dev,
> +				      "invalid channel node 
address: %u\n", i);
> +			of_node_put(child);
> +			return ret;
> +		}
> +
> +		ldb_ch = ldb->channel[i];
> +		ldb_ch->ldb = ldb;
> +		ldb_ch->chno = i;
> +		ldb_ch->is_available = true;
> +		ldb_ch->np = child;
> +
> +		ldb->available_ch_cnt++;
> +	}
> +
> +	return 0;
> +}
> +
> +int ldb_find_next_bridge_helper(struct ldb *ldb)
> +{
> +	struct device *dev = ldb->dev;
> +	struct ldb_channel *ldb_ch;
> +	int ret, i;
> +
> +	for (i = 0; i < MAX_LDB_CHAN_NUM; i++) {
> +		ldb_ch = ldb->channel[i];
> +
> +		if (!ldb_ch->is_available)
> +			continue;
> +
> +		ldb_ch->next_bridge = devm_drm_of_get_bridge(dev, 
ldb_ch->np,
> +							     
1, 0);
> +		if (IS_ERR(ldb_ch->next_bridge)) {
> +			ret = PTR_ERR(ldb_ch->next_bridge);
> +			if (ret != -EPROBE_DEFER)
> +				DRM_DEV_ERROR(dev,
> +					      "failed to get 
next bridge: %d\n",
> +					      ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +void ldb_add_bridge_helper(struct ldb *ldb,
> +			   const struct drm_bridge_funcs 
*bridge_funcs)
> +{
> +	struct ldb_channel *ldb_ch;
> +	int i;
> +
> +	for (i = 0; i < MAX_LDB_CHAN_NUM; i++) {
> +		ldb_ch = ldb->channel[i];
> +
> +		if (!ldb_ch->is_available)
> +			continue;
> +
> +		ldb_ch->bridge.driver_private = ldb_ch;
> +		ldb_ch->bridge.funcs = bridge_funcs;
> +		ldb_ch->bridge.of_node = ldb_ch->np;
> +
> +		drm_bridge_add(&ldb_ch->bridge);
> +	}
> +}
> +
> +void ldb_remove_bridge_helper(struct ldb *ldb)
> +{
> +	struct ldb_channel *ldb_ch;
> +	int i;
> +
> +	for (i = 0; i < MAX_LDB_CHAN_NUM; i++) {
> +		ldb_ch = ldb->channel[i];
> +
> +		if (!ldb_ch->is_available)
> +			continue;
> +
> +		drm_bridge_remove(&ldb_ch->bridge);
> +	}
> +}
> diff --git a/drivers/gpu/drm/bridge/imx/imx-ldb-helper.h
> b/drivers/gpu/drm/bridge/imx/imx-ldb-helper.h new file mode 100644
> index 000000000000..a0a5cde27fbc
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/imx/imx-ldb-helper.h
> @@ -0,0 +1,96 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +/*
> + * Copyright 2019,2020,2022 NXP
> + */
> +
> +#ifndef __IMX_LDB_HELPER__
> +#define __IMX_LDB_HELPER__
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_bridge.h>
> +#include <drm/drm_device.h>
> +#include <drm/drm_encoder.h>
> +#include <drm/drm_modeset_helper_vtables.h>
> +
> +#define LDB_CH0_MODE_EN_TO_DI0		BIT(0)
> +#define LDB_CH0_MODE_EN_TO_DI1		(3 << 0)
> +#define LDB_CH0_MODE_EN_MASK		(3 << 0)
> +#define LDB_CH1_MODE_EN_TO_DI0		BIT(2)
> +#define LDB_CH1_MODE_EN_TO_DI1		(3 << 2)
> +#define LDB_CH1_MODE_EN_MASK		(3 << 2)
> +#define LDB_SPLIT_MODE_EN		BIT(4)
> +#define LDB_DATA_WIDTH_CH0_24		BIT(5)
> +#define LDB_BIT_MAP_CH0_JEIDA		BIT(6)
> +#define LDB_DATA_WIDTH_CH1_24		BIT(7)
> +#define LDB_BIT_MAP_CH1_JEIDA		BIT(8)
> +#define LDB_DI0_VS_POL_ACT_LOW		BIT(9)
> +#define LDB_DI1_VS_POL_ACT_LOW		BIT(10)
> +
> +#define MAX_LDB_CHAN_NUM		2
> +
> +enum ldb_channel_link_type {
> +	LDB_CH_SINGLE_LINK,
> +	LDB_CH_DUAL_LINK_EVEN_ODD_PIXELS,
> +	LDB_CH_DUAL_LINK_ODD_EVEN_PIXELS,
> +};
> +
> +struct ldb;
> +
> +struct ldb_channel {
> +	struct ldb *ldb;
> +	struct drm_bridge bridge;
> +	struct drm_bridge *next_bridge;
> +	struct device_node *np;
> +	u32 chno;
> +	bool is_available;
> +	u32 in_bus_format;
> +	u32 out_bus_format;
> +	enum ldb_channel_link_type link_type;
> +};
> +
> +struct ldb {
> +	struct regmap *regmap;
> +	struct device *dev;
> +	struct ldb_channel *channel[MAX_LDB_CHAN_NUM];
> +	unsigned int ctrl_reg;
> +	u32 ldb_ctrl;
> +	unsigned int available_ch_cnt;
> +};
> +
> +#define bridge_to_ldb_ch(b)	container_of(b, struct ldb_channel, bridge)
> +
> +bool ldb_channel_is_single_link(struct ldb_channel *ldb_ch);
> +bool ldb_channel_is_split_link(struct ldb_channel *ldb_ch);
> +
> +int ldb_bridge_atomic_check_helper(struct drm_bridge *bridge,
> +				   struct drm_bridge_state 
*bridge_state,
> +				   struct drm_crtc_state 
*crtc_state,
> +				   struct drm_connector_state 
*conn_state);
> +
> +void ldb_bridge_mode_set_helper(struct drm_bridge *bridge,
> +				const struct drm_display_mode 
*mode,
> +				const struct drm_display_mode 
*adjusted_mode);
> +
> +void ldb_bridge_enable_helper(struct drm_bridge *bridge);
> +
> +void ldb_bridge_disable_helper(struct drm_bridge *bridge);
> +
> +int ldb_bridge_attach_helper(struct drm_bridge *bridge,
> +			     enum drm_bridge_attach_flags flags);
> +
> +int ldb_init_helper(struct ldb *ldb);
> +
> +int ldb_find_next_bridge_helper(struct ldb *ldb);
> +
> +void ldb_add_bridge_helper(struct ldb *ldb,
> +			   const struct drm_bridge_funcs 
*bridge_funcs);
> +
> +void ldb_remove_bridge_helper(struct ldb *ldb);
> +
> +#endif /* __IMX_LDB_HELPER__ */




