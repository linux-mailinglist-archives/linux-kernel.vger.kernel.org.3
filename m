Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB4E51461A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbiD2KAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 06:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357138AbiD2KAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 06:00:09 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02AF433BA;
        Fri, 29 Apr 2022 02:56:50 -0700 (PDT)
X-UUID: 4d656209bdc4489eb15392a127ed434f-20220429
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:b26a2fb7-58be-4091-9061-5c9a6135eae3,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.4,REQID:b26a2fb7-58be-4091-9061-5c9a6135eae3,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:faefae9,CLOUDID:29e2f5c6-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:IGNORED,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil,QS:0
        ,BEC:nil
X-UUID: 4d656209bdc4489eb15392a127ed434f-20220429
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 330748639; Fri, 29 Apr 2022 17:56:45 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 29 Apr 2022 17:56:44 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 Apr 2022 17:56:43 +0800
Message-ID: <2930dbe4b9e445e5d3d33a0c94fdd44d9eebae96.camel@mediatek.com>
Subject: Re: [v4 07/18] ASoC: mediatek: mt8186: support i2s in platform
 driver
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <robh+dt@kernel.org>, <angelogioacchino.delregno@collabora.com>,
        <aaronyu@google.com>, <matthias.bgg@gmail.com>,
        <trevor.wu@mediatek.com>, <tzungbi@google.com>,
        <julianbraha@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 29 Apr 2022 17:56:43 +0800
In-Reply-To: <YmqE+80xyBoIJvto@sirena.org.uk>
References: <20220428093355.16172-1-jiaxin.yu@mediatek.com>
         <20220428093355.16172-8-jiaxin.yu@mediatek.com>
         <YmqE+80xyBoIJvto@sirena.org.uk>
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

On Thu, 2022-04-28 at 13:13 +0100, Mark Brown wrote:
> On Thu, Apr 28, 2022 at 05:33:44PM +0800, Jiaxin Yu wrote:
> 
> > +/* clock source control */
> > +static const char * const mt8186_i2s_src_str[] = {
> > +	"Master", "Slave"
> > +};
> > +
> > +static const struct soc_enum mt8186_i2s_src_enum[] = {
> > +	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(mt8186_i2s_src_str),
> > +			    mt8186_i2s_src_str),
> > +};
> 
> Not clear why this is user visible?  Shouldn't the machine driver be
> setting this.  Also please use more modern provider/consumer
> terminology
> for the clocking.
> 
Sorry, here are the controls left by debug, I should remove them.
Yes, I should use provider/consumer terminology for the clocking, just
link the SND_SOC_DAIFMT_CBP_CFC.

> > +static int mt8186_i2s_hd_set(struct snd_kcontrol *kcontrol,
> > +			     struct snd_ctl_elem_value *ucontrol)
> > +{
> > +		return -EINVAL;
> > +	}
> > +
> > +	i2s_priv->low_jitter_en = hd_en;
> > +
> > +	return 0;
> > +}
> 
> Same issue as on the other patch with the events - like I said there
> mixer-test will find a bunch of these issues for you.
Yes, I remember it.
Next I will continue to use mixer-test to check all of the mixer
controls.


