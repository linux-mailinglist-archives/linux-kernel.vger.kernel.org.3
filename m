Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC995A2D88
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344484AbiHZRcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344442AbiHZRcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:32:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B26CDB076;
        Fri, 26 Aug 2022 10:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661535133; x=1693071133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TmFRXEOP3iU5sday/xLTvELB3voTZqr4jmnhnq3J/Aw=;
  b=XclIE7fhwZa2oc4DePXzYjODbZyMZVmnI9Rf3waWKY4RMswPOxp8HoW2
   /q9npcakQbiyeERSXRstl0m6X46qDL+zlZOlJ23juv4wWfKkaU/4uqJp9
   ZvzcjKg53id555py0IPhQp02i7R5RjYy28mn1Vbj/JRjqLoRg3q9l4LAh
   +xnf+eGJYbfmVA2Y7L/TCD0AJrzdfH2qpSv7VPQYdv+hfhvhUg4RWzsLi
   Qza1J0w6jUNMeziNjjTx4kuUXyAUstxSjBinOc4cIKnmhRm6+B/zuBhad
   o6y/2sk4LPWbvhUzm6GAbK3V9gpjYt9oKUj6lQMMiOMtOnoEzJJMvKC6A
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="380861414"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="380861414"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 10:31:41 -0700
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="643740701"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 10:31:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oRdB9-003zbz-2p;
        Fri, 26 Aug 2022 20:31:35 +0300
Date:   Fri, 26 Aug 2022 20:31:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] gpiolib: acpi: Add support to ignore programming
 an interrupt
Message-ID: <YwkDd+mAhyoSwVeq@smile.fi.intel.com>
References: <20220803042501.515-1-mario.limonciello@amd.com>
 <efb83a0c-7617-894e-a34d-37280238d5aa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efb83a0c-7617-894e-a34d-37280238d5aa@redhat.com>
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

On Wed, Aug 03, 2022 at 05:07:15PM +0200, Hans de Goede wrote:
> On 8/3/22 06:24, Mario Limonciello wrote:
> > gpiolib-acpi already had support for ignoring a pin for wakeup, but
> > if an OEM configures a floating pin as an interrupt source then
> > stopping it from being a wakeup won't do much good to stop the
> > interrupt storm.
> > 
> > Add support for a module parameter and quirk infrastructure to
> > ignore interrupts as well.
> > 
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


