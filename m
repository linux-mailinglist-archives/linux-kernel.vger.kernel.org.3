Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9629F518230
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbiECKYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiECKYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:24:16 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C6E17E0B;
        Tue,  3 May 2022 03:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651573245; x=1683109245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=phdN5nG74i5taBguDD63jVJlL/xdPUdJNmc8pS9IWYU=;
  b=PF6dLeCduqg8f+7/k2oHaKxhxlA1Ftb9NXTKkOOTeDMkdbjmSOpM9vAi
   YlrTwS48ZoXE/v0QtxMRLhieDFdNQpRR5T0iONpvG0XIWqSDCMnuOwbP5
   hUgT465IMHW+33jQF6xCTgagUHhydUwUKx198BUaU6m3jKl1ou2GOA9Be
   lrcLKSfOpKgy5de5BOC5Y0EPAJBwUti5wpkOY5hGsnTI6ghgVEB9wSr29
   rCDzoDSp5xpUAWdJWvODNr5EAZqkut9b8yCRTPxGenNRTyTgUnrU870Bb
   fB0Ff84aRU3We5SyIO/tn4Cp83xL5K22DHtWutiaQwlOAhmflpFl0RJQ/
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="247990294"
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="247990294"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 03:20:45 -0700
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="733856740"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 03:20:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nlpe3-00BOzE-OL;
        Tue, 03 May 2022 13:20:39 +0300
Date:   Tue, 3 May 2022 13:20:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH v1 1/1] iio: trigger: stm32-lptimer-trigger: Make use of
 device properties
Message-ID: <YnEB97YfPYpe2aCn@smile.fi.intel.com>
References: <20220413185656.21994-1-andriy.shevchenko@linux.intel.com>
 <20220428193304.016c46a3@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428193304.016c46a3@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 07:33:04PM +0100, Jonathan Cameron wrote:
> On Wed, 13 Apr 2022 21:56:56 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Convert the module to be property provider agnostic and allow
> > it to be used on non-OF platforms.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> MAINTAINERS entry for this one uses extensive wild cards so may
> escape scripts...
> 
> +CC Fabrice.

Thanks!

Not sure it might break anything, it's quite straightforward conversion.

-- 
With Best Regards,
Andy Shevchenko


