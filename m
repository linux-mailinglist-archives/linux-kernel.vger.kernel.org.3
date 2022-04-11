Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369054FB9DA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbiDKKm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiDKKmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:42:24 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9833D4A3;
        Mon, 11 Apr 2022 03:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649673610; x=1681209610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mRbzriUl5s2UXxPQ8GII2Fe20BP3Ht4BRWMMBCGSd9w=;
  b=BXst8Ls/7qvEjIxR1yB5UZiVoKiuqcO54vS4MqvIrveLwgvrlqy9JF0k
   Ex1EQxW/xYSesmF8dPyPtamly5szea5+sDzE1F9Cd6/7pUnXukc4Y2NY0
   cOmuV/4DySXR//pYuOfheL/P4qG4Jbal5APL6HMYDWCl/1yViC0u13jbJ
   Hsj7QbqKQMCGU/F/S4Xdi09nRqweUsMMMLrhBpFlawATFtdR5FtTZBfDQ
   fOt0hVRMYfUKc59ai9nCXzb2rw25IvZCSOqNY7JMU1Zo3EGUDTxnH9nYY
   odc6IAj7mv7zBAYDi3HqS/NeE7aP2S3PRaa3hMpvGriR4mbUyCgU/Vt/x
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="260932307"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="260932307"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 03:40:07 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="589832034"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 03:39:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1ndrP6-001BMJ-OC;
        Mon, 11 Apr 2022 13:36:16 +0300
Date:   Mon, 11 Apr 2022 13:36:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tony Lindgren <tony@atomide.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] serial: core: Add support of runtime PM
Message-ID: <YlQEoNDYRtoHDL68@smile.fi.intel.com>
References: <20211115084203.56478-1-tony@atomide.com>
 <20211115084203.56478-2-tony@atomide.com>
 <YaX82wxybOZnPKpy@hovoldconsulting.com>
 <YbGwaOj0ZbEuNEPA@atomide.com>
 <YbHb7HRGGFRBorB7@smile.fi.intel.com>
 <YeaLL0cJFeIhz1Tr@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeaLL0cJFeIhz1Tr@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, my apology for the long delay in answering / commenting on this.
Second, Cc'ed to Ilpo.

On Tue, Jan 18, 2022 at 11:41:03AM +0200, Tony Lindgren wrote:
> * Andy Shevchenko <andriy.shevchenko@intel.com> [211209 10:37]:
> > On Thu, Dec 09, 2021 at 09:29:44AM +0200, Tony Lindgren wrote:
> > > * Johan Hovold <johan@kernel.org> [211130 10:29]:
> > > > On Mon, Nov 15, 2021 at 10:41:57AM +0200, Tony Lindgren wrote:
> > > > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > 
> > > > > 8250 driver has wrong implementation of runtime power management, i.e.
> > > > > it uses an irq_safe flag. The irq_safe flag takes a permanent usage count
> > > > > on the parent device preventing the parent from idling. This patch
> > > > > prepares for making runtime power management generic by adding runtime PM
> > > > > calls to serial core once for all UART drivers.
> > > > > 
> > > > > As we have serial drivers that do not enable runtime PM, and drivers that
> > > > > enable runtime PM, we add new functions for serial_pm_resume_and_get() and
> > > > > serial_pm_autosuspend() functions to handle errors and allow the use also
> > > > > for cases when runtime PM is not enabled. The other option considered was
> > > > > to not check for runtime PM enable errors. But some CPUs can hang when the
> > > > > clocks are not enabled for the device, so ignoring the errors is not a good
> > > > > option. Eventually with the serial port drivers updated, we should be able
> > > > > to just switch to using the standard runtime PM calls with no need for the
> > > > > wrapper functions.
> > > > 
> > > > A third option which needs to be considered is to always enable runtime
> > > > pm in core but to keep the ports active while they are opened unless a
> > > > driver opts in for more aggressive power management. This is how USB
> > > > devices are handled for example.
> > > > 
> > > > A next step could then be to move over uart_change_pm() to be handled
> > > > from the pm callbacks.
> > > 
> > > Yes that would be nice to do eventually :)
> 
> I think we should do the "third option" above as the first preparatory patch.
> It can be done separately from the rest of the series, and we avoid adding
> serial layer specific wrappers around runtime PM calls in the later patches.
> 
> Below is what I came up with for the preparatory patch, can you guys please
> take a look and see if you have better ideas?
> 
> For system suspend and resume, it seems we don't need to do anything as
> runtime PM is anyways disabled already in prepare.
> 
> Andy, care to give the following also a try for your serial port test
> cases?

I'm a bit off of the UART work nowadays, but luckily we have Ilpo who is
pretty much ramped up on the topic. Please, include him in all your work
WRT 8250 UART improvements. I hope Ilpo might have time to test the patch
mentioned in this message or give an idea how to do better, if possibly.

-- 
With Best Regards,
Andy Shevchenko


