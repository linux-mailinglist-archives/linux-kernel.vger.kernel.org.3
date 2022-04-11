Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B594FBB52
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343945AbiDKLwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242979AbiDKLwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:52:25 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99422338A8;
        Mon, 11 Apr 2022 04:50:10 -0700 (PDT)
X-UUID: 5ac3e574fb744c4f8d5ef478c0b669f9-20220411
X-UUID: 5ac3e574fb744c4f8d5ef478c0b669f9-20220411
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 534694944; Mon, 11 Apr 2022 19:50:04 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 11 Apr 2022 19:50:03 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Apr 2022 19:50:03 +0800
Message-ID: <7920cc153930ab1e724fe65df370fc70f6cbe3db.camel@mediatek.com>
Subject: Re: [PATCH V2 13/15] cpufreq: mediatek: Link CCI device to CPU
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>
CC:     <matthias.bgg@gmail.com>, <jia-wei.chang@mediatek.com>,
        <roger.lu@mediatek.com>, <hsinyi@google.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 11 Apr 2022 19:50:03 +0800
In-Reply-To: <dc18d877-effb-1286-341d-1792ea6fcc05@collabora.com>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
         <20220408045908.21671-14-rex-bc.chen@mediatek.com>
         <dc18d877-effb-1286-341d-1792ea6fcc05@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-04-08 at 15:37 +0200, AngeloGioacchino Del Regno wrote:
> Il 08/04/22 06:59, Rex-BC Chen ha scritto:
> > From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > 
> > In some MediaTek SoCs, like MT8183, CPU and CCI share the same
> > power
> > supplies. Cpufreq needs to check if CCI devfreq exists and wait
> > until
> > CCI devfreq ready before scaling frequency.
> > 
> > - Add is_ccifreq_ready() to link CCI device to CPI, and CPU will
> > start
> >    DVFS when CCI is ready.
> > - Add platform data for MT8183.
> > 
> > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > ---
> >   drivers/cpufreq/mediatek-cpufreq.c | 69
> > +++++++++++++++++++++++++++++-
> >   1 file changed, 68 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/mediatek-cpufreq.c
> > b/drivers/cpufreq/mediatek-cpufreq.c
> > index b08ab7c14818..cebe5af2ef5d 100644
> > --- a/drivers/cpufreq/mediatek-cpufreq.c
> > +++ b/drivers/cpufreq/mediatek-cpufreq.c
> > @@ -22,6 +22,7 @@ struct mtk_cpufreq_platform_data {
> >   	int proc_max_volt;
> >   	int sram_min_volt;
> >   	int sram_max_volt;
> > +	bool is_ccifreq_support;
> 
> bool ccifreq_supported; looks better.

Hello Angelo,

Thanks for your review.

OK, I will modify this in next version.

> 
> >   };
> >   
> >   /*
> > @@ -38,6 +39,7 @@ struct mtk_cpufreq_platform_data {
> >   struct mtk_cpu_dvfs_info {
> >   	struct cpumask cpus;
> >   	struct device *cpu_dev;
> > +	struct device *cci_dev;
> >   	struct regulator *proc_reg;
> >   	struct regulator *sram_reg;
> >   	struct clk *cpu_clk;
> > @@ -52,6 +54,7 @@ struct mtk_cpu_dvfs_info {
> >   	int opp_cpu;
> >   	unsigned long opp_freq;
> >   	const struct mtk_cpufreq_platform_data *soc_data;
> > +	bool is_ccifreq_bounded;
> 
> bool ccifreq_bound; looks better.
> 

OK, I will modify this in next version.

> >   };
> >   
> >   static struct platform_device *cpufreq_pdev;
> > @@ -171,6 +174,29 @@ static int mtk_cpufreq_set_voltage(struct
> > mtk_cpu_dvfs_info *info, int vproc)
> >   	return ret;
> >   }
> >   
> > +static bool is_ccifreq_ready(struct mtk_cpu_dvfs_info *info)
> > +{
> > +	struct device_link *sup_link;
> > +
> > +	if (info->is_ccifreq_bounded)
> > +		return true;
> > +
> > +	sup_link = device_link_add(info->cpu_dev, info->cci_dev,
> > +				   DL_FLAG_AUTOREMOVE_CONSUMER);
> > +	if (!sup_link) {
> > +		dev_err(info->cpu_dev, "cpu%d: sup_link is NULL\n",
> > +			info->opp_cpu);
> 
> Please, don't break this line: 84 columns are ok.
> 

OK, I will modify this in next version.

> > +		return false;
> > +	}
> > +
> > +	if (sup_link->supplier->links.status != DL_DEV_DRIVER_BOUND)
> > +		return false;
> > +
> > +	info->is_ccifreq_bounded = true;
> > +
> > +	return true;
> > +}
> > +
> >   static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
> >   				  unsigned int index)
> >   {
> > @@ -183,6 +209,9 @@ static int mtk_cpufreq_set_target(struct
> > cpufreq_policy *policy,
> >   	long freq_hz, old_freq_hz;
> >   	int vproc, old_vproc, inter_vproc, target_vproc, ret;
> >   
> > +	if (info->soc_data->is_ccifreq_support &&
> > !is_ccifreq_ready(info))
> > +		return 0;
> 
> Honestly, I think that pretending that everything is alright and
> faking
> set_target success is *not* a good idea...
> 
> You should return -EAGAIN here, not zero.
> 
> Regards,
> Angelo
> 

As metioneded by Kevin, I will review these three situations.
Thanks for your suggestion.

BRs,
Rex

