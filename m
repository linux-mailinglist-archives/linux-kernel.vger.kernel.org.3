Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8813E4FBB00
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345645AbiDKLfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344167AbiDKLf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:35:29 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD4845783;
        Mon, 11 Apr 2022 04:33:14 -0700 (PDT)
X-UUID: ec7307cde0af4b17830cd361f74d2b89-20220411
X-UUID: ec7307cde0af4b17830cd361f74d2b89-20220411
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1482752981; Mon, 11 Apr 2022 19:33:12 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 11 Apr 2022 19:33:11 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Apr 2022 19:33:11 +0800
Message-ID: <0fad4560d167ed7f063e3e597b772bd440791b43.camel@mediatek.com>
Subject: Re: [PATCH V2 06/15] cpufreq: mediatek: Record previous target
 vproc value
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rafael@kernel.org>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <jia-wei.chang@mediatek.com>,
        <roger.lu@mediatek.com>, <hsinyi@google.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "Andrew-sh . Cheng" <andrew-sh.cheng@mediatek.com>
Date:   Mon, 11 Apr 2022 19:33:10 +0800
In-Reply-To: <20220411032654.5tqqivmstqkojfj5@vireshk-i7>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
         <20220408045908.21671-7-rex-bc.chen@mediatek.com>
         <20220411032654.5tqqivmstqkojfj5@vireshk-i7>
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

On Mon, 2022-04-11 at 08:56 +0530, Viresh Kumar wrote:
> On 08-04-22, 12:58, Rex-BC Chen wrote:
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
> >  drivers/cpufreq/mediatek-cpufreq.c | 31 +++++++++++++++++++-------
> > ----
> >  1 file changed, 20 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/mediatek-cpufreq.c
> > b/drivers/cpufreq/mediatek-cpufreq.c
> > index dc4a87e68940..472f4de29e5f 100644
> > --- a/drivers/cpufreq/mediatek-cpufreq.c
> > +++ b/drivers/cpufreq/mediatek-cpufreq.c
> > @@ -40,6 +40,7 @@ struct mtk_cpu_dvfs_info {
> >  	struct list_head list_head;
> >  	int intermediate_voltage;
> >  	bool need_voltage_tracking;
> > +	int old_vproc;
> 
> I like prev_vproc better somehow, but it is up to you to name it :)

Hello Viresh,

Thanks for your review.
I will modify this as prev_vproc in next version.

> 
> >  };
> >  
> >  static LIST_HEAD(dvfs_info_list);
> > @@ -190,11 +191,17 @@ static int
> > mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
> >  
> >  static int mtk_cpufreq_set_voltage(struct mtk_cpu_dvfs_info *info,
> > int vproc)
> >  {
> > +	int ret;
> > +
> >  	if (info->need_voltage_tracking)
> > -		return mtk_cpufreq_voltage_tracking(info, vproc);
> > +		ret = mtk_cpufreq_voltage_tracking(info, vproc);
> >  	else
> > -		return regulator_set_voltage(info->proc_reg, vproc,
> > -					     vproc + VOLT_TOL);
> > +		ret = regulator_set_voltage(info->proc_reg, vproc,
> > +					    MAX_VOLT_LIMIT);
> > +	if (!ret)
> > +		info->old_vproc = vproc;
> > +
> > +	return ret;
> >  }
> >  
> >  static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
> > @@ -211,15 +218,7 @@ static int mtk_cpufreq_set_target(struct
> > cpufreq_policy *policy,
> >  
> >  	inter_vproc = info->intermediate_voltage;
> >  
> > -	old_freq_hz = clk_get_rate(cpu_clk);
> > -	old_vproc = regulator_get_voltage(info->proc_reg);
> > -	if (old_vproc < 0) {
> > -		pr_err("%s: invalid Vproc value: %d\n", __func__,
> > old_vproc);
> > -		return old_vproc;
> > -	}
> > -
> 
> Why did you move it down from here? I think it was fine to error out
> early if voltage isn't available.

I will move them to original position in next version.

Thanks!

BRs,
Rex

> 
> >  	freq_hz = freq_table[index].frequency * 1000;
> > -
> >  	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &freq_hz);
> >  	if (IS_ERR(opp)) {
> >  		pr_err("cpu%d: failed to find OPP for %ld\n",
> > @@ -229,6 +228,16 @@ static int mtk_cpufreq_set_target(struct
> > cpufreq_policy *policy,
> >  	vproc = dev_pm_opp_get_voltage(opp);
> >  	dev_pm_opp_put(opp);
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
> > +
> >  	/*
> >  	 * If the new voltage or the intermediate voltage is higher
> > than the
> >  	 * current voltage, scale up voltage first.
> > -- 
> > 2.18.0
> 
> 

