Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520CE5B00F5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiIGJzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiIGJzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:55:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3943A24BF8;
        Wed,  7 Sep 2022 02:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662544507; x=1694080507;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wTz5MbuOMBDOMBq3QKGowVOjTKfUFIGm8N9GEPakT7M=;
  b=hSCiyCvSJywfCOImk37gC1imW5dKcu0AUcQ1fB4LY6/l9MZxvorkAKHO
   /KZRjA/o5lz41Fh4AtAyd4e6og2T5K0msuUo8z5ob50bHqBqGRCDX524k
   RdHp6lOXbqRI7OqFPBtZvSg1P+73OACOKJw5BAOfzPWAVV1t3QHiPJkmJ
   tex9y1Gd7vN0cH0DW63j442YvsIQqG1ffPhYEf8k817nF0M+QEaMlMIme
   xupNTB90ibbPOuV4uCUejVx7M6T6z9AQ9Tb3qfpWM69Pzq9an7wmZ0CiE
   z3zeY9Xm/ioaxIcJvWA5bmE/mue6J55Nl0la11g6/Y/e8empIZNQBvE2J
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="294415263"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="294415263"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 02:55:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="644551974"
Received: from dmatouse-mobl.ger.corp.intel.com ([10.251.223.53])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 02:54:58 -0700
Date:   Wed, 7 Sep 2022 12:54:57 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tobias Klauser <tklauser@distanz.ch>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/4] tty: TX helpers
In-Reply-To: <20220906104805.23211-1-jslaby@suse.cz>
Message-ID: <e6e551fa-2347-7b17-8a62-2b28517c76e@linux.intel.com>
References: <20220906104805.23211-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1229872048-1662544507=:1717"
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1229872048-1662544507=:1717
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 6 Sep 2022, Jiri Slaby wrote:

> This series introduces DEFINE_UART_PORT_TX_HELPER +
> DEFINE_UART_PORT_TX_HELPER_LIMITED TX helpers. See PATCH 2/4 for the
> details. Comments welcome.
> 
> Then it switches drivers to use them. First, to
> DEFINE_UART_PORT_TX_HELPER() in 3/4 and then
> DEFINE_UART_PORT_TX_HELPER_LIMITED() in 4/4.
> 
> The diffstat of patches 3+4 is as follows:
>  26 files changed, 191 insertions(+), 823 deletions(-)
> which appears to be nice.
> 
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Cc: Richard Genoud <richard.genoud@gmail.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: "Andreas Färber" <afaerber@suse.de>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: "Pali Rohár" <pali@kernel.org>
> Cc: Kevin Cernekee <cernekee@gmail.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Baolin Wang <baolin.wang7@gmail.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: linux-riscv@lists.infradead.org
> 
> Jiri Slaby (4):
>   tty: serial: move and cleanup vt8500_tx_empty()
>   tty: serial: introduce transmit helper generators
>   tty: serial: use DEFINE_UART_PORT_TX_HELPER()
>   tty: serial: use DEFINE_UART_PORT_TX_HELPER_LIMITED()
> 
>  Documentation/driver-api/serial/driver.rst |  3 +
>  drivers/tty/serial/21285.c                 | 33 ++-------
>  drivers/tty/serial/altera_jtaguart.c       | 42 +++--------
>  drivers/tty/serial/altera_uart.c           | 37 ++--------
>  drivers/tty/serial/amba-pl010.c            | 37 ++--------
>  drivers/tty/serial/apbuart.c               | 36 ++--------
>  drivers/tty/serial/atmel_serial.c          | 29 ++------
>  drivers/tty/serial/bcm63xx_uart.c          | 47 +++----------
>  drivers/tty/serial/fsl_lpuart.c            | 38 +++-------
>  drivers/tty/serial/lantiq.c                | 44 ++++--------
>  drivers/tty/serial/lpc32xx_hs.c            | 38 ++--------
>  drivers/tty/serial/mcf.c                   | 27 ++------
>  drivers/tty/serial/mpc52xx_uart.c          | 43 +-----------
>  drivers/tty/serial/mps2-uart.c             | 29 +-------
>  drivers/tty/serial/mux.c                   | 46 ++++--------
>  drivers/tty/serial/mvebu-uart.c            | 40 ++---------
>  drivers/tty/serial/mxs-auart.c             | 31 ++-------
>  drivers/tty/serial/omap-serial.c           | 47 ++++---------
>  drivers/tty/serial/owl-uart.c              | 35 +---------
>  drivers/tty/serial/pxa.c                   | 39 +++--------
>  drivers/tty/serial/rp2.c                   | 36 ++--------
>  drivers/tty/serial/sa1100.c                | 49 +++++--------
>  drivers/tty/serial/serial_txx9.c           | 37 ++--------
>  drivers/tty/serial/sifive.c                | 45 ++----------
>  drivers/tty/serial/sprd_serial.c           | 38 ++--------
>  drivers/tty/serial/st-asc.c                | 50 ++-----------
>  drivers/tty/serial/vt8500_serial.c         | 40 ++---------
>  include/linux/serial_core.h                | 81 ++++++++++++++++++++++
>  28 files changed, 275 insertions(+), 822 deletions(-)

For the whole series:

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1229872048-1662544507=:1717--
