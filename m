Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22204BE19D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381628AbiBURUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 12:20:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381608AbiBURUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 12:20:41 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206D5C5E;
        Mon, 21 Feb 2022 09:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645464018; x=1677000018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d5MBD6jseNDfERr7Px+b+BKh2csyDhPOjHVWEWXUWp0=;
  b=PMNt1bh2YdTAgOcfTGN5Higc428uAc7YoEcSlhJaAsU55sUBY76cEALN
   fo2/VUyJh3jokrQYzihp4YW7CRNx5hPC81Huv/LjDCj39F3A8asExt2B0
   /4CkL5Oj9U/iPOUTu7pcb2GIkP33Ph6zX5nVDfPV+06s73FO6D9XOs0zD
   CICNNTPSmktZ4vZr/50bGrCqFAMyD7TaBjyTPPdIrtJRXQxSjfgwbBgpW
   p+krrkk2tfID6lJNqambxdWUBJwD2k0Trdu1YVeLAeU17UVkoxi9dtRl7
   V5hRHbBakNDrQvEpxh3snDAkI79dQCLRgWt2ZRJYCXAdRfhKOdzV/6WJl
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="251729331"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="251729331"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 09:20:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="490502556"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 09:20:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nMCLK-006rcp-SM;
        Mon, 21 Feb 2022 19:19:22 +0200
Date:   Mon, 21 Feb 2022 19:19:22 +0200
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
Message-ID: <YhPJmiFSH8s94il7@smile.fi.intel.com>
References: <20220208031944.3444-1-bjorn.andersson@linaro.org>
 <20220208031944.3444-2-bjorn.andersson@linaro.org>
 <YgOz6K55Oi2Si4pU@smile.fi.intel.com>
 <Yg/s3eKB2wLEQTgY@ripper>
 <YhIjHjMrhUpM0ucV@smile.fi.intel.com>
 <YhMbLsvF8p/ce+mg@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhMbLsvF8p/ce+mg@ripper>
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

On Sun, Feb 20, 2022 at 08:55:10PM -0800, Bjorn Andersson wrote:
> On Sun 20 Feb 03:16 PST 2022, Andy Shevchenko wrote:
> > On Fri, Feb 18, 2022 at 11:00:45AM -0800, Bjorn Andersson wrote:
> > > On Wed 09 Feb 04:30 PST 2022, Andy Shevchenko wrote:
> > > > On Mon, Feb 07, 2022 at 07:19:39PM -0800, Bjorn Andersson wrote:

...

> > > > > +int fwnode_connection_find_matches(struct fwnode_handle *fwnode,
> > > > > +				   const char *con_id, void *data,
> > > > > +				   devcon_match_fn_t match,
> > > > > +				   void **matches, unsigned int matches_len)
> > > > > +{
> > > > > +	unsigned int count;
> > > > > +
> > > > > +	if (!fwnode || !match || !matches)
> > > > 
> > > > !matches case may be still useful to get the count and allocate memory by
> > > > caller. Please, consider this case.
> > > 
> > > As discussed in previous version, and described in the commit message,
> > > the returned value of "match" is a opaque pointer to something which
> > > has to be passed back to the caller in order to be cleaned up.
> > > 
> > > E.g. the typec mux code returns a pointer to a typec_mux/switch object
> > > with a refcounted struct device within, or an ERR_PTR().
> > > 
> > > So unfortunately we can must gather the results into matches and pass it
> > > back to the caller to take consume or clean up.
> > 
> > It's fine. You have **matches, means pointer of an opaque pointer.
> > What I'm talking about is memory allocation for and array of _pointers_.
> > That's what caller very much aware of and can allocate on heap. So, please
> > consider this case.
> 
> I'm sorry, but I'm not sure what you're looking for.
> 
> 
> I still interpret your comment as that it would be nice to be able to do
> something like:
> 
> count = fwnode_connection_find_matches(fwnode, "orientation-switch",
> 				       NULL, typec_switch_match, NULL, 0);
> 
> based on the returned value the caller could allocate an array of
> "count" pointers and then call the function again to actually fill out
> the count elements.

Yes, that's what I want from the generic fwnode APIs.
(Keyword: generic)

> The problem with this is that, typec_switch_match() does:

As you stated, the problem is in the typec_switch_match(). So, it's not related
to the fwnode, but how you are using it.

> void *typec_switch_match(fwnode, id, data) {
> 	struct device *dev = find_struct_device(fwnode, id);
> 	if (!dev)
> 		return NULL;
> 	get_device(dev);
> 	return container_of(dev, struct typec_switch, dev);
> }
> 
> So if we call the match function and if that finds a "dev" it will
> return a struct typec_switch with a refcounted struct device within.

fwnode (as being an abstraction on top of the others) has no knowledge
about this. And more important should not know that.

> We can see if that's NULL or not and will be able to return a "count",
> but we have no way of releasing the reference acquired - we must return
> the void pointer back to the client, so that it can release it.

The caller (if it wants to!) may create different callbacks for count and real
matching, no?

> My claim is that this is not a problem, because this works fine with any
> reasonable size of fwnode graphs we might run into - and the client will
> in general have a sense of the worst case number of matches (in this
> series its 3, as there's 3 types of lanes that can be switched/muxed
> coming out of a USB connector).

-- 
With Best Regards,
Andy Shevchenko


