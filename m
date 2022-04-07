Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1107C4F848E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345648AbiDGQJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345784AbiDGQIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:08:07 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id DCCF9DE0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:06:02 -0700 (PDT)
Received: (qmail 226674 invoked by uid 1000); 7 Apr 2022 12:06:01 -0400
Date:   Thu, 7 Apr 2022 12:06:01 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Maxim Devaev <mdevaev@gmail.com>
Cc:     linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cai Huoqing <caihuoqing@baidu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_mass_storage: break IO operations via
 configfs
Message-ID: <Yk8L6b9wEWTjWOg4@rowland.harvard.edu>
References: <20220406092445.215288-1-mdevaev@gmail.com>
 <Yk2wvhSTMKTLFK6c@rowland.harvard.edu>
 <20220406195234.4f63cb4a@reki>
 <Yk3TLPKyaQDsnuD4@rowland.harvard.edu>
 <20220406213634.104cae45@reki>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220406213634.104cae45@reki>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 09:36:34PM +0300, Maxim Devaev wrote:
> В Wed, 6 Apr 2022 13:51:40 -0400
> Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > On Wed, Apr 06, 2022 at 07:52:34PM +0300, Maxim Devaev wrote:
> > > > It's not clear to me how breaking I/O operations allows you to do a 
> > > > "force eject".  It seems that what you would need is something like 
> > > > fsg_store_file() that omits the curlun->prevent_medium_removal check.
> > > > Interrupting a lengthy I/O operation doesn't really have anything to do 
> > > > with this.  
> > > 
> > > Perhaps I chose the wrong path, it's just how my userspace code works now.
> > > If the drive is connected to a Linux host, then in order to clear
> > > the "file" and extract the image, I sent a SIGUSR1 signal to the "file-storage"
> > > thread. This interrupted long IO operations, reset curlun->prevent_medium_removal
> > > and I got the ability to extract.  
> > 
> > Oh, I see.  That's kind of an unintended side effect of not calling 
> > raise_exception().
> > 
> > And while it does interrupt long I/O operations, it does so in 
> > non-sanctioned way.  To the host it will appear as though the gadget's 
> > firmware has crashed, since the gadget will stop sending or receiving 
> > data.  Eventually the host will time out and reset the gadget.
> > 
> > Maybe that's the sort of thing you want, but I rather doubt it.
> 
> It's hard to say how it actually should work in case of force removing.
> At least the currect approach with SIGUSR1 is really working on thousands
> systems and with Linux, Mac and Windows. I believe that the criterion
> of the experiment is quite important here. I know of several other utilities
> that use SIGUSR1 for similar purposes.

This merely means that the current unintended behavior of userspace USR1 
signals must not be changed.  But it doesn't mean you have to continue 
to rely on that behavior; you can implement something better.

> > > Will masking the curlun->prevent_medium_removal flag be enough?  
> > 
> > I think so.  But it will be blocked to some extent by long-running I/O 
> > operations, because those operations acquire the filesem rw-semaphore 
> > for reading.
> > 
> > More precisely, each individual command holds the rw-semaphore.  But the 
> > semaphore is dropped between commands, and a long-running I/O operation 
> > typically consists of many separate commands.  So the blocking may be 
> > acceptable.
> 
> It is very important for KVM-over-IP to be able to command "turn it off immediately".

Why is this?  A lot of actual devices (DVD drives, for instance) don't 
give you the ability to eject the media when the host has prevented it.  
Why should f-mass-storage be different?

> In this context, I would prefer "break_io" rather than "allow_force_remove".

Okay.  But what about the 30-second host timeout I mentioned above?  
Does this actually happen with your approach?  It seems like the kind of 
thing you don't want in a "turn it off immediately" situation.  (I 
haven't tried doing this myself -- maybe I should.)

> > > > You should not call send_sig_info() directly; instead call 
> > > > raise_exception().  It already does the work you need (including some 
> > > > things you left out).  
> > > 
> > > raise_exception() assumes the setting of a new state, and I did not want to do this,
> > > since the same does not happen when throwing a signal from userspace.  
> > 
> > Userspace isn't supposed to send the USR1 signal, only the INT, TERM, or 
> > KILL signals.  USR1 is supposed to be reserved for the driver's internal 
> > use.  Unfortunately, AFAIK there's no way to allow the driver to send a 
> > signal to itself without also allowing the signal to be sent by 
> > userspace.  :-(
> 
> It's funny that you actually helped me solve my problem thanks to this undocumented
> behavior. If it were not for the ability to send a signal, I would not be able to make
> the necessary code, and my software would always be waiting for the completion of IO.
> 
> So here I am grateful to you - I didn't have to patch the kernel a few years ago,
> and now I just want to turn it into a clear feature :)
> 
> Given the needs of the userspace code, maybe the suggested "break_io"
> would be the best choice?

It sounds like what you really want is a combination of both "interrupt 
I/O" and "forced eject".

> > And sending the signal _does_ set a new state, whether you intended to 
> > or not.  Although in this case, the new state is always the same as the 
> > old state, i.e., FSG_STATE_NORMAL.
> 
> So I could call raise_exception(fsg->common, FSG_STATE_NORMAL) instead of sending
> the signal from break_io handler. There will be a slight difference
> in exception_req_tag and exception_arg, but it does not seem to cause any side effects.
> Please correct me if I'm wrong.

In fact, the best approach would be to introduce a new state (let's call 
it FSG_STATE_FORCED_EJECT) with priority just above
FSG_STATE_ABORT_BULK_OUT.  You would call raise_exception with 
FSG_STATE_FORCED_EJECT, not FSG_STATE_NORMAL.  handle_exceptions() would 
treat this state partially like ABORT_BULK_OUT in that it would avoid 
resetting all the LUN data values and would call send_status_common() if 
a command had been underway.  But in addition it would do the forced 
eject.

Also, the sysfs routine should be careful to see whether the command 
currently being executed is for the LUN being ejected.  I guess you 
have never tried issuing your USR1 signal to a mass-storage gadget 
running more than one LUN.  If you did, you would find that it clears 
the prevent_medium_removal flag for all of them, not just the one that 
you wanted.

Alan Stern
