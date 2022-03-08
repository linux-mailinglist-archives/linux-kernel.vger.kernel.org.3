Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371184D146B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345762AbiCHKMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345765AbiCHKLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:11:50 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509B343396;
        Tue,  8 Mar 2022 02:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646734240; x=1678270240;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2NchkUqJuLC9fxChOVIJfJ5CdtV5WqGvdfd1Xbt72Hk=;
  b=EMsbL1xL7zN+sf3KxkUN+Bgv8/6CbCVPOxO0OJMVTVU9KME76BJ9wgBo
   sJ61GSccUQ02zhwTShdbfabIscc8ZjossYtL/6B9n5FE9v5/uwY77Zz9u
   keFJmbcHeTrZf6sbNTQX/6wrfD/Wnc5RUowgUGHNrkB0F+BmZR2SR00C1
   gxlY9DqFD6AKOXp3hj8ksgCQGR53OiCVF4lFiPKfLzD0raW16C44h4aaV
   kQLzEX5XeB2jOIaRBj+3oVqsmcMqKW9p0GQXZ/cCHJvysTGARDdH3Q8ZE
   g+c+pkNQgyQoFpAKgS0LGRc0vADYNDZCJD5HaSCHOosT3MG6K6A3ZhpzD
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="235256129"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="235256129"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 02:10:39 -0800
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="641695907"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 02:10:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nRWmv-00DI2B-Bv;
        Tue, 08 Mar 2022 12:09:53 +0200
Date:   Tue, 8 Mar 2022 12:09:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v3 1/1] device property: Allow error pointer to be passed
 to fwnode APIs
Message-ID: <YicrcRUXVKzETq+l@smile.fi.intel.com>
References: <20220307202949.75300-1-andriy.shevchenko@linux.intel.com>
 <PH0PR03MB67867223806C29FF1DF90E6499099@PH0PR03MB6786.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR03MB67867223806C29FF1DF90E6499099@PH0PR03MB6786.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 09:25:07AM +0000, Sa, Nuno wrote:
> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Monday, March 7, 2022 9:30 PM

...

> > v3: dropped test of secondary fwnode (Nuno), added tag (Nuno),
> > amended commit message
> > v2: adjusted the entire fwnode API (Sakari)
> > 
> > Nuno, can you re-test this with the ltc2983 series to be sure it is still
> > okay?
> 
> Still works!

Thanks for confirming!

...

> > @@ -988,14 +998,14 @@ fwnode_graph_get_next_endpoint(const
> > struct fwnode_handle *fwnode,
> >  		parent = fwnode_graph_get_port_parent(prev);
> >  	else
> >  		parent = fwnode;
> > +	if (IS_ERR_OR_NULL(parent))
> > +		return NULL;

(1)

> >  	ep = fwnode_call_ptr_op(parent, graph_get_next_endpoint,
> > prev);
> > +	if (ep)
> > +		return ep;
> 
> I might be missing something but before the check being done was
> 'if (IS_ERR_OR_NULL(ep)'. Is there anyway for ep to be an error
> pointer? Looking at OF, It seems that only NULL or a valid pointer
> is being returned. Did not looked at others implementations of
> though...

Yes, the IS_ERR() part is redundant there. I was quite confused with
that code while working on this change. So, now it looks much clearer
what's going on and what kind of values are being expected. This also
justifies the choice of returned value in (1).

-- 
With Best Regards,
Andy Shevchenko


