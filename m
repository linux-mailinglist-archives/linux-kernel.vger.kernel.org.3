Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0B159E762
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244893AbiHWQdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244824AbiHWQdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:33:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F701BEA8;
        Tue, 23 Aug 2022 07:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661266380; x=1692802380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bqhxUdOn3t8XtyVRG+9J23npUH+3xW53S2LXug5cDv8=;
  b=lK2AhEtiNDu/zE7DPE3eEI5o+ur5tEWzAcddI/uOmuX8dblR96H7Ox/I
   zogRLeKvkISH+QHMyTlPeWtdwi5s2zGCmGc1nu5u2T+wMv8iM78vF+R2c
   fKAVCPjRZDcn0dkOFkio3Q9hwoiW3RadtjqZCyKPUo0Dslss7XgVeI5Oh
   XdZTh+kWCUk9/KnI/qD6DrbeVVgB5+R41BvHR7C0OfRgLl1X6ipMf2WlB
   DAu6twDRzri4PiwKg8qlBGJykW/59wCDC/J89dxzfUCb37ikX4BzCk7Xr
   dnjJly1x589afeeWkFIl6eNYlk3+JocbMlST7n7BWb+yXC67Fw3Wqo+yC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="294495642"
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="294495642"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 07:52:34 -0700
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="677648434"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 07:52:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oQVGY-002U44-3A;
        Tue, 23 Aug 2022 17:52:30 +0300
Date:   Tue, 23 Aug 2022 17:52:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: simatic-ipc-leds-gpio: make sure we have the GPIO
 providing driver
Message-ID: <YwTprqn6FhjEHYhG@smile.fi.intel.com>
References: <20220805120343.5027-1-henning.schild@siemens.com>
 <YwTg86pKFtT0gax0@smile.fi.intel.com>
 <20220823164207.6de6c387@md1za8fc.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823164207.6de6c387@md1za8fc.ad001.siemens.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 04:42:07PM +0200, Henning Schild wrote:
> Am Tue, 23 Aug 2022 17:15:15 +0300
> schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> > On Fri, Aug 05, 2022 at 02:03:43PM +0200, Henning Schild wrote:
> > > If we register a "leds-gpio" platform device for GPIO pins that do
> > > not exist we get a -EPROBE_DEFER and the probe will be tried again
> > > later. If there is not driver to provide that pin we will poll
> > > forever and also create a lot of log messages.
> > > 
> > > So check if that GPIO driver is configured, if so it will come up
> > > eventually. If not we exit our probe function early and do not even
> > > bother registering the "leds-gpio". This method was chosen over
> > > "Kconfig depends" since this way we can add support for more
> > > devices and GPIO backends more easily without "depends"ing on all
> > > GPIO backends.  
> > 
> > Not sure what we should do with this patch due to your self-reply on
> > it. So, if it's still needed, I would expect a new version / resend.
> 
> Ok i did not realize that the P2SB stuff made it in the meantime. This
> patch is still relevant and should be picked on top, to deal with the
> unlikely case that this driver is enabled where the gpio driver is not
> ... which would lead to an endless probing loop and a lot of logging.
> 
> Why would you expect a new version? I did not try but see no reason it
> should not still apply. There has been no review comments, which means
> no change needed.
> 
> Unless we want to give it a Fixes or something and consider that
> probing loop a bug to make sure the patch makes it into all kernels
> that carry my LED GPIO stuff based on the P2SB patches.

Because it's usually how maintainers work (at least Lee and Greg KH come
to my mind), when new cycle starts, the (potentially rebased) new versions
are expected.

But with powerfulness of `b4` tool it might be that they changed their ways
of maintaining. You need to ask the LED maintainer(s) on how to proceed.

-- 
With Best Regards,
Andy Shevchenko


