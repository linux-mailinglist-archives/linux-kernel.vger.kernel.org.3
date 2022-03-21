Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FDC4E2312
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343644AbiCUJPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbiCUJPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:15:43 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC1531DFD;
        Mon, 21 Mar 2022 02:14:13 -0700 (PDT)
X-UUID: e030b7e5dcad4d9286f6479676f04775-20220321
X-UUID: e030b7e5dcad4d9286f6479676f04775-20220321
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 524223218; Mon, 21 Mar 2022 17:14:10 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Mar 2022 17:14:09 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Mar 2022 17:14:08 +0800
Message-ID: <17e6e8895ebc1113911481c7e097b394005db123.camel@mediatek.com>
Subject: Re: [v5 3/4] ASoC: mediatek: mt8192: refactor for I2S8/I2S9 DAI
 links of headset
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
CC:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linmq006@gmail.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-mediatek@lists.infradead.org>, <trevor.wu@mediatek.com>,
        <matthias.bgg@gmail.com>, <aaronyu@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <angelogioacchino.delregno@collabora.com>
Date:   Mon, 21 Mar 2022 17:14:08 +0800
In-Reply-To: <Yjf4KjXpVJaNnvb8@google.com>
References: <20220319114111.11496-1-jiaxin.yu@mediatek.com>
         <20220319114111.11496-4-jiaxin.yu@mediatek.com>
         <Yjf4KjXpVJaNnvb8@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-03-21 at 11:59 +0800, Tzung-Bi Shih wrote:
> On Sat, Mar 19, 2022 at 07:41:10PM +0800, Jiaxin Yu wrote:
> > @@ -1145,6 +1140,13 @@ static int mt8192_mt6359_dev_probe(struct
> > platform_device *pdev)
> >  		goto err_speaker_codec;
> >  	}
> >  
> > +	headset_codec = of_get_child_by_name(pdev->dev.of_node,
> > "mediatek,headset-codec");
> > +	if (!headset_codec) {
> > +		ret = -EINVAL;
> > +		dev_err_probe(&pdev->dev, ret, "Property
> > 'headset_codec' missing or invalid\n");
> > +		goto err_headset_codec;
> > +	}
> 
> (to be neat) Does it have any reason to prevent from using
> of_parse_phandle()
> but of_get_child_by_name()?

Hi Tzung-Bi,

"mediatek,headset-codec" is a child node of pdev->dev.of_node, so I use
of_get_child_by_name() to get and   pass it to
snd_soc_of_get_dai_link_codecs().

Jiaxin.Yu
Thanks

