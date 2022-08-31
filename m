Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78D65A7D08
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiHaMOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiHaMOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:14:51 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE034F189;
        Wed, 31 Aug 2022 05:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661948084; x=1693484084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ii7wOXgseh33MqqwvIDAG/cv8mjKfILjmc3KMhH/EP8=;
  b=YeIuyNcUOPFLKnnUVrlS/hrxOEaHPA9EUwaMJXoMhqfSJpNoUlkDnWX+
   GCoL1+RJw+ra3+cGp0abUqhWvPhzXzUCBnUFlBLe8EAZnJh7bDv1a7Y7Z
   na85mIAdPcaZSxixPVpSM5tPFHhqLp6tu0AsKz2eiiVT4rX6xm6s2EhES
   c5iZDBCkuxyIWAJQTcZ3sYoDg3NHE3zFOybTYNOMUoyT/EoG4XisbxIAe
   EpVyXwk88EcmE/nEGOpRAD/t4wimnhB/LpEGbj4hI0xGx+qNZY5xokKLt
   h56wFbeA0QDE9eOz+IbdV6WMVCy4NZOl8nLWxi1Ad+N//wL+rXZyFKztH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="381729043"
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="381729043"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 05:14:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="589008856"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 05:14:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oTMc7-006Mrc-25;
        Wed, 31 Aug 2022 15:14:35 +0300
Date:   Wed, 31 Aug 2022 15:14:35 +0300
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
Subject: Re: [PATCH v3 18/19] hwmon: (mr75203) add debugfs to read and write
 temperature coefficients
Message-ID: <Yw9Qq+PIfxgXRIK2@smile.fi.intel.com>
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-19-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830192212.28570-19-farbere@amazon.com>
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

On Tue, Aug 30, 2022 at 07:22:11PM +0000, Eliav Farber wrote:
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

> +	pvt->dbgfs_dir = debugfs_create_dir(dev_name(dev), NULL);

> +	if (!pvt->dbgfs_dir) {
> +		dev_err(dev, "Failed to create dbgfs_dir\n");
> +		return -EINVAL;
> +	}

No, just don't check the return value of debugfs API calls.

> +	debugfs_create_file("ts_coeff_h", 0644, pvt->dbgfs_dir, pvt,
> +			    &pvt_ts_coeff_h_fops);
> +	debugfs_create_file("ts_coeff_g", 0644, pvt->dbgfs_dir, pvt,
> +			    &pvt_ts_coeff_g_fops);
> +	debugfs_create_file("ts_coeff_j", 0644, pvt->dbgfs_dir, pvt,
> +			    &pvt_ts_coeff_j_fops);
> +	debugfs_create_file("ts_coeff_cal5", 0644, pvt->dbgfs_dir,  pvt,
> +			    &pvt_ts_coeff_cal5_fops);

debugfs has helpers for POD types, use them and shrink your code by ~80%.

...

> +	ret = devm_add_action_or_reset(dev, devm_pvt_ts_dbgfs_remove, pvt);
> +	if (ret) {
> +		dev_err(dev, "failed to add action to remove pvt dbgfs (%d)\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	return 0;

return devm_add_...

-- 
With Best Regards,
Andy Shevchenko


