Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0E84FBAB8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345227AbiDKLUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbiDKLUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:20:46 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E6E427D6;
        Mon, 11 Apr 2022 04:18:32 -0700 (PDT)
X-UUID: db46d44347744253b0b066f3a07fb425-20220411
X-UUID: db46d44347744253b0b066f3a07fb425-20220411
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 311027754; Mon, 11 Apr 2022 19:18:26 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 Apr 2022 19:18:25 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Apr 2022 19:18:25 +0800
Message-ID: <371c9a96e80faa26719e00b694e45d176105b6dc.camel@mediatek.com>
Subject: Re: [PATCH V2 08/15] cpufreq: mediatek: Move voltage limits to
 platform data
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
Date:   Mon, 11 Apr 2022 19:18:25 +0800
In-Reply-To: <3dade32c-4b46-351a-b3f9-d1fec16b603c@collabora.com>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
         <20220408045908.21671-9-rex-bc.chen@mediatek.com>
         <3dade32c-4b46-351a-b3f9-d1fec16b603c@collabora.com>
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

On Fri, 2022-04-08 at 15:36 +0200, AngeloGioacchino Del Regno wrote:
> Il 08/04/22 06:59, Rex-BC Chen ha scritto:
> > From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > 
> > Voltages and shifts are defined as macros originally.
> > There are different requirements of these values for each MediaTek
> > SoCs.
> > Therefore, we add the platform data and move these values into it.
> > 
> > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > ---
> >   drivers/cpufreq/mediatek-cpufreq.c | 90 ++++++++++++++++++++-----
> > -----
> >   1 file changed, 61 insertions(+), 29 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/mediatek-cpufreq.c
> > b/drivers/cpufreq/mediatek-cpufreq.c
> > index 1369da62780a..0be5609ee82e 100644
> > --- a/drivers/cpufreq/mediatek-cpufreq.c
> > +++ b/drivers/cpufreq/mediatek-cpufreq.c
> 
> ..snip..
> 
> > @@ -625,20 +649,27 @@ static struct platform_driver
> > mtk_cpufreq_platdrv = {
> >   	.probe		= mtk_cpufreq_probe,
> >   };
> >   
> > +static const struct mtk_cpufreq_platform_data mtk_platform_data =
> > {
> 
> I would prefer if you name this after the oldest SoC that is
> supported in this
> driver, or after the IP version.
> 
> Example: if the oldest one is mt7622, then this should be
> mt7622_platform_data;
>           if newer SoCs have got a different cpu frequency control
> IP, then we
>           should have here something like
>           mtk_v1_platform_data, mtk_v1_3_platform_data.
> 
> Please note that I didn't check release dates, so my reference to
> mt7622 is
> purely casual.
> 
> Regards,
> Angelo

Hello Angelo,

Thanks for your review.
I will rename it as mt2701_platform_data.

BRs,
Rex

