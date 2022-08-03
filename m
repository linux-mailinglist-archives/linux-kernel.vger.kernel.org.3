Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E00588731
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbiHCGMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236490AbiHCGMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:12:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B98E2AE1D;
        Tue,  2 Aug 2022 23:12:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD3786145E;
        Wed,  3 Aug 2022 06:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B337CC433D6;
        Wed,  3 Aug 2022 06:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659507131;
        bh=Fnmgqu+s70UID3iFsQr2t3Z52LdIOA8XfpEJY2fXUPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SZl6+QFlgc+t6hTdPFclabjT30l16kHehX3SmYKzpzmZjh9ybHsdqKaCcnZcnYWNn
         Oe0SRyTO8EYYkuKeJ1ft8b1UNvHxuJSMf30xjUoATBGvJUCU/0ot0lXUN0IvvdROuz
         2/p0ik8tw+zgBEz9/exDomQ/zxCynayeHEQF5lWI=
Date:   Wed, 3 Aug 2022 08:12:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v6] ufs: core: print UFSHCD capabilities in controller's
 sysfs node
Message-ID: <YuoRuP2pxgSQ6c9E@kroah.com>
References: <20220803074955.v6.1.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803074955.v6.1.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 07:50:07AM +1000, Daniil Lunev wrote:
> Allows userspace to check if Clock Scaling and Write Booster are
> supported.
> 
> Signed-off-by: Daniil Lunev <dlunev@chromium.org>
> 
> ---
> 
> Changes in v6:
> * Add comment to clarify meaning of the "capbilities" sysfs group.
> 
> Changes in v5:
> * Correct wording for clock scaling.
> * Correct wording for the commit message.
> 
> Changes in v4:
> * Dropped crypto node per Eric Biggers mentioning it can be queried from
>   disk's queue node
> 
> Changes in v3:
> * Expose each capability individually.
> * Update documentation to represent new scheme.
> 
> Changes in v2:
> * Add documentation entry for the new sysfs node.
> 
>  Documentation/ABI/testing/sysfs-driver-ufs | 26 +++++++++++++++
>  drivers/ufs/core/ufs-sysfs.c               | 37 ++++++++++++++++++++++
>  2 files changed, 63 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
> index 6b248abb1bd71..1750a9b84ce0f 100644
> --- a/Documentation/ABI/testing/sysfs-driver-ufs
> +++ b/Documentation/ABI/testing/sysfs-driver-ufs
> @@ -1591,6 +1591,32 @@ Description:	This entry shows the status of HPB.
>  
>  		The file is read only.
>  
> +What:		/sys/bus/platform/drivers/ufshcd/*/capabilities/clock_scaling
> +What:		/sys/bus/platform/devices/*.ufs/capabilities/clock_scaling
> +Date:		July 2022
> +Contact:	Daniil Lunev <dlunev@chromium.org>
> +Description:	Indicates status of clock scaling.
> +
> +		== ============================
> +		0  Clock scaling is not supported.
> +		1  Clock scaling is supported.
> +		== ============================
> +
> +		The file is read only.
> +
> +What:		/sys/bus/platform/drivers/ufshcd/*/capabilities/write_booster
> +What:		/sys/bus/platform/devices/*.ufs/capabilities/write_booster
> +Date:		July 2022
> +Contact:	Daniil Lunev <dlunev@chromium.org>
> +Description:	Indicates status of Write Booster.
> +
> +		== ============================
> +		0  Write Booster can not be enabled.
> +		1  Write Booster can be enabled.
> +		== ============================
> +
> +		The file is read only.
> +
>  What:		/sys/class/scsi_device/*/device/hpb_param_sysfs/activation_thld
>  Date:		February 2021
>  Contact:	Avri Altman <avri.altman@wdc.com>
> diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
> index 0a088b47d5570..4149cdf19de92 100644
> --- a/drivers/ufs/core/ufs-sysfs.c
> +++ b/drivers/ufs/core/ufs-sysfs.c
> @@ -279,6 +279,42 @@ static const struct attribute_group ufs_sysfs_default_group = {
>  	.attrs = ufs_sysfs_ufshcd_attrs,
>  };
>  
> +static ssize_t clock_scaling_show(struct device *dev, struct device_attribute *attr,
> +				  char *buf)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%d\n", ufshcd_is_clkscaling_supported(hba));
> +}
> +
> +static ssize_t write_booster_show(struct device *dev, struct device_attribute *attr,
> +				  char *buf)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%d\n", ufshcd_is_wb_allowed(hba));
> +}
> +
> +static DEVICE_ATTR_RO(clock_scaling);
> +static DEVICE_ATTR_RO(write_booster);
> +
> +/*
> + * The "capabilities" sysfs group represents the effective capabilities of the
> + * host-device pair, i.e. the capabilities which are enabled in the driver for
> + * the specific host controller, supported by the host controller and are
> + * supported and/or have compatible configuration on the device side.

Why is this information not also in the Documentation/ABI/ entries as
well?

thanks,

greg k-h
