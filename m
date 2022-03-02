Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04ECD4CA9A4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbiCBPv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236478AbiCBPvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:51:52 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB78CCC54;
        Wed,  2 Mar 2022 07:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646236252; x=1677772252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D1uiCJhxBtjA4oR6+KrFSQrnollkmcJKddeu5cuEKpA=;
  b=fo+AMXorGWqlxpuUdk7argusDkRoI7GN9g0+Wye9eLm/VgpLaVn3dG0S
   xd4BAkLamXwv93XdKXTQ3G8yoBP5aOhZyzLmlBh/s6AK1eFp/4rlWWoUS
   ey6UMe5FuyXDy4WnIk7fCPNhly9hZqWQ4F6dVRn6kJy/eJagrNjgpnY+q
   NxitRwwLAUmk8rkcOskpTKAy0UY1ls+R5scJz1R9TsWTM5IvzJ8uqZDXp
   1goMlZM3oaRK3Dmr4qKdEpo3Dz/LRlSJCnT21Uh7BQk8RDEwbO97R5BMm
   ydhcDalPOiBON853oOmHHj/AqAGccD0k5K3tj6Sb+62lzDjFTN7BVRaFr
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="234048577"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="234048577"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 07:50:40 -0800
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="709553789"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 07:50:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nPREc-00AMq2-Dc;
        Wed, 02 Mar 2022 17:49:50 +0200
Date:   Wed, 2 Mar 2022 17:49:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v1 1/1] ACPI: Switch to use list_entry_is_head() helper
Message-ID: <Yh+SHs4CEWkiLxAe@smile.fi.intel.com>
References: <20220211110423.22733-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211110423.22733-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 01:04:23PM +0200, Andy Shevchenko wrote:
> Since we got list_entry_is_head() helper in the generic header,
> we may switch the ACPI modules to use it. This eliminates the
> need in additional variable. In some cases it reduces critical
> sections as well.

Besides the work required in a couple of cases (LKP) there is an
ongoing discussion about list loops (and this particular API).

Rafael, what do you think is the best course of action here?

-- 
With Best Regards,
Andy Shevchenko


