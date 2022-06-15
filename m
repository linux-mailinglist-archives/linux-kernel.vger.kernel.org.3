Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B198A54C7E6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347464AbiFOLwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347349AbiFOLvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:51:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3CB4C430
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 04:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655293866; x=1686829866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JB6XDZr8/Vc4mPnXGbXPJVXKNM+3h3HjTJByMzOT75E=;
  b=QNUHHyTU7eSZkiK/dQujhA8YS5LwFvzGTZmcCA+llRjHqGNmAxRDjhLB
   zF7yvj2P4oHFi74qj9fT1oG7zVI2VX727/yp4/+oCyp3Sa6Ys2Ixlo6wa
   zBY8Huso9k07UqiNfz1tC+fOpwWxCa4GZ28YB01XKWRD8t1gjaBif4DW3
   2uT4HSnf3zXwB+2uCJA3gVGmZYUtAvxSPJ+NKtq/J+3p7GRC1gN7LYCSV
   FQrJiVS43dFd/loFmumExYa8EoFpy1PZYLVXdBZKsNH6x2nD3c9UWbwI+
   vIETYMb0FXibgRw5Xy1LxkxErqi/TvYT48kupeQZ+nhD7XuRRbqKbipxt
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="276507233"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="276507233"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 04:51:06 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="687266169"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 04:51:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o1RY5-000dO3-T4;
        Wed, 15 Jun 2022 14:51:01 +0300
Date:   Wed, 15 Jun 2022 14:51:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: Re: [PATCH v1 1/1] phy: ti: tusb1210: Don't check for write errors
 when powering on
Message-ID: <YqnHpXvZJEfhX21/@smile.fi.intel.com>
References: <20220613160848.82746-1-andriy.shevchenko@linux.intel.com>
 <bd21d5c6-ed5f-dd8c-f0bf-73f54ca8ee58@redhat.com>
 <YqiGocQ+vr9KjUHK@smile.fi.intel.com>
 <390cf16c-f07c-ebfc-08ad-25b242548953@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <390cf16c-f07c-ebfc-08ad-25b242548953@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 05:49:22PM +0200, Hans de Goede wrote:
> On 6/14/22 15:01, Andy Shevchenko wrote:
> > On Tue, Jun 14, 2022 at 01:23:21PM +0200, Hans de Goede wrote:
> >> On 6/13/22 18:08, Andy Shevchenko wrote:

...

> > [   35.126397] tusb1210 dwc3.0.auto.ulpi: GPIO lookup for consumer reset
> > [   35.126418] tusb1210 dwc3.0.auto.ulpi: using ACPI for GPIO lookup
> > [   35.126455] tusb1210 dwc3.0.auto.ulpi: using lookup tables for GPIO lookup
> > [   35.126465] tusb1210 dwc3.0.auto.ulpi: No GPIO consumer reset found
> > [   35.126476] tusb1210 dwc3.0.auto.ulpi: GPIO lookup for consumer cs
> > [   35.126485] tusb1210 dwc3.0.auto.ulpi: using ACPI for GPIO lookup
> > [   35.126538] tusb1210 dwc3.0.auto.ulpi: using lookup tables for GPIO lookup
> > [   35.126548] tusb1210 dwc3.0.auto.ulpi: No GPIO consumer cs found
> > [   40.534107] tusb1210 dwc3.0.auto.ulpi: error -110 writing val 0x41 to reg 0x80
> > 
> > (I put 5000 ms there to be sure)
> > 
> >> I'm fine with going with this workaround patch to fix things.
> 
> Ok, so I guess we should just apply this workaround patch to make
> the error non fatal. Still would be good to dig a little deeper one
> of these days and see what is going on here...

Can you give a formal tag?

-- 
With Best Regards,
Andy Shevchenko


