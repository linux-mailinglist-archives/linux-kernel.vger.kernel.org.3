Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238D14AC299
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441895AbiBGPJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441797AbiBGOz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:55:27 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D139EC0401C1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 06:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644245726; x=1675781726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lrDm90sIcTwCRyZv7U8fHaZS5F+uJhBQphImTVnl7cw=;
  b=CG5ZJ1mR/fUBeYZWCbJ8zhmPi4Asmoybc9xo4632VP+c48YwQRoj9vRa
   6cBUZyboWsiF2rMVYCisyu9c7MNXXTlWqGGi3VMrvzXYcnZI4lAmDDsAE
   bu5l2RIEBLXUjpJ8cQCtc3Cl7nC1boKy6r6OCgnz3LKRIjJiRkDgkaLxs
   Kcq4VwDI2iVusM9ExXzCr7KjJYPJkviP1so63lrfQCglC1m3T8QqD3MsK
   Ahv+oKQyjMoCCcS+BcHF4O6jmOVpcROPuFxo6i0b0cveDLWzdPbIS1CUT
   XzmmiDq3Pxl6ZzrtNgJOAc412+WFtzf3sco1SntaaLKTWU7EaKtNe7Suy
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="248680655"
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="248680655"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 06:55:26 -0800
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="499222182"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 06:55:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nH5PO-001wHk-5J;
        Mon, 07 Feb 2022 16:54:26 +0200
Date:   Mon, 7 Feb 2022 16:54:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rodolfo Giometti <giometti@enneenne.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] pps: generators: pps_gen_parport: Switch to use
 module_parport_driver()
Message-ID: <YgEyoemcpsvC3bcI@smile.fi.intel.com>
References: <20220207141944.8707-1-andriy.shevchenko@linux.intel.com>
 <YgEtpvGHId1xKSDY@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgEtpvGHId1xKSDY@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 03:33:10PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Feb 07, 2022 at 04:19:44PM +0200, Andy Shevchenko wrote:
> > Switch to use module_parport_driver() to reduce boilerplate code.

> You changed the functionality here :(
> 
> Currently if send_delay is too big, loading the module will fail.
> 
> Now it succeeds but binding to a device fails, that's a functional
> change.  Are you _SURE_ that is ok to do?

We already discussed that during v1 IIRC. And I told that it might even gain
additional flexibility for built-in case of the module.

> And why did you not mention any of this in the changelog text?  You
> passed this off as a mere code cleanup, no functional change :(

This is fair point. Since we end up in the same Q above. I will update
changelog in v5.

Thank you for review!

-- 
With Best Regards,
Andy Shevchenko


