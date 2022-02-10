Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3712F4B106A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242936AbiBJO31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:29:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242915AbiBJO30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:29:26 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67838101;
        Thu, 10 Feb 2022 06:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644503367; x=1676039367;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ldfob0iUwpW+sD1QtLB1wQCoH5pBOWlJ1e0MYKcYAbw=;
  b=OkJgK8/Qwj+MPnX2jGTGNH0sz/U1O6zTdH9x+4Pyx/X/XCt1ScdpuxcJ
   THmpDMfA+oRK+bgiD1o4KliTLo4kyc3lt1Ox+8Ur3L5UK2fp73xQGH9GW
   rwAehpFkdL5O/z4ulboGbp0ihEQxAEHUqNuR23sksrobjJxFJ6vj39JQN
   WTeExKGQa7CfGXruKFDaHqpdIALCFsa+Ma3b1QvXi9CUbT/7WWaFLUFEE
   7LOlA+xtFTZiyO+3FhDWiHE6NxV/q8uXbmJm6aEA/dxwFbWTZkXW8UR7d
   03FD1aLjL+PmPENEFqvqLnjdkR0IXspWKpcVatEq4ZeEzPxxhp41Dp916
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="249252349"
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="249252349"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 06:29:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="679163079"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 10 Feb 2022 06:29:23 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 10 Feb 2022 16:29:22 +0200
Date:   Thu, 10 Feb 2022 16:29:22 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+60df062e1c41940cae0f@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] usb: core: Unregister device on component_add()
 failure
Message-ID: <YgUhQqGryhEnp5B7@kuha.fi.intel.com>
References: <20220209164500.8769-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209164500.8769-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 05:45:00PM +0100, Fabio M. De Francesco wrote:
> Commit 8c67d06f3fd9 ("usb: Link the ports to the connectors they are
> attached to") creates a link to the USB Type-C connector for every new
> port that is added when possible. If component_add() fails,
> usb_hub_create_port_device() prints a warning but does not unregister
> the device and does not return errors to the callers.
> 
> Syzbot reported a "WARNING in component_del()".
> 
> Fix this issue in usb_hub_create_port_device by calling device_unregister()
> and returning the errors from component_add().
> 
> Reported-and-tested-by: syzbot+60df062e1c41940cae0f@syzkaller.appspotmail.com
> Fixes: 8c67d06f3fd9 ("usb: Link the ports to the connectors they are attached to")
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> v1->v2: Move find_and_link_peer() soon after the 'if' test for "retval", 
> 	as suggested by Heikki Krogerus with his review of v1.
> 
>  drivers/usb/core/port.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> index c2bbf97a79be..d5bc36ca5b1f 100644
> --- a/drivers/usb/core/port.c
> +++ b/drivers/usb/core/port.c
> @@ -602,11 +602,14 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
>  		return retval;
>  	}
>  
> -	find_and_link_peer(hub, port1);
> -
>  	retval = component_add(&port_dev->dev, &connector_ops);
> -	if (retval)
> +	if (retval) {
>  		dev_warn(&port_dev->dev, "failed to add component\n");
> +		device_unregister(&port_dev->dev);
> +		return retval;
> +	}
> +
> +	find_and_link_peer(hub, port1);
>  
>  	/*
>  	 * Enable runtime pm and hold a refernce that hub_configure()
> -- 
> 2.34.1

-- 
heikki
