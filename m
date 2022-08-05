Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579C758A8D1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 11:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbiHEJb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 05:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiHEJb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:31:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BE8101CA;
        Fri,  5 Aug 2022 02:31:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 836F0B82852;
        Fri,  5 Aug 2022 09:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D770EC433C1;
        Fri,  5 Aug 2022 09:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659691912;
        bh=kiLMahSrWtV7J3A9GWnPiuH47W5lobYcpvmzE+dR86U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T+j/pari0Xato8E5V76riGnOp9tj9R/FcBzUXxtaKmtr0KdffMrZaZHnT/0xCdhsx
         79T6QkQctqPQKImuLFYbgZbc9ppwyOX6RMN9xGPrY96rJpinw6HQgRnAn186bkMQxE
         Xc/7S7/UsoWx6E6SoiZNJ9hrnQUshEVWZ3QBD4ww=
Date:   Fri, 5 Aug 2022 11:31:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Szuying Chen <chensiying21@gmail.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        mika.westerberg@linux.intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yd_Tseng@asmedia.com.tw, Richard_Hsu@asmedia.com.tw,
        Chloe_Chen@asmedia.com.tw
Subject: Re: [PATCH] thunderbolt: thunderbolt: add vendor's NVM formats
Message-ID: <YuzjhWylGJIFIJ2s@kroah.com>
References: <20220805092224.2536-1-Chloe_Chen@asmedia.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805092224.2536-1-Chloe_Chen@asmedia.com.tw>
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 05:22:24PM +0800, Szuying Chen wrote:
> The patch add tb_nvm_quirks() contain an array that has functions pointers to tb_nvm_vendor_apply().
> And tb_nvm_vendor_apply() that recognize supported vendor works in one of the following cases:
> Case 0:enable nvm's attribute by setting no_nvm_upgrade flag to create nvm_authenticate file node.
> Case 1:add active/non-active NVM devices.
> Case 2:update firmware to non-ative NVM device.

Please wrap your changelog text at 72 columns.

> 
> Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>

This does not match with your From: line in your email.  Please put the
correct From: line in the changelog text as the documentation suggests
when you can't use your corporate email system for patches.

> ---
>  drivers/thunderbolt/nvm.c    | 163 +++++++++++++++++++++++++++++++++++
>  drivers/thunderbolt/switch.c |  12 +++
>  drivers/thunderbolt/tb.h     |  12 +++
>  3 files changed, 187 insertions(+)
> 
> diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
> index b3f310389378..d5f283889da8 100644
> --- a/drivers/thunderbolt/nvm.c
> +++ b/drivers/thunderbolt/nvm.c
> @@ -9,10 +9,173 @@
>  #include <linux/idr.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
> +#include <linux/pm_runtime.h>
> 
>  #include "tb.h"
> 
>  static DEFINE_IDA(nvm_ida);
> +static int tb_switch_nvm_read(void *priv, unsigned int offset, void *val,
> +			      size_t bytes)

Please put the blank line back after the DEFINE_IDA line.


> +{
> +	struct tb_nvm *nvm = priv;
> +	struct tb_switch *sw = tb_to_switch(nvm->dev);
> +	int ret;
> +
> +	pm_runtime_get_sync(&sw->dev);
> +
> +	if (!mutex_trylock(&sw->tb->lock)) {
> +		ret = restart_syscall();

Why not just wait for the lock?  What does restarting help with?

> +		goto out;
> +	}
> +
> +	ret = usb4_switch_nvm_read(sw, offset, val, bytes);
> +	mutex_unlock(&sw->tb->lock);
> +
> +out:
> +	pm_runtime_mark_last_busy(&sw->dev);
> +	pm_runtime_put_autosuspend(&sw->dev);
> +
> +	return ret;
> +}
> +
> +static int tb_switch_nvm_write(void *priv, unsigned int offset, void *val,
> +			       size_t bytes)
> +{
> +	struct tb_nvm *nvm = priv;
> +	struct tb_switch *sw = tb_to_switch(nvm->dev);
> +	int ret;
> +
> +	if (!mutex_trylock(&sw->tb->lock))
> +		return restart_syscall();
> +
> +	/*
> +	 * Since writing the NVM image might require some special steps,
> +	 * for example when CSS headers are written, we cache the image
> +	 * locally here and handle the special cases when the user asks
> +	 * us to authenticate the image.
> +	 */
> +	ret = tb_nvm_write_buf(nvm, offset, val, bytes);
> +	mutex_unlock(&sw->tb->lock);
> +
> +	return ret;
> +}
> +
> +static int tb_nvm_vendor_apply(struct tb_switch *sw, unsigned int handle)
> +{
> +	int ret = 0;
> +
> +	switch (handle) {
> +	case 0:
> +		if (sw->no_nvm_upgrade)
> +			sw->no_nvm_upgrade = false;
> +
> +		break;
> +
> +	case 1:
> +		struct tb_nvm *nvm;
> +		u32 val;
> +		u32 nvm_size;
> +
> +		nvm = tb_nvm_alloc(&sw->dev);
> +		if (IS_ERR(nvm)) {
> +			ret = PTR_ERR(nvm);
> +			break;
> +		}
> +
> +		ret = usb4_switch_nvm_read(sw, NVM_Date, &val, sizeof(val));
> +		if (ret)
> +			break;
> +
> +		nvm->vendor.date = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) << 0x8 | (u8)(val >> 0x10));
> +		ret = usb4_switch_nvm_read(sw, NVM_CUSTOMER_ID, &val, sizeof(val));
> +		if (ret)
> +			break;
> +
> +		nvm->vendor.customerID = (((u8)val) << 0x8 | ((u8)(val >> 0x8)));
> +		nvm->vendor.version = (u8)(val >> 0x10);
> +		nvm_size = SZ_512K;
> +		ret = tb_nvm_add_active(nvm, nvm_size, tb_switch_nvm_read);
> +		if (ret)
> +			break;
> +
> +		ret = tb_nvm_add_non_active(nvm, NVM_MAX_SIZE, tb_switch_nvm_write);
> +		if (ret)
> +			break;
> +
> +		sw->nvm = nvm;
> +		break;
> +
> +	case 2:
> +		unsigned int image_size;
> +		const u8 *buf = sw->nvm->buf;
> +
> +		if (!buf) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +		image_size = sw->nvm->buf_data_size;
> +		if (image_size < NVM_MIN_SIZE || image_size > NVM_MAX_SIZE) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +		ret = usb4_switch_nvm_write(sw, 0, buf, image_size);
> +		if (!ret)
> +			sw->nvm->flushed = true;
> +
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	if ((handle == 1) && (ret != 0))
> +		tb_nvm_free(sw->nvm);
> +
> +	return ret;
> +}
> +
> +struct tb_nvm_id {
> +	u16 hw_vendor_id;
> +	u16 hw_device_id;
> +	u16 vendor;
> +	u16 device;
> +	int (*hook)(struct tb_switch *sw, unsigned int handle);
> +};
> +
> +static const struct tb_nvm_id tb_nvm_vendors[] = {
> +	/* ASMedia software CM firmware upgrade */
> +	{ 0x174c, 0x2428, 0x174c, 0x0009, tb_nvm_vendor_apply },
> +};
> +
> +/**
> + * tb_nvm_quirks() - support vendor's NVM format
> + * @sw: Thunderbolt switch
> + */
> +int tb_nvm_quirks(struct tb_switch *sw, unsigned int handle)

What is a handle here?  Why didn't you document it in the comments for
this function?

> +{
> +	int res, i;
> +	bool NoVendor = true;

Please always use checkpatch for your changes before you send them out.


> +
> +	for (i = 0; i < ARRAY_SIZE(tb_nvm_vendors); i++) {
> +		const struct tb_nvm_id *q = &tb_nvm_vendors[i];
> +
> +		if (q->hw_vendor_id && q->hw_vendor_id != sw->config.vendor_id)
> +			continue;
> +		if (q->hw_device_id && q->hw_device_id != sw->config.device_id)
> +			continue;
> +		if (q->vendor && q->vendor != sw->vendor)
> +			continue;
> +		if (q->device && q->device != sw->device)
> +			continue;

There should be a thunderbolt match device function somewhere already,
right?  If not, I suggest making one here.

> +
> +		 res = q->hook(sw, handle);
> +		 NoVendor = false;
> +	}
> +	if (NoVendor)
> +		return -ENODEV;

No need, if there are no quirks, that's fine, don't return an error.

> +	else
> +		return res;
> +}
> 
>  /**
>   * tb_nvm_alloc() - Allocate new NVM structure
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index 561e1d77240e..a654b6951bef 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -114,6 +114,10 @@ static int nvm_validate_and_write(struct tb_switch *sw)
>  	if (image_size < NVM_MIN_SIZE || image_size > NVM_MAX_SIZE)
>  		return -EINVAL;
> 
> +	ret = tb_nvm_quirks(sw, 2);

What is the "2" for?

> +	if (ret != -ENODEV)
> +		return ret;

Again, no need for -ENODEV checking here.

> +
>  	/*
>  	 * FARB pointer must point inside the image and must at least
>  	 * contain parts of the digital section we will be reading here.
> @@ -390,6 +394,11 @@ static int tb_switch_nvm_add(struct tb_switch *sw)
>  	if (!nvm_readable(sw))
>  		return 0;
> 
> +	/* Vendor's NVM formats definition */
> +	ret = tb_nvm_quirks(sw, 1);

What is the 1 for?

> +	if (ret != -ENODEV)
> +		return ret;
> +
>  	/*
>  	 * The NVM format of non-Intel hardware is not known so
>  	 * currently restrict NVM upgrade for Intel hardware. We may
> @@ -1953,6 +1962,8 @@ static ssize_t nvm_version_show(struct device *dev,
>  		ret = -ENODATA;
>  	else if (!sw->nvm)
>  		ret = -EAGAIN;
> +	else if (sw->config.vendor_id == 0x174C)

Don't you have a PCI id somewhere for this value?

> +		ret = sprintf(buf, "%06x_%04x_%02x\n", sw->nvm->vendor.date, sw->nvm->vendor.customerID, sw->nvm->vendor.version);

Why is this vendor special for a different string?

>  	else
>  		ret = sprintf(buf, "%x.%x\n", sw->nvm->major, sw->nvm->minor);
> 
> @@ -2860,6 +2871,7 @@ int tb_switch_add(struct tb_switch *sw)
>  		tb_sw_dbg(sw, "uid: %#llx\n", sw->uid);
> 
>  		tb_check_quirks(sw);
> +		tb_nvm_quirks(sw, 0);

What is 0 here?

> 
>  		ret = tb_switch_set_uuid(sw);
>  		if (ret) {
> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> index a831faa50f65..9dd1ba7b07b6 100644
> --- a/drivers/thunderbolt/tb.h
> +++ b/drivers/thunderbolt/tb.h
> @@ -27,6 +27,16 @@
>  #define NVM_VERSION		0x08
>  #define NVM_FLASH_SIZE		0x45
> 
> +/* ASMedia specific NVM offsets */
> +#define NVM_Date	0x1C
> +#define NVM_CUSTOMER_ID	0x28
> +
> +struct tb_nvm_vendor {

If this is ASMedia specific, please say that in the structure name.

> +	int	date;
> +	u16	customerID;

__le16?  Or is this really native-cpu-endian?

> +	u8	version;
> +};

thanks,

greg k-h
