Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B4A4A90F0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 23:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353215AbiBCW73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 17:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238236AbiBCW70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 17:59:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87327C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 14:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8HqaPYHIvIhIoq8Het0ftM6hveoX/zpB/Nhf+wpw6ho=; b=K4/yLmTRMK8xgIMvuXf4uSObTN
        Fa4SLvcn8FWT+oc5xqq3JA6BkFnS6AjII5KlUiISTVGCXx6e9IXmIyb/ORt8UIFT3DYtmrkWbXpsX
        e5oATofnw9lHwzmAHRG3UIOn/Fsx1zJbIRd4TgpQkxxesh+G2BIodyp5kC1sg9oxgnQ6XPAYW1lFR
        1qPQseRN7By4XLYouZtH+ASPJ+ZciSiaCa66pj/+8hYe8MsDwODVb+2QcAB2hPwOdLccsS3L6MjN9
        yw/6Fk4uXsEyJDDGS/OyF236jpmlRZlDHLrNsqxc+qaHjR2TUjmh8kVVzWfv/s7+P2kVD1dpAMA/s
        xJKnCgUQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFl4V-0033ns-Mp; Thu, 03 Feb 2022 22:59:23 +0000
Date:   Thu, 3 Feb 2022 14:59:23 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com
Subject: Re: [RFC PATCH 4/5] firmware_loader: Add firmware-upload support
Message-ID: <YfxeSw5n/qUWGcz8@bombadil.infradead.org>
References: <20220203213053.360190-1-russell.h.weight@intel.com>
 <20220203213053.360190-5-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203213053.360190-5-russell.h.weight@intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 02:30:51PM -0700, Russ Weight wrote:
> Extend the firmware subsystem to support a persistent sysfs interface that
> userspace may use to initiate a firmware update. For example, FPGA based
> PCIe cards load firmware and FPGA images from local FLASH when the card
> boots. The images in FLASH may be updated with new images provided by the
> user at his/her convenience.
> 
> A device driver may call fw_upload_register() to expose persistent
> "loading" and "data" sysfs files. These files are used in the same way as
> the fallback sysfs "loading" and "data" files. When 0 is written to
> "loading" to complete the write of firmware data, the data is transferred
> to the lower-level driver using pre-registered call-back functions. The
> data transfer is done in the context of a kernel worker thread.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  .../ABI/testing/sysfs-class-firmware          |  32 +++
>  .../driver-api/firmware/fw_upload.rst         |  86 +++++++
>  Documentation/driver-api/firmware/index.rst   |   1 +
>  drivers/base/firmware_loader/Kconfig          |  14 ++
>  drivers/base/firmware_loader/Makefile         |   1 +
>  drivers/base/firmware_loader/firmware.h       |   6 +
>  drivers/base/firmware_loader/fw_sysfs.c       |  50 +++-
>  drivers/base/firmware_loader/fw_sysfs.h       |   4 +
>  drivers/base/firmware_loader/fw_upload.c      | 229 ++++++++++++++++++
>  drivers/base/firmware_loader/fw_upload.h      |  24 ++
>  drivers/base/firmware_loader/main.c           |  16 +-
>  include/linux/firmware.h                      |  72 ++++++
>  12 files changed, 523 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-firmware
>  create mode 100644 Documentation/driver-api/firmware/fw_upload.rst
>  create mode 100644 drivers/base/firmware_loader/fw_upload.c
>  create mode 100644 drivers/base/firmware_loader/fw_upload.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-firmware b/Documentation/ABI/testing/sysfs-class-firmware
> new file mode 100644
> index 000000000000..a2e518f0bf8a
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-firmware
> @@ -0,0 +1,32 @@
> +What: 		/sys/class/firmware/.../data
> +Date:		Mar 2022
> +KernelVersion:	5.18
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	The data sysfs file is used for firmware-fallback and for
> +		firmware uploads. Cat a firmware image to this sysfs file
> +		after you echo 1 to the loading sysfs file. When the firmware
> +		image write is complete, echo 0 to the loading sysfs file. This
> +		sequence will signal the completion of the firmware write and
> +		signal the lower-level driver that the firmware data is
> +		available.
> +
> +What: 		/sys/class/firmware/.../loading
> +Date:		Mar 2022
> +KernelVersion:	5.18
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	The loading sysfs file is used for both firmware-fallback and
> +		for firmware uploads. Echo 1 onto the loading file to indicate
> +		you are writing a firmware file to the data sysfs node. Echo
> +		-1 onto this file to abort the data write or echo 0 onto this
> +		file to indicate that the write is complete. For firmware
> +		uploads, the zero value also triggers the transfer of the
> +		firmware data to the lower-level device driver.
> +
> +What: 		/sys/class/firmware/.../timeout
> +Date:		Mar 2022
> +KernelVersion:	5.18
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	This file supports the timeout mechanism for firmware
> +		fallback.  This file has no affect on firmware uploads. For
> +		more information on timeouts please see the documentation
> +		for firmware fallback.
> diff --git a/Documentation/driver-api/firmware/fw_upload.rst b/Documentation/driver-api/firmware/fw_upload.rst
> new file mode 100644
> index 000000000000..bf272f627a1f
> --- /dev/null
> +++ b/Documentation/driver-api/firmware/fw_upload.rst
> @@ -0,0 +1,86 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=============
> +fw_upload API
> +=============
> +
> +A device driver that registers with the firmware loader will expose
> +persistent sysfs nodes to enable users to initiate firmware updates for
> +that device.  It is the responsibility of the device driver and/or the
> +device itself to perform any validation on the data received. Firmware
> +upload uses the same *loading* and *data* sysfs files described in the
> +documentation for firmware fallback.
> +
> +Register for firmware upload
> +============================
> +
> +A device driver registers for firmware upload by calling fw_upload_register().
> +Among the parameter list is a name to identify the device under
> +/sys/class/firmware. A user may initiate a firmware upload by echoing
> +a 1 to the *loading* sysfs file for the target device. Next, the user writes
> +the firmware image to the *data* sysfs file. After writing the firmware
> +data, the user echos 0 to the *loading* sysfs file to signal completion.
> +Echoing 0 to *loading* also triggers the transfer of the firmware to the
> +lower-lever device driver in the context of a kernel worker thread.
> +
> +To use the fw_upload API, write a driver that implements a set of ops. The
> +probe function calls fw_upload_register() and the remove function calls
> +fw_upload_unregister() such as::
> +
> +	static const struct fw_upload_ops m10bmc_ops = {
> +		.prepare = m10bmc_sec_prepare,
> +		.write = m10bmc_sec_write,
> +		.poll_complete = m10bmc_sec_poll_complete,
> +		.cancel = m10bmc_sec_cancel,
> +		.cleanup = m10bmc_sec_cleanup,
> +	};
> +
> +	static int m10bmc_sec_probe(struct platform_device *pdev)
> +	{
> +		const char *fw_name, *truncate;
> +		struct m10bmc_sec *sec;
> +		struct fw_upload *fwl;
> +		unsigned int len;
> +
> +		sec = devm_kzalloc(&pdev->dev, sizeof(*sec), GFP_KERNEL);
> +		if (!sec)
> +			return -ENOMEM;
> +
> +		sec->dev = &pdev->dev;
> +		sec->m10bmc = dev_get_drvdata(pdev->dev.parent);
> +		dev_set_drvdata(&pdev->dev, sec);
> +
> +		fw_name = dev_name(sec->dev);
> +		truncate = strstr(fw_name, ".auto");
> +		len = (truncate) ? truncate - fw_name : strlen(fw_name);
> +		sec->fw_name = kmemdup_nul(fw_name, len, GFP_KERNEL);
> +
> +		fwl = fw_upload_register(sec->dev, sec->fw_name, &m10bmc_ops, sec);
> +		if (IS_ERR(fwl)) {
> +			dev_err(sec->dev, "Firmware Upload driver failed to start\n");
> +			kfree(sec->fw_name);
> +			return PTR_ERR(fwl);
> +		}
> +
> +		sec->fwl = fwl;
> +		return 0;
> +	}
> +
> +	static int m10bmc_sec_remove(struct platform_device *pdev)
> +	{
> +		struct m10bmc_sec *sec = dev_get_drvdata(&pdev->dev);
> +
> +		fw_upload_unregister(sec->fwl);
> +		kfree(sec->fw_name);
> +		return 0;
> +	}
> +
> +fw_upload_register
> +------------------
> +.. kernel-doc:: drivers/base/firmware_loader/fw_upload.c
> +   :functions: fw_upload_register
> +
> +fw_upload_unregister
> +--------------------
> +.. kernel-doc:: drivers/base/firmware_loader/fw_upload.c
> +   :functions: fw_upload_unregister
> diff --git a/Documentation/driver-api/firmware/index.rst b/Documentation/driver-api/firmware/index.rst
> index 57415d657173..9d2c19dc8e36 100644
> --- a/Documentation/driver-api/firmware/index.rst
> +++ b/Documentation/driver-api/firmware/index.rst
> @@ -8,6 +8,7 @@ Linux Firmware API
>     core
>     efi/index
>     request_firmware
> +   fw_upload
>     other_interfaces
>  
>  .. only::  subproject and html
> diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
> index 1bfe18900ed5..cee662f3277b 100644
> --- a/drivers/base/firmware_loader/Kconfig
> +++ b/drivers/base/firmware_loader/Kconfig
> @@ -185,5 +185,19 @@ config FW_CACHE
>  
>  	  If unsure, say Y.
>  
> +config FW_UPLOAD
> +	bool "Enable users to initiate firmware updates using sysfs"
> +	select FW_LOADER_SYSFS
> +	select FW_LOADER_PAGED_BUF
> +	help
> +	  Enabling this option will allow device drivers to expose a persistent
> +	  sysfs interface that allows firmware updates to be initiated from
> +	  userspace. For example, FPGA based PCIe cards load firmware and FPGA
> +	  images from local FLASH when the card boots. The images in FLASH may
> +	  be updated with new images provided by the user. Enable this device
> +	  to support cards that rely on user-initiated updates for firmware files.
> +
> +	  If unsure, say N.
> +
>  endif # FW_LOADER
>  endmenu
> diff --git a/drivers/base/firmware_loader/Makefile b/drivers/base/firmware_loader/Makefile
> index 787c833d0c6e..52ef64bd9357 100644
> --- a/drivers/base/firmware_loader/Makefile
> +++ b/drivers/base/firmware_loader/Makefile
> @@ -7,5 +7,6 @@ firmware_class-objs := main.o
>  firmware_class-$(CONFIG_FW_LOADER_USER_HELPER) += fallback.o
>  firmware_class-$(CONFIG_EFI_EMBEDDED_FIRMWARE) += fallback_platform.o
>  firmware_class-$(CONFIG_FW_LOADER_SYSFS) += fw_sysfs.o
> +firmware_class-$(CONFIG_FW_UPLOAD) += fw_upload.o
>  
>  obj-y += builtin/
> diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
> index 58768d16f8df..4019f9423de8 100644
> --- a/drivers/base/firmware_loader/firmware.h
> +++ b/drivers/base/firmware_loader/firmware.h
> @@ -87,6 +87,7 @@ struct fw_priv {
>  };
>  
>  extern struct mutex fw_lock;
> +extern struct firmware_cache fw_cache;
>  
>  static inline bool __fw_state_check(struct fw_priv *fw_priv,
>  				    enum fw_status status)
> @@ -154,7 +155,12 @@ static inline bool fw_state_is_done(struct fw_priv *fw_priv)
>  	return __fw_state_check(fw_priv, FW_STATUS_DONE);
>  }
>  
> +int alloc_lookup_fw_priv(const char *fw_name, struct firmware_cache *fwc,
> +			 struct fw_priv **fw_priv, void *dbuf, size_t size,
> +			 size_t offset, u32 opt_flags);
>  int assign_fw(struct firmware *fw, struct device *device);
> +void free_fw_priv(struct fw_priv *fw_priv);
> +void fw_state_init(struct fw_priv *fw_priv);
>  
>  #ifdef CONFIG_FW_LOADER
>  bool firmware_is_builtin(const struct firmware *fw);
> diff --git a/drivers/base/firmware_loader/fw_sysfs.c b/drivers/base/firmware_loader/fw_sysfs.c
> index 70cb1d67ffb2..9b0cd37c81df 100644
> --- a/drivers/base/firmware_loader/fw_sysfs.c
> +++ b/drivers/base/firmware_loader/fw_sysfs.c
> @@ -6,8 +6,8 @@
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  
> -#include "firmware.h"
>  #include "fw_sysfs.h"
> +#include "fw_upload.h"
>  
>  /*
>   * sysfs support for firmware loader
> @@ -80,6 +80,10 @@ static void fw_dev_release(struct device *dev)
>  {
>  	struct fw_sysfs *fw_sysfs = to_fw_sysfs(dev);
>  
> +	if (fw_sysfs->fw_upload_priv) {
> +		free_fw_priv(fw_sysfs->fw_priv);
> +		kfree(fw_sysfs->fw_upload_priv);
> +	}
>  	kfree(fw_sysfs);
>  }
>  
> @@ -165,6 +169,9 @@ static ssize_t firmware_loading_store(struct device *dev,
>  				      const char *buf, size_t count)
>  {
>  	struct fw_sysfs *fw_sysfs = to_fw_sysfs(dev);
> +#ifdef CONFIG_FW_UPLOAD
> +	struct fw_upload_priv *fwlp;
> +#endif
>  	struct fw_priv *fw_priv;
>  	ssize_t written = count;
>  	int loading = simple_strtol(buf, NULL, 10);
> @@ -211,6 +218,42 @@ static ssize_t firmware_loading_store(struct device *dev,
>  				written = rc;
>  			} else {
>  				fw_state_done(fw_priv);
> +
> +#ifdef CONFIG_FW_UPLOAD
> +				/*
> +				 * For fw_uploads, start a worker thread to upload
> +				 * data to the parent driver.
> +				 */
> +				if (!fw_sysfs->fw_upload_priv)
> +					break;
> +
> +				if (!fw_priv->size) {
> +					fw_free_paged_buf(fw_priv);
> +					fw_state_init(fw_sysfs->fw_priv);
> +					break;
> +				}
> +
> +				fwlp = fw_sysfs->fw_upload_priv;
> +				mutex_lock(&fwlp->lock);
> +
> +				/* Do not interfere an on-going fw_upload */
> +				if (fwlp->progress != FW_UPLOAD_PROG_IDLE) {
> +					mutex_unlock(&fwlp->lock);
> +					written = -EBUSY;
> +					goto out;
> +				}
> +
> +				fwlp->progress = FW_UPLOAD_PROG_RECEIVING;
> +				fwlp->err_code = 0;
> +				fwlp->remaining_size = fw_priv->size;
> +				fwlp->data = fw_priv->data;
> +				pr_debug("%s: fw-%s fw_priv=%p data=%p size=%u\n",
> +					 __func__, fw_priv->fw_name,
> +					 fw_priv, fw_priv->data,
> +					 (unsigned int)fw_priv->size);
> +				queue_work(system_long_wq, &fwlp->work);
> +				mutex_unlock(&fwlp->lock);
> +#endif

If you're going to split this work up it'd be nice to avoid to have
#ifdef stuff here.

> diff --git a/drivers/base/firmware_loader/fw_upload.c b/drivers/base/firmware_loader/fw_upload.c

No need for fw prefix, sysfs-upload.[ch] would make it clearer.

> +EXPORT_SYMBOL_GPL(fw_upload_register);

firmware_upload_register()

> +EXPORT_SYMBOL_GPL(fw_upload_unregister);

firmware_upload_unregister()

> diff --git a/include/linux/firmware.h b/include/linux/firmware.h
> index 3b057dfc8284..9b109f8ff627 100644
> --- a/include/linux/firmware.h
> +++ b/include/linux/firmware.h
> @@ -17,6 +17,56 @@ struct firmware {
>  	void *priv;
>  };
>  


> +/* Update progress codes */
> +#define FW_UPLOAD_PROG_IDLE		0
> +#define FW_UPLOAD_PROG_RECEIVING	1
> +#define FW_UPLOAD_PROG_PREPARING	2
> +#define FW_UPLOAD_PROG_TRANSFERRING	3
> +#define FW_UPLOAD_PROG_PROGRAMMING	4
> +#define FW_UPLOAD_PROG_MAX		5

enums with kdoc allows you to nicely document these as well.
> +
> +/* Update error progress codes */
> +#define FW_UPLOAD_ERR_HW_ERROR		1
> +#define FW_UPLOAD_ERR_TIMEOUT		2
> +#define FW_UPLOAD_ERR_CANCELED		3
> +#define FW_UPLOAD_ERR_BUSY		4
> +#define FW_UPLOAD_ERR_INVALID_SIZE	5
> +#define FW_UPLOAD_ERR_RW_ERROR		6
> +#define FW_UPLOAD_ERR_WEAROUT		7
> +#define FW_UPLOAD_ERR_MAX		8

enums with kdoc allows you to nicely document these as well.

  Luis
