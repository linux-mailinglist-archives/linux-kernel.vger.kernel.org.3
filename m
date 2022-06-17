Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467FB54F538
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381377AbiFQKUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381810AbiFQKUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:20:15 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BAF6A025;
        Fri, 17 Jun 2022 03:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655461215; x=1686997215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TtWxJFBWSC8dpEJIGL9p+xzotG0gM0wIrOqMj8vxH9U=;
  b=BBamBPEuLV1Wmo/6D2ojDrTSv0cWiYnOZ9Gmqm0Q1kaNc7jxhV8zqKtK
   Rlj5GwUH41hPXDCKHz96+yBEp+khMBYDSqwdWT6Qxduz57kjCjTXm9Jov
   mDVHzIskHhsoHl6OUcy4MRPnRbNhaC6dPXYdDbRLYjlL0865txX6wAxG6
   H+xMADe97SlvqGdzpyV/WtGPxskw5LERd4NtdiZitrrRYzi6koF2eZUFg
   5K+I3EI5ql/ClaW1iw/uAdZDExo2vlw9btyEiCdqeKdhTA43/q3CTr1X1
   b0gQT28lg2fsBdtHuEp4KLmUdqsevaH53ZO5P/73SjF7mnThTX5Hux4QV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="365826031"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="365826031"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 03:20:14 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="675443283"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 03:20:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o295G-000eyV-KM;
        Fri, 17 Jun 2022 13:20:10 +0300
Date:   Fri, 17 Jun 2022 13:20:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, djrscally@gmail.com,
        sakari.ailus@linux.intel.com
Subject: Re: [PATCH] media: ov7251: add missing clk_disable_unprepare() on
 error in ov7251_set_power_on()
Message-ID: <YqxVWg21PsdkMz2Y@smile.fi.intel.com>
References: <20220617013943.851327-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617013943.851327-1-yangyingliang@huawei.com>
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

On Fri, Jun 17, 2022 at 09:39:43AM +0800, Yang Yingliang wrote:
> Add the missing clk_disable_unprepare() before return
> from ov7251_set_power_on() in the error handling case.

...

>  	if (ret < 0) {
>  		dev_err(ov7251->dev, "error during global init\n");
> +		clk_disable_unprepare(ov7251->xclk);
>  		ov7251_regulators_disable(ov7251);

Logically it should go here. Please, read a code above this check.

>  		return ret;
>  	}

-- 
With Best Regards,
Andy Shevchenko


