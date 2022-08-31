Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500985A7A59
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiHaJiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiHaJir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:38:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3654CCEB26;
        Wed, 31 Aug 2022 02:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661938727; x=1693474727;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jonMZ3l6rEd+wV3XzXM0LDE5/eeSVv24z4EqTQlOWwg=;
  b=J5JlDKgONMF2hTOgJV+HYtm3p5ufPYzgZErRwFNxRGomrfj2dNHYFa5I
   wIdmNetezlizSZUjlsptjgWv9OCB4b5mWw8zBFzoLO6WDXpJppopWu49b
   xYtYPlOVeDB9VFtL8/cI6UpL2TCp9kWqysOWBog8YEFNcTom+KbITxIOd
   AgGLNRHbMO4y/99eBxvFT/nTAAqzovGIhazakzhzFWPY03iMW52O8ZG1z
   SvuKxSNSVdccLjhwZw5ZH++c7kxfC5/zuZHQIkvUysNIR5YDIIjz3LE1l
   z7aLDepUGSCh20AK/2PhPVOI6rQFjWLyi7IqncPmx/xrTxv397d9Kt13f
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="296691649"
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="296691649"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 02:38:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="680371119"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 02:38:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oTKBD-006Jcd-0M;
        Wed, 31 Aug 2022 12:38:39 +0300
Date:   Wed, 31 Aug 2022 12:38:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        p.zabel@pengutronix.de, rtanwar@maxlinear.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, ronenk@amazon.com,
        itamark@amazon.com, shellykz@amazon.com, shorer@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com, dkl@amazon.com,
        rahul.tanwar@linux.intel.com
Subject: Re: [PATCH v3 02/19] hwmon: (mr75203) fix VM sensor allocation when
 "intel,vm-map" not defined
Message-ID: <Yw8sHt0WLsEpL4bY@smile.fi.intel.com>
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-3-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830192212.28570-3-farbere@amazon.com>
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

On Tue, Aug 30, 2022 at 07:21:55PM +0000, Eliav Farber wrote:
> Bug fix - in case "intel,vm-map" is missing in device-tree ,'num' is set
> to 0, and no voltage channel infos are allocated.

Care to provide a Fixes tag for all fixes in your series. Also don't forget to
start series with fixes followed by cleanups and new features..

-- 
With Best Regards,
Andy Shevchenko


