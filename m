Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8596E565173
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbiGDJ4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiGDJ4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:56:08 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B0BDEC9;
        Mon,  4 Jul 2022 02:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656928567; x=1688464567;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wqdKh+YT2kwmBentxY6WWvFarS1Y974WhBuHLSKpX8k=;
  b=eOZsXb49Yf9yLqlbb9EKagxY4AOKv9qAdS7CmpFbjCRINgPslAzPeCjP
   QtCWQnC/Jn0b6G2EnwfxgGKuKCv2/MPpTCN+HW2eZ9vJvny0uCFGl3ddH
   LmJsDCkLxh6hQj8h0quOaaiYXPleFkGaMHBeaQTvGAa9rE3q1UZdJhsP7
   H5FrO69hIsSDxj9B8fakPnzjjfjgmnbUVY5Y+bkeOYQ8giy0YR6QruosG
   1wMXnFCv8OkyBk+/bVKCN78Zr57MKC4GTQlChBL4r40xOq4j44dTp5qzf
   6CXbogZIyFHhFrXuL7x07OjH8rZaKXRFQz2bogNg8Si7j0FrRUJhx5Pol
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="347067904"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="347067904"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 02:56:06 -0700
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="649513813"
Received: from bclindho-mobl.ger.corp.intel.com ([10.252.49.27])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 02:56:02 -0700
Date:   Mon, 4 Jul 2022 12:55:59 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        vz@mleia.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH v2 1/9] serial: core: only get RS485 termination GPIO if
 supported
In-Reply-To: <20220703170039.2058202-2-LinoSanfilippo@gmx.de>
Message-ID: <9bc128a9-7ce3-d1e-dad6-ca91a5564ea8@linux.intel.com>
References: <20220703170039.2058202-1-LinoSanfilippo@gmx.de> <20220703170039.2058202-2-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Jul 2022, Lino Sanfilippo wrote:

> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> In uart_get_rs485_mode() only try to get a termination GPIO if RS485 bus
> termination is supported by the driver. This prevents from allocating
> and holding a GPIO descriptor for the drivers lifetimg that will never be
> used.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
> 
> NOTE: 
> This patch follows the design decision that "rs485_supported" is
> set by the driver at initialization and cannot be modified
> afterwards. However the better approach would be to let the serial
> core modify the termination GPIO support setting based on the
> existence of a termination GPIO. If "rs485_supported" is not a 
> read-only value any more in future the logic implemented in this
> patch should be adjusted accordingly.
> 
>  drivers/tty/serial/serial_core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 85ef7ef00b82..3768663dfa4d 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3404,6 +3404,16 @@ int uart_get_rs485_mode(struct uart_port *port)
>  	 */
>  	port->rs485_term_gpio = devm_gpiod_get_optional(dev, "rs485-term",
>  							GPIOD_OUT_LOW);
> +
> +	if (port->rs485_term_gpio &&
> +	    !(port->rs485_supported->flags & SER_RS485_TERMINATE_BUS)) {
> +		dev_warn(port->dev,
> +			"%s (%d): RS485 termination gpio not supported by driver\n",
> +			port->name, port->line);
> +		devm_gpiod_put(dev, port->rs485_term_gpio);
> +		port->rs485_term_gpio = NULL;
> +	}
> +
>  	if (IS_ERR(port->rs485_term_gpio)) {
>  		ret = PTR_ERR(port->rs485_term_gpio);
>  		port->rs485_term_gpio = NULL;

I sent a series to embed supported_rs485 to uart_port and manage 
SER_RS485_TERMINATE_BUS properly so I think this won't be necessary 
with that?


-- 
 i.

