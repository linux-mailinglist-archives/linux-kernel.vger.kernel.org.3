Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED72754D99A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 07:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350554AbiFPFPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 01:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiFPFPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 01:15:37 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08F92AE09;
        Wed, 15 Jun 2022 22:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655356536; x=1686892536;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=w5f/uRo7VAfu2ZSH1O1BKsd51bCmWG6WWb8H4rj04YI=;
  b=b9P2E6xJnjVob+ppGGsv+/BVWwNuTOloIEJsFO/ZTu1Ndtf1puD8dihn
   ZaAbRqL7EAMQCOEqBv4RyEbsBWNWs0ddxW+en3cUWiib9zRC7qfQZY9Up
   Bo94U6TLSa7Iqh2G8LCJRDE4z+jYpNNWrQ5uiEfYdiL8XBJyz+yDHy3t6
   enZKaTygFn75VISN/T1KJ4buUxgfVarEEPwWWYixypl61yqcpsGf2F+WK
   jS5HL89XzVBp98ZWUz1pTlnI6KY2Pdrg8y7p/K0Tr45tMNv1qjKIFYVOa
   gyFR7HfOeCBECJYTwCgLSYDd4kkXsRkOcQ9xSdhx8EBhEazc2Dp++Zv5U
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="279883644"
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="279883644"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 22:15:26 -0700
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="641366171"
Received: from mngueron-mobl1.amr.corp.intel.com ([10.252.60.248])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 22:15:19 -0700
Date:   Thu, 16 Jun 2022 08:15:16 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
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
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Lukas Wunner <lukas@wunner.de>,
        =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: [PATCH v7 4/6] serial: take termios_rwsem for .rs485_config()
 & pass termios as param
In-Reply-To: <YqnnKQYAnqORpdBJ@smile.fi.intel.com>
Message-ID: <ddc178b-1292-248c-21a1-4cf990d0b1c@linux.intel.com>
References: <20220615124829.34516-1-ilpo.jarvinen@linux.intel.com> <20220615124829.34516-5-ilpo.jarvinen@linux.intel.com> <YqnnKQYAnqORpdBJ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1748112325-1655356526=:1693"
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

--8323329-1748112325-1655356526=:1693
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Wed, 15 Jun 2022, Andy Shevchenko wrote:

> On Wed, Jun 15, 2022 at 03:48:27PM +0300, Ilpo Järvinen wrote:
> > To be able to alter ADDRB within .rs485_config(), take termios_rwsem
> > before calling .rs485_config() and pass termios.
> 
> I would use ->rs485_config() as a reference to the callback.
> 
> ...
> 
> > -	ret = port->rs485_config(port, rs485);
> > +	ret = port->rs485_config(port, rs485, NULL);
> 
> > +
> 
> Stray change?

Yes it was.

> >  	if (ret)
> >  		memset(rs485, 0, sizeof(*rs485));
> 
> ...
> 
> >  	void			(*handle_break)(struct uart_port *);
> >  	int			(*rs485_config)(struct uart_port *,
> > -						struct serial_rs485 *rs485);
> > +						struct serial_rs485 *rs485,
> > +						struct ktermios *termios);
> 
> Dunno if termios has to be second parameter. The idea is to pass input data
> followed by (auxiliary) output as usual pattern.

I guess I can make termios 2nd param.

-- 
 i.

--8323329-1748112325-1655356526=:1693--
