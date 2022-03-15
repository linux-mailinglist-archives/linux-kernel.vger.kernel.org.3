Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A6A4D968E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346083AbiCOIol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346089AbiCOIoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:44:37 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311642607;
        Tue, 15 Mar 2022 01:43:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id B2C74DF955;
        Tue, 15 Mar 2022 01:43:17 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id l4rAMarCJxh5; Tue, 15 Mar 2022 01:43:16 -0700 (PDT)
Message-ID: <a66bd7ff8356cc0d97073ae41d128eabb74cc94d.camel@puri.sm>
Subject: Re: [PATCH] usb: xhci: make XHCI_STOP_EP_CMD_TIMEOUT a module
 parameter
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     mathias.nyman@intel.com, kernel@puri.sm, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 15 Mar 2022 09:43:12 +0100
In-Reply-To: <60227688-4435-516d-2525-b31fabbef273@linux.intel.com>
References: <20220304113057.1477958-1-martin.kepplinger@puri.sm>
         <YiIfZFPl9ZqPBKvj@kroah.com>
         <835b3990-43a6-a985-81b4-b86bddfe951f@linux.intel.com>
         <2d439eec0548361669bcc7b4de5b2c0e966d4d62.camel@puri.sm>
         <efd900656e15eac9169ee597ab7c19986c15277c.camel@puri.sm>
         <60227688-4435-516d-2525-b31fabbef273@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, dem 09.03.2022 um 11:29 +0200 schrieb Mathias Nyman:
> On 9.3.2022 9.56, Martin Kepplinger wrote:
> > Am Dienstag, dem 08.03.2022 um 17:17 +0100 schrieb Martin
> > Kepplinger:
> > > Am Montag, dem 07.03.2022 um 10:49 +0200 schrieb Mathias Nyman:
> > > > On 4.3.2022 16.17, Greg KH wrote:
> > > > > On Fri, Mar 04, 2022 at 12:30:57PM +0100, Martin Kepplinger
> > > > > wrote:
> > > > > > On the Librem 5 imx8mq system we've seen the stop endpoint
> > > > > > command
> > > > > > time out regularly which results in the hub dying.
> > > > > > 
> > > > > > While on the one hand we see "Port resume timed out, port
> > > > > > 1-1:
> > > > > > 0xfe3"
> > > > > > before this and on the other hand driver-comments suggest
> > > > > > that
> > > > > > the driver
> > > > > > might be able to recover instead of dying here, Sarah
> > > > > > seemed to
> > > > > > have a
> > > > > > workaround for this particulator problem in mind already:
> > > > > > 
> > > > > > Make it a module parameter. So while it might not be the
> > > > > > root
> > > > > > cause for
> > > > > > the problem, do this to give users a workaround.
> > > > > 
> > > > > This is not the 1990's, sorry, please do not add new module
> > > > > parameters.
> > > > > They modify code, when you want to modify an individual
> > > > > device.
> > > > > 
> > > > 
> > > > Agree, I think we really need to find the rootcause here.
> > > > 
> > > > There's a known problem with this stop endpoint timeout timer.
> > > > 
> > > > For all other commands we start the timer when the controller
> > > > starts
> > > > processing the
> > > > command, but the stop endpoint timer is started immediately
> > > > when
> > > > command is queued.
> > > > So it might timeout if some other commend before it failed.
> > > > 
> > > > I have a patchseries for this. It's still work in progress but
> > > > should
> > > > be testable.
> > > > Pushed to a branch named stop_endpoint_fixes
> > > > 
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git
> > > > stop_endpoint_fixes
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=stop_endpoint_fixes
> > > > 
> > > > Can you try it out and see if it helps?
> > > > 
> > > 
> > > thanks a lot Mathias, I'm running these now. The timeout has not
> > > been
> > > easy to reproduce (or I'm just lazy) but in a few days I should
> > > be
> > > able
> > > to tell whether that helps.
> > > 
> > > So this thread has been about
> > > 
> > > [14145.960512] xhci-hcd xhci-hcd.4.auto: Port resume timed out,
> > > port
> > > 1-
> > > 1: 0xfe3
> > > [14156.308511] xhci-hcd xhci-hcd.4.auto: xHCI host not responding
> > > to
> > > stop endpoint command.
> > > 
> > > that I previously tried to work around by increasing
> > > XHCI_MAX_REXIT_TIMEOUT_MS and XHCI_STOP_EP_CMD_TIMEOUT.
> > > 
> > > 
> > > These patches can't help with the following, right?
> > > readl_poll_timeout_atomic() with a fixed timeout is called in
> > > this
> > > case:
> > > 
> > > xhci-hcd xhci-hcd.4.auto: Abort failed to stop command ring: -110
> > > 
> > > I see that too from time to time. It results in the HC dying as
> > > well.
> > > 
> > > thanks,
> > >                               martin
> > > 
> > 
> > hi Mathias,
> > 
> > I already saw "Port resume timed out" and the HC dying running your
> > patches. I append the logs.
> > 
> > So for now I saw more success with increasing
> > XHCI_MAX_REXIT_TIMEOUT_MS.
> > 
> 
> XHCI_MAX_REXIT_TIMEOUT_MS is only 20ms, that we can probably change.
> 
> Is 40ms enough?
> 
> "Port resume timed out, port 1-1: 0xfe3" means port link state is
> still in
> resume even if we asked link to go to U0 20ms ago.
> 
> Maybe this hw combination just resumes slowly.
> 
> Thanks
> Mathias


hi Mathias, sorry for not responding until now. I'm currently testing
whether QUIRK_HUB_SLOW_RESET will work too to avoid the HC dying due to
the command timeouts:

{ USB_DEVICE(0x0424, 0x2640), .driver_info = USB_QUIRK_HUB_SLOW_RESET
},

But these timeouts usually happen after a port is reset (not just
runtime-resumed without resetting, which happens very often).

And exactly *that* is what I now want to try to avoid now. I *never*
want ports on the Hub in question to be reset. (it causes enough other
hick-ups even *if* the reset would be successful and not result in the
HC die, so all resets need to go away).

Normally, on successful runtime resume (without any reset), the hub
port status is:

Mär 15 08:24:44.748852 pureos kernel: usb 1-1-port2: status 0503 change
0004
Mär 15 08:24:44.747863 pureos kernel: usb 1-1-port1: status 0507 change
0000

But when the following happens:

Mär 15 08:24:52.660348 pureos kernel: usb 1-1-port2: status 0101 change
0005
Mär 15 08:24:52.656107 pureos kernel: usb 1-1-port1: status 0507 change
0000

then hub_activate() sets "reset_resume" (persist is enabled) and it's
too late :)

Do you have an idea about what could be the cause for "status 0101"
here? (it basically means ENABLE and HIGH_SPEED is not set, but why?)

I know this is a bit of a different area now, but it's all about
avoiding problems on that hub at runtime.

thanks,

                                 martin


