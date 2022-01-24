Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34C4497970
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 08:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241886AbiAXH2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 02:28:39 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:34688 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241813AbiAXH2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:28:32 -0500
X-UUID: 707d40179bd543fd8fba229a40cedfab-20220124
X-UUID: 707d40179bd543fd8fba229a40cedfab-20220124
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1848919182; Mon, 24 Jan 2022 15:28:29 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 24 Jan 2022 15:28:28 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 24 Jan
 2022 15:28:27 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 24 Jan 2022 15:28:27 +0800
Message-ID: <f4fbfc91d2f0abf041f058f191e2b239ac173a1e.camel@mediatek.com>
Subject: Re: [PATCH v21 4/8] soc: mediatek: SVS: add monitor mode
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
Date:   Mon, 24 Jan 2022 15:28:27 +0800
In-Reply-To: <e118df40-da6b-88f6-fbff-15befb3405d5@collabora.com>
References: <20220107095200.4389-1-roger.lu@mediatek.com>
         <20220107095200.4389-5-roger.lu@mediatek.com>
         <e118df40-da6b-88f6-fbff-15befb3405d5@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AngeloGioacchino,

Sorry for the late reply and thanks for the advice.

On Fri, 2022-01-07 at 15:34 +0100, AngeloGioacchino Del Regno wrote:
> Il 07/01/22 10:51, Roger Lu ha scritto:
> > SVS monitor mode is based on different thermal temperature
> > to provide suitable SVS bank voltages.
> > 
> > Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> > ---
> >   drivers/soc/mediatek/mtk-svs.c | 253 ++++++++++++++++++++++++++++++++-
> >   1 file changed, 247 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> > index fc7e2ee44a92..042c6e8e9069 100644
> > --- a/drivers/soc/mediatek/mtk-svs.c
> > +++ b/drivers/soc/mediatek/mtk-svs.c
> > @@ -25,6 +25,7 @@
> >   #include <linux/regulator/consumer.h>
> >   #include <linux/slab.h>
> >   #include <linux/spinlock.h>
> > +#include <linux/thermal.h>
> >   
> >   /* svs bank 1-line sw id */
> >   #define SVSB_CPU_LITTLE			BIT(0)
> > @@ -36,6 +37,7 @@
> >   #define SVSB_MODE_ALL_DISABLE		0
> >   #define SVSB_MODE_INIT01		BIT(1)
> >   #define SVSB_MODE_INIT02		BIT(2)
> > +#define SVSB_MODE_MON			BIT(3)

[snip]

> >   /**
> > @@ -241,6 +254,7 @@ struct svs_platform {
> >    * @get_volts: function pointer to get bank voltages
> >    * @name: bank name
> >    * @buck_name: regulator name
> > + * @tzone_name: thermal zone name
> >    * @suspended: suspend flag of this bank
> >    * @phase: bank current phase
> >    * @volt_od: bank voltage overdrive
> > @@ -270,6 +284,13 @@ struct svs_platform {
> >    * @sw_id: bank software identification
> >    * @cpu_id: cpu core id for SVS CPU bank use only
> >    * @ctl0: TS-x selection
> > + * @temp: bank temperature
> > + * @tzone_htemp: thermal zone high temperature threshold
> > + * @tzone_htemp_voffset: thermal zone high temperature voltage offset
> > + * @tzone_ltemp: thermal zone low temperature threshold
> > + * @tzone_ltemp_voffset: thermal zone low temperature voltage offset
> > + * @bts: svs efuse data
> > + * @mts: svs efuse data
> >    * @bdes: svs efuse data
> >    * @mdes: svs efuse data
> >    * @mtdes: svs efuse data
> > @@ -292,6 +313,7 @@ struct svs_bank {
> >   	void (*get_volts)(struct svs_platform *svsp);
> >   	char *name;
> >   	char *buck_name;
> > +	char *tzone_name;
> >   	bool suspended;
> >   	enum svsb_phase phase;
> >   	s32 volt_od;
> > @@ -321,6 +343,13 @@ struct svs_bank {
> >   	u32 sw_id;
> >   	u32 cpu_id;
> >   	u32 ctl0;
> > +	u32 temp;
> > +	u32 tzone_htemp;
> > +	u32 tzone_htemp_voffset;
> > +	u32 tzone_ltemp;
> > +	u32 tzone_ltemp_voffset;
> > +	u32 bts;
> > +	u32 mts;
> >   	u32 bdes;
> >   	u32 mdes;
> >   	u32 mtdes;
> > @@ -361,10 +390,21 @@ static u32 svs_bank_volt_to_opp_volt(u32 svsb_volt,
> > u32 svsb_volt_step,
> >   	return (svsb_volt * svsb_volt_step) + svsb_volt_base;
> >   }
> >   
> 
> I'm sorry for the double review, but this went unnoticed in the previous one.
> 
> > +static int svs_get_zone_temperature(const char *tzone_name, int
> > *tzone_temp)
> > +{
> > +	struct thermal_zone_device *tzd;
> > +
> > +	tzd = thermal_zone_get_zone_by_name(tzone_name);
> 
> This call is expensive, as it's iterating through the (possibly) entire
> thermal_tz_list (drivers/thermal/thermal_core.c) so, for performance purposes,
> noting that you're using this in svs_adjust_pm_opp_volts(), it's not a good
> idea
> to call it at every ISR.
> 
> I would instead propose to get a pointer to the thermal_zone at driver probe
> time and cache that in struct svs_bank: this function would also be removed
> as the only thing that you'd need to do then would be just one call...
> 
> [read forward...]

No problem. I'll cache thermal_zone at driver probe time and remove this API in
the next patch. Thanks.

> 
> > +	if (IS_ERR(tzd))
> > +		return PTR_ERR(tzd);
> > +
> > +	return thermal_zone_get_temp(tzd, tzone_temp);
> > +}
> > +
> >   static int svs_adjust_pm_opp_volts(struct svs_bank *svsb, bool
> > force_update)
> >   {
> > -	int ret = -EPERM;
> > -	u32 i, svsb_volt, opp_volt;
> > +	int ret = -EPERM, tzone_temp = 0;
> > +	u32 i, svsb_volt, opp_volt, temp_voffset = 0;
> >   
> >   	mutex_lock(&svsb->lock);
> >   
> > @@ -378,6 +418,22 @@ static int svs_adjust_pm_opp_volts(struct svs_bank
> > *svsb, bool force_update)
> >   		goto unlock_mutex;
> >   	}
> >   
> > +	/* Get thermal effect */
> > +	if (svsb->phase == SVSB_PHASE_MON) {
> > +		ret = svs_get_zone_temperature(svsb->tzone_name, &tzone_temp);
> 
> ... so you can simply call ...
> 
> 
> 	ret = thermal_zone_get_temp(svsb->tzd, tzone_temp);
> 
> 
> ...without any need for any helper.

Sure, I'll call thermal_zone_get_temp() directly after applying this recommended
change in the next patch. Thanks.

> 
> > +		if (ret || (svsb->temp > SVSB_TEMP_UPPER_BOUND &&
> > +			    svsb->temp < SVSB_TEMP_LOWER_BOUND)) {
> > +			dev_err(svsb->dev, "%s: %d (0x%x), run default volts\n",
> > +				svsb->tzone_name, ret, svsb->temp);
> > +			svsb->phase = SVSB_PHASE_ERROR;
> > +		}
> > +
> > +		if (tzone_temp >= svsb->tzone_htemp)
> > +			temp_voffset += svsb->tzone_htemp_voffset;
> > +		else if (tzone_temp <= svsb->tzone_ltemp)
> > +			temp_voffset += svsb->tzone_ltemp_voffset;
> > +	}
> > +
> >   	/* vmin <= svsb_volt (opp_volt) <= default opp voltage */
> >   	for (i = 0; i < svsb->opp_count; i++) {
> >   		switch (svsb->phase) {
> 
> Apart from that, the commit looks good. Looking forward to review the new
> version!
> 
> Regards,
> - Angelo

