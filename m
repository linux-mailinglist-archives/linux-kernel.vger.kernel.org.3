Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993785B05BD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiIGNxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiIGNxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:53:39 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A25A9E2F8;
        Wed,  7 Sep 2022 06:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tCjY/QLdprUhf7WTcDGbAKlrnkf5jVx/ryaWR+dwtH8=; b=GIwenM/qxvktpWk+ynw5s+7XBo
        NxlXbk/3I26vSXz691UpGfggJkyclumiQG0P7Fdno0A8V7yF4hkfBMtSUnBbxCPcYkGhNrglx6VW4
        JDP+fLL5bd5kZeEYw+zdzq3y1/WNg/rc7HnpKTnPujcHh8uHZ2r9lEZqWJPrDHL1+sS0qJZgQ5K+G
        T5C2pNlLsN5ZnYOdW6+0TMdZC8P7Fg/OeWpOKRNxCEe+1GaQx3u7bDJG5f/y1uFUg9cV5W5/lzXJr
        6Akgtj4N4giZsUhXhvbZeVVTqiq1ffu7wgn+/4CrODR6B1ZJRbpA5YuPKLhoSD2km2JlW4nG2smfQ
        Rb/slnaA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34176)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oVvUM-0005SY-QH; Wed, 07 Sep 2022 14:53:10 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oVvU9-00019I-RD; Wed, 07 Sep 2022 14:52:57 +0100
Date:   Wed, 7 Sep 2022 14:52:57 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
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
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/4] tty: TX helpers
Message-ID: <YxiiOWQxGCUz9ktF@shell.armlinux.org.uk>
References: <20220906104805.23211-1-jslaby@suse.cz>
 <Yxcvbk281f/vy4vb@hovoldconsulting.com>
 <dec6d5c4-45b7-f087-95f4-bf1dae9e9d27@kernel.org>
 <4e9b4471-a6f2-4b16-d830-67d253ae4e6a@linux.intel.com>
 <715b40ba-1bcc-4582-bed1-ef41126c7b94@www.fastmail.com>
 <cfd16d53-6aa0-e848-91d0-dce8ff72bb4d@linux.intel.com>
 <YxiONiDgGYp8MGQA@kroah.com>
 <c66f9c98-dcef-27c-d74a-ea826f6a799@linux.intel.com>
 <YxiQVTN/jX8AfO4L@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YxiQVTN/jX8AfO4L@kroah.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 02:36:37PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Sep 07, 2022 at 03:32:44PM +0300, Ilpo Järvinen wrote:
> > On Wed, 7 Sep 2022, Greg Kroah-Hartman wrote:
> > 
> > > On Wed, Sep 07, 2022 at 03:21:28PM +0300, Ilpo Järvinen wrote:
> > > > On Wed, 7 Sep 2022, Arnd Bergmann wrote:
> > > > 
> > > > > On Wed, Sep 7, 2022, at 12:16 PM, Ilpo Järvinen wrote:
> > > > > > On Wed, 7 Sep 2022, Jiri Slaby wrote:
> > > > > >> On 06. 09. 22, 13:30, Johan Hovold wrote:
> > > > > >> > On Tue, Sep 06, 2022 at 12:48:01PM +0200, Jiri Slaby wrote:
> > > > > >> > NAK
> > > > > >> 
> > > > > >> I'd love to come up with something nicer. That would be a function in
> > > > > >> serial-core calling hooks like I had [1] for example. But provided all those
> > > > > >> CPU workarounds/thunks, it'd be quite expensive to call two functions per
> > > > > >> character.
> > > > > >> 
> > > > > >> Or creating a static inline (having ± the macro content) and the hooks as
> > > > > >> parameters and hope for optimizations to eliminate thunks (also suggested in
> > > > > >> the past [1]).
> > > > > >> 
> > > > > >> [1] https://lore.kernel.org/all/20220411105405.9519-1-jslaby@suse.cz/
> > > > > >
> > > > > > I second Jiri here.
> > > > > >
> > > > > > Saving lines in drivers is not that important compared with all removing 
> > > > > > all the variants of the same thing that have crept there over the years.
> > > > > >
> > > > > > I suspect the main reason for the variants is that everybody just used 
> > > > > > other drivers as examples and therefore we've a few "main" variant 
> > > > > > branches depending on which of the drivers was used as an example for the 
> > > > > > other. That is hardly a good enough reason to keep them different and as 
> > > > > > long as each driver keeps its own function for this, it will eventually 
> > > > > > lead to similar differentiation so e.g. a one-time band-aid similarization 
> > > > > > would not help in the long run.
> > > > > >
> > > > > > Also, I don't understand why you see it unreadable when the actual code is 
> > > > > > out in the open in that macro. It's formatted much better than e.g. 
> > > > > > read_poll_timeout() if you want an example of something that is hardly 
> > > > > > readable ;-). I agree though there's a learning-curve, albeit small, that 
> > > > > > it actually creates a function but that doesn't seem to me as big of an 
> > > > > > obstacle you seem to think.
> > > > > 
> > > > > I think it would help to replace the macro that defines
> > > > > the function with a set of macros that can be used in
> > > > > function bodies. This would avoid the __VA_ARGS__ stuff
> > > > > and allow readers that are unfamiliar with tty drivers to
> > > > > treat it as a function call.
> > > > > 
> > > > > So e.g. instead of 
> > > > > 
> > > > > static DEFINE_UART_PORT_TX_HELPER_LIMITED(altera_jtaguart_do_tx_chars,
> > > > > 		true,
> > > > > 		writel(ch, port->membase + ALTERA_JTAGUART_DATA_REG),
> > > > > 		({}));
> > > > > 
> > > > > the altera_jtaguart driver would contain a function like
> > > > > 
> > > > > static int altera_jtaguart_do_tx_chars(struct uart_port *port,
> > > > >                                        unsigned int count)
> > > > > {
> > > > >        char ch;
> > > > > 
> > > > >        return uart_port_tx_helper_limited(port, ch, count, true,
> > > > >                 writel(ch, port->membase + ALTERA_JTAGUART_DATA_REG),
> > > > >                 ({}));
> > > > > }
> > > > > 
> > > > > or some variation of that. It's a few more lines, but those
> > > > > extra lines would help me understand what is actually going on
> > > > > while still avoiding the usual bugs and duplication.
> > > > > 
> > > > > If the caller of that function is itself trivial (like
> > > > > serial21285_tx_chars), then the intermediate function can
> > > > > be omitted in order to save some of the extra complexity.
> > > > 
> > > > I'd be ok with that. There's still a small startle factor associated to 
> > > > passing that writel(...) as an argument to a "function" but it's the same 
> > > > for other things such as read_poll_timeout() so not an end of the world.
> > > 
> > > That's going to incure the function-pointer-indirection-call for every
> > > character that Jiri's original submission had, so I don't think this is
> > > a very viable solution, sorry.
> > 
> > I don't think you got what Arnd meant. It must still be technically a 
> > #define because you cannot pass
> > 	writel(ch, port->membase + ALTERA_JTAGUART_DATA_REG)
> > as an argument to a real function like he did in the example above.
> > It's similar to how read_poll_timeout() and friends are #defines despite 
> > being lowercased.
> 
> Ok, no, I don't understand what Arnd meant here then :(

Arnd's opening sentence when proposing the new thing was:

"I think it would help to replace the macro that defines
the function with a set of macros that can be used in
function bodies."

Given "a set of macros" and the quoted example, I take
"uart_port_tx_helper_limited" to be one of those macros - it has to be
a macro because - as others have pointed out - you can't pass
"writel(ch, port->membase + ALTERA_JTAGUART_DATA_REG)" to a function.

Of course, it would have been nicer to see the definition of this
macro, because then we can understand what the "ch" argument is to
this macro, and how that relates to the macro argument that is
shown in the example as a writel().

Maybe a more complete example would help clear up the confusion?
Arnd?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
