Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D698E487918
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239306AbiAGOfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:35:03 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40962 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiAGOfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:35:01 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E656F1F46484
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641566099;
        bh=tO2bafMKol/hq/296vAXOxJK1zX8lB17tRRk8j/yVMU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=n0Q/+BXcDc256g8LCW4ZtbwUMvlpa54V6RtKsE60O2nwj5Hol+3rq9wPhDTbAqSFi
         CgK8XIxq4wVzA4Ue9XbOGmCl7uPbOXczAhKAza4WouLK582qQe2Nz4oqnep7WVJKsI
         C4NaBX3Z6LbLxdxPAF5Q/wnZ6Lx2TcLP4VsaIUe1gMPb+Rz+lda+5JLhnH6KiGSYJ9
         +sxNvgWNYDsRJ1QrHP7tyvYJ8rm8z8aD/YuCpz8Lk6Zx/IaUOOtjnkq06rLyDY726b
         tQHFFQM7nSegzGjjO8UTDeNvseRkXTtO82usILDT+og2I2+LhHKGxuJ9jbbjkhALjt
         n554laxjjXi4Q==
Subject: Re: [PATCH v21 5/8] soc: mediatek: SVS: add debug commands
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
 <20220107095200.4389-6-roger.lu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <47bcbffc-42f6-335e-dfab-990e0ab5f103@collabora.com>
Date:   Fri, 7 Jan 2022 15:34:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220107095200.4389-6-roger.lu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/01/22 10:51, Roger Lu ha scritto:
> The purpose of SVS is to help find the suitable voltages
> for DVFS. Therefore, if SVS bank voltages are concerned
> to be wrong, we can adjust SVS bank voltages by this patch.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-svs.c | 321 ++++++++++++++++++++++++++++++++-
>   1 file changed, 318 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index 042c6e8e9069..93cdaecadd6d 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c

..snip..

> @@ -605,6 +896,16 @@ static void svs_set_bank_phase(struct svs_platform *svsp,
>   	}
>   }
>   
> +static inline void svs_save_bank_register_data(struct svs_platform *svsp,
> +					       enum svsb_phase phase)
> +{
> +	struct svs_bank *svsb = svsp->pbank;
> +	enum svs_reg_index rg_i;
> +

I think that it'd be a good idea to add an `enable` parameter, so that we
don't always do a register dump; after all, this is a debugging feature and
it's going to be completely irrelevant to the user, so keeping this disabled
by default would ensure to get no performance degradation (even if small)
unless really wanted.

So, in this case, here we'd have

	if (!svsp->debug_enabled)
		return;

> +	for (rg_i = DESCHAR; rg_i < SVS_REG_MAX; rg_i++)
> +		svsb->reg_data[phase][rg_i] = svs_readl_relaxed(svsp, rg_i);
> +}
> +

Of course, this implies adding a new debugfs entry to enable/disable the debugging.
Everything else looks good :)

>   static inline void svs_error_isr_handler(struct svs_platform *svsp)
>   {
>   	struct svs_bank *svsb = svsp->pbank;
> @@ -619,6 +920,8 @@ static inline void svs_error_isr_handler(struct svs_platform *svsp)
>   		svs_readl_relaxed(svsp, SMSTATE1));
>   	dev_err(svsb->dev, "TEMP = 0x%08x\n", svs_readl_relaxed(svsp, TEMP));
>   
> +	svs_save_bank_register_data(svsp, SVSB_PHASE_ERROR);
> +
>   	svsb->mode_support = SVSB_MODE_ALL_DISABLE;
>   	svsb->phase = SVSB_PHASE_ERROR;
>   
> @@ -635,6 +938,8 @@ static inline void svs_init01_isr_handler(struct svs_platform *svsp)
>   		 svs_readl_relaxed(svsp, VDESIGN30),
>   		 svs_readl_relaxed(svsp, DCVALUES));
>   
> +	svs_save_bank_register_data(svsp, SVSB_PHASE_INIT01);
> +
>   	svsb->phase = SVSB_PHASE_INIT01;
>   	svsb->dc_voffset_in = ~(svs_readl_relaxed(svsp, DCVALUES) &
>   				GENMASK(15, 0)) + 1;
> @@ -662,6 +967,8 @@ static inline void svs_init02_isr_handler(struct svs_platform *svsp)
>   		 svs_readl_relaxed(svsp, VOP30),
>   		 svs_readl_relaxed(svsp, DCVALUES));
>   
> +	svs_save_bank_register_data(svsp, SVSB_PHASE_INIT02);
> +
>   	svsb->phase = SVSB_PHASE_INIT02;
>   	svsb->get_volts(svsp);
>   
> @@ -673,6 +980,8 @@ static inline void svs_mon_mode_isr_handler(struct svs_platform *svsp)
>   {
>   	struct svs_bank *svsb = svsp->pbank;
>   
> +	svs_save_bank_register_data(svsp, SVSB_PHASE_MON);
> +
>   	svsb->phase = SVSB_PHASE_MON;
>   	svsb->temp = svs_readl_relaxed(svsp, TEMP) & GENMASK(7, 0);
>   	svsb->get_volts(svsp);
> @@ -1658,6 +1967,12 @@ static int svs_probe(struct platform_device *pdev)
>   		goto svs_probe_iounmap;
>   	}
>   
> +	ret = svs_create_debug_cmds(svsp);
> +	if (ret) {
> +		dev_err(svsp->dev, "svs create debug cmds fail: %d\n", ret);
> +		goto svs_probe_iounmap;
> +	}
> +
>   	return 0;
>   
>   svs_probe_iounmap:
> 

