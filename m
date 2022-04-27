Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB075113CB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359458AbiD0IyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359577AbiD0Ixv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:53:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1FCDF4BA;
        Wed, 27 Apr 2022 01:50:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E98961C39;
        Wed, 27 Apr 2022 08:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645E3C385A7;
        Wed, 27 Apr 2022 08:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651049438;
        bh=nq7/CDH4aTXlXNOActxnTDPggtDZ1TzxYbung5bS7xA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HPKpNVyf9NjowBhrE7NfG5DG0ghxJLvrIKDbN2nryv8ujxzK6oNKhYdCjw7gFlqTv
         iu7is0b0hxIb5/eCjfF2qGloQiYmRPWIwoupRr7FXOy86bG9whKRa7V1tFB6ynEUeD
         NR4wBR6GaPAxuvhBMY1Jc8c6TQZXLI9Xl3zZV6t8=
Date:   Wed, 27 Apr 2022 10:50:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Jameson Thies <jthies@google.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Won Chung <wonchung@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] usb: typec: Separate USB Power Delivery from USB
 Type-C
Message-ID: <YmkD2/r1imDT5qTz@kroah.com>
References: <20220425124946.13064-1-heikki.krogerus@linux.intel.com>
 <20220425124946.13064-2-heikki.krogerus@linux.intel.com>
 <YmfgfRA1ecJwf12i@kroah.com>
 <YmjlyxLk8wfziq9l@kuha.fi.intel.com>
 <YmjxFkpCwxz4fgqb@kroah.com>
 <Ymj8LWUgk6X/Alze@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ymj8LWUgk6X/Alze@kuha.fi.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 11:17:49AM +0300, Heikki Krogerus wrote:
> On Wed, Apr 27, 2022 at 09:30:30AM +0200, Greg Kroah-Hartman wrote:
> > > > "struct pd" is just about the shortest structure name I've seen in the
> > > > kernel so far.  How about using some more letters?  :)
> > > 
> > > Okay, I'll make it usbpd.
> > 
> > How about some more vowels: "struct usb_power_delivery" please.  This
> > isn't the 1980's :)
> 
> "struct usb_power_delivery" is fine, but I would still really really
> want to use "struct usbpd_capabilities" instead of
> "struct usb_power_delivery_capabilities" - it's just too long.
> Is that okay?

Nah, spell it out please, we don't use "usbpd" anywhere, and again, we
don't have a limit of characters.  Most editors should auto-complete
anyway :)

> > > > The kobject question above goes to the code as well.  You are creating a
> > > > bunch of raw kobjects still, why?  This should all fit into the driver
> > > > model and kobjects shouldn't be needed.  Are you trying to nest too deep
> > > > in the attributes?  If so, kobjects will not work as userspace tools
> > > > will not realize they are there and are attributes at all.
> > > 
> > > They are not raw kobjects, they are all devices now. That header just
> > > needs to be fixed.
> > 
> > You have loads of kobject attributes in the .c file.  Either I read it
> > wrong, or you are doing something wrong, as that should never be the
> > case for a driver or device.
> 
> Hmm, I'm probable still doing something wrong...

All of your sysfs callbacks should have a struct device, not a kobject.
You might just be getting lucky in that we are casting around a pointer
of the correct layout.  But the compiler should have caught that
somewhere, please look into it.

thanks,

greg k-h
