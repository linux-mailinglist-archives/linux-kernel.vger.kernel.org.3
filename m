Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB05569C9B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbiGGIHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbiGGIHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:07:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B63333E29;
        Thu,  7 Jul 2022 01:07:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2837A61F51;
        Thu,  7 Jul 2022 08:07:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C64C3411E;
        Thu,  7 Jul 2022 08:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657181243;
        bh=1PJR3vSNi2CqctUA37KJUC5ljQpR0hSFxiwQaafsdrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h11WPHjnsVXBQRdtSVAD2tfv3aR7GPvQP6WHCL9YKf0qLe3WXI8kMmOJ3dNfzqM5+
         R6VB4LBjhMDEnhlXCyCQ0QEPOhJN3rygXaYpXZrxAHBuiuAbx/AJpCJHX8ShBvfWmj
         29tIRU+kvthFXiyavmGT+b/abfJ3zN/6i0UcQ7VA=
Date:   Thu, 7 Jul 2022 10:07:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Maxim Devaev <mdevaev@gmail.com>
Cc:     linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        balbi@kernel.org, caihuoqing@baidu.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: f_mass_storage: forced_eject attribute
Message-ID: <YsaUOWZogtkE0ZLF@kroah.com>
References: <20220706185936.24692-1-mdevaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706185936.24692-1-mdevaev@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 09:59:37PM +0300, Maxim Devaev wrote:
> It allows to reset prevent_medium_removal flag and "eject" the image.
> 
> The patch is a completely alternative implementation of the previously
> proposed [1], the idea of which was born after the mentioned discussion.
> 
> Signed-off-by: Maxim Devaev <mdevaev@gmail.com>
> Link: https://lore.kernel.org/lkml/20220406092445.215288-1-mdevaev@gmail.com [1]
> ---
>  .../testing/configfs-usb-gadget-mass-storage  |  6 +++++
>  Documentation/usb/gadget-testing.rst          |  6 +++++
>  Documentation/usb/mass-storage.rst            |  9 +++++++
>  drivers/usb/gadget/function/f_mass_storage.c  | 25 +++++++++++++++++++
>  drivers/usb/gadget/function/storage_common.c  | 11 ++++++++
>  drivers/usb/gadget/function/storage_common.h  |  2 ++
>  6 files changed, 59 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/configfs-usb-gadget-mass-storage b/Documentation/ABI/testing/configfs-usb-gadget-mass-storage
> index c86b63a7bb43..87859ef40579 100644
> --- a/Documentation/ABI/testing/configfs-usb-gadget-mass-storage
> +++ b/Documentation/ABI/testing/configfs-usb-gadget-mass-storage
> @@ -32,4 +32,10 @@ Description:
>  				being a CD-ROM.
>  		nofua		Flag specifying that FUA flag
>  				in SCSI WRITE(10,12)
> +		forced_eject	This write-only flag only makes sence when
> +				the function is active. It causes a forced
> +				detaching of the backing file from the LUN,
> +				regardless of whether the host has allowed it.
> +				Any non-zero number of bytes written will
> +				result in ejection.
>  		===========	==============================================
> diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
> index c18113077889..1481173d8719 100644
> --- a/Documentation/usb/gadget-testing.rst
> +++ b/Documentation/usb/gadget-testing.rst
> @@ -333,6 +333,12 @@ In each lun directory there are the following attribute files:
>  			being a CD-ROM.
>  	nofua		Flag specifying that FUA flag
>  			in SCSI WRITE(10,12)
> +	forced_eject	This write-only flag only makes sence when
> +			the function is active. It causes a forced
> +			detaching of the backing file from the LUN,
> +			regardless of whether the host has allowed it.
> +			Any non-zero number of bytes written will
> +			result in ejection.
>  	=============== ==============================================
>  
>  Testing the MASS STORAGE function
> diff --git a/Documentation/usb/mass-storage.rst b/Documentation/usb/mass-storage.rst
> index d181b47c3cb6..f72e59237bce 100644
> --- a/Documentation/usb/mass-storage.rst
> +++ b/Documentation/usb/mass-storage.rst
> @@ -181,6 +181,15 @@ sysfs entries
>      Reflects the state of nofua flag for given logical unit.  It can
>      be read and written.
>  
> +  - forced_eject
> +
> +    When written into, it allows to detach the backing file for given
> +    logical unit, regardless of whether the host has allowed it.
> +    The content doesn't matter, any non-zero number of bytes will
> +    lead the forced eject.
> +
> +    Can not be read.
> +
>    Other then those, as usual, the values of module parameters can be
>    read from /sys/module/g_mass_storage/parameters/* files.
>  
> diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
> index 6ad669dde41c..00cac2a38178 100644
> --- a/drivers/usb/gadget/function/f_mass_storage.c
> +++ b/drivers/usb/gadget/function/f_mass_storage.c
> @@ -2520,10 +2520,21 @@ static ssize_t file_store(struct device *dev, struct device_attribute *attr,
>  	return fsg_store_file(curlun, filesem, buf, count);
>  }
>  
> +static ssize_t forced_eject_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	struct fsg_lun		*curlun = fsg_lun_from_dev(dev);
> +	struct rw_semaphore	*filesem = dev_get_drvdata(dev);
> +
> +	return fsg_store_forced_eject(curlun, filesem, buf, count);
> +}
> +
>  static DEVICE_ATTR_RW(nofua);
>  /* mode wil be set in fsg_lun_attr_is_visible() */
>  static DEVICE_ATTR(ro, 0, ro_show, ro_store);
>  static DEVICE_ATTR(file, 0, file_show, file_store);
> +static DEVICE_ATTR_WO(forced_eject);
>  
>  /****************************** FSG COMMON ******************************/
>  
> @@ -2677,6 +2688,7 @@ static struct attribute *fsg_lun_dev_attrs[] = {
>  	&dev_attr_ro.attr,
>  	&dev_attr_file.attr,
>  	&dev_attr_nofua.attr,
> +	&dev_attr_forced_eject.attr,
>  	NULL
>  };
>  
> @@ -3090,6 +3102,18 @@ static ssize_t fsg_lun_opts_inquiry_string_store(struct config_item *item,
>  
>  CONFIGFS_ATTR(fsg_lun_opts_, inquiry_string);
>  
> +static ssize_t fsg_lun_opts_forced_eject_store(struct config_item *item,
> +					       const char *page, size_t len)
> +{
> +	struct fsg_lun_opts *opts = to_fsg_lun_opts(item);
> +	struct fsg_opts *fsg_opts = to_fsg_opts(opts->group.cg_item.ci_parent);
> +
> +	return fsg_store_forced_eject(opts->lun, &fsg_opts->common->filesem,
> +				      page, len);
> +}
> +
> +CONFIGFS_ATTR_WO(fsg_lun_opts_, forced_eject);
> +
>  static struct configfs_attribute *fsg_lun_attrs[] = {
>  	&fsg_lun_opts_attr_file,
>  	&fsg_lun_opts_attr_ro,
> @@ -3097,6 +3121,7 @@ static struct configfs_attribute *fsg_lun_attrs[] = {
>  	&fsg_lun_opts_attr_cdrom,
>  	&fsg_lun_opts_attr_nofua,
>  	&fsg_lun_opts_attr_inquiry_string,
> +	&fsg_lun_opts_attr_forced_eject,
>  	NULL,
>  };
>  
> diff --git a/drivers/usb/gadget/function/storage_common.c b/drivers/usb/gadget/function/storage_common.c
> index b859a158a414..8cd95bf7831f 100644
> --- a/drivers/usb/gadget/function/storage_common.c
> +++ b/drivers/usb/gadget/function/storage_common.c
> @@ -519,4 +519,15 @@ ssize_t fsg_store_inquiry_string(struct fsg_lun *curlun, const char *buf,
>  }
>  EXPORT_SYMBOL_GPL(fsg_store_inquiry_string);
>  
> +ssize_t fsg_store_forced_eject(struct fsg_lun *curlun, struct rw_semaphore *filesem,
> +			       const char *buf, size_t count)
> +{
> +	int ret;
> +
> +	curlun->prevent_medium_removal = 0;
> +	ret = fsg_store_file(curlun, filesem, "", 0);
> +	return ret < 0 ? ret : count;
> +}
> +EXPORT_SYMBOL_GPL(fsg_store_forced_eject);
> +
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/usb/gadget/function/storage_common.h b/drivers/usb/gadget/function/storage_common.h
> index bdeb1e233fc9..0a544a82cbf8 100644
> --- a/drivers/usb/gadget/function/storage_common.h
> +++ b/drivers/usb/gadget/function/storage_common.h
> @@ -219,5 +219,7 @@ ssize_t fsg_store_removable(struct fsg_lun *curlun, const char *buf,
>  			    size_t count);
>  ssize_t fsg_store_inquiry_string(struct fsg_lun *curlun, const char *buf,
>  				 size_t count);
> +ssize_t fsg_store_forced_eject(struct fsg_lun *curlun, struct rw_semaphore *filesem,
> +			       const char *buf, size_t count);
>  
>  #endif /* USB_STORAGE_COMMON_H */
> -- 
> 2.37.0
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
