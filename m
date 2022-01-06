Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F987486063
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 06:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbiAFFuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 00:50:21 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:41978 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229560AbiAFFuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 00:50:20 -0500
X-UUID: c6d932d9b69847748943f54310ac15eb-20220106
X-UUID: c6d932d9b69847748943f54310ac15eb-20220106
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 350615604; Thu, 06 Jan 2022 13:50:15 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 6 Jan 2022 13:50:14 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 6 Jan 2022 13:50:14 +0800
Message-ID: <cd16a23f82c4c545e60600454aa27b99c3f5d8fb.camel@mediatek.com>
Subject: Re: [PATCH v20 3/7] soc: mediatek: SVS: introduce MTK SVS engine
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
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Guenter Roeck <linux@roeck-us.net>
Date:   Thu, 6 Jan 2022 13:50:13 +0800
In-Reply-To: <1480efdf-ed94-8bda-7bea-a657eddae45d@collabora.com>
References: <20210721070904.15636-1-roger.lu@mediatek.com>
         <20210721070904.15636-4-roger.lu@mediatek.com>
         <1480efdf-ed94-8bda-7bea-a657eddae45d@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AngeloGioacchino,

This patch is older comparing with the time when you left comments on v16. So,
excuse me if this patch makes you confuse and thanks for all the advices.

On Wed, 2022-01-05 at 10:58 +0100, AngeloGioacchino Del Regno wrote:
> Il 21/07/21 09:09, Roger Lu ha scritto:
> > The Smart Voltage Scaling(SVS) engine is a piece of hardware
> > which calculates suitable SVS bank voltages to OPP voltage table.
> > Then, DVFS driver could apply those SVS bank voltages to PMIC/Buck
> > when receiving OPP_EVENT_ADJUST_VOLTAGE.
> > 
> > Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> 
> Hello Roger,
> thanks for the patch!
> 
> However, there are a few things to improve...
> 
> > ---
> >   drivers/soc/mediatek/Kconfig   |   10 +
> >   drivers/soc/mediatek/Makefile  |    1 +
> >   drivers/soc/mediatek/mtk-svs.c | 1720 ++++++++++++++++++++++++++++++++
> >   3 files changed, 1731 insertions(+)
> >   create mode 100644 drivers/soc/mediatek/mtk-svs.c

[snip]

> > +/* svs bank volt flags */
> > +#define SVSB_INIT01_VOLT_IGNORE		BIT(1)
> > +#define SVSB_INIT01_VOLT_INC_ONLY	BIT(2)
> > +#define SVSB_INIT02_RM_DVTFIXED		BIT(8)
> > +#define SVSB_MON_VOLT_IGNORE		BIT(16)
> > +
> > +/* svs bank common setting */
> > +#define SVSB_DET_CLK_EN			BIT(31)
> > +#define SVSB_TZONE_HIGH_TEMP_MAX	U32_MAX
> > +#define SVSB_RUNCONFIG_DEFAULT		0x80000000
> > +#define SVSB_DC_SIGNED_BIT		0x8000
> 
> SVSB_DC_SIGNED_BIT is.. clearly a bit, so this should be BIT(15)

Thanks. I'll update it to BIT(15) in v21.

> 
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
> Looks like the great intention is to have kernel-doc here, and it's already
> in the right format, but the start of the comment block should be
> 
> /**
> 
> and not
> 
> /*
> 
> to be recognized as kerneldoc.
> Please refer to 
> https://urldefense.com/v3/__https://www.kernel.org/doc/html/v5.15/doc-guide/kernel-doc.html__;!!CTRNKA9wMg0ARbw!zYX3rnKoCilN7h_LLkpKmqF-6FsUGN4pOnlSO9NBfevbtwA15bM5CjqcMFn75nsn$
>  

No problem. I'll follow kernel-doc. Thanks for the link.

> > + * enum svsb_phase - svs bank phase enumeration
> > + * @SVSB_PHASE_INIT01: basic init for svs bank
> > + * @SVSB_PHASE_INIT02: svs bank can provide voltages
> > + * @SVSB_PHASE_MON: svs bank can provide voltages with thermal effect
> > + * @SVSB_PHASE_ERROR: svs bank encounters unexpected condition
> 
> Please move @SVSB_PHASE_ERROR before @SVSB_PHASE_INIT01: the order
> 
> is important here, and has to be the same as the actual enumeration.
> 

Sure, I'll update it in v21. Thanks.

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


> > +/*
> 
> ... same here, /** for kerneldoc

Sure, I'll update it in v21. Thanks.

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
> 
> @name should be here

Got it. I'll reorder them consistently in v21. Thanks for the guide.

> 
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
> ... and here

Sure, I'll update it in v21. Thanks.

> 
> > + * struct svs_bank - svs bank representation
> > + * @dev: svs bank device
> > + * @opp_dev: device for opp table/buck control
> > + * @pd_dev: power domain device for SoC mtcmos control
> > + * @init_completion: the timeout completion for bank init
> > + * @buck: phandle of the regulator
> > + * @lock: mutex lock to protect voltage update process
> > + * @phase: bank current phase
> > + * @name: bank name
> > + * @tzone_name: thermal zone name
> > + * @buck_name: regulator name
> > + * @suspended: suspend flag of this bank
> > + * @pd_req: bank's power-domain on request
> > + * @enable_pm_runtime_ever: bank enables pm-runtime flag
> > + * @set_freqs_pct: phandle of set frequencies percent function
> > + * @get_vops: phandle of get bank voltages function
> > + * @volt_offset: bank voltage offset controlled by svs software
> > + * @mode_support: bank mode support.
> > + * @opp_freqs: signed-off frequencies from default opp table
> > + * @opp_volts: signed-off voltages from default opp table
> > + * @freqs_pct: percent of "opp_freqs / freq_base" for bank init
> > + * @volts: bank voltages
> > + * @freq_base: reference frequency for bank init
> > + * @vboot: voltage request for bank init01 stage only
> > + * @volt_step: bank voltage step
> > + * @volt_base: bank voltage base
> > + * @volt_flags: bank voltage flags
> > + * @vmax: bank voltage maximum
> > + * @vmin: bank voltage minimum
> 
> I love when developers take the effort to document with kerneldoc, so, great
> job
> about that.... however, you forgot to document a few variables... can you
> please
> add the required documentation for them?

I'll add them up and reveal the detail as many as possible. Thanks for the
gentle wording.

> 
> > + * @temp: bank temperature
> > + * @temp_upper_bound: bank temperature upper bound
> > + * @temp_lower_bound: bank temperature lower bound
> > + * @tzone_high_temp: thermal zone high temperature threshold
> > + * @tzone_high_temp_offset: thermal zone high temperature offset
> > + * @tzone_low_temp: thermal zone low temperature threshold
> > + * @tzone_low_temp_offset: thermal zone low temperature offset
> > + * @core_sel: bank selection
> > + * @opp_count: bank opp count
> > + * @int_st: bank interrupt identification
> > + * @sw_id: bank software identification
> > + * @ctl0: bank thermal sensor selection
> > + * @cpu_id: cpu core id for SVS CPU only
> > + *
> > + * Other structure members which are not listed above are svs platform
> > + * efuse data for bank init
> > + */
> > +struct svs_bank {
> > +	struct device *dev;
> > +	struct device *opp_dev;
> > +	struct device *pd_dev;
> > +	struct completion init_completion;
> > +	struct regulator *buck;
> > +	struct mutex lock;	/* lock to protect voltage update process */
> > +	enum svsb_phase phase;
> > +	char *name;
> > +	char *tzone_name;
> > +	char *buck_name;
> > +	bool suspended;
> > +	bool pd_req;
> > +	bool enable_pm_runtime_ever;
> > +	void (*set_freqs_pct)(struct svs_platform *svsp);
> > +	void (*get_vops)(struct svs_platform *svsp);
> > +	s32 volt_offset;
> > +	u32 mode_support;
> > +	u32 opp_freqs[16];
> 
> At the beginning of the file....
> #define MAX_OPP_ENTRIES 16
> 
> ...so you can do...
> 	u32 opp_freqs[MAX_OPP_ENTRIES];
> 	u32 opp_volts[MAX_OPP_ENTRIES];
> ...and the same for the other two.

Sure, I'll replace them with MAX_OPP_ENTRIES.

> > +	u32 opp_volts[16];
> > +	u32 freqs_pct[16];
> > +	u32 volts[16];
> > +	u32 freq_base;
> > +	u32 vboot;
> > +	u32 volt_step;
> > +	u32 volt_base;
> > +	u32 volt_flags;
> > +	u32 vmax;
> > +	u32 vmin;


> Document these entries, please.
> 
> vvvvvvvvv From here.... vvvvvvvvv
> 
> > +	u32 bts;
> > +	u32 mts;
> > +	u32 bdes;
> > +	u32 mdes;
> > +	u32 mtdes;
> > +	u32 dcbdet;
> > +	u32 dcmdet;
> > +	u32 dthi;
> > +	u32 dtlo;
> > +	u32 det_window;
> > +	u32 det_max;
> > +	u32 age_config;
> > +	u32 age_voffset_in;
> > +	u32 agem;
> > +	u32 dc_config;
> > +	u32 dc_voffset_in;
> > +	u32 dvt_fixed;
> > +	u32 vco;
> > +	u32 chk_shift;
> 
> ^^^^^^^^^ ....to there ^^^^^^^^^

Sure, thanks for the review.

> 
> > +	u32 temp;
> > +	u32 temp_upper_bound;
> > +	u32 temp_lower_bound;
> > +	u32 tzone_high_temp;
> > +	u32 tzone_high_temp_offset;
> > +	u32 tzone_low_temp;
> > +	u32 tzone_low_temp_offset;
> > +	u32 core_sel;
> > +	u32 opp_count;
> > +	u32 int_st;
> > +	u32 sw_id;
> > +	u32 ctl0;
> > +	u32 cpu_id;
> > +};

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
> 
> 
> What about using switch here?
> 
> 
> 
>          switch (svsb->phase) {
> 
>          case SVSB_PHASE_MON:
> 
>              ......
> 
>              break;
> 
>          case .......:
> 
>              .........
> 
>              break;
> 
>          default:
> 
>              dev_err(......);
> 
>              ret = -EINVAL;
> 
>              goto unlock_mutex;
> 
>          }

No problem. I'll use switch here. Thanks.

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
> val = 0;

Got it. I'll improve this if-else statement as minimum support first.

> 
> > +
> > +		for (i = 0; i < 24; i += 2) {
> > +			filter = 0x3 << i;
> > +
> > +			if (!(svsb->age_config & filter))
> > +				val |= (0x1 << i);
> 
> val |= BIT(i);

ditto.

> 
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
> 
> slightly more descriptive way:
> 
> 
> 
>          WARN(1, "Requested unknown target phase %u", target_phase);
> 

Sure, I'll add more description in v21. Thanks for the example code.

> > +		break;
> > +	}
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
> 
> 
> nvmem_cell_read may return an error pointer: you have to check that.
> 
> 
> 
>      if (IS_ERR(svsp->tefuse))
> 
>          .........
> 
> 
> 
> Failing to perform this check will produce unpredictable behavior
> 
> during the parsing stage.

Sure, I'll add the error handling here. Thanks for the notice.

> 
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
> > +	if (tp.adc_cali_en_t == 1) {
> > +		if (!tp.ts_id)
> > +			tp.o_slope = 0;
> > +
> > +		if (tp.adc_ge_t < 265 || tp.adc_ge_t > 758 ||
> > +		    tp.adc_oe_t < 265 || tp.adc_oe_t > 758 ||
> > +		    tp.o_vtsmcu1 < -8 || tp.o_vtsmcu1 > 484 ||
> > +		    tp.o_vtsmcu2 < -8 || tp.o_vtsmcu2 > 484 ||
> > +		    tp.o_vtsmcu3 < -8 || tp.o_vtsmcu3 > 484 ||
> > +		    tp.o_vtsmcu4 < -8 || tp.o_vtsmcu4 > 484 ||
> > +		    tp.o_vtsmcu5 < -8 || tp.o_vtsmcu5 > 484 ||
> > +		    tp.o_vtsabb < -8 || tp.o_vtsabb > 484 ||
> > +		    tp.degc_cali < 1 || tp.degc_cali > 63) {
> > +			dev_err(svsp->dev, "bad thermal efuse, no mon mode\n");
> > +			mon_mode_support = false;
> > +		}
> > +	} else {
> > +		dev_err(svsp->dev, "no thermal efuse, no mon mode\n");
> > +		mon_mode_support = false;
> > +	}
> > +
> > +	if (!mon_mode_support) {
> > +		for (idx = 0; idx < svsp->bank_num; idx++) {
> > +			svsb = &svsp->banks[idx];
> > +			svsb->mode_support &= ~SVSB_MODE_MON;
> > +		}
> > +
> > +		return true;
> > +	}
> > +
> > +	tp.ge = ((tp.adc_ge_t - 512) * 10000) / 4096;
> > +	tp.oe = (tp.adc_oe_t - 512);
> > +	tp.gain = (10000 + tp.ge);
> > +
> > +	format[0] = (tp.o_vtsmcu1 + 3350 - tp.oe);
> > +	format[1] = (tp.o_vtsmcu2 + 3350 - tp.oe);
> > +	format[2] = (tp.o_vtsmcu3 + 3350 - tp.oe);
> > +	format[3] = (tp.o_vtsmcu4 + 3350 - tp.oe);
> > +	format[4] = (tp.o_vtsmcu5 + 3350 - tp.oe);
> > +	format[5] = (tp.o_vtsabb + 3350 - tp.oe);
> > +
> > +	for (i = 0; i < 6; i++)
> > +		x_roomt[i] = (((format[i] * 10000) / 4096) * 10000) / tp.gain;
> > +
> > +	temp0 = (10000 * 100000 / tp.gain) * 15 / 18;
> > +
> > +	if (!tp.o_slope_sign)
> > +		mts = (temp0 * 10) / (1534 + tp.o_slope * 10);
> > +	else
> > +		mts = (temp0 * 10) / (1534 - tp.o_slope * 10);
> > +
> > +	for (idx = 0; idx < svsp->bank_num; idx++) {
> > +		svsb = &svsp->banks[idx];
> > +		svsb->mts = mts;
> > +
> > +		switch (svsb->sw_id) {
> > +		case SVSB_CPU_LITTLE:
> > +			tb_roomt = x_roomt[3];
> > +			break;
> > +		case SVSB_CPU_BIG:
> > +			tb_roomt = x_roomt[4];
> > +			break;
> > +		case SVSB_CCI:
> > +			tb_roomt = x_roomt[3];
> > +			break;
> > +		case SVSB_GPU:
> > +			tb_roomt = x_roomt[1];
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +
> > +		temp0 = (tp.degc_cali * 10 / 2);
> > +		temp1 = ((10000 * 100000 / 4096 / tp.gain) *
> > +			 tp.oe + tb_roomt * 10) * 15 / 18;
> > +
> > +		if (!tp.o_slope_sign)
> > +			temp2 = temp1 * 100 / (1534 + tp.o_slope * 10);
> > +		else
> > +			temp2 = temp1 * 100 / (1534 - tp.o_slope * 10);
> > +
> > +		svsb->bts = (temp0 + temp2 - 250) * 4 / 10;
> > +	}
> > +
> > +	return true;
> > +}

[snip]

