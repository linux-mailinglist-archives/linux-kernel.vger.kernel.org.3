Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D2A51154E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiD0LUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiD0LUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:20:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B84165A3;
        Wed, 27 Apr 2022 04:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651058212; x=1682594212;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HIRF5W5o/gV3DIQXa4xMa+ibJZeT9Xrw34R4dA4zxYo=;
  b=B7o9vEFrJCS65f5xHiQWVGGAYQxaHrCOLKifntW21gPsPdFDeolQcxSN
   +aR2ugrsv5ZnxFCisIUa0mlCt7HW9nvMPT6IRFlCK3F8GVBJnTrS322DU
   3ffrpeUBKwG+6feTZeUB0ogkPE4Lz58S6AzFLYa14VjSSsoD3ZsQ9wuaw
   w129/zZ6e0d5iPQubJOwVZpU9XBTZbIMBHhLkFM3XCCTJ21QoV8JWeq9F
   9iQH3IZjHnkp9fnsLXKOADivJnsUFca9hxrBVsR5FBepY8RVrkbbTw7jW
   K/nwgc4JPkn+LhgcdIqX/aOL/vgarfssuAelZiyEzXxumSxOK9nRK3Zax
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="291045239"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="291045239"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 04:16:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="705498756"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 27 Apr 2022 04:16:49 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 27 Apr 2022 14:16:48 +0300
Date:   Wed, 27 Apr 2022 14:16:48 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Jameson Thies <jthies@google.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Won Chung <wonchung@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] usb: typec: Separate USB Power Delivery from USB
 Type-C
Message-ID: <YmkmILWlbvoZaXKZ@kuha.fi.intel.com>
References: <20220425124946.13064-1-heikki.krogerus@linux.intel.com>
 <20220425124946.13064-2-heikki.krogerus@linux.intel.com>
 <YmfgfRA1ecJwf12i@kroah.com>
 <YmjlyxLk8wfziq9l@kuha.fi.intel.com>
 <YmjxFkpCwxz4fgqb@kroah.com>
 <Ymj8LWUgk6X/Alze@kuha.fi.intel.com>
 <YmkD2/r1imDT5qTz@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmkD2/r1imDT5qTz@kroah.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 10:50:35AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 27, 2022 at 11:17:49AM +0300, Heikki Krogerus wrote:
> > On Wed, Apr 27, 2022 at 09:30:30AM +0200, Greg Kroah-Hartman wrote:
> > > > > "struct pd" is just about the shortest structure name I've seen in the
> > > > > kernel so far.  How about using some more letters?  :)
> > > > 
> > > > Okay, I'll make it usbpd.
> > > 
> > > How about some more vowels: "struct usb_power_delivery" please.  This
> > > isn't the 1980's :)
> > 
> > "struct usb_power_delivery" is fine, but I would still really really
> > want to use "struct usbpd_capabilities" instead of
> > "struct usb_power_delivery_capabilities" - it's just too long.
> > Is that okay?
> 
> Nah, spell it out please, we don't use "usbpd" anywhere, and again, we
> don't have a limit of characters.  Most editors should auto-complete
> anyway :)

Very well.

> > > > > The kobject question above goes to the code as well.  You are creating a
> > > > > bunch of raw kobjects still, why?  This should all fit into the driver
> > > > > model and kobjects shouldn't be needed.  Are you trying to nest too deep
> > > > > in the attributes?  If so, kobjects will not work as userspace tools
> > > > > will not realize they are there and are attributes at all.
> > > > 
> > > > They are not raw kobjects, they are all devices now. That header just
> > > > needs to be fixed.
> > > 
> > > You have loads of kobject attributes in the .c file.  Either I read it
> > > wrong, or you are doing something wrong, as that should never be the
> > > case for a driver or device.
> > 
> > Hmm, I'm probable still doing something wrong...
> 
> All of your sysfs callbacks should have a struct device, not a kobject.
> You might just be getting lucky in that we are casting around a pointer
> of the correct layout.  But the compiler should have caught that
> somewhere, please look into it.

I'll fix this.

thanks,

-- 
heikki
