Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E62D4FAF1A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 18:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243675AbiDJQzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 12:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240762AbiDJQzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 12:55:39 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A019E4B436;
        Sun, 10 Apr 2022 09:53:26 -0700 (PDT)
Received: from p508fdda7.dip0.t-ipconnect.de ([80.143.221.167] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1ndaoQ-0006ci-8W; Sun, 10 Apr 2022 18:53:18 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Frank Wunderlich <frank-w@public-files.de>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     Dan Johansen <strit@manjaro.org>,
        Frank Wunderlich <linux@fw-web.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Fix clocks for rk356x usb
Date:   Sun, 10 Apr 2022 18:53:17 +0200
Message-ID: <10062144.nUPlyArG6x@phil>
In-Reply-To: <CAMdYzYpK-RTf_8FVte2QLJawCKCjU6efgkRjsBj6quWGSSE6xA@mail.gmail.com>
References: <20220409075147.136187-1-linux@fw-web.de> <trinity-da7d86cc-5703-4657-858c-f241e5f0a6fd-1649505409042@3c-app-gmx-bap35> <CAMdYzYpK-RTf_8FVte2QLJawCKCjU6efgkRjsBj6quWGSSE6xA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 9. April 2022, 17:26:01 CEST schrieb Peter Geis:
> On Sat, Apr 9, 2022 at 7:56 AM Frank Wunderlich <frank-w@public-files.de> wrote:
> >
> > Hi,
> >
> > so to not break the binding and other boards the right Patch should be like this
> >
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -1691,17 +1691,17 @@ static int dwc3_probe(struct platform_device *pdev)
> >                  * Clocks are optional, but new DT platforms should support all
> >                  * clocks as required by the DT-binding.
> >                  */
> > -               dwc->bus_clk = devm_clk_get_optional(dev, "bus_early");
> > +               dwc->bus_clk = devm_clk_get_optional(dev, "bus_clk");
> >                 if (IS_ERR(dwc->bus_clk))
> >                         return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
> >                                              "could not get bus clock\n");
> >
> > -               dwc->ref_clk = devm_clk_get_optional(dev, "ref");
> > +               dwc->ref_clk = devm_clk_get_optional(dev, "ref_clk");
> >                 if (IS_ERR(dwc->ref_clk))
> >                         return dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
> >                                              "could not get ref clock\n");
> >
> > -               dwc->susp_clk = devm_clk_get_optional(dev, "suspend");
> > +               dwc->susp_clk = devm_clk_get_optional(dev, "suspend_clk");
> >                 if (IS_ERR(dwc->susp_clk))
> >                         return dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
> >                                              "could not get suspend clock\n");
> >
> > but this needs fixing dts using the new clock names
> >
> > this is a link to the series moving from bulk_clk to named clocks:
> >
> > https://patchwork.kernel.org/project/linux-usb/patch/20220127200636.1456175-3-sean.anderson@seco.com/
> >
> > regards Frank
> 
> I've submitted a fix for the backwards compatibility issue.
> https://patchwork.kernel.org/project/linux-rockchip/patch/20220409152116.3834354-1-pgwipeout@gmail.com/
> 
> This fix is standalone and necessary no matter which route we decide
> to go with this series (and the rk3328/rk3399 support as well).
> With this patch, dwc3 is functional on the rk356x as the series was
> submitted, so if we decide to fix everything all at once, that is a
> viable option.

Thanks for doing that fix.

As the usb-dt-series is actually following the rockchip,dwc3 binding,
and "just" the driver does ignore it, I've now applied the usb series
and hope for a resolution of the general problem :-)


Heiko




