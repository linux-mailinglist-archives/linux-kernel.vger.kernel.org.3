Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E9751158A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbiD0LJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbiD0LId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:08:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834EE2E97BE;
        Wed, 27 Apr 2022 04:04:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D6BDB825C9;
        Wed, 27 Apr 2022 09:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E6EC385A7;
        Wed, 27 Apr 2022 09:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651052236;
        bh=FaaTt9JdhlJnKcF7blPYJLnYl5SWCRiX+UvFNXe8R6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vkf8G3wXUTN1QsedhJ45hr3IatTk0lTNSy+w9IF++SO4fwGvpCMFQfQa7Gv0w+FuF
         rfn6jmjKUIuOGMM0YF2i7S+62XuK5vpD7CAE/D+cqXXEDBIcB3XALWOvFlQb17h/y6
         8wHLoIgD2G2qSpGSdFDmXZKG3E+yhfJmofQpsThM=
Date:   Wed, 27 Apr 2022 11:37:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jung Daehwan <dh10.jung@samsung.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v4 4/5] usb: host: add some to xhci overrides for
 xhci-exynos
Message-ID: <YmkOyDT+ejWMHB7k@kroah.com>
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220426092022epcas2p2c016c83b21e41c7bcd4bdfbb95e464c0@epcas2p2.samsung.com>
 <1650964728-175347-5-git-send-email-dh10.jung@samsung.com>
 <YmfIIo6d1CkhkQS3@kroah.com>
 <20220427091901.GC145620@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427091901.GC145620@ubuntu>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 06:19:01PM +0900, Jung Daehwan wrote:
> On Tue, Apr 26, 2022 at 12:23:30PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Apr 26, 2022 at 06:18:47PM +0900, Daehwan Jung wrote:
> > > Co-processor needs some information about connected usb device.
> > > It's proper to pass information after usb device gets address when
> > > getting "Set Address" command. It supports vendors to implement it
> > > using xhci overrides. There're several power scenarios depending
> > > on vendors. It gives vendors flexibilty to meet their power requirement.
> > > They can override suspend and resume of root hub.
> > > 
> > > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> > > ---
> > >  drivers/usb/host/xhci.c | 6 ++++++
> > >  drivers/usb/host/xhci.h | 4 ++++
> > >  2 files changed, 10 insertions(+)
> > > 
> > > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > > index 5ccf1bbe8732..8b3df1302650 100644
> > > --- a/drivers/usb/host/xhci.c
> > > +++ b/drivers/usb/host/xhci.c
> > > @@ -5555,6 +5555,12 @@ void xhci_init_driver(struct hc_driver *drv,
> > >  			drv->check_bandwidth = over->check_bandwidth;
> > >  		if (over->reset_bandwidth)
> > >  			drv->reset_bandwidth = over->reset_bandwidth;
> > > +		if (over->address_device)
> > > +			drv->address_device = over->address_device;
> > > +		if (over->bus_suspend)
> > > +			drv->bus_suspend = over->bus_suspend;
> > > +		if (over->bus_resume)
> > > +			drv->bus_resume = over->bus_resume;
> > >  	}
> > >  }
> > >  EXPORT_SYMBOL_GPL(xhci_init_driver);
> > > diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> > > index 3a414a2f41f0..5bc621e77762 100644
> > > --- a/drivers/usb/host/xhci.h
> > > +++ b/drivers/usb/host/xhci.h
> > > @@ -1947,6 +1947,9 @@ struct xhci_driver_overrides {
> > >  			     struct usb_host_endpoint *ep);
> > >  	int (*check_bandwidth)(struct usb_hcd *, struct usb_device *);
> > >  	void (*reset_bandwidth)(struct usb_hcd *, struct usb_device *);
> > > +	int (*address_device)(struct usb_hcd *hcd, struct usb_device *udev);
> > > +	int (*bus_suspend)(struct usb_hcd *hcd);
> > > +	int (*bus_resume)(struct usb_hcd *hcd);
> > >  };
> > >  
> > >  #define	XHCI_CFC_DELAY		10
> > > @@ -2103,6 +2106,7 @@ int xhci_drop_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
> > >  		       struct usb_host_endpoint *ep);
> > >  int xhci_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev);
> > >  void xhci_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev);
> > > +int xhci_address_device(struct usb_hcd *hcd, struct usb_device *udev);
> > 
> > You do not use this function in this change, why include it in here?
> > 
> > Please reorganize your patch series to only include what you need for
> > each step, as-is it's kind of out-of-order and might not build at each
> > step along the way (or it might, it's hard to determine...)
> > 
> 
> This patch is to add function pointers. xhci-exynos or other user could use it.

But this commit has nothing to do with xhci_address_device(), why add it
to the .h file here?

> If I reorganize them as you said, all patches depend on xhci-exynos.

Of course, we need real users of the functions you export, otherwise
they do not need to be exported.

You can export them in one commit, and then use them in the next, but
that's not what you are doing here at all.  You have a mix of .c and .h
changes across different commits that are not coordinated at all.

> That's because hooks and override are only used in xhci-exynos for now.
> I don't want user driver effects common files like xhci platform.
> I've tried removing dependancies.. That's why I split patches like that.

Splitting patches is the correct way, just do it so that it makes sense.
As you can see by the kbuild reports, what you have here is not correct.

thanks,

greg k-h
