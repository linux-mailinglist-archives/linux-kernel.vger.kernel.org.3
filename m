Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F6F5AEACE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 15:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiIFNpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 09:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbiIFNm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:42:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3ED7E327;
        Tue,  6 Sep 2022 06:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662471474; x=1694007474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0AVHmV4j+CGqbHA0Zsx4yKELCU1KzKM2ua3IIG4LOjw=;
  b=OlCgQOfPkfcHaWWyLGbWjgM8UBsh3PYTJApnX0+s9wo5BUA4VZzO+y+S
   rRVLm0hWXPNbAc1dM77+p2c80DGcH2fNr6V0lg68WDOzgh7WNp/9evNl1
   Ii2DjChUl7FL7Yz0/1+wTKq/162SlVv0tmrVBRQx0vJwceHjsg2Alq84s
   pWlkLfivdP5Kp0jy4hLevV+jPaQZbwFZrl/3Mzke8MHldJF134XY6bD+d
   63bBqqD+gQR+ewIbO5BV+vlNnjv/BooVZ3yJklFRINwZpInuOrz3MU2EQ
   /ltbvKVLf8WXa6OpxrNQWV9PoGDq5X2JPJNXYyaisTJwzKuc7PutKD9Ps
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="297378054"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="297378054"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:36:26 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="682398883"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:36:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oVYkW-0098Zi-2d;
        Tue, 06 Sep 2022 16:36:20 +0300
Date:   Tue, 6 Sep 2022 16:36:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v1 1/1] iio: adc: mxs-lradc-adc: Get rid of OF specifics
Message-ID: <YxdM1KUFcdVlnKuO@smile.fi.intel.com>
References: <20220530173324.921-1-andriy.shevchenko@linux.intel.com>
 <20220603181006.2c5cc6c4@jic23-huawei>
 <20220620204225.34d40a3f@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620204225.34d40a3f@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 08:42:25PM +0100, Jonathan Cameron wrote:
> On Fri, 3 Jun 2022 18:10:06 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> > On Mon, 30 May 2022 20:33:24 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > > First of all, the additional conversion from vIRQ, and this is exactly
> > > what is returned by platform_get_irq_byname(), to vIRQ is not needed.  
> > Confusing sentence form.  Perhaps:
> > 
> > First, the additional conversion from vIRQ (returned by platform_get_irq_byname())
> > to vIRQ is not needed.
> > 
> > > Hence, drop no-op call to irq_of_parse_and_map().
> > > 
> > > Second, assign the firmware node instead of of_node.

...

> > Seems sensible to me, but I'd like a sanity check from someone more
> > familiar with this driver.
> 
> This one has been outstanding for a few weeks. I'd still like
> an Ack or similar form someone who knows this device well.
> 
> If no one has looked at it in a week or so I'll just go with
> my judgement and pick it up.

Any news on this one? Maybe I need to resend with the better commit message?

-- 
With Best Regards,
Andy Shevchenko


