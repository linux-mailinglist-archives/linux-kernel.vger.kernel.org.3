Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71191504A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 03:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbiDRBkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 21:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbiDRBka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 21:40:30 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12846B87C;
        Sun, 17 Apr 2022 18:37:52 -0700 (PDT)
X-UUID: 1227b60080594bb489291a5e9899a0b5-20220418
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:a9652940-7633-4f59-b913-3764e1a50e25,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.4,REQID:a9652940-7633-4f59-b913-3764e1a50e25,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:faefae9,CLOUDID:430f2eef-06b0-4305-bfbf-554bfc9d151a,C
        OID:IGNORED,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:0,EDM:-3,File:ni
        l,QS:0,BEC:nil
X-UUID: 1227b60080594bb489291a5e9899a0b5-20220418
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 731530093; Mon, 18 Apr 2022 09:37:46 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 18 Apr 2022 09:37:45 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 18 Apr
 2022 09:37:45 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 18 Apr 2022 09:37:45 +0800
Message-ID: <3a1fe42adace3a1355b6a95fbd55abc724c1053d.camel@mediatek.com>
Subject: Re: [PATCH V3 04/15] cpufreq: mediatek: Record previous target
 vproc value
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
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "Andrew-sh . Cheng" <andrew-sh.cheng@mediatek.com>
Date:   Mon, 18 Apr 2022 09:37:45 +0800
In-Reply-To: <9751622e-f969-c025-2a39-efcc9a612392@collabora.com>
References: <20220415055916.28350-1-rex-bc.chen@mediatek.com>
         <20220415055916.28350-5-rex-bc.chen@mediatek.com>
         <9751622e-f969-c025-2a39-efcc9a612392@collabora.com>
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

On Fri, 2022-04-15 at 14:24 +0200, AngeloGioacchino Del Regno wrote:
> Il 15/04/22 07:59, Rex-BC Chen ha scritto:
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
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > ---
> >   drivers/cpufreq/mediatek-cpufreq.c | 17 +++++++++++++----
> >   1 file changed, 13 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/mediatek-cpufreq.c
> > b/drivers/cpufreq/mediatek-cpufreq.c
> > index ff27f77e8ee6..fa8b193bf27b 100644
> > --- a/drivers/cpufreq/mediatek-cpufreq.c
> > +++ b/drivers/cpufreq/mediatek-cpufreq.c
> > @@ -40,6 +40,7 @@ struct mtk_cpu_dvfs_info {
> >   	struct list_head list_head;
> >   	int intermediate_voltage;
> >   	bool need_voltage_tracking;
> > +	int pre_vproc;
> >   };
> >   
> >   static LIST_HEAD(dvfs_info_list);
> > @@ -191,11 +192,17 @@ static int
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
> > +		info->pre_vproc = vproc;
> > +
> > +	return ret;
> >   }
> >   
> >   static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
> > @@ -213,7 +220,9 @@ static int mtk_cpufreq_set_target(struct
> > cpufreq_policy *policy,
> >   	inter_vproc = info->intermediate_voltage;
> >   
> >   	pre_freq_hz = clk_get_rate(cpu_clk);
> > -	pre_vproc = regulator_get_voltage(info->proc_reg);
> > +	pre_vproc = info->pre_vproc;
> > +	if (pre_vproc <= 0)
> > +		pre_vproc = regulator_get_voltage(info->proc_reg);
> 
> I would do it like that, instead:
> 
> 	if (unlikely(info->pre_vproc <= 0))
> 		pre_vproc = regulator_get_voltage(info->proc_reg);
> 	else
> 		pre_vproc = info->pre_vproc;
> 
> ....as even though it is indeed possible that info->pre_vproc is <=
> 0, it is
> very unlikely to happen ;-)
> This also solves a 'pre_vproc' double assignment issue, by the way.
> 
> Cheers,
> Angelo
> 
> 
> 

Hello Angelo,

OK, I will add this in next version.
Thanks for your suggestion.

BRs,
Rex

