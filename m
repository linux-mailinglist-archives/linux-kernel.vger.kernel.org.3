Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63B35A7AA4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiHaJxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiHaJxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:53:47 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AF8D075A;
        Wed, 31 Aug 2022 02:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661939627; x=1693475627;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rO2di7Or7wgl0UxQbftUauaVDFyOQAmRE6hICb36rng=;
  b=mIWIfjbWx6EsZrqZ6prcE+nG/dG41AP9QKWjNWKv1BVngz7SHra/JlKX
   +JxJ4Th+cXXVZHfp8j0SIfqduEPRcA5FM3UhWlkfIqXLm6TSJkml2alvX
   jZi0Yb85zkpjnWoHR0j1VvJlAG9ydGYGH2oe3wdZDSY2CzafOyM/zW2wZ
   eL2yrT1O4B7/y414c8Sfph/ZfWSRsxZA+uwximaqZU748r6Jo4gyptpnS
   ui2tR8EP9vdYd1Zblixr98q5m5hyugL1gI2jjybPugpa3LSuoWy6587Gl
   g+IqqTWVoJQJFjOgj8HC1JWy5uYztD0hJ6YOPqaf3Qtnln7ntu7YBppRc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="381710284"
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="381710284"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 02:53:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="673284621"
Received: from adott-mobl1.ger.corp.intel.com ([10.252.43.127])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 02:53:41 -0700
Date:   Wed, 31 Aug 2022 12:53:39 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, andy.shevchenko@gmail.com,
        u.kleine-koenig@pengutronix.de, johan@kernel.org,
        wander@redhat.com, etremblay@distech-controls.com,
        macro@orcam.me.uk, geert+renesas@glider.be, jk@ozlabs.org,
        phil.edworthy@renesas.com, Lukas Wunner <lukas@wunner.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v1 tty-next 2/2] 8250: microchip: pci1xxxx: Add power
 management functions to pci1xxxx's  quad-uart driver.
In-Reply-To: <20220830180054.1998296-3-kumaravel.thiagarajan@microchip.com>
Message-ID: <8a47735-82d-809c-9b8c-a8d9d9a8d5c5@linux.intel.com>
References: <20220830180054.1998296-1-kumaravel.thiagarajan@microchip.com> <20220830180054.1998296-3-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2022, Kumaravel Thiagarajan wrote:

> pci1xxxx's quad-uart function has the capability to wake up the host from
> suspend state. Enable wakeup before entering into suspend and disable
> wakeup upon resume.
> 
> Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> ---
>  drivers/tty/serial/8250/8250_pci1xxxx.c | 122 ++++++++++++++++++++++++
>  1 file changed, 122 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
> index 56852ae0585e..38c2a6a9e5d5 100644
> --- a/drivers/tty/serial/8250/8250_pci1xxxx.c
> +++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
> @@ -70,6 +70,7 @@
>  
>  #define UART_PCI_CTRL_REG		0x80
>  #define UART_PCI_CTRL_SET_MULTIPLE_MSI	BIT(4)
> +#define UART_PCI_CTRL_D3_CLK_ENABLE	BIT(0)

Reorder.

> +static char pci1xxxx_port_suspend(int line)

Why char???

> +{
> +	struct uart_8250_port *up = serial8250_get_port(line);
> +	struct uart_port *port = &up->port;
> +	unsigned long flags;
> +	u8 wakeup_mask;
> +	char ret = 0;
> +
> +	if (port->suspended == 0 && port->dev) {
> +		wakeup_mask = readb(up->port.membase + UART_WAKE_MASK_REG);
> +
> +		spin_lock_irqsave(&port->lock, flags);
> +		port->mctrl &= ~TIOCM_OUT2;
> +		port->ops->set_mctrl(port, port->mctrl);
> +		spin_unlock_irqrestore(&port->lock, flags);
> +
> +		if ((wakeup_mask & UART_WAKE_SRCS) != UART_WAKE_SRCS)
> +			ret = 0x01;
> +		else
> +			ret = 0x00;

Is it a bool or should you name these it with a #define?

> +	}
> +
> +	writeb(UART_WAKE_SRCS, port->membase + UART_WAKE_REG);
> +
> +	return ret;
> +}
> +
> +void pci1xxxx_port_resume(int line)
> +{
> +	struct uart_8250_port *up = serial8250_get_port(line);
> +	struct uart_port *port = &up->port;
> +	unsigned long flags;
> +
> +	writeb(UART_WAKE_SRCS, port->membase + UART_WAKE_REG);
> +
> +	if (port->suspended == 0) {
> +		spin_lock_irqsave(&port->lock, flags);
> +		port->mctrl |= TIOCM_OUT2;
> +		port->ops->set_mctrl(port, port->mctrl);
> +		spin_unlock_irqrestore(&port->lock, flags);
> +	}
> +}
> +
> +static int pci1xxxx_suspend(struct device *dev)
> +{
> +	struct pci1xxxx_8250 *priv = dev_get_drvdata(dev);
> +	struct pci_dev *pcidev = to_pci_dev(dev);
> +	unsigned int data;
> +	void __iomem *p;
> +	char wakeup = 0;
> +	int i;
> +
> +	for (i = 0; i < priv->nr; i++) {
> +		if (priv->line[i] >= 0) {
> +			serial8250_suspend_port(priv->line[i]);
> +			wakeup |= pci1xxxx_port_suspend(priv->line[i]);
> +		}
> +	}
> +
> +	p = pci_ioremap_bar(pcidev, 0);
> +	if (!p) {
> +		dev_err(dev, "remapping of bar 0 memory failed");
> +		return -ENOMEM;
> +	}
> +
> +	data = readl(p + UART_RESET_REG);
> +	writel(data | UART_RESET_D3_RESET_DISABLE, p + UART_RESET_REG);
> +
> +	if (wakeup)

It looks you'd want bool instead of char here.


-- 
 i.

