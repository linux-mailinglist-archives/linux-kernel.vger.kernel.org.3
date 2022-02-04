Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8F94A976C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 11:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358177AbiBDKEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 05:04:49 -0500
Received: from mga01.intel.com ([192.55.52.88]:18260 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358127AbiBDKEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:04:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643969085; x=1675505085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3mxheKqTYV1TJi2fulCX3aSIhQo5eTdbQ5+4Zi+6mZw=;
  b=QclL9LjzFnl7dAKfpSpu/oPt0W32TdjnBaMqgORC7spry2aicDOE6tb6
   kF1mjXSZWYoepX7loolyVrI4w5l+z17mK4N6Hf8aBTKFvkuKhFuhCrsiM
   0iAXpq9Ogd84jISDyOip493CsierI8k1w4GALElQjsbxDw1UMsP4IGN7r
   uxl8+XEuEP4enEv6A0TnaHzdIy4Y798oRlRD2sgNqPZ6QnsPmQf2u5nld
   bdv83vY19h9L9D2TyaKhlUbX69F37gyL2msnF1uzg2vi3ruXn8qozlCRZ
   1iWD4I22345y+Y/uRc8XxMmO5Lm1CLkbtPmP/GRV4EjCY7pPSTKbp/of2
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="272843676"
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="272843676"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 02:04:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="677061944"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 04 Feb 2022 02:04:42 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 04 Feb 2022 12:04:41 +0200
Date:   Fri, 4 Feb 2022 12:04:41 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Jameson Thies <jthies@google.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] usb: typec: Separate USB Power Delivery from USB
 Type-C
Message-ID: <Yfz6OUbDBXVtQzrb@kuha.fi.intel.com>
References: <20220203144657.16527-1-heikki.krogerus@linux.intel.com>
 <20220203144657.16527-2-heikki.krogerus@linux.intel.com>
 <Yfvs13vpsWULIVWu@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yfvs13vpsWULIVWu@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Feb 03, 2022 at 03:55:19PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Feb 03, 2022 at 05:46:55PM +0300, Heikki Krogerus wrote:
> > +/* These additional details are only available with vSafe5V supplies */
> > +static struct kobj_attribute dual_role_power_attr = __ATTR_RO(dual_role_power);
> > +static struct kobj_attribute usb_suspend_supported_attr = __ATTR_RO(usb_suspend_supported);
> > +static struct kobj_attribute unconstrained_power_attr = __ATTR_RO(unconstrained_power);
> > +static struct kobj_attribute usb_communication_capable_attr = __ATTR_RO(usb_communication_capable);
> > +static struct kobj_attribute dual_role_data_attr = __ATTR_RO(dual_role_data);
> > +static struct kobj_attribute
> > +unchunked_extended_messages_supported_attr = __ATTR_RO(unchunked_extended_messages_supported);
> 
> Note, no 'struct device' should ever have a "raw" kobject hanging off of
> it.  If so, something went wrong.
> 
> If you do this, userspace will never be notified of the attributes and
> any userspace representation of the tree will be messed up.
> 
> Please, use an attribute directory with a name, or if you really need to
> go another level deep, use a real 'struct device'.  As-is here, I can't
> take it.

OK, got it. I don't think we can avoid the deeper levels, not without
making this really cryptic, and not really usable in all cases. These
objects are trying to represent (parts) of the protocol - the
messages, the objects in those messages, and later the responses to
those messages.

But I'm also trying to avoid having to claim that these objects are
"devices", because honestly, claiming that the packages used in
communication are devices is confusing, and just wrong. If we take
that road, then we really should redefine what struct device is
supposed to represent, and rename it also.

So would it be OK that, instead of registering these objects as
devices, we just introduce a kset where we can group them
(/sys/kernel/usb_power_delivery)?

thanks,

-- 
heikki
