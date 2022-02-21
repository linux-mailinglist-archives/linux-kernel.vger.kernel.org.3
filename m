Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B73F4BD753
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 08:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346147AbiBUH3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:29:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiBUH3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:29:48 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D3C2E7;
        Sun, 20 Feb 2022 23:29:24 -0800 (PST)
X-UUID: 2e011d40a02843e2b7e6398bc6902036-20220221
X-UUID: 2e011d40a02843e2b7e6398bc6902036-20220221
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 499028823; Mon, 21 Feb 2022 15:29:22 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Feb 2022 15:29:21 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 21 Feb
 2022 15:29:21 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Feb 2022 15:29:20 +0800
Message-ID: <4be20cf9fd351c17414945a2fa199c490a0ff8d6.camel@mediatek.com>
Subject: Re: [PATCH v5 2/3] mmc: core: Add support for SDIO async interrupt
From:   Axe Yang <axe.yang@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        "Eric Biggers" <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        "Stephen Boyd" <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Mon, 21 Feb 2022 15:29:19 +0800
In-Reply-To: <CAPDyKFqd+H6F4+gBd4CEigaOTC5TtjtT75B3G0B6qexFi6XqKw@mail.gmail.com>
References: <20220121071942.11601-1-axe.yang@mediatek.com>
         <20220121071942.11601-3-axe.yang@mediatek.com>
         <CAPDyKFqd+H6F4+gBd4CEigaOTC5TtjtT75B3G0B6qexFi6XqKw@mail.gmail.com>
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

On Mon, 2022-02-14 at 16:34 +0100, Ulf Hansson wrote:
> On Fri, 21 Jan 2022 at 08:19, Axe Yang <axe.yang@mediatek.com> wrote:
> > 
> > If cap-sdio-async-irq flag is set in host dts node, parse EAI
> > information from SDIO CCCR interrupt externsion segment. If async
> > interrupt is supported by SDIO card then send command to card to
> > enable it and set enable_async_irq flag in sdio_cccr structure to
> > 1.
> > The parse flow is implemented in sdio_read_cccr().
> > 
> > Acked-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> > ---
> >  drivers/mmc/core/host.c  |  2 ++
> >  drivers/mmc/core/sdio.c  | 17 +++++++++++++++++
> >  include/linux/mmc/card.h |  3 ++-
> >  include/linux/mmc/host.h |  1 +
> >  include/linux/mmc/sdio.h |  5 +++++
> >  5 files changed, 27 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > index cf140f4ec864..a972241548b4 100644
> > --- a/drivers/mmc/core/host.c
> > +++ b/drivers/mmc/core/host.c
> > @@ -410,6 +410,8 @@ int mmc_of_parse(struct mmc_host *host)
> >         if (device_property_read_bool(dev, "no-mmc-hs400"))
> >                 host->caps2 &= ~(MMC_CAP2_HS400_1_8V |
> > MMC_CAP2_HS400_1_2V |
> >                                  MMC_CAP2_HS400_ES);
> > +       if (device_property_read_bool(dev, "cap-sdio-async-irq"))
> > +               host->caps2 |= MMC_CAP2_SDIO_ASYNC_IRQ;
> > 
> >         /* Must be after "non-removable" check */
> >         if (device_property_read_u32(dev, "fixed-emmc-driver-type", 
> > &drv_type) == 0) {
> > diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> > index 41164748723d..771fb5d18585 100644
> > --- a/drivers/mmc/core/sdio.c
> > +++ b/drivers/mmc/core/sdio.c
> > @@ -225,6 +225,23 @@ static int sdio_read_cccr(struct mmc_card
> > *card, u32 ocr)
> >                                 card->sw_caps.sd3_drv_type |=
> > SD_DRIVER_TYPE_C;
> >                         if (data & SDIO_DRIVE_SDTD)
> >                                 card->sw_caps.sd3_drv_type |=
> > SD_DRIVER_TYPE_D;
> > +
> > +                       if (card->host->caps2 &
> > MMC_CAP2_SDIO_ASYNC_IRQ) {
> 
> We can probably check host->pm_caps & MMC_PM_WAKE_SDIO_IRQ here,
> instead of MMC_CAP2_SDIO_ASYNC_IRQ.

Will update this part in next version.

> 
> > +                               ret = mmc_io_rw_direct(card, 0, 0,
> > SDIO_CCCR_INTERRUPT_EXT, 0,
> > +                                                      &data);
> > +                               if (ret)
> > +                                       goto out;
> > +
> > +                               if (data & SDIO_INTERRUPT_EXT_SAI)
> > {
> > +                                       data |=
> > SDIO_INTERRUPT_EXT_EAI;
> > +                                       ret =
> > mmc_io_rw_direct(card, 1, 0, SDIO_CCCR_INTERRUPT_EXT,
> > +                                                              data
> > , NULL);
> > +                                       if (ret)
> > +                                               goto out;
> > +
> > +                                       card->cccr.enable_async_irq 
> > = 1;
> 
> As you show in the next patch(3), this flag is useful to read for the
> host driver.
> 
> However, rather than accessing this flag directly in the host driver,
> can you please add a helper function that takes a struct mmc_card* as
> in-parameter instead?

OK. I will do that in next version.

> 
> > +                               }
> > +                       }
> >                 }
> > 
> >                 /* if no uhs mode ensure we check for high speed */
> > diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> > index 37f975875102..4df9182bc0e6 100644
> > --- a/include/linux/mmc/card.h
> > +++ b/include/linux/mmc/card.h
> > @@ -219,7 +219,8 @@ struct sdio_cccr {
> >                                 wide_bus:1,
> >                                 high_power:1,
> >                                 high_speed:1,
> > -                               disable_cd:1;
> > +                               disable_cd:1,
> > +                               enable_async_irq:1;
> >  };
> > 
> >  struct sdio_cis {
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index 7afb57cab00b..502a5418264c 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -402,6 +402,7 @@ struct mmc_host {
> >  #define MMC_CAP2_CRYPTO                0
> >  #endif
> >  #define MMC_CAP2_ALT_GPT_TEGRA (1 << 28)       /* Host with eMMC
> > that has GPT entry at a non-standard location */
> > +#define MMC_CAP2_SDIO_ASYNC_IRQ        (1 << 29)       /* SDIO
> > host supports asynchronous interrupt */
> > 
> >         int                     fixed_drv_type; /* fixed driver
> > type for non-removable media */
> > 
> > diff --git a/include/linux/mmc/sdio.h b/include/linux/mmc/sdio.h
> > index 2a05d1ac4f0e..1ef400f28642 100644
> > --- a/include/linux/mmc/sdio.h
> > +++ b/include/linux/mmc/sdio.h
> > @@ -159,6 +159,11 @@
> >  #define  SDIO_DTSx_SET_TYPE_A  (1 << SDIO_DRIVE_DTSx_SHIFT)
> >  #define  SDIO_DTSx_SET_TYPE_C  (2 << SDIO_DRIVE_DTSx_SHIFT)
> >  #define  SDIO_DTSx_SET_TYPE_D  (3 << SDIO_DRIVE_DTSx_SHIFT)
> > +
> > +#define SDIO_CCCR_INTERRUPT_EXT        0x16
> > +#define SDIO_INTERRUPT_EXT_SAI (1 << 0)
> > +#define SDIO_INTERRUPT_EXT_EAI (1 << 1)
> > +
> >  /*
> >   * Function Basic Registers (FBR)
> >   */
> 
Regards,
Axe Yang


