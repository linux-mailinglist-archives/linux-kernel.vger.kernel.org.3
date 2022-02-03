Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E994A8FF7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355258AbiBCVbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:31:11 -0500
Received: from mga05.intel.com ([192.55.52.43]:32987 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355268AbiBCVbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:31:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643923862; x=1675459862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b7dA0pgbMDSo/rSorsW/TYdkkYsDnUBgHm+Mb/VkKvo=;
  b=BzZyJ3OW7R8GY5r+8ZfHN/2HRWFnWdedw4gmBlpuglflK50N8ZpOc79v
   x5+dIWVgDD+H7t3/ufupGAtEtpW30jSAJLjryxkPOSzLVXYENI1q7D0uL
   t8KAht7594QOGV/KShDU7B1QRqD1ithIDtSYVSDDaR/LvTjrH+D/MeK+t
   wJpTwQYM2Hzt3Di2NpSK6l1YQUV47MwMkALKVk7bEA1pvwcFtOltfVuDm
   SGj83x6JarcaubVnZ8XSGZft/Q0yLSY157TDiXjL/uov0MAbcOrOI8Nie
   trAqt+6NMTDWHA7+MPjaY4Vi/igtqt65YAmJJCOqjkLRpkpcYQGStreTT
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="334634004"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="334634004"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 13:31:02 -0800
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="583931543"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.209.6.75])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 13:31:01 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [RFC PATCH 4/5] firmware_loader: Add firmware-upload support
Date:   Thu,  3 Feb 2022 14:30:51 -0700
Message-Id: <20220203213053.360190-5-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220203213053.360190-1-russell.h.weight@intel.com>
References: <20220203213053.360190-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the firmware subsystem to support a persistent sysfs interface that
userspace may use to initiate a firmware update. For example, FPGA based
PCIe cards load firmware and FPGA images from local FLASH when the card
boots. The images in FLASH may be updated with new images provided by the
user at his/her convenience.

A device driver may call fw_upload_register() to expose persistent
"loading" and "data" sysfs files. These files are used in the same way as
the fallback sysfs "loading" and "data" files. When 0 is written to
"loading" to complete the write of firmware data, the data is transferred
to the lower-level driver using pre-registered call-back functions. The
data transfer is done in the context of a kernel worker thread.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
 .../ABI/testing/sysfs-class-firmware          |  32 +++
 .../driver-api/firmware/fw_upload.rst         |  86 +++++++
 Documentation/driver-api/firmware/index.rst   |   1 +
 drivers/base/firmware_loader/Kconfig          |  14 ++
 drivers/base/firmware_loader/Makefile         |   1 +
 drivers/base/firmware_loader/firmware.h       |   6 +
 drivers/base/firmware_loader/fw_sysfs.c       |  50 +++-
 drivers/base/firmware_loader/fw_sysfs.h       |   4 +
 drivers/base/firmware_loader/fw_upload.c      | 229 ++++++++++++++++++
 drivers/base/firmware_loader/fw_upload.h      |  24 ++
 drivers/base/firmware_loader/main.c           |  16 +-
 include/linux/firmware.h                      |  72 ++++++
 12 files changed, 523 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-firmware
 create mode 100644 Documentation/driver-api/firmware/fw_upload.rst
 create mode 100644 drivers/base/firmware_loader/fw_upload.c
 create mode 100644 drivers/base/firmware_loader/fw_upload.h

diff --git a/Documentation/ABI/testing/sysfs-class-firmware b/Documentation/ABI/testing/sysfs-class-firmware
new file mode 100644
index 000000000000..a2e518f0bf8a
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-firmware
@@ -0,0 +1,32 @@
+What: 		/sys/class/firmware/.../data
+Date:		Mar 2022
+KernelVersion:	5.18
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	The data sysfs file is used for firmware-fallback and for
+		firmware uploads. Cat a firmware image to this sysfs file
+		after you echo 1 to the loading sysfs file. When the firmware
+		image write is complete, echo 0 to the loading sysfs file. This
+		sequence will signal the completion of the firmware write and
+		signal the lower-level driver that the firmware data is
+		available.
+
+What: 		/sys/class/firmware/.../loading
+Date:		Mar 2022
+KernelVersion:	5.18
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	The loading sysfs file is used for both firmware-fallback and
+		for firmware uploads. Echo 1 onto the loading file to indicate
+		you are writing a firmware file to the data sysfs node. Echo
+		-1 onto this file to abort the data write or echo 0 onto this
+		file to indicate that the write is complete. For firmware
+		uploads, the zero value also triggers the transfer of the
+		firmware data to the lower-level device driver.
+
+What: 		/sys/class/firmware/.../timeout
+Date:		Mar 2022
+KernelVersion:	5.18
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	This file supports the timeout mechanism for firmware
+		fallback.  This file has no affect on firmware uploads. For
+		more information on timeouts please see the documentation
+		for firmware fallback.
diff --git a/Documentation/driver-api/firmware/fw_upload.rst b/Documentation/driver-api/firmware/fw_upload.rst
new file mode 100644
index 000000000000..bf272f627a1f
--- /dev/null
+++ b/Documentation/driver-api/firmware/fw_upload.rst
@@ -0,0 +1,86 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
+fw_upload API
+=============
+
+A device driver that registers with the firmware loader will expose
+persistent sysfs nodes to enable users to initiate firmware updates for
+that device.  It is the responsibility of the device driver and/or the
+device itself to perform any validation on the data received. Firmware
+upload uses the same *loading* and *data* sysfs files described in the
+documentation for firmware fallback.
+
+Register for firmware upload
+============================
+
+A device driver registers for firmware upload by calling fw_upload_register().
+Among the parameter list is a name to identify the device under
+/sys/class/firmware. A user may initiate a firmware upload by echoing
+a 1 to the *loading* sysfs file for the target device. Next, the user writes
+the firmware image to the *data* sysfs file. After writing the firmware
+data, the user echos 0 to the *loading* sysfs file to signal completion.
+Echoing 0 to *loading* also triggers the transfer of the firmware to the
+lower-lever device driver in the context of a kernel worker thread.
+
+To use the fw_upload API, write a driver that implements a set of ops. The
+probe function calls fw_upload_register() and the remove function calls
+fw_upload_unregister() such as::
+
+	static const struct fw_upload_ops m10bmc_ops = {
+		.prepare = m10bmc_sec_prepare,
+		.write = m10bmc_sec_write,
+		.poll_complete = m10bmc_sec_poll_complete,
+		.cancel = m10bmc_sec_cancel,
+		.cleanup = m10bmc_sec_cleanup,
+	};
+
+	static int m10bmc_sec_probe(struct platform_device *pdev)
+	{
+		const char *fw_name, *truncate;
+		struct m10bmc_sec *sec;
+		struct fw_upload *fwl;
+		unsigned int len;
+
+		sec = devm_kzalloc(&pdev->dev, sizeof(*sec), GFP_KERNEL);
+		if (!sec)
+			return -ENOMEM;
+
+		sec->dev = &pdev->dev;
+		sec->m10bmc = dev_get_drvdata(pdev->dev.parent);
+		dev_set_drvdata(&pdev->dev, sec);
+
+		fw_name = dev_name(sec->dev);
+		truncate = strstr(fw_name, ".auto");
+		len = (truncate) ? truncate - fw_name : strlen(fw_name);
+		sec->fw_name = kmemdup_nul(fw_name, len, GFP_KERNEL);
+
+		fwl = fw_upload_register(sec->dev, sec->fw_name, &m10bmc_ops, sec);
+		if (IS_ERR(fwl)) {
+			dev_err(sec->dev, "Firmware Upload driver failed to start\n");
+			kfree(sec->fw_name);
+			return PTR_ERR(fwl);
+		}
+
+		sec->fwl = fwl;
+		return 0;
+	}
+
+	static int m10bmc_sec_remove(struct platform_device *pdev)
+	{
+		struct m10bmc_sec *sec = dev_get_drvdata(&pdev->dev);
+
+		fw_upload_unregister(sec->fwl);
+		kfree(sec->fw_name);
+		return 0;
+	}
+
+fw_upload_register
+------------------
+.. kernel-doc:: drivers/base/firmware_loader/fw_upload.c
+   :functions: fw_upload_register
+
+fw_upload_unregister
+--------------------
+.. kernel-doc:: drivers/base/firmware_loader/fw_upload.c
+   :functions: fw_upload_unregister
diff --git a/Documentation/driver-api/firmware/index.rst b/Documentation/driver-api/firmware/index.rst
index 57415d657173..9d2c19dc8e36 100644
--- a/Documentation/driver-api/firmware/index.rst
+++ b/Documentation/driver-api/firmware/index.rst
@@ -8,6 +8,7 @@ Linux Firmware API
    core
    efi/index
    request_firmware
+   fw_upload
    other_interfaces
 
 .. only::  subproject and html
diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
index 1bfe18900ed5..cee662f3277b 100644
--- a/drivers/base/firmware_loader/Kconfig
+++ b/drivers/base/firmware_loader/Kconfig
@@ -185,5 +185,19 @@ config FW_CACHE
 
 	  If unsure, say Y.
 
+config FW_UPLOAD
+	bool "Enable users to initiate firmware updates using sysfs"
+	select FW_LOADER_SYSFS
+	select FW_LOADER_PAGED_BUF
+	help
+	  Enabling this option will allow device drivers to expose a persistent
+	  sysfs interface that allows firmware updates to be initiated from
+	  userspace. For example, FPGA based PCIe cards load firmware and FPGA
+	  images from local FLASH when the card boots. The images in FLASH may
+	  be updated with new images provided by the user. Enable this device
+	  to support cards that rely on user-initiated updates for firmware files.
+
+	  If unsure, say N.
+
 endif # FW_LOADER
 endmenu
diff --git a/drivers/base/firmware_loader/Makefile b/drivers/base/firmware_loader/Makefile
index 787c833d0c6e..52ef64bd9357 100644
--- a/drivers/base/firmware_loader/Makefile
+++ b/drivers/base/firmware_loader/Makefile
@@ -7,5 +7,6 @@ firmware_class-objs := main.o
 firmware_class-$(CONFIG_FW_LOADER_USER_HELPER) += fallback.o
 firmware_class-$(CONFIG_EFI_EMBEDDED_FIRMWARE) += fallback_platform.o
 firmware_class-$(CONFIG_FW_LOADER_SYSFS) += fw_sysfs.o
+firmware_class-$(CONFIG_FW_UPLOAD) += fw_upload.o
 
 obj-y += builtin/
diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index 58768d16f8df..4019f9423de8 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -87,6 +87,7 @@ struct fw_priv {
 };
 
 extern struct mutex fw_lock;
+extern struct firmware_cache fw_cache;
 
 static inline bool __fw_state_check(struct fw_priv *fw_priv,
 				    enum fw_status status)
@@ -154,7 +155,12 @@ static inline bool fw_state_is_done(struct fw_priv *fw_priv)
 	return __fw_state_check(fw_priv, FW_STATUS_DONE);
 }
 
+int alloc_lookup_fw_priv(const char *fw_name, struct firmware_cache *fwc,
+			 struct fw_priv **fw_priv, void *dbuf, size_t size,
+			 size_t offset, u32 opt_flags);
 int assign_fw(struct firmware *fw, struct device *device);
+void free_fw_priv(struct fw_priv *fw_priv);
+void fw_state_init(struct fw_priv *fw_priv);
 
 #ifdef CONFIG_FW_LOADER
 bool firmware_is_builtin(const struct firmware *fw);
diff --git a/drivers/base/firmware_loader/fw_sysfs.c b/drivers/base/firmware_loader/fw_sysfs.c
index 70cb1d67ffb2..9b0cd37c81df 100644
--- a/drivers/base/firmware_loader/fw_sysfs.c
+++ b/drivers/base/firmware_loader/fw_sysfs.c
@@ -6,8 +6,8 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 
-#include "firmware.h"
 #include "fw_sysfs.h"
+#include "fw_upload.h"
 
 /*
  * sysfs support for firmware loader
@@ -80,6 +80,10 @@ static void fw_dev_release(struct device *dev)
 {
 	struct fw_sysfs *fw_sysfs = to_fw_sysfs(dev);
 
+	if (fw_sysfs->fw_upload_priv) {
+		free_fw_priv(fw_sysfs->fw_priv);
+		kfree(fw_sysfs->fw_upload_priv);
+	}
 	kfree(fw_sysfs);
 }
 
@@ -165,6 +169,9 @@ static ssize_t firmware_loading_store(struct device *dev,
 				      const char *buf, size_t count)
 {
 	struct fw_sysfs *fw_sysfs = to_fw_sysfs(dev);
+#ifdef CONFIG_FW_UPLOAD
+	struct fw_upload_priv *fwlp;
+#endif
 	struct fw_priv *fw_priv;
 	ssize_t written = count;
 	int loading = simple_strtol(buf, NULL, 10);
@@ -211,6 +218,42 @@ static ssize_t firmware_loading_store(struct device *dev,
 				written = rc;
 			} else {
 				fw_state_done(fw_priv);
+
+#ifdef CONFIG_FW_UPLOAD
+				/*
+				 * For fw_uploads, start a worker thread to upload
+				 * data to the parent driver.
+				 */
+				if (!fw_sysfs->fw_upload_priv)
+					break;
+
+				if (!fw_priv->size) {
+					fw_free_paged_buf(fw_priv);
+					fw_state_init(fw_sysfs->fw_priv);
+					break;
+				}
+
+				fwlp = fw_sysfs->fw_upload_priv;
+				mutex_lock(&fwlp->lock);
+
+				/* Do not interfere an on-going fw_upload */
+				if (fwlp->progress != FW_UPLOAD_PROG_IDLE) {
+					mutex_unlock(&fwlp->lock);
+					written = -EBUSY;
+					goto out;
+				}
+
+				fwlp->progress = FW_UPLOAD_PROG_RECEIVING;
+				fwlp->err_code = 0;
+				fwlp->remaining_size = fw_priv->size;
+				fwlp->data = fw_priv->data;
+				pr_debug("%s: fw-%s fw_priv=%p data=%p size=%u\n",
+					 __func__, fw_priv->fw_name,
+					 fw_priv, fw_priv->data,
+					 (unsigned int)fw_priv->size);
+				queue_work(system_long_wq, &fwlp->work);
+				mutex_unlock(&fwlp->lock);
+#endif
 			}
 			break;
 		}
@@ -220,6 +263,9 @@ static ssize_t firmware_loading_store(struct device *dev,
 		fallthrough;
 	case -1:
 		fw_load_abort(fw_sysfs);
+		if (fw_sysfs->fw_upload_priv)
+			fw_state_init(fw_sysfs->fw_priv);
+
 		break;
 	}
 out:
@@ -227,7 +273,7 @@ static ssize_t firmware_loading_store(struct device *dev,
 	return written;
 }
 
-static DEVICE_ATTR(loading, 0644, firmware_loading_show, firmware_loading_store);
+DEVICE_ATTR(loading, 0644, firmware_loading_show, firmware_loading_store);
 
 static void firmware_rw_data(struct fw_priv *fw_priv, char *buffer,
 			     loff_t offset, size_t count, bool read)
diff --git a/drivers/base/firmware_loader/fw_sysfs.h b/drivers/base/firmware_loader/fw_sysfs.h
index 0ca7f72892b0..1aadc12244d7 100644
--- a/drivers/base/firmware_loader/fw_sysfs.h
+++ b/drivers/base/firmware_loader/fw_sysfs.h
@@ -4,7 +4,10 @@
 
 #include <linux/device.h>
 
+#include "firmware.h"
+
 extern struct firmware_fallback_config fw_fallback_config;
+extern struct device_attribute dev_attr_loading;
 
 #ifdef CONFIG_FW_LOADER_USER_HELPER
 /**
@@ -59,6 +62,7 @@ struct fw_sysfs {
 	struct device dev;
 	struct fw_priv *fw_priv;
 	struct firmware *fw;
+	void *fw_upload_priv;
 };
 
 static inline struct fw_sysfs *to_fw_sysfs(struct device *dev)
diff --git a/drivers/base/firmware_loader/fw_upload.c b/drivers/base/firmware_loader/fw_upload.c
new file mode 100644
index 000000000000..bf02c9f09fd2
--- /dev/null
+++ b/drivers/base/firmware_loader/fw_upload.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/firmware.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#include "fw_sysfs.h"
+#include "fw_upload.h"
+
+/*
+ * Support for user-space to initiate a firmware upload to a device.
+ */
+
+static void fw_upload_update_progress(struct fw_upload_priv *fwlp,
+				      u32 new_progress)
+{
+	mutex_lock(&fwlp->lock);
+	fwlp->progress = new_progress;
+	mutex_unlock(&fwlp->lock);
+}
+
+static void fw_upload_set_error(struct fw_upload_priv *fwlp, u32 err_code)
+{
+	mutex_lock(&fwlp->lock);
+	fwlp->err_progress = fwlp->progress;
+	fwlp->err_code = err_code;
+	mutex_unlock(&fwlp->lock);
+}
+
+static void fw_upload_prog_complete(struct fw_upload_priv *fwlp)
+{
+	mutex_lock(&fwlp->lock);
+	fwlp->progress = FW_UPLOAD_PROG_IDLE;
+	mutex_unlock(&fwlp->lock);
+}
+
+static void fw_upload_main(struct work_struct *work)
+{
+	struct fw_upload_priv *fwlp;
+	struct fw_sysfs *fw_sysfs;
+	struct fw_upload *fwl;
+	s32 ret, offset = 0;
+
+	fwlp = container_of(work, struct fw_upload_priv, work);
+	fwl = fwlp->fw_upload;
+	fw_sysfs = (struct fw_sysfs *)fwl->priv;
+
+	get_device(&fw_sysfs->dev);
+	if (!try_module_get(fw_sysfs->dev.parent->driver->owner)) {
+		fw_upload_set_error(fwlp, FW_UPLOAD_ERR_BUSY);
+		goto putdev_exit;
+	}
+
+	fw_upload_update_progress(fwlp, FW_UPLOAD_PROG_PREPARING);
+	ret = fwlp->ops->prepare(fwl, fwlp->data, fwlp->remaining_size);
+	if (ret) {
+		fw_upload_set_error(fwlp, ret);
+		goto modput_exit;
+	}
+
+	fw_upload_update_progress(fwlp, FW_UPLOAD_PROG_TRANSFERRING);
+	while (fwlp->remaining_size) {
+		ret = fwlp->ops->write(fwl, fwlp->data, offset,
+					fwlp->remaining_size);
+		if (ret <= 0) {
+			if (!ret) {
+				dev_warn(&fw_sysfs->dev,
+					 "write-op wrote zero data\n");
+				ret = -FW_UPLOAD_ERR_RW_ERROR;
+			}
+			fw_upload_set_error(fwlp, -ret);
+			goto done;
+		}
+
+		fwlp->remaining_size -= ret;
+		offset += ret;
+	}
+
+	fw_upload_update_progress(fwlp, FW_UPLOAD_PROG_PROGRAMMING);
+	ret = fwlp->ops->poll_complete(fwl);
+	if (ret)
+		fw_upload_set_error(fwlp, ret);
+
+done:
+	if (fwlp->ops->cleanup)
+		fwlp->ops->cleanup(fwl);
+
+modput_exit:
+	module_put(fw_sysfs->dev.parent->driver->owner);
+
+putdev_exit:
+	put_device(&fw_sysfs->dev);
+
+	/*
+	 * Note: fwlp->remaining_size is left unmodified here to provide
+	 * additional information on errors. It will be reinitialized when
+	 * the next firmeware upload begins.
+	 */
+	mutex_lock(&fw_lock);
+	fw_free_paged_buf(fw_sysfs->fw_priv);
+	fw_state_init(fw_sysfs->fw_priv);
+	mutex_unlock(&fw_lock);
+	fwlp->data = NULL;
+	fw_upload_prog_complete(fwlp);
+}
+
+/**
+ * fw_upload_register() - register for the firmware upload sysfs API
+ * @parent: parent device instantiating firmware upload
+ * @name: firmware name to be associated with this device
+ * @ops: pointer to structure of firmware upload ops
+ * @dd_handle: pointer to parent driver private data
+ *
+ *	@name must be unique among all users of firmware upload. The firmware
+ *	sysfs files for this device will be found at /sys/class/firmware/@name.
+ *
+ *	Return: struct fw_upload pointer or ERR_PTR()
+ *
+ **/
+struct fw_upload *
+fw_upload_register(struct device *parent, const char *name,
+		   const struct fw_upload_ops *ops, void *dd_handle)
+{
+	u32 opt_flags = FW_OPT_NOCACHE;
+	struct fw_upload *fw_upload;
+	struct fw_upload_priv *fw_upload_priv;
+	struct fw_sysfs *fw_sysfs;
+	struct fw_priv *fw_priv;
+	struct device *f_dev;
+	int ret;
+
+	__module_get(THIS_MODULE);
+
+	if (!name || name[0] == '\0')
+		return ERR_PTR(-EINVAL);
+
+	if (!ops || !ops->cancel || !ops->prepare ||
+	    !ops->write || !ops->poll_complete) {
+		dev_err(parent, "Attempt to register without all required ops\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	fw_upload = kzalloc(sizeof(*fw_upload), GFP_KERNEL);
+	if (!fw_upload)
+		return ERR_PTR(-ENOMEM);
+
+	fw_upload_priv = kzalloc(sizeof(*fw_upload_priv), GFP_KERNEL);
+	if (!fw_upload_priv) {
+		ret = -ENOMEM;
+		goto free_fw_upload;
+	}
+
+	fw_upload_priv->fw_upload = fw_upload;
+	fw_upload_priv->ops = ops;
+	mutex_init(&fw_upload_priv->lock);
+	fw_upload_priv->name = name;
+	fw_upload_priv->err_code = 0;
+	fw_upload_priv->progress = FW_UPLOAD_PROG_IDLE;
+	INIT_WORK(&fw_upload_priv->work, fw_upload_main);
+	fw_upload->dd_handle = dd_handle;
+
+	fw_sysfs = fw_create_instance(NULL, name, parent, opt_flags);
+	if (IS_ERR(fw_sysfs)) {
+		ret = PTR_ERR(fw_sysfs);
+		goto free_fw_upload_priv;
+	}
+	fw_upload->priv = fw_sysfs;
+	fw_sysfs->fw_upload_priv = fw_upload_priv;
+	f_dev = &fw_sysfs->dev;
+
+	ret = alloc_lookup_fw_priv(name, &fw_cache, &fw_priv,  NULL, 0, 0,
+				   FW_OPT_NOCACHE);
+	if (ret != 0) {
+		if (ret > 0)
+			ret = -EINVAL;
+		goto free_fw_sysfs;
+	}
+	fw_sysfs->fw_priv = fw_priv;
+
+	ret = device_add(f_dev);
+	if (ret) {
+		dev_err(f_dev, "%s: device_register failed\n", __func__);
+		put_device(f_dev);
+		module_put(THIS_MODULE);
+		return ERR_PTR(ret);
+	}
+
+	return fw_upload;
+
+free_fw_sysfs:
+	kfree(fw_sysfs);
+
+free_fw_upload_priv:
+	kfree(fw_upload_priv);
+
+free_fw_upload:
+	kfree(fw_upload);
+
+	module_put(THIS_MODULE);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(fw_upload_register);
+
+/**
+ * fw_upload_unregister() - Unregister firmware upload interface
+ * @fw_upload: pointer to struct fw_upload
+ **/
+void fw_upload_unregister(struct fw_upload *fw_upload)
+{
+	struct fw_sysfs *fw_sysfs = fw_upload->priv;
+	struct fw_upload_priv *fw_upload_priv = fw_sysfs->fw_upload_priv;
+
+	mutex_lock(&fw_upload_priv->lock);
+	if (fw_upload_priv->progress == FW_UPLOAD_PROG_IDLE) {
+		mutex_unlock(&fw_upload_priv->lock);
+		goto unregister;
+	}
+
+	fw_upload_priv->ops->cancel(fw_upload);
+	mutex_unlock(&fw_upload_priv->lock);
+
+	/* Ensure lower-level device-driver is finished */
+	flush_work(&fw_upload_priv->work);
+
+unregister:
+	device_unregister(&fw_sysfs->dev);
+	module_put(THIS_MODULE);
+}
+EXPORT_SYMBOL_GPL(fw_upload_unregister);
diff --git a/drivers/base/firmware_loader/fw_upload.h b/drivers/base/firmware_loader/fw_upload.h
new file mode 100644
index 000000000000..c55ac4047d55
--- /dev/null
+++ b/drivers/base/firmware_loader/fw_upload.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __FIRMWARE_UPLOAD_H
+#define __FIRMWARE_UPLOAD_H
+
+#include <linux/device.h>
+
+struct fw_upload_priv {
+	struct fw_upload *fw_upload;
+	const char *name;
+	const struct fw_upload_ops *ops;
+	struct mutex lock;		/* protect data structure contents */
+	struct work_struct work;
+	const u8 *data;			/* pointer to update data */
+	u32 remaining_size;		/* size remaining to transfer */
+	u32 progress;
+	u32 err_progress;		/* progress at time of failure */
+	u32 err_code;			/* security manager error code */
+	bool driver_unload;
+};
+
+umode_t
+fw_upload_is_visible(struct kobject *kobj, struct attribute *attr, int n);
+
+#endif /* __FIRMWARE_UPLOAD_H */
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 2cc11d93753a..874a5ef31c56 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -91,9 +91,9 @@ static inline struct fw_priv *to_fw_priv(struct kref *ref)
  * guarding for corner cases a global lock should be OK */
 DEFINE_MUTEX(fw_lock);
 
-static struct firmware_cache fw_cache;
+struct firmware_cache fw_cache;
 
-static void fw_state_init(struct fw_priv *fw_priv)
+void fw_state_init(struct fw_priv *fw_priv)
 {
 	struct fw_state *fw_st = &fw_priv->fw_st;
 
@@ -163,13 +163,9 @@ static struct fw_priv *__lookup_fw_priv(const char *fw_name)
 }
 
 /* Returns 1 for batching firmware requests with the same name */
-static int alloc_lookup_fw_priv(const char *fw_name,
-				struct firmware_cache *fwc,
-				struct fw_priv **fw_priv,
-				void *dbuf,
-				size_t size,
-				size_t offset,
-				u32 opt_flags)
+int alloc_lookup_fw_priv(const char *fw_name, struct firmware_cache *fwc,
+			 struct fw_priv **fw_priv, void *dbuf, size_t size,
+			 size_t offset, u32 opt_flags)
 {
 	struct fw_priv *tmp;
 
@@ -224,7 +220,7 @@ static void __free_fw_priv(struct kref *ref)
 	kfree(fw_priv);
 }
 
-static void free_fw_priv(struct fw_priv *fw_priv)
+void free_fw_priv(struct fw_priv *fw_priv)
 {
 	struct firmware_cache *fwc = fw_priv->fwc;
 	spin_lock(&fwc->lock);
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index 3b057dfc8284..9b109f8ff627 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -17,6 +17,56 @@ struct firmware {
 	void *priv;
 };
 
+/* Update progress codes */
+#define FW_UPLOAD_PROG_IDLE		0
+#define FW_UPLOAD_PROG_RECEIVING	1
+#define FW_UPLOAD_PROG_PREPARING	2
+#define FW_UPLOAD_PROG_TRANSFERRING	3
+#define FW_UPLOAD_PROG_PROGRAMMING	4
+#define FW_UPLOAD_PROG_MAX		5
+
+/* Update error progress codes */
+#define FW_UPLOAD_ERR_HW_ERROR		1
+#define FW_UPLOAD_ERR_TIMEOUT		2
+#define FW_UPLOAD_ERR_CANCELED		3
+#define FW_UPLOAD_ERR_BUSY		4
+#define FW_UPLOAD_ERR_INVALID_SIZE	5
+#define FW_UPLOAD_ERR_RW_ERROR		6
+#define FW_UPLOAD_ERR_WEAROUT		7
+#define FW_UPLOAD_ERR_MAX		8
+
+struct fw_upload {
+	void *dd_handle; /* reference to parent driver */
+	void *priv;	 /* firmware loader private fields */
+};
+
+/**
+ * struct fw_upload_ops - device specific operations to support firmware upload
+ * @prepare:		  Required: Prepare secure update
+ * @write:		  Required: The write() op receives the remaining
+ *			  size to be written and must return the actual
+ *			  size written or a negative error code. The write()
+ *			  op will be called repeatedly until all data is
+ *			  written.
+ * @poll_complete:	  Required: Check for the completion of the
+ *			  HW authentication/programming process.
+ * @cancel:		  Required: Request cancellation of update. This op
+ *			  is called from the context of a different kernel
+ *			  thread, so race conditions need to be considered.
+ * @cleanup:		  Optional: Complements the prepare()
+ *			  function and is called at the completion
+ *			  of the update, on success or failure, if the
+ *			  prepare function succeeded.
+ */
+struct fw_upload_ops {
+	u32 (*prepare)(struct fw_upload *fw_upload, const u8 *data, u32 size);
+	s32 (*write)(struct fw_upload *fw_upload, const u8 *data,
+		     u32 offset, u32 size);
+	u32 (*poll_complete)(struct fw_upload *fw_upload);
+	void (*cancel)(struct fw_upload *fw_upload);
+	void (*cleanup)(struct fw_upload *fw_upload);
+};
+
 struct module;
 struct device;
 
@@ -112,6 +162,28 @@ static inline int request_partial_firmware_into_buf
 
 #endif
 
+#ifdef CONFIG_FW_UPLOAD
+
+struct fw_upload *
+fw_upload_register(struct device *parent, const char *name,
+		   const struct fw_upload_ops *ops, void *dd_handle);
+void fw_upload_unregister(struct fw_upload *fw_upload);
+
+#else
+
+static inline struct fw_upload *
+fw_upload_register(struct device *parent, const char *name,
+		   const struct fw_upload_ops *ops, void *dd_handle)
+{
+		return ERR_PTR(-EINVAL);
+}
+
+static inline void fw_upload_unregister(struct fw_upload *fw_upload)
+{
+}
+
+#endif
+
 int firmware_request_cache(struct device *device, const char *name);
 
 #endif
-- 
2.25.1

