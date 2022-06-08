Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E63654303C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239187AbiFHMYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239180AbiFHMYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:24:00 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7A71F187E;
        Wed,  8 Jun 2022 05:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654691034; x=1686227034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ogrZ4q/o6zXk4o+X+qsQgG9Jvd4n3nuZ6xC2HGV8zrk=;
  b=kvBLEWJsGPQDfk7TE0f9NvqrnEJmCsp1v7u35ztFYtsinNzYllYIWB39
   8ag/ONIAg4jW5XCCYxmpWFnJEoHQaFoKTSVDeHHgcaRoztaV2EjSC0I5K
   y4an3DpC5Ct0rCex/xN03ts7MurRaNNK86wBTqedUqOY0BRLJyg4RklwK
   XlUEWcfW6DXAkues4wqKh3yf23oZxhmWNhQ+CNsa8mbPnVvysKnNUopoP
   aDvdlAVOS0QALZoGI/zy2rdVR0Deazo1rkYDS9PrGo4ES0z6MuEKrOsQs
   1JshFS1adeyZN8rDquLl5VY4Pv7DcvsZ1e/ofmTH34MaD/r3ZDkdMsh/R
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="256707085"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="256707085"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 05:23:31 -0700
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="580034303"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 05:23:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nyuid-000X0F-EK;
        Wed, 08 Jun 2022 15:23:27 +0300
Date:   Wed, 8 Jun 2022 15:23:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 2/2] spi: Use device_find_first_child() instead of
 custom approach
Message-ID: <YqCUv2tSwzALSVsm@smile.fi.intel.com>
References: <20220607202058.8304-1-andriy.shevchenko@linux.intel.com>
 <20220607202058.8304-2-andriy.shevchenko@linux.intel.com>
 <YqCJsRqrCRiIBm1P@kroah.com>
 <YqCMunw+2WHIinOP@smile.fi.intel.com>
 <YqCQFFRXyaaQNSWv@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqCQFFRXyaaQNSWv@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 02:03:32PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jun 08, 2022 at 02:49:14PM +0300, Andy Shevchenko wrote:

...

> Why not exactly?  match_true() above and device_match_any() have the
> same signature from what I can tell:
> 	static int match_true(struct device *dev, void *data)
> 	int device_match_any(struct device *dev, const void *unused)
> 
> What am I missing, the const?

Yep! Compiler is very unhappy about it.

> > I agree that all thing should be using _any instead of _first.
> 
> Yes, so let's fix it please, don't propagate bad patterns.

Will do, thanks!

-- 
With Best Regards,
Andy Shevchenko


