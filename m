Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CB1516055
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 22:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245051AbiD3UZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 16:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243477AbiD3UZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 16:25:23 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D152749C97;
        Sat, 30 Apr 2022 13:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651350120; x=1682886120;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6jbPuSw3k3iSchP4UYOMtIzdN+2guCWB74XjbgdKQmk=;
  b=U2xI56JngC392/wQAFogyJlvzOL28C8Eed83qS3J4ORg58rzewAJiJyi
   +B5uyG5ZKh6tDOKPoLvgh7jDVaeGBPji4H/e/q77YtIFydvh9FKV+rEvV
   b/PCAn6k8G3riBlL8p9+561S6uIlyz4X51vXj8BAZZEPXksbSD6Gi/fIx
   SG75kGhbEk09o5e11ak7WnrmnKoYD7yYZeC2rcJ6128CPXyQn6nTmCyCk
   uuAMICUh9oaT57RcF2Z8dSaRdhNXx68ncq8e2zRfgIxdwn50hvQPq8qnx
   jqmvRYqpCQak/wMbkwYiLa0JLMSbhDyAfpizA36eB5YHRtwAdgIKsh69D
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10333"; a="327438660"
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="327438660"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 13:22:00 -0700
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="809591388"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 13:21:56 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 9F2D220423;
        Sat, 30 Apr 2022 23:21:24 +0300 (EEST)
Date:   Sat, 30 Apr 2022 23:21:24 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        swboyd@chromium.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        freedreno@lists.freedesktop.org,
        Saravana Kannan <saravanak@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device property: Fix recent breakage of
 fwnode_get_next_parent_dev()
Message-ID: <Ym2aRE/CkLsuJYzM@paasikivi.fi.intel.com>
References: <20220429164325.1.I2a3b980ea051e59140227999f0f0ca16f1125768@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429164325.1.I2a3b980ea051e59140227999f0f0ca16f1125768@changeid>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 04:43:47PM -0700, Douglas Anderson wrote:
> Due to a subtle typo, instead of commit 87ffea09470d ("device
> property: Introduce fwnode_for_each_parent_node()") being a no-op
> change, it ended up causing the display on my sc7180-trogdor-lazor
> device from coming up unless I added "fw_devlink=off" to my kernel
> command line. Fix the typo.
> 
> Fixes: 87ffea09470d ("device property: Introduce fwnode_for_each_parent_node()")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Good catch, thanks!

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

> ---
> 
>  drivers/base/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 36401cfe432c..52e85dcb20b5 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -600,7 +600,7 @@ struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode)
>  	struct device *dev;
>  
>  	fwnode_for_each_parent_node(fwnode, parent) {
> -		dev = get_dev_from_fwnode(fwnode);
> +		dev = get_dev_from_fwnode(parent);
>  		if (dev) {
>  			fwnode_handle_put(parent);
>  			return dev;

-- 
Sakari Ailus
