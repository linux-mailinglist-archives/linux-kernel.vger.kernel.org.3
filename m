Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985EF4F5F99
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbiDFNJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbiDFNHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:07:50 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CCD4DF8AA;
        Wed,  6 Apr 2022 02:42:07 -0700 (PDT)
X-UUID: f38cdd16a5934c02bb76974fe8781fa9-20220406
X-UUID: f38cdd16a5934c02bb76974fe8781fa9-20220406
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 475865710; Wed, 06 Apr 2022 17:41:37 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 6 Apr 2022 17:41:36 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 6 Apr 2022 17:41:34 +0800
Message-ID: <174a42437212ed26ecc08d1a35d20717d0346158.camel@mediatek.com>
Subject: Re: [PATCH v9 2/3] mmc: core: Add support for SDIO wakeup interrupt
From:   Axe Yang <axe.yang@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Date:   Wed, 6 Apr 2022 17:41:34 +0800
In-Reply-To: <CAPDyKFqzNJxt8RhQ5ABLqqkVaJmRPDFu=QuSUvAr-eW9SK4fSw@mail.gmail.com>
References: <20220329032913.8750-1-axe.yang@mediatek.com>
         <20220329032913.8750-3-axe.yang@mediatek.com>
         <CAPDyKFqzNJxt8RhQ5ABLqqkVaJmRPDFu=QuSUvAr-eW9SK4fSw@mail.gmail.com>
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

On Fri, 2022-04-01 at 14:42 +0200, Ulf Hansson wrote:
> On Tue, 29 Mar 2022 at 05:29, Axe Yang <axe.yang@mediatek.com> wrote:
> > 
> > If wakeup-source flag is set in host dts node, parse EAI
> > information
> > from SDIO CCCR interrupt externsion segment for in-band wakeup. If
> > async interrupt is supported by SDIO card then enable it and set
> > enable_async_irq flag in sdio_cccr structure to 1. The parse flow
> > is
> > implemented in sdio_read_cccr().
> > 
> > Acked-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> > ---
> >  drivers/mmc/core/sdio.c  | 17 +++++++++++++++++
> >  include/linux/mmc/card.h |  8 +++++++-
> >  include/linux/mmc/sdio.h |  5 +++++
> >  3 files changed, 29 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> > index 25799accf8a0..4898c5e9a299 100644
> > --- a/drivers/mmc/core/sdio.c
> > +++ b/drivers/mmc/core/sdio.c
> > @@ -226,6 +226,23 @@ static int sdio_read_cccr(struct mmc_card
> > *card, u32 ocr)
> >                                 card->sw_caps.sd3_drv_type |=
> > SD_DRIVER_TYPE_C;
> >                         if (data & SDIO_DRIVE_SDTD)
> >                                 card->sw_caps.sd3_drv_type |=
> > SD_DRIVER_TYPE_D;
> > +
> > +                       if (card->host->pm_caps &
> > MMC_PM_WAKE_SDIO_IRQ) {
> 
> After a second thought, I think we can just skip this check. The
> MMC_PM_WAKE_SDIO_IRQ indicates that the host supports SDIO IRQs as
> *system wakeups*.
> 
> But, in fact, I think we want this feature to be enabled to allow
> waking up for runtime_suspend (RPM_SUSPENDED) too.
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
> > +                               }
> > +                       }
> >                 }
> 
> 
Will skip this check in next version. Thanks.

Regards,
Axe

