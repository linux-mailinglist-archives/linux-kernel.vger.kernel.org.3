Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB31D55D5DB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbiF0JF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbiF0JFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:05:55 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FE1634B;
        Mon, 27 Jun 2022 02:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656320754; x=1687856754;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jcKmTKeNDN11ToKECGTcEIIGoAMkwCReSD4tvZEnNOU=;
  b=gh89DNe4LlIV3cmFQXzkOR5I57fix3KhHHbqM5idztRcTyFZtuUk5W+5
   DRHzumX06f2vLeVrABUuXKQfMHry2HtRYW/QDZLMW0040hF9y7dEyV15l
   CLDl/LLRT/UJzeDvnpubz5QQfzJVKaqWIPjqGGdKsMgjH0c550WbEfJV1
   /KParq2Eo93HyjRIVCoFdRWnICVbzhYHucW5QsikB0N4MySnwbqA6FNDx
   d79zPv8cE73mNatcjAmW2JVYO1d650Vyab4Y7tj0XG4UsS/urrhdSO0ow
   AvUqprzvoUlP3r/nRuh5HFG7RDpdFuurNCWmxpbJHyB0KVDpM6DG74owq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="367719636"
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="367719636"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 02:05:53 -0700
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="646348400"
Received: from gretavix-mobl3.amr.corp.intel.com ([10.249.43.78])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 02:05:49 -0700
Date:   Mon, 27 Jun 2022 12:05:50 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        vz@mleia.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH 1/8] serial: core: only get RS485 termination gpio if
 supported
In-Reply-To: <20220625194951.GA2879@wunner.de>
Message-ID: <fbce8d7e-86e-d47e-bcd8-5b99754d1d2e@linux.intel.com>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de> <20220622154659.8710-2-LinoSanfilippo@gmx.de> <20220625194951.GA2879@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jun 2022, Lukas Wunner wrote:

> On Wed, Jun 22, 2022 at 05:46:52PM +0200, Lino Sanfilippo wrote:
> > In uart_get_rs485_mode() only try to get a termination GPIO if RS485 bus
> > termination is supported by the driver.
> [...]
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -3384,17 +3384,20 @@ int uart_get_rs485_mode(struct uart_port *port)
> >  		rs485conf->flags |= SER_RS485_RTS_AFTER_SEND;
> >  	}
> >  
> > -	/*
> > -	 * Disabling termination by default is the safe choice:  Else if many
> > -	 * bus participants enable it, no communication is possible at all.
> > -	 * Works fine for short cables and users may enable for longer cables.
> > -	 */
> > -	port->rs485_term_gpio = devm_gpiod_get_optional(dev, "rs485-term",
> > -							GPIOD_OUT_LOW);
> > -	if (IS_ERR(port->rs485_term_gpio)) {
> > -		ret = PTR_ERR(port->rs485_term_gpio);
> > -		port->rs485_term_gpio = NULL;
> > -		return dev_err_probe(dev, ret, "Cannot get rs485-term-gpios\n");
> > +	if (port->rs485_supported->flags & SER_RS485_TERMINATE_BUS) {
> 
> So I think linux-next commit be2e2cb1d281 ("serial: Sanitize rs485_struct")
> contains a mistake in that it forces drivers to set SER_RS485_TERMINATE_BUS
> in their rs485_supported->flags to allow enabling bus termination.
> 
> That's wrong because *every* rs485-capable driver can enable bus
> termination if a GPIO has been defined for that in the DT.

Do you mean every em485 using driver? Otherwise I don't see this "forces 
drivers to set" happening anywhere in the code?

You're partially right because there are other bugs in this area such 
as the one you propose a fix below. While I was making the sanitization 
series, I entirely missed some parts related to termination because 
SER_RS485_TERMINATE_BUS is seemingly not set/handled correctly by the 
core.

Another thing that looks a bug is that on subsequent call to TIOCSRS485, 
w/o SER_RS485_TERMINATE_BUS nothing happens (for non-em485 driver, that 
is)? It seems to be taken care by 2/8 of this series though, I think. But 
it should be properly marked as Fixes: ... in that case although nobody 
has complained about it so likely not a huge issue to anyone.

> In fact, another commit which was applied as part of the same series,
> ebe2cf736a04 ("serial: pl011: Fill in rs485_supported") does not set
> SER_RS485_TERMINATE_BUS in amba-pl011.c's flags and thus forbids the
> driver from enabling bus termination, even though we know there are
> products out there which support bus termination on the pl011 through
> a GPIO (Revolution Pi RevPi Compact, Revpi Flat).
>
> I think what you want to do is amend uart_get_rs485_mode() to set
> SER_RS485_TERMINATE_BUS in port->rs485_supported_flags if a GPIO
> was found in the DT.  Instead of the change proposed above.

That seems appropriate (and is a fix).

What makes it a bit complicated though is that it's a pointer currently
and what it points to is shared per driver (besides being const):
	const struct serial_rs485       *rs485_supported;
While it could be embedded into uart_port, there's the .padding which we 
might not want to bloat uart_port with. Perhaps create non-uapi struct 
kserial_rs485 w/o .padding and add static_assert()s to ensure the 
layout is identical to serial_rs485?


-- 
 i.

