Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3D74673E1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 10:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379563AbhLCJZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 04:25:40 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37728 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351316AbhLCJZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 04:25:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7985162985
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 09:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE4DC53FAD;
        Fri,  3 Dec 2021 09:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638523334;
        bh=4JEFNZRdq3WznXssMg2+WLRPghAzeUklMa4y9yBiDOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HeMdtqAUHnJD+Qi8mwhPBNbJvHKbl8DwvcUciu4lGRhTCtMLRwEPx+lj4ENApJsm9
         mPem/FPwSmPznrngUP/0qb898/xRFXarKVbzm7psfrsEXoGwDAwouFopX0S31jdqP7
         EQQSOjjV7WRr4ZeOxW44PBiOcoZ/nwzxMNCSa0vI=
Date:   Fri, 3 Dec 2021 10:22:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ronak Jain <ronak.jain@xilinx.com>
Cc:     michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        rajan.vaja@xilinx.com, corbet@lwn.net,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        lakshmi.sai.krishna.potthuri@xilinx.com
Subject: Re: [PATCH v3 3/3] firmware: xilinx: Add sysfs support for feature
 config
Message-ID: <YanhxIoxkPb+rYN5@kroah.com>
References: <20211203091814.15582-1-ronak.jain@xilinx.com>
 <20211203091814.15582-4-ronak.jain@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203091814.15582-4-ronak.jain@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 01:18:14AM -0800, Ronak Jain wrote:
> Add support for sysfs interface for runtime features configuration.
>  The user can configure the features at runtime. First the user need
>  to select the config id of the supported features and then the user
>  can configure the parameters of the feature based on the config id.
>  So far the support is added for the over temperature and external
>  watchdog features.
> 
> Added zynqmp_devinfo structure to handle muliple driver instances
>  when accessed by multiple devices.
> 
> Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
> ---
> Changes in v3:
> - Added zynqmp_devinfo structure to store device instances
> - Modified feature_conf_id from atomic variable to u32
> - Update commit message
> - Resolved merge conflicts
> 
> Changes in v2:
> - Update commit message
> ---
>  drivers/firmware/xilinx/zynqmp.c | 93 ++++++++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 6b05844e67d7..f37a8e805cd7 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -38,6 +38,16 @@
>  static bool feature_check_enabled;
>  static DEFINE_HASHTABLE(pm_api_features_map, PM_API_FEATURE_CHECK_MAX_ORDER);
>  
> +/**
> + * struct zynqmp_devinfo - Structure for Zynqmp device instance
> + * @dev:		Device Pointer
> + * @feature_conf_id:	Feature conf id
> + */
> +struct zynqmp_devinfo {
> +	struct device *dev;
> +	u32 feature_conf_id;
> +};
> +
>  /**
>   * struct pm_api_feature_data - PM API Feature data
>   * @pm_api_id:		PM API Id, used as key to index into hashmap
> @@ -1424,6 +1434,78 @@ static DEVICE_ATTR_RW(pggs1);
>  static DEVICE_ATTR_RW(pggs2);
>  static DEVICE_ATTR_RW(pggs3);
>  
> +static ssize_t feature_config_id_show(struct device *device,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	struct zynqmp_devinfo *devinfo = dev_get_drvdata(device);
> +
> +	return sysfs_emit(buf, "%d\n", devinfo->feature_conf_id);
> +}

You are adding new sysfs files without any Documentation/ABI/ entries :(

Please fix.

thanks,

greg k-h
