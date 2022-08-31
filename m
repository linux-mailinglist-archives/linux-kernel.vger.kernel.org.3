Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECA35A7CF8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiHaMME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiHaML6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:11:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDE6D1E2E;
        Wed, 31 Aug 2022 05:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661947915; x=1693483915;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lWa2PIIJurcrWbijboRRKWuKy75PsrE4Ts6KqX3c3mY=;
  b=VpULw7K68ivqwHi1sBinAwaYsTiYUghqi5N8QXN5TLJ+sJKnYV6Jmgpy
   8XgYpbA43Qyf2o9GwPbvWN2IoWFmotUpjAwGVJ6cZmsO9Ozxrn5j4sZAz
   1lOJwo084Yi2MRKf43GBrFOWtVsjuYT2I6Qrnoi3bX0QoUb/BOVY5u3gC
   eJkS4Hs7FjuqrqP7RKwSf49MATXJgumlV2Exua08DwCAjLOA/pNT3RJpd
   lhKQHRzHuCYlLrlTjjmpLxgO53HlSwVe1FVdQExXqVPlQJRRdNEku5sMW
   sf/7zgzBM//UO4xEOsfZJ4zIoJTx1exy3g11tKsVTAmaUkwF2lnU1ho04
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="293008254"
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="293008254"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 05:11:55 -0700
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="754403975"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 05:11:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oTMZP-006MlS-29;
        Wed, 31 Aug 2022 15:11:47 +0300
Date:   Wed, 31 Aug 2022 15:11:47 +0300
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
Subject: Re: [PATCH v3 17/19] hwmon: (mr75203) parse temperature coefficients
 from device-tree
Message-ID: <Yw9QAxIn10AKaV74@smile.fi.intel.com>
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-18-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830192212.28570-18-farbere@amazon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 07:22:10PM +0000, Eliav Farber wrote:
> Use thermal coefficients from the device tree if they exist.
> Otherwise, use default values according to the series (5 or 6).
> All coefficients can be used or only part of them.
> 
> The coefficients shall be used for fine tuning the default values since
> coefficients can vary between product and product.

...

> +	ret = of_property_read_u32(np, "moortec,ts-coeff-h", &coeff_h);

of_ ?! Ditto for the rest.

> +	if (!ret)
> +		ts_coeff->h = coeff_h;

...

> +	ret = of_property_read_s32(np, "moortec,ts-coeff-j", &coeff_j);
> +	if (!ret)
> +		ts_coeff->j = coeff_j;

You may avoid conditional:

	_property_read_s32(..., "moortec,ts-coeff-j", &ts_coeff->j);


...

> +	ret = of_property_read_u32(np, "moortec,ts-coeff-cal5", &coeff_cal5);
> +	if (!ret) {

> +		if (coeff_cal5 == 0) {
> +			dev_err(dev, "moortec,ts-coeff-cal5 can't be 0\n");
> +			return -EINVAL;
> +		}

Code shouldn't be a YAML validator. Drop this and make sure you have correct
DT schema.

> +		ts_coeff->cal5 = coeff_cal5;
> +	}

Also see above.

-- 
With Best Regards,
Andy Shevchenko


