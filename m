Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22074D077B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245039AbiCGTT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237059AbiCGTTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:19:55 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DAA193EB;
        Mon,  7 Mar 2022 11:18:58 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id A9FD9101C0527;
        Mon,  7 Mar 2022 20:18:54 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 87D06449B49; Mon,  7 Mar 2022 20:18:54 +0100 (CET)
Date:   Mon, 7 Mar 2022 20:18:54 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 1/7] serial: 8250_dwlib: RS485 HW half duplex support
Message-ID: <20220307191854.GA27748@wunner.de>
References: <20220302095606.14818-1-ilpo.jarvinen@linux.intel.com>
 <20220302095606.14818-2-ilpo.jarvinen@linux.intel.com>
 <20220306184857.GA19394@wunner.de>
 <CAHp75Vdxa_p866t5B7zJ8nHS-v+tu3vLiW0=vaBznnyCGyve_g@mail.gmail.com>
 <ab82f6a-8d1b-8e89-4ea-77d1a55667d2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab82f6a-8d1b-8e89-4ea-77d1a55667d2@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 11:19:59AM +0200, Ilpo Järvinen wrote:
> On Mon, 7 Mar 2022, Andy Shevchenko wrote:
> > On Mon, Mar 7, 2022 at 12:00 AM Lukas Wunner <lukas@wunner.de> wrote:
> > > On Wed, Mar 02, 2022 at 11:56:00AM +0200, Ilpo Järvinen wrote:
> > > > +     d->hw_rs485_support = device_property_read_bool(p->dev, "snps,rs485-interface-en");
> > > > +     if (d->hw_rs485_support)
> > > > +             p->rs485_config = dw8250_rs485_config;
> > > > +
> > >
> > > You wrote in the commit message that rs485 support is present from
> > > version 4.0 onward.  Can't we just check the IP version and enable
> > > rs485 support for >= 4.0?  That would seem more appropriate instead
> > > of introducing yet another new property.
> > 
> > AFAIU this is dependent on the IP syntheses. I.o.w. version 4.0+ is a
> > prerequisite, but doesn't automatically mean that there is a support.
> > Unfortunately there is no way to tell this clearly in the IP
> > configuration register.
> 
> And the IP synthesis only part of the picture, in general case, it'd
> also matter that there's something connected to that RE (i.e.,
> an RS485 transceiver).

If an RS-485 transceiver is *soldered* to the UART, the devicetree
is supposed to contain the property "linux,rs485-enabled-at-boot-time"
under the UART's of_node.  In that case the UART driver can (and should)
enable rs485 mode already on ->probe.

Of course there's also the possibility to enable RS-485 after ->open
with the TIOCSRS485 ioctl.  That can be used if the transceiver is
attached at runtime (which is likely a rare use case) or as a legacy
enablement method if the driver lacks linux,rs485-enabled-at-boot-time
support.

That's for DT platforms, but I suppose you've got ACPI.  Not sure
how it's handled there, the ACPI 6.4 spec contains a "UART Serial Bus
Connection Resource Descriptor" but nothing on RS-485, so I guess
the only option is to use regular DT properties in a _DSD object?


> I initially had additional version check here while developing this
> patch series but it seemed to not provide any added value due those
> other factors that need to be considered.

Here's another idea:

Read TCR register on ->probe.  It's POR value is 0x6 if RS-485 is
supported by the chip, else 0x0.  (Page 220 of the 4.01a spec says
UCV register does not exist if additional features are not implemented
and reading from this register address returns 0, I suppose the same
applies to TCR if RS-485 is not implemented.)

Since the driver may change the polarity in the TCR register, be sure
to write 0x6 to it on ->remove so that you can still correctly detect
presence of the RS-485 feature after unbind/rebind of the driver.

Thanks,

Lukas
