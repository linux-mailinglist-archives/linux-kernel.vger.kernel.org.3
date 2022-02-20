Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDA54BCE23
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 12:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbiBTLSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 06:18:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiBTLSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 06:18:03 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E85143AFB;
        Sun, 20 Feb 2022 03:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645355863; x=1676891863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wFiGHzKu/gkWdPi94TIZ1NxsAlvi0yITyD0myZyZrQc=;
  b=DuyfglcsIbXJoAUdkKW4gcOJXIEti9jsjsslsMnu2O5xQjq3rtaGbncv
   m4U7b+iNLzJtWwh+lt+1p0rCuOPKjXTFUJ9yqzM+CRSZOk9rw9j5TsYhY
   iQXBNAomp/lJI4RFKy2omkc5ok0nFDIzATZ5xolAtOuEnRFnHCbykcv79
   4JJNq4HMIkKZsptTN2RVZSHXhED3dNSbsg6sLbcHuTqfYhlobDYskYYXQ
   8iUGIf9ENP4/Mq3yO9lQ9xGSuqpRKhQgV5lTofDvAnoEhsTDMU4Pdv9xa
   Y+J0dgOVpZ7iE7nw2+z+eARWRSDEldZpYERm1tYvElGVgTICJ9fbEHL+y
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10263"; a="337795825"
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="337795825"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 03:17:42 -0800
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="638243794"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 03:17:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nLkCs-006Uow-OJ;
        Sun, 20 Feb 2022 13:16:46 +0200
Date:   Sun, 20 Feb 2022 13:16:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 1/6] device property: Helper to match multiple
 connections
Message-ID: <YhIjHjMrhUpM0ucV@smile.fi.intel.com>
References: <20220208031944.3444-1-bjorn.andersson@linaro.org>
 <20220208031944.3444-2-bjorn.andersson@linaro.org>
 <YgOz6K55Oi2Si4pU@smile.fi.intel.com>
 <Yg/s3eKB2wLEQTgY@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yg/s3eKB2wLEQTgY@ripper>
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

On Fri, Feb 18, 2022 at 11:00:45AM -0800, Bjorn Andersson wrote:
> On Wed 09 Feb 04:30 PST 2022, Andy Shevchenko wrote:
> > On Mon, Feb 07, 2022 at 07:19:39PM -0800, Bjorn Andersson wrote:

...

> > > +int fwnode_connection_find_matches(struct fwnode_handle *fwnode,
> > > +				   const char *con_id, void *data,
> > > +				   devcon_match_fn_t match,
> > > +				   void **matches, unsigned int matches_len)
> > > +{
> > > +	unsigned int count;
> > > +
> > > +	if (!fwnode || !match || !matches)
> > 
> > !matches case may be still useful to get the count and allocate memory by
> > caller. Please, consider this case.
> > 
> 
> As discussed in previous version, and described in the commit message,
> the returned value of "match" is a opaque pointer to something which
> has to be passed back to the caller in order to be cleaned up.
> 
> E.g. the typec mux code returns a pointer to a typec_mux/switch object
> with a refcounted struct device within, or an ERR_PTR().
> 
> So unfortunately we can must gather the results into matches and pass it
> back to the caller to take consume or clean up.


It's fine. You have **matches, means pointer of an opaque pointer.
What I'm talking about is memory allocation for and array of _pointers_.
That's what caller very much aware of and can allocate on heap. So, please
consider this case.

-- 
With Best Regards,
Andy Shevchenko


