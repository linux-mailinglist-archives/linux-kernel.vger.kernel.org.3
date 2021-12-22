Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A43747D3E3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 15:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343555AbhLVOqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 09:46:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35638 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343540AbhLVOqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 09:46:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB1BC61A56;
        Wed, 22 Dec 2021 14:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B570C36AE5;
        Wed, 22 Dec 2021 14:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640184371;
        bh=phXrYZ26uqRrRtL9psmNpU8/i8O7+uPas2TndxpCdWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=syWCh5I+BWgkLbeSip6eVBzW5xIc5oQWqcPbwwtFWkjBbrMbojgmN+UKwvr3JmuiR
         Ec84zGxyPFNT8vWV8hVZxVfF5XV0zF1KMGt/CddpkbwLIeP0vD53UYP7J0R9Y0zzqy
         oI9rS3NZPtVeJZYbGd8k9pzvWnzynxaDbhNTXC/usUHp6/ukv3sHq067iOH5ePz6AB
         trn3JhMWFmEfntsv0E3zejTIqDyZBpSeXy8qYfBefzVJxGhdV0aR3b6xDRFxYZvXjL
         4VX5Fal3iUf5muKYstZxH/BuXd/koM6k742hU0w5KE713O04DixAyuyLZXxHvjGFC8
         wKCTmoSEJHeZw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1n02sV-0002Bx-Sa; Wed, 22 Dec 2021 15:46:03 +0100
Date:   Wed, 22 Dec 2021 15:46:03 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Marc Ferland <ferlandm@amotus.ca>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] gnss: usb: add support for Sierra Wireless XM1210
Message-ID: <YcM6KwkBo6lvdkZQ@hovoldconsulting.com>
References: <20211220111901.23206-1-johan@kernel.org>
 <20211220111901.23206-3-johan@kernel.org>
 <CAMRMzCAe1B66vyhXRsiew2=NDM+FbzFU8O9wXsrod64KaYrZ1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRMzCAe1B66vyhXRsiew2=NDM+FbzFU8O9wXsrod64KaYrZ1Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 02:04:49PM -0500, Marc Ferland wrote:
> On Mon, Dec 20, 2021 at 6:19 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > Add support for the USB interface of the Sierra Wireless XM1210
> > receiver.
> >
> > Note that the device only supports NMEA.

> > Reported-by: Marc Ferland <ferlandm@amotus.ca>
> > Link: https://lore.kernel.org/r/20211027200223.72701-1-ferlandm@amotus.ca
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  drivers/gnss/usb.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gnss/usb.c b/drivers/gnss/usb.c
> > index 5c0251034def..792235a688ea 100644
> > --- a/drivers/gnss/usb.c
> > +++ b/drivers/gnss/usb.c
> > @@ -17,6 +17,7 @@
> >  #define GNSS_USB_WRITE_TIMEOUT 1000
> >
> >  static const struct usb_device_id gnss_usb_id_table[] = {
> > +       { USB_DEVICE(0x1199, 0xb000) },         /* Sierra Wireless XM1210 */
> >         { }
> >  };
> >  MODULE_DEVICE_TABLE(usb, gnss_usb_id_table);
> > --
> > 2.32.0
> >
> Thank you Johan! Much appreciated!
> 
> With your patches applied on my platform (featuring the XM1210) , I get:
> 
> # lsmod | grep gnss
> gnss_usb 16384 0 - Live 0xffffffffc011b000
> gnss 16384 3 gnss_usb, Live 0xffffffffc0082000
> 
> # dmesg | grep gnss
> gnss: GNSS driver registered with major 244
> usbcore: registered new interface driver gnss-usb
> 
> # ls -l /dev/gnss0
> crw-rw----    1 root     root      244,   0 Apr  8 08:39 /dev/gnss0
> 
> I also tested with gpsd and everything is working as expected, hence:
> 
> Tested-by: Marc Ferland <ferlandm@amotus.ca>

Thanks for testing, Marc!

I've applied this series now after adding your Tested-by tag to both
patches.

Johan
