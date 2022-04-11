Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694F54FC175
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348269AbiDKPwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348265AbiDKPwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:52:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324AEF21;
        Mon, 11 Apr 2022 08:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649692192; x=1681228192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gyDoMc98GJmanTHsL9qK4pOeFXXJEueQFvdOn+5W79Q=;
  b=amlsel1Uy9yIbiytLhirB8tp8mpgRstrJ90lUEyqAAmyFZLMARkfR7Eu
   5d5QDnl+FkGSTqL5dkKbm/vlvEtuInXaYiY4q/VuK+2zlWgfi3Ob3S9yR
   2ndh6do8c/9ap3JUZ7FESw0kYbojapUR/2kEKiKAcBLXUcF3x3C9MOM/O
   grzHdNRIQShBOEWP5CZ6qv/NGEVCcr2SeRkIScHlJJs8/Nf1oM46Okvp0
   nXe0sHDz244+uKrx1nYSlUeqGcJmgQVRlUU/EclKDOCjdVAV38ZKNtRlG
   qnehE2fXfGC8g0fBajnryQDuFb1riB1olRaSiHt0hJveFsd+MPzPjFRaI
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="262326628"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="262326628"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 08:49:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="660096199"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 08:49:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ndwEx-001J5c-Tx;
        Mon, 11 Apr 2022 18:46:07 +0300
Date:   Mon, 11 Apr 2022 18:46:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v6 1/5] device property: Allow error pointer to be passed
 to fwnode APIs
Message-ID: <YlRNPyxHcNRQE/5A@smile.fi.intel.com>
References: <20220408184844.22829-1-andriy.shevchenko@linux.intel.com>
 <YlQyEz3/J0rb2Hew@smile.fi.intel.com>
 <YlQ69jMduq/evgTt@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlQ69jMduq/evgTt@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 04:28:06PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 11, 2022 at 04:50:11PM +0300, Andy Shevchenko wrote:
> > On Fri, Apr 08, 2022 at 09:48:40PM +0300, Andy Shevchenko wrote:
> > > Some of the fwnode APIs might return an error pointer instead of NULL
> > > or valid fwnode handle. The result of such API call may be considered
> > > optional and hence the test for it is usually done in a form of
> > > 
> > > 	fwnode = fwnode_find_reference(...);
> > > 	if (IS_ERR(fwnode))
> > > 		...error handling...
> > > 
> > > Nevertheless the resulting fwnode may have bumped the reference count
> > > and hence caller of the above API is obliged to call fwnode_handle_put().
> > > Since fwnode may be not valid either as NULL or error pointer the check
> > > has to be performed there. This approach uglifies the code and adds
> > > a point of making a mistake, i.e. forgetting about error point case.
> > > 
> > > To prevent this, allow an error pointer to be passed to the fwnode APIs.
> > 
> > Rafael and Greg, if this okay for you, can the first three patches be
> > applied, so we will have at least the fix in and consider constification
> > a further work?
> 
> Give us a chance, you sent this on friday and are asking about it first
> thing Monday morning?
> 
> Please go and review other patches sent on the list to help us catch up.

OK! Reviewed (actually commented on) a few patches so far.

-- 
With Best Regards,
Andy Shevchenko


