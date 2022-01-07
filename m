Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C1E487903
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347814AbiAGOde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347822AbiAGOdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:33:33 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A83CC061746;
        Fri,  7 Jan 2022 06:33:32 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id ADD2E1F41A85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641566010;
        bh=xsEtblrCb0tBGSZg8VcgU0f3IuRCjwRAstGnjQ8ex4M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QztwbUzfrGMamK1nWpM8GF6PyhX/dvB4Q4MRkV+FgjLDfhxFomfBA/TddHKIgB3x1
         43q4PBu4b4iO0S3kFcdqmiyHP3anskAUZUGjvQMG5Em2AqHqpFqgfZI3QpxBrYd6oA
         4h9Cjx/95lA8ECG2FTfu5eaupz6adnpD2bHDlPdsz/3YCYIRJ2ZM2X7o9LTkjX/KbX
         dAtivBbTKJleh18+csF8ixXQeRmeZC3wLNJu5ESLPTLBk7MhStatySGKSLreVFQF+l
         ezG2zpxcX/9zwDA4gYxThJg331dIv+bvKfRQNzP3/qSTCCkoBNdJS8R3JwaITQ7b4B
         h9SGuLEfNKThg==
Subject: Re: [PATCH v21 8/8] soc: mediatek: SVS: add mt8192 SVS GPU driver
To:     Roger Lu <roger.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Guenter Roeck <linux@roeck-us.net>
References: <20220107095200.4389-1-roger.lu@mediatek.com>
 <20220107095200.4389-9-roger.lu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <2c0e89c6-6e9c-9d12-703f-d71e22023e7a@collabora.com>
Date:   Fri, 7 Jan 2022 15:33:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220107095200.4389-9-roger.lu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/01/22 10:52, Roger Lu ha scritto:
> mt8192 SVS GPU uses 2-line (high/low bank) HW architecture to provide
> bank voltages. High bank helps update higher frequency's voltage
> and low bank helps update lower frequency's voltage.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-svs.c | 469 ++++++++++++++++++++++++++++++++-
>   1 file changed, 464 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index 93cdaecadd6d..bec6524ab33a 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c

..snip..

> @@ -639,9 +706,11 @@ static int svs_status_debug_show(struct seq_file *m, void *v)
>   
>   	ret = svs_get_zone_temperature(svsb->tzone_name, &tzone_temp);
>   	if (ret)
> -		seq_printf(m, "%s: temperature ignore\n", svsb->name);
> +		seq_printf(m, "%s: temperature ignore, turn_pt = %u\n",
> +			   svsb->name, svsb->turn_pt);
>   	else
> -		seq_printf(m, "%s: temperature = %d\n", svsb->name, tzone_temp);
> +		seq_printf(m, "%s: temperature = %d, turn_pt = %u\n",
> +			   svsb->name, tzone_temp, svsb->turn_pt);
>   
>   	for (i = 0; i < svsb->opp_count; i++) {
>   		opp = dev_pm_opp_find_freq_exact(svsb->opp_dev,
> @@ -784,6 +853,181 @@ static u32 interpolate(u32 f0, u32 f1, u32 v0, u32 v1, u32 fx)
>   	return DIV_ROUND_UP(vx, 100);
>   }
>   
> +static void svs_get_bank_volts_v3(struct svs_platform *svsp)
> +{
> +	struct svs_bank *svsb = svsp->pbank;
> +	u32 i, j, *vop, vop74, vop30, mask7_0 = GENMASK(7, 0);
> +	u32 b_sft, bits8 = 8, shift_byte = 0, reg_bytes = 4;

mask7_0, bits8, reg_bytes are constants, and it's not right to declare constants
as variables like you're doing here.

Please replace all usages of `mask7_0` with either a definition or with the call
to the GENMASK macro;
also, replace all usages of `bits8` with a definition, or just 8;
finally, either make `reg_bytes` a `const u8` or a definition.


In my opinion, a #define would be preferred, since the exact same comments on
the exact same values also apply to function svs_set_bank_freq_pct_v3().

After that fix, you'll get my R-b.

I feel like v22 will be golden :)

Regards,
- Angelo

> +	u32 middle_index = (svsb->opp_count / 2);
> +	u32 opp_start = 0, opp_stop = 0, turn_pt = svsb->turn_pt;
> +
> +	if (svsb->phase == SVSB_PHASE_MON &&
> +	    svsb->volt_flags & SVSB_MON_VOLT_IGNORE)
> +		return;
> +
> +	vop74 = svs_readl_relaxed(svsp, VOP74);
> +	vop30 = svs_readl_relaxed(svsp, VOP30);
> +
> +	/* Target is to set svsb->volt[] by algorithm */
> +	if (turn_pt < middle_index) {
> +		if (svsb->type == SVSB_HIGH) {
> +			/* volt[0] ~ volt[turn_pt - 1] */
> +			for (i = 0; i < turn_pt; i++) {
> +				b_sft = bits8 * (shift_byte % reg_bytes);
> +				vop = (shift_byte < reg_bytes) ? &vop30 :
> +								 &vop74;
> +				svsb->volt[i] = (*vop >> b_sft) & mask7_0;
> +				shift_byte++;
> +			}
> +		} else if (svsb->type == SVSB_LOW) {
> +			/* volt[turn_pt] + volt[j] ~ volt[opp_count - 1] */
> +			j = svsb->opp_count - 7;
> +			svsb->volt[turn_pt] = vop30 & mask7_0;
> +			shift_byte++;
> +			for (i = j; i < svsb->opp_count; i++) {
> +				b_sft = bits8 * (shift_byte % reg_bytes);
> +				vop = (shift_byte < reg_bytes) ? &vop30 :
> +								 &vop74;
> +				svsb->volt[i] = (*vop >> b_sft) & mask7_0;
> +				shift_byte++;
> +			}
> +
> +			/* volt[turn_pt + 1] ~ volt[j - 1] by interpolate */
> +			for (i = turn_pt + 1; i < j; i++)
> +				svsb->volt[i] =
> +					interpolate(svsb->freq_pct[turn_pt],
> +						    svsb->freq_pct[j],
> +						    svsb->volt[turn_pt],
> +						    svsb->volt[j],
> +						    svsb->freq_pct[i]);
> +		}
> +	} else {
> +		if (svsb->type == SVSB_HIGH) {
> +			/* volt[0] + volt[j] ~ volt[turn_pt - 1] */
> +			j = turn_pt - 7;
> +			svsb->volt[0] = vop30 & mask7_0;
> +			shift_byte++;
> +			for (i = j; i < turn_pt; i++) {
> +				b_sft = bits8 * (shift_byte % reg_bytes);
> +				vop = (shift_byte < reg_bytes) ? &vop30 :
> +								 &vop74;
> +				svsb->volt[i] = (*vop >> b_sft) & mask7_0;
> +				shift_byte++;
> +			}
> +
> +			/* volt[1] ~ volt[j - 1] by interpolate */
> +			for (i = 1; i < j; i++)
> +				svsb->volt[i] =
> +					interpolate(svsb->freq_pct[0],
> +						    svsb->freq_pct[j],
> +						    svsb->volt[0],
> +						    svsb->volt[j],
> +						    svsb->freq_pct[i]);
> +		} else if (svsb->type == SVSB_LOW) {
> +			/* volt[turn_pt] ~ volt[opp_count - 1] */
> +			for (i = turn_pt; i < svsb->opp_count; i++) {
> +				b_sft = bits8 * (shift_byte % reg_bytes);
> +				vop = (shift_byte < reg_bytes) ? &vop30 :
> +								 &vop74;
> +				svsb->volt[i] = (*vop >> b_sft) & mask7_0;
> +				shift_byte++;
> +			}
> +		}
> +	}
> +
> +	if (svsb->type == SVSB_HIGH) {
> +		opp_start = 0;
> +		opp_stop = svsb->turn_pt;
> +	} else if (svsb->type == SVSB_LOW) {
> +		opp_start = svsb->turn_pt;
> +		opp_stop = svsb->opp_count;
> +	}
> +
> +	for (i = opp_start; i < opp_stop; i++)
> +		if (svsb->volt_flags & SVSB_REMOVE_DVTFIXED_VOLT)
> +			svsb->volt[i] -= svsb->dvt_fixed;
> +}
> +
> +static void svs_set_bank_freq_pct_v3(struct svs_platform *svsp)
> +{
> +	struct svs_bank *svsb = svsp->pbank;
> +	u32 i, j, *freq_pct, freq_pct74 = 0, freq_pct30 = 0;
> +	u32 b_sft, bits8 = 8, shift_byte = 0, reg_bytes = 4;
> +	u32 middle_index = (svsb->opp_count / 2);
> +	u32 turn_pt = middle_index;
> +
> +	for (i = 0; i < svsb->opp_count; i++) {
> +		if (svsb->opp_dfreq[i] <= svsb->turn_freq_base) {
> +			svsb->turn_pt = i;
> +			break;
> +		}
> +	}
> +
> +	turn_pt = svsb->turn_pt;
> +
> +	/* Target is to fill out freq_pct74 / freq_pct30 by algorithm */
> +	if (turn_pt < middle_index) {
> +		if (svsb->type == SVSB_HIGH) {
> +			/* Edge case for preventing freq_pct30 from being 0 */
> +			if (turn_pt == 0)
> +				freq_pct30 = svsb->freq_pct[0];
> +
> +			/* freq_pct[0] ~ freq_pct[turn_pt - 1] */
> +			for (i = 0; i < turn_pt; i++) {
> +				b_sft = bits8 * (shift_byte % reg_bytes);
> +				freq_pct = (shift_byte < reg_bytes) ?
> +					   &freq_pct30 : &freq_pct74;
> +				*freq_pct |= (svsb->freq_pct[i] << b_sft);
> +				shift_byte++;
> +			}
> +		} else if (svsb->type == SVSB_LOW) {
> +			/*
> +			 * freq_pct[turn_pt] +
> +			 * freq_pct[opp_count - 7] ~ freq_pct[opp_count -1]
> +			 */
> +			freq_pct30 = svsb->freq_pct[turn_pt];
> +			shift_byte++;
> +			j = svsb->opp_count - 7;
> +			for (i = j; i < svsb->opp_count; i++) {
> +				b_sft = bits8 * (shift_byte % reg_bytes);
> +				freq_pct = (shift_byte < reg_bytes) ?
> +					   &freq_pct30 : &freq_pct74;
> +				*freq_pct |= (svsb->freq_pct[i] << b_sft);
> +				shift_byte++;
> +			}
> +		}
> +	} else {
> +		if (svsb->type == SVSB_HIGH) {
> +			/*
> +			 * freq_pct[0] +
> +			 * freq_pct[turn_pt - 7] ~ freq_pct[turn_pt - 1]
> +			 */
> +			freq_pct30 = svsb->freq_pct[0];
> +			shift_byte++;
> +			j = turn_pt - 7;
> +			for (i = j; i < turn_pt; i++) {
> +				b_sft = bits8 * (shift_byte % reg_bytes);
> +				freq_pct = (shift_byte < reg_bytes) ?
> +					   &freq_pct30 : &freq_pct74;
> +				*freq_pct |= (svsb->freq_pct[i] << b_sft);
> +				shift_byte++;
> +			}
> +		} else if (svsb->type == SVSB_LOW) {
> +			/* freq_pct[turn_pt] ~ freq_pct[opp_count - 1] */
> +			for (i = turn_pt; i < svsb->opp_count; i++) {
> +				b_sft = bits8 * (shift_byte % reg_bytes);
> +				freq_pct = (shift_byte < reg_bytes) ?
> +					   &freq_pct30 : &freq_pct74;
> +				*freq_pct |= (svsb->freq_pct[i] << b_sft);
> +				shift_byte++;
> +			}
> +		}
> +	}
> +
> +	svs_writel_relaxed(svsp, freq_pct74, FREQPCT74);
> +	svs_writel_relaxed(svsp, freq_pct30, FREQPCT30);
> +}
> +
>   static void svs_get_bank_volts_v2(struct svs_platform *svsp)
>   {
>   	struct svs_bank *svsb = svsp->pbank;


