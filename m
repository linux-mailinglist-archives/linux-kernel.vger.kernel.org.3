Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8120846765C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243493AbhLCLeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243546AbhLCLe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:34:27 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C232C06173E;
        Fri,  3 Dec 2021 03:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=0RFYGismENxwP+jaxLHTrZjrtbEuIPpeDDZE6JkcEEE=; b=C94QI
        6CBtQh9rKmomxNnpS2FUjsmdr7U2vrhKD/4it5rwf8L1UqhI6f+7l8caHcvj4vheFqw3yg+FAYKOt
        Cb2ET3Mnth7jNKWkqANhYv2Lu3qqaTWZyIXz3d6otAa7bWp9F579UMBPv9/O3ciHga1Ruuk4NhP+Y
        5xpiYw1GgiQMIW/Q9upcv22KjmvdKmeBe0Uon2elAmlsWwih2zva8mJupnDpaAmnrrF7x8VVstrfg
        bugii8JK7n8YD2vIF+V25yUwImIrZJ8s2fx+GGn4+YBxUJvy/HGfpHvBDIIYSxtamMHi023JT3ANu
        8p+CdqGizE7FR8aa2+v5nTsysQQfw==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mt6mB-0002Sr-Vs; Fri, 03 Dec 2021 11:30:52 +0000
Date:   Fri, 3 Dec 2021 11:30:50 +0000
From:   John Keeping <john@metanate.com>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     Wesley Cheng <quic_wcheng@quicinc.com>, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_jackp@quicinc.com
Subject: Re: [PATCH] usb: gadget: f_fs: Wake up IO thread during disconnect
Message-ID: <Yan/6o/0YsaYuUgr@donbot>
References: <20211201100205.25448-1-quic_wcheng@quicinc.com>
 <YaelpmsJXmhTY4A0@donbot>
 <Yajc5f3LDm+dSji/@donbot>
 <dcfb2b21-6ae8-6921-663d-85cb71f3f5ae@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcfb2b21-6ae8-6921-663d-85cb71f3f5ae@codeaurora.org>
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wesley,

On Thu, Dec 02, 2021 at 11:33:40PM -0800, Wesley Cheng wrote:
> On 12/2/2021 6:49 AM, John Keeping wrote:
> > On Wed, Dec 01, 2021 at 04:41:10PM +0000, John Keeping wrote:
> >> On Wed, Dec 01, 2021 at 02:02:05AM -0800, Wesley Cheng wrote:
> >>> During device disconnect or composition unbind, applications should be
> >>> notified that the endpoints are no longer enabled, so that it can take
> >>> the proper actions to handle its IO threads.  Otherwise, they can be
> >>> left waiting for endpoints until EPs are re-enabled.
> >>>
> >>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> >>> ---
> >>>  drivers/usb/gadget/function/f_fs.c | 7 +++++--
> >>>  1 file changed, 5 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> >>> index 3c584da9118c..0b0747d96378 100644
> >>> --- a/drivers/usb/gadget/function/f_fs.c
> >>> +++ b/drivers/usb/gadget/function/f_fs.c
> >>> @@ -957,10 +957,12 @@ static ssize_t ffs_epfile_io(struct file *file, struct ffs_io_data *io_data)
> >>>  		if (file->f_flags & O_NONBLOCK)
> >>>  			return -EAGAIN;
> >>>  
> >>> -		ret = wait_event_interruptible(
> >>> -				epfile->ffs->wait, (ep = epfile->ep));
> >>> +		ret = wait_event_interruptible(epfile->ffs->wait,
> >>> +				(ep = epfile->ep) || !epfile->ffs->func);
> > 
> > I looked at this again, and doesn't this totally break the wait
> > condition?
> > 
> > epfile->ep is set to non-null in ffs_func_eps_enable() which is called
> > from ffs_func_set_alt() just after ffs->func is set to non-null, and
> > then those are also set back to null at the same time.
> > 
> > So the condition boils down to a || !a and this never blocks.  Or am I
> > missing something?
> 
> Thanks for the feedback.  Hmm...yes, I get what you're saying.  The
> EPfiles and func is basically being set/cleared together, so the above
> change wouldn't be any different than checking for ep != epfile->ep.
> Let me see if there's another way we can address the issue this change
> is trying to resolve.
> 
> > 
> >>>  		if (ret)
> >>>  			return -EINTR;
> >>> +		if (!epfile->ffs->func)
> >>> +			return -ENODEV;
> >>
> >> This seems strange - we are inside the case where the endpoint is not
> >> initially enabled, if we're returning ENODEV here shouldn't that happen
> >> in all cases?
> >>
> >> Beyond that, there is no locking for accessing ffs->func here;
> >> modification happens in gadget callbacks so it's guarded by the gadget
> >> core (the existing case in ffs_ep0_ioctl() looks suspicious as well).
> >>
> >> But I can't see why this change is necessary - there are event
> >> notifications through ep0 when this happens, as can be seen in the hunk
> >> below from the ffs_event_add(ffs, FUNCTIONFS_DISABLE) line.  If
> >> userspace cares about this, then it can read the events from ep0.
> >>
> In short, the change is basically trying to resolve an issue in an
> application that has a separate thread handling the IO ops.  When the
> USB cable is disconnected, the application would expect for this IO
> thread to be completed and exit gracefully, and restarting it on the
> next connect.  However, since we are stuck in the read() it can not
> proceed further.

Did you see the other recent thread on FunctionFS [1]?  It seems that
the separate I/O thread is not required and in fact there is a race here
in general even using AIO via io_submit().

[1] https://lore.kernel.org/linux-usb/CAJkDvNk4G3WJuitZa+oPuNhkrCPNiwwG-zyNET+urWVWAda+cw@mail.gmail.com/

> I guess in these situations, we should utilize the O_NONBLOCK file
> parameter?

Yes, using O_NONBLOCK does avoid the problems.

I'm not sure what the general solution is - right now I don't see any
way to resolve the requirements to wait for the host to connect and
handle disconnection without blocking here.

The simplest thing would be to refuse epfile I/O when FunctionFS is not
enabled, which neatly resolves the race in favour of returning an error.
But it means that applications need to wait for a FUNCTIONFS_ENABLE
event on ep0 before submitting any transfers on other endpoints, which
is a change from the current behaviour.  And there's no way to know how
many applications rely on that.

So I don't think that's an option, at least not without providing some
way for userspace to opt in to the new behaviour.
