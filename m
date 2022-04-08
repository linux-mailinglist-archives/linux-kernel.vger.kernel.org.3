Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83DB4F8C4F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbiDHCzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 22:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiDHCzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 22:55:19 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8C3195D8D;
        Thu,  7 Apr 2022 19:53:16 -0700 (PDT)
X-UUID: f29ab3910e2a400e81809af9bedac63c-20220408
X-UUID: f29ab3910e2a400e81809af9bedac63c-20220408
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1125716402; Fri, 08 Apr 2022 10:53:13 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 8 Apr 2022 10:53:11 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Apr 2022 10:53:11 +0800
Message-ID: <79b785cada5bdf65673a272255ba22bdb4b55df9.camel@mediatek.com>
Subject: Re: [PATCH 2/3] devfreq: mediatek: add mt8183 cci devfreq driver
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     Kevin Hilman <khilman@kernel.org>,
        Hsin-Yi Wang <hsinyi@google.com>,
        "Tim Chang" <jia-wei.chang@mediatek.com>
CC:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fan.chen@mediatek.com>,
        <louis.yu@mediatek.com>, <roger.lu@mediatek.com>,
        <Allen-yy.Lin@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
Date:   Fri, 8 Apr 2022 10:53:11 +0800
In-Reply-To: <7h7d808sti.fsf@baylibre.com>
References: <20220307122513.11822-1-jia-wei.chang@mediatek.com>
         <20220307122513.11822-3-jia-wei.chang@mediatek.com>
         <CACb=7PUSAF6ui2a7iMYrrXo=v0OaXhCfiF=dPzq4cfUXM3JbDg@mail.gmail.com>
         <7h7d808sti.fsf@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-04-07 at 14:52 -0700, Kevin Hilman wrote:
> Hsin-Yi Wang <hsinyi@google.com> writes:
> 
> > On Mon, Mar 7, 2022 at 8:32 PM Tim Chang <
> > jia-wei.chang@mediatek.com> wrote:
> > > 
> > > This adds a devfreq driver for the Cache Coherent Interconnect
> > > (CCI) of
> > > the Mediatek MT8183.
> > > 
> > > On mt8183 the cci is supplied by the same regulator as the little
> > > cores.
> > > The driver is notified when the regulator voltage changes (driven
> > > by
> > > cpufreq) and adjusts the cci frequency to the maximum possible
> > > value.
> > > 
> > > Add need_voltage_tracking variable to platforma data. if true, it
> > > indicates soc is required to realize the voltage tracking between
> > > voltage of sram and voltage of cci by software approach.
> > > otherwise, the
> > > voltage tracking is realized by hardware appraoch.
> > > 
> > > Add the notifier to cci so that it could react after svs driver
> > > changes
> > > opp table of cci.
> > > 
> > > Signed-off-by: Jia-Wei Chang <
> > > jia-wei.chang@mediatek.corp-partner.google.com>
> 
> [...]
> 
> > > +
> > > +       passive_data = devm_kzalloc(cci_dev, sizeof(struct
> > > devfreq_passive_data), GFP_KERNEL);
> > > +       if (!passive_data) {
> > > +               ret = -ENOMEM;
> > > +               goto out_remove_opp_table;
> > > +       }
> > > +
> > > +       passive_data->parent_type = CPUFREQ_PARENT_DEV;
> > 
> > It's better to add a note below commit message to state that this
> > series depends on
> > 
https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing__;!!CTRNKA9wMg0ARbw!3dQn_JiiD_cRiN-TmoNWXX7mD2cmF4M5elG4WabiS392Mg9S8wlsagK1o-n9beULMei4AAj9zsoPBElt9R4-UnAd1g$
> >  
> 
> Not only is this series dependent the previous series from Chanwoo,
> in
> also fails to compile if CONFIG_DEVFREQ_GOV_PASSIVE is not enabled,
> because CPUFREQ_PARENT_DEV defined inside of an #ifdef.
> 
> Please compile test this with and without CONFIG_DEVFREQ_GOV_PASSIVE
> enabled.
> 
> Kevin

Hi Kevin,

Thank you for review.
I will fix it in next verison.

BRs,
Johnson Wang


