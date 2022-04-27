Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510FB512133
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240355AbiD0Pp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240386AbiD0Ppw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:45:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5EF4BB8D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651074158; x=1682610158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XUPw6zKcEmTgJvPIDxaK2dswQjcD22fWJPyux4y0Zso=;
  b=gn3OACcpsPlkTmywBN/gDRanlG8+IEMUQSgW+Jr53cCdoFknss6i9UtM
   82iDM7zqPwgedQOkUoeu1Dd7/eLFiWEn1qNQcGPn6IdcZNOSjSU+14kBu
   Eae0qV8g1R0KnI0LBHmItM7ZGAdQy8k4uPJXDMkaKWysxZ78CeMEfzFJr
   odWM2DjOvQ+TTn/tknbUgJZ/K2eksuBNHLmIUe6tgAEosEYUSwPtpzBWb
   b82LzR+nShKvidbBw18Wtw1mOCZFL77oUMIY6pATdZcmCbL1ZSySUQgqH
   BSgyczOEorrhZ+KMfwJBDVt8XoMC5qH9WAcWvo5emZ8wAroRe79Uj1/Z2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="247898790"
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="247898790"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 08:17:35 -0700
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="680829030"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 08:17:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1njjQ1-008sao-CJ;
        Wed, 27 Apr 2022 18:17:29 +0300
Date:   Wed, 27 Apr 2022 18:17:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jonathan.Cameron@huawei.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, rf@opensource.cirrus.com,
        pmladek@suse.com, ying.huang@intel.com, dave.hansen@intel.com
Subject: Re: [PATCH v2 2/2] mm: Covert sysfs input to bool using kstrtobool()
Message-ID: <YmleidxlL2/d859f@smile.fi.intel.com>
References: <20220426170040.65487-1-jvgediya@linux.ibm.com>
 <20220426170040.65487-2-jvgediya@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426170040.65487-2-jvgediya@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 10:30:40PM +0530, Jagdish Gediya wrote:
> Sysfs input conversion to corrosponding bool value e.g. "false" or "0"
> to false, "true" or "1" to true are currently handled through strncmp
> at multiple places. Use kstrtobool() to convert sysfs input to bool
> value.

...

> +	if (kstrtobool(buf, &numa_demotion_enabled))
>  		return -EINVAL;

Hmm... The commit message doesn't explain what's wrong with the error codes
returned by kstrtobool(). Can't it be

	ret = kstrtobool();
	if (ret)
		return ret;

?

...

> +	if (kstrtobool(buf, &enable_vma_readahead))
>  		return -EINVAL;

Ditto.

-- 
With Best Regards,
Andy Shevchenko


