Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F82347CF2D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243906AbhLVJZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243899AbhLVJZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:25:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908C3C061574;
        Wed, 22 Dec 2021 01:25:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F36FD61940;
        Wed, 22 Dec 2021 09:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E97BC36AE8;
        Wed, 22 Dec 2021 09:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640165133;
        bh=BNhr6yaAR52+M0GJ5JUkDKxBOuQ2SF9yp85aaKzXNrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j2FzncqI0YBT3hkF1xRTjB90eztT+BtzqFkEPU7/x3QhHRCW35fUxQj4CSecyZ24J
         vnNlocqgtVrC3pm6ah4zTECU2lva/nPZ1KhYf5+TJzo1K436PwGdLqVJJL9rMGFnq6
         eIE3DwW6sHmoIpIo5E/6ia0SvhkBK0OTYdXoz8jQ=
Date:   Wed, 22 Dec 2021 10:25:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: renesas_usbhs: Fix unused variable warning
Message-ID: <YcLvCtFwxoSeh2zs@kroah.com>
References: <20211221171532.29881-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <YcLBZBwIZkhhKxGD@kroah.com>
 <CA+V-a8s1RzonxKf2PbitTmb88WKKW9eSiZPsdHO6=-vxww7LFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8s1RzonxKf2PbitTmb88WKKW9eSiZPsdHO6=-vxww7LFQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 09:01:03AM +0000, Lad, Prabhakar wrote:
> Hi Greg,
> 
> Thank you for the review.
> 
> On Wed, Dec 22, 2021 at 6:10 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Dec 21, 2021 at 05:15:32PM +0000, Lad Prabhakar wrote:
> > > This patch fixes the below warning:
> > >
> > > drivers/usb/renesas_usbhs/mod.c: In function 'usbhs_status_get_each_irq':
> > > drivers/usb/renesas_usbhs/mod.c:195:13: warning: variable 'intenb0'
> > > set but not used [-Wunused-but-set-variable]
> > >   195 |         u16 intenb0, intenb1;
> > >       |
> > >
> > > Fixes: 33e4245ee919 ("usb: renesas_usbhs: Use platform_get_irq() to get the interrupt")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > >  drivers/usb/renesas_usbhs/mod.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/usb/renesas_usbhs/mod.c b/drivers/usb/renesas_usbhs/mod.c
> > > index f2ea3e1412d2..3919e350b487 100644
> > > --- a/drivers/usb/renesas_usbhs/mod.c
> > > +++ b/drivers/usb/renesas_usbhs/mod.c
> > > @@ -192,13 +192,12 @@ static int usbhs_status_get_each_irq(struct usbhs_priv *priv,
> > >                                    struct usbhs_irq_state *state)
> > >  {
> > >       struct usbhs_mod *mod = usbhs_mod_get_current(priv);
> > > -     u16 intenb0, intenb1;
> > >       unsigned long flags;
> > > +     u16 intenb1;
> > >
> > >       /********************  spin lock ********************/
> > >       usbhs_lock(priv, flags);
> > >       state->intsts0 = usbhs_read(priv, INTSTS0);
> > > -     intenb0 = usbhs_read(priv, INTENB0);
> >
> > Did you just break the hardware?  Reading is often times needed and
> > clang has no idea about hardware issues.  We need proof in the changlog
> > that this really is safe to do.
> >
> I introduced this warning in commit 33e4245ee919 ("usb: renesas_usbhs:
> Use platform_get_irq() to get the interrupt'') where
> IORESOURCE_IRQ_SHAREABLE flag handling was dropped and I missed to
> remove this change. As a result I included a fixes tag for this
> commit. Let me know if you want me to update the changelog.

Yes please explain why this change is ok, not just that it is a random
compiler warning cleanup.

> > How did you test your change?
> >
> I haven't but can test it.

Please do.

thanks,

greg k-h
