Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C57588C28
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbiHCMcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiHCMb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:31:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78A01A074
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 05:31:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91295B8225D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 12:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3D0C433D7;
        Wed,  3 Aug 2022 12:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659529915;
        bh=hHyOWrVaNjl5PfSM5D5Apuu2LwwIaKPH1g2WPnvwQYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YAQi4kc1RpEdCuPBKsZ+UR+zlE2pLu+IWBS/ngrYLpIKWY25Ey/Ygcrq2mV1/NaAS
         sfP+3YAXjKwjkIqG5KKkQn6oTwjhcGfEa1v7d+zu1IFVaPLYGNJPiaNVj1sQhsBhqm
         2QL/EuGYCGcyK0WsrEm3qkGLaUbjPicbbPpEaWN4=
Date:   Wed, 3 Aug 2022 14:31:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nipun Gupta <nipun.gupta@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rafael@kernel.org, maz@kernel.org, tglx@linutronix.de,
        okaya@kernel.org, harpreet.anand@amd.com, michal.simek@amd.com,
        nikhil.agarwal@amd.com
Subject: Re: [RFC PATCH 2/2] driver core: add compatible string in sysfs for
 platform devices
Message-ID: <YupquKhvLR7zAwa/@kroah.com>
References: <20220803122655.100254-1-nipun.gupta@amd.com>
 <20220803122655.100254-3-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803122655.100254-3-nipun.gupta@amd.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 05:56:55PM +0530, Nipun Gupta wrote:
> For devices registered dynamically using platform_device_register
> API, this patch exposes the sysfs entry for the compatible string.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> ---
>  drivers/base/platform.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 51bb2289865c..89949f88a0a1 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1289,10 +1289,25 @@ static ssize_t driver_override_store(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(driver_override);
>  
> +static ssize_t compatible_show(struct device *dev, struct device_attribute *attr,
> +			      char *buf)
> +{
> +	const char *compat;
> +	int ret;
> +
> +	ret = device_property_read_string(dev, "compatible", &compat);
> +	if (ret != 0)
> +		return 0;
> +
> +	return sysfs_emit(buf, "%s", compat);
> +}
> +static DEVICE_ATTR_RO(compatible);

You forgot the Documentation/ABI/ update :(

Also, what happens if there is no such string to read?  Why are you
returning 0?  You should not create the attribute at all then, right?

thanks,

greg k-h
