Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09894FBB10
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345667AbiDKLh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236405AbiDKLhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:37:24 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD1539D;
        Mon, 11 Apr 2022 04:35:08 -0700 (PDT)
X-UUID: dbd08abc811945b1993f258b3e75863a-20220411
X-UUID: dbd08abc811945b1993f258b3e75863a-20220411
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1613410139; Mon, 11 Apr 2022 19:35:02 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 11 Apr 2022 19:35:01 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 11 Apr
 2022 19:35:01 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Apr 2022 19:35:01 +0800
Message-ID: <096e5da55313bb064575af4e64915fecb839a248.camel@mediatek.com>
Subject: Re: [PATCH V2 06/15] cpufreq: mediatek: Record previous target
 vproc value
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
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "Andrew-sh . Cheng" <andrew-sh.cheng@mediatek.com>
Date:   Mon, 11 Apr 2022 19:35:00 +0800
In-Reply-To: <4cc24333-3985-5efe-cc5f-c7b8492f6c1e@collabora.com>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
         <20220408045908.21671-7-rex-bc.chen@mediatek.com>
         <4cc24333-3985-5efe-cc5f-c7b8492f6c1e@collabora.com>
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

On Fri, 2022-04-08 at 15:36 +0200, AngeloGioacchino Del Regno wrote:
> Il 08/04/22 06:58, Rex-BC Chen ha scritto:
> > From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > 
> > We found the buck voltage may not be exactly the same with what we
> > set
> > because CPU may share the same buck with other module.
> > Therefore, we need to record the previous desired value instead of
> > reading
> > it from regulators.
> > 
> > Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > ---
> >   drivers/cpufreq/mediatek-cpufreq.c | 31 +++++++++++++++++++----
> > -------
> >   1 file changed, 20 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/mediatek-cpufreq.c
> > b/drivers/cpufreq/mediatek-cpufreq.c
> > index dc4a87e68940..472f4de29e5f 100644
> > --- a/drivers/cpufreq/mediatek-cpufreq.c
> > +++ b/drivers/cpufreq/mediatek-cpufreq.c
> > @@ -40,6 +40,7 @@ struct mtk_cpu_dvfs_info {
> >   	struct list_head list_head;
> >   	int intermediate_voltage;
> >   	bool need_voltage_tracking;
> > +	int old_vproc;
> >   };
> >   
> >   static LIST_HEAD(dvfs_info_list);
> > @@ -190,11 +191,17 @@ static int
> > mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
> >   
> >   static int mtk_cpufreq_set_voltage(struct mtk_cpu_dvfs_info
> > *info, int vproc)
> >   {
> > +	int ret;
> > +
> >   	if (info->need_voltage_tracking)
> > -		return mtk_cpufreq_voltage_tracking(info, vproc);
> > +		ret = mtk_cpufreq_voltage_tracking(info, vproc);
> >   	else
> > -		return regulator_set_voltage(info->proc_reg, vproc,
> > -					     vproc + VOLT_TOL);
> > +		ret = regulator_set_voltage(info->proc_reg, vproc,
> > +					    MAX_VOLT_LIMIT);
> > +	if (!ret)
> > +		info->old_vproc = vproc;
> > +
> > +	return ret;
> >   }
> >   
> >   static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
> > @@ -211,15 +218,7 @@ static int mtk_cpufreq_set_target(struct
> > cpufreq_policy *policy,
> >   
> >   	inter_vproc = info->intermediate_voltage;
> >   
> > -	old_freq_hz = clk_get_rate(cpu_clk);
> > -	old_vproc = regulator_get_voltage(info->proc_reg);
> > -	if (old_vproc < 0) {
> > -		pr_err("%s: invalid Vproc value: %d\n", __func__,
> > old_vproc);
> > -		return old_vproc;
> > -	}
> > -
> >   	freq_hz = freq_table[index].frequency * 1000;
> > -
> >   	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &freq_hz);
> >   	if (IS_ERR(opp)) {
> >   		pr_err("cpu%d: failed to find OPP for %ld\n",
> > @@ -229,6 +228,16 @@ static int mtk_cpufreq_set_target(struct
> > cpufreq_policy *policy,
> >   	vproc = dev_pm_opp_get_voltage(opp);
> >   	dev_pm_opp_put(opp);
> >   
> > +	old_freq_hz = clk_get_rate(cpu_clk);
> > +	old_vproc = info->old_vproc;
> > +	if (old_vproc == 0)
> > +		old_vproc = regulator_get_voltage(info->proc_reg);
> > +	if (old_vproc < 0) {
> > +		dev_err(cpu_dev, "%s: invalid Vproc value: %d\n",
> > +			__func__, old_vproc);
> > +		return old_vproc;
> > +	}
> 
>  From my understandment, if this fails once, it fails forever!
> 
> info->old_vproc is set only if info->need_voltage_tracking is true,
> and only
> in mtk_cpufreq_set_voltage(): this function is called only after the
> checks
> that you've introduced there, and that's on previously stored values.
> While this was fine in the previous version, because it was always
> calling
> regulator_get_voltage(), here it's not.
> 
> I think that a good option here is to:
> 
> old_vproc = info->old_vproc;
> if (old_vproc <= 0)
> 	old_vproc = regulator_get_voltage(info->proc_reg);
> if (old_vproc < 0) {
> 	dev_err and return
> }
> 
> ...or, if this is not applicable, we should still find another way to
> not
> let this driver to simply fail forever in case anything goes wrong.
> 
> Regards,
> Angelo

Hello Angelo,

Yes, your concern is right.
I will add this in next version.

if (old_vproc <= 0)
	old_vproc = regulator_get_voltage(info->proc_reg);
if (old_vproc < 0) {
	dev_err and return
}

BRs,
Rex

