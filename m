Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E6A4FFDBC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237662AbiDMS3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiDMS3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:29:22 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4C84D9F7;
        Wed, 13 Apr 2022 11:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649874419; x=1681410419;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qm2YltahQtD5BhZA01az8bEK9fLcMHdBo7nVBNQR/jI=;
  b=Sh89F1VAOnaaO0i2OKT4X4hoMolm61vCf3AijOH1GHOD9ag7dubHn+Xa
   4OGrpoacuD3pLdyPBT4/sBz4WzHhNfWZO5MXm4k9IEpT0AkLlYGq66HQ9
   MG5BXBSD+Xoc4WqAqqYu3t9H32l2SG3vgV9mY9AJzkwL6Hpyl+s6vqq/i
   TYcUvJFBDhISHv0eYJv0ODeacJGTTDC8WmBMLep+ziMjoy3CSXrAOlOBm
   h+dd2FxPTa0gCeQpChDwImMW/9rSsBfJ/WmDNq73P5zSgyODc3tjWs0Av
   HVDz/79m7VCDYIqGelQ2ClkLc5t7fKQI80LO1HqKI4QhKjAABMHeoI1fP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="250032461"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="250032461"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 11:26:59 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="661035861"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 11:26:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nehe9-001xgI-VP;
        Wed, 13 Apr 2022 21:23:17 +0300
Date:   Wed, 13 Apr 2022 21:23:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v6 4/5] device property: Constify fwnode_handle_get()
Message-ID: <YlcVFRQ9wJIH+sjI@smile.fi.intel.com>
References: <20220408184844.22829-1-andriy.shevchenko@linux.intel.com>
 <20220408184844.22829-4-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0jnyg6n-1QRmVg1tjzu3szsG3DYqYTXAbobbKwkFhTreg@mail.gmail.com>
 <YlcUMNe5gDsEca4f@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlcUMNe5gDsEca4f@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 09:19:28PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 13, 2022 at 08:10:22PM +0200, Rafael J. Wysocki wrote:
> > On Fri, Apr 8, 2022 at 8:49 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:

...

> > > -struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode)
> > > +struct fwnode_handle *fwnode_handle_get(const struct fwnode_handle *fwnode)
> > >  {
> 
> > >         if (!fwnode_has_op(fwnode, get))
> > >                 return fwnode;
> 
> ^^^^, so it needs a casting, but then we have to comment why is so.

Note, it means that the fwnode parameter either invalid or has no given option.
It's not a problem to drop casting in the first case, but the second one should
be justified and Sakari wants to be sure that the initial container is not
const, which seems can't be achieved even with the original code.

> > Why is 0-day complaining about this one?

-- 
With Best Regards,
Andy Shevchenko


