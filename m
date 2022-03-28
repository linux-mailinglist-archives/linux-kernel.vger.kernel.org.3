Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF48B4E8FE2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 10:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239212AbiC1IQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 04:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239205AbiC1IQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:16:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5281275D;
        Mon, 28 Mar 2022 01:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648455310; x=1679991310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+ly0OGq6gM5noH+O4k+peHcygWjXe0wzX2kxggo7hiU=;
  b=dUjn4iX2mLQQC+MSHoL1yNLV5Y3IWk1vaFSnm1eiSqSqDWf8t8q2ZLGk
   oTP/IMegaP1HNcNgh8bkpSdM0qbx6kyqIWypLxMMZ7Au0pZ67HsRy6Afz
   lPrABQSbTEHmV/kooRHG5NmAPm9/0o+oVogBFZ+rxRP1aZbnxewQ7S60C
   tSpp8bcyNaFrOIGYadIlD4RB0TD0kFUGN7Krzd00yCzjY+CmeWO3Iq/VL
   L8TDy2sIxF1yUFjqoLNI0yCnQLII08eqirDL4oAW/N5HDXZ8h8NV+6C/V
   7HuG+cPAx/PW30iQsf1l0sH6yOCtdlFjCVUlN4zH2uKWteWCl51UmZUAc
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="241095115"
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="241095115"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 01:15:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="694285824"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 28 Mar 2022 01:15:05 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 28 Mar 2022 11:15:05 +0300
Date:   Mon, 28 Mar 2022 11:15:05 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCHv2 1/3] software node: Power management operations for
 software nodes
Message-ID: <YkFuiarj9z9YUgOs@kuha.fi.intel.com>
References: <20201029105941.63410-1-heikki.krogerus@linux.intel.com>
 <20201029105941.63410-2-heikki.krogerus@linux.intel.com>
 <20220325164255.GA12710@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325164255.GA12710@wunner.de>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

On Fri, Mar 25, 2022 at 05:42:55PM +0100, Lukas Wunner wrote:
> Hi Heikki,
> 
> saw this linked in your WSR and felt compelled to reply... ;)
> 
> On Thu, Oct 29, 2020 at 01:59:39PM +0300, Heikki Krogerus wrote:
> > +static int software_node_runtime_suspend(struct device *dev)
> > +{
> > +	struct swnode_pm_domain *domain = to_swnode_pm_domain(dev->pm_domain);
> > +	struct swnode *swnode = dev_to_swnode(dev);
> > +	int ret;
> > +
> > +	if (domain->primary && domain->primary->ops.runtime_suspend)
> > +		ret = domain->primary->ops.runtime_suspend(dev);
> > +	else if (dev->type && dev->type->pm && dev->type->pm->runtime_suspend)
> > +		ret = dev->type->pm->runtime_suspend(dev);
> > +	else if (dev->class && dev->class->pm && dev->class->pm->runtime_suspend)
> > +		ret = dev->class->pm->runtime_suspend(dev);
> > +	else if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_suspend)
> > +		ret = dev->bus->pm->runtime_suspend(dev);
> > +	else
> > +		ret = pm_generic_runtime_suspend(dev);
> 
> This if/else ladder seems to be duplicated for every single PM callback
> in this patch.
> 
> Code size can be reduced significantly if you use offsetof() to determine
> the offset of the given callback in struct pm_ops, then pass that offset
> to a helper which contains the above-quoted if/else ladder and retrieves
> the callback.  Finally invoke the callback you've just retrieved.

I think Sakari already suggested that. I'll improve this part in the
next version.

thanks,

-- 
heikki
