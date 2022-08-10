Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525F458E4B1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 03:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiHJBu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 21:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiHJBt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 21:49:57 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54257FE78
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 18:49:55 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-10d845dcf92so16128785fac.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 18:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc;
        bh=Ybj8vZxZYBpkkhEBS1SO/qE3n39ghM+YNCOIwdQkArs=;
        b=Uh5kxZxk/+qhtzi8xm1tpic0WHXDsx4tqCVTB/WDjdu5p9etWqIR5GBIgn7sl42kbo
         gQhMg6a2X7ZJRIrZPtbV9izSYmbSmAAr/p1T2B3L7SaIiKqJHWg5m71In7A1rIC7OSB8
         yDmVp2wiuShO5n8Kjd99hfONUfGqFIVoBMpuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc;
        bh=Ybj8vZxZYBpkkhEBS1SO/qE3n39ghM+YNCOIwdQkArs=;
        b=egooDHNkWlMdv4+DS9Bf2AXTOM2Wi5md1yyX6wYE8UuggCR82ATW/AkY+nlmSYxLxL
         jWkc+MVj40T0hK8K+TX1YMsMXLBD+qMOL2nNZOeUaqyQ8KZfHN7R4lZSjOm4fi7WaaVj
         7jh8aU2hLcQkuIyHsbARrFzET0vxRBhFHH5VvYasIhKSapJceOCVXGpXpWghaP4NPj0B
         uSa/Rm5chIiB0EQG2QtSrOdRf42Bog/gXV3sWgmX59kDebtWCW8UBgOzbPz/SIgV/aP7
         cSQaPjadva+kkTQYscWBEa1uChxhj7ucvEz3+jFCQw+Rcs1VmtpvCAJa16oP9HIFFs00
         4sGg==
X-Gm-Message-State: ACgBeo240BLaLfkMVTlYPjpgKC2FA9Lo9qZxNltepDytyPkj/U/26DTN
        ssFnpBw5w+Ed+0xHiYK9xlJaCwxnnbxwziRy4QZKLCyi3yQ=
X-Google-Smtp-Source: AA6agR4QvT43Qw5NEUKhpEW1c5llCPAHhiiLl94+zK/7mTOz4M/zpOh6WDcD1QzgKRRi2OuJgb5rnixRRbpBDrZPR3Q=
X-Received: by 2002:a05:6870:9a17:b0:e9:3d1:f91a with SMTP id
 fo23-20020a0568709a1700b000e903d1f91amr558560oab.44.1660096195049; Tue, 09
 Aug 2022 18:49:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Aug 2022 20:49:54 -0500
MIME-Version: 1.0
In-Reply-To: <20220806204857.3276448-1-jrosenth@chromium.org>
References: <20220806204857.3276448-1-jrosenth@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 9 Aug 2022 20:49:54 -0500
Message-ID: <CAE-0n53gc=1vwZbhGUaF2EyXotMPjqoQixUMJDidcs7vLmNORQ@mail.gmail.com>
Subject: Re: [PATCH v8] firmware: google: Implement cbmem in sysfs driver
To:     Jack Rosenthal <jrosenth@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jack Rosenthal (2022-08-06 13:48:57)
> cbmem entries can be read from coreboot table
> 0x31 (LB_TAG_CBMEM_ENTRY).  This commit exports access to cbmem
> entries in sysfs under /sys/firmware/coreboot/cbmem/<id>.

Why do we care? What problem are you solving? More details please!

I'm particularly nervous about exporting this through sysfs this way for
all cbmem entries. Is that really necessary, or can we expose the bare
minimum required data? If there were details on the why it would make
more sense to me. I read the bug but I really don't know what's going
on, sorry.

>
> Link: https://issuetracker.google.com/239604743
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Reviewed-by: Guenter Roeck <groeck@chromium.org>
> Reviewed-by: Julius Werner <jwerner@chromium.org>
> Tested-by: Jack Rosenthal <jrosenth@chromium.org>
> Signed-off-by: Jack Rosenthal <jrosenth@chromium.org>
> ---
> v8: Updated commit message.  Also re-sent as I mistakenly sent the
>     last round as v7, which I've already used that number.
>
> Changes:
>
> Updated based on review comments from Stephen Boyd:
>     - /sys/firmware/coreboot now created in coreboot_table.c
>     - Documentation for each sysfs file now split out into individual
>       sections.
>     - now /sys/firmware/coreboot/cbmem/<id>/ instead of
>           /sys/frimware/coreboot/cbmem-<id>/
>
>  .../ABI/testing/sysfs-firmware-coreboot       |  49 ++++
>  drivers/firmware/google/Kconfig               |   8 +
>  drivers/firmware/google/Makefile              |   3 +
>  drivers/firmware/google/cbmem.c               | 231 ++++++++++++++++++
>  drivers/firmware/google/coreboot_table.c      |  10 +
>  drivers/firmware/google/coreboot_table.h      |  16 ++
>  6 files changed, 317 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-firmware-coreboot
>  create mode 100644 drivers/firmware/google/cbmem.c
>
> diff --git a/Documentation/ABI/testing/sysfs-firmware-coreboot b/Documentation/ABI/testing/sysfs-firmware-coreboot
> new file mode 100644
> index 000000000000..02a0190d418f
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-firmware-coreboot
> @@ -0,0 +1,49 @@
> +What:          /sys/firmware/coreboot/
> +Date:          August 2022
> +Contact:       Jack Rosenthal <jrosenth@chromium.org>
> +Description:
> +               Kernel objects associated with the Coreboot-based BIOS firmware.
> +
> +What:          /sys/firmware/coreboot/cbmem/
> +Date:          August 2022
> +Contact:       Jack Rosenthal <jrosenth@chromium.org>
> +Description:
> +               Coreboot provides a variety of information in CBMEM.  This
> +               directory contains each CBMEM entry, which can be found via
> +               Coreboot tables.
> +
> +What:          /sys/firmware/coreboot/cbmem/<id>/
> +Date:          August 2022
> +Contact:       Jack Rosenthal <jrosenth@chromium.org>
> +Description:
> +               Each CBMEM entry is given a directory based on the id
> +               corresponding to the entry.  A list of ids known to coreboot can
> +               be found in the coreboot source tree at
> +               ``src/commonlib/bsd/include/commonlib/bsd/cbmem_id.h``.
> +
> +What:          /sys/firmware/coreboot/cbmem/<id>/address
> +Date:          August 2022
> +Contact:       Jack Rosenthal <jrosenth@chromium.org>
> +Description:
> +               The memory address that the CBMEM entry's data begins at.
> +
> +What:          /sys/firmware/coreboot/cbmem/<id>/size
> +Date:          August 2022
> +Contact:       Jack Rosenthal <jrosenth@chromium.org>
> +Description:
> +               The size of the data being stored.
> +
> +What:          /sys/firmware/coreboot/cbmem/<id>/id
> +Date:          August 2022
> +Contact:       Jack Rosenthal <jrosenth@chromium.org>
> +Description:
> +               The CBMEM id corresponding to the entry.
> +
> +What:          /sys/firmware/coreboot/cbmem/<id>/mem
> +Date:          August 2022
> +Contact:       Jack Rosenthal <jrosenth@chromium.org>
> +Description:
> +               A file exposing read/write memory access to the entry's data.
> +               Note that this file does not support mmap(), and should be used
> +               for basic data access only.  Users requiring mmap() should read
> +               the address and size files, and mmap() /dev/mem.
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

/sys/firmware/coreboot/cbmem?

> +
>  config GOOGLE_COREBOOT_TABLE
>         tristate "Coreboot Table Access"
>         depends on HAS_IOMEM && (ACPI || OF)
> diff --git a/drivers/firmware/google/cbmem.c b/drivers/firmware/google/cbmem.c
> new file mode 100644
> index 000000000000..6454dd5fa3fe
> --- /dev/null
> +++ b/drivers/firmware/google/cbmem.c
> @@ -0,0 +1,231 @@
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

What is used from this header?

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
> +static struct kobject *cbmem_kobj;
> +
> +struct cbmem_entry;
> +struct cbmem_entry_attr {
> +       struct kobj_attribute kobj_attr;
> +       struct cbmem_entry *entry;
> +};
> +
> +struct cbmem_entry {
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
> +       return sysfs_emit(buf, "0x%08x\n",
> +                         entry_attr->entry->dev->cbmem_entry.id);
> +}
> +
> +static int cbmem_entry_setup(struct cbmem_entry *entry)
> +{
> +       int ret;
> +       char *kobj_name;
> +
> +       entry->mem_file_buf =
> +               devm_memremap(&entry->dev->dev, entry->dev->cbmem_entry.address,
> +                             entry->dev->cbmem_entry.entry_size, MEMREMAP_WB);
> +       if (!entry->mem_file_buf)
> +               return -ENOMEM;
> +
> +       kobj_name = devm_kasprintf(&entry->dev->dev, GFP_KERNEL, "%08x",
> +                                  entry->dev->cbmem_entry.id);
> +       if (!kobj_name)
> +               return -ENOMEM;
> +
> +       entry->kobj = kobject_create_and_add(kobj_name, cbmem_kobj);
> +       if (!entry->kobj)
> +               return -ENOMEM;
> +
> +       sysfs_bin_attr_init(&entry->mem_file);
> +       entry->mem_file.attr.name = "mem";
> +       entry->mem_file.attr.mode = 0664;

Are all entries supposed to be writeable? Are there entries that are
read-only?

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

Is there a reason this isn't inlined here?

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

Need to set .owner = THIS_MODULE unless you use
module_coreboot_driver().

> +       },
> +       .tag = LB_TAG_CBMEM_ENTRY,
> +};
> +
> +static int __init cbmem_init(void)
> +{
> +       int ret;
> +
> +       cbmem_kobj = kobject_create_and_add("cbmem", coreboot_kobj);
> +       if (!coreboot_kobj)

cbmem_kobj?

> +               return -ENOMEM;
> +
> +       ret = coreboot_driver_register(&cbmem_entry_driver);
> +       if (ret) {
> +               kobject_put(cbmem_kobj);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +module_init(cbmem_init);
