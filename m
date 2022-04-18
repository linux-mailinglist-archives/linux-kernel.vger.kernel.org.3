Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE95504AAD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 03:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbiDRBsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 21:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbiDRBsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 21:48:00 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321A710FC8;
        Sun, 17 Apr 2022 18:45:21 -0700 (PDT)
X-UUID: 2f8e0fc2f68c4275b598f47fb438682a-20220418
X-UUID: 2f8e0fc2f68c4275b598f47fb438682a-20220418
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 189061640; Mon, 18 Apr 2022 09:45:11 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 18 Apr 2022 09:45:10 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 18 Apr
 2022 09:45:09 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 18 Apr 2022 09:45:09 +0800
Message-ID: <fb61128ab1534982ed9f8c8d7a141afad04d8fbb.camel@mediatek.com>
Subject: Re: [PATCH V3 11/15] cpufreq: mediatek: Link CCI device to CPU
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <jia-wei.chang@mediatek.com>, <roger.lu@mediatek.com>,
        <hsinyi@google.com>, <khilman@baylibre.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 18 Apr 2022 09:45:09 +0800
In-Reply-To: <9fccbb92-1832-bf5d-7804-80dd481663fc@collabora.com>
References: <20220415055916.28350-1-rex-bc.chen@mediatek.com>
         <20220415055916.28350-12-rex-bc.chen@mediatek.com>
         <9fccbb92-1832-bf5d-7804-80dd481663fc@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-04-15 at 14:24 +0200, AngeloGioacchino Del Regno wrote:
> Il 15/04/22 07:59, Rex-BC Chen ha scritto:
> > From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > 
> > In some MediaTek SoCs, like MT8183, CPU and CCI share the same
> > power
> > supplies. Cpufreq needs to check if CCI devfreq exists and wait
> > until
> > CCI devfreq ready before scaling frequency.
> > 
> > Before CCI devfreq is ready, we record the voltage when booting to
> > kernel and use the max(cpu target voltage, booting voltage) to
> > prevent cpufreq adjust to the lower voltage which will cause the
> > CCI
> > crash because of high frequency and low voltage.
> > 
> > - Add is_ccifreq_ready() to link CCI device to CPI, and CPU will
> > start
> >    DVFS when CCI is ready.
> > - Add platform data for MT8183.
> > 
> > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> 
> I am enthusiast to see that the solution that I've proposed was
> welcome!
> 
> I only have one nit on this patch, check below:
> 

Hello Angelo,

Thanks for your advice for this modification.
I also reply to Kevin and describe this solution.
Let's wait for Kevin's feedback and other suggestion.

> > ---
> >   drivers/cpufreq/mediatek-cpufreq.c | 80
> > +++++++++++++++++++++++++++++-
> >   1 file changed, 79 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/mediatek-cpufreq.c
> > b/drivers/cpufreq/mediatek-cpufreq.c
> > index d4c00237e862..dd3f739fede1 100644
> > --- a/drivers/cpufreq/mediatek-cpufreq.c
> > +++ b/drivers/cpufreq/mediatek-cpufreq.c
> 
> ..snip..
> 
> > @@ -225,6 +251,14 @@ static int mtk_cpufreq_set_target(struct
> > cpufreq_policy *policy,
> >   	vproc = dev_pm_opp_get_voltage(opp);
> >   	dev_pm_opp_put(opp);
> >   
> > +	/*
> > +	 * If MediaTek cci is supported but is not ready, we will use
> > the value
> > +	 * of max(target cpu voltage, booting voltage) to prevent high
> > freqeuncy
> > +	 * low voltage crash.
> > +	 */
> > +	if (info->soc_data->ccifreq_supported &&
> > !is_ccifreq_ready(info))
> > +		vproc = max(vproc, info->vproc_on_boot);
> > +
> >   	/*
> >   	 * If the new voltage or the intermediate voltage is higher
> > than the
> >   	 * current voltage, scale up voltage first.
> 
> ..snip..
> 
> > @@ -423,6 +484,13 @@ static int mtk_cpu_dvfs_info_init(struct
> > mtk_cpu_dvfs_info *info, int cpu)
> >   	if (ret)
> >   		goto out_disable_mux_clock;
> >   
> > +	info->vproc_on_boot = regulator_get_voltage(info->proc_reg);
> 
> This result is used only if we use ccifreq, so this should be
> enclosed in an if
> condition: this will spare us some (yes, small) time on devices that
> don't use it.
> 
> 	if (info->soc_data->ccifreq_supported) {
> 		info->vproc_on_boot = regulator_get_voltage(info-
> >proc_reg);
> 		if (info->vproc_on_boot < 0) {
> 			dev_err(....
> 			goto ..
> 		}
> 	}
> 
> P.S.: While at it, since the maximum width is 100 columns, the
> dev_err() call fits,
> so don't break that line!
> 
> After the requested change:
> 
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>

I will add this in next version if there is no any suggestion for this
patch.

Thanks!

BRs,
Rex

