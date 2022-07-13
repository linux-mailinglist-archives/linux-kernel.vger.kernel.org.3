Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DC85734C9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbiGMK5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236094AbiGMK5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:57:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D6BFFE1E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 03:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657709853; x=1689245853;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SjKb/QwCDJiVQGSCvxcetbNT2QIOZOrT+XnxiucJwrA=;
  b=Ty+ELcllACVg/GsmUS+4+I8lduz4rYtvBA3SAs1ks6rJey1yUqGXm2+f
   zIQQlqTwz/azDCeiuuyMtOY04pobW+J7Bfmtt0YFiIpRZyvMtBu0he34U
   R0sbPbkA5/8xYWo/FpG+hEncasTB6NVUTh9/XA5SMjftbmsj++6WX2r74
   2jxeq9Mw5tL8is5rkuAqtH5QRSvURmRK5zU/BzQSsu88ivCLlC7auHUvD
   gD9gFZMIaFu3KNrd8MINfPD6PRgSTd/SrZIGl0Tb+cJKhlYUbPcreuuHm
   GoRhSFLqPwVNSr1qGUzb30HihZ5a5CKXfQSlTJ2hbzcfcvlt8+hUoi5/z
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="346860948"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="346860948"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 03:57:31 -0700
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="685119267"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 03:57:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oBa3a-001CEY-2d;
        Wed, 13 Jul 2022 13:57:26 +0300
Date:   Wed, 13 Jul 2022 13:57:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Provide an SSP type to the SPI
 driver
Message-ID: <Ys6lFqm4/T/Kb3et@smile.fi.intel.com>
References: <20220702211903.9093-1-andriy.shevchenko@linux.intel.com>
 <Ys593spfcFtoILhS@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys593spfcFtoILhS@google.com>
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

On Wed, Jul 13, 2022 at 09:10:06AM +0100, Lee Jones wrote:
> On Sun, 03 Jul 2022, Andy Shevchenko wrote:

> > +static const struct property_entry spt_spi_properties[] = {
> > +	PROPERTY_ENTRY_U32("intel,spi-pxa2xx-type", LPSS_SPT_SSP),
> > +	{ }
> > +};
> > +
> > +static const struct software_node spt_spi_node = {
> > +	.properties = spt_spi_properties,
> > +};
> > +
> >  static const struct intel_lpss_platform_info spt_info = {
> >  	.clk_rate = 120000000,
> > +	.swnode = &spt_spi_node,
> >  };
> 
> IMHO, this is a rubbish interface.
> 
> The amount of 10-line changes required to store a 32-bit value is
> depressing.  Is there not a reduced interface for storing small pieces
> of data that doesn't require arrays of structs?

The part of it that makes it longer because of differentiating the hardware,
but see the difference here:

In this change:
	95 insertions(+), 46 deletions(-)

In the follow up SPI driver cleaning (not yet submitted):
	14 insertions(+), 121 deletions(-)


-- 
With Best Regards,
Andy Shevchenko


