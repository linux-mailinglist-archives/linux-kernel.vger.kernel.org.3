Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B269E4F6AEA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbiDFULd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbiDFUK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:10:57 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 821741B60E2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 10:51:41 -0700 (PDT)
Received: (qmail 195999 invoked by uid 1000); 6 Apr 2022 13:51:40 -0400
Date:   Wed, 6 Apr 2022 13:51:40 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Maxim Devaev <mdevaev@gmail.com>
Cc:     linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cai Huoqing <caihuoqing@baidu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_mass_storage: break IO operations via
 configfs
Message-ID: <Yk3TLPKyaQDsnuD4@rowland.harvard.edu>
References: <20220406092445.215288-1-mdevaev@gmail.com>
 <Yk2wvhSTMKTLFK6c@rowland.harvard.edu>
 <20220406195234.4f63cb4a@reki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406195234.4f63cb4a@reki>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 07:52:34PM +0300, Maxim Devaev wrote:
> > It's not clear to me how breaking I/O operations allows you to do a 
> > "force eject".  It seems that what you would need is something like 
> > fsg_store_file() that omits the curlun->prevent_medium_removal check.
> > Interrupting a lengthy I/O operation doesn't really have anything to do 
> > with this.
> 
> Perhaps I chose the wrong path, it's just how my userspace code works now.
> If the drive is connected to a Linux host, then in order to clear
> the "file" and extract the image, I sent a SIGUSR1 signal to the "file-storage"
> thread. This interrupted long IO operations, reset curlun->prevent_medium_removal
> and I got the ability to extract.

Oh, I see.  That's kind of an unintended side effect of not calling 
raise_exception().

And while it does interrupt long I/O operations, it does so in 
non-sanctioned way.  To the host it will appear as though the gadget's 
firmware has crashed, since the gadget will stop sending or receiving 
data.  Eventually the host will time out and reset the gadget.

Maybe that's the sort of thing you want, but I rather doubt it.

> It was done in our KVM-over-IP project and worked for several years,
> just now I want to do it without searching for procfs and the need
> to use sudo helpers like this:
> https://github.com/pikvm/kvmd/blob/1b3a2cc/kvmd/helpers/otgmsd/unlock/__init__.py
> 
> Maybe it's worth introducing some option that will allow us to ignore
> curlun->prevent_medium_removal and perform a forced extraction?
> Something like "allow_force_eject" on the same lavel with "stall".

Or have a separate sysfs file where any write at all will be interpreted 
as a forced eject.  Either way would work.

> Will masking the curlun->prevent_medium_removal flag be enough?

I think so.  But it will be blocked to some extent by long-running I/O 
operations, because those operations acquire the filesem rw-semaphore 
for reading.

More precisely, each individual command holds the rw-semaphore.  But the 
semaphore is dropped between commands, and a long-running I/O operation 
typically consists of many separate commands.  So the blocking may be 
acceptable.

> > Or to keep this ability restricted to the superuser, if that is desired.
> 
> Indeed.
> 
> > You should not call send_sig_info() directly; instead call 
> > raise_exception().  It already does the work you need (including some 
> > things you left out).
> 
> raise_exception() assumes the setting of a new state, and I did not want to do this,
> since the same does not happen when throwing a signal from userspace.

Userspace isn't supposed to send the USR1 signal, only the INT, TERM, or 
KILL signals.  USR1 is supposed to be reserved for the driver's internal 
use.  Unfortunately, AFAIK there's no way to allow the driver to send a 
signal to itself without also allowing the signal to be sent by 
userspace.  :-(

And sending the signal _does_ set a new state, whether you intended to 
or not.  Although in this case, the new state is always the same as the 
old state, i.e., FSG_STATE_NORMAL.

Alan Stern
