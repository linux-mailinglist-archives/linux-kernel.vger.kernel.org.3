Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0448A511169
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358227AbiD0Gpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242894AbiD0Gpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:45:38 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF2D12FEF4;
        Tue, 26 Apr 2022 23:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651041748; x=1682577748;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M0Yim+wzgXBIfpDKLfu6Nj6r7PJaxMbByiW4szopul4=;
  b=i4igcz0NYHy0hwhxIfrJgTimlFEve1b9tZUqr02Q/EB8twoBfh1amCPT
   eimuG/X8PAmxsIn4yibSc0jmT11VvoDcctHIj4PeaLHdeVBJTaZIBMTOC
   PX7YO9eq/Po58t+WBFGfeFOBCFt0Bpiw0f5eoUyUcIPw0gVD7jxRxuO9i
   JlbbMDvETY68qo+kXcAiFRlybRaNc+5yTj/SbVqF4U1qLPS7Ovw+Izg9s
   CS4e9HnZdnBguhOKg7CBeLNpT1MTkEoy7mzPRnhc+HA7UFXFjrl8DWm0F
   p6Y1lHqsE4r8Brw81Gt8NoYbiwN1rwMEuwD9nJ6+CVzGZMTGjZX3Vo/gF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="265644130"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="265644130"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 23:42:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="705407344"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 26 Apr 2022 23:42:20 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 27 Apr 2022 09:42:19 +0300
Date:   Wed, 27 Apr 2022 09:42:19 +0300
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
Message-ID: <YmjlyxLk8wfziq9l@kuha.fi.intel.com>
References: <20220425124946.13064-1-heikki.krogerus@linux.intel.com>
 <20220425124946.13064-2-heikki.krogerus@linux.intel.com>
 <YmfgfRA1ecJwf12i@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmfgfRA1ecJwf12i@kroah.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 26, 2022 at 02:07:25PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 25, 2022 at 03:49:44PM +0300, Heikki Krogerus wrote:
> > --- /dev/null
> > +++ b/drivers/usb/typec/pd.h
> > @@ -0,0 +1,30 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef __USB_POWER_DELIVERY__
> > +#define __USB_POWER_DELIVERY__
> > +
> > +#include <linux/kobject.h>
> 
> Why kobject.h when:

Oops, that should now be "#include <linux/device.h>".

> > +
> > +struct pd_capabilities {
> > +	struct device dev;
> 
> This is a device?
> 
> > +	struct pd *pd;
> > +	enum typec_role role;
> > +};
> > +
> > +struct pd {
> > +	struct device		dev;
> > +	int			id;
> > +
> > +	u16			revision; /* 0300H = "3.0" */
> 
> So BCD?

Yes.

> > +	u16			version;
> > +};
> 
> > +
> > +#define to_pd_capabilities(o) container_of(o, struct pd_capabilities, dev)
> > +#define to_pd(o) container_of(o, struct pd, dev)
> > +
> > +struct pd *pd_find(const char *name);
> 
> "struct pd" is just about the shortest structure name I've seen in the
> kernel so far.  How about using some more letters?  :)

Okay, I'll make it usbpd.

> > +
> > +int pd_init(void);
> > +void pd_exit(void);
> 
> The kobject question above goes to the code as well.  You are creating a
> bunch of raw kobjects still, why?  This should all fit into the driver
> model and kobjects shouldn't be needed.  Are you trying to nest too deep
> in the attributes?  If so, kobjects will not work as userspace tools
> will not realize they are there and are attributes at all.

They are not raw kobjects, they are all devices now. That header just
needs to be fixed.

Br,

-- 
heikki
