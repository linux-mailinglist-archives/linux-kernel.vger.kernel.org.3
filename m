Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D8F4D1D02
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348245AbiCHQS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348143AbiCHQSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:18:55 -0500
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607D2DFC4;
        Tue,  8 Mar 2022 08:17:58 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id D30ABE0076;
        Tue,  8 Mar 2022 08:17:27 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id I5-U4puZBtsc; Tue,  8 Mar 2022 08:17:27 -0800 (PST)
Message-ID: <2d439eec0548361669bcc7b4de5b2c0e966d4d62.camel@puri.sm>
Subject: Re: [PATCH] usb: xhci: make XHCI_STOP_EP_CMD_TIMEOUT a module
 parameter
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     mathias.nyman@intel.com, kernel@puri.sm, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 08 Mar 2022 17:17:23 +0100
In-Reply-To: <835b3990-43a6-a985-81b4-b86bddfe951f@linux.intel.com>
References: <20220304113057.1477958-1-martin.kepplinger@puri.sm>
         <YiIfZFPl9ZqPBKvj@kroah.com>
         <835b3990-43a6-a985-81b4-b86bddfe951f@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, dem 07.03.2022 um 10:49 +0200 schrieb Mathias Nyman:
> On 4.3.2022 16.17, Greg KH wrote:
> > On Fri, Mar 04, 2022 at 12:30:57PM +0100, Martin Kepplinger wrote:
> > > On the Librem 5 imx8mq system we've seen the stop endpoint
> > > command
> > > time out regularly which results in the hub dying.
> > > 
> > > While on the one hand we see "Port resume timed out, port 1-1:
> > > 0xfe3"
> > > before this and on the other hand driver-comments suggest that
> > > the driver
> > > might be able to recover instead of dying here, Sarah seemed to
> > > have a
> > > workaround for this particulator problem in mind already:
> > > 
> > > Make it a module parameter. So while it might not be the root
> > > cause for
> > > the problem, do this to give users a workaround.
> > 
> > This is not the 1990's, sorry, please do not add new module
> > parameters.
> > They modify code, when you want to modify an individual device.
> > 
> 
> Agree, I think we really need to find the rootcause here.
> 
> There's a known problem with this stop endpoint timeout timer.
> 
> For all other commands we start the timer when the controller starts
> processing the
> command, but the stop endpoint timer is started immediately when
> command is queued.
> So it might timeout if some other commend before it failed.
> 
> I have a patchseries for this. It's still work in progress but should
> be testable.
> Pushed to a branch named stop_endpoint_fixes
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git
> stop_endpoint_fixes
> https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=stop_endpoint_fixes
> 
> Can you try it out and see if it helps?
> 

thanks a lot Mathias, I'm running these now. The timeout has not been
easy to reproduce (or I'm just lazy) but in a few days I should be able
to tell whether that helps.

So this thread has been about

[14145.960512] xhci-hcd xhci-hcd.4.auto: Port resume timed out, port 1-
1: 0xfe3
[14156.308511] xhci-hcd xhci-hcd.4.auto: xHCI host not responding to
stop endpoint command.

that I previously tried to work around by increasing
XHCI_MAX_REXIT_TIMEOUT_MS and XHCI_STOP_EP_CMD_TIMEOUT.


These patches can't help with the following, right?
readl_poll_timeout_atomic() with a fixed timeout is called in this
case:

xhci-hcd xhci-hcd.4.auto: Abort failed to stop command ring: -110

I see that too from time to time. It results in the HC dying as well.

thanks,
                              martin

