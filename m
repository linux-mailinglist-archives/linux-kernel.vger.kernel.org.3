Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453054CD559
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbiCDNm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiCDNm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:42:27 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA251B84F7;
        Fri,  4 Mar 2022 05:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646401298; x=1677937298;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=W8+cYexF94Vl6YzXjBdnxaTLtgugktdOPocSTG8FZjE=;
  b=fgbVb8Lri4D8f/UrJBnB5Xx45w7rPzcFwsUcbVxtsX7Z28UYVhwk1ksT
   8ZSpIqcwfu4s0BdQZ/V8hr3EJa9zhOX2GTSsEXWV27AnH8mCYEkP3TYY5
   lK41hTtGsP7I9DpWDC3DflYs/U68HkQEOKmauknplI9vnHjdB77zBNvdk
   v6BU59WYH6xVwcsQ55eDj/6LE72xBTSVLlwXO6Qd+i2t9bSGHdzxOkQG4
   27U/IB8UIxIKgSq4v0N425err6QZhRQFV5k5cgepif0bI4yU9hJNVHvhc
   AiVqvzHCmg+V+5KXSzPc84GhP2teRBB8c/VBb2d1WL9MEM/R6mUAonnmL
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="314691021"
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="314691021"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 05:41:38 -0800
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="494331573"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 05:41:35 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 205D420087;
        Fri,  4 Mar 2022 15:41:33 +0200 (EET)
Date:   Fri, 4 Mar 2022 15:41:33 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Message-ID: <YiIXDZnquRZj8dU5@paasikivi.fi.intel.com>
References: <20220303223351.141238-1-bjorn.andersson@linaro.org>
 <YiIL/ejgxhfRhTDP@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YiIL/ejgxhfRhTDP@smile.fi.intel.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy, Björn,

On Fri, Mar 04, 2022 at 02:54:21PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 03, 2022 at 02:33:46PM -0800, Bjorn Andersson wrote:
> > In some cases multiple connections with the same connection id
> > needs to be resolved from a fwnode graph.
> > 
> > One such example is when separate hardware is used for performing muxing
> > and/or orientation switching of the SuperSpeed and SBU lines in a USB
> > Type-C connector. In this case the connector needs to belong to a graph
> > with multiple matching remote endpoints, and the Type-C controller needs
> > to be able to resolve them both.
> > 
> > Add a new API that allows this kind of lookup.
> 
> ...
> 
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
> 
> > +		if (count >= matches_len && matches) {
> > +			fwnode_handle_put(ep);
> > +			return count;
> > +		}
> 
> Wouldn't be the same as
> 
> 		if (count >= matches_len) {
> 			fwnode_handle_put(ep);
> 			break;
> 		}

Don't you need to check for non-NULL matches here?

I find return above easier to read.

> 
> ?
> 
> > +		node = fwnode_graph_get_remote_port_parent(ep);
> > +		if (!fwnode_device_is_available(node)) {
> > +			fwnode_handle_put(node);
> > +			continue;
> > +		}
> > +
> > +		ret = match(node, con_id, data);
> > +		fwnode_handle_put(node);
> > +		if (ret) {
> > +			if (matches)
> > +				matches[count] = ret;
> > +			count++;
> > +		}
> > +	}
> > +	return count;
> > +}
> 
> ...
> 
> > +static unsigned int fwnode_devcon_matches(struct fwnode_handle *fwnode,
> > +					  const char *con_id, void *data,
> > +					  devcon_match_fn_t match,
> > +					  void **matches,
> > +					  unsigned int matches_len)
> > +{
> > +	struct fwnode_handle *node;
> > +	unsigned int count = 0;
> > +	unsigned int i;
> > +	void *ret;
> > +
> > +	for (i = 0; ; i++) {
> 
> > +		if (count >= matches_len && matches)
> > +			return count;
> 
> Ditto.
> 
> > +		node = fwnode_find_reference(fwnode, con_id, i);
> > +		if (IS_ERR(node))
> > +			break;
> > +
> > +		ret = match(node, NULL, data);
> > +		fwnode_handle_put(node);
> > +		if (ret) {
> > +			if (matches)
> > +				matches[count] = ret;
> > +			count++;
> > +		}
> > +	}
> > +
> > +	return count;
> > +}
> 
> ...
> 
> > +int fwnode_connection_find_matches(struct fwnode_handle *fwnode,
> > +				   const char *con_id, void *data,
> > +				   devcon_match_fn_t match,
> > +				   void **matches, unsigned int matches_len)
> > +{
> > +	unsigned int count_graph;
> > +	unsigned int count_ref;
> > +
> > +	if (!fwnode || !match)
> > +		return -EINVAL;
> 
> > +	count_graph = fwnode_graph_devcon_matches(fwnode, con_id, data, match,
> > +						  matches, matches_len);
> 
> > +	matches += count_graph;
> > +	matches_len -= count_graph;
> 
> No, won't work when matches == NULL.
> 
> Also, matches_len is expected to be 0 in that case (or at least being ignored,
> check with vsnprintf() behaviour in similar case).
> 
> So, something like this, perhaps
> 
> 	if (matches && matches_len) {
> 		matches += count_graph;
> 		matches_len -= count_graph;
> 	}

Good find!

> 
> > +	count_ref = fwnode_devcon_matches(fwnode, con_id, data, match,
> > +					  matches, matches_len);
> > +
> > +	return count_graph + count_ref;
> > +}
> 
> 

-- 
Regards,

Sakari Ailus
