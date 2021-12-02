Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D94D4665C9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358801AbhLBOwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358641AbhLBOwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:52:38 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE3CC06174A;
        Thu,  2 Dec 2021 06:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=TENbFU3VPoZmYB532OJ5heIU8WiCFPnyDoknW+eBIAs=; b=u/RFN
        igsiYs4KEY8kg4EOvk3QRD+ebpGHt0dj7glb360pL8HLJi8WIhp9GH8G58NU9z5m0uT3joBm/vWD3
        FebZFiLGB4KoOXlMgL6wO7kHd/S//PefNmB7BpUkweDfy7p+uCV1aklvnVfr1zZbZ4hutZoISh5yg
        stbSsqaVI3jlvzSepptn36teVgW9Zt5qMc8511JOhu7lJQpzwvaAiWtAusqtdz/pxBGy53VBGrLlL
        PUO7mZ5gOvCXrH+RNFg/4gF5nvh1q29o6tziahe9ARcB6gHVBFFMQYA/4kgUzhS71B3pyvpLstQ3r
        ciB7wqki9iwrbCQC4xn81UPOrXXKA==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1msnOY-0000PP-Dh; Thu, 02 Dec 2021 14:49:10 +0000
Date:   Thu, 2 Dec 2021 14:49:09 +0000
From:   John Keeping <john@metanate.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_jackp@quicinc.com
Subject: Re: [PATCH] usb: gadget: f_fs: Wake up IO thread during disconnect
Message-ID: <Yajc5f3LDm+dSji/@donbot>
References: <20211201100205.25448-1-quic_wcheng@quicinc.com>
 <YaelpmsJXmhTY4A0@donbot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaelpmsJXmhTY4A0@donbot>
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 04:41:10PM +0000, John Keeping wrote:
> On Wed, Dec 01, 2021 at 02:02:05AM -0800, Wesley Cheng wrote:
> > During device disconnect or composition unbind, applications should be
> > notified that the endpoints are no longer enabled, so that it can take
> > the proper actions to handle its IO threads.  Otherwise, they can be
> > left waiting for endpoints until EPs are re-enabled.
> > 
> > Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> > ---
> >  drivers/usb/gadget/function/f_fs.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> > index 3c584da9118c..0b0747d96378 100644
> > --- a/drivers/usb/gadget/function/f_fs.c
> > +++ b/drivers/usb/gadget/function/f_fs.c
> > @@ -957,10 +957,12 @@ static ssize_t ffs_epfile_io(struct file *file, struct ffs_io_data *io_data)
> >  		if (file->f_flags & O_NONBLOCK)
> >  			return -EAGAIN;
> >  
> > -		ret = wait_event_interruptible(
> > -				epfile->ffs->wait, (ep = epfile->ep));
> > +		ret = wait_event_interruptible(epfile->ffs->wait,
> > +				(ep = epfile->ep) || !epfile->ffs->func);

I looked at this again, and doesn't this totally break the wait
condition?

epfile->ep is set to non-null in ffs_func_eps_enable() which is called
from ffs_func_set_alt() just after ffs->func is set to non-null, and
then those are also set back to null at the same time.

So the condition boils down to a || !a and this never blocks.  Or am I
missing something?

> >  		if (ret)
> >  			return -EINTR;
> > +		if (!epfile->ffs->func)
> > +			return -ENODEV;
> 
> This seems strange - we are inside the case where the endpoint is not
> initially enabled, if we're returning ENODEV here shouldn't that happen
> in all cases?
> 
> Beyond that, there is no locking for accessing ffs->func here;
> modification happens in gadget callbacks so it's guarded by the gadget
> core (the existing case in ffs_ep0_ioctl() looks suspicious as well).
> 
> But I can't see why this change is necessary - there are event
> notifications through ep0 when this happens, as can be seen in the hunk
> below from the ffs_event_add(ffs, FUNCTIONFS_DISABLE) line.  If
> userspace cares about this, then it can read the events from ep0.
> 
> >  	}
> >  
> >  	/* Do we halt? */
> > @@ -3292,6 +3294,7 @@ static int ffs_func_set_alt(struct usb_function *f,
> >  	if (alt == (unsigned)-1) {
> >  		ffs->func = NULL;
> >  		ffs_event_add(ffs, FUNCTIONFS_DISABLE);
> > +		wake_up_interruptible(&ffs->wait);
> >  		return 0;
> >  	}
> >  
