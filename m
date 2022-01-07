Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B53487913
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347906AbiAGOeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:34:25 -0500
Received: from mga17.intel.com ([192.55.52.151]:59409 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347864AbiAGOeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641566055; x=1673102055;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=DXgdDcZzD0elNYWBm1IixW+PtrsX2vdFCxvYPLrWCGc=;
  b=gZ+SC1r6USJ4Wru4gsVPIHJy57OAf3p3sinWiJnzb1lPs5eDcK8j7oQZ
   RxITv7x3Wnh4L8lEueAbnJKb4yPLQhsfJwtxix1NHLOmsZFfEz9R5hi36
   HzHrfqyukXIQlsTag0jzpY6vNjsxzs02HdqER4lzRwBasdtV1b9uAqcdu
   l1QIGq2xiUTPPID0U+SqOMlyK10tpIvjAorj3+Ca6dhYxnx6kqhsx3vkB
   Kpvsv84YqdHo2XjjBh1E53AnERF/VTEj2tzk9g+hci55QBlirYMTFDTMw
   J5sjCVLAFe3J5EahM9ocLIwQDktV0JkVTaEx2jhccUjbFjbj1ZJKVhjhp
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="223571537"
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="223571537"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 06:34:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="668784047"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 06:34:11 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 9160D202B9;
        Fri,  7 Jan 2022 16:33:39 +0200 (EET)
Date:   Fri, 7 Jan 2022 16:33:39 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 3/8] device property: Helper to match multiple connections
Message-ID: <YdhPQ0Wuz63JBKaR@paasikivi.fi.intel.com>
References: <20211228052116.1748443-1-bjorn.andersson@linaro.org>
 <20211228052116.1748443-4-bjorn.andersson@linaro.org>
 <Yc17Ssug3neFFXKN@kuha.fi.intel.com>
 <Yc7I3gZehc1lHn4Z@paasikivi.fi.intel.com>
 <YdYC8DeF1i9a3RnP@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YdYC8DeF1i9a3RnP@ripper>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 12:43:28PM -0800, Bjorn Andersson wrote:
> On Fri 31 Dec 01:09 PST 2021, Sakari Ailus wrote:
> 
> > Hi Björn,
> > 
> > (And thanks to Heikki for cc'ing me!)
> > 
> > On Thu, Dec 30, 2021 at 11:26:34AM +0200, Heikki Krogerus wrote:
> > > +Andy, Dan and Sakari
> > > 
> > > On Mon, Dec 27, 2021 at 09:21:11PM -0800, Bjorn Andersson wrote:
> > > > In some cases multiple connections with the same connection id
> > > > needs to be resolved from a fwnode graph.
> > > > 
> > > > One such example is when separate hardware is used for performing muxing and/or
> > > > orientation switching of the SuperSpeed and SBU lines in a USB-C
> > > > connector. In this case the connector needs to belong to a graph with
> > > > multiple matching remote endpoints, and the TypeC controller needs to be
> > > > able to resolve them both.
> > > > 
> > > > Add a new API that allows this kind of lookup.
> > > > 
> > > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > ---
> > > >  drivers/base/property.c  | 94 ++++++++++++++++++++++++++++++++++++++++
> > > >  include/linux/property.h |  5 +++
> > > >  2 files changed, 99 insertions(+)
> > > > 
> > > > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > > > index cbe4fa298413..0aa0296fd991 100644
> > > > --- a/drivers/base/property.c
> > > > +++ b/drivers/base/property.c
> > > > @@ -1180,6 +1180,36 @@ fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
> > > >  	return NULL;
> > > >  }
> > > >  
> > > > +static unsigned int fwnode_graph_devcon_matches(struct fwnode_handle *fwnode,
> > > > +						const char *con_id, void *data,
> > > > +						devcon_match_fn_t match,
> > > > +						void **matches,
> > > > +						unsigned int matches_len)
> > > > +{
> > > > +	struct fwnode_handle *node;
> > > > +	struct fwnode_handle *ep;
> > > > +	unsigned int count = 0;
> > > > +	void *ret;
> > > > +
> > > > +	fwnode_graph_for_each_endpoint(fwnode, ep) {
> > > > +		if (count >= matches_len) {
> > > > +			fwnode_handle_put(ep);
> > > > +			return count;
> > > > +		}
> > > > +
> > > > +		node = fwnode_graph_get_remote_port_parent(ep);
> > > > +		if (!fwnode_device_is_available(node))
> > 
> > The reference to node needs to be put here.
> > 
> 
> You're right, thanks!
> 
> > > > +			continue;
> > > > +
> > > > +		ret = match(node, con_id, data);
> > > > +		fwnode_handle_put(node);
> > > > +
> > > > +		if (ret)
> > > > +			matches[count++] = ret;
> > > > +	}
> > > > +	return count;
> > > > +}
> > > > +
> > > >  static void *
> > > >  fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
> > > >  		    void *data, devcon_match_fn_t match)
> > > > @@ -1202,6 +1232,35 @@ fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
> > > >  	return NULL;
> > > >  }
> > > >  
> > > > +static unsigned int fwnode_devcon_matches(struct fwnode_handle *fwnode,
> > > > +					  const char *con_id, void *data,
> > > > +					  devcon_match_fn_t match,
> > > > +					  void **matches,
> > > > +					  unsigned int matches_len)
> > > > +{
> > > > +	struct fwnode_handle *node;
> > > > +	unsigned int count = 0;
> > > > +	void *ret;
> > > > +	int i;
> > 
> > unsigned int, please.
> > 
> 
> Sounds good.
> 
> > > > +
> > > > +	for (i = 0; ; i++) {
> > > > +		if (count >= matches_len)
> > > > +			return count;
> > > > +
> > > > +		node = fwnode_find_reference(fwnode, con_id, i);
> > > > +		if (IS_ERR(node))
> > > > +			break;
> > > > +
> > > > +		ret = match(node, NULL, data);
> > > > +		fwnode_handle_put(node);
> > > > +
> > > > +		if (ret)
> > > > +			matches[count++] = ret;
> > > > +	}
> > > > +
> > > > +	return count;
> > > > +}
> > > > +
> > > >  /**
> > > >   * fwnode_connection_find_match - Find connection from a device node
> > > >   * @fwnode: Device node with the connection
> > > > @@ -1229,3 +1288,38 @@ void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
> > > >  	return fwnode_devcon_match(fwnode, con_id, data, match);
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(fwnode_connection_find_match);
> > > > +
> > > > +/**
> > > > + * fwnode_connection_find_matches - Find connections from a device node
> > > > + * @fwnode: Device node with the connection
> > > > + * @con_id: Identifier for the connection
> > > > + * @data: Data for the match function
> > > > + * @match: Function to check and convert the connection description
> > > > + * @matches: Array of pointers to fill with matches
> > > > + * @matches_len: Length of @matches
> > > > + *
> > > > + * Find up to @matches_len connections with unique identifier @con_id between
> > > > + * @fwnode and other device nodes. @match will be used to convert the
> > > > + * connection description to data the caller is expecting to be returned
> > > > + * through the @matches array.
> > 
> > If the caller allocates the matches array, how does it know how large it
> > should be? Is there a need to provide a way to count the matches before
> > writing them to an array? Most similar functions do that by just setting the
> > array (matches) to NULL.
> > 
> 
> This is a very relevant comment and I did look for ways to handle this
> as I came up with the patch.
> 
> I think the typical mechanism would be to allow @matches to be NULL, in
> which case we iterate over objects and return the number of matches, so
> that the caller can allocate an appropriately sized array and call the
> API again.
> 
> But the "match" function simply returns a pointer to something and
> looking at the example of the typec_{mux,switch} this pointer points to
> a member of an object which has a struct device which is refcounted.
> 
> As such, we can't simply discard the returned object. We have to pass it
> back to the caller, whom knows what "match" did and is able to reverse
> that.
> 
> I looked at changing the callback and I looked at using krealloc() to
> grow an array dynamically.

krealloc() may also fail...

> 
> 
> But looking at the use case in mind; finding entities that might need to
> react to a USB Type-C event I have a need for 2 matches, and 3 seems
> plausible. Beyond that the largest of_graph I have ever dealt with has 6
> endpoints.
> 
> While it isn't relevant to use this API for my 6-endpoint case, it would
> result in @matches having to be 48 bytes of pointers. And once the call
> returns, the actual number of pointers needed is known and the long-term
> storage can be re-allocated as necessary based on the return value.
> 
> As such, I dropped the idea of making something fancier and more
> dynamic, for the sake of simplicity. Perhaps I'm missing some cool use
> case where this is infeasible?

Another option would be to use a fixed-size array for the purpose. Assuming
this will remain a small number, a single global macro could be used to set
the maximum number that could be also easily increased if needed.

On the other hand, if this number remains specific to the caller as it
would seem, then I guess a caller-set value (as implemented now) remains a
fine option, too.

-- 
Kind regards,

Sakari Ailus
