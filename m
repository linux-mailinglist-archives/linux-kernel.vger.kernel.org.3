Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904185080F3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359514AbiDTGVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359509AbiDTGVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:21:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EB939694;
        Tue, 19 Apr 2022 23:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650435499; x=1681971499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s9LPH8JBvnn8wboJ6v237vLso4yR85Mqf/BUwurYhWU=;
  b=kSsGGCSPo7amXr01QJTjqfg5yocdbmT1ONdDzl+8g0uKyeD9+PcSgHxv
   iB6PExhpizC8bSMbbJbXTBy85wsU9im92QF6SkelJfvvgINbXiVurFOz7
   Le3FZQ/6+Jvzmr25LnRe51juPtY9X/X9/8VgiL/Sh8LCunl+ZeumeKJbJ
   HrMbYYd+XjbTzxEUfanxU8dRxMoO/QQItsZoztsMWHJvziqed7n0jNuCL
   NP5/aAs2jKSmCNvaUnw8NyUsRahKgG3XBP85Xot64XXj560kbz5OOezlQ
   I4/RYhFKzIX9pgQ3fWSCXTdbV1RbhI4qs+BAmrCnJ4YwODi9kq9DdqarL
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,274,1643698800"; 
   d="scan'208";a="161062216"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Apr 2022 23:18:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 19 Apr 2022 23:18:18 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 19 Apr 2022 23:18:18 -0700
Date:   Wed, 20 Apr 2022 08:21:34 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Michael Walle <michael@walle.cc>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] pinctrl: ocelot: add optional shared reset
Message-ID: <20220420062134.4cyux7sz5xyyg6mr@soft-dev3-1.localhost>
References: <20220419230324.3221779-1-michael@walle.cc>
 <20220419230324.3221779-3-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20220419230324.3221779-3-michael@walle.cc>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 04/20/2022 01:03, Michael Walle wrote:

Hi Michael,

> 
> On the LAN9668 there is a shared reset line which affects GPIO, SGPIO
> and the switch core. Add support for this shared reset line.

I have just a small comment below. Otherwise:
Tested-by: Horatiu Vultur <horatiu.vultur@microchip.com>

> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/pinctrl/pinctrl-ocelot.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
> index 1bdced67464b..b25eb04e4e1d 100644
> --- a/drivers/pinctrl/pinctrl-ocelot.c
> +++ b/drivers/pinctrl/pinctrl-ocelot.c
> @@ -19,6 +19,7 @@
>  #include <linux/pinctrl/pinconf-generic.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
> 
>  #include "core.h"
> @@ -1912,6 +1913,7 @@ static int ocelot_pinctrl_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         struct ocelot_pinctrl *info;
> +       struct reset_control *reset;
>         struct regmap *pincfg;
>         void __iomem *base;
>         int ret;
> @@ -1927,6 +1929,13 @@ static int ocelot_pinctrl_probe(struct platform_device *pdev)
> 
>         info->desc = (struct pinctrl_desc *)device_get_match_data(dev);
> 
> +       reset = devm_reset_control_get_optional_shared(dev, "switch");
> +       if (IS_ERR(reset)) {
> +               dev_err(dev, "Failed to get reset\n");
> +               return PTR_ERR(reset);

Can you use dev_err_probe here?

> +       }
> +       reset_control_reset(reset);
> +
>         base = devm_ioremap_resource(dev,
>                         platform_get_resource(pdev, IORESOURCE_MEM, 0));
>         if (IS_ERR(base))
> --
> 2.30.2
> 

-- 
/Horatiu
