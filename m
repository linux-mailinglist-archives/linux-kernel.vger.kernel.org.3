Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90AF846CE0D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 08:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244385AbhLHHH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 02:07:26 -0500
Received: from mga17.intel.com ([192.55.52.151]:37310 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231351AbhLHHHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 02:07:25 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="218456330"
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; 
   d="scan'208";a="218456330"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 23:03:54 -0800
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; 
   d="scan'208";a="502942272"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.186])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 23:03:51 -0800
Date:   Wed, 8 Dec 2021 15:03:38 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 3/4] drivers/acpi: Introduce Platform Firmware
 Runtime Update Telemetry
Message-ID: <20211208070338.GA261963@chenyu-desktop>
References: <cover.1637505679.git.yu.c.chen@intel.com>
 <abd1ed0c9d2ef5f856d6aa31166f6a9bf515978d.1637505679.git.yu.c.chen@intel.com>
 <CAJZ5v0hd2=aA1S5XAVNnpJfhLmahOGEZOVsNGbkBeWX+fUxhvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hd2=aA1S5XAVNnpJfhLmahOGEZOVsNGbkBeWX+fUxhvQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 08:44:52PM +0100, Rafael J. Wysocki wrote:
> On Sun, Nov 21, 2021 at 4:17 PM Chen Yu <yu.c.chen@intel.com> wrote:
> >
> 
> First of all, the subject of the patch should be "Introduce Platform
> Firmware Runtime Telemetry", because there is no "update" part in it.
>
Ok, will change it. 
> > Platform Firmware Runtime Update(PFRU) Telemetry Service is part of RoT
> > (Root of Trust), which allows PFRU handler and other PFRU drivers to
> > produce telemetry data to upper layer OS consumer at runtime.
> 
> The above paragraph is redundant IMO.  It provides a little useful
> information IMV.
>
Ok, will remove it 
> > The Linux kernel provides interfaces for the user to query the parameters
> > of telemetry data, and the user could read out the telemetry data
> > accordingly.
> 
> In fact, this driver allows user space to fetch telemetry data from
> the firmware with the help of the Platform Firmware Runtime Telemetry
> interface.
>
Ok. 
> > PFRU and PFRU Telemetry both invoke _DSM to trigger the low level actions.
> 
> "PFRU and PFRT " or "PFRU and PFR Telemetry ", please.
> 
Ok will use the former one.
> > However the input parameters and ACPI package result as well as the
> > functions are different from each other. It is hard to extract the common
> > code between them, so introduce separated files for them.
> 
> I would write the above in the following way:
> 
> "Both PFRU and PFRT are based on ACPI _DSM interfaces located under
> special device objects in the ACPI Namespace, but these interfaces are
> different from each other, so it is better to provide a separate
> driver from each of them.  However, they share some common definitions
> and naming conventions."
>
Ok, will change it. 
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> 
> [cut the history]
> 
> > ---
> >  drivers/acpi/pfru/Makefile         |   2 +-
> >  drivers/acpi/pfru/pfru_telemetry.c | 457 +++++++++++++++++++++++++++++
> >  include/uapi/linux/pfru.h          |  88 ++++++
> >  3 files changed, 546 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/acpi/pfru/pfru_telemetry.c
> >
> > diff --git a/drivers/acpi/pfru/Makefile b/drivers/acpi/pfru/Makefile
> > index 098cbe80cf3d..9ba11efe10b3 100644
> > --- a/drivers/acpi/pfru/Makefile
> > +++ b/drivers/acpi/pfru/Makefile
> 
> Actually, I'm not sure if a separate directory for this is needed.
> 
> The files (pfrut.h, pfr_update.c and pfr_telemetry.c) can be located
> directly in drivers/acpi/ as far as I'm concerned.
>
pfr_update.c and pfr_telemetry.c could be put in drivers/acpi, but pfrut.h
is used by user space tool for ioctl interface and shares some data structures
between the driver and user space tool, so the pfrut.h might need to be put
to include/uapi/linux/pfrut.h 
> > @@ -1,2 +1,2 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > -obj-$(CONFIG_ACPI_PFRU) += pfru_update.o
> > +obj-$(CONFIG_ACPI_PFRU) += pfru_update.o pfru_telemetry.o
> 
> Please also update Kconfig with the information regarding PFRT (which
> is not going to be added by the previous patch I suppose).
>
Ok, will do. 
> > diff --git a/drivers/acpi/pfru/pfru_telemetry.c b/drivers/acpi/pfru/pfru_telemetry.c
> > new file mode 100644
> > index 000000000000..5140a4591c9e
> > --- /dev/null
> > +++ b/drivers/acpi/pfru/pfru_telemetry.c
> > @@ -0,0 +1,457 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * ACPI Platform Firmware Runtime Update Telemetry Driver
> 
> "ACPI Platform Runtime Telemetry driver"
> 
Ok.
> > + *
> > + * Copyright (C) 2021 Intel Corporation
> > + * Author: Chen Yu <yu.c.chen@intel.com>
> 
> Please describe the driver here at least briefly (what it is for etc.).
>
Ok, will do. 
> > + */
> > +#include <linux/acpi.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/errno.h>
> > +#include <linux/file.h>
> > +#include <linux/fs.h>
> > +#include <linux/miscdevice.h>
> > +#include <linux/module.h>
> > +#include <linux/mm.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/string.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/uio.h>
> > +#include <linux/uuid.h>
> > +
> > +#include <uapi/linux/pfru.h>
> > +
> > +#define PFRU_LOG_EXEC_IDX      0
> > +#define PFRU_LOG_HISTORY_IDX   1
> > +
> > +#define PFRU_LOG_ERR           0
> > +#define PFRU_LOG_WARN  1
> > +#define PFRU_LOG_INFO  2
> > +#define PFRU_LOG_VERB  4
> > +
> > +#define PFRU_FUNC_SET_LEV              1
> > +#define PFRU_FUNC_GET_LEV              2
> > +#define PFRU_FUNC_GET_DATA             3
> > +
> > +#define PFRU_REVID_1           1
> > +#define PFRU_REVID_2           2
> > +#define PFRU_DEFAULT_REV_ID    PFRU_REVID_1
> 
> I would use the PFRT_ prefix in the above symbols.
>
Ok, will change them accordingly. 
> > +
> > +enum log_index {
> > +       LOG_STATUS_IDX = 0,
> > +       LOG_EXT_STATUS_IDX = 1,
> > +       LOG_MAX_SZ_IDX = 2,
> > +       LOG_CHUNK1_LO_IDX = 3,
> > +       LOG_CHUNK1_HI_IDX = 4,
> > +       LOG_CHUNK1_SZ_IDX = 5,
> > +       LOG_CHUNK2_LO_IDX = 6,
> > +       LOG_CHUNK2_HI_IDX = 7,
> > +       LOG_CHUNK2_SZ_IDX = 8,
> > +       LOG_ROLLOVER_CNT_IDX = 9,
> > +       LOG_RESET_CNT_IDX = 10,
> > +       LOG_NR_IDX
> > +};
> > +
> > +struct pfru_log_device {
> 
> 'pfrt_log_device"
>
Ok. 
> > +       int index;
> > +       struct pfru_log_info info;
> > +       struct device *parent_dev;
> > +       struct miscdevice miscdev;
> > +};
> > +
> > +static const guid_t pfru_log_guid =
> > +       GUID_INIT(0x75191659, 0x8178, 0x4D9D, 0xB8, 0x8F, 0xAC, 0x5E,
> > +                 0x5E, 0x93, 0xE8, 0xBF);
> 
> The UUID needs to be documented.
> 
Ok.
> > +
> > +static DEFINE_IDA(pfru_log_ida);
> 
> pfrt_log_ida
> 
> Generally, I would use the pfrt_ prefix in the names below instead of pfru_.
> 
Ok, will change them accordingly.
> > +
> > +static inline struct pfru_log_device *to_pfru_log_dev(struct file *file)
> > +{
> > +       return container_of(file->private_data, struct pfru_log_device, miscdev);
> > +}
> > +
> > +static int get_pfru_log_data_info(struct pfru_log_data_info *data_info,
> > +                                 struct pfru_log_device *pfru_log_dev)
> > +{
> > +       acpi_handle handle = ACPI_HANDLE(pfru_log_dev->parent_dev);
> > +       union acpi_object *out_obj, in_obj, in_buf;
> > +       int ret = -EINVAL;
> > +
> > +       memset(&in_obj, 0, sizeof(in_obj));
> > +       memset(&in_buf, 0, sizeof(in_buf));
> > +       in_obj.type = ACPI_TYPE_PACKAGE;
> > +       in_obj.package.count = 1;
> > +       in_obj.package.elements = &in_buf;
> > +       in_buf.type = ACPI_TYPE_INTEGER;
> > +       in_buf.integer.value = pfru_log_dev->info.log_type;
> > +
> > +       out_obj = acpi_evaluate_dsm_typed(handle, &pfru_log_guid,
> > +                                         pfru_log_dev->info.log_revid, PFRU_FUNC_GET_DATA,
> > +                                         &in_obj, ACPI_TYPE_PACKAGE);
> > +       if (!out_obj)
> > +               return ret;
> > +
> > +       if (out_obj->package.count < LOG_NR_IDX)
> > +               goto free_acpi_buffer;
> > +
> > +       if (out_obj->package.elements[LOG_STATUS_IDX].type != ACPI_TYPE_INTEGER)
> > +               goto free_acpi_buffer;
> > +
> > +       data_info->status = out_obj->package.elements[LOG_STATUS_IDX].integer.value;
> > +
> > +       if (out_obj->package.elements[LOG_EXT_STATUS_IDX].type != ACPI_TYPE_INTEGER)
> > +               goto free_acpi_buffer;
> > +
> > +       data_info->ext_status =
> > +               out_obj->package.elements[LOG_EXT_STATUS_IDX].integer.value;
> > +
> > +       if (out_obj->package.elements[LOG_MAX_SZ_IDX].type != ACPI_TYPE_INTEGER)
> > +               goto free_acpi_buffer;
> > +
> > +       data_info->max_data_size =
> > +               out_obj->package.elements[LOG_MAX_SZ_IDX].integer.value;
> > +
> > +       if (out_obj->package.elements[LOG_CHUNK1_LO_IDX].type != ACPI_TYPE_INTEGER)
> > +               goto free_acpi_buffer;
> > +
> > +       data_info->chunk1_addr_lo =
> > +               out_obj->package.elements[LOG_CHUNK1_LO_IDX].integer.value;
> > +
> > +       if (out_obj->package.elements[LOG_CHUNK1_HI_IDX].type != ACPI_TYPE_INTEGER)
> > +               goto free_acpi_buffer;
> > +
> > +       data_info->chunk1_addr_hi =
> > +               out_obj->package.elements[LOG_CHUNK1_HI_IDX].integer.value;
> > +
> > +       if (out_obj->package.elements[LOG_CHUNK1_SZ_IDX].type != ACPI_TYPE_INTEGER)
> > +               goto free_acpi_buffer;
> > +
> > +       data_info->chunk1_size =
> > +               out_obj->package.elements[LOG_CHUNK1_SZ_IDX].integer.value;
> > +
> > +       if (out_obj->package.elements[LOG_CHUNK2_LO_IDX].type != ACPI_TYPE_INTEGER)
> > +               goto free_acpi_buffer;
> > +
> > +       data_info->chunk2_addr_lo =
> > +               out_obj->package.elements[LOG_CHUNK2_LO_IDX].integer.value;
> > +
> > +       if (out_obj->package.elements[LOG_CHUNK2_HI_IDX].type != ACPI_TYPE_INTEGER)
> > +               goto free_acpi_buffer;
> > +
> > +       data_info->chunk2_addr_hi =
> > +               out_obj->package.elements[LOG_CHUNK2_HI_IDX].integer.value;
> > +
> > +       if (out_obj->package.elements[LOG_CHUNK2_SZ_IDX].type != ACPI_TYPE_INTEGER)
> > +               goto free_acpi_buffer;
> > +
> > +       data_info->chunk2_size =
> > +               out_obj->package.elements[LOG_CHUNK2_SZ_IDX].integer.value;
> > +
> > +       if (out_obj->package.elements[LOG_ROLLOVER_CNT_IDX].type != ACPI_TYPE_INTEGER)
> > +               goto free_acpi_buffer;
> > +
> > +       data_info->rollover_cnt =
> > +               out_obj->package.elements[LOG_ROLLOVER_CNT_IDX].integer.value;
> > +
> > +       if (out_obj->package.elements[LOG_RESET_CNT_IDX].type != ACPI_TYPE_INTEGER)
> > +               goto free_acpi_buffer;
> > +
> > +       data_info->reset_cnt =
> > +               out_obj->package.elements[LOG_RESET_CNT_IDX].integer.value;
> 
> Like in some functions in the other patch, it would be good to reduce
> the number of goto statements and possibly redundant updates by
> grouping the checks.
>
Ok, will do. 
> > +
> > +       ret = 0;
> > +
> > +free_acpi_buffer:
> > +       kfree(out_obj);
> > +
> > +       return ret;
> > +}
> > +
[cut]
> > +static long pfru_log_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> > +{
> > +       struct pfru_log_device *pfru_log_dev = to_pfru_log_dev(file);
> > +       struct pfru_log_data_info data_info;
> > +       struct pfru_log_info info;
> > +       void __user *p;
> > +       int ret = 0;
> > +
> > +       p = (void __user *)arg;
> > +
> > +       switch (cmd) {
> > +       case PFRU_LOG_IOC_SET_INFO:
> > +               if (copy_from_user(&info, p, sizeof(info)))
> > +                       return -EFAULT;
> > +
> > +               if (valid_log_revid(info.log_revid))
> > +                       pfru_log_dev->info.log_revid = info.log_revid;
> > +
> > +               if (valid_log_level(info.log_level)) {
> > +                       ret = set_pfru_log_level(info.log_level, pfru_log_dev);
> > +                       if (ret < 0)
> > +                               return ret;
> > +
> > +                       pfru_log_dev->info.log_level = info.log_level;
> > +               }
> > +
> > +               if (valid_log_type(info.log_type))
> > +                       pfru_log_dev->info.log_type = info.log_type;
> > +
> > +               return 0;
> 
> Please use blank lines to separate the cases visually from each other.
> 
Ok.
> > +       case PFRU_LOG_IOC_GET_INFO:
> > +               info.log_level = get_pfru_log_level(pfru_log_dev);
> > +               if (ret < 0)
> > +                       return ret;
> > +
[cut]
> > +       pfru_log_dev->info.log_revid = PFRU_DEFAULT_REV_ID;
> > +       pfru_log_dev->parent_dev = &pdev->dev;
> > +
> > +       pfru_log_dev->miscdev.minor = MISC_DYNAMIC_MINOR;
> > +       pfru_log_dev->miscdev.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> > +                                                   "pfru_telemetry%d",
> 
> I would call it "pfr_telemetry" (without the "u" in the prefix).
> 
Ok.
> > +                                                   pfru_log_dev->index);
> > +       if (!pfru_log_dev->miscdev.name)
> > +               return -ENOMEM;
> > +
> > +       pfru_log_dev->miscdev.nodename = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> > +                                                       "acpi_pfru_telemetry%d",
> 
> And this one (analogously) "acpi_pfr_telemetry".
> 
Ok, will do.
> > +                                                       pfru_log_dev->index);
> > +       if (!pfru_log_dev->miscdev.nodename)
> > +               return -ENOMEM;
> > +
[cut]
> 
> And of course it needs to be rebased to take the changes in the
> previous patch into account.
>
Ok, will do. 
> Overall, it's almost there IMO.


thanks,
Chenyu
