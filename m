Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E4F58A29C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 22:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239763AbiHDU7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 16:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiHDU7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 16:59:42 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6322A253
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 13:59:40 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id l188so734334oia.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 13:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc;
        bh=f73Eks8Jl6EVDem2eLLD+hj6gdK68wfFjALwud/WERM=;
        b=Oef0oZztUyhGTFkzBwZQVopx2ZB0q7gcQYMtTzXqYaFBp4AoR2rTWgtGa/KHN6p2t0
         1nFWlSaj3Glca8jdeKCHpHpWjcge7RjiUsJPQBcwuCNY/37S3Eejn5J77Bgs5o4uDpGk
         TI3PgkGuBwQJgQ8Y+tZUu6P1S+V8u/VHik27s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc;
        bh=f73Eks8Jl6EVDem2eLLD+hj6gdK68wfFjALwud/WERM=;
        b=XRULKNQzgNLQs6E/kp2W/YTnyEewvP/1Pfais8e1CcGtSgId9k8p54upGBWta7upel
         AeujkvzIpILyJS4fi3dApOWHLquLWQmdAAhHhr2ZChlZ6bfwDrUlzvTmtUIUuaTGUQWY
         NrqfCHkNq45AhHtz5y01NBZyfhRiOSVzP9hf3V9l+MRI/tF5u2enbC6OEo5wRS02BcNl
         BaG4WJhCuNmaawsNpcj1YNZmr/0sDGyc+MycEMl1wHkElwI8kjaSSwWu4MfHir8A/bGK
         8mamjBw+8taNx7I0fTqOXsehqY6/WLF+ighDLRWSC2NaBtVqHuf0MXgZ7CtWZee6xmQF
         kESw==
X-Gm-Message-State: ACgBeo12QE/bsSqBL1U0HhCQrzxLF7klXN2+FAJHG8gOBnbTOj6sr1S1
        AWoHOt/z3XbKCN4seWMBdG/huV3BfD6qsVSFntkOLx7oBes=
X-Google-Smtp-Source: AA6agR7uMzCT9lAbeTLdq8KG/B2wHk+yvs18hpJo16sFUwubF+exgMZF3MeOJa04edDD1C4HK/SuOXzwk3DtfSsfJT4=
X-Received: by 2002:a05:6808:1389:b0:33a:bd16:c4e4 with SMTP id
 c9-20020a056808138900b0033abd16c4e4mr1633784oiw.0.1659646779585; Thu, 04 Aug
 2022 13:59:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Aug 2022 15:59:39 -0500
MIME-Version: 1.0
In-Reply-To: <20220804142856.306032-1-jrosenth@chromium.org>
References: <YuuBrUmiRYoaSmPw@google.com> <20220804142856.306032-1-jrosenth@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 4 Aug 2022 15:59:39 -0500
Message-ID: <CAE-0n51UcauP1ojoskV9_2+CFPoJrs08jGHVPCZdSA_oXX1zUw@mail.gmail.com>
Subject: Re: [PATCH v7] firmware: google: Implement cbmem in sysfs driver
To:     Jack Rosenthal <jrosenth@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jack Rosenthal (2022-08-04 07:28:56)
> cbmem entries can be read from coreboot table
> 0x31 (LB_TAG_CBMEM_ENTRY).  This commit exports access to cbmem
> entries in sysfs under /sys/firmware/coreboot/cbmem-*.
>
> Link: https://issuetracker.google.com/239604743

Is what you intend to use from here essentially an nvram? If so, it may
make more sense to expose just that entry in drivers/nvmem/ as a
read-only sort of nvmem.

> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Reviewed-by: Guenter Roeck <groeck@chromium.org>
> Reviewed-by: Julius Werner <jwerner@chromium.org>
> Tested-by: Jack Rosenthal <jrosenth@chromium.org>
> Signed-off-by: Jack Rosenthal <jrosenth@chromium.org>
> ---

Please don't send patches as replies to previous rounds. It makes it
harder to dig out the latest series.

> v7: Updated commit message.
>  .../ABI/testing/sysfs-firmware-coreboot       |  17 ++
>  drivers/firmware/google/Kconfig               |   8 +
>  drivers/firmware/google/Makefile              |   3 +
>  drivers/firmware/google/cbmem.c               | 232 ++++++++++++++++++
>  drivers/firmware/google/coreboot_table.h      |  11 +
>  5 files changed, 271 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-firmware-coreboot
>  create mode 100644 drivers/firmware/google/cbmem.c
>
> diff --git a/Documentation/ABI/testing/sysfs-firmware-coreboot b/Documentation/ABI/testing/sysfs-firmware-coreboot
> new file mode 100644
> index 000000000000..2401483bb86c
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-firmware-coreboot
> @@ -0,0 +1,17 @@
> +What:          /sys/firmware/coreboot/
> +Date:          July 2022
> +Contact:       Jack Rosenthal <jrosenth@chromium.org>
> +Description:
> +               Coreboot-based BIOS firmware provides a variety of information
> +               in CBMEM.  Each CBMEM entry can be found via Coreboot tables.
> +               For each CBMEM entry, the following are exposed:
> +
> +               ======= =======================================================
> +               address A hexidecimal value of the memory address the data for
> +                       the entry begins at.
> +               size    The size of the data stored.
> +               id      The id corresponding to the entry. A list of ids known
> +                       to coreboot can be found in the coreboot source tree at
> +                       ``src/commonlib/bsd/include/commonlib/bsd/cbmem_id.h``
> +               mem     A file exposing the raw memory for the entry.
> +               ======= =======================================================

It isn't clear to me what the structure of this path is. I'd expect to
see an entry for each 'address', 'size', 'id', 'mem' with a different
What/Date/Contact/Description. If those attributes are all within a
directory in sysfs then there could be a top-level description for that
as well.

   What:          /sys/firmware/coreboot/cbmem-<id>
   Date:          July 2022
   Contact:       Jack Rosenthal <jrosenth@chromium.org>
   Description:
	

   What:          /sys/firmware/coreboot/cbmem-<id>/mem
   Date:          July 2022
   Contact:       Jack Rosenthal <jrosenth@chromium.org>
   Description:

   What:          /sys/firmware/coreboot/cbmem-<id>/size
   Date:          July 2022
   Contact:       Jack Rosenthal <jrosenth@chromium.org>
   Description:

etc..

> diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
> index 983e07dc022e..bf8316d1cb31 100644
> --- a/drivers/firmware/google/Kconfig
> +++ b/drivers/firmware/google/Kconfig
> @@ -19,6 +19,14 @@ config GOOGLE_SMI
>           driver provides an interface for reading and writing NVRAM
>           variables.
>
> +config GOOGLE_CBMEM
> +       tristate "CBMEM entries in sysfs"
> +       depends on GOOGLE_COREBOOT_TABLE
> +       help
> +         This option enables the kernel to search for Coreboot CBMEM
> +         entries, and expose the memory for each entry in sysfs under
> +         /sys/firmware/coreboot.
> +
>  config GOOGLE_COREBOOT_TABLE
>         tristate "Coreboot Table Access"
>         depends on HAS_IOMEM && (ACPI || OF)
> diff --git a/drivers/firmware/google/Makefile b/drivers/firmware/google/Makefile
> index d17caded5d88..8151e323cc43 100644
> --- a/drivers/firmware/google/Makefile
> +++ b/drivers/firmware/google/Makefile
> @@ -7,5 +7,8 @@ obj-$(CONFIG_GOOGLE_MEMCONSOLE)            += memconsole.o
>  obj-$(CONFIG_GOOGLE_MEMCONSOLE_COREBOOT)   += memconsole-coreboot.o
>  obj-$(CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY) += memconsole-x86-legacy.o
>
> +# Must come after coreboot_table.o, as this driver depends on that bus type.
> +obj-$(CONFIG_GOOGLE_CBMEM)             += cbmem.o
> +
>  vpd-sysfs-y := vpd.o vpd_decode.o
>  obj-$(CONFIG_GOOGLE_VPD)               += vpd-sysfs.o
> diff --git a/drivers/firmware/google/cbmem.c b/drivers/firmware/google/cbmem.c
> new file mode 100644
> index 000000000000..9646a8047742
> --- /dev/null
> +++ b/drivers/firmware/google/cbmem.c
> @@ -0,0 +1,232 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * cbmem.c
> + *
> + * Driver for exporting cbmem entries in sysfs.
> + *
> + * Copyright 2022 Google LLC
> + */
> +
> +#include <linux/ctype.h>
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/kobject.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +
> +#include "coreboot_table.h"
> +
> +#define LB_TAG_CBMEM_ENTRY 0x31
> +
> +static struct kobject *coreboot_kobj;
> +
> +struct cbmem_entry;
> +struct cbmem_entry_attr {
> +       struct kobj_attribute kobj_attr;
> +       struct cbmem_entry *entry;
> +};
> +
> +struct cbmem_entry {
> +       char *kobj_name;
> +       struct kobject *kobj;
> +       struct coreboot_device *dev;
> +       struct bin_attribute mem_file;
> +       char *mem_file_buf;
> +       struct cbmem_entry_attr address_file;
> +       struct cbmem_entry_attr size_file;
> +       struct cbmem_entry_attr id_file;
> +};
> +
> +static struct cbmem_entry_attr *to_cbmem_entry_attr(struct kobj_attribute *a)
> +{
> +       return container_of(a, struct cbmem_entry_attr, kobj_attr);
> +}
> +
> +static ssize_t cbmem_entry_mem_read(struct file *filp, struct kobject *kobp,
> +                                   struct bin_attribute *bin_attr, char *buf,
> +                                   loff_t pos, size_t count)
> +{
> +       struct cbmem_entry *entry = bin_attr->private;
> +
> +       return memory_read_from_buffer(buf, count, &pos, entry->mem_file_buf,
> +                                      bin_attr->size);
> +}
> +
> +static ssize_t cbmem_entry_mem_write(struct file *filp, struct kobject *kobp,
> +                                    struct bin_attribute *bin_attr, char *buf,
> +                                    loff_t pos, size_t count)
> +{
> +       struct cbmem_entry *entry = bin_attr->private;
> +
> +       if (pos < 0 || pos >= bin_attr->size)
> +               return -EINVAL;
> +       if (count > bin_attr->size - pos)
> +               count = bin_attr->size - pos;
> +
> +       memcpy(entry->mem_file_buf + pos, buf, count);
> +       return count;
> +}

Do you need to be able to write cbmem entries?

> +
> +static ssize_t cbmem_entry_address_show(struct kobject *kobj,
> +                                       struct kobj_attribute *a, char *buf)
> +{
> +       struct cbmem_entry_attr *entry_attr = to_cbmem_entry_attr(a);
> +
> +       return sysfs_emit(buf, "0x%llx\n",
> +                         entry_attr->entry->dev->cbmem_entry.address);
> +}
> +
> +static ssize_t cbmem_entry_size_show(struct kobject *kobj,
> +                                    struct kobj_attribute *a, char *buf)
> +{
> +       struct cbmem_entry_attr *entry_attr = to_cbmem_entry_attr(a);
> +
> +       return sysfs_emit(buf, "0x%x\n",
> +                         entry_attr->entry->dev->cbmem_entry.entry_size);
> +}
> +
> +static ssize_t cbmem_entry_id_show(struct kobject *kobj,
> +                                  struct kobj_attribute *a, char *buf)
> +{
> +       struct cbmem_entry_attr *entry_attr = to_cbmem_entry_attr(a);
> +
> +       return sysfs_emit(buf, "0x%x\n",
> +                         entry_attr->entry->dev->cbmem_entry.id);
> +}
> +
> +static int cbmem_entry_setup(struct cbmem_entry *entry)
> +{
> +       int ret;
> +
> +       entry->mem_file_buf =
> +               devm_memremap(&entry->dev->dev, entry->dev->cbmem_entry.address,
> +                             entry->dev->cbmem_entry.entry_size, MEMREMAP_WB);

I suspect this won't work because the driver can be unbound, and thus
the mapping can be destroyed by devm, but then the kobject and sysfs
file like 'mem' can be held by userspace after the driver is unbound.
Userspace access after that time will try to read/write unmapped memory.

> +       if (!entry->mem_file_buf)
> +               return -ENOMEM;
> +
> +       entry->kobj_name = devm_kasprintf(&entry->dev->dev, GFP_KERNEL,
> +                                         "cbmem-%08x",
> +                                         entry->dev->cbmem_entry.id);
> +       if (!entry->kobj_name)
> +               return -ENOMEM;
> +
> +       entry->kobj = kobject_create_and_add(entry->kobj_name, coreboot_kobj);
> +       if (!entry->kobj)
> +               return -ENOMEM;
> +
> +       sysfs_bin_attr_init(&entry->mem_file);
> +       entry->mem_file.attr.name = "mem";
> +       entry->mem_file.attr.mode = 0664;
> +       entry->mem_file.size = entry->dev->cbmem_entry.entry_size;
> +       entry->mem_file.read = cbmem_entry_mem_read;
> +       entry->mem_file.write = cbmem_entry_mem_write;
> +       entry->mem_file.private = entry;
> +       ret = sysfs_create_bin_file(entry->kobj, &entry->mem_file);
> +       if (ret)
> +               goto free_kobj;
> +
> +       sysfs_attr_init(&entry->address_file.kobj_attr.attr);
> +       entry->address_file.kobj_attr.attr.name = "address";
> +       entry->address_file.kobj_attr.attr.mode = 0444;
> +       entry->address_file.kobj_attr.show = cbmem_entry_address_show;
> +       entry->address_file.entry = entry;
> +       ret = sysfs_create_file(entry->kobj,
> +                               &entry->address_file.kobj_attr.attr);
> +       if (ret)
> +               goto free_mem_file;
> +
> +       sysfs_attr_init(&entry->size_file.kobj_attr.attr);
> +       entry->size_file.kobj_attr.attr.name = "size";
> +       entry->size_file.kobj_attr.attr.mode = 0444;
> +       entry->size_file.kobj_attr.show = cbmem_entry_size_show;
> +       entry->size_file.entry = entry;
> +       ret = sysfs_create_file(entry->kobj, &entry->size_file.kobj_attr.attr);
> +       if (ret)
> +               goto free_address_file;
> +
> +       sysfs_attr_init(&entry->id_file.kobj_attr.attr);
> +       entry->id_file.kobj_attr.attr.name = "id";
> +       entry->id_file.kobj_attr.attr.mode = 0444;
> +       entry->id_file.kobj_attr.show = cbmem_entry_id_show;
> +       entry->id_file.entry = entry;
> +       ret = sysfs_create_file(entry->kobj, &entry->id_file.kobj_attr.attr);
> +       if (ret)
> +               goto free_size_file;
> +
> +       return 0;
> +
> +free_size_file:
> +       sysfs_remove_file(entry->kobj, &entry->size_file.kobj_attr.attr);
> +free_address_file:
> +       sysfs_remove_file(entry->kobj, &entry->address_file.kobj_attr.attr);
> +free_mem_file:
> +       sysfs_remove_bin_file(entry->kobj, &entry->mem_file);
> +free_kobj:
> +       kobject_put(entry->kobj);
> +       return ret;
> +}
> +
> +static int cbmem_entry_probe(struct coreboot_device *dev)
> +{
> +       struct cbmem_entry *entry;
> +
> +       entry = devm_kzalloc(&dev->dev, sizeof(*entry), GFP_KERNEL);
> +       if (!entry)
> +               return -ENOMEM;
> +
> +       dev_set_drvdata(&dev->dev, entry);
> +       entry->dev = dev;
> +       return cbmem_entry_setup(entry);
> +}
> +
> +static void cbmem_entry_remove(struct coreboot_device *dev)
> +{
> +       struct cbmem_entry *entry = dev_get_drvdata(&dev->dev);
> +
> +       sysfs_remove_bin_file(entry->kobj, &entry->mem_file);
> +       sysfs_remove_file(entry->kobj, &entry->address_file.kobj_attr.attr);
> +       sysfs_remove_file(entry->kobj, &entry->size_file.kobj_attr.attr);
> +       sysfs_remove_file(entry->kobj, &entry->id_file.kobj_attr.attr);
> +       kobject_put(entry->kobj);
> +}
> +
> +static struct coreboot_driver cbmem_entry_driver = {
> +       .probe = cbmem_entry_probe,
> +       .remove = cbmem_entry_remove,
> +       .drv = {
> +               .name = "cbmem",
> +       },
> +       .tag = LB_TAG_CBMEM_ENTRY,
> +};
> +
> +static int __init cbmem_init(void)
> +{
> +       int ret;
> +
> +       coreboot_kobj = kobject_create_and_add("coreboot", firmware_kobj);

Why not make this in the bus driver (coreboot-table.c)? In fact, most
things could probably be created there instead of in a 'driver' that
really isn't doing much 'driving' at all.

> +       if (!coreboot_kobj)
> +               return -ENOMEM;
> +
> +       ret = coreboot_driver_register(&cbmem_entry_driver);
> +       if (ret) {
> +               kobject_put(coreboot_kobj);
