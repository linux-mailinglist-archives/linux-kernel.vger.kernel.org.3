Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AE659E877
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343622AbiHWQ7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245734AbiHWQ6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:58:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61A87331E;
        Tue, 23 Aug 2022 07:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661264119; x=1692800119;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=05QrM+J42tkTyLvNaEQHtLHqDI6Al9GqhyxNcFXt604=;
  b=IZ0Ocvag80KP4lf9bTnb9YTVeJ9FNtknZ0aMn2XGIXLSUb7SRCc0i/n1
   lAgq+JiONACnlPoOUu76mhy01q8rZQJe4ZgIObxdthhGh7vN2QvfVJygD
   m0e9fLSOXNL48NQE4mpvyIcJCjbiLIcYsIEu2uJ5HZ1m/SkwACRZ1PNnx
   j4632sH+MotVZBX6obZKrRk2TmkpQrCEbcPj6kVgGZRiVffKbKhUilh02
   Y7iw7OVKskJRoiOuKK0pOjk0GsYgsDHglbO9MONVkicG+7ln0QW8mLqS3
   Ocr1u/wvQ+m4Npx9D4TrN7nw2AtcOeYc0xMlSivCzbhreHOOqJA28kXVr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="355426788"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="355426788"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 07:15:19 -0700
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="677635626"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 07:15:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oQUgV-002TD2-1c;
        Tue, 23 Aug 2022 17:15:15 +0300
Date:   Tue, 23 Aug 2022 17:15:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: simatic-ipc-leds-gpio: make sure we have the GPIO
 providing driver
Message-ID: <YwTg86pKFtT0gax0@smile.fi.intel.com>
References: <20220805120343.5027-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805120343.5027-1-henning.schild@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 02:03:43PM +0200, Henning Schild wrote:
> If we register a "leds-gpio" platform device for GPIO pins that do not
> exist we get a -EPROBE_DEFER and the probe will be tried again later.
> If there is not driver to provide that pin we will poll forever and also
> create a lot of log messages.
> 
> So check if that GPIO driver is configured, if so it will come up
> eventually. If not we exit our probe function early and do not even
> bother registering the "leds-gpio". This method was chosen over "Kconfig
> depends" since this way we can add support for more devices and GPIO
> backends more easily without "depends"ing on all GPIO backends.

Not sure what we should do with this patch due to your self-reply on it.
So, if it's still needed, I would expect a new version / resend.

-- 
With Best Regards,
Andy Shevchenko


