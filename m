Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335E9565BAF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbiGDQVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbiGDQUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:20:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D745F59;
        Mon,  4 Jul 2022 09:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656951622; x=1688487622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xklgiuMjen9DU5ORZxBTUv7D732UpNcojJAfn/+LK/w=;
  b=Zr/OFx9TY83sGk456d0IF1ZGcumdPZ3J9I+QCarkXUZCJWMyzxvRneD0
   chk5C51JExToaoPpZyRpwUdC4xIzk8XhLvC1DSKRXWIa8ysr+XdP3Q681
   VjOGwryzb5pI5rqqFj2af5HdP6FuRSL6ntL08ETT0cBclP0utO7KGAqUH
   MEJaeNVnzwU4xAjKmq7YpuqyOUAq2RJuViJKfbXppYfF5o3SdSkw/j0iS
   CdVG6kDh0yrF54Ug/uSKRATZWFHqd/mk4Ob6ACJzy9kekxg8xByBXycFv
   fjkUeEx52DaIxfTu1g7F0aTOm55WN/ZNZKEUsR0K8H0TRkr9uTCQf97L3
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="369487905"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="369487905"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 09:20:21 -0700
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="542641244"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 09:20:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o8Oly-0015AC-0b;
        Mon, 04 Jul 2022 19:18:06 +0300
Date:   Mon, 4 Jul 2022 19:18:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Michal Simek <michal.simek@amd.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Conall O'Griofa <conall.o'griofa@xilinx.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v1 1/2] iio: adc: xilinx-xadc: Make use of device
 properties
Message-ID: <YsMSvSJdc/eVqnYU@smile.fi.intel.com>
References: <20220531141118.64540-1-andriy.shevchenko@linux.intel.com>
 <20220603183224.540b3808@jic23-huawei>
 <e2efcf6d-ed85-dc6e-64e1-f0efedd4a673@amd.com>
 <YsBYvPKfZRLygCyz@smile.fi.intel.com>
 <1d6eba67-5a63-e1b2-c9cd-583b950ddca6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d6eba67-5a63-e1b2-c9cd-583b950ddca6@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 12:43:26PM +0200, Michal Simek wrote:
> On 7/2/22 16:39, Andy Shevchenko wrote:
> > On Mon, Jun 20, 2022 at 04:58:04PM +0200, Michal Simek wrote:

...

> > Hmm... No news?
> 
> Anand unfortunately left the company. I have asked testing team to test this
> patch and they can't see any issue.
> That's why:
> Acked-by: Michal Simek <michal.simek@amd.com>

Ah, thanks! Jonathan, I guess we are set to apply now.

-- 
With Best Regards,
Andy Shevchenko


