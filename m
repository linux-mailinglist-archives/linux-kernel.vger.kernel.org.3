Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E654FFD87
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237599AbiDMSN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237598AbiDMSNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:13:23 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F2742A1D;
        Wed, 13 Apr 2022 11:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649873461; x=1681409461;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0k/x2QWhXcod6LrpeYd8pZ6GKq7UkjSZY6p5v6Jf2zs=;
  b=BgHtpMjB8yk//QBs3MyTRVDyLOdmlmTDDFUTLjEAkay06CbOZRJO6lEj
   9+5T2oBoBsPmqtZOf3JyF8xkqftQcFpYF3icVSBCXU/1G5RH5msl6hnCO
   Az0yIziUBOybLV6CLe9dRjE47v/P14nK6GDLJ7w7+gQzMkpooTAxLjhMk
   Ki52GvCIfrXlrKGjBfxlthan9O+/Ez6Pi0QURd1Uo1vRoReHpsTQEY/FS
   jZmADCcUAclHV42O9EU3PTmNrsccja1F68lxhf7+PntD7mXJMgbpVJtx3
   FW1NRSNEBdQZOTq9LQhbKA7836zn60OvvS4gA9g/eQZ1ioOfDNquOrWxB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="262491549"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="262491549"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 11:10:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="661029240"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 11:10:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nehOX-001xLb-0j;
        Wed, 13 Apr 2022 21:07:09 +0300
Date:   Wed, 13 Apr 2022 21:07:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: core: Convert to use firmware node handle
 instead of OF node
Message-ID: <YlcRTB9W6Ggzt7vp@smile.fi.intel.com>
References: <20220413180202.19220-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413180202.19220-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 09:02:02PM +0300, Andy Shevchenko wrote:

...

> +	/* If the calling driver did not initialize firmware node, do it here */
> +	if (dev_fwnode(&indio_dev->dev))
> +		fwnode = dev_fwnode(&indio_dev->dev);
> +	else
> +		fwnode = dev_fwnode(indio_dev->dev.parent);

Can be also done as

	fwnode = dev_fwnode(&indio_dev->dev) ?: dev_fwnode(indio_dev->dev.parent);

-- 
With Best Regards,
Andy Shevchenko


