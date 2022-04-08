Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF48F4F9F43
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 23:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239889AbiDHVi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 17:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiDHVi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:38:57 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CF019025;
        Fri,  8 Apr 2022 14:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649453812; x=1680989812;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q7gUV6Oy1V+1Da26I8JHKgDGYCIYUQUcdpcCZ47Ly5s=;
  b=VL2p0lYJ0rsiPBgQdqGKRpaQp0T/YMrblNYauYCqXpbBGQzp2ikV3G9M
   CULx+Iu5WmSf34WmUnv/xUqaheF4Ve6FJUUlYQoq/CfbPQO9nvzrbUWya
   Zo+HLu5BNTuq3L6Sr79ne6WA5bJweFfYH96FL58evyxzBSCUaBeJ6U6da
   X3VvQMOeG229fRXNdvJiTG7Jv3T/bwKIszAifttUHU3uziO0bO73LUH+g
   Gy2mf+IlwDHGqQyw+sMjXOGawvWMU3xhnPplXu2U1KE9xBwMqnCWkZIqu
   OHpxDh9szANpuEjs31ccHvhPZtTBoV/AzrmbdcYapKYtZzZLZL0nv8bW5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="242283408"
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="242283408"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 14:36:52 -0700
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="550664795"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 14:36:49 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 721012030F;
        Sat,  9 Apr 2022 00:36:47 +0300 (EEST)
Date:   Sat, 9 Apr 2022 00:36:47 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rob Herring <robh@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v6 4/5] device property: Constify fwnode_handle_get()
Message-ID: <YlCq79KveByePxe9@paasikivi.fi.intel.com>
References: <20220408184844.22829-1-andriy.shevchenko@linux.intel.com>
 <20220408184844.22829-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408184844.22829-4-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, Apr 08, 2022 at 09:48:43PM +0300, Andy Shevchenko wrote:
> As to_of_node() suggests and the way the code in the OF and software node
> back ends actually uses the fwnode handle, it may be constified. Do this
> for good.

How?

If the fwnode is const, then the struct it contains must be presumed to be
const, too.

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v6: new patch
>  drivers/base/property.c  | 2 +-
>  drivers/base/swnode.c    | 2 +-
>  drivers/of/property.c    | 2 +-
>  include/linux/fwnode.h   | 2 +-
>  include/linux/property.h | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 36401cfe432c..1ad4b37cd312 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -776,7 +776,7 @@ EXPORT_SYMBOL_GPL(device_get_named_child_node);
>   *
>   * Returns the fwnode handle.
>   */
> -struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode)
> +struct fwnode_handle *fwnode_handle_get(const struct fwnode_handle *fwnode)
>  {
>  	if (!fwnode_has_op(fwnode, get))
>  		return fwnode;
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index b0bbd1805970..84a11008ffb8 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -363,7 +363,7 @@ EXPORT_SYMBOL_GPL(property_entries_free);
>  /* -------------------------------------------------------------------------- */
>  /* fwnode operations */
>  
> -static struct fwnode_handle *software_node_get(struct fwnode_handle *fwnode)
> +static struct fwnode_handle *software_node_get(const struct fwnode_handle *fwnode)
>  {
>  	struct swnode *swnode = to_swnode(fwnode);
>  
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 9a50ad25906e..8d06282af8e4 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -858,7 +858,7 @@ struct device_node *of_graph_get_remote_node(const struct device_node *node,
>  }
>  EXPORT_SYMBOL(of_graph_get_remote_node);
>  
> -static struct fwnode_handle *of_fwnode_get(struct fwnode_handle *fwnode)
> +static struct fwnode_handle *of_fwnode_get(const struct fwnode_handle *fwnode)
>  {
>  	return of_fwnode_handle(of_node_get(to_of_node(fwnode)));
>  }
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 9a81c4410b9f..a94bd47192a3 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -108,7 +108,7 @@ struct fwnode_reference_args {
>   *		zero on success, a negative error code otherwise.
>   */
>  struct fwnode_operations {
> -	struct fwnode_handle *(*get)(struct fwnode_handle *fwnode);
> +	struct fwnode_handle *(*get)(const struct fwnode_handle *fwnode);
>  	void (*put)(struct fwnode_handle *fwnode);
>  	bool (*device_is_available)(const struct fwnode_handle *fwnode);
>  	const void *(*device_get_match_data)(const struct fwnode_handle *fwnode,
> diff --git a/include/linux/property.h b/include/linux/property.h
> index fc24d45632eb..c631ee7fd161 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -121,7 +121,7 @@ struct fwnode_handle *fwnode_get_named_child_node(
>  struct fwnode_handle *device_get_named_child_node(struct device *dev,
>  						  const char *childname);
>  
> -struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
> +struct fwnode_handle *fwnode_handle_get(const struct fwnode_handle *fwnode);
>  void fwnode_handle_put(struct fwnode_handle *fwnode);
>  
>  int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
> -- 
> 2.35.1
> 

-- 
Sakari Ailus
