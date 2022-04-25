Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D704A50DCD3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbiDYJjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241740AbiDYJi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:38:59 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9D5192A2;
        Mon, 25 Apr 2022 02:34:59 -0700 (PDT)
X-UUID: 9881bae1289a4abc94700e0d5a922da8-20220425
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:fcff05ab-eeec-4fb4-ab96-a704b6f8f539,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:bfb1daf0-da02-41b4-b6df-58f4ccd36682,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 9881bae1289a4abc94700e0d5a922da8-20220425
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 660831122; Mon, 25 Apr 2022 17:34:52 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 25 Apr 2022 17:34:51 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 25 Apr
 2022 17:34:50 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 Apr 2022 17:34:49 +0800
Message-ID: <64c690e8edf493ec0a4a14e0fdaad2d8e88e6da7.camel@mediatek.com>
Subject: Re: [PATCH V4 07/14] cpufreq: mediatek: Add .get function
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rafael@kernel.org>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <jia-wei.chang@mediatek.com>,
        <roger.lu@mediatek.com>, <hsinyi@google.com>,
        <khilman@baylibre.com>, <angelogioacchino.delregno@collabora.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 25 Apr 2022 17:34:49 +0800
In-Reply-To: <20220425053548.72w2jh2g6lpzgz6g@vireshk-i7>
References: <20220422075239.16437-1-rex-bc.chen@mediatek.com>
         <20220422075239.16437-8-rex-bc.chen@mediatek.com>
         <20220425053548.72w2jh2g6lpzgz6g@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-04-25 at 11:05 +0530, Viresh Kumar wrote:
> On 22-04-22, 15:52, Rex-BC Chen wrote:
> > From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > 
> > We want to get opp frequency via opp table. Therefore, we add the
> > function
> > "mtk_cpufreq_get()" to do this.
> > 
> > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > ---
> >  drivers/cpufreq/mediatek-cpufreq.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/mediatek-cpufreq.c
> > b/drivers/cpufreq/mediatek-cpufreq.c
> > index e070a2619bcb..0b2ca0c8eddc 100644
> > --- a/drivers/cpufreq/mediatek-cpufreq.c
> > +++ b/drivers/cpufreq/mediatek-cpufreq.c
> > @@ -71,6 +71,15 @@ static struct mtk_cpu_dvfs_info
> > *mtk_cpu_dvfs_info_lookup(int cpu)
> >  	return NULL;
> >  }
> >  
> > +static unsigned int mtk_cpufreq_get(unsigned int cpu)
> > +{
> > +	struct mtk_cpu_dvfs_info *info;
> > +
> > +	info = mtk_cpu_dvfs_info_lookup(cpu);
> > +
> > +	return !info ? 0 : (info->opp_freq / 1000);
> > +}
> > +
> >  static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info
> > *info,
> >  					int new_vproc)
> >  {
> > @@ -588,7 +597,7 @@ static struct cpufreq_driver mtk_cpufreq_driver
> > = {
> >  		 CPUFREQ_IS_COOLING_DEV,
> >  	.verify = cpufreq_generic_frequency_table_verify,
> >  	.target_index = mtk_cpufreq_set_target,
> > -	.get = cpufreq_generic_get,
> > +	.get = mtk_cpufreq_get,
> 
> The .get callback should read the real frequency from hardware
> instead of
> fetching a cached freq value.
> 

Hello Viresh,

We found that the pulses of cpu voltage could be observed when
frequency is fixed (scaling_max_freq == scaling_min_freq) if using
cpufreq_generic_get as '.get' callback in MT8186.
cpufreq framework will constantly (~ 1 sec) call 'update' if the policy
frequency is NOT equal to hardware frequency in
cpufreq_verify_current_freq.
The problem is that there might be a tiny difference between the policy
frequency and the hardware frequency even they are very close.
e.g. policy frequency is 500,000,000 Hz however, hardware frequency is
499,999,726 Hz for MT8186 opp15.

To prevent the voltage pulses, we currently use the software cached
values as you pointed out.
I wonder is it possible to add a tolerence for checking difference
between policy frequency and hardware frequency in cpufreq framework so
that we can use cpufreq_generic_get as callback without pulse issue.
Or any suggestion would be appreciated.

Thanks.

BRs,
Rex
> >  	.init = mtk_cpufreq_init,
> >  	.exit = mtk_cpufreq_exit,
> >  	.register_em = cpufreq_register_em_with_opp,
> > -- 
> > 2.18.0
> 
> 

