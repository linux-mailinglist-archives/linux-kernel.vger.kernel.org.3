Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D242E4CD495
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbiCDM43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiCDM40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:56:26 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD9AE98D4;
        Fri,  4 Mar 2022 04:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646398539; x=1677934539;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u8WLhOYgoR4+MkVoQ/8tm2u28hBvyv0voWHkunaJIQI=;
  b=XGXabIPxyMTmMaXy7AQfiY2a+/T5T341edp9TDMTs52e1VPGpqn51Zee
   ql/asXaSMBYGWAelxfdz+TZTaZ3ASrINCAhFALWm+mQosB6g7Szl8+LxR
   XfdQxEEVUCIFzJuBpxq00pt0Sak8EgrQ6segFFqx3LRw5zkXPA1ZNAach
   W+YE9k61Pucvif/W6vi8xyg8OMo8k7crUxyKnAKdUU1XIa7vFnVuMWg6h
   wtWxEQyHRqhqTaRakx5EFaJ4iFUrtoQAWpV0bAIDhBjbTH6KxL4BoFGt3
   bmQTkuk/zoua31bU2f+WVqx2lQeYmdYqgq4/xXL+SceRI5H9oXGgyfbRG
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="317197907"
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="317197907"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 04:55:39 -0800
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="511842295"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 04:55:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nQ7SL-00BDxn-Ji;
        Fri, 04 Mar 2022 14:54:49 +0200
Date:   Fri, 4 Mar 2022 14:54:49 +0200
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
Subject: Re: [PATCH v3 2/6] device property: Use multi-connection matchers
 for single case
Message-ID: <YiIMGQrhJX7svHSC@smile.fi.intel.com>
References: <20220303223351.141238-1-bjorn.andersson@linaro.org>
 <20220303223351.141238-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303223351.141238-2-bjorn.andersson@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 02:33:47PM -0800, Bjorn Andersson wrote:
> The newly introduced helpers for searching for matches in the case of
> multiple connections can be resused by the single-connection case, so do
> this to save some duplication.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v2:
> - None
> 
> Changes since v1:
> - None
> 
>  drivers/base/property.c | 55 ++++-------------------------------------
>  1 file changed, 5 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 5cda205136f6..81156dc97ad7 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -1193,31 +1193,6 @@ const void *device_get_match_data(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(device_get_match_data);
>  
> -static void *
> -fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
> -			  void *data, devcon_match_fn_t match)
> -{
> -	struct fwnode_handle *node;
> -	struct fwnode_handle *ep;
> -	void *ret;
> -
> -	fwnode_graph_for_each_endpoint(fwnode, ep) {
> -		node = fwnode_graph_get_remote_port_parent(ep);
> -		if (!fwnode_device_is_available(node)) {
> -			fwnode_handle_put(node);
> -			continue;
> -		}
> -
> -		ret = match(node, con_id, data);
> -		fwnode_handle_put(node);
> -		if (ret) {
> -			fwnode_handle_put(ep);
> -			return ret;
> -		}
> -	}
> -	return NULL;
> -}
> -
>  static unsigned int fwnode_graph_devcon_matches(struct fwnode_handle *fwnode,
>  						const char *con_id, void *data,
>  						devcon_match_fn_t match,
> @@ -1252,28 +1227,6 @@ static unsigned int fwnode_graph_devcon_matches(struct fwnode_handle *fwnode,
>  	return count;
>  }
>  
> -static void *
> -fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
> -		    void *data, devcon_match_fn_t match)
> -{
> -	struct fwnode_handle *node;
> -	void *ret;
> -	int i;
> -
> -	for (i = 0; ; i++) {
> -		node = fwnode_find_reference(fwnode, con_id, i);
> -		if (IS_ERR(node))
> -			break;
> -
> -		ret = match(node, NULL, data);
> -		fwnode_handle_put(node);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	return NULL;
> -}
> -
>  static unsigned int fwnode_devcon_matches(struct fwnode_handle *fwnode,
>  					  const char *con_id, void *data,
>  					  devcon_match_fn_t match,
> @@ -1320,16 +1273,18 @@ void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
>  				   const char *con_id, void *data,
>  				   devcon_match_fn_t match)
>  {
> +	unsigned int count;
>  	void *ret;
>  
>  	if (!fwnode || !match)
>  		return NULL;
>  
> -	ret = fwnode_graph_devcon_match(fwnode, con_id, data, match);
> -	if (ret)
> +	count = fwnode_graph_devcon_matches(fwnode, con_id, data, match, &ret, 1);
> +	if (count)
>  		return ret;
>  
> -	return fwnode_devcon_match(fwnode, con_id, data, match);
> +	count = fwnode_devcon_matches(fwnode, con_id, data, match, &ret, 1);
> +	return count ? ret : NULL;
>  }
>  EXPORT_SYMBOL_GPL(fwnode_connection_find_match);
>  
> -- 
> 2.33.1
> 

-- 
With Best Regards,
Andy Shevchenko


