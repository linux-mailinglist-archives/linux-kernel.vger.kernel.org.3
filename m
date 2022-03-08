Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A686C4D1AFA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347627AbiCHOvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbiCHOvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:51:40 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E2A3C733;
        Tue,  8 Mar 2022 06:50:43 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 1E8B730057E8D;
        Tue,  8 Mar 2022 15:50:42 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 11FC547A006; Tue,  8 Mar 2022 15:50:42 +0100 (CET)
Date:   Tue, 8 Mar 2022 15:50:42 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 1/7] serial: 8250_dwlib: RS485 HW half duplex support
Message-ID: <20220308145042.GA20520@wunner.de>
References: <20220302095606.14818-1-ilpo.jarvinen@linux.intel.com>
 <20220302095606.14818-2-ilpo.jarvinen@linux.intel.com>
 <20220306184857.GA19394@wunner.de>
 <CAHp75Vdxa_p866t5B7zJ8nHS-v+tu3vLiW0=vaBznnyCGyve_g@mail.gmail.com>
 <ab82f6a-8d1b-8e89-4ea-77d1a55667d2@linux.intel.com>
 <20220307191854.GA27748@wunner.de>
 <YiZfdlw0A75cojCx@smile.fi.intel.com>
 <6931d6ad-7520-b585-a8ba-35349e730bb@linux.intel.com>
 <20220308122220.GA24694@wunner.de>
 <d9aabfe-1179-67c2-98d1-f36e7e698f33@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9aabfe-1179-67c2-98d1-f36e7e698f33@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 02:59:59PM +0200, Ilpo Järvinen wrote:
> On Tue, 8 Mar 2022, Lukas Wunner wrote:
> > On Tue, Mar 08, 2022 at 02:16:56PM +0200, Ilpo Järvinen wrote:
> > > The SoC also has a pin to select between RS485 and RS232. With a combo 
> > > transceiver, TCR-based heuristic just runs into the same problems as the 
> > > version-based one did.
> > 
> > I thought this was about detecting whether hardware-assisted DE assertion
> > may be used (versus software-controlled), not about whether to enable
> > RS-485 mode.  Right?
> 
> HW DE assertion only works when RS485 mode is enabled so I don't see how 
> these questions could be easily decoupled like that. That's assuming with 
> "software-controlled" you mean RTS(RS232)+em485?

Right, that's what I meant.

Enabling RS-485 mode is only supposed to happen upon a TIOCSRS485 ioctl
or if the "linux,rs485-enabled-at-boot-time" property is present.
We don't need to second-guess the user's decision to enable RS-485 mode.
If that's what they've asked for, then we can and should assume that an
RS-485 transceiver is attached.

Of course, if hardware-assisted DE assertion requires a particular pinmux
state, we could double-check whether that pinmux state is set.  If the
RTS/DE pin is not muxed as a DE pin but rather as an RTS pin, one option
would be to fall back to software-controlled RTS assertion.  A warning
message may be warranted in that case.

Whether hardware-assisted DE assertion is supported by the chip can not
only be detected by checking for the POR 0x6 value in the TCR register:
You can alternatively write a non-zero value to any of the RS-485 registers,
then check if reading the register back returns a non-zero value
(RE_EN is probably a good candidate).  That approach is more robust
than relying on the POR value 0x6 in TCR because you never know if
boot firmware fiddled with the registers before passing control to the
kernel.

Thanks,

Lukas
