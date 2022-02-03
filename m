Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2B44A872E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351621AbiBCPE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:04:57 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46860 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242302AbiBCPEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:04:55 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 0662D1F45D6D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643900693;
        bh=yRqiHTvDPVaaoZAN7/Y8QlY5gSCbxdufcdOqexm65Fs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=N90Gw9M0grizF0w9OyDwvTwqsvNTCnPOUzXLwc2EVUX/EeSWoSqqJ94tm1bJbewfR
         nYGaAY6Zm9gPzKxHKVCTDhKrhVOwg6MpJNfCgZ3aKKjsWPI/4C6w574uZbRsDhJYm0
         Rki/Ij9JNd8TxXzruyigDyDb81yMz2CNl+EiMTBrpKOJMFuDePHlW7xCIahWXWUcZN
         gxIVPZEgOGbDFcJQV/n2ehYy/tDU4bMf7XNV9iuzIB7Awwy0tWm9CYSSG8csQC5QlK
         msjqIcM2TWtgmkFmB72s5fs1NJWiTtKSL8BtdkuDfFdgNhgm60AT7/K+3ry7PSFbtY
         jjOGnpKWYSViw==
Message-ID: <3d1ba05d-0013-a9ac-1fe1-1d60e510c574@collabora.com>
Date:   Thu, 3 Feb 2022 16:04:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [V11,PATCH 04/19] soc: mediatek: add driver for dvfsrc support
Content-Language: en-US
To:     Dawei Chien <dawei.chien@mediatek.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Fan Chen <fan.chen@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Henry Chen <henryc.chen@mediatek.com>
References: <20210812085846.2628-1-dawei.chien@mediatek.com>
 <20210812085846.2628-5-dawei.chien@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20210812085846.2628-5-dawei.chien@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/08/21 10:58, Dawei Chien ha scritto:
> From: Henry Chen <henryc.chen@mediatek.com>
> 
> Add dvfsrc driver for MT6873/MT8183/MT8192
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
> ---
>   drivers/soc/mediatek/Kconfig            |  11 +
>   drivers/soc/mediatek/Makefile           |   1 +
>   drivers/soc/mediatek/mtk-dvfsrc.c       | 421 ++++++++++++++++++++++++++++++++
>   include/linux/soc/mediatek/mtk_dvfsrc.h |  35 +++
>   4 files changed, 468 insertions(+)
>   create mode 100644 drivers/soc/mediatek/mtk-dvfsrc.c
>   create mode 100644 include/linux/soc/mediatek/mtk_dvfsrc.h
> 
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index fdd8bc08569e..2dcf02384639 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -26,6 +26,17 @@ config MTK_DEVAPC
>   	  The violation information is logged for further analysis or
>   	  countermeasures.
>   
> +config MTK_DVFSRC
> +	tristate "MediaTek DVFSRC Support"
> +	depends on ARCH_MEDIATEK
> +	help
> +	  Say yes here to add support for the MediaTek DVFSRC (dynamic voltage
> +	  and frequency scaling resource collector) found
> +	  on different MediaTek SoCs. The DVFSRC is a proprietary
> +	  hardware which is used to collect all the requests from
> +	  system and turn into the decision of minimum Vcore voltage
> +	  and minimum DRAM frequency to fulfill those requests.
> +
>   config MTK_INFRACFG
>   	bool "MediaTek INFRACFG Support"
>   	select REGMAP
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> index 90270f8114ed..365d14fd7d49 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   obj-$(CONFIG_MTK_CMDQ) += mtk-cmdq-helper.o
>   obj-$(CONFIG_MTK_DEVAPC) += mtk-devapc.o
> +obj-$(CONFIG_MTK_DVFSRC) += mtk-dvfsrc.o
>   obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
>   obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
>   obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
> diff --git a/drivers/soc/mediatek/mtk-dvfsrc.c b/drivers/soc/mediatek/mtk-dvfsrc.c
> new file mode 100644
> index 000000000000..6ef167cf55bd
> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-dvfsrc.c
> @@ -0,0 +1,421 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 MediaTek Inc.
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/notifier.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/soc/mediatek/mtk_dvfsrc.h>
> +#include <linux/soc/mediatek/mtk_sip_svc.h>
> +
> +#define DVFSRC_IDLE     0x00
> +#define DVFSRC_GET_TARGET_LEVEL(x)  (((x) >> 0) & 0x0000ffff)
> +#define DVFSRC_GET_CURRENT_LEVEL(x) (((x) >> 16) & 0x0000ffff)
> +#define kbps_to_mbps(x) ((x) / 1000)
> +
> +#define POLL_TIMEOUT        1000
> +#define STARTUP_TIME        1
> +
> +#define MTK_SIP_DVFSRC_INIT		0x00
> +
> +#define DVFSRC_OPP_DESC(_opp_table)	\
> +{	\
> +	.opps = _opp_table,	\
> +	.num_opp = ARRAY_SIZE(_opp_table),	\
> +}
> +
> +struct dvfsrc_opp {
> +	u32 vcore_opp;
> +	u32 dram_opp;
> +};
> +
> +struct dvfsrc_opp_desc {
> +	const struct dvfsrc_opp *opps;
> +	u32 num_opp;
> +};
> +
> +struct mtk_dvfsrc;
> +struct dvfsrc_soc_data {
> +	const int *regs;
> +	const struct dvfsrc_opp_desc *opps_desc;
> +	int (*get_target_level)(struct mtk_dvfsrc *dvfsrc);
> +	int (*get_current_level)(struct mtk_dvfsrc *dvfsrc);
> +	u32 (*get_vcore_level)(struct mtk_dvfsrc *dvfsrc);
> +	u32 (*get_vcp_level)(struct mtk_dvfsrc *dvfsrc);
> +	void (*set_dram_bw)(struct mtk_dvfsrc *dvfsrc, u64 bw);
> +	void (*set_dram_peak_bw)(struct mtk_dvfsrc *dvfsrc, u64 bw);
> +	void (*set_dram_hrtbw)(struct mtk_dvfsrc *dvfsrc, u64 bw);
> +	void (*set_opp_level)(struct mtk_dvfsrc *dvfsrc, u32 level);
> +	void (*set_vcore_level)(struct mtk_dvfsrc *dvfsrc, u32 level);
> +	void (*set_vscp_level)(struct mtk_dvfsrc *dvfsrc, u32 level);
> +	int (*wait_for_opp_level)(struct mtk_dvfsrc *dvfsrc, u32 level);
> +	int (*wait_for_vcore_level)(struct mtk_dvfsrc *dvfsrc, u32 level);
> +};
> +
> +struct mtk_dvfsrc {
> +	struct device *dev;
> +	struct platform_device *icc;
> +	struct platform_device *regulator;
> +	const struct dvfsrc_soc_data *dvd;
> +	int dram_type;
> +	const struct dvfsrc_opp_desc *curr_opps;
> +	void __iomem *regs;
> +	spinlock_t req_lock;
> +	struct mutex pstate_lock;
> +	struct notifier_block scpsys_notifier;
> +};
> +
> +static u32 dvfsrc_read(struct mtk_dvfsrc *dvfs, u32 offset)
> +{
> +	return readl(dvfs->regs + dvfs->dvd->regs[offset]);
> +}
> +
> +static void dvfsrc_write(struct mtk_dvfsrc *dvfs, u32 offset, u32 val)
> +{
> +	writel(val, dvfs->regs + dvfs->dvd->regs[offset]);
> +}
> +
> +#define dvfsrc_rmw(dvfs, offset, val, mask, shift) \
> +	dvfsrc_write(dvfs, offset, \
> +		(dvfsrc_read(dvfs, offset) & ~(mask << shift)) | (val << shift))
> +

Hello Dawei,

is there any reason why you're not using regmap-mmio here?
If your concern is about regmap locking overhead, you can disable it by
setting disable_locking as true in the regmap_config.

> +enum dvfsrc_regs {
> +	DVFSRC_SW_REQ,
> +	DVFSRC_SW_REQ2,
> +	DVFSRC_LEVEL,
> +	DVFSRC_TARGET_LEVEL,
> +	DVFSRC_SW_BW,
> +	DVFSRC_SW_PEAK_BW,
> +	DVFSRC_SW_HRT_BW,
> +	DVFSRC_VCORE_REQUEST,
> +};
> +
> +static const int mt8183_regs[] = {
> +	[DVFSRC_SW_REQ] =	0x4,
> +	[DVFSRC_SW_REQ2] =	0x8,
> +	[DVFSRC_LEVEL] =	0xDC,
> +	[DVFSRC_SW_BW] =	0x160,
> +};
> +
> +static const struct dvfsrc_opp *get_current_opp(struct mtk_dvfsrc *dvfsrc)
> +{
> +	int level;

	int level = dvfsrc->dvd->get_current_level(dvfsrc);

> +
> +	level = dvfsrc->dvd->get_current_level(dvfsrc);
> +	return &dvfsrc->curr_opps->opps[level];
> +}
> +
> +static int dvfsrc_is_idle(struct mtk_dvfsrc *dvfsrc)
> +{
> +	if (!dvfsrc->dvd->get_target_level)
> +		return true;
> +
> +	return dvfsrc->dvd->get_target_level(dvfsrc);
> +}
> +
> +static int dvfsrc_wait_for_vcore_level(struct mtk_dvfsrc *dvfsrc, u32 level)
> +{
> +	const struct dvfsrc_opp *curr;
> +
> +	return readx_poll_timeout_atomic(get_current_opp, dvfsrc, curr,
> +					 curr->vcore_opp >= level, STARTUP_TIME,
> +					 POLL_TIMEOUT);
> +}
> +
> +static int mt8183_wait_for_opp_level(struct mtk_dvfsrc *dvfsrc, u32 level)
> +{
> +	const struct dvfsrc_opp *target, *curr;
> +	int ret;
> +
> +	target = &dvfsrc->curr_opps->opps[level];
> +	ret = readx_poll_timeout(get_current_opp, dvfsrc, curr,
> +				 curr->dram_opp >= target->dram_opp &&
> +				 curr->vcore_opp >= target->vcore_opp,
> +				 STARTUP_TIME, POLL_TIMEOUT);
> +	if (ret < 0) {
> +		dev_warn(dvfsrc->dev,
> +			 "timeout, target: %u, dram: %d, vcore: %d\n", level,
> +			 curr->dram_opp, curr->vcore_opp);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mt8183_get_target_level(struct mtk_dvfsrc *dvfsrc)
> +{
> +	return DVFSRC_GET_TARGET_LEVEL(dvfsrc_read(dvfsrc, DVFSRC_LEVEL));
> +}
> +
> +static int mt8183_get_current_level(struct mtk_dvfsrc *dvfsrc)
> +{
> +	int level;
> +
> +	/* HW level 0 is begin from 0x10000 */
> +	level = DVFSRC_GET_CURRENT_LEVEL(dvfsrc_read(dvfsrc, DVFSRC_LEVEL));
> +	/* Array index start from 0 */
> +	return ffs(level) - 1;
> +}
> +
> +static u32 mt8183_get_vcore_level(struct mtk_dvfsrc *dvfsrc)
> +{
> +	return (dvfsrc_read(dvfsrc, DVFSRC_SW_REQ2) >> 2) & 0x3;
> +}
> +
> +static void mt8183_set_dram_bw(struct mtk_dvfsrc *dvfsrc, u64 bw)
> +{

Is there any min/max allowed bw? If there is, please add a boudary check here.
Same for set_vcore_level.

> +	dvfsrc_write(dvfsrc, DVFSRC_SW_BW, div_u64(kbps_to_mbps(bw), 100));
> +}
> +
> +static void mt8183_set_opp_level(struct mtk_dvfsrc *dvfsrc, u32 level)
> +{
> +	int vcore_opp, dram_opp;
> +	const struct dvfsrc_opp *opp;
> +
> +	/* translate pstate to dvfsrc level, and set it to DVFSRC HW */
> +	opp = &dvfsrc->curr_opps->opps[level];
> +	vcore_opp = opp->vcore_opp;
> +	dram_opp = opp->dram_opp;
> +
> +	dev_dbg(dvfsrc->dev, "vcore_opp: %d, dram_opp: %d\n",
> +		vcore_opp, dram_opp);
> +	dvfsrc_write(dvfsrc, DVFSRC_SW_REQ, dram_opp | vcore_opp << 2);
> +}
> +
> +static void mt8183_set_vcore_level(struct mtk_dvfsrc *dvfsrc, u32 level)
> +{
> +	dvfsrc_write(dvfsrc, DVFSRC_SW_REQ2, level << 2);
> +}
> +
> +void mtk_dvfsrc_send_request(const struct device *dev, u32 cmd, u64 data)

int mtk_dvfsrc_send_request(......

> +{
> +	int ret, state;
> +	struct mtk_dvfsrc *dvfsrc = dev_get_drvdata(dev);
> +
> +	dev_dbg(dvfsrc->dev, "cmd: %d, data: %llu\n", cmd, data);
> +
> +	switch (cmd) {
> +	case MTK_DVFSRC_CMD_BW_REQUEST:
> +		dvfsrc->dvd->set_dram_bw(dvfsrc, data);
> +		return;
> +	case MTK_DVFSRC_CMD_PEAK_BW_REQUEST:
> +		if (dvfsrc->dvd->set_dram_peak_bw)
> +			dvfsrc->dvd->set_dram_peak_bw(dvfsrc, data);
> +		return;
> +	case MTK_DVFSRC_CMD_OPP_REQUEST:
> +		if (dvfsrc->dvd->set_opp_level)
> +			dvfsrc->dvd->set_opp_level(dvfsrc, data);
> +		break;
> +	case MTK_DVFSRC_CMD_VCORE_REQUEST:
> +		dvfsrc->dvd->set_vcore_level(dvfsrc, data);
> +		break;
> +	case MTK_DVFSRC_CMD_HRTBW_REQUEST:
> +		if (dvfsrc->dvd->set_dram_hrtbw)
> +			dvfsrc->dvd->set_dram_hrtbw(dvfsrc, data);
> +		else
> +			return;

			return -EINVAL;

> +		break;
> +	case MTK_DVFSRC_CMD_VSCP_REQUEST:
> +		dvfsrc->dvd->set_vscp_level(dvfsrc, data);
> +		break;
> +	default:
> +		dev_err(dvfsrc->dev, "unknown command: %d\n", cmd);
> +		return;

		return -EINVAL;

> +	}
> +
> +	/* DVFSRC needs to wait at least 2T(~196ns) to handle request
> +	 * after receiving command
> +	 */
> +	udelay(STARTUP_TIME);
> +
> +	ret = readx_poll_timeout(dvfsrc_is_idle, dvfsrc,
> +				 state, state == DVFSRC_IDLE,
> +				 STARTUP_TIME, POLL_TIMEOUT);
> +
> +	if (ret < 0) {
> +		dev_warn(dvfsrc->dev,
> +			 "%d: idle timeout, data: %llu, last: %d -> %d\n",
> +			 cmd, data,
> +			 dvfsrc->dvd->get_current_level(dvfsrc),
> +			 dvfsrc->dvd->get_target_level(dvfsrc));
> +		return;

		return ret;

> +	}
> +
> +	/* The previous change may be requested by previous request.
> +	 * So we delay 1us, then start checking opp is reached enough.
> +	 */
> +	udelay(STARTUP_TIME);
> +
> +	if (cmd == MTK_DVFSRC_CMD_OPP_REQUEST)
> +		ret = dvfsrc->dvd->wait_for_opp_level(dvfsrc, data);
> +	else
> +		ret = dvfsrc->dvd->wait_for_vcore_level(dvfsrc, data);
> +
> +	if (ret < 0) {
> +		dev_warn(dvfsrc->dev,
> +			 "%d: wait timeout, data: %llu, last: %d -> %d\n",
> +			 cmd, data,
> +			 dvfsrc->dvd->get_current_level(dvfsrc),
> +			 dvfsrc->dvd->get_target_level(dvfsrc));
> +	}
> +
> +}
> +EXPORT_SYMBOL(mtk_dvfsrc_send_request);
> +
> +int mtk_dvfsrc_query_info(const struct device *dev, u32 cmd, int *data)
> +{
> +	struct mtk_dvfsrc *dvfsrc = dev_get_drvdata(dev);
> +
> +	switch (cmd) {
> +	case MTK_DVFSRC_CMD_VCORE_LEVEL_QUERY:
> +		*data = dvfsrc->dvd->get_vcore_level(dvfsrc);
> +		break;
> +	case MTK_DVFSRC_CMD_VSCP_LEVEL_QUERY:
> +		*data = dvfsrc->dvd->get_vcp_level(dvfsrc);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(mtk_dvfsrc_query_info);
> +
> +static int mtk_dvfsrc_probe(struct platform_device *pdev)
> +{
> +	struct arm_smccc_res ares;
> +	struct resource *res;
> +	struct mtk_dvfsrc *dvfsrc;
> +	int ret;
> +
> +	dvfsrc = devm_kzalloc(&pdev->dev, sizeof(*dvfsrc), GFP_KERNEL);
> +	if (!dvfsrc)
> +		return -ENOMEM;
> +
> +	dvfsrc->dvd = of_device_get_match_data(&pdev->dev);
> +	dvfsrc->dev = &pdev->dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	dvfsrc->regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(dvfsrc->regs))
> +		return PTR_ERR(dvfsrc->regs);
> +
> +	spin_lock_init(&dvfsrc->req_lock);
> +	mutex_init(&dvfsrc->pstate_lock);
> +
> +	arm_smccc_smc(MTK_SIP_VCOREFS_CONTROL, MTK_SIP_DVFSRC_INIT, 0, 0, 0,
> +		0, 0, 0, &ares);
> +
> +	if (!ares.a0) {
> +		dvfsrc->dram_type = ares.a1;
> +		dev_info(dvfsrc->dev, "dram_type: %d\n", dvfsrc->dram_type);
> +	} else {
> +		dev_err(dvfsrc->dev, "init fails: %lu\n", ares.a0);
> +		return ares.a0;
> +	}
> +
> +	dvfsrc->curr_opps = &dvfsrc->dvd->opps_desc[dvfsrc->dram_type];
> +	platform_set_drvdata(pdev, dvfsrc);
> +
> +	dvfsrc->regulator = platform_device_register_data(dvfsrc->dev,
> +			"mtk-dvfsrc-regulator", -1, NULL, 0);

Why are you registering platform devices like this?

Please use device-tree instead.

> +	if (IS_ERR(dvfsrc->regulator)) {
> +		dev_err(dvfsrc->dev, "Failed create regulator device\n");
> +		ret = PTR_ERR(dvfsrc->regulator);
> +		goto err;
> +	}
> +
> +	dvfsrc->icc = platform_device_register_data(dvfsrc->dev,
> +			"mediatek-emi-icc", -1, NULL, 0);

Same here.

> +	if (IS_ERR(dvfsrc->icc)) {
> +		dev_err(dvfsrc->dev, "Failed create icc device\n");

As a side note, after applying the suggested flow, you will also be able
to use dev_err_probe() instead, simplifying this probe function.

> +		ret = PTR_ERR(dvfsrc->icc);
> +		goto unregister_regulator;
> +	}
> +
> +	ret = devm_of_platform_populate(&pdev->dev);
> +	if (ret)
> +		platform_device_unregister(dvfsrc->icc);
> +
> +	return 0;
> +
> +unregister_regulator:
> +	platform_device_unregister(dvfsrc->regulator);
> +err:
> +	return ret;
> +}
> +
> +static const struct dvfsrc_opp dvfsrc_opp_mt8183_lp4[] = {
> +	{0, 0}, {0, 1}, {0, 2}, {1, 2},
> +};
> +
> +static const struct dvfsrc_opp dvfsrc_opp_mt8183_lp3[] = {
> +	{0, 0}, {0, 1}, {1, 1}, {1, 2},
> +};
> +
> +static const struct dvfsrc_opp_desc dvfsrc_opp_mt8183_desc[] = {
> +	DVFSRC_OPP_DESC(dvfsrc_opp_mt8183_lp4),
> +	DVFSRC_OPP_DESC(dvfsrc_opp_mt8183_lp3),
> +	DVFSRC_OPP_DESC(dvfsrc_opp_mt8183_lp3),
> +};
> +
> +static const struct dvfsrc_soc_data mt8183_data = {
> +	.opps_desc = dvfsrc_opp_mt8183_desc,
> +	.regs = mt8183_regs,
> +	.get_target_level = mt8183_get_target_level,
> +	.get_current_level = mt8183_get_current_level,
> +	.get_vcore_level = mt8183_get_vcore_level,
> +	.set_dram_bw = mt8183_set_dram_bw,
> +	.set_opp_level = mt8183_set_opp_level,
> +	.set_vcore_level = mt8183_set_vcore_level,
> +	.wait_for_opp_level = mt8183_wait_for_opp_level,
> +	.wait_for_vcore_level = dvfsrc_wait_for_vcore_level,
> +};
> +
> +static int mtk_dvfsrc_remove(struct platform_device *pdev)
> +{
> +	struct mtk_dvfsrc *dvfsrc = platform_get_drvdata(pdev);
> +
> +	platform_device_unregister(dvfsrc->regulator);
> +	platform_device_unregister(dvfsrc->icc);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mtk_dvfsrc_of_match[] = {
> +	{
> +		.compatible = "mediatek,mt8183-dvfsrc",
> +		.data = &mt8183_data,
> +	}, {
> +		/* sentinel */
> +	},
> +};
> +
> +static struct platform_driver mtk_dvfsrc_driver = {
> +	.probe	= mtk_dvfsrc_probe,
> +	.remove	= mtk_dvfsrc_remove,
> +	.driver = {
> +		.name = "mtk-dvfsrc",
> +		.of_match_table = of_match_ptr(mtk_dvfsrc_of_match),
> +	},
> +};
> +
> +static int __init mtk_dvfsrc_init(void)
> +{
> +	return platform_driver_register(&mtk_dvfsrc_driver);
> +}
> +subsys_initcall(mtk_dvfsrc_init);
> +
> +static void __exit mtk_dvfsrc_exit(void)
> +{
> +	platform_driver_unregister(&mtk_dvfsrc_driver);
> +}
> +module_exit(mtk_dvfsrc_exit);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("MTK DVFSRC driver");
> diff --git a/include/linux/soc/mediatek/mtk_dvfsrc.h b/include/linux/soc/mediatek/mtk_dvfsrc.h
> new file mode 100644
> index 000000000000..823eff9bb19f
> --- /dev/null
> +++ b/include/linux/soc/mediatek/mtk_dvfsrc.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (c) 2021 MediaTek Inc.
> + */
> +
> +#ifndef __SOC_MTK_DVFSRC_H
> +#define __SOC_MTK_DVFSRC_H
> +
> +#define MTK_DVFSRC_CMD_BW_REQUEST		0
> +#define MTK_DVFSRC_CMD_OPP_REQUEST		1
> +#define MTK_DVFSRC_CMD_VCORE_REQUEST		2
> +#define MTK_DVFSRC_CMD_HRTBW_REQUEST		3
> +#define MTK_DVFSRC_CMD_VSCP_REQUEST		4
> +#define MTK_DVFSRC_CMD_PEAK_BW_REQUEST		5
> +
> +#define MTK_DVFSRC_CMD_VCORE_LEVEL_QUERY	0
> +#define MTK_DVFSRC_CMD_VSCP_LEVEL_QUERY		1
> +
> +#if IS_ENABLED(CONFIG_MTK_DVFSRC)
> +void mtk_dvfsrc_send_request(const struct device *dev, u32 cmd, u64 data);
> +int mtk_dvfsrc_query_info(const struct device *dev, u32 cmd, int *data);
> +
> +#else
> +
> +static inline void mtk_dvfsrc_send_request(const struct device *dev, u32 cmd,
> +					   u64 data)
> +{ return -ENODEV; }
> +
> +static inline int mtk_dvfsrc_query_info(const struct device *dev, u32 cmd,
> +					int *data);
> +{ return -ENODEV; }
> +
> +#endif /* CONFIG_MTK_DVFSRC */
> +
> +#endif
