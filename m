Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F464CC26B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbiCCQQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbiCCQQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:16:52 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE65D198EE2;
        Thu,  3 Mar 2022 08:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646324164; x=1677860164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=g1C/ot8Ij1y4B2kuWS/1yaGsXWgmA9l7aQSOgcM0DMU=;
  b=SLAPQnkKzminJ9y49v2IWCrU6loG9bNVh1y8WJC3RRkae8rVvf5F9sCL
   1ApDtfohmgdcU1AAs7WUQyZBESINs47NsaB65sHiCqeoE1VvY+L1D7mMZ
   M8ODM4HGJwMp6+OOtXne6y4fKDyyUxSU0Iql+/Lai1z9IJLk87GCeJMSs
   nB0gN/vYQbP6tTt8pxTI3DiVG+qqdJMtdxwVYevlr1LfHX0rBBdGOBNJ8
   9Xk3mcHdoQit2jkFZTcw6KTno9rhJE8odboBSNgKZoGG1NEFmoWzgTp0N
   RgDgrcqV4rkCzK2gDe+8ZRHKB5kjRuxuCxc1QEvmKEbrDnKpXR+SvuDpG
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="241135612"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="241135612"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 08:13:35 -0800
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="545908712"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 08:13:32 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id A791720087;
        Thu,  3 Mar 2022 18:13:30 +0200 (EET)
Date:   Thu, 3 Mar 2022 18:13:30 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH v1 1/1] device property: Allow error pointer for
 fwnode_handle_{get,put}()
Message-ID: <YiDpKqwiwD8jZdFT@paasikivi.fi.intel.com>
References: <20220303150610.47596-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220303150610.47596-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Thu, Mar 03, 2022 at 05:06:10PM +0200, Andy Shevchenko wrote:
> Some of the fwnode APIs might return an error pointer instead of NULL
> or valid fwnode handle. The result of such API call may be considered
> optional and hence the test for it is usually done in a form of
> 
> 	fwnode = fwnode_find_reference(...);
> 	if (IS_ERR_OR_NULL(fwnode))
> 		...error handling...
> 
> Nevertheless the resulting fwnode may have bumped reference count and
> hence caller of the above API is obliged to call fwnode_handle_put().
> Since fwnode may be not valid either as NULL or error pointer the check
> has to be performed there. This approach uglifies the code and adds
> a point of making a mistake, i.e. forgetting about error point case.
> 
> To prevent this allow error pointer for fwnode_handle_get() and
> fwnode_handle_put().
> 
> Fixes: 83b34afb6b79 ("device property: Introduce fwnode_find_reference()")
> Reported-by: Nuno Sá <nuno.sa@analog.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/property.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 2d70392fc982..df7b8c7ad264 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -776,7 +776,7 @@ EXPORT_SYMBOL_GPL(device_get_named_child_node);
>   */
>  struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode)
>  {
> -	if (!fwnode_has_op(fwnode, get))
> +	if (IS_ERR(fwnode) || !fwnode_has_op(fwnode, get))
>  		return fwnode;
>  
>  	return fwnode_call_ptr_op(fwnode, get);
> @@ -793,6 +793,9 @@ EXPORT_SYMBOL_GPL(fwnode_handle_get);
>   */
>  void fwnode_handle_put(struct fwnode_handle *fwnode)
>  {
> +	if (IS_ERR(fwnode) || !fwnode_has_op(fwnode, put))
> +		return;
> +
>  	fwnode_call_void_op(fwnode, put);
>  }
>  EXPORT_SYMBOL_GPL(fwnode_handle_put);

I guess fwnode_find_reference() is the only fwnode API function returning
errors as pointers? If you changed it returning NULL on error, you'd lose
the error codes.

But I think this is a problem beyond fwnode_handle_{get,put}: fwnode
obtained this way could be passed to any fwnode function and they should
just work correctly with that.

How about moving the check to fwnode_has_op()? That function is responsible
for checking the fwnode is valid and has the op in question.

It also seems the explicit fwnode_has_op() call is redundant in
fwnode_handle_put() as fwnode_call_void_op() already calls fwnode_has_op().

-- 
Kind regards,

Sakari Ailus
