Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666B255764F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiFWJIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFWJIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:08:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96E01A078
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:08:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54CEE61D4D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF17C3411B;
        Thu, 23 Jun 2022 09:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655975290;
        bh=f0MFgvw7hzg7rQcTGBpDRqGzhW//YY93Vsb2+pnhDmc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mYm7s7+RS+VsRoXDmbB/nymgrLjiWV0nsKjzs9wBbl1T85DpByx36RPQ5lnHs9SK+
         ypUMz83Kkd6ukAitg6VIPqDYv5rf/JdQ0GtMRpzb5QxcInyHpu2HuW4rk2l8/3RYxX
         //viWgNCxtmMdibfRq+aUmtl87JrH5SkwSLW3jds=
Date:   Thu, 23 Jun 2022 11:08:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] driver core: Ignore driver_async_probe cmdline param
 for module drivers
Message-ID: <YrQtd5q+Q8i21gSF@kroah.com>
References: <20220623042150.762330-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623042150.762330-1-saravanak@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 09:21:50PM -0700, Saravana Kannan wrote:
> If the module's async_probe option isn't set, the module loading code
> will do a async_synchronize_full() before returning to userspace. This
> effectively negates any benefits of driver_async_probe listing the
> module's driver.
> 
> If the module's async_probe is set, then we already do async probe for
> that module's driver even if driver_async_probe does not list that
> driver. So, again, the driver_async_probe's value doesn't matter for a
> module's driver.
> 
> So this change ignores the driver_async_probe for module drivers to
> avoid useless async probes.
> 
> In addition, if driver_async_probe lists a module's driver and the
> driver's async probe ends up calling request_module() in the async
> thread context, that's going to trigger a spurious WARNING stack dump
> without any real benefits of async probing. So this will avoid that
> unnecessary warning in that situation.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Does this "fix" an older commit?  Does this need to be backported
anywhere?  Or is this just a new feature to help make things work
properly going forward?

> ---
>  drivers/base/dd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index e600dd2afc35..f1ac28a4ce62 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -823,7 +823,7 @@ bool driver_allows_async_probing(struct device_driver *drv)
>  		return false;
>  
>  	default:
> -		if (cmdline_requested_async_probing(drv->name))
> +		if (cmdline_requested_async_probing(drv->name) && drv->owner == NULL)

This feels odd, the module owner shouldn't be used for anything other
then the reference for the module being properly handled.  Not doing
different logic for built-in vs. not-built-in feels wrong, especially
asa some module drivers might not set the owner field for various
reasons (hint, networking drivers do not deal with the owner field as
they have different ways of handling the module reference logic.)

So I don't think this is ok, sorry.  Did you test this with networking
drivers?

thanks,

greg k-h
