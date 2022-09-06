Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542805AEE46
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239935AbiIFO53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238907AbiIFO4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:56:51 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41E5A6C7F;
        Tue,  6 Sep 2022 07:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662473557; x=1694009557;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wFM4+ipDAARS/vDb2JTydobm8ytemLFf7Wn8G0k0SmU=;
  b=Li0A6WGq4wK3aeq6/zO0KStWldRG58pIpm770cUR5kg1RsGHoBUXC2s8
   Vpzt6e4aGQYxMPjF0gfck4DqqD2D/BjIEPQigLiTWm7CDeDOQo5KGz2sr
   ok2IFxtHw+XENSCp1+LazlggqHe0qk7yTwApTTyNiAbO7+LL47xWan2lc
   AAj1DU4blE4317LqCBZ5OZ+9RtOwt0Y36DZR0wKW+FSGgOpv+JNsu4FQL
   uICDiswF9N4kFvLN9faMtgXfVQPrg4qFXiS9LHc3CzIGvZcg2pKPvYlFj
   nLRwWVeVRpoe2mAalrOzakJC1VNkfW1GxXlkRTOzf8nBmwCeaSBOilpC/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="382898766"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="382898766"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 07:10:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="682410019"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 07:10:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oVZHu-0099IH-35;
        Tue, 06 Sep 2022 17:10:50 +0300
Date:   Tue, 6 Sep 2022 17:10:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        p.zabel@pengutronix.de, rtanwar@maxlinear.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hhhawa@amazon.com, jonnyc@amazon.com
Subject: Re: [PATCH v4 06/21] hwmon: (mr75203) fix multi-channel voltage
 reading
Message-ID: <YxdU6hiwblhT2I5u@smile.fi.intel.com>
References: <20220906083356.21067-1-farbere@amazon.com>
 <20220906083356.21067-7-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906083356.21067-7-farbere@amazon.com>
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

On Tue, Sep 06, 2022 at 08:33:41AM +0000, Eliav Farber wrote:
> Fix voltage allocation and reading to support all channels in all VMs.
> Prior to this change allocation and reading were done only for the first
> channel in each VM.
> This change counts the total number of channels for allocation, and takes
> into account the channel offset when reading the sample data register.

...

> +		total_ch = ch_num * vm_num;
> +		in_config = devm_kcalloc(dev, total_ch + 1,
>  					 sizeof(*in_config), GFP_KERNEL);

Strictly speaking this should be `size_add(size_mul(...) ...)` construction
from overflow.h.

		total_ch = size_mul(ch_num, vm_num);
		in_config = devm_kcalloc(dev, size_add(total_ch, 1),
					 sizeof(*in_config), GFP_KERNEL);

Alternatively before doing all these, add a check

		if (array3_size(ch_num, vm_num, sizeof(*in_config)) < SIZE_MAX - sizeof(*in_config))
			return -EOVERFLOW;

But this is a bit monstrous. Seems like the above looks and feels better.

Also for backporting purposes perhaps it's fine to do without using those macro
helpers.

>  		if (!in_config)
>  			return -ENOMEM;


-- 
With Best Regards,
Andy Shevchenko


