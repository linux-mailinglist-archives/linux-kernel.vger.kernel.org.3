Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E6A4CD58D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238435AbiCDNyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiCDNyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:54:13 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16884532E5;
        Fri,  4 Mar 2022 05:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646402006; x=1677938006;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EBV+8A/WSH+HEZn2WXFADUJhrDTrMNNGavJydqTbqEE=;
  b=TpyPI486IwuLTlbBIKbByPctIkCTcqCopfetMFCemqeHECpunCMyY3h4
   KkOYqRzkM71RIs73pv5+iG0+KxderaHJsVtZTNFrpED3Wg4h25/vIJeob
   8rFm8/M0TTWls1s98+p/98Ghb5hQjucAroOFCXjc19Go0LNo1dR6WPuTk
   GzxTzS++P0frb/I62QGZ4gDaogRjo9QvYd84k+XqUI2DPqXDAi1Cq3t9s
   aNKcb+U2KStjMxUu9X2CdxJA1zb/xt8rjrABNU+3AqYbLbPGIbDaGKwGc
   3GNlStBW/5pRxvCFVLtBH39aKxZeRCLZWXTEXm70Ok3rbxhSoktbDCkZH
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="254170019"
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="254170019"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 05:53:25 -0800
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="642513908"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 05:53:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nQ8MG-00BF56-8O;
        Fri, 04 Mar 2022 15:52:36 +0200
Date:   Fri, 4 Mar 2022 15:52:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v3 1/6] device property: Helper to match multiple
 connections
Message-ID: <YiIZoyfsJDcwR4gr@smile.fi.intel.com>
References: <20220303223351.141238-1-bjorn.andersson@linaro.org>
 <YiIL/ejgxhfRhTDP@smile.fi.intel.com>
 <YiIXDZnquRZj8dU5@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiIXDZnquRZj8dU5@paasikivi.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 03:41:33PM +0200, Sakari Ailus wrote:
> On Fri, Mar 04, 2022 at 02:54:21PM +0200, Andy Shevchenko wrote:
> > On Thu, Mar 03, 2022 at 02:33:46PM -0800, Bjorn Andersson wrote:

...

> > > +		if (count >= matches_len && matches) {
> > > +			fwnode_handle_put(ep);
> > > +			return count;
> > > +		}
> > 
> > Wouldn't be the same as
> > 
> > 		if (count >= matches_len) {
> > 			fwnode_handle_put(ep);
> > 			break;
> > 		}
> 
> Don't you need to check for non-NULL matches here?

Right, this should be kept as in original patch.

> I find return above easier to read.

Okay, original code may work, so I have no strong opinion about return vs
break, although I find slightly better to have a single point of return in
such case.

> > ?

...

> > > +	count_graph = fwnode_graph_devcon_matches(fwnode, con_id, data, match,
> > > +						  matches, matches_len);
> > 
> > > +	matches += count_graph;
> > > +	matches_len -= count_graph;
> > 
> > No, won't work when matches == NULL.
> > 
> > Also, matches_len is expected to be 0 in that case (or at least being ignored,
> > check with vsnprintf() behaviour in similar case).
> > 
> > So, something like this, perhaps
> > 
> > 	if (matches && matches_len) {
> > 		matches += count_graph;
> > 		matches_len -= count_graph;
> > 	}
> 
> Good find!

I have checked vsnprintf() and indeed, it expects to have the size is 0 when
the resulting buffer pointer is NULL, and it doesn't do any additional checks.

> > > +	count_ref = fwnode_devcon_matches(fwnode, con_id, data, match,
> > > +					  matches, matches_len);

-- 
With Best Regards,
Andy Shevchenko


