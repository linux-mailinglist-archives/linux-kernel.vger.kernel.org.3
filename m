Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D59C55A8D4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 12:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbiFYKVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 06:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiFYKVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 06:21:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BB831513;
        Sat, 25 Jun 2022 03:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656152508; x=1687688508;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=eTCNWlcNgptSkHWawKJQt1duBUbGSUyCeEj5eGlb+xM=;
  b=Xmv6M9frizN9FSPAqxwfGU1O57Zx7DuHm4CtBB885CZxy3xLbwpIN0ly
   rDWQ6wCY8E8ML1pRGrQRH5dizDqRMMr3gReaEL894648ME/juWXEbKSF7
   X+FrJDTe1KhkNfckonoijyKtVanolA2or6Aulxd9zcJD6LWiUD5kzqhRj
   OjIaAjixQlR/XVHMiJdIyvDZ2fF4ySCfkrWH01SqzHndHmGpr25niR0Wt
   BqX0itZDtmbSFUDZMQI1qQEgPW6HTvUKA8LOhGiqzdtNBsGwn5Bd3OJUW
   vX6gt/ewuIzLMefNTKeRZVXCgDSN8vtGQK4hAU/4enEbBs7RNIeckevet
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="269910741"
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="269910741"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 03:21:47 -0700
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="645650589"
Received: from selvaku-mobl.ger.corp.intel.com ([10.252.60.244])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 03:21:43 -0700
Date:   Sat, 25 Jun 2022 13:21:41 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        vz@mleia.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lukas@wunner.de,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH 6/8] serial: 8250_dwlib: remove redundant sanity check
 for RS485 flags
In-Reply-To: <20220622154659.8710-7-LinoSanfilippo@gmx.de>
Message-ID: <c0ef766d-198-b257-9291-cee7a6f890fa@linux.intel.com>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de> <20220622154659.8710-7-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1686025556-1656152507=:1653"
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1686025556-1656152507=:1653
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 22 Jun 2022, Lino Sanfilippo wrote:

> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> Before the drivers rs485_config() function is called the serial core
> already ensures that only one of both options RTS on send or RTS after send
> is set. So remove the concerning sanity check in the driver function to
> avoid redundancy.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/tty/serial/8250/8250_dwlib.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
> index c83e7eaf3877..bed2bd6b7a01 100644
> --- a/drivers/tty/serial/8250/8250_dwlib.c
> +++ b/drivers/tty/serial/8250/8250_dwlib.c
> @@ -95,16 +95,10 @@ static int dw8250_rs485_config(struct uart_port *p, struct serial_rs485 *rs485)
>  	if (rs485->flags & SER_RS485_ENABLED) {
>  		tcr |= DW_UART_TCR_RS485_EN;
>  
> -		if (rs485->flags & SER_RS485_RX_DURING_TX) {
> +		if (rs485->flags & SER_RS485_RX_DURING_TX)
>  			tcr |= DW_UART_TCR_XFER_MODE_DE_DURING_RE;
> -		} else {
> -			/* HW does not support same DE level for tx and rx */
> -			if (!(rs485->flags & SER_RS485_RTS_ON_SEND) ==
> -			    !(rs485->flags & SER_RS485_RTS_AFTER_SEND))
> -				return -EINVAL;
> -
> +		else
>  			tcr |= DW_UART_TCR_XFER_MODE_DE_OR_RE;
> -		}
>  		dw8250_writel_ext(p, DW_UART_DE_EN, 1);
>  		dw8250_writel_ext(p, DW_UART_RE_EN, 1);
>  	} else {
> -- 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-1686025556-1656152507=:1653--
