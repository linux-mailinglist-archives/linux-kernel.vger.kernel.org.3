Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02085A8801
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 23:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbiHaVTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 17:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbiHaVTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:19:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E43F5CC4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 14:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661980769; x=1693516769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nden09wHw+7qvxDuZ4teofu7WMUZp3ya1vYxeeSmh34=;
  b=WoAlr9+bcNXUhAiK+OVeKKuftgy7myyrfOn9sE1yN4UXsvNavnhs9WPF
   QaKr+jaALO8b9rY7qcSVLclxbVWIyqfMpCOgGAykhRIP/LqEVeMSO1CjN
   PfHGZA5NWRpXmPo31YbqQs6jxUW1VESZ5DZzBwoQwJSy46VpS8mpchuxe
   UwKyNROgL6cGO6j9ew+ILfEXhwfBnJcd8h0+fYSTY5XyiNxQSI1heVkP8
   yE76BasgZ7x52BfVn7N+n7Q8FwdvWhVsx2gQElHf3f9ShFIyPgv75F8P1
   vNh7IJgfoS6cx9HoXw92MFx2ACCEqnjzNWaaVK3pt5AE8mXFKRuPYhGcg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="275295439"
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="275295439"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 14:19:29 -0700
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="701498490"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 14:19:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oTV7L-006Zl7-0J;
        Thu, 01 Sep 2022 00:19:23 +0300
Date:   Thu, 1 Sep 2022 00:19:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 3/3] regmap: spi-avmm: Use swabXX_array() helpers
Message-ID: <Yw/QWshWH9L/+Hwp@smile.fi.intel.com>
References: <20220831145407.78166-3-andriy.shevchenko@linux.intel.com>
 <202209010444.n3YAkNP1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209010444.n3YAkNP1-lkp@intel.com>
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

On Thu, Sep 01, 2022 at 04:12:01AM +0800, kernel test robot wrote:

...

>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/base/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):

Indeed, I compiled only first two patches on x86.

> >> drivers/base/regmap/regmap-spi-avmm.c:171:15: error: incompatible pointer types passing 'char *' to parameter of type 'u32 *' (aka 'unsigned int *') [-Werror,-Wincompatible-pointer-types]
>            swab32_array(buf, len / 4);
>                         ^~~
>    include/linux/swab.h:32:38: note: passing argument to parameter 'buf' here
>    static inline void swab32_array(u32 *buf, unsigned int words)
>                                         ^
>    6 warnings and 1 error generated.

While error message is valid, I believe the warnings are not related to the
patch in question and were before it.

-- 
With Best Regards,
Andy Shevchenko


