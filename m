Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D59F511287
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358874AbiD0HeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358867AbiD0Hdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:33:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB2C6B0B5;
        Wed, 27 Apr 2022 00:30:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3861861B07;
        Wed, 27 Apr 2022 07:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421C8C385A7;
        Wed, 27 Apr 2022 07:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651044633;
        bh=7IUrdMT9kbbx0DsJsKPAR8psLkzAWpMBFfCUfqBAWig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xbzbCx2hvF0hCGkEqxhiO5N0HqXdEGddWDPvYd71bPKnrs6HqtmHS0TASeReeiO0j
         i4aT5usH7V80GDFG0lzHtx5UIgYhS/htq3wRaYnzp+JyQAqZHFOOh8zR1ThgICjmXu
         HJT3dURy+l7VwWqgQKv1K/cPA0HBFjWtr44P76og=
Date:   Wed, 27 Apr 2022 09:30:30 +0200
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
Message-ID: <YmjxFkpCwxz4fgqb@kroah.com>
References: <20220425124946.13064-1-heikki.krogerus@linux.intel.com>
 <20220425124946.13064-2-heikki.krogerus@linux.intel.com>
 <YmfgfRA1ecJwf12i@kroah.com>
 <YmjlyxLk8wfziq9l@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmjlyxLk8wfziq9l@kuha.fi.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 09:42:19AM +0300, Heikki Krogerus wrote:
> Hi,
> 
> On Tue, Apr 26, 2022 at 02:07:25PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Apr 25, 2022 at 03:49:44PM +0300, Heikki Krogerus wrote:
> > > --- /dev/null
> > > +++ b/drivers/usb/typec/pd.h
> > > @@ -0,0 +1,30 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +
> > > +#ifndef __USB_POWER_DELIVERY__
> > > +#define __USB_POWER_DELIVERY__
> > > +
> > > +#include <linux/kobject.h>
> > 
> > Why kobject.h when:
> 
> Oops, that should now be "#include <linux/device.h>".
> 
> > > +
> > > +struct pd_capabilities {
> > > +	struct device dev;
> > 
> > This is a device?
> > 
> > > +	struct pd *pd;
> > > +	enum typec_role role;
> > > +};
> > > +
> > > +struct pd {
> > > +	struct device		dev;
> > > +	int			id;
> > > +
> > > +	u16			revision; /* 0300H = "3.0" */
> > 
> > So BCD?
> 
> Yes.
> 
> > > +	u16			version;
> > > +};
> > 
> > > +
> > > +#define to_pd_capabilities(o) container_of(o, struct pd_capabilities, dev)
> > > +#define to_pd(o) container_of(o, struct pd, dev)
> > > +
> > > +struct pd *pd_find(const char *name);
> > 
> > "struct pd" is just about the shortest structure name I've seen in the
> > kernel so far.  How about using some more letters?  :)
> 
> Okay, I'll make it usbpd.

How about some more vowels: "struct usb_power_delivery" please.  This
isn't the 1980's :)

> > > +
> > > +int pd_init(void);
> > > +void pd_exit(void);
> > 
> > The kobject question above goes to the code as well.  You are creating a
> > bunch of raw kobjects still, why?  This should all fit into the driver
> > model and kobjects shouldn't be needed.  Are you trying to nest too deep
> > in the attributes?  If so, kobjects will not work as userspace tools
> > will not realize they are there and are attributes at all.
> 
> They are not raw kobjects, they are all devices now. That header just
> needs to be fixed.

You have loads of kobject attributes in the .c file.  Either I read it
wrong, or you are doing something wrong, as that should never be the
case for a driver or device.

thanks,

greg k-h
