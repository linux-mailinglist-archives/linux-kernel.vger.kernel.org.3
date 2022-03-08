Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B938E4D15F8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346219AbiCHLQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238474AbiCHLQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:16:24 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D433B544;
        Tue,  8 Mar 2022 03:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646738128; x=1678274128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KoWUG7e7YIIFnTkCHQYkhAmq+KJ3tI1osWCdZnLLdoA=;
  b=LfuroAc2KzuWJh/WvWUH0MvosJfnabbIobdUGxpjv6rzXc3t7YAUh67U
   IfumdSV6EOgPa17PqC/CcA084xydLTmo5vGjYVOcpYYO5WglX2ISDRNM8
   BdyyGqKOllKPZCZK1etLOd8mzbXgRTe0C36YnqrcmDwKApBVJz8U58E6O
   5ZLF3tSd/FTPUnpkpz65Hij7ejXtZkknsZoUp7eDdYdccmT2ZXJ9c/6s5
   DPPvwyR+eIyCl8HPA3Xx5//lMQxec9zwt7hhSdeEyUHYHhvzjMs75lnYS
   GxIiaulK6/chQLLP2GIPsW2Mho5YdF6p7pRO6pycvv19tAEZpNZqqQ0jx
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="235267719"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="235267719"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 03:15:27 -0800
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="513069069"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 03:15:24 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 4CA01204C3;
        Tue,  8 Mar 2022 13:15:22 +0200 (EET)
Date:   Tue, 8 Mar 2022 13:15:22 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH v3 1/1] device property: Allow error pointer to be passed
 to fwnode APIs
Message-ID: <Yic6yr6aycu7IHHh@paasikivi.fi.intel.com>
References: <20220307202949.75300-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220307202949.75300-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

This makes secondary handling quite a big nicer, thanks! A few comments
below. Apart from that,

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

On Mon, Mar 07, 2022 at 10:29:49PM +0200, Andy Shevchenko wrote:
> Some of the fwnode APIs might return an error pointer instead of NULL
> or valid fwnode handle. The result of such API call may be considered
> optional and hence the test for it is usually done in a form of
> 
> 	fwnode = fwnode_find_reference(...);
> 	if (IS_ERR(fwnode))
> 		...error handling...
> 
> Nevertheless the resulting fwnode may have bumped the reference count
> and hence caller of the above API is obliged to call fwnode_handle_put().
> Since fwnode may be not valid either as NULL or error pointer the check
> has to be performed there. This approach uglifies the code and adds
> a point of making a mistake, i.e. forgetting about error point case.
> 
> To prevent this, allow an error pointer to be passed to the fwnode APIs.
> 
> Fixes: 83b34afb6b79 ("device property: Introduce fwnode_find_reference()")
> Reported-by: Nuno Sá <nuno.sa@analog.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Nuno Sá <nuno.sa@analog.com>
> ---
> 
> v3: dropped test of secondary fwnode (Nuno), added tag (Nuno), amended commit message
> v2: adjusted the entire fwnode API (Sakari)
> 
> Nuno, can you re-test this with the ltc2983 series to be sure it is still okay?
> 
>  drivers/base/property.c | 76 +++++++++++++++++++++++------------------
>  include/linux/fwnode.h  | 10 +++---
>  2 files changed, 48 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index c0e94cce9c29..635a0e556a4f 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/export.h>
> +#include <linux/fwnode.h>

Is this intended? linux/property.h already includes linux/fwnode.h.

>  #include <linux/kernel.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> @@ -47,12 +48,14 @@ bool fwnode_property_present(const struct fwnode_handle *fwnode,
>  {
>  	bool ret;
>  
> +	if (IS_ERR_OR_NULL(fwnode))
> +		return false;
> +
>  	ret = fwnode_call_bool_op(fwnode, property_present, propname);
> -	if (ret == false && !IS_ERR_OR_NULL(fwnode) &&
> -	    !IS_ERR_OR_NULL(fwnode->secondary))
> -		ret = fwnode_call_bool_op(fwnode->secondary, property_present,
> -					 propname);
> -	return ret;
> +	if (ret == true)

It's already bool. I'd instead use:

	if (ret)

> +		return ret;
> +
> +	return fwnode_call_bool_op(fwnode->secondary, property_present, propname);
>  }
>  EXPORT_SYMBOL_GPL(fwnode_property_present);
>  
> @@ -232,15 +235,16 @@ static int fwnode_property_read_int_array(const struct fwnode_handle *fwnode,
>  {
>  	int ret;
>  
> +	if (IS_ERR_OR_NULL(fwnode))
> +		return -EINVAL;
> +
>  	ret = fwnode_call_int_op(fwnode, property_read_int_array, propname,
>  				 elem_size, val, nval);
> -	if (ret == -EINVAL && !IS_ERR_OR_NULL(fwnode) &&
> -	    !IS_ERR_OR_NULL(fwnode->secondary))
> -		ret = fwnode_call_int_op(
> -			fwnode->secondary, property_read_int_array, propname,
> -			elem_size, val, nval);
> +	if (ret != -EINVAL)
> +		return ret;
>  
> -	return ret;
> +	return fwnode_call_int_op(fwnode->secondary, property_read_int_array, propname,
> +				  elem_size, val, nval);
>  }
>  
>  /**
> @@ -371,14 +375,16 @@ int fwnode_property_read_string_array(const struct fwnode_handle *fwnode,
>  {
>  	int ret;
>  
> +	if (IS_ERR_OR_NULL(fwnode))
> +		return -EINVAL;
> +
>  	ret = fwnode_call_int_op(fwnode, property_read_string_array, propname,
>  				 val, nval);
> -	if (ret == -EINVAL && !IS_ERR_OR_NULL(fwnode) &&
> -	    !IS_ERR_OR_NULL(fwnode->secondary))
> -		ret = fwnode_call_int_op(fwnode->secondary,
> -					 property_read_string_array, propname,
> -					 val, nval);
> -	return ret;
> +	if (ret != -EINVAL)
> +		return ret;
> +
> +	return fwnode_call_int_op(fwnode->secondary, property_read_string_array, propname,
> +				  val, nval);
>  }
>  EXPORT_SYMBOL_GPL(fwnode_property_read_string_array);
>  
> @@ -480,15 +486,16 @@ int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
>  {
>  	int ret;
>  
> +	if (IS_ERR_OR_NULL(fwnode))
> +		return -ENOENT;
> +
>  	ret = fwnode_call_int_op(fwnode, get_reference_args, prop, nargs_prop,
>  				 nargs, index, args);
> +	if (ret == 0)
> +		return ret;
>  
> -	if (ret < 0 && !IS_ERR_OR_NULL(fwnode) &&
> -	    !IS_ERR_OR_NULL(fwnode->secondary))
> -		ret = fwnode_call_int_op(fwnode->secondary, get_reference_args,
> -					 prop, nargs_prop, nargs, index, args);
> -
> -	return ret;
> +	return fwnode_call_int_op(fwnode->secondary, get_reference_args, prop, nargs_prop,
> +				  nargs, index, args);
>  }
>  EXPORT_SYMBOL_GPL(fwnode_property_get_reference_args);
>  
> @@ -698,7 +705,7 @@ fwnode_get_next_available_child_node(const struct fwnode_handle *fwnode,
>  {
>  	struct fwnode_handle *next_child = child;
>  
> -	if (!fwnode)
> +	if (IS_ERR_OR_NULL(fwnode))
>  		return NULL;
>  
>  	do {
> @@ -722,16 +729,16 @@ struct fwnode_handle *device_get_next_child_node(struct device *dev,
>  	const struct fwnode_handle *fwnode = dev_fwnode(dev);
>  	struct fwnode_handle *next;
>  
> +	if (IS_ERR_OR_NULL(fwnode))
> +		return NULL;
> +
>  	/* Try to find a child in primary fwnode */
>  	next = fwnode_get_next_child_node(fwnode, child);
>  	if (next)
>  		return next;
>  
>  	/* When no more children in primary, continue with secondary */
> -	if (fwnode && !IS_ERR_OR_NULL(fwnode->secondary))
> -		next = fwnode_get_next_child_node(fwnode->secondary, child);
> -
> -	return next;
> +	return fwnode_get_next_child_node(fwnode->secondary, child);
>  }
>  EXPORT_SYMBOL_GPL(device_get_next_child_node);
>  
> @@ -798,6 +805,9 @@ EXPORT_SYMBOL_GPL(fwnode_handle_put);
>   */
>  bool fwnode_device_is_available(const struct fwnode_handle *fwnode)
>  {
> +	if (IS_ERR_OR_NULL(fwnode))
> +		return false;
> +
>  	if (!fwnode_has_op(fwnode, device_is_available))
>  		return true;
>  
> @@ -988,14 +998,14 @@ fwnode_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
>  		parent = fwnode_graph_get_port_parent(prev);
>  	else
>  		parent = fwnode;
> +	if (IS_ERR_OR_NULL(parent))
> +		return NULL;
>  
>  	ep = fwnode_call_ptr_op(parent, graph_get_next_endpoint, prev);
> +	if (ep)
> +		return ep;
>  
> -	if (IS_ERR_OR_NULL(ep) &&
> -	    !IS_ERR_OR_NULL(parent) && !IS_ERR_OR_NULL(parent->secondary))
> -		ep = fwnode_graph_get_next_endpoint(parent->secondary, NULL);
> -
> -	return ep;
> +	return fwnode_graph_get_next_endpoint(parent->secondary, NULL);
>  }
>  EXPORT_SYMBOL_GPL(fwnode_graph_get_next_endpoint);
>  
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 3a532ba66f6c..7defac04f9a3 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -148,12 +148,12 @@ struct fwnode_operations {
>  	int (*add_links)(struct fwnode_handle *fwnode);
>  };
>  
> -#define fwnode_has_op(fwnode, op)				\
> -	((fwnode) && (fwnode)->ops && (fwnode)->ops->op)
> +#define fwnode_has_op(fwnode, op)					\
> +	(!IS_ERR_OR_NULL(fwnode) && (fwnode)->ops && (fwnode)->ops->op)
> +
>  #define fwnode_call_int_op(fwnode, op, ...)				\
> -	(fwnode ? (fwnode_has_op(fwnode, op) ?				\
> -		   (fwnode)->ops->op(fwnode, ## __VA_ARGS__) : -ENXIO) : \
> -	 -EINVAL)
> +	(fwnode_has_op(fwnode, op) ?					\
> +	 (fwnode)->ops->op(fwnode, ## __VA_ARGS__) : (IS_ERR_OR_NULL(fwnode) ? -EINVAL : -ENXIO))
>  
>  #define fwnode_call_bool_op(fwnode, op, ...)		\
>  	(fwnode_has_op(fwnode, op) ?			\

-- 
Kind regards,

Sakari Ailus
