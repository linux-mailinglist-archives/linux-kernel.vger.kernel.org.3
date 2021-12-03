Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B09467E5C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 20:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382958AbhLCTlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 14:41:25 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:42610 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382932AbhLCTlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 14:41:22 -0500
Received: by mail-ot1-f48.google.com with SMTP id 47-20020a9d0332000000b005798ac20d72so4636451otv.9;
        Fri, 03 Dec 2021 11:37:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6g7Il1yFxf31HmDcELmRGabuWqVw62wzv3TjKOuCiFg=;
        b=pF9XcUWpXLv/qLTlGbmI4wl+XrEf7uuvegQSRFHjcFZvnmzIOvcAd56aGSECEVPdlt
         LVa98BxPpr74ASCe5YZ/en8VwbhhnjbbNTblJWRS4FzgIs5jB+OSX0NPTWyETzW23M96
         UCIqOMA+nczUrDQIVfALKnSjmhA07odzmfFlIplVD5OxjKbUevxCN+5Ab/5H/pgmfnM+
         Tb6b4KdEBIk1J9zKjoZde5EyUi5/Oq6zM+AI4UnPZYhPcSsRIDrpNja17tpAGQikGRKQ
         935ZtDJPde6vcU6ky+8S7LklIQ3q4I7l+YVd2KOTNUG4w+vQG5jrw19pxphT0m+w3h6Q
         9svg==
X-Gm-Message-State: AOAM533Li+S1To4r6Di31vmNyK5CtWDLYQk7ugAKhko3UVwkmBuxFZZQ
        iiVZUhwnEA387GeMKZgeJ/2AfosaCHNx5fRo2HM=
X-Google-Smtp-Source: ABdhPJzskFjRGtCrUZ/I7Ngpz9rPS9oF6VMNt78IvOg6xgu+S17Nc7At2TVG8R5IR9xv0WXevkgl7ygAY5heVAzHfSg=
X-Received: by 2002:a9d:4c10:: with SMTP id l16mr17932646otf.198.1638560276039;
 Fri, 03 Dec 2021 11:37:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637505679.git.yu.c.chen@intel.com> <a52dc1716e7cb0362d415f123ff3e24975e8fb1f.1637505679.git.yu.c.chen@intel.com>
In-Reply-To: <a52dc1716e7cb0362d415f123ff3e24975e8fb1f.1637505679.git.yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 3 Dec 2021 20:37:44 +0100
Message-ID: <CAJZ5v0iHFDMckjD4fqF-PR3HKCbjqmDWK9BqMkA5XimyojZjdw@mail.gmail.com>
Subject: Re: [PATCH v11 2/4] drivers/acpi: Introduce Platform Firmware Runtime
 Update device driver
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2021 at 4:17 PM Chen Yu <yu.c.chen@intel.com> wrote:
>
> Introduce the pfru_update driver which can be used for Platform Firmware
> Runtime code injection and driver update [1].

The PFRU TLA already covers the "update" part. so the naming is a bit unclean.

IMO any of pfrut_update, or pfr_update, or even pfru alone would be better.

My favorite is pfr_update, and the telemetry part can be called
pfr_telementry for symmetry.

> The user is expected to
> provide the update firmware in the form of capsule file, and pass it to

This is an EFI capsule and not necessarily in a separate file, so why
don't you just say "EFI capsule"?

> the driver via ioctl.

It is actually passed by writing the capsule to a device special file, isn't it?

The ioctl() interface is necessary for setup/cleanup.

> Then the driver would hand this capsule file to the
> Platform Firmware Runtime Update via the ACPI device _DSM method. At last

"The capsule is transferred by the driver to the platform firmware
with the help of an ACPI _DSM method under the special ACPI Platform
Firmware Runtime Update device (INTC1080)"

> the low level Management Mode would do the firmware update.

"and the actual firmware update is carried out by the low-level
Management Mode code in the platform firmware."

> The corresponding userspace tool and man page will be introduced at
> tools/power/acpi/tools/pfru.

The above is irrelevant for this particular patch IMO.

What is relevant, and missing, is a bit of justification, like why it
is a good idea to add this driver to the kernel.  There are some
pieces of it in the Kconfig help text and elsewhere, but it should be
there in the patch changelog too.

> Link: https://uefi.org/sites/default/files/resources/Intel_MM_OS_Interface_Spec_Rev100.pdf # [1]
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---

[cut the history]

> ---
>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>  drivers/acpi/Kconfig                          |   1 +
>  drivers/acpi/Makefile                         |   1 +
>  drivers/acpi/pfru/Kconfig                     |  13 +
>  drivers/acpi/pfru/Makefile                    |   2 +
>  drivers/acpi/pfru/pfru_update.c               | 601 ++++++++++++++++++
>  include/uapi/linux/pfru.h                     | 174 +++++
>  7 files changed, 793 insertions(+)
>  create mode 100644 drivers/acpi/pfru/Kconfig
>  create mode 100644 drivers/acpi/pfru/Makefile
>  create mode 100644 drivers/acpi/pfru/pfru_update.c
>  create mode 100644 include/uapi/linux/pfru.h
>
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index cfe6cccf0f44..adf830410e0d 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -367,6 +367,7 @@ Code  Seq#    Include File                                           Comments
>                                                                       <mailto:aherrman@de.ibm.com>
>  0xE5  00-3F  linux/fuse.h
>  0xEC  00-01  drivers/platform/chrome/cros_ec_dev.h                   ChromeOS EC driver
> +0xEE  00-09  uapi/linux/pfru.h                                       Platform Firmware Runtime Update and Telemetry

If this is called pfrut.h, it would be more consistent with the description.

>  0xF3  00-3F  drivers/usb/misc/sisusbvga/sisusb.h                     sisfb (in development)
>                                                                       <mailto:thomas@winischhofer.net>
>  0xF6  all                                                            LTTng Linux Trace Toolkit Next Generation
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index cdbdf68bd98f..1cf26e404b63 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -482,6 +482,7 @@ source "drivers/acpi/nfit/Kconfig"
>  source "drivers/acpi/numa/Kconfig"
>  source "drivers/acpi/apei/Kconfig"
>  source "drivers/acpi/dptf/Kconfig"
> +source "drivers/acpi/pfru/Kconfig"
>
>  config ACPI_WATCHDOG
>         bool
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 3018714e87d9..9c2c5ddff6ec 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -102,6 +102,7 @@ obj-$(CONFIG_ACPI_CPPC_LIB) += cppc_acpi.o
>  obj-$(CONFIG_ACPI_SPCR_TABLE)  += spcr.o
>  obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
>  obj-$(CONFIG_ACPI_PPTT)        += pptt.o
> +obj-$(CONFIG_ACPI_PFRU)                += pfru/
>
>  # processor has its own "processor." module_param namespace
>  processor-y                    := processor_driver.o
> diff --git a/drivers/acpi/pfru/Kconfig b/drivers/acpi/pfru/Kconfig
> new file mode 100644
> index 000000000000..fd0a41b88fac
> --- /dev/null
> +++ b/drivers/acpi/pfru/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0
> +config ACPI_PFRU

The telemetry will depend on the same config option, so I would call
it ACPI_PFRUT.

> +       tristate "ACPI Platform Firmware Runtime Update (PFRU)"

And I would simply say "ACPI Platform Firmware Runtime Update and
Telemetry" here.

> +       depends on 64BIT
> +       help
> +         In order to reduce the system reboot times and update the platform firmware
> +         in time, Platform Firmware Runtime Update is leveraged to patch the system
> +         without reboot. This driver supports Platform Firmware Runtime Update,
> +         which is composed of two parts: code injection and driver update. It also
> +         allows telemetry data to be retrieved from the platform firmware.

The above needs to be edited.  What about using something like this instead:

"This mechanism allows certain pieces of the platform firmware to be
updated on the fly while the system is running (runtime) without the
need to restart it, which is key in the cases when the system needs to
be available 100% of the time and it cannot afford the downtime
related to restarting it, or when the work carried out by the system
is particularly important, so it cannot be interrupted, and it is not
practical to wait until it is complete.

The existing firmware code can be modified (driver update) or extended
by adding new code to the firmware (code injection)."

The telemetry part will be added separately later, so it need not be
mentioned here just yet.

> +
> +         To compile this driver as module, choose M here:
> +         the modules will be called pfru_update and pfru_telemetry.
> diff --git a/drivers/acpi/pfru/Makefile b/drivers/acpi/pfru/Makefile
> new file mode 100644
> index 000000000000..098cbe80cf3d
> --- /dev/null
> +++ b/drivers/acpi/pfru/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_ACPI_PFRU) += pfru_update.o
> diff --git a/drivers/acpi/pfru/pfru_update.c b/drivers/acpi/pfru/pfru_update.c
> new file mode 100644
> index 000000000000..cf670d052cc9
> --- /dev/null
> +++ b/drivers/acpi/pfru/pfru_update.c

So why don't you call this file pfr_update.c?

> @@ -0,0 +1,601 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ACPI Platform Firmware Runtime Update Device Driver
> + *
> + * Copyright (C) 2021 Intel Corporation
> + * Author: Chen Yu <yu.c.chen@intel.com>

Please describe what the driver is for here at least briefly.

> + */
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/efi.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <linux/idr.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/string.h>
> +#include <linux/uaccess.h>
> +#include <linux/uio.h>
> +#include <linux/uuid.h>
> +
> +#include <uapi/linux/pfru.h>
> +
> +#define PFRU_FUNC_STANDARD_QUERY       0
> +#define PFRU_FUNC_QUERY_UPDATE_CAP     1
> +#define PFRU_FUNC_QUERY_BUF            2
> +#define PFRU_FUNC_START                3
> +
> +#define PFRU_CODE_INJECT_TYPE  1
> +#define PFRU_DRIVER_UPDATE_TYPE        2
> +
> +#define PFRU_REVID_1           1
> +#define PFRU_REVID_2           2
> +#define PFRU_DEFAULT_REV_ID    PFRU_REVID_1
> +
> +enum cap_index {
> +       CAP_STATUS_IDX = 0,
> +       CAP_UPDATE_IDX = 1,
> +       CAP_CODE_TYPE_IDX = 2,
> +       CAP_FW_VER_IDX = 3,
> +       CAP_CODE_RT_VER_IDX = 4,
> +       CAP_DRV_TYPE_IDX = 5,
> +       CAP_DRV_RT_VER_IDX = 6,
> +       CAP_DRV_SVN_IDX = 7,
> +       CAP_PLAT_ID_IDX = 8,
> +       CAP_OEM_ID_IDX = 9,
> +       CAP_OEM_INFO_IDX = 10,
> +       CAP_NR_IDX
> +};
> +
> +enum buf_index {
> +       BUF_STATUS_IDX = 0,
> +       BUF_EXT_STATUS_IDX = 1,
> +       BUF_ADDR_LOW_IDX = 2,
> +       BUF_ADDR_HI_IDX = 3,
> +       BUF_SIZE_IDX = 4,
> +       BUF_NR_IDX
> +};
> +
> +enum update_index {
> +       UPDATE_STATUS_IDX = 0,
> +       UPDATE_EXT_STATUS_IDX = 1,
> +       UPDATE_AUTH_TIME_LOW_IDX = 2,
> +       UPDATE_AUTH_TIME_HI_IDX = 3,
> +       UPDATE_EXEC_TIME_LOW_IDX = 4,
> +       UPDATE_EXEC_TIME_HI_IDX = 5,
> +       UPDATE_NR_IDX
> +};
> +
> +enum pfru_start_action {

The pfru prefix here (and below) is OK.

> +       START_STAGE = 0,
> +       START_ACTIVATE = 1,
> +       START_STAGE_ACTIVATE = 2,
> +};
> +
> +struct pfru_device {
> +       u32 rev_id, index;
> +       struct device *parent_dev;
> +       struct miscdevice miscdev;
> +};
> +
> +static DEFINE_IDA(pfru_ida);
> +
> +static const guid_t pfru_guid =
> +       GUID_INIT(0xECF9533B, 0x4A3C, 0x4E89, 0x93, 0x9E, 0xC7, 0x71,
> +                 0x12, 0x60, 0x1C, 0x6D);
> +
> +static const guid_t pfru_code_inj_guid =
> +       GUID_INIT(0xB2F84B79, 0x7B6E, 0x4E45, 0x88, 0x5F, 0x3F, 0xB9,
> +                 0xBB, 0x18, 0x54, 0x02);
> +
> +static const guid_t pfru_drv_update_guid =
> +       GUID_INIT(0x4569DD8C, 0x75F1, 0x429A, 0xA3, 0xD6, 0x24, 0xDE,
> +                 0x80, 0x97, 0xA0, 0xDF);

The above are _DSM UUIDs, right?

If so, please add a comment pointing to their definitions and
explaining briefly what they are for.

> +
> +static inline int pfru_valid_revid(u32 id)
> +{
> +       return id == PFRU_REVID_1 || id == PFRU_REVID_2;
> +}
> +
> +static inline struct pfru_device *to_pfru_dev(struct file *file)
> +{
> +       return container_of(file->private_data, struct pfru_device, miscdev);
> +}
> +
> +static int query_capability(struct pfru_update_cap_info *cap_hdr,
> +                           struct pfru_device *pfru_dev)
> +{
> +       acpi_handle handle = ACPI_HANDLE(pfru_dev->parent_dev);
> +       union acpi_object *out_obj;
> +       int ret = -EINVAL;
> +
> +       out_obj = acpi_evaluate_dsm_typed(handle, &pfru_guid,
> +                                         pfru_dev->rev_id,
> +                                         PFRU_FUNC_QUERY_UPDATE_CAP,
> +                                         NULL, ACPI_TYPE_PACKAGE);
> +       if (!out_obj)
> +               return ret;
> +
> +       if (out_obj->package.count < CAP_NR_IDX)
> +               goto free_acpi_buffer;
> +
> +       if (out_obj->package.elements[CAP_STATUS_IDX].type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +
> +       cap_hdr->status = out_obj->package.elements[CAP_STATUS_IDX].integer.value;
> +
> +       if (out_obj->package.elements[CAP_UPDATE_IDX].type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +
> +       cap_hdr->update_cap = out_obj->package.elements[CAP_UPDATE_IDX].integer.value;
> +
> +       if (out_obj->package.elements[CAP_CODE_TYPE_IDX].type != ACPI_TYPE_BUFFER)
> +               goto free_acpi_buffer;
> +
> +       memcpy(&cap_hdr->code_type,
> +              out_obj->package.elements[CAP_CODE_TYPE_IDX].buffer.pointer,
> +              out_obj->package.elements[CAP_CODE_TYPE_IDX].buffer.length);
> +
> +       if (out_obj->package.elements[CAP_FW_VER_IDX].type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +
> +       cap_hdr->fw_version =
> +               out_obj->package.elements[CAP_FW_VER_IDX].integer.value;
> +
> +       if (out_obj->package.elements[CAP_CODE_RT_VER_IDX].type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +
> +       cap_hdr->code_rt_version =
> +               out_obj->package.elements[CAP_CODE_RT_VER_IDX].integer.value;
> +
> +       if (out_obj->package.elements[CAP_DRV_TYPE_IDX].type != ACPI_TYPE_BUFFER)
> +               goto free_acpi_buffer;
> +
> +       memcpy(&cap_hdr->drv_type,
> +              out_obj->package.elements[CAP_DRV_TYPE_IDX].buffer.pointer,
> +              out_obj->package.elements[CAP_DRV_TYPE_IDX].buffer.length);
> +
> +       if (out_obj->package.elements[CAP_DRV_RT_VER_IDX].type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +
> +       cap_hdr->drv_rt_version =
> +               out_obj->package.elements[CAP_DRV_RT_VER_IDX].integer.value;
> +
> +       if (out_obj->package.elements[CAP_DRV_SVN_IDX].type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +
> +       cap_hdr->drv_svn =
> +               out_obj->package.elements[CAP_DRV_SVN_IDX].integer.value;
> +
> +       if (out_obj->package.elements[CAP_PLAT_ID_IDX].type != ACPI_TYPE_BUFFER)
> +               goto free_acpi_buffer;
> +
> +       memcpy(&cap_hdr->platform_id,
> +              out_obj->package.elements[CAP_PLAT_ID_IDX].buffer.pointer,
> +              out_obj->package.elements[CAP_PLAT_ID_IDX].buffer.length);
> +
> +       if (out_obj->package.elements[CAP_OEM_ID_IDX].type != ACPI_TYPE_BUFFER)
> +               goto free_acpi_buffer;
> +
> +       memcpy(&cap_hdr->oem_id,
> +              out_obj->package.elements[CAP_OEM_ID_IDX].buffer.pointer,
> +              out_obj->package.elements[CAP_OEM_ID_IDX].buffer.length);
> +
> +       if (out_obj->package.elements[CAP_OEM_INFO_IDX].type != ACPI_TYPE_BUFFER)
> +               goto free_acpi_buffer;
> +
> +       cap_hdr->oem_info_len =
> +               out_obj->package.elements[CAP_OEM_INFO_IDX].buffer.length;
> +
> +       ret = 0;

The number of goto statements and possibly redundant memory updates
can be reduced by doing all of the checks upfront (possibly in one big
if () statement even).  And there would be fewer LOC then.

> +
> +free_acpi_buffer:
> +       kfree(out_obj);
> +
> +       return ret;
> +}
> +
> +static int query_buffer(struct pfru_com_buf_info *info,
> +                       struct pfru_device *pfru_dev)
> +{
> +       acpi_handle handle = ACPI_HANDLE(pfru_dev->parent_dev);
> +       union acpi_object *out_obj;
> +       int ret = -EINVAL;
> +
> +       out_obj = acpi_evaluate_dsm_typed(handle, &pfru_guid,
> +                                         pfru_dev->rev_id, PFRU_FUNC_QUERY_BUF,
> +                                         NULL, ACPI_TYPE_PACKAGE);
> +       if (!out_obj)
> +               return ret;
> +
> +       if (out_obj->package.count < BUF_NR_IDX)
> +               goto free_acpi_buffer;
> +
> +       if (out_obj->package.elements[BUF_STATUS_IDX].type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +
> +       info->status = out_obj->package.elements[BUF_STATUS_IDX].integer.value;
> +
> +       if (out_obj->package.elements[BUF_EXT_STATUS_IDX].type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +
> +       info->ext_status =
> +               out_obj->package.elements[BUF_EXT_STATUS_IDX].integer.value;
> +
> +       if (out_obj->package.elements[BUF_ADDR_LOW_IDX].type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +
> +       info->addr_lo =
> +               out_obj->package.elements[BUF_ADDR_LOW_IDX].integer.value;
> +
> +       if (out_obj->package.elements[BUF_ADDR_HI_IDX].type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +
> +       info->addr_hi =
> +               out_obj->package.elements[BUF_ADDR_HI_IDX].integer.value;
> +
> +       if (out_obj->package.elements[BUF_SIZE_IDX].type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +
> +       info->buf_size = out_obj->package.elements[BUF_SIZE_IDX].integer.value;

The same comment applies to this function.

> +
> +       ret = 0;
> +
> +free_acpi_buffer:
> +       kfree(out_obj);
> +
> +       return ret;
> +}
> +
> +static int get_image_type(const struct efi_manage_capsule_image_header *img_hdr,
> +                         struct pfru_device *pfru_dev)
> +{
> +       const efi_guid_t *image_type_id = &img_hdr->image_type_id;
> +
> +       /* check whether this is a code injection or driver update */
> +       if (guid_equal(image_type_id, &pfru_code_inj_guid))
> +               return PFRU_CODE_INJECT_TYPE;
> +
> +       if (guid_equal(image_type_id, &pfru_drv_update_guid))
> +               return PFRU_DRIVER_UPDATE_TYPE;
> +
> +       return -EINVAL;
> +}
> +
> +static int adjust_efi_size(const struct efi_manage_capsule_image_header *img_hdr,
> +                          int size)
> +{
> +       /*
> +        * The (u64 hw_ins) was introduced in UEFI spec version 2,
> +        * and (u64 capsule_support) was introduced in version 3.
> +        * The size needs to be adjusted accordingly. That is to
> +        * say, version 1 should subtract the size of hw_ins+capsule_support,
> +        * and version 2 should sbstract the size of capsule_support.
> +        */
> +       size += sizeof(struct efi_manage_capsule_image_header);
> +       switch (img_hdr->ver) {
> +       case 1:
> +               return size - 2 * sizeof(u64);
> +       case 2:
> +               return size - sizeof(u64);
> +       default:
> +               /* only support version 1 and 2 */
> +               return -EINVAL;
> +       }
> +}
> +
> +static bool valid_version(const void *data, struct pfru_update_cap_info *cap,
> +                         struct pfru_device *pfru_dev)
> +{
> +       struct pfru_payload_hdr *payload_hdr;
> +       const efi_capsule_header_t *cap_hdr = data;
> +       const struct efi_manage_capsule_header *m_hdr;
> +       const struct efi_manage_capsule_image_header *m_img_hdr;
> +       const struct efi_image_auth *auth;
> +       int type, size;
> +
> +       /*
> +        * Sanity check if the capsule image has a newer version
> +        * than current one. In this way, if the user provides an
> +        * invalid capsule image, the kernel could be used as a
> +        * guard to reject it, without switching to the MM update mode.
> +        * (which might be costly)

So this really isn't "valid", but "applicable", so I would call the
function applicable_image().

And I would use a different comment text, like the following:

"If the code in the capsule is older than the current firmware code,
the update will be rejected by the firmware, so check the version of
it upfront without engaging the Management Mode update mechanism which
may be costly."

> +        */
> +       size = cap_hdr->headersize;
> +       m_hdr = data + size;
> +       /*
> +        * Current data structure size plus variable array indicated
> +        * by number of (emb_drv_cnt + payload_cnt)
> +        */
> +       size += offsetof(struct efi_manage_capsule_header, offset_list) +
> +               (m_hdr->emb_drv_cnt + m_hdr->payload_cnt) * sizeof(u64);
> +       m_img_hdr = data + size;
> +
> +       type = get_image_type(m_img_hdr, pfru_dev);
> +       if (type < 0)
> +               return false;
> +
> +       size = adjust_efi_size(m_img_hdr, size);
> +       if (size < 0)
> +               return false;
> +
> +       auth = data + size;
> +       size += sizeof(u64) + auth->auth_info.hdr.len;
> +       payload_hdr = (struct pfru_payload_hdr *)(data + size);
> +
> +       /* finally compare the version */
> +       if (type == PFRU_CODE_INJECT_TYPE)
> +               return payload_hdr->rt_ver >= cap->code_rt_version;
> +       else

Redundant else.

> +               return payload_hdr->rt_ver >= cap->drv_rt_version;
> +}
> +
> +static void dump_update_result(struct pfru_updated_result *result,
> +                              struct pfru_device *pfru_dev)

What about calling this print_ipdate_debug_info()?

> +{
> +       dev_dbg(pfru_dev->parent_dev, "Update result:\n");
> +       dev_dbg(pfru_dev->parent_dev, "Status:%d\n", result->status);
> +       dev_dbg(pfru_dev->parent_dev, "Extended Status:%d\n", result->ext_status);
> +       dev_dbg(pfru_dev->parent_dev, "Authentication Time Low:%lld\n",
> +               result->low_auth_time);
> +       dev_dbg(pfru_dev->parent_dev, "Authentication Time High:%lld\n",
> +               result->high_auth_time);
> +       dev_dbg(pfru_dev->parent_dev, "Execution Time Low:%lld\n",
> +               result->low_exec_time);
> +       dev_dbg(pfru_dev->parent_dev, "Execution Time High:%lld\n",
> +               result->high_exec_time);
> +}
> +
> +static int start_acpi_update(int action, struct pfru_device *pfru_dev)

Why not just start_update()?

> +{
> +       union acpi_object *out_obj, in_obj, in_buf;
> +       struct pfru_updated_result update_result;
> +       acpi_handle handle;
> +       int ret = -EINVAL;
> +
> +       memset(&in_obj, 0, sizeof(in_obj));
> +       memset(&in_buf, 0, sizeof(in_buf));
> +       in_obj.type = ACPI_TYPE_PACKAGE;
> +       in_obj.package.count = 1;
> +       in_obj.package.elements = &in_buf;
> +       in_buf.type = ACPI_TYPE_INTEGER;
> +       in_buf.integer.value = action;
> +
> +       handle = ACPI_HANDLE(pfru_dev->parent_dev);
> +       out_obj = acpi_evaluate_dsm_typed(handle, &pfru_guid,
> +                                         pfru_dev->rev_id, PFRU_FUNC_START,
> +                                         &in_obj, ACPI_TYPE_PACKAGE);
> +       if (!out_obj)
> +               return ret;
> +
> +       if (out_obj->package.count < UPDATE_NR_IDX)
> +               goto free_acpi_buffer;
> +
> +       if (out_obj->package.elements[UPDATE_STATUS_IDX].type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +
> +       update_result.status =
> +               out_obj->package.elements[UPDATE_STATUS_IDX].integer.value;
> +
> +       if (out_obj->package.elements[UPDATE_EXT_STATUS_IDX].type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +
> +       update_result.ext_status =
> +               out_obj->package.elements[UPDATE_EXT_STATUS_IDX].integer.value;
> +
> +       if (out_obj->package.elements[UPDATE_AUTH_TIME_LOW_IDX].type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +
> +       update_result.low_auth_time =
> +               out_obj->package.elements[UPDATE_AUTH_TIME_LOW_IDX].integer.value;
> +
> +       if (out_obj->package.elements[UPDATE_AUTH_TIME_HI_IDX].type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +
> +       update_result.high_auth_time =
> +               out_obj->package.elements[UPDATE_AUTH_TIME_HI_IDX].integer.value;
> +
> +       if (out_obj->package.elements[UPDATE_EXEC_TIME_LOW_IDX].type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +
> +       update_result.low_exec_time =
> +               out_obj->package.elements[UPDATE_EXEC_TIME_LOW_IDX].integer.value;
> +
> +       if (out_obj->package.elements[UPDATE_EXEC_TIME_HI_IDX].type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +
> +       update_result.high_exec_time =
> +               out_obj->package.elements[UPDATE_EXEC_TIME_HI_IDX].integer.value;

Again, checks can be combined to reduce the number of goto statements etc.

> +
> +       dump_update_result(&update_result, pfru_dev);
> +       ret = 0;
> +
> +free_acpi_buffer:
> +       kfree(out_obj);
> +
> +       return ret;
> +}
> +
> +static long pfru_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +       struct pfru_update_cap_info cap_hdr;
> +       struct pfru_device *pfru_dev = to_pfru_dev(file);
> +       void __user *p = (void __user *)arg;
> +       u32 rev;
> +       int ret;
> +
> +       switch (cmd) {
> +       case PFRU_IOC_QUERY_CAP:
> +               ret = query_capability(&cap_hdr, pfru_dev);
> +               if (ret)
> +                       return ret;
> +
> +               if (copy_to_user(p, &cap_hdr, sizeof(cap_hdr)))
> +                       return -EFAULT;
> +
> +               return 0;

I would add a blank line before each "case xxx:" line to visually
separate the cases from each other.

> +       case PFRU_IOC_SET_REV:
> +               if (copy_from_user(&rev, p, sizeof(rev)))
> +                       return -EFAULT;
> +
> +               if (!pfru_valid_revid(rev))
> +                       return -EINVAL;
> +
> +               pfru_dev->rev_id = rev;
> +
> +               return 0;
> +       case PFRU_IOC_STAGE:
> +               return start_acpi_update(START_STAGE, pfru_dev);
> +       case PFRU_IOC_ACTIVATE:
> +               return start_acpi_update(START_ACTIVATE, pfru_dev);
> +       case PFRU_IOC_STAGE_ACTIVATE:
> +               return start_acpi_update(START_STAGE_ACTIVATE, pfru_dev);
> +       default:
> +               return -ENOTTY;
> +       }
> +}
> +
> +static ssize_t pfru_write(struct file *file, const char __user *buf,
> +                         size_t len, loff_t *ppos)
> +{
> +       struct pfru_device *pfru_dev = to_pfru_dev(file);
> +       struct pfru_update_cap_info cap;
> +       struct pfru_com_buf_info buf_info;
> +       phys_addr_t phy_addr;
> +       struct iov_iter iter;
> +       struct iovec iov;
> +       char *buf_ptr;
> +       int ret;
> +
> +       ret = query_buffer(&buf_info, pfru_dev);
> +       if (ret)
> +               return ret;
> +
> +       if (len > buf_info.buf_size)
> +               return -EINVAL;
> +
> +       iov.iov_base = (void __user *)buf;
> +       iov.iov_len = len;
> +       iov_iter_init(&iter, WRITE, &iov, 1, len);
> +
> +       /* map the communication buffer */
> +       phy_addr = (phys_addr_t)((buf_info.addr_hi << 32) | buf_info.addr_lo);
> +       buf_ptr = memremap(phy_addr, buf_info.buf_size, MEMREMAP_WB);
> +       if (IS_ERR(buf_ptr))
> +               return PTR_ERR(buf_ptr);
> +
> +       if (!copy_from_iter_full(buf_ptr, len, &iter)) {
> +               ret = -EINVAL;
> +               goto unmap;
> +       }
> +
> +       /* check if the capsule header has a valid version number */
> +       ret = query_capability(&cap, pfru_dev);
> +       if (ret)
> +               goto unmap;
> +
> +       if (cap.status != DSM_SUCCEED)
> +               ret = -EBUSY;

Can this check be made by query_capability() and -EBUSY returned by it
if the check triggers?

> +       else if (!valid_version(buf_ptr, &cap, pfru_dev))
> +               ret = -EINVAL;
> +
> +unmap:
> +       memunmap(buf_ptr);
> +
> +       return ret ?: len;
> +}
> +
> +static const struct file_operations acpi_pfru_fops = {
> +       .owner          = THIS_MODULE,
> +       .write          = pfru_write,
> +       .unlocked_ioctl = pfru_ioctl,
> +       .llseek         = noop_llseek,
> +};
> +
> +static int acpi_pfru_remove(struct platform_device *pdev)
> +{
> +       struct pfru_device *pfru_dev = platform_get_drvdata(pdev);
> +
> +       misc_deregister(&pfru_dev->miscdev);
> +
> +       return 0;
> +}
> +
> +static void pfru_put_idx(void *data)
> +{
> +       struct pfru_device *pfru_dev = data;
> +
> +       ida_free(&pfru_ida, pfru_dev->index);
> +}
> +
> +static int acpi_pfru_probe(struct platform_device *pdev)
> +{
> +       acpi_handle handle = ACPI_HANDLE(&pdev->dev);
> +       struct pfru_device *pfru_dev;
> +       int ret;
> +
> +       if (!acpi_has_method(handle, "_DSM")) {
> +               dev_dbg(&pdev->dev, "Missing _DSM\n");
> +               return -ENODEV;
> +       }
> +
> +       pfru_dev = devm_kzalloc(&pdev->dev, sizeof(*pfru_dev), GFP_KERNEL);
> +       if (!pfru_dev)
> +               return -ENOMEM;
> +
> +       ret = ida_alloc(&pfru_ida, GFP_KERNEL);
> +       if (ret < 0)
> +               return ret;
> +
> +       pfru_dev->index = ret;
> +       ret = devm_add_action_or_reset(&pdev->dev, pfru_put_idx, pfru_dev);
> +       if (ret)
> +               return ret;
> +
> +       pfru_dev->rev_id = PFRU_DEFAULT_REV_ID;
> +       pfru_dev->parent_dev = &pdev->dev;
> +
> +       pfru_dev->miscdev.minor = MISC_DYNAMIC_MINOR;
> +       pfru_dev->miscdev.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +                                               "pfru%d", pfru_dev->index);
> +       if (!pfru_dev->miscdev.name)
> +               return -ENOMEM;
> +
> +       pfru_dev->miscdev.nodename = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +                                                   "acpi_pfru%d", pfru_dev->index);

So in accordance with the naming considerations above, I would call
this devis "acpi_pfr_update".

> +       if (!pfru_dev->miscdev.nodename)
> +               return -ENOMEM;
> +
> +       pfru_dev->miscdev.fops = &acpi_pfru_fops;
> +       pfru_dev->miscdev.parent = &pdev->dev;
> +
> +       ret = misc_register(&pfru_dev->miscdev);
> +       if (ret)
> +               return ret;
> +
> +       platform_set_drvdata(pdev, pfru_dev);
> +
> +       return 0;
> +}
> +
> +static const struct acpi_device_id acpi_pfru_ids[] = {
> +       {"INTC1080"},
> +       {}
> +};
> +MODULE_DEVICE_TABLE(acpi, acpi_pfru_ids);
> +
> +static struct platform_driver acpi_pfru_driver = {
> +       .driver = {
> +               .name = "pfru_update",

"pfr_update" ?

> +               .acpi_match_table = acpi_pfru_ids,
> +       },
> +       .probe = acpi_pfru_probe,
> +       .remove = acpi_pfru_remove,
> +};
> +module_platform_driver(acpi_pfru_driver);
> +
> +MODULE_DESCRIPTION("Platform Firmware Runtime Update device driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/uapi/linux/pfru.h b/include/uapi/linux/pfru.h
> new file mode 100644
> index 000000000000..fed50cb01309
> --- /dev/null
> +++ b/include/uapi/linux/pfru.h
> @@ -0,0 +1,174 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Platform Firmware Runtime Update header
> + *
> + * Copyright(c) 2021 Intel Corporation. All rights reserved.
> + */
> +#ifndef __PFRU_H__
> +#define __PFRU_H__
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +#define PFRU_MAGIC_FOR_IOCTL 0xEE

If you follow my comments regarding the naming, this should be
PFRUT_MAGIC_FOR_IOCTL, or even PFRUT_IOCTL_MAGIC for brevity.


> +
> +/**
> + * PFRU_IOC_SET_REV - _IOW(PFRU_MAGIC_FOR_IOCTL, 0x01, unsigned int)
> + *
> + * Return:
> + * * 0                 - success
> + * * -EFAULT           - fail to read the revision id
> + * * -EINVAL           - user provides an invalid revision id
> + *
> + * Set the Revision ID for PFRU Runtime Update.
> + */
> +#define PFRU_IOC_SET_REV _IOW(PFRU_MAGIC_FOR_IOCTL, 0x01, unsigned int)
> +
> +/**
> + * PFRU_IOC_STAGE - _IOW(PFRU_MAGIC_FOR_IOCTL, 0x02, unsigned int)
> + *
> + * Return:
> + * * 0                 - success
> + * * -EINVAL           - stage phase returns invalid result
> + *
> + * Stage a capsule image from communication buffer and perform authentication.
> + */
> +#define PFRU_IOC_STAGE _IOW(PFRU_MAGIC_FOR_IOCTL, 0x02, unsigned int)
> +
> +/**
> + * PFRU_IOC_ACTIVATE - _IOW(PFRU_MAGIC_FOR_IOCTL, 0x03, unsigned int)
> + *
> + * Return:
> + * * 0                 - success
> + * * -EINVAL           - activate phase returns invalid result
> + *
> + * Activate a previous staged capsule image.

"previously"

> + */
> +#define PFRU_IOC_ACTIVATE _IOW(PFRU_MAGIC_FOR_IOCTL, 0x03, unsigned int)
> +
> +/**
> + * PFRU_IOC_STAGE_ACTIVATE - _IOW(PFRU_MAGIC_FOR_IOCTL, 0x04, unsigned int)
> + *
> + * Return:
> + * * 0                 - success
> + * * -EINVAL           - stage/activate phase returns invalid result.
> + *
> + * Perform both stage and activation action.
> + */
> +#define PFRU_IOC_STAGE_ACTIVATE _IOW(PFRU_MAGIC_FOR_IOCTL, 0x04, unsigned int)
> +
> +/**
> + * PFRU_IOC_QUERY_CAP - _IOR(PFRU_MAGIC_FOR_IOCTL, 0x05,
> + *                          struct pfru_update_cap_info)
> + *
> + * Return:
> + * * 0                 - success
> + * * -EINVAL           - query phase returns invalid result
> + * * -EFAULT           - the result fails to be copied to userspace
> + *
> + * Retrieve information about the PFRU Runtime Update capability.

"information on"

> + * The information is a struct pfru_update_cap_info.
> + */
> +#define PFRU_IOC_QUERY_CAP _IOR(PFRU_MAGIC_FOR_IOCTL, 0x05, struct pfru_update_cap_info)
> +
> +/**
> + * struct pfru_payload_hdr - Capsule file payload header.
> + *
> + * @sig: Signature of this capsule file.
> + * @hdr_version: Revision of this header structure.
> + * @hdr_size: Size of this header, including the OemHeader bytes.
> + * @hw_ver: The supported firmware version.
> + * @rt_ver: Version of the code injection image.
> + * @platform_id: A platform specific GUID to specify the platform what
> + *               this capsule image support.
> + */
> +struct pfru_payload_hdr {
> +       __u32 sig;
> +       __u32 hdr_version;
> +       __u32 hdr_size;
> +       __u32 hw_ver;
> +       __u32 rt_ver;
> +       __u8 platform_id[16];
> +};
> +
> +enum pfru_dsm_status {
> +       DSM_SUCCEED = 0,
> +       DSM_FUNC_NOT_SUPPORT = 1,
> +       DSM_INVAL_INPUT = 2,
> +       DSM_HARDWARE_ERR = 3,
> +       DSM_RETRY_SUGGESTED = 4,
> +       DSM_UNKNOWN = 5,
> +       DSM_FUNC_SPEC_ERR = 6,
> +};
> +
> +/**
> + * struct pfru_update_cap_info - Runtime update capability information.
> + *
> + * @status: Indicator of whether this query succeed.
> + * @update_cap: Bitmap to indicate whether the feature is supported.
> + * @code_type: A buffer containing an image type GUID.
> + * @fw_version: Platform firmware version.
> + * @code_rt_version: Code injection runtime version for anti-rollback.
> + * @drv_type: A buffer containing an image type GUID.
> + * @drv_rt_version: The version of the driver update runtime code.
> + * @drv_svn: The secure version number(SVN) of the driver update runtime code.
> + * @platform_id: A buffer containing a platform ID GUID.
> + * @oem_id: A buffer containing an OEM ID GUID.
> + * @oem_info_len: Length of the buffer containing the vendor specific information.
> + */
> +struct pfru_update_cap_info {
> +       __u32 status;
> +       __u32 update_cap;
> +
> +       __u8 code_type[16];
> +       __u32 fw_version;
> +       __u32 code_rt_version;
> +
> +       __u8 drv_type[16];
> +       __u32 drv_rt_version;
> +       __u32 drv_svn;
> +
> +       __u8 platform_id[16];
> +       __u8 oem_id[16];
> +
> +       __u32 oem_info_len;
> +};
> +
> +/**
> + * struct pfru_com_buf_info - Communication buffer information.
> + *
> + * @status: Indicator of whether this query succeed.
> + * @ext_status: Implementation specific query result.
> + * @addr_lo: Low 32bit physical address of the communication buffer to hold
> + *           a runtime update package.
> + * @addr_hi: High 32bit physical address of the communication buffer to hold
> + *           a runtime update package.
> + * @buf_size: Maximum size in bytes of the communication buffer.
> + */
> +struct pfru_com_buf_info {
> +       __u32 status;
> +       __u32 ext_status;
> +       __u64 addr_lo;
> +       __u64 addr_hi;
> +       __u32 buf_size;
> +};
> +
> +/**
> + * struct pfru_updated_result - Platform firmware runtime update result information.
> + * @status: Indicator of whether this update succeed.
> + * @ext_status: Implementation specific update result.
> + * @low_auth_time: Low 32bit value of image authentication time in nanosecond.
> + * @high_auth_time: High 32bit value of image authentication time in nanosecond.
> + * @low_exec_time: Low 32bit value of image execution time in nanosecond.
> + * @high_exec_time: High 32bit value of image execution time in nanosecond.
> + */
> +struct pfru_updated_result {
> +       __u32 status;
> +       __u32 ext_status;
> +       __u64 low_auth_time;
> +       __u64 high_auth_time;
> +       __u64 low_exec_time;
> +       __u64 high_exec_time;
> +};
> +
> +#endif /* __PFRU_H__ */
> --

Overall, I think that the design is fine now, it just needs to be made nicer.

[Please wait for my comments on the next patch before sending a new version.]
