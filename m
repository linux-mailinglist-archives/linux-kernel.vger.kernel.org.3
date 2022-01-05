Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4EE485440
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 15:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbiAEOVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 09:21:22 -0500
Received: from mga02.intel.com ([134.134.136.20]:9197 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240642AbiAEOVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 09:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641392476; x=1672928476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EAdgIp26iUg6aUv/Nvv5aYtYFvk2bNewToWj30BrfSY=;
  b=iHFbOGGzhv+Zna/nEAqB/hczGzZaI+Q7u5KkOXUQ3Y/wgi+bq0oTFeO4
   4igyOYa/wvJnniJCpK2huuMMUoRWhx9C7+Oe3dqoKvBrVkuK5oR/KfNc8
   cv/Sk2WCBf4gfeyQ5ncnmRLpr2cv+/8vJO6B/ui3yloEebNin/ZxuGWh8
   /Mf5Ng6dJX3U4WVQEBwi3a9GS9b+RlWDFLk1uenJnuWXhuzlEqRMVNJvu
   uJpDrObRz0uQl/XBE13YnLL7KZLs2KMTBKmkrFM3QOD19uvYjQca0GfW/
   NSUly2nIMzYSeS4hJB+Hczfc341Exh3ZM1A9+jZ7Hzn8Gh/BApYJLZKT+
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229767577"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="229767577"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 05:55:57 -0800
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="591022758"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 05:55:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n56kP-006ipY-IF;
        Wed, 05 Jan 2022 15:54:37 +0200
Date:   Wed, 5 Jan 2022 15:54:37 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Adriana Reus <adi.reus@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: bmg160: Fix error handling in
 bmg160_core_probe
Message-ID: <YdWjHWowWXy01zaE@smile.fi.intel.com>
References: <20220105125633.21989-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105125633.21989-1-linmq006@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 12:56:30PM +0000, Miaoqian Lin wrote:
> The pm_runtime_enable will increase power disable depth.
> If the probe fails, we should use pm_runtime_disable() to balance
> pm_runtime_enable(). In the PM Runtime docs:
>     Drivers in ->remove() callback should undo the runtime PM changes done
>     in ->probe(). Usually this means calling pm_runtime_disable(),
>     pm_runtime_dont_use_autosuspend() etc.
> We should do this in error handling.

Looking into culprit commit, can you fix all of them, please?

-- 
With Best Regards,
Andy Shevchenko


