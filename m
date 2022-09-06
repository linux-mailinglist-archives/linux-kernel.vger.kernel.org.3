Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BF45AF160
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbiIFRAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiIFQ7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:59:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C89515FCD
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:47:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C672A615BA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 16:47:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D836C433C1;
        Tue,  6 Sep 2022 16:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662482852;
        bh=cHKIr8FO43+rlWYKK3qyeLCAybVPqrMV+RuG3NzWnqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2ltlK0ifrq3B/2Aen64BRCHZpjRUayVK7Cyj9khEHOV+Uibcc47UGyyvZrmTy3aZ9
         xoDZiyjvnlFsNnlwKppDWKG4Kk18ilFplgl7c/IwdliD9MaN5QI+YU6NgfrgrSI4zl
         9FSouyxvAlLQd7tFMbPe+AEIZEBegfZS9o7KFz/o=
Date:   Tue, 6 Sep 2022 18:47:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Czerwacki, Eial" <eial.czerwacki@sap.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arsh, Leonid" <leonid.arsh@sap.com>,
        "Twaig, Oren" <oren.twaig@sap.com>,
        SAP vSMP Linux Maintainer <linux.vsmp@sap.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Eric Biggers <ebiggers@google.com>, Fei Li <fei1.li@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2] drivers/virt/vSMP: new driver
Message-ID: <Yxd5oc9/Bz32YFtu@kroah.com>
References: <PAXPR02MB731058B69D178E026C578BB481729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <YxdQLY3RWRRuFMKd@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxdQLY3RWRRuFMKd@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 03:50:37PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 25, 2022 at 06:24:02AM +0000, Czerwacki, Eial wrote:
> > --- /dev/null
> > +++ b/drivers/virt/vsmp/Kconfig
> > @@ -0,0 +1,11 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +config VSMP
> > +	tristate "vSMP Guest Support"
> > +	depends on SYS_HYPERVISOR && X86_64 && PCI
> > +	help
> > +	  Support for vSMP Guest Driver.
> > +
> > +	  This driver allows information gathering of data from the vSMP hypervisor when
> > +	  running on top of a vSMP-based hypervisor.
> > +
> > +	  If unsure, say no.
> 
> In wanting to test this out, I tried it but this depends line is wrong,
> you have to set SYS_HYPERVISOR, you can not depend on it otherwise your
> code will never be selected :(

Ok, based on the conversation happening on the staging list, I took a
look at the code here again and have deleted a ton of it and added a
framework for you to add some sysfs files in the hypervisor location,
but this is NOT where the device/board files go, that's a different
add-on patch on top of this.

Here's an updated patch, much smaller, and hopefully simpler to
understand and follow.  I didn't touch the Documentation/ABI/ entry, but
if you run this you should see 4 sysfs files, "version1-3" that just
print a single number, and "version_length" that does some i/o and gets
the length that you wanted to use in the past to show how to tie this
into the device-specific information (and not have any static
information.)

Feel free to build on this for your next submission.  And if you have
any questions about this, please let me know.

Note, I have only built this code, not tested it, for obvious reasons :)

thanks,

greg k-h

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

vSMP driver framework and dummy sysfs files

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/ABI/stable/sysfs-driver-vsmp |   5 +
 MAINTAINERS                                |   6 +
 drivers/virt/Kconfig                       |   2 +
 drivers/virt/Makefile                      |   2 +
 drivers/virt/vsmp/Kconfig                  |  12 +
 drivers/virt/vsmp/Makefile                 |   6 +
 drivers/virt/vsmp/vsmp.c                   | 294 +++++++++++++++++++++
 7 files changed, 327 insertions(+)
 create mode 100644 Documentation/ABI/stable/sysfs-driver-vsmp
 create mode 100644 drivers/virt/vsmp/Kconfig
 create mode 100644 drivers/virt/vsmp/Makefile
 create mode 100644 drivers/virt/vsmp/vsmp.c

diff --git a/Documentation/ABI/stable/sysfs-driver-vsmp b/Documentation/ABI/stable/sysfs-driver-vsmp
new file mode 100644
index 000000000000..18a0a62f40ed
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-driver-vsmp
@@ -0,0 +1,5 @@
+What:           /sys/hypervisor/vsmp/version
+Date:           Aug 2022
+Contact:        Eial Czerwacki <eial.czerwacki@sap.com>
+		linux-vsmp@sap.com
+Description:    Shows the full version of the vSMP hypervisor
diff --git a/MAINTAINERS b/MAINTAINERS
index d30f26e07cd3..ff5277853660 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21789,6 +21789,12 @@ F:	lib/test_printf.c
 F:	lib/test_scanf.c
 F:	lib/vsprintf.c
 
+VSMP GUEST DRIVER
+M:	Eial Czerwacki <eial.czerwacki@sap.com>
+M:	linux-vsmp@sap.com
+S:	Maintained
+F:	drivers/virt/vsmp
+
 VT1211 HARDWARE MONITOR DRIVER
 M:	Juerg Haefliger <juergh@gmail.com>
 L:	linux-hwmon@vger.kernel.org
diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index 87ef258cec64..9f283f476674 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -52,4 +52,6 @@ source "drivers/virt/coco/efi_secret/Kconfig"
 
 source "drivers/virt/coco/sev-guest/Kconfig"
 
+source "drivers/virt/vsmp/Kconfig"
+
 endif
diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
index 093674e05c40..159ba37cb471 100644
--- a/drivers/virt/Makefile
+++ b/drivers/virt/Makefile
@@ -11,3 +11,5 @@ obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
 obj-$(CONFIG_ACRN_HSM)		+= acrn/
 obj-$(CONFIG_EFI_SECRET)	+= coco/efi_secret/
 obj-$(CONFIG_SEV_GUEST)		+= coco/sev-guest/
+
+obj-$(CONFIG_VSMP)             += vsmp/
diff --git a/drivers/virt/vsmp/Kconfig b/drivers/virt/vsmp/Kconfig
new file mode 100644
index 000000000000..71eb06560a2a
--- /dev/null
+++ b/drivers/virt/vsmp/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VSMP
+	tristate "vSMP Guest Support"
+	depends on X86_64 && PCI
+	select SYS_HYPERVISOR
+	help
+	  Support for vSMP Guest Driver.
+
+	  This driver allows information gathering of data from the vSMP hypervisor when
+	  running on top of a vSMP-based hypervisor.
+
+	  If unsure, say no.
diff --git a/drivers/virt/vsmp/Makefile b/drivers/virt/vsmp/Makefile
new file mode 100644
index 000000000000..28240ea3f170
--- /dev/null
+++ b/drivers/virt/vsmp/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for vSMP Guest driver
+#
+
+obj-$(CONFIG_VSMP) = vsmp.o
diff --git a/drivers/virt/vsmp/vsmp.c b/drivers/virt/vsmp/vsmp.c
new file mode 100644
index 000000000000..2a3abf3c0b0b
--- /dev/null
+++ b/drivers/virt/vsmp/vsmp.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * vSMP driver
+ *
+ * (C) Copyright 2022 SAP SE
+ * (C) Copyright 2022 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+ */
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/kobject.h>
+#include <linux/pci.h>
+#include <linux/sysfs.h>
+
+// R/W ops handlers
+#define vsmp_read_reg32_from_cfg(dev, _reg_) \
+	((u32) vsmp_read_reg_from_cfg(dev, (_reg_), VSMP_CTL_REG_SIZE_32BIT))
+
+enum reg_size_type {
+	VSMP_CTL_REG_SIZE_8BIT = 0,
+	VSMP_CTL_REG_SIZE_16BIT,
+	VSMP_CTL_REG_SIZE_32BIT,
+	VSMP_CTL_REG_SIZE_64BIT
+};
+
+struct vsmp_dev {
+	void __iomem *cfg_addr;
+	struct kobject kobj;
+	struct pci_dev *pdev;
+};
+
+#define VSMP_VERSION_REG 0x0c
+
+/*
+ * Read a value from a specific register in the vSMP's device config space
+ */
+static u64 vsmp_read_reg_from_cfg(struct vsmp_dev *vdev, u64 reg, enum reg_size_type type)
+{
+	u64 ret_val;
+
+	switch (type) {
+	case VSMP_CTL_REG_SIZE_8BIT:
+		ret_val = readb(vdev->cfg_addr + reg);
+		break;
+
+	case VSMP_CTL_REG_SIZE_16BIT:
+		ret_val = readw(vdev->cfg_addr + reg);
+		break;
+
+	case VSMP_CTL_REG_SIZE_32BIT:
+		ret_val = readl(vdev->cfg_addr + reg);
+		break;
+
+	case VSMP_CTL_REG_SIZE_64BIT:
+		ret_val = readq(vdev->cfg_addr + reg);
+		break;
+
+	default:
+		dev_err(&vdev->pdev->dev, "Unsupported reg size type %d.\n", type);
+		ret_val = (u64) -EINVAL;
+	}
+
+	dev_dbg(&vdev->pdev->dev, "%s: read 0x%llx from reg 0x%llx of %d bits\n",
+		__func__, ret_val, reg, (type + 1) * 8);
+	return ret_val;
+}
+
+/*
+ * Read a buffer from the bar byte by byte for halt on
+ * null termination.
+ * Expected buffs are strings.
+ */
+static ssize_t read_buff_from_bar_in_bytes(char *out, u8 __iomem *buff, ssize_t len)
+{
+	u32 i;
+
+	for (i = 0; i < len; i++) {
+		out[i] = ioread8(&buff[i]);
+		if (!out[i])
+			break;
+	}
+
+	return i;
+}
+
+/*
+ * Read a buffer from a specific offset in a specific bar,
+ * maxed to a predefined len size-wise from the vSMP device
+ */
+static int vsmp_read_buff_from_bar(struct vsmp_dev *vdev, u8 bar, u32 offset,
+				   char *out, ssize_t len, bool halt_on_null)
+{
+	u8 __iomem *buff;
+	u64 bar_start = pci_resource_start(vdev->pdev, bar);
+	u32 bar_len = pci_resource_len(vdev->pdev, bar);
+	ssize_t actual_len = len;
+
+	/* incase of overflow, warn and use max len possible */
+	if ((offset + len) > bar_len) {
+		WARN_ON((offset + len) > actual_len);
+		actual_len = bar_len - offset;
+		dev_dbg(&vdev->pdev->dev, "%lu overflows bar len, using %ld len instead\n", len, actual_len);
+	}
+
+	buff = ioremap(bar_start + offset, actual_len);
+	if (!buff)
+		return -ENOMEM;
+
+	if (halt_on_null)
+		read_buff_from_bar_in_bytes(out, buff, len);
+	else
+		memcpy_fromio(out, buff, len);
+
+	iounmap(buff);
+
+	return 0;
+}
+
+/*
+ * Generic function to read from the bar
+ */
+/*
+ * This is the maximal possible length of the version which is a text string
+ * the real len is usually much smaller, thus the driver uses this once to read
+ * the version string and record it's actual len.
+ * From that point and on, the actual len will be used in each call.
+ */
+#define VERSION_MAX_LEN (1 << 19)
+
+/*
+ * Retrieve str in order to determine the proper length.
+ * This is the best way to maintain backwards compatibility with all
+ * vSMP versions.
+ */
+static ssize_t get_version_len(struct vsmp_dev *vdev)
+{
+	ssize_t len = 0;
+	u64 reg_val = vsmp_read_reg32_from_cfg(vdev, VSMP_VERSION_REG);
+	char *version_str = kzalloc(VERSION_MAX_LEN, GFP_KERNEL);
+
+	if (!version_str)
+		return len;
+
+	if (vsmp_read_reg32_from_cfg(vdev, VSMP_VERSION_REG) < 0) {
+		kfree(version_str);
+		dev_err(&vdev->pdev->dev, "Failed to read value of reg 0x%x\n", VSMP_VERSION_REG);
+		return len;
+	}
+
+	memset(version_str, 0, VERSION_MAX_LEN);
+	if (vsmp_read_buff_from_bar(vdev, 0, reg_val, version_str, VERSION_MAX_LEN, true)) {
+		kfree(version_str);
+		dev_err(&vdev->pdev->dev, "Failed to read buffer from bar\n");
+		return len;
+	}
+
+	len = strlen(version_str);
+	kfree(version_str);
+
+	return len;
+}
+
+static ssize_t version1_show(struct kobject *kobj,
+			     struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "1\n");
+}
+
+static ssize_t version2_show(struct kobject *kobj,
+			     struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "2\n");
+}
+
+static ssize_t version3_show(struct kobject *kobj,
+			     struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "3\n");
+}
+
+static ssize_t version_len_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	struct vsmp_dev *vdev = container_of(kobj, struct vsmp_dev, kobj);
+	int length;
+
+	length = (int)get_version_len(vdev);
+
+	return sysfs_emit(buf, "%d\n", length);
+}
+
+static struct kobj_attribute version1 = __ATTR_RO(version1);
+static struct kobj_attribute version2 = __ATTR_RO(version2);
+static struct kobj_attribute version3 = __ATTR_RO(version3);
+static struct kobj_attribute version_len = __ATTR_RO(version_len);
+
+static struct attribute *vsmp_attrs[] = {
+	&version1.attr,
+	&version2.attr,
+	&version3.attr,
+	&version_len.attr,
+};
+ATTRIBUTE_GROUPS(vsmp);
+
+static void vsmp_release(struct kobject *kobj)
+{
+	struct vsmp_dev *vdev = container_of(kobj, struct vsmp_dev, kobj);
+
+	kfree(vdev);
+}
+
+static ssize_t vsmp_show(struct kobject *kobj, struct attribute *attr, char *buf)
+{
+	struct kobj_attribute *kobj_attr;
+
+	kobj_attr = container_of(attr, struct kobj_attribute, attr);
+	return kobj_attr->show(kobj, kobj_attr, buf);
+}
+
+static const struct sysfs_ops vsmp_ops = {
+	.show		= vsmp_show,
+};
+
+static struct kobj_type vsmp_type = {
+	.release	= vsmp_release,
+	.sysfs_ops	= &vsmp_ops,
+	.default_groups	= vsmp_groups,
+};
+
+static int vsmp_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
+{
+	struct vsmp_dev *vdev;
+	u64 cfg_start;
+	u32 cfg_len;
+	int retval;
+
+	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
+	if (!vdev)
+		return -ENOMEM;
+
+	vdev->pdev = pci;
+
+	/*
+	 * Open the cfg address space of the vSDP device
+	 */
+	cfg_start = pci_resource_start(pci, 0);
+	cfg_len = pci_resource_len(pci, 0);
+
+	dev_dbg(&pci->dev, "Mapping bar 0: [0x%llx,0x%llx]\n", cfg_start, cfg_start + cfg_len);
+
+	vdev->cfg_addr = ioremap(cfg_start, cfg_len);
+	if (!vdev->cfg_addr) {
+		dev_err(&pci->dev, "Failed to map vSMP pci controller, exiting.\n");
+		kfree(vdev);
+		return -ENODEV;
+	}
+
+	pci_set_drvdata(pci, vdev);
+
+	retval = kobject_init_and_add(&vdev->kobj, &vsmp_type, hypervisor_kobj, "vsmp");
+	if (retval) {
+		kobject_put(&vdev->kobj);
+		dev_err(&vdev->pdev->dev, "Failed to create vSMP sysfs entry, exiting.\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void vsmp_pci_remove(struct pci_dev *pci)
+{
+	struct vsmp_dev *vdev = pci_get_drvdata(pci);
+
+	iounmap(vdev->cfg_addr);
+	kobject_del(&vdev->kobj);
+}
+
+#define PCI_DEVICE_ID_SAP_FLX_VSMP_CTL 0x1011
+static const struct pci_device_id vsmp_pci_table[] = {
+	{ PCI_VDEVICE(SCALEMP, PCI_DEVICE_ID_SAP_FLX_VSMP_CTL), 0, },
+	{ 0, },			/* terminate list */
+};
+
+static struct pci_driver vsmp_pci_driver = {
+	.name		= "vSMP",
+	.id_table	= vsmp_pci_table,
+	.probe		= vsmp_pci_probe,
+	.remove		= vsmp_pci_remove,
+};
+
+module_pci_driver(vsmp_pci_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Eial Czerwacki <eial.czerwacki@sap.com>");
+MODULE_DESCRIPTION("vSMP hypervisor driver");
-- 
2.37.3

