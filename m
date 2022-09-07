Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EA25B03E8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 14:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiIGM1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 08:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIGM1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 08:27:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9DDAB418;
        Wed,  7 Sep 2022 05:27:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60939B81C29;
        Wed,  7 Sep 2022 12:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51819C433D6;
        Wed,  7 Sep 2022 12:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662553657;
        bh=MlcvCBFONM0Q3HGbf+iu5vcYE7JzglxZtv5RjeJdq+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jdOVSndiMaKnKdCVU0AFeYdJlV0AWftG69PoYHflE6v3waleOO98fvvEamHA42AG+
         YO5EOWxtmDOwY/kO3/mrzEoReruOTHgb04vtiUMQChXVb9WG+GNy6xSjEHlwTBvo0a
         nGNHdBbsgJxCTG0eDBYk7qhnJE2ZUSJJGxhvM64E=
Date:   Wed, 7 Sep 2022 14:27:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jirislaby@kernel.org>,
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
        Russell King <linux@armlinux.org.uk>,
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
Message-ID: <YxiONiDgGYp8MGQA@kroah.com>
References: <20220906104805.23211-1-jslaby@suse.cz>
 <Yxcvbk281f/vy4vb@hovoldconsulting.com>
 <dec6d5c4-45b7-f087-95f4-bf1dae9e9d27@kernel.org>
 <4e9b4471-a6f2-4b16-d830-67d253ae4e6a@linux.intel.com>
 <715b40ba-1bcc-4582-bed1-ef41126c7b94@www.fastmail.com>
 <cfd16d53-6aa0-e848-91d0-dce8ff72bb4d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cfd16d53-6aa0-e848-91d0-dce8ff72bb4d@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 03:21:28PM +0300, Ilpo Järvinen wrote:
> On Wed, 7 Sep 2022, Arnd Bergmann wrote:
> 
> > On Wed, Sep 7, 2022, at 12:16 PM, Ilpo Järvinen wrote:
> > > On Wed, 7 Sep 2022, Jiri Slaby wrote:
> > >> On 06. 09. 22, 13:30, Johan Hovold wrote:
> > >> > On Tue, Sep 06, 2022 at 12:48:01PM +0200, Jiri Slaby wrote:
> > >> > NAK
> > >> 
> > >> I'd love to come up with something nicer. That would be a function in
> > >> serial-core calling hooks like I had [1] for example. But provided all those
> > >> CPU workarounds/thunks, it'd be quite expensive to call two functions per
> > >> character.
> > >> 
> > >> Or creating a static inline (having ± the macro content) and the hooks as
> > >> parameters and hope for optimizations to eliminate thunks (also suggested in
> > >> the past [1]).
> > >> 
> > >> [1] https://lore.kernel.org/all/20220411105405.9519-1-jslaby@suse.cz/
> > >
> > > I second Jiri here.
> > >
> > > Saving lines in drivers is not that important compared with all removing 
> > > all the variants of the same thing that have crept there over the years.
> > >
> > > I suspect the main reason for the variants is that everybody just used 
> > > other drivers as examples and therefore we've a few "main" variant 
> > > branches depending on which of the drivers was used as an example for the 
> > > other. That is hardly a good enough reason to keep them different and as 
> > > long as each driver keeps its own function for this, it will eventually 
> > > lead to similar differentiation so e.g. a one-time band-aid similarization 
> > > would not help in the long run.
> > >
> > > Also, I don't understand why you see it unreadable when the actual code is 
> > > out in the open in that macro. It's formatted much better than e.g. 
> > > read_poll_timeout() if you want an example of something that is hardly 
> > > readable ;-). I agree though there's a learning-curve, albeit small, that 
> > > it actually creates a function but that doesn't seem to me as big of an 
> > > obstacle you seem to think.
> > 
> > I think it would help to replace the macro that defines
> > the function with a set of macros that can be used in
> > function bodies. This would avoid the __VA_ARGS__ stuff
> > and allow readers that are unfamiliar with tty drivers to
> > treat it as a function call.
> > 
> > So e.g. instead of 
> > 
> > static DEFINE_UART_PORT_TX_HELPER_LIMITED(altera_jtaguart_do_tx_chars,
> > 		true,
> > 		writel(ch, port->membase + ALTERA_JTAGUART_DATA_REG),
> > 		({}));
> > 
> > the altera_jtaguart driver would contain a function like
> > 
> > static int altera_jtaguart_do_tx_chars(struct uart_port *port,
> >                                        unsigned int count)
> > {
> >        char ch;
> > 
> >        return uart_port_tx_helper_limited(port, ch, count, true,
> >                 writel(ch, port->membase + ALTERA_JTAGUART_DATA_REG),
> >                 ({}));
> > }
> > 
> > or some variation of that. It's a few more lines, but those
> > extra lines would help me understand what is actually going on
> > while still avoiding the usual bugs and duplication.
> > 
> > If the caller of that function is itself trivial (like
> > serial21285_tx_chars), then the intermediate function can
> > be omitted in order to save some of the extra complexity.
> 
> I'd be ok with that. There's still a small startle factor associated to 
> passing that writel(...) as an argument to a "function" but it's the same 
> for other things such as read_poll_timeout() so not an end of the world.

That's going to incure the function-pointer-indirection-call for every
character that Jiri's original submission had, so I don't think this is
a very viable solution, sorry.

thanks,

greg k-h
