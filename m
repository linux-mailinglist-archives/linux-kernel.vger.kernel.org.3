Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3FA4CD491
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbiCDM4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiCDM4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:56:01 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49ECE869C;
        Fri,  4 Mar 2022 04:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646398512; x=1677934512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+ZFa6rhRZ44X3wnA/gDErro2pEA4WQVzTbV/DBqK2YE=;
  b=X1U9Hgm8DkU2Wz47Ibp8H5nM0r1dZhv4bSmMdmA4//7B1RfN7j3Wc06k
   JPcm+WPo47HmKvs/CFli3DgUUc9V8l8lcBr0wSiDzlC3oUHgS76bj8W9X
   uC/sUYql+KQUzOz80hwHgpnX7Jz8j2asEi/EfgaoYEBCg75ykyYJRh0+X
   /BiCNmYl/PxYfm/e8uOesrarQ15/6vtcglTsvVvjDQfqs8XpaQjd+xI/1
   T3OmnseSXnXpiRDFJWd2MvY1RseNqm/m5n1AUT7AxJZjxtfCABk1Uq7wV
   JlRVnvabWEWsCLUGOZRyw5M83WhYOKU79yLnUPkTPeEWGsWIBQN4ZZZgA
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="251543752"
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="251543752"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 04:55:12 -0800
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="576872396"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 04:55:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nQ7Ru-00BDxX-4b;
        Fri, 04 Mar 2022 14:54:22 +0200
Date:   Fri, 4 Mar 2022 14:54:21 +0200
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
Subject: Re: [PATCH v3 1/6] device property: Helper to match multiple
 connections
Message-ID: <YiIL/ejgxhfRhTDP@smile.fi.intel.com>
References: <20220303223351.141238-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303223351.141238-1-bjorn.andersson@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 02:33:46PM -0800, Bjorn Andersson wrote:
> In some cases multiple connections with the same connection id
> needs to be resolved from a fwnode graph.
> 
> One such example is when separate hardware is used for performing muxing
> and/or orientation switching of the SuperSpeed and SBU lines in a USB
> Type-C connector. In this case the connector needs to belong to a graph
> with multiple matching remote endpoints, and the Type-C controller needs
> to be able to resolve them both.
> 
> Add a new API that allows this kind of lookup.

...

> +static unsigned int fwnode_graph_devcon_matches(struct fwnode_handle *fwnode,
> +						const char *con_id, void *data,
> +						devcon_match_fn_t match,
> +						void **matches,
> +						unsigned int matches_len)
> +{
> +	struct fwnode_handle *node;
> +	struct fwnode_handle *ep;
> +	unsigned int count = 0;
> +	void *ret;
> +
> +	fwnode_graph_for_each_endpoint(fwnode, ep) {

> +		if (count >= matches_len && matches) {
> +			fwnode_handle_put(ep);
> +			return count;
> +		}

Wouldn't be the same as

		if (count >= matches_len) {
			fwnode_handle_put(ep);
			break;
		}

?

> +		node = fwnode_graph_get_remote_port_parent(ep);
> +		if (!fwnode_device_is_available(node)) {
> +			fwnode_handle_put(node);
> +			continue;
> +		}
> +
> +		ret = match(node, con_id, data);
> +		fwnode_handle_put(node);
> +		if (ret) {
> +			if (matches)
> +				matches[count] = ret;
> +			count++;
> +		}
> +	}
> +	return count;
> +}

...

> +static unsigned int fwnode_devcon_matches(struct fwnode_handle *fwnode,
> +					  const char *con_id, void *data,
> +					  devcon_match_fn_t match,
> +					  void **matches,
> +					  unsigned int matches_len)
> +{
> +	struct fwnode_handle *node;
> +	unsigned int count = 0;
> +	unsigned int i;
> +	void *ret;
> +
> +	for (i = 0; ; i++) {

> +		if (count >= matches_len && matches)
> +			return count;

Ditto.

> +		node = fwnode_find_reference(fwnode, con_id, i);
> +		if (IS_ERR(node))
> +			break;
> +
> +		ret = match(node, NULL, data);
> +		fwnode_handle_put(node);
> +		if (ret) {
> +			if (matches)
> +				matches[count] = ret;
> +			count++;
> +		}
> +	}
> +
> +	return count;
> +}

...

> +int fwnode_connection_find_matches(struct fwnode_handle *fwnode,
> +				   const char *con_id, void *data,
> +				   devcon_match_fn_t match,
> +				   void **matches, unsigned int matches_len)
> +{
> +	unsigned int count_graph;
> +	unsigned int count_ref;
> +
> +	if (!fwnode || !match)
> +		return -EINVAL;

> +	count_graph = fwnode_graph_devcon_matches(fwnode, con_id, data, match,
> +						  matches, matches_len);

> +	matches += count_graph;
> +	matches_len -= count_graph;

No, won't work when matches == NULL.

Also, matches_len is expected to be 0 in that case (or at least being ignored,
check with vsnprintf() behaviour in similar case).

So, something like this, perhaps

	if (matches && matches_len) {
		matches += count_graph;
		matches_len -= count_graph;
	}

> +	count_ref = fwnode_devcon_matches(fwnode, con_id, data, match,
> +					  matches, matches_len);
> +
> +	return count_graph + count_ref;
> +}


-- 
With Best Regards,
Andy Shevchenko


