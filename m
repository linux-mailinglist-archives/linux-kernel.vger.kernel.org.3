Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4F65A7CE3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiHaMGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiHaMGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:06:36 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D0F21248;
        Wed, 31 Aug 2022 05:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661947594; x=1693483594;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BGu3/5fG8xHIe5yMcSH1ib5RNNwENF77HYJJciCvzEQ=;
  b=RGbMveID76jBMxC0Kqw6DRgFQvH7lMaNJoP42pb+BoK3LOy44gdWlHKM
   qDKJ/dFtefBe8ounM726gqTqAXFUq2tFLqwO85aEDztEP060i/VBsmWB+
   bBs1P8VC5AmthbvdwfHHJ/U1jHuuMY27uUhkyJCQ/FrSkxw+k2XhkUIM3
   /NEX1kOTOMjvL+wc3w2+XwXQaG/+Z+4MIztKEAqYaZgPCeh1BHfuSQhXw
   lqesMF6YLFju1d9lDf8xD+csTF9o47JHBUtY+6FKqkb6qVu/sEyjK3wRf
   4e3hkJQuLuRqix7CM0IWCQt6oDNkZ356b1B9qeQQjkQfKPfG5kNIDsuVR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="296216014"
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="296216014"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 05:06:34 -0700
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="680402279"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 05:06:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oTMUE-006MbU-01;
        Wed, 31 Aug 2022 15:06:26 +0300
Date:   Wed, 31 Aug 2022 15:06:25 +0300
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
Subject: Re: [PATCH v3 13/19] hwmon: (mr75203) modify the temperature
 equation according to series 5 datasheet
Message-ID: <Yw9OwUUD/t9DESQb@smile.fi.intel.com>
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-14-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830192212.28570-14-farbere@amazon.com>
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

On Tue, Aug 30, 2022 at 07:22:06PM +0000, Eliav Farber wrote:
> Modify the equation and coefficients used to convert the digital output
> to temperature according to series 5 of the Moortec Embedded Temperature
> Sensor (METS) datasheet:
> T = G + H * (n / cal5 - 0.5) + J * F
> 
> Where:
> *) G = 60, H = 200, cal5 = 4094, J = -0.1.
> *) F = frequency clock in MHz.
> *) n is the digital output.
> 
> In code, the G, H and J coefficients are multiplied by a factor of 1000
> to get the temperature in milli-Celsius.
> Final result is clamped in case it exceeds min/max thresholds.
> 
> Change is done since it is not clear where the current equation and

not clear -> unclear

> coefficients came from.

...

> +#define PVT_TEMP_MIN		-40000
> +#define PVT_TEMP_MAX		125000

Unit suffix? _mC perhaps would be enough.

-- 
With Best Regards,
Andy Shevchenko


