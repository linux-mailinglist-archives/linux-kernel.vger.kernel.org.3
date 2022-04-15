Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B675502593
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 08:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350447AbiDOGbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 02:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236018AbiDOGbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 02:31:36 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA1E50456;
        Thu, 14 Apr 2022 23:29:08 -0700 (PDT)
X-UUID: b225d94715c9430390a03777fc3720d7-20220415
X-UUID: b225d94715c9430390a03777fc3720d7-20220415
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 113088385; Fri, 15 Apr 2022 14:29:05 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 15 Apr 2022 14:29:04 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 15 Apr
 2022 14:29:03 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 15 Apr 2022 14:29:03 +0800
Message-ID: <e1be95ddcdd01cf859e4d18bea95f8f55cd9ed1d.camel@mediatek.com>
Subject: Re: [PATCH V3 10/15] cpufreq: mediatek: Add counter to prevent
 infinite loop when tracking voltage
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Hsin-Yi Wang <hsinyi@google.com>
CC:     <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tim Chang <jia-wei.chang@mediatek.com>,
        <roger.lu@mediatek.com>, Kevin Hilman <khilman@baylibre.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 15 Apr 2022 14:29:03 +0800
In-Reply-To: <CACb=7PXykpUgZ+QG93Bd-vWstq2V-k6G0zTg+D1q2WchJHPbig@mail.gmail.com>
References: <20220415055916.28350-1-rex-bc.chen@mediatek.com>
         <20220415055916.28350-11-rex-bc.chen@mediatek.com>
         <CACb=7PXykpUgZ+QG93Bd-vWstq2V-k6G0zTg+D1q2WchJHPbig@mail.gmail.com>
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

On Fri, 2022-04-15 at 14:14 +0800, Hsin-Yi Wang wrote:
> On Fri, Apr 15, 2022 at 1:59 PM Rex-BC Chen <rex-bc.chen@mediatek.com
> > wrote:
> > 
> > To prevent infinite loop when tracking voltage, we calculate the
> > maximum
> > value for each platform data.
> > We assume min voltage is 0 and tracking target voltage using
> > min_volt_shift for each iteration.
> > The retry_max is 3 times of expeted iteration count.
> > 
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > ---
> >  drivers/cpufreq/mediatek-cpufreq.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/mediatek-cpufreq.c
> > b/drivers/cpufreq/mediatek-cpufreq.c
> > index cc44a7a9427a..d4c00237e862 100644
> > --- a/drivers/cpufreq/mediatek-cpufreq.c
> > +++ b/drivers/cpufreq/mediatek-cpufreq.c
> > @@ -86,6 +86,16 @@ static int mtk_cpufreq_voltage_tracking(struct
> > mtk_cpu_dvfs_info *info,
> >         struct regulator *proc_reg = info->proc_reg;
> >         struct regulator *sram_reg = info->sram_reg;
> >         int pre_vproc, pre_vsram, new_vsram, vsram, vproc, ret;
> > +       int retry_max;
> > +
> > +       /*
> > +        * We assume min voltage is 0 and tracking target voltage
> > using
> > +        * min_volt_shift for each iteration.
> > +        * The retry_max is 3 times of expeted iteration count.
> > +        */
> > +       retry_max = 3 * DIV_ROUND_UP(max(info->soc_data-
> > >sram_max_volt,
> > +                                        info->soc_data-
> > >proc_max_volt),
> > +                                    info->soc_data-
> > >min_volt_shift);
> 
> mtk_cpufreq_voltage_tracking() will be called very frequently.
> retry_max is the same every time mtk_cpufreq_voltage_tracking() is
> called. Is it better to calculate before and store in
> mtk_cpu_dvfs_info?
> 

Hello Hsin-Yi,

Thanks for your reviwew.
I will do this in next version.

BRs,
Rex

> > 
> >         pre_vproc = regulator_get_voltage(proc_reg);
> >         if (pre_vproc < 0) {
> > @@ -151,6 +161,12 @@ static int mtk_cpufreq_voltage_tracking(struct
> > mtk_cpu_dvfs_info *info,
> > 
> >                 pre_vproc = vproc;
> >                 pre_vsram = vsram;
> > +
> > +               if (--retry_max < 0) {
> > +                       dev_err(info->cpu_dev,
> > +                               "over loop count, failed to set
> > voltage\n");
> > +                       return -EINVAL;
> > +               }
> >         } while (vproc != new_vproc || vsram != new_vsram);
> > 
> >         return 0;
> > --
> > 2.18.0
> > 

