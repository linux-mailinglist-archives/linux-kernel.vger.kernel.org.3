Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025C1540243
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343957AbiFGPSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245065AbiFGPSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:18:13 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB42379397;
        Tue,  7 Jun 2022 08:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654615091; x=1686151091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uy8NrYtEbMwwgKIrNrC4fVggcAL7DJ5u9s5876iN6aM=;
  b=hJtIbR0exDqQxRxvEcwYkpi4ZcY4ht/OTpZj7HIE/lDh7Gc3OhsQDEGP
   lrHKqd/cs/Fy6TH8fBtS15pwL6u106+SCimInpDo4ATP/P+XkEqTsGGQw
   BfQmA7ijFQVwif1nQv45Vp65BsjsSJL9PNL3Xq6p1KKO3dIeuljA7dDiP
   QTUgyCoQGYyZiTs/grcDFz5XRzka5bNF4VOy/ncXHcuGpaS0JbsoOpGcW
   ZIxvlpWwQwdZ6QY4VYplKD4Z+ixd3GDNV7EOjkWla2k/X4BYBGX27nvoh
   is+AbX4snIPRDbBFx01IImbLAooaZOc298TzuccH0BubTutcn5SgcDBcp
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="274261673"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="274261673"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 08:18:11 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="826403540"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 08:18:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nyay5-000Vnm-GT;
        Tue, 07 Jun 2022 18:18:05 +0300
Date:   Tue, 7 Jun 2022 18:18:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Enrico Weigelt <lkml@metux.net>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
Subject: Re: [PATCH v3 0/4] simatic-ipc additions to p2sb apl lake gpio
Message-ID: <Yp9sLePHn9RqcXcU@smile.fi.intel.com>
References: <20220513083652.974-1-henning.schild@siemens.com>
 <You1KI78zbXmApm+@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <You1KI78zbXmApm+@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 07:24:08PM +0300, Andy Shevchenko wrote:
> On Fri, May 13, 2022 at 10:36:48AM +0200, Henning Schild wrote:
> > changed since v2:
> >  - put GPIO led module under same config switch
> >  - some style changes from review
> >  - init gpios with gpiod_get_index and drop gpiod_set_value
> >  - drop bogus "if" from watchdog Kconfig
> > 
> > changed since v1:
> >  - rebased
> >  - split p1 into p1-3
> > 
> > This switches the simatic-ipc modules to using the upcoming p2sb 
> > interface introduced by Andy with 
> > "platform/x86: introduce p2sb_bar() helper".
> > The series relies on these p2sb changes already applied and Andy will
> > likely take them into his series at some point.
> > 
> > It also switches to one apollo lake device to using gpio leds.
> 
> Hmm... This series misses LEDS maintainer. Okay, I will include them when
> sending v6 after v5.19-rc1.

I have sent v6 [1], please make sure everything is okay.

[1]: https://lore.kernel.org/platform-driver-x86/20220606164138.66535-1-andriy.shevchenko@linux.intel.com/

-- 
With Best Regards,
Andy Shevchenko


