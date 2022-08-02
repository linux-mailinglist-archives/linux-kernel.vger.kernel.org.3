Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFF25877B3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbiHBHS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbiHBHSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:18:54 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9672FD13A;
        Tue,  2 Aug 2022 00:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659424733; x=1690960733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RvwmFxwP70eYQJZ3Lq3ZhuetbGK49H2H5zbw48rU8xs=;
  b=Y7Q4YQdvYVQIsH26gPsT6zMDwNBRGv0rsa5OhXUOUqzL1BoUwFIIWQcN
   FDFceFKr2gbE3EMC12YAagdZ66xeYtyh53jZpjMqG+FdgW87e7bl2QT2A
   QIY1pDyPipC6KqYWPjMZY3lUfEBRw5xCeo5JuueRtfCxjV/fpyaFhGrDh
   hmNA5sS8Lip0sHHaui8ZxWDEtp1mp7gMc7Y9m1zH0HNkJnjBmndAKeeqp
   j6vdHeVqR++mEFjv/YzPHeRIwAg8OuYCAAiCPyYZTdJFNlBTf7j7b79XC
   Hs3hq4v8dcyXJ4zoQ/p6BrRjBEZ+1NXUIUZ5xaPX2YlvD5rWeDCauwLhg
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="353346621"
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="353346621"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 00:18:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="744571129"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 02 Aug 2022 00:18:47 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 02 Aug 2022 10:18:46 +0300
Date:   Tue, 2 Aug 2022 10:18:46 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: typec: retimer: Add missing id check in match
 callback
Message-ID: <YujP1oOHojuB9iXa@kuha.fi.intel.com>
References: <20220725203129.1973260-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220725203129.1973260-1-nfraprado@collabora.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 04:31:29PM -0400, Nícolas F. R. A. Prado wrote:
> The fwnode_connection_find_match() function handles two cases: named
> references and graph endpoints. In the second case, the match function
> passed in is called with the id to check for the match. However, the
> match function for the recently added type-c retimer class assumes the
> connection has already been matched (which is only true for the first
> case).
> 
> The result is that with that change, all type-c nodes with graph
> endpoints defer probe indefinitely, independently of having a retimer
> connection or not.
> 
> Add the missing check, like is done by the type-c mux and usb role
> switch code, to fix the issue.
> 
> Fixes: ddaf8d96f93b ("usb: typec: Add support for retimers")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
>  drivers/usb/typec/retimer.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/retimer.c b/drivers/usb/typec/retimer.c
> index 051eaa7d2899..2003731f1bee 100644
> --- a/drivers/usb/typec/retimer.c
> +++ b/drivers/usb/typec/retimer.c
> @@ -36,8 +36,13 @@ static int retimer_fwnode_match(struct device *dev, const void *fwnode)
>  
>  static void *typec_retimer_match(struct fwnode_handle *fwnode, const char *id, void *data)
>  {
> -	struct device *dev  = class_find_device(&retimer_class, NULL, fwnode,
> -						retimer_fwnode_match);
> +	struct device *dev;
> +
> +	if (id && !fwnode_property_present(fwnode, id))
> +		return NULL;
> +
> +	dev = class_find_device(&retimer_class, NULL, fwnode,
> +				retimer_fwnode_match);
>  
>  	return dev ? to_typec_retimer(dev) : ERR_PTR(-EPROBE_DEFER);
>  }

thanks,

-- 
heikki
