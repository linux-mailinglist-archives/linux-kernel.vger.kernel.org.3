Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD3C4EC8B8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348385AbiC3PuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344628AbiC3PuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:50:00 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA07920E942;
        Wed, 30 Mar 2022 08:48:10 -0700 (PDT)
X-UUID: 3b656cbffa5f4f99900f5d676e1ba9e7-20220330
X-UUID: 3b656cbffa5f4f99900f5d676e1ba9e7-20220330
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1049488280; Wed, 30 Mar 2022 23:48:03 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 30 Mar 2022 23:48:02 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Mar 2022 23:48:01 +0800
Message-ID: <734fbf254c64668856e987aafe9d7dfd3ec86941.camel@mediatek.com>
Subject: Re: [v7 2/4] ASoC: mediatek: mt8192: refactor for I2S3 DAI link of
 speaker
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "=?ISO-8859-1?Q?N=EDcolas?= F. R. A. Prado" <nfraprado@collabora.com>,
        <robh+dt@kernel.org>, <tzungbi@google.com>,
        <angelogioacchino.delregno@collabora.com>, <aaronyu@google.com>,
        <matthias.bgg@gmail.com>, <trevor.wu@mediatek.com>,
        <linmq006@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Date:   Wed, 30 Mar 2022 23:48:01 +0800
In-Reply-To: <YkRoC30JLDMeVi1B@sirena.org.uk>
References: <20220324064511.10665-1-jiaxin.yu@mediatek.com>
         <20220324064511.10665-3-jiaxin.yu@mediatek.com>
         <20220329223002.uo7kiemopkh7ak4x@notapiano>
         <dee3fbb7c9f0c3e1f11143db1d6fc4381cab827f.camel@mediatek.com>
         <YkRNSoBKFvYYyZLu@sirena.org.uk>
         <61e9fb59448837cfc8e3ec862b711294bcb68872.camel@mediatek.com>
         <YkRoC30JLDMeVi1B@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-03-30 at 15:24 +0100, Mark Brown wrote:
> On Wed, Mar 30, 2022 at 10:06:24PM +0800, Jiaxin Yu wrote:
> > On Wed, 2022-03-30 at 13:30 +0100, Mark Brown wrote:
> > > Making a previously optional property required means that systems
> > > that
> > > previously worked may stop working unless they update their DT,
> > > DTs
> > > may
> > > be distributed separately to the kernel and perhaps even baked
> > > into
> > > firmware or similar.
> > Thank you for your detailed answer. I should keep the driver's
> > behavior
> > consistent with the description of dt-bindings. The "mediatek,hdmi-
> > codec" needs to be set as the required property. Is my
> > understanding
> > right?
> 
> The binding document and code should match so if one is changed the
> other needs to be changed too.
> 
> In theory we should never change a previously optional property to
> required which would mean that the code should be updated to reflect
> the
> binding document, however sometimes the DT isn't actually used as a
> stable intereface by anything for a given property or device type so
> we
> can get away with changing things.

"however sometimes the DT isn't actually used as a stable intereface by
anything for a given property or device type so we can get away with
changing things."

Sorry, I don't understand the real idea of this description. Does it
mean that dt-bindings in this series don't need to be updated, but the
driver?

