Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE59511363
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359354AbiD0IVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344335AbiD0IVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:21:04 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749032D1ED;
        Wed, 27 Apr 2022 01:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651047474; x=1682583474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4eQwnHv73t3DM77yvY9E91P67tUvy3j6uTNJ4V2P08U=;
  b=nYJ4feadvQ8aCiKoo4w9v9DeVgttdyUEh+51Urwld6iA9aUXLRY0jFe2
   1qSV22smymrkB9HGJe552D2MilgqqB02tUmiv8QCbMMse6qnSREAk0u/4
   cQ1K00Ir44ZF/H1qI1+oKSBMG8KEXmHZ4WmZ6sKgsY3IaOzQbr05WQ8dc
   e69kVSuXo7mm8MPYRqIPCR3YcfTbk13aQWTXd7W0Fe9ga4M75qkI5PzFV
   TkmQxFL68haoaYwa8xklDFod97FlBKzKSdA66oMArAutqcoJhIOH9lwgj
   siSDWkjwtrWDoe3vUd7N4GKE4kRx04KxBppaYEpc3LPhTysilRjfteH95
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="264704590"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="264704590"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 01:17:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="705439773"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 27 Apr 2022 01:17:50 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 27 Apr 2022 11:17:49 +0300
Date:   Wed, 27 Apr 2022 11:17:49 +0300
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
Message-ID: <Ymj8LWUgk6X/Alze@kuha.fi.intel.com>
References: <20220425124946.13064-1-heikki.krogerus@linux.intel.com>
 <20220425124946.13064-2-heikki.krogerus@linux.intel.com>
 <YmfgfRA1ecJwf12i@kroah.com>
 <YmjlyxLk8wfziq9l@kuha.fi.intel.com>
 <YmjxFkpCwxz4fgqb@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmjxFkpCwxz4fgqb@kroah.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 09:30:30AM +0200, Greg Kroah-Hartman wrote:
> > > "struct pd" is just about the shortest structure name I've seen in the
> > > kernel so far.  How about using some more letters?  :)
> > 
> > Okay, I'll make it usbpd.
> 
> How about some more vowels: "struct usb_power_delivery" please.  This
> isn't the 1980's :)

"struct usb_power_delivery" is fine, but I would still really really
want to use "struct usbpd_capabilities" instead of
"struct usb_power_delivery_capabilities" - it's just too long.
Is that okay?

> > > > +
> > > > +int pd_init(void);
> > > > +void pd_exit(void);
> > > 
> > > The kobject question above goes to the code as well.  You are creating a
> > > bunch of raw kobjects still, why?  This should all fit into the driver
> > > model and kobjects shouldn't be needed.  Are you trying to nest too deep
> > > in the attributes?  If so, kobjects will not work as userspace tools
> > > will not realize they are there and are attributes at all.
> > 
> > They are not raw kobjects, they are all devices now. That header just
> > needs to be fixed.
> 
> You have loads of kobject attributes in the .c file.  Either I read it
> wrong, or you are doing something wrong, as that should never be the
> case for a driver or device.

Hmm, I'm probable still doing something wrong...

thanks,

-- 
heikki
