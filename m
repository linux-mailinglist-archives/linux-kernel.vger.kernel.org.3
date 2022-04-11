Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BC54FBB17
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242819AbiDKLkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbiDKLkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:40:17 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11504457BB;
        Mon, 11 Apr 2022 04:38:02 -0700 (PDT)
X-UUID: 015305930e034de79ebfd34af5134c87-20220411
X-UUID: 015305930e034de79ebfd34af5134c87-20220411
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 83393646; Mon, 11 Apr 2022 19:37:55 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 11 Apr 2022 19:37:54 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Apr 2022 19:37:54 +0800
Message-ID: <664e31f0449533b41cd50f9d2fc68ec79ca9dfa3.camel@mediatek.com>
Subject: Re: [PATCH V2 00/15] cpufreq: mediatek: Cleanup and support MT8183
 and MT8186
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Hsin-Yi Wang <hsinyi@google.com>,
        Kevin Hilman <khilman@baylibre.com>
CC:     <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tim Chang <jia-wei.chang@mediatek.com>,
        <roger.lu@mediatek.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 11 Apr 2022 19:37:54 +0800
In-Reply-To: <CACb=7PVu6Rt3giBW78LWtkM=9xV6JzZgFSKOmUNx_26O0Wvowg@mail.gmail.com>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
         <7h5ynj5lhc.fsf@baylibre.com>
         <CACb=7PVu6Rt3giBW78LWtkM=9xV6JzZgFSKOmUNx_26O0Wvowg@mail.gmail.com>
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

On Sat, 2022-04-09 at 09:05 +0800, Hsin-Yi Wang wrote:
> On Sat, Apr 9, 2022 at 5:11 AM Kevin Hilman <khilman@baylibre.com>
> wrote:
> > 
> > Rex-BC Chen <rex-bc.chen@mediatek.com> writes:
> > 
> > > Cpufreq is a DVFS driver used for power saving to scale the clock
> > > frequency
> > > and supply the voltage for CPUs. This series do some cleanup for
> > > MediaTek
> > > cpufreq drivers and add support for MediaTek SVS[2] and MediaTek
> > > CCI
> > > devfreq[3] which are supported in MT8183 and MT8186.
> > 
> > There's no upstream DT for MT8186 and there are no OPPs defined in
> > the
> > upstream DT for MT8183.
> > 
> > In order to test this on mainline, could you provide a patch for
> > MT8183
> > that adds OPPs to the DT so this can be tested with mainline?
> > 
> 
> The DT change used in the downstream kernel is from here:
> 
https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/patch/1616499241-4906-9-git-send-email-andrew-sh.cheng@mediatek.com/__;!!CTRNKA9wMg0ARbw!ykRlVJPl8TZWMCfnAzLnqhtn3iqXeHh8f6tMBWpneZuJPPmJTGEDIiEgv-R_Q4gVunnp$
>  
> Might need some update (eg. add the cci property in cpu) though.
> Rex, you can also include the 8183 DT change in the next version
> since
> most of the mt8183 dts are in the mainline.
> 
> Thanks
> 
> > Thanks,
> > 
> > Kevin

Hello Kevin and Hsinyi,

OK I will add dts part of cpufreq for MT8183 in next version.
And I think the cci part will be upstreamed in cci seriues.

BRs,
Rex

