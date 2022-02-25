Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158514C4132
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 10:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238979AbiBYJWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 04:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiBYJWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:22:20 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8111CB17;
        Fri, 25 Feb 2022 01:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645780907; x=1677316907;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=89kyyoJndWkPE14LCwoliaBF7EKo8CRJ7OCVP+vfOMA=;
  b=SBEcXjjOsLFjQtNzx2rIDnrtRu/AFbJZZBOnDUxHdxigKr1QVsea9OMu
   YexVm9XtEcYR9q0lVLIkKMSK4CI5vhBNcfe7o4UguHLmWPeGAxSZRGVAn
   hk69kwtRnbXfUUxe6pFCGVkvQGbUoP+R1yJ5Ke3g97neQ8rAeH/42i8ow
   8l9bt2mzmW+QLN9radks2NvlqAe0dAT3BCZOW4P2NYt7Ps/N234WuopkZ
   n8C9eUy9bbkPcDh24ZbnBx7yVl7hg7fQ18Kpe0mm5l+N2C1Sh5CJRk+6f
   AaBnkDBwAZdfzIGy2mBKJjLSEghncNKYukX/flzO0y4A8l2tybxlCzmn7
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,136,1643698800"; 
   d="scan'208";a="147261782"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Feb 2022 02:21:45 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 25 Feb 2022 02:21:43 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 25 Feb 2022 02:21:43 -0700
Date:   Fri, 25 Feb 2022 10:24:27 +0100
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Michael Walle <michael@walle.cc>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        <UNGLinuxDriver@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Colin Foster <colin.foster@in-advantage.com>
Subject: Re: [PATCH v1 5/5] pinctrl: microchip-sgpio: wait until output is
 actually set
Message-ID: <20220225092427.jjilv3qo52crsmuw@soft-dev3-1.localhost>
References: <20220224161021.2197263-1-michael@walle.cc>
 <20220224161021.2197263-6-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20220224161021.2197263-6-michael@walle.cc>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 02/24/2022 17:10, Michael Walle wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe

Hi Michael,

> 
> Right now, when a gpio value is set, the actual hardware pin gets set
> asynchronously. When linux write the output register, it takes some time
> until it is actually propagated to the output shift registers. If that
> output port is connected to an I2C mux for example, the linux driver
> assumes the I2C bus is already switched although it is not.
> 
> Fortunately, there is a single shot mode with a feedback: you can
> trigger the single shot and the hardware will clear that bit once it has
> finished the clocking and strobed the load signal of the shift
> registers. This can take a considerable amount of time though.
> Measuremens have shown that it takes up to a whole burst cycle gap which
> is about 50ms on the largest setting. Therefore, we have to mark the
> output bank as sleepable. To avoid unnecessary waiting, just trigger the
> single shot if the value was actually changed.

I have tested this patch series on our lan9668 board and it worked
fine. Thanks!

I just have few questions:
1. What about other boards/chips that have this sgpio, do they have also
   the same issue? Because from what I recall on sparx5 they don't have
   this issue. I have seen it only on lan9668.
2. I remember that I have tried to fix this issue like this [1], but
   unfortunetly that was never accepted. Is this something that is worth
   at looking at?

[1] https://patchwork.ozlabs.org/project/linux-i2c/patch/20211103091839.1665672-3-horatiu.vultur@microchip.com/

> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/pinctrl/pinctrl-microchip-sgpio.c | 58 ++++++++++++++++++++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-microchip-sgpio.c b/drivers/pinctrl/pinctrl-microchip-sgpio.c
> index 3f3b8c482f3a..768b69929c99 100644
> --- a/drivers/pinctrl/pinctrl-microchip-sgpio.c
> +++ b/drivers/pinctrl/pinctrl-microchip-sgpio.c
> @@ -69,6 +69,7 @@ struct sgpio_properties {
>  #define SGPIO_OCELOT_BIT_SOURCE  GENMASK(23, 12)
> 
>  #define SGPIO_SPARX5_AUTO_REPEAT BIT(6)
> +#define SGPIO_SPARX5_SINGLE_SHOT BIT(7)
>  #define SGPIO_SPARX5_PORT_WIDTH  GENMASK(4, 3)
>  #define SGPIO_SPARX5_CLK_FREQ    GENMASK(19, 8)
>  #define SGPIO_SPARX5_BIT_SOURCE  GENMASK(23, 12)
> @@ -118,6 +119,8 @@ struct sgpio_priv {
>         struct regmap *regs;
>         const struct sgpio_properties *properties;
>         spinlock_t lock;
> +       /* protects the config register and single shot mode */
> +       struct mutex poll_lock;
>  };
> 
>  struct sgpio_port_addr {
> @@ -225,12 +228,54 @@ static inline void sgpio_configure_clock(struct sgpio_priv *priv, u32 clkfrq)
>         sgpio_clrsetbits(priv, REG_SIO_CLOCK, 0, clr, set);
>  }
> 
> +static int sgpio_single_shot(struct sgpio_priv *priv)
> +{
> +       u32 addr = sgpio_get_addr(priv, REG_SIO_CONFIG, 0);
> +       int ret, ret2;
> +       u32 ctrl;
> +
> +       /* Only supported on SparX-5 for now. */
> +       if (priv->properties->arch != SGPIO_ARCH_SPARX5)
> +               return 0;
> +
> +       /*
> +        * Trigger immediate burst. This only works when auto repeat is turned
> +        * off. Otherwise, the single shot bit will never be cleared by the
> +        * hardware. Measurements showed that an update might take as long as
> +        * the burst gap. On a LAN9668 this is about 50ms for the largest
> +        * setting.
> +        * After the manual burst, reenable the auto repeat mode again.
> +        */
> +       mutex_lock(&priv->poll_lock);
> +       ret = regmap_update_bits(priv->regs, addr,
> +                                SGPIO_SPARX5_SINGLE_SHOT | SGPIO_SPARX5_AUTO_REPEAT,
> +                                SGPIO_SPARX5_SINGLE_SHOT);
> +       if (ret)
> +               goto out;
> +
> +       ret = regmap_read_poll_timeout(priv->regs, addr, ctrl,
> +                                      !(ctrl & SGPIO_SPARX5_SINGLE_SHOT),
> +                                      100, 60000);
> +
> +       /* reenable auto repeat mode even if there was an error */
> +       ret2 = regmap_update_bits(priv->regs, addr,
> +                                 SGPIO_SPARX5_AUTO_REPEAT,
> +                                 SGPIO_SPARX5_AUTO_REPEAT);
> +out:
> +       mutex_unlock(&priv->poll_lock);
> +
> +       return ret ?: ret2;
> +}
> +
>  static int sgpio_output_set(struct sgpio_priv *priv,
>                             struct sgpio_port_addr *addr,
>                             int value)
>  {
>         unsigned int bit = SGPIO_SRC_BITS * addr->bit;
> +       u32 reg = sgpio_get_addr(priv, REG_PORT_CONFIG, addr->port);
> +       bool changed;
>         u32 clr, set;
> +       int ret;
> 
>         switch (priv->properties->arch) {
>         case SGPIO_ARCH_LUTON:
> @@ -249,7 +294,16 @@ static int sgpio_output_set(struct sgpio_priv *priv,
>                 return -EINVAL;
>         }
> 
> -       sgpio_clrsetbits(priv, REG_PORT_CONFIG, addr->port, clr, set);
> +       ret = regmap_update_bits_check(priv->regs, reg, clr | set, set,
> +                                      &changed);
> +       if (ret)
> +               return ret;
> +
> +       if (changed) {
> +               ret = sgpio_single_shot(priv);
> +               if (ret)
> +                       return ret;
> +       }
> 
>         return 0;
>  }
> @@ -788,6 +842,7 @@ static int microchip_sgpio_register_bank(struct device *dev,
>         gc->of_gpio_n_cells     = 3;
>         gc->base                = -1;
>         gc->ngpio               = ngpios;
> +       gc->can_sleep           = !bank->is_input;
> 
>         if (bank->is_input && priv->properties->flags & SGPIO_FLAGS_HAS_IRQ) {
>                 int irq = fwnode_irq_get(fwnode, 0);
> @@ -848,6 +903,7 @@ static int microchip_sgpio_probe(struct platform_device *pdev)
> 
>         priv->dev = dev;
>         spin_lock_init(&priv->lock);
> +       mutex_init(&priv->poll_lock);
> 
>         reset = devm_reset_control_get_optional_shared(&pdev->dev, "switch");
>         if (IS_ERR(reset))
> --
> 2.30.2
> 

-- 
/Horatiu
