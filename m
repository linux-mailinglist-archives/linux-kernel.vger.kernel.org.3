Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827B850C9E5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 14:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbiDWMbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 08:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbiDWMbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 08:31:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6260762B5;
        Sat, 23 Apr 2022 05:28:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24F84610A6;
        Sat, 23 Apr 2022 12:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293BFC385A0;
        Sat, 23 Apr 2022 12:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650716883;
        bh=xd32SN3BRqxRVtnNiYTREn60ZMNvYHMhRfZ1xfou+Ac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aSuyPNS2P0Uerv6f4EY/BvZFM2JXV6gDVy1P7a/yu8BpCmt13WXyJ7ydxk64yTa50
         Ckd1r2+QoBgKyOCvnzLcIBT4OMetSPhzeecal6W9BwqNLSRybhS3S8wZiQnl6t8IgF
         2WQHHDP9X0U5eUL0eQ11epShUBhHIuQA0J8ngQxGfDnJhZUDvhhZyW5aMbuVn7jqfP
         R0Ki2J//X06DmizOdhw/D/LrmwHNjrvWuOdbpTn/oNGdEblyCXkAir9ADUWKcnvcUn
         C7Sk7uk40M9BrxHS8dI/3hMfnOqu4/F4TZ7gbfcFPUkdH4gfeAy78n2npxN4yj1fnR
         4xP0urMChPvtQ==
Date:   Sat, 23 Apr 2022 17:57:56 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] bus: mhi: host: Add soc_reset sysfs
Message-ID: <20220423122756.GM374560@thinkpad>
References: <1650302327-30439-1-git-send-email-quic_jhugo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650302327-30439-1-git-send-email-quic_jhugo@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 11:18:47AM -0600, Jeffrey Hugo wrote:
> The MHI bus supports a standardized hardware reset, which is known as the
> "SoC Reset".  This reset is similar to the reset sysfs for PCI devices -
> a hardware mechanism to reset the state back to square one.
> 
> The MHI SoC Reset is described in the spec as a reset of last resort.  If
> some unrecoverable error has occurred where other resets have failed, SoC
> Reset is the "big hammer" that ungracefully resets the device.  This is
> effectivly the same as yanking the power on the device, and reapplying it.
> However, depending on the nature of the particular issue, the underlying
> transport link may remain active and configured.  If the link remains up,
> the device will flag a MHI system error early in the boot process after
> the reset is executed, which allows the MHI bus to process a fatal error
> event, and clean up appropiately.
> 
> While the SoC Reset is generally intended as a means of recovery when all
> else has failed, it can be useful in non-error scenarios.  For example,
> if the device loads firmware from the host filesystem, the device may need
> to be fully rebooted inorder to pick up the new firmware.  In this
> scenario, the system administrator may use the soc_reset sysfs to cause
> the device to pick up the new firmware that the admin placed on the
> filesystem.
> 
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Reviewed-by: Bhaumik Bhatt <quic_bbhatt@quicinc.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to mhi-next!

Thanks,
Mani

> ---
> 
> v3:
> Cleanup email domain change
> 
> v2:
> Rebase
> 
>  Documentation/ABI/stable/sysfs-bus-mhi | 10 ++++++++++
>  drivers/bus/mhi/host/init.c            | 14 ++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-bus-mhi b/Documentation/ABI/stable/sysfs-bus-mhi
> index ecfe766..96ccc33 100644
> --- a/Documentation/ABI/stable/sysfs-bus-mhi
> +++ b/Documentation/ABI/stable/sysfs-bus-mhi
> @@ -19,3 +19,13 @@ Description:	The file holds the OEM PK Hash value of the endpoint device
>  		read without having the device power on at least once, the file
>  		will read all 0's.
>  Users:		Any userspace application or clients interested in device info.
> +
> +What:           /sys/bus/mhi/devices/.../soc_reset
> +Date:           April 2022
> +KernelVersion:  5.19
> +Contact:        mhi@lists.linux.dev
> +Description:	Initiates a SoC reset on the MHI controller.  A SoC reset is
> +                a reset of last resort, and will require a complete re-init.
> +                This can be useful as a method of recovery if the device is
> +                non-responsive, or as a means of loading new firmware as a
> +                system administration task.
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index a665b8e..a8c18c5f 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -108,9 +108,23 @@ static ssize_t oem_pk_hash_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(oem_pk_hash);
>  
> +static ssize_t soc_reset_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf,
> +			       size_t count)
> +{
> +	struct mhi_device *mhi_dev = to_mhi_device(dev);
> +	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
> +
> +	mhi_soc_reset(mhi_cntrl);
> +	return count;
> +}
> +static DEVICE_ATTR_WO(soc_reset);
> +
>  static struct attribute *mhi_dev_attrs[] = {
>  	&dev_attr_serial_number.attr,
>  	&dev_attr_oem_pk_hash.attr,
> +	&dev_attr_soc_reset.attr,
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(mhi_dev);
> -- 
> 2.7.4
> 
