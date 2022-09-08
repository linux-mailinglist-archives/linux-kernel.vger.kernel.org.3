Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2CC5B2560
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiIHSLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIHSLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:11:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E0450724;
        Thu,  8 Sep 2022 11:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662660691; x=1694196691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bZewxsNrhZtcEOeBaHMwmonPchlWsSOuThEydu6CoaU=;
  b=jJLh80H0V3yrWDHo8Bg4yzWgFL8QMsQH2RkXw5ECSughc15UeSQwsfNS
   Cfc+cjGkb1hm8qCe/2CCDMk2ynLeBpNbS7/prsl7YYTPmd0IwS0eqPkI5
   RLsDalw2xkQ1HHkUbS0c67dkCFMuEL8x0H2uiFJpgspPYRJ5JZ5hIZOU9
   c76lutqkleRER7z9Nn1762sBQmjWJtUPGqiBOWCmwPLsFm/7BlBOd+CQ+
   r75IlsQoDS3v3AI6MHRFDYVVxKXg5RMQicCUi8pgC+fCgiPzbOHb5gXp6
   ob07mNGRIRy7cjTazfDrAwVvja/GiMBlOUOegHSGctIu0E3P+yia1GUE4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="284302778"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="284302778"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 11:11:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="704108514"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 11:11:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oWLzo-00AERp-2m;
        Thu, 08 Sep 2022 21:11:24 +0300
Date:   Thu, 8 Sep 2022 21:11:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        p.zabel@pengutronix.de, rtanwar@maxlinear.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hhhawa@amazon.com, jonnyc@amazon.com
Subject: Re: [PATCH v5 20/21] hwmon: (mr75203) add debugfs to read and write
 temperature coefficients
Message-ID: <YxowTBIODMLjf1Ek@smile.fi.intel.com>
References: <20220908152449.35457-1-farbere@amazon.com>
 <20220908152449.35457-21-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908152449.35457-21-farbere@amazon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 03:24:48PM +0000, Eliav Farber wrote:
> This change adds debugfs to read and write temperature sensor coefficients
> - g, h, j and cal5.
> 
> The coefficients can vary between product and product, so it can be very
> useful to be able to modify them on the fly during the calibration
> process.
> 
> e.g.:
> 
> cat /sys/kernel/debug/940f23d0000.pvt/ts_coeff_cal5
> 4096
> 
> echo 83000 > sys/kernel/debug/940f23d0000.pvt/ts_coeff_g

...

> - Return j coefficient to use debugfs_create_file() instead of
>   debugfs_create_u32() because j is signed.

You can use

DEFINE_DEBUGFS_ATTRIBUTE(ts_coeff_j, ts_coeff_j_get, ts_coeff_j_set, "%lld\n");

which still makes code compact.

-- 
With Best Regards,
Andy Shevchenko


