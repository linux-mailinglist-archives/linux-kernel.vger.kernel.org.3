Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356F948E2D3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 04:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238987AbiANDGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 22:06:42 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:33416 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236150AbiANDGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 22:06:41 -0500
X-UUID: 775fc08edc90494a9341dded806c18e1-20220114
X-UUID: 775fc08edc90494a9341dded806c18e1-20220114
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1888334197; Fri, 14 Jan 2022 11:06:39 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 14 Jan 2022 11:06:37 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 14 Jan 2022 11:06:36 +0800
Message-ID: <52901ebe0db555f8e58dc0d59cfd703c5a0fc2de.camel@mediatek.com>
Subject: Re: [PATCH v2 3/3] mmc: mediatek: add support for SDIO eint irq
From:   Axe Yang <axe.yang@mediatek.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Yoshihiro Shimoda" <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "Lucas Stach" <dev@lynxeye.de>, Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 14 Jan 2022 11:06:36 +0800
In-Reply-To: <YeADWXPGPW253ssR@smile.fi.intel.com>
References: <20220111014046.5864-1-axe.yang@mediatek.com>
         <20220111014046.5864-4-axe.yang@mediatek.com>
         <Yd1uJ+dX2CTEJfYY@smile.fi.intel.com>
         <83670f12a4eda1d8aecde3c0bf225642106d1267.camel@mediatek.com>
         <YeADWXPGPW253ssR@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-01-13 at 12:47 +0200, Andy Shevchenko wrote:
> On Thu, Jan 13, 2022 at 03:58:52PM +0800, Axe Yang wrote:
> 
> > But for the comment for 'dev_dbg', can you explain more about that?
> 
> Sure.
> 
> > On Tue, 2022-01-11 at 13:46 +0200, Andy Shevchenko wrote:
> > > On Tue, Jan 11, 2022 at 09:40:46AM +0800, Axe Yang wrote:
> 
> ..
> 
> > > > +		host->pins_eint = pinctrl_lookup_state(host-
> > > > >pinctrl,
> > > > "state_eint");
> > > > +		if (IS_ERR(host->pins_eint)) {
> > > > +			dev_dbg(&pdev->dev, "Cannot find
> > > > pinctrl
> > > > eint!\n");
> > > 
> > > In debug mode of pin control this will bring a duplicate message.
> > 
> > Can you explain more about this comment?
> > I don't understand what the 'duplicate message' refers for.
> 
> Have you chance to read the implementation of pinctrl_lookup_state()?

I have read pinctrl_lookup_state(), and if the 'duplicate message' you
were talking about is 'using pinctrl dummy state...':

https://elixir.bootlin.com/linux/latest/source/drivers/pinctrl/core.c#L1214
No, this message will not appear in debug mode if pins_eint not found
because pinctrl_dummy_state is always FALSE. MTK Soc do not need dummy
state support.

--
Best Regard,
Axe Yang

