Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C98547BCDF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236365AbhLUJaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbhLUJaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:30:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86FAC061574;
        Tue, 21 Dec 2021 01:30:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4741061335;
        Tue, 21 Dec 2021 09:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FBBC36AE2;
        Tue, 21 Dec 2021 09:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640079001;
        bh=t9uG/PUzJfJCt5vq7qOvzQiuQHsRYBb+5hBgWJjQF8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MMrMbGrsqXDDJawxnYTgl5OlqV29ks8dDbYtGt+9DN7vpqfD5awhcaVrfIphjkLhR
         eCRBU9SysvivSe0EOauQNT2dECjbHZrp5OFoLLZrHfj5oxihlfsbp1jTAEj+M4zMa2
         qN4tkQlXtDx9JJihAZOgHkEn4Qjac7ihVzHqkY94=
Date:   Tue, 21 Dec 2021 10:29:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v4 01/34] component: Introduce struct aggregate_device
Message-ID: <YcGel9PtOgqWH6l3@kroah.com>
References: <20211202222732.2453851-1-swboyd@chromium.org>
 <20211202222732.2453851-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202222732.2453851-2-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 02:26:59PM -0800, Stephen Boyd wrote:
> Replace 'struct master' with 'struct aggregate_device' and then rename
> 'master' to 'adev' everywhere in the code. While we're here, put a
> struct device inside the aggregate device so that we can register it
> with a bus_type in the next patch.
> 
> The diff is large but that's because this is mostly a rename, where
> sometimes 'master' is replaced with 'adev' and other times it is
> replaced with 'parent' to indicate that the struct device that was being
> used is actually the parent of the aggregate device and driver.
> 
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/base/component.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/component.c b/drivers/base/component.c
> index 2d25a6416587..d25048d04b70 100644
> --- a/drivers/base/component.c
> +++ b/drivers/base/component.c
> @@ -9,6 +9,7 @@
>   */
>  #include <linux/component.h>
>  #include <linux/device.h>
> +#include <linux/idr.h>
>  #include <linux/list.h>
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
> @@ -63,7 +64,10 @@ struct master {
>  
>  	const struct component_master_ops *ops;
>  	struct device *parent;
> +	struct device dev;

Who initializes this new structure?

>  	struct component_match *match;
> +
> +	int id;
>  };
>  
>  struct component {
> @@ -79,6 +83,7 @@ struct component {
>  static DEFINE_MUTEX(component_mutex);
>  static LIST_HEAD(component_list);
>  static LIST_HEAD(masters);
> +static DEFINE_IDA(aggregate_ida);
>  
>  #ifdef CONFIG_DEBUG_FS
>  
> @@ -440,6 +445,7 @@ static void free_master(struct master *master)
>  		}
>  	}
>  
> +	ida_free(&aggregate_ida, master->id);
>  	kfree(master);
>  }
>  
> @@ -460,7 +466,7 @@ int component_master_add_with_match(struct device *parent,
>  	struct component_match *match)
>  {
>  	struct master *master;
> -	int ret;
> +	int ret, id;
>  
>  	/* Reallocate the match array for its true size */
>  	ret = component_match_realloc(match, match->num);
> @@ -471,9 +477,17 @@ int component_master_add_with_match(struct device *parent,
>  	if (!master)
>  		return -ENOMEM;
>  
> +	id = ida_alloc(&aggregate_ida, GFP_KERNEL);
> +	if (id < 0) {
> +		kfree(master);
> +		return id;
> +	}
> +
> +	master->id = id;
>  	master->parent = parent;
>  	master->ops = ops;
>  	master->match = match;
> +	dev_set_name(&master->dev, "aggregate%d", id);

You set the name yet the device is not "real"?

I don't understand this patch at all, sorry.

greg k-h
