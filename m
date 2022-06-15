Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537AF54CAE0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356166AbiFOOGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345845AbiFOOGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:06:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4D74AE2D;
        Wed, 15 Jun 2022 07:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655301999; x=1686837999;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/J7saP6W0TXPEiZ1K3kLi0tAL5PKe7Bfz4iY/dpF86g=;
  b=EErOltXS2cxDsv7Fmyd6HIInA4C9vzwPBH3lcCfov8H5pobj4YA1/DsB
   ke5QOjWzyjcPGSvBa+3Krl6cjVsy/YeokTXB1A3uLnnZr8QZhyVJCCSAo
   nBOnCZ6Udb4KM+sPuXatJBA6MiPofAwrgUJzdaLe5cZnBhVusX3nlKDSe
   SCGbKe4gX/n8Iv+BngQYTIXTkWYK3yCNVd/ZrrCuM9RymgxScs6zrPjUQ
   OezXWt5Zjeajn8d/BuCsK7biL44ROok4TMKJKTK4htNHiLeU4UnQ2uJtr
   fw7xCzg6O5BlewHBDDLSUeCeGcRMhrabQbx7bZKbf8GJkvoYTV9l5J4t7
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="280007170"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="280007170"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 07:05:39 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="583222325"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 07:05:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o1TeD-000dUK-Te;
        Wed, 15 Jun 2022 17:05:29 +0300
Date:   Wed, 15 Jun 2022 17:05:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Lukas Wunner <lukas@wunner.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: [PATCH v7 4/6] serial: take termios_rwsem for .rs485_config() &
 pass termios as param
Message-ID: <YqnnKQYAnqORpdBJ@smile.fi.intel.com>
References: <20220615124829.34516-1-ilpo.jarvinen@linux.intel.com>
 <20220615124829.34516-5-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220615124829.34516-5-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 03:48:27PM +0300, Ilpo Järvinen wrote:
> To be able to alter ADDRB within .rs485_config(), take termios_rwsem
> before calling .rs485_config() and pass termios.

I would use ->rs485_config() as a reference to the callback.

...

> -	ret = port->rs485_config(port, rs485);
> +	ret = port->rs485_config(port, rs485, NULL);

> +

Stray change?

>  	if (ret)
>  		memset(rs485, 0, sizeof(*rs485));

...

>  	void			(*handle_break)(struct uart_port *);
>  	int			(*rs485_config)(struct uart_port *,
> -						struct serial_rs485 *rs485);
> +						struct serial_rs485 *rs485,
> +						struct ktermios *termios);

Dunno if termios has to be second parameter. The idea is to pass input data
followed by (auxiliary) output as usual pattern.

>  	int			(*iso7816_config)(struct uart_port *,
>  						  struct serial_iso7816 *iso7816);

-- 
With Best Regards,
Andy Shevchenko


