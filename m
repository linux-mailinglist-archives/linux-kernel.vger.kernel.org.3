Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FCE4E6147
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349345AbiCXJta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 05:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239549AbiCXJt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:49:28 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C8856C0B;
        Thu, 24 Mar 2022 02:47:54 -0700 (PDT)
X-UUID: 906a8ac4647c4f778edaaec8b06d2341-20220324
X-UUID: 906a8ac4647c4f778edaaec8b06d2341-20220324
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1951271556; Thu, 24 Mar 2022 17:47:49 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 24 Mar 2022 17:47:48 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 24 Mar
 2022 17:47:47 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Mar 2022 17:47:47 +0800
Message-ID: <c3b5fc807465c4ed3b01b518c2582069683f5a13.camel@mediatek.com>
Subject: Re: [PATCH 3/4] cpufreq: mediatek: clean up cpufreq driver
From:   Jia-Wei Chang <jia-wei.chang@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Mark Brown" <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <fan.chen@mediatek.com>,
        <louis.yu@mediatek.com>, <roger.lu@mediatek.com>,
        <Allen-yy.Lin@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <hsinyi@google.com>,
        Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
Date:   Thu, 24 Mar 2022 17:47:47 +0800
In-Reply-To: <0fa44005-158b-74ee-f4ff-f2694ffce38a@canonical.com>
References: <20220307122151.11666-1-jia-wei.chang@mediatek.com>
         <20220307122151.11666-4-jia-wei.chang@mediatek.com>
         <0fa44005-158b-74ee-f4ff-f2694ffce38a@canonical.com>
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

On Mon, 2022-03-07 at 20:02 +0100, Krzysztof Kozlowski wrote:
> On 07/03/2022 13:21, Tim Chang wrote:
> > cleanup of naming, print log and comments.
> > 
> > Signed-off-by: Jia-Wei Chang <
> > jia-wei.chang@mediatek.corp-partner.google.com>
> > ---
> >  drivers/cpufreq/mediatek-cpufreq.c | 487 ++++++++++++++-----------
> > ----
> >  1 file changed, 233 insertions(+), 254 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/mediatek-cpufreq.c
> > b/drivers/cpufreq/mediatek-cpufreq.c
> > index 8e9d706d8081..3f00c7eb01f1 100644
> > --- a/drivers/cpufreq/mediatek-cpufreq.c
> > +++ b/drivers/cpufreq/mediatek-cpufreq.c
> > @@ -1,7 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /*
> > - * Copyright (c) 2015 Linaro Ltd.
> > - * Author: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> > + * Copyright (C) 2022 MediaTek Inc.
> 
> Removal of authorship and existing copyrights does not fit into
> "clean
> up". Please explain this thoroughly.

This is my mistake.
I will keep it as before and add myself as a new author.

> 
> >   */
> >  
> >  #include <linux/clk.h>
> > @@ -22,7 +21,7 @@
> >  #define VOLT_TOL		(10000)
> >  
> >  /*
> > - * The struct mtk_cpu_dvfs_info holds necessary information for
> > doing CPU DVFS
> > + * The struct mtk_cpufreq_drv holds necessary information for
> > doing CPU DVFS
> >   * on each CPU power/clock domain of Mediatek SoCs. Each CPU
> > cluster in
> >   * Mediatek SoCs has two voltage inputs, Vproc and Vsram. In some
> > cases the two
> >   * voltage inputs need to be controlled under a hardware
> > limitation:
> > @@ -32,7 +31,7 @@
> >   * needs to be switched to another stable PLL clock temporarily
> > until
> >   * the original PLL becomes stable at target frequency.
> >   */
> > -struct mtk_cpu_dvfs_info {
> > +struct mtk_cpufreq_drv {
> >  	struct cpumask cpus;
> >  	struct device *cpu_dev;
> >  	struct regulator *proc_reg;
> > @@ -40,45 +39,45 @@ struct mtk_cpu_dvfs_info {
> >  	struct clk *cpu_clk;
> >  	struct clk *inter_clk;
> >  	struct list_head list_head;
> > -	int intermediate_voltage;
> > +	int inter_voltage;
> >  	bool need_voltage_tracking;
> > -	int old_vproc;
> > -	struct mutex lock; /* avoid notify and policy race condition */
> > +	int old_voltage;
> > +	struct mutex lock;  /* avoid notify and policy race condition
> > */
> >  	struct notifier_block opp_nb;
> >  	int opp_cpu;
> >  	unsigned long opp_freq;
> >  };
> >  
> > -static LIST_HEAD(dvfs_info_list);
> > +static LIST_HEAD(drv_list);
> >  
> > -static struct mtk_cpu_dvfs_info *mtk_cpu_dvfs_info_lookup(int cpu)
> > +static struct mtk_cpufreq_drv *mtk_cpufreq_drv_lookup(int cpu)
> >  {
> > -	struct mtk_cpu_dvfs_info *info;
> > +	struct mtk_cpufreq_drv *drv;
> >  
> > -	list_for_each_entry(info, &dvfs_info_list, list_head) {
> > -		if (cpumask_test_cpu(cpu, &info->cpus))
> > -			return info;
> > +	list_for_each_entry(drv, &drv_list, list_head) {
> > +		if (cpumask_test_cpu(cpu, &drv->cpus))
> > +			return drv;>  	}
> >  
> >  	return NULL;
> >  }
> >  
> > -static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info
> > *info,
> > -					int new_vproc)
> > +static int mtk_cpufreq_voltage_tracking(struct mtk_cpufreq_drv
> > *drv,
> > +					int new_voltage)
> >  {
> > -	struct regulator *proc_reg = info->proc_reg;
> > -	struct regulator *sram_reg = info->sram_reg;
> > -	int old_vproc, old_vsram, new_vsram, vsram, vproc, ret;
> > -
> > -	old_vproc = regulator_get_voltage(proc_reg);
> > -	if (old_vproc < 0) {
> > -		pr_err("%s: invalid Vproc value: %d\n", __func__,
> > old_vproc);
> > -		return old_vproc;
> > +	struct regulator *proc_reg = drv->proc_reg;
> > +	struct regulator *sram_reg = drv->sram_reg;
> > +	int old_voltage, old_vsram, new_vsram, vsram, voltage, ret;
> > +
> > +	old_voltage = regulator_get_voltage(proc_reg);
> > +	if (old_voltage < 0) {
> > +		pr_err("%s: invalid vproc value: %d\n", __func__,
> > old_voltage);
> > +		return old_voltage;
> 
> 
> Several different changes in one commit. Please read the document
> "Submitting patches".
> 
> (...)

Sorry for my ignorance.
I will split the changes and send one change in one commit.

> 
> > -MODULE_AUTHOR("Pi-Cheng Chen <pi-cheng.chen@linaro.org>");
> > +MODULE_AUTHOR("Jia-Wei Chang <jia-wei.chang@mediatek.com>");
> 
> Ekhm, why? He was not the author?

This is my mistake.
I will keep it as before and add myself as a new author.

> 
> Best regards,
> Krzysztof

