Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376B355A8BF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 12:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbiFYKON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 06:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiFYKOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 06:14:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698B113E0C;
        Sat, 25 Jun 2022 03:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656152050; x=1687688050;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FpKY2DF6TueYC4tmSBCp0oR3CpEMPuEwj+UmJ668MZU=;
  b=hkIhEnZxESzupOW1puVozWdUhlfm8eUqoKGCSyfDjeRptBidZn0zBNNC
   uG937syASipLvTPLvh3Dd55QJETnTTTT/rBYMaMX8VIdu6ObKOmKNgfKS
   GqmOV6InY5utmxo1dMK60DjBqa62AnGPBPiWUVR/dhKJ+a+rMRlo+UxWF
   bsHcTYXdR5+ic/wW9Vy/9f1U567f61iRZqxqp/p6TR9jzHdV4ptql3Sxe
   ++55M/gCD2VMOniOaxdemChWqyJw0VZHVFLU0YzZWJsLgXiw9gMYwh0DI
   qkoCvMZmFcLMlW9Fp146hvobkdsr/nbpiuu4c7WwK4c84OX5NwR9BKc8V
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="281907113"
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="281907113"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 03:14:10 -0700
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="645648517"
Received: from selvaku-mobl.ger.corp.intel.com ([10.252.60.244])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 03:14:05 -0700
Date:   Sat, 25 Jun 2022 13:14:03 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        vz@mleia.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lukas@wunner.de,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH 7/8] serial: ar933x: Remove redundant assignment in
 rs485_config
In-Reply-To: <20220622154659.8710-8-LinoSanfilippo@gmx.de>
Message-ID: <f7beef4-c422-cae3-8e22-8652b407434@linux.intel.com>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de> <20220622154659.8710-8-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2022, Lino Sanfilippo wrote:

> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> In uart_set_rs485_config() the serial core already assigns the passed
> serial_rs485 struct to the uart port.
> 
> So remove the assignment in the drivers rs485_config() function to avoid
> redundancy.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/tty/serial/ar933x_uart.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
> index ab2c5b2a1ce8..857e010d01dc 100644
> --- a/drivers/tty/serial/ar933x_uart.c
> +++ b/drivers/tty/serial/ar933x_uart.c
> @@ -591,7 +591,6 @@ static int ar933x_config_rs485(struct uart_port *port,
>  		dev_err(port->dev, "RS485 needs rts-gpio\n");
>  		return 1;
>  	}
> -	port->rs485 = *rs485conf;
>  	return 0;
>  }

Hmm, I realize that for some reason I missed cleaning up this particular 
driver after introducing the serial_rs485 sanitization. It shouldn't need 
that preceeding if block either because ar933x_no_rs485 gets applied if 
there's no rts_gpiod so the core clears SER_RS485_ENABLED.


-- 
 i.

