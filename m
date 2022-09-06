Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380745AEE72
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbiIFPQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbiIFPPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:15:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71B74DB6C;
        Tue,  6 Sep 2022 07:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662474546; x=1694010546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ybgSo2BkoIeNrG9pnEwHuQd0zdtCaKmVHLLWorPRU10=;
  b=fWWJtozf+jgh+pAEhkuFZw0bj1pHoIa70kXfVAOpA4fstDTl+7TVGPXB
   0jqRZrP91dwqaKikkAan1wDsoPZx2O9TFH7d5yHHd85PXc3d1Q7WL+KVc
   ihKELM9zLhwjYVjrXS/R7hqvRPIp456ZzamocEm5M0kaB4yt4e6bE0jHN
   pJAHfPEIxkCrZ3cLMHDbalwTu18EljJaLQNll1y+vzYhqp3GzceimE/P4
   svSjhva5LsN59nN5fbcc6Ts13PHjoV/aJlYyjOXbls/IUmHik0VNf/fUV
   x4b5uX8r1rFOqK7/QCDN5LBYRSPH2jgPzaSA/dCVHrfTunGxs+/G6aKpj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="276344870"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="276344870"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 07:26:27 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="756383261"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 07:26:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oVZWv-0099cw-3D;
        Tue, 06 Sep 2022 17:26:22 +0300
Date:   Tue, 6 Sep 2022 17:26:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        p.zabel@pengutronix.de, rtanwar@maxlinear.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hhhawa@amazon.com, jonnyc@amazon.com
Subject: Re: [PATCH v4 00/21] Variety of fixes and new features for mr75203
 driver
Message-ID: <YxdYjWYCR7YCodTX@smile.fi.intel.com>
References: <20220906083356.21067-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906083356.21067-1-farbere@amazon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 08:33:35AM +0000, Eliav Farber wrote:
> List of fixes:
>  - Fix "intel,vm-map" property to be optional.
>  - Fix VM sensor allocation when "intel,vm-map" not defined.
>  - Fix multi-channel voltage reading.
>  - Fix voltage equation for negative source input.
>  - Modify the temperature equation according to series 5 datasheet.
>  - Fix coding style issue.
> 
> List of new features:
>  - Modify "reset" property to be optional.
>  - Add optional "moortec,vm-active-channels" property to define the number
>    of active channels per VM.
>  - Add support for mr76006 pre-scaler to multiply the voltage result by 2.
>  - Add support for series 6 temperature equation.
>  - Add coefficient properties to fine tune the temperature equation.
>  - Add debugfs to read and write temperature coefficients

For all code patches (means no DT ones)
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> ---------
> 
> Changes between v3 and v4:
> *) Provide a Fixes tag for all fixes in the series.
> *) Start series with fixes.
> *) New patch to add description in moortec,mr75203.yaml.
> *) New patch to add moortec to vendor-prefixes.
> *) Fix moortec,mr75203.yaml checker errors.
> *) Remove validation of device-tree parameters.
> *) Fix per patch specific comments (detailed in each patch).
> 
> Changes between v2 and v3:
> *) Add "moortec" prefix to all new device-tree properties.
> *) Change order of patches.
> *) Add explanations to better understand the changes.
> *) Change "reset" property to be optional and remove the
>   "reset-control-skip" property.
> *) Split the patch for "fix multi-channel voltage reading" to two
>    patches.
> *) Change pre-scaler property format and fix typo (scalar --> scaler).
> *) Fix voltage equation to support negative values instead of limiting
>    value to zero.
> *) Temperature equation - protect from overflow and add clamping.
> *) Add new "moortec,ts-series" property to select between temperature
>    equation of series 5 or series 6.
> 
> Changes between v1 and v2:
>  *) Fix compilation error for patch 08/16:
>     "warning: ISO C90 forbids variable length array"
> 
> ---------
> 
> Eliav Farber (21):
>   hwmon: (mr75203) fix coding style space errors
>   dt-bindings: hwmon: (mr75203) fix "intel,vm-map" property to be
>     optional
>   hwmon: (mr75203) fix VM sensor allocation when "intel,vm-map" not
>     defined
>   hwmon: (mr75203) update pvt->v_num and vm_num to the actual number of
>     used sensors
>   hwmon: (mr75203) fix voltage equation for negative source input
>   hwmon: (mr75203) fix multi-channel voltage reading
>   hwmon: (mr75203) enable polling for all VM channels
>   dt-bindings: hwmon: (mr75203) add description for Moortec's PVT
>     controller
>   dt-bindings: hwmon: (mr75203) change "resets" property to be optional
>   hwmon: (mr75203) skip reset-control deassert for SOCs that don't
>     support it
>   dt-bindings: vendor-prefixes: add vendor prefix for Moortec
>   dt-bindings: hwmon: (mr75203) add "moortec,vm-active-channels"
>     property
>   hwmon: (mr75203) add VM active channel support
>   dt-bindings: hwmon: (mr75203) add "moortec,vm-pre-scaler-x2" property
>   hwmon: (mr75203) add VM pre-scaler x2 support
>   hwmon: (mr75203) modify the temperature equation according to series 5
>     datasheet
>   dt-bindings: hwmon: (mr75203) add "moortec,ts-series" property
>   hwmon: (mr75203) add support for series 6 temperature equation
>   dt-bindings: hwmon: (mr75203) add coefficient properties for the
>     thermal equation
>   hwmon: (mr75203) parse temperature coefficients from device-tree
>   hwmon: (mr75203) add debugfs to read and write temperature
>     coefficients
> 
>  .../bindings/hwmon/moortec,mr75203.yaml       |  97 ++++-
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  drivers/hwmon/mr75203.c                       | 387 +++++++++++++++---
>  3 files changed, 421 insertions(+), 65 deletions(-)
> 
> -- 
> 2.37.1
> 

-- 
With Best Regards,
Andy Shevchenko


