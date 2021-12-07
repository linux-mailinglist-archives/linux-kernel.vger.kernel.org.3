Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60B846C3E4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 20:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbhLGTsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 14:48:36 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:33680 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236447AbhLGTsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 14:48:35 -0500
Received: by mail-oi1-f178.google.com with SMTP id q25so733888oiw.0;
        Tue, 07 Dec 2021 11:45:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sMGt0LLRIXYHhJjfdOoKJhCoqjB+6uEaw/ZXm5hR38k=;
        b=AbQNJGDGlQENU7uX/rbS2ouhakwRGt3DaH8QkTJq+k/2qVD+fImaA/0Wr24qqFyriU
         r4Yml875qkrztnCSqTa82isX734fCGew1kdZf9YO65tQVK9VMmoBt8vM/IjUgjJTx7cH
         QXmrs5UyhQiU1YKyHVaNLSBvrMTW65xfYPwfmG5KmXQQ5AshV0LU7npuLh71hBAAwyhj
         BznjauIZcTKxZaVsyWDWG38e3joJns/YZO9wKrXyTF2ArZpoXkUn0XhZhJ/ImTu3Qx8w
         yqs/owYmsUvjzcaz/voDRkuWU818dusbH5PdMwVLUJvUzPI1eP/5vsfCqQVzBbHOL2LZ
         ZI4Q==
X-Gm-Message-State: AOAM531yKyeH72PMVPKJ08Ff03MD7Fnxyjb18NzHFtBIz6fZQQL7VJmQ
        KBdwqIlKKrDnJmW0sBoSEOKwG1ALV1mSQ9a1x4s=
X-Google-Smtp-Source: ABdhPJyYAiHyDQPXXApT0ZcJUTTzTHMDL9wcIDk97p14sAh0aWk/n26Takhu5Vd0/yw91RaSp3Y+T4/4IUV5syXmtpA=
X-Received: by 2002:aca:eb0b:: with SMTP id j11mr7082614oih.51.1638906304011;
 Tue, 07 Dec 2021 11:45:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637505679.git.yu.c.chen@intel.com> <abd1ed0c9d2ef5f856d6aa31166f6a9bf515978d.1637505679.git.yu.c.chen@intel.com>
In-Reply-To: <abd1ed0c9d2ef5f856d6aa31166f6a9bf515978d.1637505679.git.yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Dec 2021 20:44:52 +0100
Message-ID: <CAJZ5v0hd2=aA1S5XAVNnpJfhLmahOGEZOVsNGbkBeWX+fUxhvQ@mail.gmail.com>
Subject: Re: [PATCH v11 3/4] drivers/acpi: Introduce Platform Firmware Runtime
 Update Telemetry
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

First of all, the subject of the patch should be "Introduce Platform
Firmware Runtime Telemetry", because there is no "update" part in it.

> Platform Firmware Runtime Update(PFRU) Telemetry Service is part of RoT
> (Root of Trust), which allows PFRU handler and other PFRU drivers to
> produce telemetry data to upper layer OS consumer at runtime.

The above paragraph is redundant IMO.  It provides a little useful
information IMV.

> The Linux kernel provides interfaces for the user to query the parameters
> of telemetry data, and the user could read out the telemetry data
> accordingly.

In fact, this driver allows user space to fetch telemetry data from
the firmware with the help of the Platform Firmware Runtime Telemetry
interface.

> PFRU and PFRU Telemetry both invoke _DSM to trigger the low level actions.

"PFRU and PFRT " or "PFRU and PFR Telemetry ", please.

> However the input parameters and ACPI package result as well as the
> functions are different from each other. It is hard to extract the common
> code between them, so introduce separated files for them.

I would write the above in the following way:

"Both PFRU and PFRT are based on ACPI _DSM interfaces located under
special device objects in the ACPI Namespace, but these interfaces are
different from each other, so it is better to provide a separate
driver from each of them.  However, they share some common definitions
and naming conventions."

> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---

[cut the history]

> ---
>  drivers/acpi/pfru/Makefile         |   2 +-
>  drivers/acpi/pfru/pfru_telemetry.c | 457 +++++++++++++++++++++++++++++
>  include/uapi/linux/pfru.h          |  88 ++++++
>  3 files changed, 546 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/acpi/pfru/pfru_telemetry.c
>
> diff --git a/drivers/acpi/pfru/Makefile b/drivers/acpi/pfru/Makefile
> index 098cbe80cf3d..9ba11efe10b3 100644
> --- a/drivers/acpi/pfru/Makefile
> +++ b/drivers/acpi/pfru/Makefile

Actually, I'm not sure if a separate directory for this is needed.

The files (pfrut.h, pfr_update.c and pfr_telemetry.c) can be located
directly in drivers/acpi/ as far as I'm concerned.

> @@ -1,2 +1,2 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -obj-$(CONFIG_ACPI_PFRU) += pfru_update.o
> +obj-$(CONFIG_ACPI_PFRU) += pfru_update.o pfru_telemetry.o

Please also update Kconfig with the information regarding PFRT (which
is not going to be added by the previous patch I suppose).

> diff --git a/drivers/acpi/pfru/pfru_telemetry.c b/drivers/acpi/pfru/pfru_telemetry.c
> new file mode 100644
> index 000000000000..5140a4591c9e
> --- /dev/null
> +++ b/drivers/acpi/pfru/pfru_telemetry.c
> @@ -0,0 +1,457 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ACPI Platform Firmware Runtime Update Telemetry Driver

"ACPI Platform Runtime Telemetry driver"

> + *
> + * Copyright (C) 2021 Intel Corporation
> + * Author: Chen Yu <yu.c.chen@intel.com>

Please describe the driver here at least briefly (what it is for etc.).

> + */
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/mm.h>
> +#include <linux/platform_device.h>
> +#include <linux/string.h>
> +#include <linux/uaccess.h>
> +#include <linux/uio.h>
> +#include <linux/uuid.h>
> +
> +#include <uapi/linux/pfru.h>
> +
> +#define PFRU_LOG_EXEC_IDX      0
> +#define PFRU_LOG_HISTORY_IDX   1
> +
> +#define PFRU_LOG_ERR           0
> +#define PFRU_LOG_WARN  1
> +#define PFRU_LOG_INFO  2
> +#define PFRU_LOG_VERB  4
> +
> +#define PFRU_FUNC_SET_LEV              1
> +#define PFRU_FUNC_GET_LEV              2
> +#define PFRU_FUNC_GET_DATA             3
> +
> +#define PFRU_REVID_1           1
> +#define PFRU_REVID_2           2
> +#define PFRU_DEFAULT_REV_ID    PFRU_REVID_1

I would use the PFRT_ prefix in the above symbols.

> +
> +enum log_index {
> +       LOG_STATUS_IDX = 0,
> +       LOG_EXT_STATUS_IDX = 1,
> +       LOG_MAX_SZ_IDX = 2,
> +       LOG_CHUNK1_LO_IDX = 3,
> +       LOG_CHUNK1_HI_IDX = 4,
> +       LOG_CHUNK1_SZ_IDX = 5,
> +       LOG_CHUNK2_LO_IDX = 6,
> +       LOG_CHUNK2_HI_IDX = 7,
> +       LOG_CHUNK2_SZ_IDX = 8,
> +       LOG_ROLLOVER_CNT_IDX = 9,
> +       LOG_RESET_CNT_IDX = 10,
> +       LOG_NR_IDX
> +};
> +
> +struct pfru_log_device {

'pfrt_log_device"

> +       int index;
> +       struct pfru_log_info info;
> +       struct device *parent_dev;
> +       struct miscdevice miscdev;
> +};
> +
> +static const guid_t pfru_log_guid =
> +       GUID_INIT(0x75191659, 0x8178, 0x4D9D, 0xB8, 0x8F, 0xAC, 0x5E,
> +                 0x5E, 0x93, 0xE8, 0xBF);

The UUID needs to be documented.

> +
> +static DEFINE_IDA(pfru_log_ida);

pfrt_log_ida

Generally, I would use the pfrt_ prefix in the names below instead of pfru_.

> +
> +static inline struct pfru_log_device *to_pfru_log_dev(struct file *file)
> +{
> +       return container_of(file->private_data, struct pfru_log_device, miscdev);
> +}
> +
> +static int get_pfru_log_data_info(struct pfru_log_data_info *data_info,
> +                                 struct pfru_log_device *pfru_log_dev)
> +{
> +       acpi_handle handle = ACPI_HANDLE(pfru_log_dev->parent_dev);
> +       union acpi_object *out_obj, in_obj, in_buf;
> +       int ret = -EINVAL;
> +
> +       memset(&in_obj, 0, sizeof(in_obj));
> +       memset(&in_buf, 0, sizeof(in_buf));
> +       in_obj.type = ACPI_TYPE_PACKAGE;
> +       in_obj.package.count = 1;
> +       in_obj.package.elements = &in_buf;
> +       in_buf.type = ACPI_TYPE_INTEGER;
> +       in_buf.integer.value = pfru_log_dev->info.log_type;
> +
> +       out_obj = acpi_evaluate_dsm_typed(handle, &pfru_log_guid,
> +                                         pfru_log_dev->info.log_revid, PFRU_FUNC_GET_DATA,
> +                                         &in_obj, ACPI_TYPE_PACKAGE);
> +       if (!out_obj)
> +               return ret;
> +
> +       if (out_obj->package.count < LOG_NR_IDX)
> +               goto free_acpi_buffer;
> +
> +       if (out_obj->package.elements[LOG_STATUS_IDX].type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +
> +       data_info->status = out_obj->package.elements[LOG_STATUS_IDX].integer.value;
> +
> +       if (out_obj->package.elements[LOG_EXT_STATUS_IDX].type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +
> +       data_info->ext_status =
> +               out_obj->package.elements[LOG_EXT_STATUS_IDX].integer.value;
> +
> +       if (out_obj->package.elements[LOG_MAX_SZ_IDX].type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +
> +       data_info->max_data_size =
> +               out_obj->package.elements[LOG_MAX_SZ_IDX].integer.value;
> +
> +       if (out_obj->package.elements[LOG_CHUNK1_LO_IDX].type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +
> +       data_info->chunk1_addr_lo =
> +               out_obj->package.elements[LOG_CHUNK1_LO_IDX].integer.value;
> +
> +       if (out_obj->package.elements[LOG_CHUNK1_HI_IDX].type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +
> +       data_info->chunk1_addr_hi =
> +               out_obj->package.elements[LOG_CHUNK1_HI_IDX].integer.value;
> +
> +       if (out_obj->package.elements[LOG_CHUNK1_SZ_IDX].type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +
> +       data_info->chunk1_size =
> +               out_obj->package.elements[LOG_CHUNK1_SZ_IDX].integer.value;
> +
> +       if (out_obj->package.elements[LOG_CHUNK2_LO_IDX].type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +
> +       data_info->chunk2_addr_lo =
> +               out_obj->package.elements[LOG_CHUNK2_LO_IDX].integer.value;
> +
> +       if (out_obj->package.elements[LOG_CHUNK2_HI_IDX].type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +
> +       data_info->chunk2_addr_hi =
> +               out_obj->package.elements[LOG_CHUNK2_HI_IDX].integer.value;
> +
> +       if (out_obj->package.elements[LOG_CHUNK2_SZ_IDX].type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +
> +       data_info->chunk2_size =
> +               out_obj->package.elements[LOG_CHUNK2_SZ_IDX].integer.value;
> +
> +       if (out_obj->package.elements[LOG_ROLLOVER_CNT_IDX].type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +
> +       data_info->rollover_cnt =
> +               out_obj->package.elements[LOG_ROLLOVER_CNT_IDX].integer.value;
> +
> +       if (out_obj->package.elements[LOG_RESET_CNT_IDX].type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +
> +       data_info->reset_cnt =
> +               out_obj->package.elements[LOG_RESET_CNT_IDX].integer.value;

Like in some functions in the other patch, it would be good to reduce
the number of goto statements and possibly redundant updates by
grouping the checks.

> +
> +       ret = 0;
> +
> +free_acpi_buffer:
> +       kfree(out_obj);
> +
> +       return ret;
> +}
> +
> +static int set_pfru_log_level(int level, struct pfru_log_device *pfru_log_dev)
> +{
> +       acpi_handle handle = ACPI_HANDLE(pfru_log_dev->parent_dev);
> +       union acpi_object *out_obj, *obj, in_obj, in_buf;
> +       enum pfru_dsm_status status;
> +       int ret = -EINVAL;
> +
> +       memset(&in_obj, 0, sizeof(in_obj));
> +       memset(&in_buf, 0, sizeof(in_buf));
> +       in_obj.type = ACPI_TYPE_PACKAGE;
> +       in_obj.package.count = 1;
> +       in_obj.package.elements = &in_buf;
> +       in_buf.type = ACPI_TYPE_INTEGER;
> +       in_buf.integer.value = level;
> +
> +       out_obj = acpi_evaluate_dsm_typed(handle, &pfru_log_guid,
> +                                         pfru_log_dev->info.log_revid, PFRU_FUNC_SET_LEV,
> +                                         &in_obj, ACPI_TYPE_PACKAGE);
> +       if (!out_obj)
> +               return -EINVAL;
> +
> +       obj = &out_obj->package.elements[0];
> +       status = obj->integer.value;
> +       if (status)
> +               goto free_acpi_buffer;
> +
> +       obj = &out_obj->package.elements[1];
> +       status = obj->integer.value;
> +       if (status)
> +               goto free_acpi_buffer;
> +
> +       ret = 0;
> +
> +free_acpi_buffer:
> +       kfree(out_obj);
> +
> +       return ret;
> +}
> +
> +static int get_pfru_log_level(struct pfru_log_device *pfru_log_dev)
> +{
> +       acpi_handle handle = ACPI_HANDLE(pfru_log_dev->parent_dev);
> +       union acpi_object *out_obj, *obj;
> +       enum pfru_dsm_status status;
> +       int ret = -EINVAL;
> +
> +       out_obj = acpi_evaluate_dsm_typed(handle, &pfru_log_guid,
> +                                         pfru_log_dev->info.log_revid, PFRU_FUNC_GET_LEV,
> +                                         NULL, ACPI_TYPE_PACKAGE);
> +       if (!out_obj)
> +               return -EINVAL;
> +
> +       obj = &out_obj->package.elements[0];
> +       if (obj->type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +
> +       status = obj->integer.value;
> +       if (status)
> +               goto free_acpi_buffer;
> +
> +       obj = &out_obj->package.elements[1];
> +       if (obj->type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +
> +       status = obj->integer.value;
> +       if (status)
> +               goto free_acpi_buffer;
> +
> +       obj = &out_obj->package.elements[2];
> +       if (obj->type != ACPI_TYPE_INTEGER)
> +               goto free_acpi_buffer;
> +
> +       ret = obj->integer.value;
> +
> +free_acpi_buffer:
> +       kfree(out_obj);
> +
> +       return ret;
> +}
> +
> +static int valid_log_level(u32 level)
> +{
> +       return level == PFRU_LOG_ERR || level == PFRU_LOG_WARN ||
> +              level == PFRU_LOG_INFO || level == PFRU_LOG_VERB;
> +}
> +
> +static int valid_log_type(u32 type)
> +{
> +       return type == PFRU_LOG_EXEC_IDX || type == PFRU_LOG_HISTORY_IDX;
> +}
> +
> +static inline int valid_log_revid(u32 id)
> +{
> +       return id == PFRU_REVID_1 || id == PFRU_REVID_2;
> +}
> +
> +static long pfru_log_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +       struct pfru_log_device *pfru_log_dev = to_pfru_log_dev(file);
> +       struct pfru_log_data_info data_info;
> +       struct pfru_log_info info;
> +       void __user *p;
> +       int ret = 0;
> +
> +       p = (void __user *)arg;
> +
> +       switch (cmd) {
> +       case PFRU_LOG_IOC_SET_INFO:
> +               if (copy_from_user(&info, p, sizeof(info)))
> +                       return -EFAULT;
> +
> +               if (valid_log_revid(info.log_revid))
> +                       pfru_log_dev->info.log_revid = info.log_revid;
> +
> +               if (valid_log_level(info.log_level)) {
> +                       ret = set_pfru_log_level(info.log_level, pfru_log_dev);
> +                       if (ret < 0)
> +                               return ret;
> +
> +                       pfru_log_dev->info.log_level = info.log_level;
> +               }
> +
> +               if (valid_log_type(info.log_type))
> +                       pfru_log_dev->info.log_type = info.log_type;
> +
> +               return 0;

Please use blank lines to separate the cases visually from each other.

> +       case PFRU_LOG_IOC_GET_INFO:
> +               info.log_level = get_pfru_log_level(pfru_log_dev);
> +               if (ret < 0)
> +                       return ret;
> +
> +               info.log_type = pfru_log_dev->info.log_type;
> +               info.log_revid = pfru_log_dev->info.log_revid;
> +               if (copy_to_user(p, &info, sizeof(info)))
> +                       return -EFAULT;
> +
> +               return 0;
> +       case PFRU_LOG_IOC_GET_DATA_INFO:
> +               ret = get_pfru_log_data_info(&data_info, pfru_log_dev);
> +               if (ret)
> +                       return ret;
> +
> +               if (copy_to_user(p, &data_info, sizeof(struct pfru_log_data_info)))
> +                       return -EFAULT;
> +
> +               return 0;
> +       default:
> +               return -ENOTTY;
> +       }
> +}
> +
> +static int
> +pfru_log_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +       struct pfru_log_device *pfru_log_dev;
> +       struct pfru_log_data_info info;
> +       unsigned long psize, vsize;
> +       phys_addr_t base_addr;
> +       int ret;
> +
> +       if (vma->vm_flags & VM_WRITE)
> +               return -EROFS;
> +
> +       /* changing from read to write with mprotect is not allowed */
> +       vma->vm_flags &= ~VM_MAYWRITE;
> +
> +       pfru_log_dev = to_pfru_log_dev(file);
> +
> +       ret = get_pfru_log_data_info(&info, pfru_log_dev);
> +       if (ret)
> +               return ret;
> +
> +       base_addr = (phys_addr_t)((info.chunk2_addr_hi << 32) | info.chunk2_addr_lo);
> +       /* pfru update has not been launched yet */
> +       if (!base_addr)
> +               return -ENODEV;
> +
> +       psize = info.max_data_size;
> +       /* base address and total buffer size must be page aligned */
> +       if (!PAGE_ALIGNED(base_addr) || !PAGE_ALIGNED(psize))
> +               return -ENODEV;
> +
> +       vsize = vma->vm_end - vma->vm_start;
> +       if (vsize > psize)
> +               return -EINVAL;
> +
> +       vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +       if (io_remap_pfn_range(vma, vma->vm_start, PFN_DOWN(base_addr),
> +                              vsize, vma->vm_page_prot))
> +               return -EAGAIN;
> +
> +       return 0;
> +}
> +
> +static const struct file_operations acpi_pfru_log_fops = {
> +       .owner          = THIS_MODULE,
> +       .mmap           = pfru_log_mmap,
> +       .unlocked_ioctl = pfru_log_ioctl,
> +       .llseek         = noop_llseek,
> +};
> +
> +static int acpi_pfru_log_remove(struct platform_device *pdev)
> +{
> +       struct pfru_log_device *pfru_log_dev = platform_get_drvdata(pdev);
> +
> +       misc_deregister(&pfru_log_dev->miscdev);
> +
> +       return 0;
> +}
> +
> +static void pfru_log_put_idx(void *data)
> +{
> +       struct pfru_log_device *pfru_log_dev = data;
> +
> +       ida_free(&pfru_log_ida, pfru_log_dev->index);
> +}
> +
> +static int acpi_pfru_log_probe(struct platform_device *pdev)
> +{
> +       acpi_handle handle = ACPI_HANDLE(&pdev->dev);
> +       struct pfru_log_device *pfru_log_dev;
> +       int ret;
> +
> +       if (!acpi_has_method(handle, "_DSM")) {
> +               dev_dbg(&pdev->dev, "Missing _DSM\n");
> +               return -ENODEV;
> +       }
> +
> +       pfru_log_dev = devm_kzalloc(&pdev->dev, sizeof(*pfru_log_dev), GFP_KERNEL);
> +       if (!pfru_log_dev)
> +               return -ENOMEM;
> +
> +       ret = ida_alloc(&pfru_log_ida, GFP_KERNEL);
> +       if (ret < 0)
> +               return ret;
> +
> +       pfru_log_dev->index = ret;
> +       ret = devm_add_action_or_reset(&pdev->dev, pfru_log_put_idx, pfru_log_dev);
> +       if (ret)
> +               return ret;
> +
> +       pfru_log_dev->info.log_revid = PFRU_DEFAULT_REV_ID;
> +       pfru_log_dev->parent_dev = &pdev->dev;
> +
> +       pfru_log_dev->miscdev.minor = MISC_DYNAMIC_MINOR;
> +       pfru_log_dev->miscdev.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +                                                   "pfru_telemetry%d",

I would call it "pfr_telemetry" (without the "u" in the prefix).

> +                                                   pfru_log_dev->index);
> +       if (!pfru_log_dev->miscdev.name)
> +               return -ENOMEM;
> +
> +       pfru_log_dev->miscdev.nodename = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +                                                       "acpi_pfru_telemetry%d",

And this one (analogously) "acpi_pfr_telemetry".

> +                                                       pfru_log_dev->index);
> +       if (!pfru_log_dev->miscdev.nodename)
> +               return -ENOMEM;
> +
> +       pfru_log_dev->miscdev.fops = &acpi_pfru_log_fops;
> +       pfru_log_dev->miscdev.parent = &pdev->dev;
> +
> +       ret = misc_register(&pfru_log_dev->miscdev);
> +       if (ret)
> +               return ret;
> +
> +       platform_set_drvdata(pdev, pfru_log_dev);
> +
> +       return 0;
> +}
> +
> +static const struct acpi_device_id acpi_pfru_log_ids[] = {
> +       {"INTC1081"},
> +       {}
> +};
> +MODULE_DEVICE_TABLE(acpi, acpi_pfru_log_ids);
> +
> +static struct platform_driver acpi_pfru_log_driver = {
> +       .driver = {
> +               .name = "pfru_telemetry",
> +               .acpi_match_table = acpi_pfru_log_ids,
> +       },
> +       .probe = acpi_pfru_log_probe,
> +       .remove = acpi_pfru_log_remove,
> +};
> +module_platform_driver(acpi_pfru_log_driver);
> +
> +MODULE_DESCRIPTION("Platform Firmware Runtime Update Telemetry driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/uapi/linux/pfru.h b/include/uapi/linux/pfru.h
> index fed50cb01309..2f17714e05b7 100644
> --- a/include/uapi/linux/pfru.h
> +++ b/include/uapi/linux/pfru.h
> @@ -171,4 +171,92 @@ struct pfru_updated_result {
>         __u64 high_exec_time;
>  };
>
> +/**
> + * struct pfru_log_data_info - Log Data from telemetry service.
> + * @status: Indicator of whether this update succeed.
> + * @ext_status: Implementation specific update result.
> + * @chunk1_addr_lo: Low 32bit physical address of the telemetry data chunk1
> + *                  starting address.
> + * @chunk1_addr_hi: High 32bit physical address of the telemetry data chunk1
> + *                  starting address.
> + * @chunk2_addr_lo: Low 32bit physical address of the telemetry data chunk2
> + *                  starting address.
> + * @chunk2_addr_hi: High 32bit physical address of the telemetry data chunk2
> + *                  starting address.
> + * @max_data_size: Maximum supported size of data of all data chunks combined.
> + * @chunk1_size: Data size in bytes of the telemetry data chunk1 buffer.
> + * @chunk2_size: Data size in bytes of the telemetry data chunk2 buffer.
> + * @rollover_cnt: Number of times telemetry data buffer is overwritten
> + *                since telemetry buffer reset.
> + * @reset_cnt: Number of times telemetry services resets that results in
> + *             rollover count and data chunk buffers are reset.
> + */
> +struct pfru_log_data_info {
> +       __u32 status;
> +       __u32 ext_status;
> +       __u64 chunk1_addr_lo;
> +       __u64 chunk1_addr_hi;
> +       __u64 chunk2_addr_lo;
> +       __u64 chunk2_addr_hi;
> +       __u32 max_data_size;
> +       __u32 chunk1_size;
> +       __u32 chunk2_size;
> +       __u32 rollover_cnt;
> +       __u32 reset_cnt;
> +};
> +
> +/**
> + * struct pfru_log_info - Telemetry log information.
> + * @log_level: The telemetry log level.
> + * @log_type: The telemetry log type(history and execution).
> + * @log_revid: The telemetry log revision id.
> + */
> +struct pfru_log_info {
> +       __u32 log_level;
> +       __u32 log_type;
> +       __u32 log_revid;
> +};
> +
> +/**
> + * PFRU_LOG_IOC_SET_INFO - _IOW(PFRU_MAGIC_FOR_IOCTL, 0x06,
> + *                             struct pfru_log_info)
> + *
> + * Return:
> + * * 0                 - success
> + * * -EFAULT           - fail to get the setting parameter
> + * * -EINVAL           - fail to set the log level
> + *
> + * Set the PFRU log level and log type. The input information is
> + * a struct pfru_log_info.
> + */
> +#define PFRU_LOG_IOC_SET_INFO _IOW(PFRU_MAGIC_FOR_IOCTL, 0x06, struct pfru_log_info)
> +
> +/**
> + * PFRU_LOG_IOC_GET_INFO - _IOR(PFRU_MAGIC_FOR_IOCTL, 0x07,
> + *                             struct pfru_log_info)
> + *
> + * Return:
> + * * 0                 - success
> + * * -EINVAL           - fail to get the log level
> + * * -EFAULT           - fail to copy the result back to userspace
> + *
> + * Retrieve log level and log type of the PFRU telemetry. The information is
> + * a struct pfru_log_info.
> + */
> +#define PFRU_LOG_IOC_GET_INFO _IOR(PFRU_MAGIC_FOR_IOCTL, 0x07, struct pfru_log_info)
> +
> +/**
> + * PFRU_LOG_IOC_GET_DATA_INFO - _IOR(PFRU_MAGIC_FOR_IOCTL, 0x08,
> + *                                  struct pfru_log_data_info)
> + *
> + * Return:
> + * * 0                 - success
> + * * -EINVAL           - fail to get the log buffer information
> + * * -EFAULT           - fail to copy the log buffer information to userspace
> + *
> + * Retrieve data information about the PFRU telemetry. The information
> + * is a struct pfru_log_data_info.
> + */
> +#define PFRU_LOG_IOC_GET_DATA_INFO _IOR(PFRU_MAGIC_FOR_IOCTL, 0x08, struct pfru_log_data_info)
> +
>  #endif /* __PFRU_H__ */

And of course it needs to be rebased to take the changes in the
previous patch into account.

Overall, it's almost there IMO.
