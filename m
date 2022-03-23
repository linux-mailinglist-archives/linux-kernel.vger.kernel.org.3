Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1394E57AE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343707AbiCWRih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343733AbiCWRiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:38:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40A47EA0C;
        Wed, 23 Mar 2022 10:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648056997; x=1679592997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dgKB7CXUgH7XBh9+a33zflluzHIzN/Jnr1ZGBzp7T/c=;
  b=l8nx9v4Mq32PxU/I4Rk7LP5d11vm3xhq04wmaMf1S+BbrdVJx+JM7/ZD
   /86geW0he9e1gxmBSC1e/0WJuXhhEDfnOitPPXby/t7nZz2uWv4u8MYdj
   rz30IpWJ7vvD2CTkqIii+2OXc5fwuBpM/zdMZpu6WFK9/XPUs7Tqqn34y
   gXKoZgSme50IdxAuH1Yhf+uaSkAj+eTQ1DaJTKJA8wPT8+AAyeiSZeszp
   18H11VqW+we4Q0ue7EMT7W+gr23pZlncia6HNfRdXb51zly4F8zQOLD2r
   L/Dft7kA86HZ/w/Sf/NP9YT99pGbpnQBJUfqwQzH02U1j/NCNBQAS4Nbf
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="257006208"
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="257006208"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 10:23:30 -0700
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="561004083"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 10:23:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nX4hA-005KMq-Jz;
        Wed, 23 Mar 2022 19:22:52 +0200
Date:   Wed, 23 Mar 2022 19:22:52 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] spidev: Do not use atomic bit operations when
 allocating minor
Message-ID: <YjtXbDyCWZxKnf4Y@smile.fi.intel.com>
References: <20220323140215.2568-1-andriy.shevchenko@linux.intel.com>
 <YjtNJe4Pgp3WIwOa@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjtNJe4Pgp3WIwOa@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 04:39:01PM +0000, Mark Brown wrote:
> On Wed, Mar 23, 2022 at 04:02:12PM +0200, Andy Shevchenko wrote:
> > There is no need to use atomic bit operations when allocating a minor
> > number since it's done under a mutex. Moreover, one of the operations
> > that is in use is non-atomic anyway.

...

> >  	if (status == 0) {
> > -		set_bit(minor, minors);
> > +		__set_bit(minor, minors);
> >  		list_add(&spidev->device_entry, &device_list);
> 
> There's no *need* but the __ looks suspicious...  what's the upside
> here?

It's exactly what is written in the commit message

__*_bit() are non-atomic
*_bit() are atomic

Since they are wrapped by mutex, the atomic ones are not needed.

-- 
With Best Regards,
Andy Shevchenko


