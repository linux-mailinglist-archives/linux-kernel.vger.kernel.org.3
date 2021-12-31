Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122734822F0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 10:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhLaJJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 04:09:58 -0500
Received: from mga07.intel.com ([134.134.136.100]:23619 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229475AbhLaJJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 04:09:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640941797; x=1672477797;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JWKwkX5e7TvJaQyN9tQXOL6j40nXjQfEIfbGleJsNpw=;
  b=gTcT928ZdY8It8oAKQRjZjzp8EF1xmWyU+Lleh2IN5zWXIvpBNN4XQ+9
   xCAh1BbeNWxq+YmCWjg2xXywuB/FfqYLlAw1AR8FcOOr1Q5dryBV3aKlv
   BhaF8K9dTxK5GCSaULZkaThO0AZPYd7xw7xiq5XoIrc09HGlyoEOyBvHN
   1eqEihvlV9WgFDua5HlToK0uBXmvAEjl6O70C5tzH2Oujf/TPCRNWoSUs
   /2BnTXpcBsT1zDoOGMOmE5oCCJDhD8DzwcJZxx6qJ9yHOO49vsNnYsGqz
   Igo9TGVdFHWc9aqaNnGVwdBTrF5bAJpydrMHYMikzNmzXup5wW2russAS
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="305152531"
X-IronPort-AV: E=Sophos;i="5.88,251,1635231600"; 
   d="scan'208";a="305152531"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 01:09:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,251,1635231600"; 
   d="scan'208";a="487110838"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 01:09:52 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 4AD9820192;
        Fri, 31 Dec 2021 11:09:50 +0200 (EET)
Date:   Fri, 31 Dec 2021 11:09:50 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
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
Message-ID: <Yc7I3gZehc1lHn4Z@paasikivi.fi.intel.com>
References: <20211228052116.1748443-1-bjorn.andersson@linaro.org>
 <20211228052116.1748443-4-bjorn.andersson@linaro.org>
 <Yc17Ssug3neFFXKN@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yc17Ssug3neFFXKN@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Björn,

(And thanks to Heikki for cc'ing me!)

On Thu, Dec 30, 2021 at 11:26:34AM +0200, Heikki Krogerus wrote:
> +Andy, Dan and Sakari
> 
> On Mon, Dec 27, 2021 at 09:21:11PM -0800, Bjorn Andersson wrote:
> > In some cases multiple connections with the same connection id
> > needs to be resolved from a fwnode graph.
> > 
> > One such example is when separate hardware is used for performing muxing and/or
> > orientation switching of the SuperSpeed and SBU lines in a USB-C
> > connector. In this case the connector needs to belong to a graph with
> > multiple matching remote endpoints, and the TypeC controller needs to be
> > able to resolve them both.
> > 
> > Add a new API that allows this kind of lookup.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  drivers/base/property.c  | 94 ++++++++++++++++++++++++++++++++++++++++
> >  include/linux/property.h |  5 +++
> >  2 files changed, 99 insertions(+)
> > 
> > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > index cbe4fa298413..0aa0296fd991 100644
> > --- a/drivers/base/property.c
> > +++ b/drivers/base/property.c
> > @@ -1180,6 +1180,36 @@ fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
> >  	return NULL;
> >  }
> >  
> > +static unsigned int fwnode_graph_devcon_matches(struct fwnode_handle *fwnode,
> > +						const char *con_id, void *data,
> > +						devcon_match_fn_t match,
> > +						void **matches,
> > +						unsigned int matches_len)
> > +{
> > +	struct fwnode_handle *node;
> > +	struct fwnode_handle *ep;
> > +	unsigned int count = 0;
> > +	void *ret;
> > +
> > +	fwnode_graph_for_each_endpoint(fwnode, ep) {
> > +		if (count >= matches_len) {
> > +			fwnode_handle_put(ep);
> > +			return count;
> > +		}
> > +
> > +		node = fwnode_graph_get_remote_port_parent(ep);
> > +		if (!fwnode_device_is_available(node))

The reference to node needs to be put here.

> > +			continue;
> > +
> > +		ret = match(node, con_id, data);
> > +		fwnode_handle_put(node);
> > +
> > +		if (ret)
> > +			matches[count++] = ret;
> > +	}
> > +	return count;
> > +}
> > +
> >  static void *
> >  fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
> >  		    void *data, devcon_match_fn_t match)
> > @@ -1202,6 +1232,35 @@ fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
> >  	return NULL;
> >  }
> >  
> > +static unsigned int fwnode_devcon_matches(struct fwnode_handle *fwnode,
> > +					  const char *con_id, void *data,
> > +					  devcon_match_fn_t match,
> > +					  void **matches,
> > +					  unsigned int matches_len)
> > +{
> > +	struct fwnode_handle *node;
> > +	unsigned int count = 0;
> > +	void *ret;
> > +	int i;

unsigned int, please.

> > +
> > +	for (i = 0; ; i++) {
> > +		if (count >= matches_len)
> > +			return count;
> > +
> > +		node = fwnode_find_reference(fwnode, con_id, i);
> > +		if (IS_ERR(node))
> > +			break;
> > +
> > +		ret = match(node, NULL, data);
> > +		fwnode_handle_put(node);
> > +
> > +		if (ret)
> > +			matches[count++] = ret;
> > +	}
> > +
> > +	return count;
> > +}
> > +
> >  /**
> >   * fwnode_connection_find_match - Find connection from a device node
> >   * @fwnode: Device node with the connection
> > @@ -1229,3 +1288,38 @@ void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
> >  	return fwnode_devcon_match(fwnode, con_id, data, match);
> >  }
> >  EXPORT_SYMBOL_GPL(fwnode_connection_find_match);
> > +
> > +/**
> > + * fwnode_connection_find_matches - Find connections from a device node
> > + * @fwnode: Device node with the connection
> > + * @con_id: Identifier for the connection
> > + * @data: Data for the match function
> > + * @match: Function to check and convert the connection description
> > + * @matches: Array of pointers to fill with matches
> > + * @matches_len: Length of @matches
> > + *
> > + * Find up to @matches_len connections with unique identifier @con_id between
> > + * @fwnode and other device nodes. @match will be used to convert the
> > + * connection description to data the caller is expecting to be returned
> > + * through the @matches array.

If the caller allocates the matches array, how does it know how large it
should be? Is there a need to provide a way to count the matches before
writing them to an array? Most similar functions do that by just setting the
array (matches) to NULL.

> > + *
> > + * Return: Number of matches resolved, of negative errno.
> > + */
> > +int fwnode_connection_find_matches(struct fwnode_handle *fwnode,
> > +				   const char *con_id, void *data,
> > +				   devcon_match_fn_t match,
> > +				   void **matches, unsigned int matches_len)
> > +{
> > +	unsigned int count;
> > +
> > +	if (!fwnode || !match || !matches)
> > +		return -EINVAL;
> > +
> > +	count = fwnode_graph_devcon_matches(fwnode, con_id, data, match,
> > +					    matches, matches_len);
> > +
> > +	return count + fwnode_devcon_matches(fwnode, con_id, data, match,
> > +					     matches + count,
> > +					     matches_len - count);
> > +}
> > +EXPORT_SYMBOL_GPL(fwnode_connection_find_matches);
> > diff --git a/include/linux/property.h b/include/linux/property.h
> > index 16f736c698a2..59484ccb260e 100644
> > --- a/include/linux/property.h
> > +++ b/include/linux/property.h
> > @@ -444,6 +444,11 @@ static inline void *device_connection_find_match(struct device *dev,
> >  	return fwnode_connection_find_match(dev_fwnode(dev), con_id, data, match);
> >  }
> >  
> > +int fwnode_connection_find_matches(struct fwnode_handle *fwnode,
> > +				   const char *con_id, void *data,
> > +				   devcon_match_fn_t match,
> > +				   void **matches, unsigned int matches_len);
> > +
> >  /* -------------------------------------------------------------------------- */
> >  /* Software fwnode support - when HW description is incomplete or missing */
> >  

-- 
Kind regards,

Sakari Ailus
