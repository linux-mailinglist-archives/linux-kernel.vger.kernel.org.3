Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9454CFBBD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241276AbiCGKqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241203AbiCGKqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:46:23 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5879E546;
        Mon,  7 Mar 2022 02:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646647622; x=1678183622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L1jx+V8E552T2PPRm+4WoanMaIRUFpfYGagJ4ohp3Bc=;
  b=Nc3PUtEQ93fOPMakSsCp/OrYJ76yC9nZKtGYcsvVFEv0qLtur5C4A7BH
   jFXNvkSfHG3X5QhSCZPX7ndFSu/SeGShmVrVaWcjv/Wiov0g0pW0bYVaV
   B3p32xa+gJ7G58yWlgPenDeDfoH4Sgs4x5AM0hZd5xKAOtZFvfXfZSLta
   8fx050RVvwqX8RWKEkVW5JDkbn/zMzHVJ5H+UzQ1PsEqg5N8J/AUpg71U
   cBx8U+qy/zVhUU6ay+ciyB25O5YoUQHqcKUyz8FANtrDLyANwlr0m0IcQ
   sb6nXiN9EZ3qoOk28gqLgAfZaFg775nrJgn1QlK9dp+ZoYTNKW6QgSUB2
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="254083323"
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="254083323"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 02:06:44 -0800
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="643188785"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 02:06:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nRAFY-00ChWh-J3;
        Mon, 07 Mar 2022 12:05:56 +0200
Date:   Mon, 7 Mar 2022 12:05:56 +0200
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
Subject: Re: [PATCH v4 1/7] device property: Helper to match multiple
 connections
Message-ID: <YiXZBMG7cK6Cm7wP@smile.fi.intel.com>
References: <20220307034040.1111107-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307034040.1111107-1-bjorn.andersson@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2022 at 07:40:34PM -0800, Bjorn Andersson wrote:
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

Thanks for the update!

First of all, I have noticed that subject misses the verb, something like Add
or Introduce.

...

> +/**
> + * fwnode_connection_find_matches - Find connections from a device node
> + * @fwnode: Device node with the connection
> + * @con_id: Identifier for the connection
> + * @data: Data for the match function
> + * @match: Function to check and convert the connection description
> + * @matches: Array of pointers to fill with matches

(Optional) array...

> + * @matches_len: Length of @matches
> + *
> + * Find up to @matches_len connections with unique identifier @con_id between
> + * @fwnode and other device nodes. @match will be used to convert the
> + * connection description to data the caller is expecting to be returned
> + * through the @matches array.

> + * If @matches is NULL @matches_len is ignored and the total number of resolved
> + * matches is returned.

I would require matches_len to be 0, see below.

> + * Return: Number of matches resolved, or negative errno.
> + */
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
> +
> +	count_graph = fwnode_graph_devcon_matches(fwnode, con_id, data, match,
> +						  matches, matches_len);

> +	if (matches) {
> +		matches += count_graph;
> +		matches_len -= count_graph;
> +	}

So, the valid case is matches != NULL and matches_len == 0. For example, when
we have run something previously on the buffer and it becomes full.

In this case we have carefully handle this case.

	if (matches) {
		matches += count_graph;
		if (matches_len)
			matches_len -= count_graph;
	}

Seems it can be also

	if (matches)
		matches += count_graph;

	if (matches_len)
		matches_len -= count_graph;

That said, do we have a test cases for this?

> +	count_ref = fwnode_devcon_matches(fwnode, con_id, data, match,
> +					  matches, matches_len);
> +
> +	return count_graph + count_ref;
> +}

-- 
With Best Regards,
Andy Shevchenko


