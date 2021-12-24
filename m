Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82B847EDC4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 10:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352240AbhLXJ13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 04:27:29 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:59406 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1352232AbhLXJ12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 04:27:28 -0500
X-UUID: 25f50a1500424778b903cc0b36a5a382-20211224
X-UUID: 25f50a1500424778b903cc0b36a5a382-20211224
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 722099893; Fri, 24 Dec 2021 17:27:23 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 24 Dec 2021 17:27:21 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 24 Dec 2021 17:27:21 +0800
Message-ID: <6cdc903250723a6c547bccf2546dd10091b76249.camel@mediatek.com>
Subject: Re: [PATCH v16 3/7] soc: mediatek: SVS: introduce MTK SVS engine
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
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 24 Dec 2021 17:27:21 +0800
In-Reply-To: <c97f7dcd-32e5-616e-1bf9-fbd110ecd218@collabora.com>
References: <20210428065440.3704-1-roger.lu@mediatek.com>
         <20210428065440.3704-4-roger.lu@mediatek.com>
         <c97f7dcd-32e5-616e-1bf9-fbd110ecd218@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AngeloGioacchino,

Sorry for the late reply and thanks for all the advices.

On Thu, 2021-10-21 at 10:46 +0200, AngeloGioacchino Del Regno wrote:
> Il 28/04/21 08:54, Roger Lu ha scritto:
> > The Smart Voltage Scaling(SVS) engine is a piece of hardware
> > which calculates suitable SVS bank voltages to OPP voltage table.
> > Then, DVFS driver could apply those SVS bank voltages to PMIC/Buck
> > when receiving OPP_EVENT_ADJUST_VOLTAGE.
> > 
> > Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> > ---
> >   drivers/soc/mediatek/Kconfig   |   10 +
> >   drivers/soc/mediatek/Makefile  |    1 +
> >   drivers/soc/mediatek/mtk-svs.c | 1723 ++++++++++++++++++++++++++++++++
> >   3 files changed, 1734 insertions(+)
> >   create mode 100644 drivers/soc/mediatek/mtk-svs.c

[snip]

> > +/* svs bank common setting */
> > +#define SVSB_DET_CLK_EN			BIT(31)
> > +#define SVSB_TZONE_HIGH_TEMP_MAX	U32_MAX
> > +#define SVSB_RUNCONFIG_DEFAULT		0x80000000
> > +#define SVSB_DC_SIGNED_BIT		0x8000
> > +#define SVSB_INTEN_INIT0x		0x00005f01
> > +#define SVSB_INTEN_MONVOPEN		0x00ff0000
> > +#define SVSB_EN_OFF			0x0
> > +#define SVSB_EN_MASK			0x7
> > +#define SVSB_EN_INIT01			0x1
> > +#define SVSB_EN_INIT02			0x5
> > +#define SVSB_EN_MON			0x2
> > +#define SVSB_INTSTS_MONVOP		0x00ff0000
> > +#define SVSB_INTSTS_COMPLETE		0x1
> > +#define SVSB_INTSTS_CLEAN		0x00ffffff
> > +
> > +static DEFINE_SPINLOCK(mtk_svs_lock);
> > +
> > +/*
> 
> Thanks for using kernel-doc!! However, to be proper, this has to be
> /**
>   * ..........

Oh okay. Thanks. I will use /** to add multi-line comments. However, I checked
kernel doc-guide and it uses indent as below. So, I'll follow it. If I'm doing
it wrong, please correct me. Thanks a lot.
https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html

/**
 * .........

> 
> 
> > + * enum svsb_phase - svs bank phase enumeration
> > + * @SVSB_PHASE_INIT01: basic init for svs bank
> > + * @SVSB_PHASE_INIT02: svs bank can provide voltages
> > + * @SVSB_PHASE_MON: svs bank can provide voltages with thermal effect
> > + * @SVSB_PHASE_ERROR: svs bank encounters unexpected condition
> 
> Please move @SVSB_PHASE_ERROR before @SVSB_PHASE_INIT01: the order
> is important here, and has to be the same as the actual enumeration.

Sure, I'll improve it in the next version. Thanks.

> 
> > + *
> > + * Each svs bank has its own independent phase. We enable each svs bank by
> > + * running their phase orderly. However, When svs bank encounters
> > unexpected
> > + * condition, it will fire an irq (PHASE_ERROR) to inform svs software.
> > + *
> > + * svs bank general phase-enabled order:
> > + * SVSB_PHASE_INIT01 -> SVSB_PHASE_INIT02 -> SVSB_PHASE_MON
> > + */
> > +enum svsb_phase {
> > +	SVSB_PHASE_ERROR = 0,
> > +	SVSB_PHASE_INIT01,
> > +	SVSB_PHASE_INIT02,
> > +	SVSB_PHASE_MON,
> > +};
> > 
> > 

[snip]

> > +/*
> 
> Same here, use /**

Sure, I'll improve it in the next version. Thanks.

> 
> > + * struct svs_platform - svs platform data
> > + * @dev: svs platform device
> > + * @base: svs platform register address base
> > + * @main_clk: main clock for svs bank
> > + * @pbank: phandle of svs bank and needs to be protected by spin_lock
> > + * @banks: phandle of the banks that support
> > + * @efuse_parsing: phandle of efuse parsing function
> > + * @irqflags: irq settings flags
> > + * @rst: svs reset control
> > + * @regs: phandle to the registers map
> > + * @efuse_num: the total number of svs platform efuse
> > + * @tefuse_num: the total number of thermal efuse
> > + * @bank_num: the total number of banks
> > + * @efuse_check: the svs efuse check index
> > + * @efuse: svs platform efuse data received from NVMEM framework
> > + * @tefuse: thermal efuse data received from NVMEM framework
> > + * @name: svs platform name
> > + */
> > +struct svs_platform {
> > +	struct device *dev;
> > +	void __iomem *base;
> > +	struct clk *main_clk;
> > +	struct svs_bank *pbank;
> > +	struct svs_bank *banks;
> > +	bool (*efuse_parsing)(struct svs_platform *svsp);
> > +	unsigned long irqflags;
> > +	struct reset_control *rst;
> > +	const u32 *regs;
> > +	char *name;
> > +	size_t efuse_num;
> > +	size_t tefuse_num;
> > +	u32 bank_num;
> > +	u32 efuse_check;
> > +	u32 *efuse;
> > +	u32 *tefuse;
> > +};
> > +
> > +/*
> 
> ditto.

Sure, I'll improve it in the next version. Thanks.

> 
> > + * struct svs_bank - svs bank representation
> > + * @dev: svs bank device
> > + * @opp_dev: device for opp table/buck control
> > + * @pd_dev: power domain device for SoC mtcmos control
> > + * @init_completion: the timeout completion for bank init
> > + * @buck: phandle of the regulator

[snip]

> > +static int svs_adjust_pm_opp_volts(struct svs_bank *svsb, bool
> > force_update)
> > +{
> > +	int tzone_temp = 0, ret = -EPERM;
> > +	u32 i, svsb_volt, opp_volt, temp_offset = 0;
> > +
> > +	mutex_lock(&svsb->lock);
> > +
> > +	/*
> > +	 * If svs bank is suspended, it means signed-off voltages are applied.
> > +	 * Don't need to update opp voltage anymore.
> > +	 */
> > +	if (svsb->suspended && !force_update) {
> > +		dev_notice(svsb->dev, "bank is suspended\n");
> > +		ret = -EPERM;
> > +		goto unlock_mutex;
> > +	}
> > +
> > +	/* Get thermal effect */
> > +	if (svsb->phase == SVSB_PHASE_MON) {
> > +		if (svsb->temp > svsb->temp_upper_bound &&
> > +		    svsb->temp < svsb->temp_lower_bound) {
> > +			dev_warn(svsb->dev, "svsb temp = 0x%x?\n", svsb->temp);
> > +			ret = -EINVAL;
> > +			goto unlock_mutex;
> > +		}
> > +
> > +		ret = svs_get_bank_zone_temperature(svsb->tzone_name,
> > +						    &tzone_temp);
> > +		if (ret) {
> > +			dev_err(svsb->dev, "no %s? (%d), run default volts\n",
> > +				svsb->tzone_name, ret);
> > +			svsb->phase = SVSB_PHASE_ERROR;
> > +		}
> > +
> > +		if (tzone_temp >= svsb->tzone_high_temp)
> > +			temp_offset += svsb->tzone_high_temp_offset;
> > +		else if (tzone_temp <= svsb->tzone_low_temp)
> > +			temp_offset += svsb->tzone_low_temp_offset;
> > +	}
> > +
> > +	/* vmin <= svsb_volt (opp_volt) <= signed-off (default) voltage */
> > +	for (i = 0; i < svsb->opp_count; i++) {
> 
> What about using switch here?
> 
> 		switch (svsb->phase) {
> 		case SVSB_PHASE_MON:
> 			......
> 			break;
> 		case .......:
> 			.........
> 			break;
> 		default:
> 			dev_err(......);
> 			ret = -EINVAL;
> 			goto unlock_mutex;
> 		}
> 

Okay. I'll use switch here in the next version. Thanks for the advice.

> > +		if (svsb->phase == SVSB_PHASE_MON) {
> > +			svsb_volt = max(svsb->volts[i] + svsb->volt_offset +
> > +					temp_offset, svsb->vmin);
> > +			opp_volt = svs_bank_volt_to_opp_volt(svsb_volt,
> > +							     svsb->volt_step,
> > +							     svsb->volt_base);
> > +		} else if (svsb->phase == SVSB_PHASE_INIT02) {
> > +			svsb_volt = max(svsb->volts[i] + svsb->volt_offset,
> > +					svsb->vmin);
> > +			opp_volt = svs_bank_volt_to_opp_volt(svsb_volt,
> > +							     svsb->volt_step,
> > +							     svsb->volt_base);
> > +		} else if (svsb->phase == SVSB_PHASE_ERROR) {
> > +			opp_volt = svsb->opp_volts[i];
> > +		} else {
> > +			dev_err(svsb->dev, "unknown phase: %u?\n", svsb->phase);
> > +			ret = -EINVAL;
> > +			goto unlock_mutex;
> > +		}
> > +
> > +		opp_volt = min(opp_volt, svsb->opp_volts[i]);
> > +		ret = dev_pm_opp_adjust_voltage(svsb->opp_dev,
> > +						svsb->opp_freqs[i],
> > +						opp_volt, opp_volt,
> > +						svsb->opp_volts[i]);
> > +		if (ret) {
> > +			dev_err(svsb->dev, "set voltage fail: %d\n", ret);
> > +			goto unlock_mutex;
> > +		}
> > +	}
> > +
> > +unlock_mutex:
> > +	mutex_unlock(&svsb->lock);
> > +
> > +	return ret;
> > +}

[snip]

> > +static void svs_set_bank_phase(struct svs_platform *svsp,
> > +			       enum svsb_phase target_phase)
> > +{
> > +	struct svs_bank *svsb = svsp->pbank;
> > +	u32 des_char, temp_char, det_char, limit_vals;
> > +	u32 init2vals, ts_calcs, val, filter, i;
> > +
> > +	svs_switch_bank(svsp);
> > +
> > +	des_char = (svsb->bdes << 8) | svsb->mdes;
> > +	svs_writel(svsp, des_char, DESCHAR);
> > +
> > +	temp_char = (svsb->vco << 16) | (svsb->mtdes << 8) | svsb->dvt_fixed;
> > +	svs_writel(svsp, temp_char, TEMPCHAR);
> > +
> > +	det_char = (svsb->dcbdet << 8) | svsb->dcmdet;
> > +	svs_writel(svsp, det_char, DETCHAR);
> > +
> > +	svs_writel(svsp, svsb->dc_config, DCCONFIG);
> > +	svs_writel(svsp, svsb->age_config, AGECONFIG);
> > +
> > +	if (!svsb->agem) {
> > +		svs_writel(svsp, SVSB_RUNCONFIG_DEFAULT, RUNCONFIG);
> > +	} else {
> > +		val = 0x0;
> 
> 		val = 0;
> 
> > +
> > +		for (i = 0; i < 24; i += 2) {
> > +			filter = 0x3 << i;
> > +
> > +			if (!(svsb->age_config & filter))
> > +				val |= (0x1 << i);
> 
> 				val |= BIT(i);

I'll remove these if / else for "agem" in this patch as Matthias recommended in
v20 review. Thanks for the advice.

> > +			else
> > +				val |= (svsb->age_config & filter);
> > +		}
> > +		svs_writel(svsp, val, RUNCONFIG);
> > +	}
> > +
> > +	svsb->set_freqs_pct(svsp);
> > +
> > +	limit_vals = (svsb->vmax << 24) | (svsb->vmin << 16) |
> > +		     (svsb->dthi << 8) | svsb->dtlo;
> > +	svs_writel(svsp, limit_vals, LIMITVALS);
> > +	svs_writel(svsp, svsb->vboot, VBOOT);
> > +	svs_writel(svsp, svsb->det_window, DETWINDOW);
> > +	svs_writel(svsp, svsb->det_max, CONFIG);
> > +
> > +	if (svsb->chk_shift)
> > +		svs_writel(svsp, svsb->chk_shift, CHKSHIFT);
> > +
> > +	if (svsb->ctl0)
> > +		svs_writel(svsp, svsb->ctl0, CTL0);
> > +
> > +	svs_writel(svsp, SVSB_INTSTS_CLEAN, INTSTS);
> > +
> > +	switch (target_phase) {
> > +	case SVSB_PHASE_INIT01:
> > +		svs_writel(svsp, SVSB_INTEN_INIT0x, INTEN);
> > +		svs_writel(svsp, SVSB_EN_INIT01, SVSEN);
> > +		break;
> > +	case SVSB_PHASE_INIT02:
> > +		svs_writel(svsp, SVSB_INTEN_INIT0x, INTEN);
> > +		init2vals = (svsb->age_voffset_in << 16) | svsb->dc_voffset_in;
> > +		svs_writel(svsp, init2vals, INIT2VALS);
> > +		svs_writel(svsp, SVSB_EN_INIT02, SVSEN);
> > +		break;
> > +	case SVSB_PHASE_MON:
> > +		ts_calcs = (svsb->bts << 12) | svsb->mts;
> > +		svs_writel(svsp, ts_calcs, TSCALCS);
> > +		svs_writel(svsp, SVSB_INTEN_MONVOPEN, INTEN);
> > +		svs_writel(svsp, SVSB_EN_MON, SVSEN);
> > +		break;
> > +	default:
> > +		WARN_ON(1);
> 
> I agree about printing a big warning in kmsg here, but you can do that in a
> slightly more descriptive way:
> 
> 		WARN(1, "Requested unknown target phase %u", target_phase);
> 

Okay. I'll add description in these kinds of warning kmsg. Thanks for the
advice.

> > +		break;
> > +	}
> > +}

[snip]

> > +static int svs_init02(struct svs_platform *svsp)
> > +{
> > +	struct svs_bank *svsb;
> > +	unsigned long flags, time_left;
> > +	u32 idx;
> > +
> > +	for (idx = 0; idx < svsp->bank_num; idx++) {
> > +		svsb = &svsp->banks[idx];
> > +
> > +		if (!(svsb->mode_support & SVSB_MODE_INIT02))
> > +			continue;
> > +
> > +		reinit_completion(&svsb->init_completion);
> > +		spin_lock_irqsave(&mtk_svs_lock, flags);
> > +		svsp->pbank = svsb;
> > +		svs_set_bank_phase(svsp, SVSB_PHASE_INIT02);
> > +		spin_unlock_irqrestore(&mtk_svs_lock, flags);
> > +
> > +		time_left =
> > +			wait_for_completion_timeout(&svsb->init_completion,
> > +						    msecs_to_jiffies(5000));
> 
> There's no need to break the line... that's going to be fine:
> 
> 		time_left = wait_for_completion_timeout(&svsb->init_completion,
> 
> 							msecs_to_jiffies(5000));
> 

Okay. I'll keep it one line. Thanks.

> > +		if (!time_left) {
> > +			dev_err(svsb->dev, "init02 completion timeout\n");
> > +			return -EBUSY;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int svs_init01(struct svs_platform *svsp)
> > +{
> > +	struct svs_bank *svsb;
> > +	struct pm_qos_request *qos_request;
> > +	unsigned long flags, time_left;
> > +	bool search_done;
> > +	int ret = 0;
> > +	u32 opp_freqs, opp_vboot, buck_volt, idx, i;
> > +
> > +	qos_request = kzalloc(sizeof(*qos_request), GFP_KERNEL);
> > +	if (!qos_request)
> > +		return -ENOMEM;
> > +
> > +	/* Let CPUs leave idle-off state for initializing svs_init01. */
> > +	cpu_latency_qos_add_request(qos_request, 0);
> > +
> > +	/*
> > +	 * Sometimes two svs banks use the same buck.
> > +	 * Therefore, we set each svs bank to vboot voltage first.
> > +	 */
> > +	for (idx = 0; idx < svsp->bank_num; idx++) {
> > +		svsb = &svsp->banks[idx];
> > +
> > +		if (!(svsb->mode_support & SVSB_MODE_INIT01))
> > +			continue;
> > +
> > +		search_done = false;
> > +
> > +		if (svsb->pd_req) {
> > +			ret = regulator_enable(svsb->buck);
> > +			if (ret) {
> > +				dev_err(svsb->dev, "%s enable fail: %d\n",
> > +					svsb->buck_name, ret);
> > +				goto init01_finish;
> > +			}
> > +
> > +			if (!pm_runtime_enabled(svsb->pd_dev)) {
> > +				pm_runtime_enable(svsb->pd_dev);
> > +				svsb->enable_pm_runtime_ever = true;
> > +			}
> > +
> > +			ret = pm_runtime_get_sync(svsb->pd_dev);
> > +			if (ret < 0) {
> > +				dev_err(svsb->dev, "mtcmos on fail: %d\n", ret);
> > +				goto init01_finish;
> > +			}
> > +		}
> > +
> > +		if (regulator_set_mode(svsb->buck, REGULATOR_MODE_FAST))
> > +			dev_notice(svsb->dev, "set fast mode fail\n");
> > +
> > +		/*
> > +		 * Find the fastest freq that can be run at vboot and
> > +		 * fix to that freq until svs_init01 is done.
> > +		 */
> > +		opp_vboot = svs_bank_volt_to_opp_volt(svsb->vboot,
> > +						      svsb->volt_step,
> > +						      svsb->volt_base);
> > +
> > +		for (i = 0; i < svsb->opp_count; i++) {
> > +			opp_freqs = svsb->opp_freqs[i];
> > +			if (!search_done && svsb->opp_volts[i] <= opp_vboot) {
> > +				ret = dev_pm_opp_adjust_voltage(svsb->opp_dev,
> > +								opp_freqs,
> > +								opp_vboot,
> > +								opp_vboot,
> > +								opp_vboot);
> > +				if (ret) {
> > +					dev_err(svsb->dev,
> > +						"set voltage fail: %d\n", ret);
> > +					goto init01_finish;
> > +				}
> > +
> > +				search_done = true;
> > +			} else {
> > +				dev_pm_opp_disable(svsb->opp_dev,
> > +						   svsb->opp_freqs[i]);
> > +			}
> > +		}
> > +	}
> > +
> > +	/* svs bank init01 begins */
> > +	for (idx = 0; idx < svsp->bank_num; idx++) {
> > +		svsb = &svsp->banks[idx];
> > +
> > +		if (!(svsb->mode_support & SVSB_MODE_INIT01))
> > +			continue;
> > +
> > +		opp_vboot = svs_bank_volt_to_opp_volt(svsb->vboot,
> > +						      svsb->volt_step,
> > +						      svsb->volt_base);
> > +
> > +		buck_volt = regulator_get_voltage(svsb->buck);
> > +		if (buck_volt != opp_vboot) {
> > +			dev_err(svsb->dev,
> > +				"buck voltage: %u, expected vboot: %u\n",
> > +				buck_volt, opp_vboot);
> > +			ret = -EPERM;
> > +			goto init01_finish;
> > +		}
> > +
> > +		spin_lock_irqsave(&mtk_svs_lock, flags);
> > +		svsp->pbank = svsb;
> > +		svs_set_bank_phase(svsp, SVSB_PHASE_INIT01);
> > +		spin_unlock_irqrestore(&mtk_svs_lock, flags);
> > +
> > +		time_left =
> > +			wait_for_completion_timeout(&svsb->init_completion,
> 
> 81 columns is ok to have.
> 

Okay. Thanks. I'll keep it one line.

> > +						    msecs_to_jiffies(5000));
> > +		if (!time_left) {
> > +			dev_err(svsb->dev, "init01 completion timeout\n");
> > +			ret = -EBUSY;
> > +			goto init01_finish;
> > +		}
> > +	}
> > +
> > +init01_finish:
> > +	for (idx = 0; idx < svsp->bank_num; idx++) {
> > +		svsb = &svsp->banks[idx];
> > +
> > +		if (!(svsb->mode_support & SVSB_MODE_INIT01))
> > +			continue;
> > +
> > +		for (i = 0; i < svsb->opp_count; i++)
> > +			dev_pm_opp_enable(svsb->opp_dev, svsb->opp_freqs[i]);
> > +
> > +		if (regulator_set_mode(svsb->buck, REGULATOR_MODE_NORMAL))
> > +			dev_notice(svsb->dev, "fail to set normal mode\n");
> > +
> > +		if (svsb->pd_req) {
> > +			if (pm_runtime_put_sync(svsb->pd_dev))
> > +				dev_err(svsb->dev, "mtcmos off fail\n");
> > +
> > +			if (svsb->enable_pm_runtime_ever) {
> > +				pm_runtime_disable(svsb->pd_dev);
> > +				svsb->enable_pm_runtime_ever = false;
> > +			}
> > +
> > +			if (regulator_disable(svsb->buck))
> > +				dev_err(svsb->dev, "%s disable fail: %d\n",
> > +					svsb->buck_name, ret);
> > +		}
> > +	}
> > +
> > +	cpu_latency_qos_remove_request(qos_request);
> > +	kfree(qos_request);
> > +
> > +	return ret;
> > +}

[snip]

> > +static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
> > +{
> > +	struct thermal_parameter tp;
> > +	struct svs_bank *svsb;
> > +	bool mon_mode_support = true;
> > +	int format[6], x_roomt[6], tb_roomt = 0;
> > +	struct nvmem_cell *cell;
> > +	u32 idx, i, ft_pgm, mts, temp0, temp1, temp2;
> > +
> > +	for (i = 0; i < svsp->efuse_num; i++)
> > +		if (svsp->efuse[i])
> > +			dev_info(svsp->dev, "M_HW_RES%d: 0x%08x\n",
> > +				 i, svsp->efuse[i]);
> > +
> > +	/* Svs efuse parsing */
> > +	ft_pgm = (svsp->efuse[0] >> 4) & GENMASK(3, 0);
> > +
> > +	for (idx = 0; idx < svsp->bank_num; idx++) {
> > +		svsb = &svsp->banks[idx];
> > +
> > +		if (ft_pgm <= 1)
> > +			svsb->volt_flags |= SVSB_INIT01_VOLT_IGNORE;
> > +
> > +		switch (svsb->sw_id) {
> > +		case SVSB_CPU_LITTLE:
> > +			svsb->bdes = svsp->efuse[16] & GENMASK(7, 0);
> > +			svsb->mdes = (svsp->efuse[16] >> 8) & GENMASK(7, 0);
> > +			svsb->dcbdet = (svsp->efuse[16] >> 16) & GENMASK(7, 0);
> > +			svsb->dcmdet = (svsp->efuse[16] >> 24) & GENMASK(7, 0);
> > +			svsb->mtdes  = (svsp->efuse[17] >> 16) & GENMASK(7, 0);
> > +
> > +			if (ft_pgm <= 3)
> > +				svsb->volt_offset += 10;
> > +			else
> > +				svsb->volt_offset += 2;
> > +			break;
> > +		case SVSB_CPU_BIG:
> > +			svsb->bdes = svsp->efuse[18] & GENMASK(7, 0);
> > +			svsb->mdes = (svsp->efuse[18] >> 8) & GENMASK(7, 0);
> > +			svsb->dcbdet = (svsp->efuse[18] >> 16) & GENMASK(7, 0);
> > +			svsb->dcmdet = (svsp->efuse[18] >> 24) & GENMASK(7, 0);
> > +			svsb->mtdes  = svsp->efuse[17] & GENMASK(7, 0);
> > +
> > +			if (ft_pgm <= 3)
> > +				svsb->volt_offset += 15;
> > +			else
> > +				svsb->volt_offset += 12;
> > +			break;
> > +		case SVSB_CCI:
> > +			svsb->bdes = svsp->efuse[4] & GENMASK(7, 0);
> > +			svsb->mdes = (svsp->efuse[4] >> 8) & GENMASK(7, 0);
> > +			svsb->dcbdet = (svsp->efuse[4] >> 16) & GENMASK(7, 0);
> > +			svsb->dcmdet = (svsp->efuse[4] >> 24) & GENMASK(7, 0);
> > +			svsb->mtdes  = (svsp->efuse[5] >> 16) & GENMASK(7, 0);
> > +
> > +			if (ft_pgm <= 3)
> > +				svsb->volt_offset += 10;
> > +			else
> > +				svsb->volt_offset += 2;
> > +			break;
> > +		case SVSB_GPU:
> > +			svsb->bdes = svsp->efuse[6] & GENMASK(7, 0);
> > +			svsb->mdes = (svsp->efuse[6] >> 8) & GENMASK(7, 0);
> > +			svsb->dcbdet = (svsp->efuse[6] >> 16) & GENMASK(7, 0);
> > +			svsb->dcmdet = (svsp->efuse[6] >> 24) & GENMASK(7, 0);
> > +			svsb->mtdes  = svsp->efuse[5] & GENMASK(7, 0);
> > +
> > +			if (ft_pgm >= 2) {
> > +				svsb->freq_base = 800000000; /* 800MHz */
> > +				svsb->dvt_fixed = 2;
> > +			}
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +	}
> > +
> > +	/* Get thermal efuse by nvmem */
> > +	cell = nvmem_cell_get(svsp->dev, "t-calibration-data");
> > +	if (IS_ERR_OR_NULL(cell)) {
> > +		dev_err(svsp->dev, "no thermal cell, no mon mode\n");
> > +		for (idx = 0; idx < svsp->bank_num; idx++) {
> > +			svsb = &svsp->banks[idx];
> > +			svsb->mode_support &= ~SVSB_MODE_MON;
> > +		}
> > +
> > +		return true;
> > +	}
> > +
> > +	svsp->tefuse = nvmem_cell_read(cell, &svsp->tefuse_num);
> 
> nvmem_cell_read may return an error pointer: you have to check that.
> 
> 	if (IS_ERR(svsp->tefuse))
> 		.........
> 
> Failing to perform this check will produce unpredictable behavior
> during the parsing stage.
> 

Sure. I'll add the error handling when using nvmem_cell_read(). Thanks for the
advice.

> > +	svsp->tefuse_num /= sizeof(u32);
> > +	nvmem_cell_put(cell);
> > +
> > +	/* Thermal efuse parsing */
> > +	tp.adc_ge_t = (svsp->tefuse[1] >> 22) & GENMASK(9, 0);
> > +	tp.adc_oe_t = (svsp->tefuse[1] >> 12) & GENMASK(9, 0);
> > +
> > +	tp.o_vtsmcu1 = (svsp->tefuse[0] >> 17) & GENMASK(8, 0);
> > +	tp.o_vtsmcu2 = (svsp->tefuse[0] >> 8) & GENMASK(8, 0);
> > +	tp.o_vtsmcu3 = svsp->tefuse[1] & GENMASK(8, 0);
> > +	tp.o_vtsmcu4 = (svsp->tefuse[2] >> 23) & GENMASK(8, 0);
> > +	tp.o_vtsmcu5 = (svsp->tefuse[2] >> 5) & GENMASK(8, 0);
> > +	tp.o_vtsabb = (svsp->tefuse[2] >> 14) & GENMASK(8, 0);
> > +
> > +	tp.degc_cali = (svsp->tefuse[0] >> 1) & GENMASK(5, 0);
> > +	tp.adc_cali_en_t = svsp->tefuse[0] & BIT(0);
> > +	tp.o_slope_sign = (svsp->tefuse[0] >> 7) & BIT(0);
> > +
> > +	tp.ts_id = (svsp->tefuse[1] >> 9) & BIT(0);
> > +	tp.o_slope = (svsp->tefuse[0] >> 26) & GENMASK(5, 0);
> > +
> 
> Regards,
> - Angelo
> 
> 

