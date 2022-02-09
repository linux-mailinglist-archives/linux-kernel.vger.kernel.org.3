Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5898A4AF1AE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbiBIMbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiBIMba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:31:30 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAB8C0613CA;
        Wed,  9 Feb 2022 04:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644409893; x=1675945893;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=soo0nB22WJPviBpDRfEsLQcVnBjoM627TI0/ktDLbTA=;
  b=DIJvvN1fahCLSOlJKbUbt7CYREFfjB8FFrh0GhrgYu3pS0H0AntDOr/n
   UJKll2uyur+6Fp2DMwjiTCT55WJ+/Xa7Hd6W8dr7ICJLaG8A7ctGNOSg/
   3CeHCkZd/E+d2L0VCBK9Nm96juLZvKpPIMeSw1I3g57PDAA52OO4McLpF
   owT/Dcg353xM+perKlvEoBpGUMOp8s2+0MO+U4YT+dZAhNpNLYXAPpX7b
   s74rukMfa+Oeq90J0v1c3UjAPBkv6qisqyn5CNXlCZg4hSv6KRpOYAcT9
   vHFrpTgL3fEXH1OcU7CPb/4Sbzo+F5ZX9IL4OwsramGMyfAR8q/QTLiOe
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="248026147"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="248026147"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 04:31:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="622261908"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 04:31:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nHm7E-002bvg-8W;
        Wed, 09 Feb 2022 14:30:32 +0200
Date:   Wed, 9 Feb 2022 14:30:32 +0200
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
Message-ID: <YgOz6K55Oi2Si4pU@smile.fi.intel.com>
References: <20220208031944.3444-1-bjorn.andersson@linaro.org>
 <20220208031944.3444-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208031944.3444-2-bjorn.andersson@linaro.org>
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

On Mon, Feb 07, 2022 at 07:19:39PM -0800, Bjorn Andersson wrote:
> In some cases multiple connections with the same connection id
> needs to be resolved from a fwnode graph.
> 
> One such example is when separate hardware is used for performing muxing
> and/or orientation switching of the SuperSpeed and SBU lines in a USB-C

USB Type-C ?

> connector. In this case the connector needs to belong to a graph with
> multiple matching remote endpoints, and the TypeC controller needs to be

Type-C ?

> able to resolve them both.
> 
> Add a new API that allows this kind of lookup.
> 
> Given that the match() callback returns an opaque reference to something
> provided by the client it's not possible for the implementation to
> release the returned object and as such it's not possible to handle
> errors, which in turn means that it's not possible to query the number
> of elements or dynamically grow the results array. It's however expected
> that the number of matches will be reasonably low and that the worst
> case is known by the caller before hand.

...

> +	fwnode_graph_for_each_endpoint(fwnode, ep) {
> +		if (count >= matches_len) {
> +			fwnode_handle_put(ep);
> +			return count;
> +		}
> +
> +		node = fwnode_graph_get_remote_port_parent(ep);
> +		if (!fwnode_device_is_available(node)) {
> +			fwnode_handle_put(node);
> +			continue;
> +		}
> +
> +		ret = match(node, con_id, data);
> +		fwnode_handle_put(node);

> +

Redundant blank line (it seems the current style w/o this).
Ditto for the below function.

> +		if (ret)
> +			matches[count++] = ret;
> +	}

...

> +/**
> + * fwnode_connection_find_matches - Find connections from a device node
> + * @fwnode: Device node with the connection
> + * @con_id: Identifier for the connection
> + * @data: Data for the match function
> + * @match: Function to check and convert the connection description
> + * @matches: Array of pointers to fill with matches
> + * @matches_len: Length of @matches
> + *
> + * Find up to @matches_len connections with unique identifier @con_id between
> + * @fwnode and other device nodes. @match will be used to convert the
> + * connection description to data the caller is expecting to be returned
> + * through the @matches array.
> + *
> + * Return: Number of matches resolved, of negative errno.

s/of/or/ ?

> + */
> +int fwnode_connection_find_matches(struct fwnode_handle *fwnode,
> +				   const char *con_id, void *data,
> +				   devcon_match_fn_t match,
> +				   void **matches, unsigned int matches_len)
> +{
> +	unsigned int count;
> +
> +	if (!fwnode || !match || !matches)

!matches case may be still useful to get the count and allocate memory by
caller. Please, consider this case.

> +		return -EINVAL;
> +
> +	count = fwnode_graph_devcon_matches(fwnode, con_id, data, match,
> +					    matches, matches_len);
> +
> +	return count + fwnode_devcon_matches(fwnode, con_id, data, match,
> +					     matches + count,
> +					     matches_len - count);

I haven't found any explanation what the difference between two counts. Also
can you define two count variables with distinct names and do something like

	count_A = ...

	matches += count;
	matches_len -= count;

	count_B = ...

	return count_A + count_B;

?

> +}

-- 
With Best Regards,
Andy Shevchenko


