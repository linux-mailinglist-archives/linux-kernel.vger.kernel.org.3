Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BEC561DE7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 16:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbiF3O3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 10:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236633AbiF3O2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 10:28:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E247CC68;
        Thu, 30 Jun 2022 07:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656598311; x=1688134311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/jj7IiySnenbJ6Jt3exYRBe8CNXmvllxDBc9it60MkI=;
  b=GsD8EYLeEWnrpITONd+w9XUUlZCEDsi4hD1pcGYL27hArYhPrrkOMxGf
   8fX3+beJPlayIsIIyvVp2ZqeD4Uco2bXF2dXUo/Bd49CETbhptDgwB0qc
   7BJdFRj5JHUQpQyXBQj4yPU4I5P76FMeONv3tqWZIIMgyE1sFtZFSApGd
   U+BNarJfdjX6VO6N+X4fYmKTjilRUuCTF7ZJNjhAJyJFuib58bAESH48H
   4dYWRbMgDu5PjSdLukYXz3wPZtorMNlv1h48cyXcY6s0SJdZ6/Ifps+eU
   b72Z5g9pO973H2auDB3OPF7dy9c1Ky01AIVMHevanJ+bFjg2V4G1786eD
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="283092199"
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="283092199"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 07:11:18 -0700
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="541340582"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 07:11:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o6usz-000ybK-Hh;
        Thu, 30 Jun 2022 17:11:13 +0300
Date:   Thu, 30 Jun 2022 17:11:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Add Intel Meteor Lake pin
 controller support
Message-ID: <Yr2vATzSrWTD5rmn@smile.fi.intel.com>
References: <20220630123858.74300-1-andriy.shevchenko@linux.intel.com>
 <Yr2eaj9oxhYQDKJG@lahna>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr2eaj9oxhYQDKJG@lahna>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 04:00:26PM +0300, Mika Westerberg wrote:
> On Thu, Jun 30, 2022 at 03:38:58PM +0300, Andy Shevchenko wrote:
> > This driver adds pinctrl/GPIO support for Intel Meteor Lake. The
> > GPIO controller is based on the next generation GPIO hardware but still
> > compatible with the one supported by the Intel core pinctrl/GPIO driver.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


