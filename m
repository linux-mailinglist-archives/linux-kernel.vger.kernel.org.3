Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5FE4811B1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 11:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239751AbhL2Kh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 05:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhL2Kh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 05:37:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F5DC061574;
        Wed, 29 Dec 2021 02:37:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47569B81853;
        Wed, 29 Dec 2021 10:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5778DC36AE7;
        Wed, 29 Dec 2021 10:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640774246;
        bh=Saf54E+TsW0X/GrHGniSHEIhZq7hY7EkFszXYncEcnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=olGEBpimCE+KHpaaosSKZXrLonJZ7k1RwflWzsrnk6wWUxpefEWfzR4P5+0eeUFU4
         XFnD+fNX6ASEy8EmSPyeC5loV5e3vb3fa3G2Hny21L0A6y0wiQtzkVQ+ccSSlf1rzC
         52P5yfHCd+q3zhCOt7QtfWq2Gpbmq5QCXsjTaGWM=
Date:   Wed, 29 Dec 2021 11:37:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Puma Hsu <pumahsu@google.com>
Cc:     mathias.nyman@intel.com, Albert Wang <albertccwang@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xhci: re-initialize the HC during resume if HCE was set
Message-ID: <Ycw6Y8qrLZEat749@kroah.com>
References: <20211228060246.2958070-1-pumahsu@google.com>
 <YcrKNP4TRXB6nsCI@kroah.com>
 <CAGCq0Lb8ZoGpbkLNhXG=OyWgvz_Qn3ABmq_uvMPJdyEKygMH+Q@mail.gmail.com>
 <YcwclrVzEXRxgUFa@kroah.com>
 <CAGCq0LbfWt2xTmRczhdZUXrwFTJdaMH3Zd-y4quqWi7kyaso6Q@mail.gmail.com>
 <Ycwvm5rdqVW4E27y@kroah.com>
 <CAGCq0LZc9Leh=oEiA2hPrpK9OBO+bnRR6hENr+emgFWGsaB0Yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGCq0LZc9Leh=oEiA2hPrpK9OBO+bnRR6hENr+emgFWGsaB0Yg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 06:21:05PM +0800, Puma Hsu wrote:
> On Wed, Dec 29, 2021 at 5:51 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Dec 29, 2021 at 05:11:47PM +0800, Puma Hsu wrote:
> > > On Wed, Dec 29, 2021 at 4:30 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > A: http://en.wikipedia.org/wiki/Top_post
> > > > Q: Were do I find info about this thing called top-posting?
> > > > A: Because it messes up the order in which people normally read text.
> > > > Q: Why is top-posting such a bad thing?
> > > > A: Top-posting.
> > > > Q: What is the most annoying thing in e-mail?
> > > >
> > > > A: No.
> > > > Q: Should I include quotations after my reply?
> > > >
> > > > http://daringfireball.net/2007/07/on_top
> > > >
> > > > On Wed, Dec 29, 2021 at 01:53:04PM +0800, Puma Hsu wrote:
> > > > > This commit is not used to fix a specific commit. We find a condition
> > > > > that when XHCI runs the resume process but the HCE flag is set, then
> > > > > the Run/Stop bit of USBCMD cannot be set so that HC would not be
> > > > > enabled. In fact, HC may already meet a problem at this moment.
> > > > > Besides, in xHCI requirements specification revision 1.2, Table 5-21
> > > > > BIT(12) claims that Software should re-initialize the xHC when HCE is
> > > > > set. Therefore, I think this commit could be the error handling for
> > > > > HCE.
> > > >
> > > > So this does not actually fix an issue that you have seen in any device
> > > > or testing?  So it is not relevant for older kernels but just "nice to
> > > > have"?
> > > >
> > > > How did you test this if you can not duplicate the problem?
> > > >
> > >
> > > Yes, we actually see that the HCE may be detected while running xhci_resume
> > > on our product platform, so I'm able to verify this commit can fix
> > > such a condition.
> >
> > Given that your product platform is an older kernel version than 5.17, I
> > think that you also want this in the older kernel releases, so please
> > mark it for stable backporting.
> >
> Thank you for advising.
> Could I know how to do this? Just add "Cc: <stable@vger.kernel.org>"
> to the commit message?

Yes, please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

It should describe this well, if not, please let us know.

thanks,

greg k-h
