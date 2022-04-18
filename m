Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30FD504A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 03:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbiDRBnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 21:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235670AbiDRBnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 21:43:37 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB2B1837F;
        Sun, 17 Apr 2022 18:40:58 -0700 (PDT)
X-UUID: f7ae32f4d54b4db788c3ca0e90ea4eee-20220418
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:d37a0a38-bdb6-4c99-9134-89e413489115,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.4,REQID:d37a0a38-bdb6-4c99-9134-89e413489115,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:faefae9,CLOUDID:535804f0-da02-41b4-b6df-58f4ccd36682,C
        OID:IGNORED,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:0,EDM:-3,File:ni
        l,QS:0,BEC:nil
X-UUID: f7ae32f4d54b4db788c3ca0e90ea4eee-20220418
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1585846989; Mon, 18 Apr 2022 09:40:53 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 18 Apr 2022 09:40:52 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 18 Apr 2022 09:40:51 +0800
Message-ID: <8eee483694bf93197b441eb7deab31c95f68288c.camel@mediatek.com>
Subject: Re: [PATCH V3 10/15] cpufreq: mediatek: Add counter to prevent
 infinite loop when tracking voltage
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hsin-Yi Wang <hsinyi@google.com>
CC:     <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tim Chang <jia-wei.chang@mediatek.com>,
        <roger.lu@mediatek.com>, Kevin Hilman <khilman@baylibre.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 18 Apr 2022 09:40:51 +0800
In-Reply-To: <cfde61f1-5581-23b8-bd5b-f2a1875ec4ae@collabora.com>
References: <20220415055916.28350-1-rex-bc.chen@mediatek.com>
         <20220415055916.28350-11-rex-bc.chen@mediatek.com>
         <CACb=7PXykpUgZ+QG93Bd-vWstq2V-k6G0zTg+D1q2WchJHPbig@mail.gmail.com>
         <cfde61f1-5581-23b8-bd5b-f2a1875ec4ae@collabora.com>
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
> Il 15/04/22 08:14, Hsin-Yi Wang ha scritto:
> > On Fri, Apr 15, 2022 at 1:59 PM Rex-BC Chen <
> > rex-bc.chen@mediatek.com> wrote:
> > > 
> > > To prevent infinite loop when tracking voltage, we calculate the
> > > maximum
> > > value for each platform data.
> > > We assume min voltage is 0 and tracking target voltage using
> > > min_volt_shift for each iteration.
> > > The retry_max is 3 times of expeted iteration count.
> > > 
> > > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> 
> I'm sorry Rex, but this commit has to be squashed with 09/15, as the
> logic is
> that each commit has to be acceptable, and 09/15 is not, without this
> fix.
> 
> Besides, as Hsin-Yi suggested, calculating this every time may hit
> performance,
> but at the same time I don't want to lose this explicit
> calculation...
> 

Hello Angelo,

I will squash thius patch into 9/15 and will use info->vtrack_max to
record the value in probe function.

Thanks!

BRs,
Rex

> > > ---
> > >   drivers/cpufreq/mediatek-cpufreq.c | 16 ++++++++++++++++
> > >   1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/drivers/cpufreq/mediatek-cpufreq.c
> > > b/drivers/cpufreq/mediatek-cpufreq.c
> > > index cc44a7a9427a..d4c00237e862 100644
> > > --- a/drivers/cpufreq/mediatek-cpufreq.c
> > > +++ b/drivers/cpufreq/mediatek-cpufreq.c
> > > @@ -86,6 +86,16 @@ static int mtk_cpufreq_voltage_tracking(struct
> > > mtk_cpu_dvfs_info *info,
> > >          struct regulator *proc_reg = info->proc_reg;
> > >          struct regulator *sram_reg = info->sram_reg;
> > >          int pre_vproc, pre_vsram, new_vsram, vsram, vproc, ret;
> > > +       int retry_max;
> > > +
> > > +       /*
> > > +        * We assume min voltage is 0 and tracking target voltage
> > > using
> > > +        * min_volt_shift for each iteration.
> > > +        * The retry_max is 3 times of expeted iteration count.
> > > +        */
> > > +       retry_max = 3 * DIV_ROUND_UP(max(info->soc_data-
> > > >sram_max_volt,
> > > +                                        info->soc_data-
> > > >proc_max_volt),
> > > +                                    info->soc_data-
> > > >min_volt_shift);
> > 
> > mtk_cpufreq_voltage_tracking() will be called very frequently.
> > retry_max is the same every time mtk_cpufreq_voltage_tracking() is
> > called. Is it better to calculate before and store in
> > mtk_cpu_dvfs_info?
> > 
> 
> ...so I agree with this solution: perhaps you can add a "vtrack_max"
> variable to
> mtk_cpu_dvfs_info as suggested, and fill in that one in function
> mtk_cpu_dvfs_info_init(), where we effectively initialize all-the-
> things.
> 
> Cheers,
> Angelo

