Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C2156A674
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbiGGO64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236732AbiGGO6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:58:15 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 3EBAA57272
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 07:57:43 -0700 (PDT)
Received: (qmail 427876 invoked by uid 1000); 7 Jul 2022 10:57:42 -0400
Date:   Thu, 7 Jul 2022 10:57:42 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Maxim Devaev <mdevaev@gmail.com>
Cc:     linux-usb@vger.kernel.org, balbi@kernel.org,
        gregkh@linuxfoundation.org, caihuoqing@baidu.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: f_mass_storage: forced_eject attribute
Message-ID: <Ysb0ZiEveXvmrC2f@rowland.harvard.edu>
References: <20220706185936.24692-1-mdevaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706185936.24692-1-mdevaev@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

Generally quite good, but the documentation needs some improvement.

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

s/flag/file/

Instead of "only makes sense" (note the spelling), how about "is useful 
only" or "operates only"?

By the way, what does happen if someone writes to this attribute file 
before the function is active?  Have you tested this?

> +				the function is active. It causes a forced
> +				detaching of the backing file from the LUN,

Slightly improved wording: "It causes the backing file to be forcibly 
detached from the LUN".

> +				regardless of whether the host has allowed it.
> +				Any non-zero number of bytes written will
> +				result in ejection.

Doesn't a zero-byte write also work?

The same suggested changes apply to the documentation added below.

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

This should be phrased in the same way as above.  The file doesn't 
"allow" anything; it _causes_ the backing file to be detached.

> +    logical unit, regardless of whether the host has allowed it.

Same as above, use "LUN" here instead of "logical unit".

Alan Stern

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
