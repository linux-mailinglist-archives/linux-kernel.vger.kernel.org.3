Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20BB4CDC77
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241684AbiCDSaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241685AbiCDS37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:29:59 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6D3A41B7;
        Fri,  4 Mar 2022 10:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646418551; x=1677954551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=T1cJyOMT/4MKGohYN7debDUVB+ANZyP5BQoa2vWx+2Y=;
  b=WmMjbRwWZnnL8eX0KxSotT3fKM09kVEuFkZlCRNeLdYCdvPKrddNNznb
   WTs8Cg96aOB3/mKl2yil9RCDgjWboeVRGpD4veO3Xumtf5bnFLcKXpf4V
   fLUmKAiiAzTA9nTQFDgjtU2m9QrgeE4QzXMeWRjDfVYC0H/wASaevWxyl
   gaylwgnPo+PUm0VWwm23tS2wQ99+nHXnLDj4rniI4fdplVtcv0hyW1mGR
   9yo3KWjHLUjE6l6zRGsUINeWWBzuVLoHenGOmzYcSA/nnxzfEivWL3q17
   CDuYsYENUHQHzGWb4lQS5NgBLZjRiecHwOwxfQ0hqHzRkn6jT0A3T9JMn
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="314751355"
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="314751355"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 10:29:10 -0800
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="710419091"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 10:29:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nQCf8-00BKb2-UB;
        Fri, 04 Mar 2022 20:28:22 +0200
Date:   Fri, 4 Mar 2022 20:28:22 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v4 3/3] iio: temperature: ltc2983: Make use of device
 properties
Message-ID: <YiJaRoIVSU8fIly3@smile.fi.intel.com>
References: <20220304180257.80298-1-andriy.shevchenko@linux.intel.com>
 <20220304180257.80298-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220304180257.80298-3-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 08:02:57PM +0200, Andy Shevchenko wrote:
> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
> The conversion slightly changes the logic behind property reading for
> the configuration values. Original code allocates just as much memory
> as needed. Then for each separate 32- or 64-bit value it reads it from
> the property and converts to a raw one which will be fed to the sensor.
> In the new code we allocate the amount of memory needed to retrieve all
> values at once from the property and then convert them as required.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Nuno Sá <nuno.sa@analog.com>
> ---
> v4: added checks for error pointer (Nuno), added Tb tag (Nuno)
> v3: no changes

Forgot to add, that this patch should work without fwnode fix.
To test fwnode fix, the part of the NULLifying ref should be
(temporary) dropped.

-- 
With Best Regards,
Andy Shevchenko


