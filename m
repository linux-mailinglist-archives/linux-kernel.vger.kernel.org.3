Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99A95A7A66
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiHaJnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiHaJnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:43:04 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0ED8C6FF5;
        Wed, 31 Aug 2022 02:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661938980; x=1693474980;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=e5BXTTbEN9oyaXeHXCdrLZklrN/YmuZpv91NpQyVSl4=;
  b=Aj8PYwmYazVIKc7i9u470gnHZi3c1d9w4/T8MtCIxlmGpAsXA/IPZv94
   It07wZoT3DxZzi+bxBa+flqjpLcdlN0/9sOWgsv1v7GPLamRQ+bnxgEUy
   it8UQI4u1uGw2Wr0+QKq1nTEKWsr/fn+GZF85dH7EXvZ/n8JaCjWCuGZk
   qBSDMdZqQSFF/4JFf6waVDLP/koGVJAgAs8M6iDZJ8vLW+pXbvJzXR8yx
   CSvn0CwwKI9QgjSa7mUI5c+QSU/qPNQxmFbK8UnGPh3xghZA9E887ne13
   /iy8TfR+Y12ccJ6OuWnASCMA+mR+ahicCr+GqveB8MFRdtM3zSH9l2qN1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="278429089"
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="278429089"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 02:42:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="673282687"
Received: from adott-mobl1.ger.corp.intel.com ([10.252.43.127])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 02:42:53 -0700
Date:   Wed, 31 Aug 2022 12:42:48 +0300 (EEST)
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
Subject: Re: [PATCH v1 tty-next 1/2] 8250: microchip: pci1xxxx: Add driver
 for the quad-uart function in the  multi-function endpoint of pci1xxxx
 device.
In-Reply-To: <20220830180054.1998296-2-kumaravel.thiagarajan@microchip.com>
Message-ID: <bea049b-69d-a097-ddeb-737cdd485e@linux.intel.com>
References: <20220830180054.1998296-1-kumaravel.thiagarajan@microchip.com> <20220830180054.1998296-2-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2022, Kumaravel Thiagarajan wrote:

> pci1xxxx is a PCIe switch with a multi-function endpoint on one of its
> downstream ports. Quad-uart is one of the functions in the
> multi-function endpoint. This driver loads for the quad-uart and
> enumerates single or multiple instances of uart based on the PCIe
> subsystem device ID.
> 
> Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> ---

> +static int mchp_pci1xxxx_rs485_config(struct uart_port *port,
> +				      struct ktermios *termios,
> +				      struct serial_rs485 *rs485)
> +{
> +	u8 data = 0;
> +
> +	memset(rs485->padding, 0, sizeof(rs485->padding));
> +	rs485->flags &= SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND;
> +
> +	if (rs485->flags & SER_RS485_ENABLED) {
> +		data = ADCL_CFG_EN | ADCL_CFG_PIN_SEL;
> +		if (!(rs485->flags & SER_RS485_RTS_ON_SEND)) {
> +			data |= ADCL_CFG_POL_SEL;
> +			rs485->flags |=  SER_RS485_RTS_AFTER_SEND;
> +		}
> +	}
> +
> +	rs485->delay_rts_after_send = 0;
> +	rs485->delay_rts_before_send = 0;
> +	writeb(data, (port->membase + ADCL_CFG_REG));
> +	port->rs485 = *rs485;

Most of this will be handled for by the core so don't duplicate it in
the driver.

These days, you also need to provide rs485_supported.

> +	return 0;
> +}
> +
> +static void mchp_pci1xxxx_set_termios(struct uart_port *port,
> +				      struct ktermios *termios,
> +				      struct ktermios *old)
> +{
> +	const unsigned int standard_baud_list[] = {50, 75, 110, 134, 150, 300,
> +						600, 1200, 1800, 2000, 2400, 3600,
> +						4800, 7200, 9600, 19200, 38400, 57600,
> +						115200, 125000, 136400, 150000, 166700,
> +						187500, 214300, 250000, 300000, 375000,
> +						500000, 750000, 1000000, 1500000};
> +	unsigned int baud = tty_termios_baud_rate(termios);
> +	unsigned int baud_clock;
> +	unsigned int quot;
> +	unsigned int frac;
> +	unsigned int i;
> +
> +	baud = tty_termios_baud_rate(termios);

Either this or the one at the declaration is redundant.

> +	serial8250_do_set_termios(port, termios, NULL);
> +
> +	if (baud == 38400 && (port->flags & UPF_SPD_MASK) == UPF_SPD_CUST) {
> +		writel((port->custom_divisor & 0x3FFFFFFF),
> +		       (port->membase + CLK_DIVISOR_REG));
> +	} else {
> +		for (i = 0; i < ARRAY_SIZE(standard_baud_list); i++) {
> +			if (baud == standard_baud_list[i])
> +				return;

Did you mean to break here instead?

> +		}
> +		tty_termios_encode_baud_rate(termios, baud, baud);
> +
> +		baud = uart_get_baud_rate(port, termios, old,
> +					  50, 1500000);
> +		baud_clock = readb(port->membase + CLK_SEL_REG);
> +
> +		if ((baud_clock & CLK_SEL_MASK) == CLK_SEL_500MHZ) {
> +			quot = 500000000 / (16 * baud);
> +			writel(quot, (port->membase + CLK_DIVISOR_REG));
> +		} else if ((baud_clock & CLK_SEL_MASK) == CLK_SEL_166MHZ) {
> +			quot = (166667 * 1000) / (16 * baud);
> +			writel(quot, (port->membase + CLK_DIVISOR_REG));
> +		} else {
> +			quot = ((1000000000) / (baud * UART_BIT_SAMPLE_CNT));
> +			frac = (((1000000000 - (quot * baud *
> +				UART_BIT_SAMPLE_CNT)) / UART_BIT_SAMPLE_CNT)
> +				* 255) / baud;
> +			writel(frac | (quot << 8),
> +			       (port->membase + CLK_DIVISOR_REG));
> +		}

Please check ->[gs]et_divisor() out.


-- 
 i.

