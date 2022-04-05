Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE494F4E42
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1588458AbiDFAQE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Apr 2022 20:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455406AbiDEP77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:59:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1565D49241
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:15:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nbktf-0008C6-St; Tue, 05 Apr 2022 17:15:07 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nbktg-001FZW-En; Tue, 05 Apr 2022 17:15:07 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nbkte-0007xb-A6; Tue, 05 Apr 2022 17:15:06 +0200
Message-ID: <f90d23f8c781d75bd0d171e1ab4e99c1d217d1ff.camel@pengutronix.de>
Subject: Re: [PATCH 6/8] power: reset: at91-reset: add reset_controller_dev
 support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Claudiu.Beznea@microchip.com, robh+dt@kernel.org,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        sre@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Date:   Tue, 05 Apr 2022 17:15:06 +0200
In-Reply-To: <9683a951-160a-b4e4-9494-c2e6ee51582e@microchip.com>
References: <20220405112724.2760905-1-claudiu.beznea@microchip.com>
         <20220405112724.2760905-7-claudiu.beznea@microchip.com>
         <0ff9a7cd2e6261a0de32db3bf16901e3737efef8.camel@pengutronix.de>
         <9683a951-160a-b4e4-9494-c2e6ee51582e@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudio,

On Di, 2022-04-05 at 14:47 +0000, Claudiu.Beznea@microchip.com wrote:
> Hi, Philipp,
> 
> On 05.04.2022 14:47, Philipp Zabel wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> > 
> > Hi Claudiu,
> > 
> > On Di, 2022-04-05 at 14:27 +0300, Claudiu Beznea wrote:
> > > SAMA7G5 reset controller has 5 extra lines that goes to different
> > > devices
> > > (3 lines to USB PHYs, 1 line to DDR controller, one line DDR PHY
> > > controller). These reset lines could be requested by different
> > > controller
> > > drivers (e.g. USB PHY driver) and these controllers' drivers
> > > could
> > > assert/deassert these lines when necessary. Thus add support for
> > > reset_controller_dev which brings this functionality.
> > > 
> > > Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> > > ---
> > >  drivers/power/reset/at91-reset.c | 92
> > > ++++++++++++++++++++++++++++++--
> > >  1 file changed, 88 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/power/reset/at91-reset.c
> > > b/drivers/power/reset/at91-reset.c
> > > index 0d721e27f545..b04df54c15d2 100644
> > > --- a/drivers/power/reset/at91-reset.c
> > > +++ b/drivers/power/reset/at91-reset.c
> > > @@ -17,6 +17,7 @@
> > >  #include <linux/of_address.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/reboot.h>
> > > +#include <linux/reset-controller.h>
> > > 
> > >  #include <soc/at91/at91sam9_ddrsdr.h>
> > >  #include <soc/at91/at91sam9_sdramc.h>
> > > @@ -53,12 +54,16 @@ enum reset_type {
> > >  struct at91_reset {
> > >         void __iomem *rstc_base;
> > >         void __iomem *ramc_base[2];
> > > +       void __iomem *dev_base;
> > > +       struct reset_controller_dev rcdev;
> > >         struct clk *sclk;
> > >         struct notifier_block nb;
> > >         u32 args;
> > >         u32 ramc_lpr;
> > >  };
> > > 
> > > +#define to_at91_reset(r)       container_of(r, struct
> > > at91_reset, rcdev)
> > > +
> > >  struct at91_reset_data {
> > >         u32 reset_args;
> > >         u32 n_device_reset;
> > > @@ -191,6 +196,79 @@ static const struct of_device_id
> > > at91_reset_of_match[] = {
> > >  };
> > >  MODULE_DEVICE_TABLE(of, at91_reset_of_match);
> > > 
> > > +static int at91_reset_update(struct reset_controller_dev *rcdev,
> > > +                            unsigned long id, bool assert)
> > > +{
> > > +       struct at91_reset *reset = to_at91_reset(rcdev);
> > > +       u32 val;
> > > +
> > > +       val = readl_relaxed(reset->dev_base);
> > > +       if (assert)
> > > +               val |= BIT(id);
> > > +       else
> > > +               val &= ~BIT(id);
> > > +       writel_relaxed(val, reset->dev_base);
> > 
> > This read-modify-update should be protected by a spinlock.
> > 
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int at91_reset_assert(struct reset_controller_dev *rcdev,
> > > +                            unsigned long id)
> > > +{
> > > +       return at91_reset_update(rcdev, id, true);
> > > +}
> > > +
> > > +static int at91_reset_deassert(struct reset_controller_dev
> > > *rcdev,
> > > +                              unsigned long id)
> > > +{
> > > +       return at91_reset_update(rcdev, id, false);
> > > +}
> > > +
> > > +static int at91_reset_dev_status(struct reset_controller_dev
> > > *rcdev,
> > > +                                unsigned long id)
> > > +{
> > > +       struct at91_reset *reset = to_at91_reset(rcdev);
> > > +       u32 val;
> > > +
> > > +       val = readl_relaxed(reset->dev_base);
> > > +
> > > +       return !!(val & BIT(id));
> > > +}
> > > +
> > > +static const struct reset_control_ops at91_reset_ops = {
> > > +       .assert = at91_reset_assert,
> > > +       .deassert = at91_reset_deassert,
> > > +       .status = at91_reset_dev_status,
> > > +};
> > > +
> > > +static int at91_reset_of_xlate(struct reset_controller_dev
> > > *rcdev,
> > > +                              const struct of_phandle_args
> > > *reset_spec)
> > > +{
> > > +       return reset_spec->args[0];
> > > +}
> > 
> > For 1:1 mappings there is no need for a custom of_xlate handler.
> > Just
> > leave of_xlate and of_reset_n_cells empty.
> 
> I've double checked that. This would work if reset ids are continuous
> from
> zero to rcdev.nr_resets. This the of_reset_simple_xlate:
> 
> static int of_reset_simple_xlate(struct reset_controller_dev *rcdev,
>                                  const struct of_phandle_args
> *reset_spec)
> {
>         if (reset_spec->args[0] >= rcdev->nr_resets)
>                 return -EINVAL;
>         return reset_spec->args[0];
> }
> 
> But in this driver's case we have 3 ids: 4, 5, 6. That is the reason
> I had this simple xlate function.

I see. In that case I'd say keep the custom of_xlate but let it return
-EINVAL if the args[0] value is not 4, 5, or 6.

Or you could set nr_resets to 7, but unless there are more resets at
the lower bits, that wouldn't necessarily be better.

regards
Philipp
