Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60BA4E5BD8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 00:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346098AbiCWXf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 19:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346045AbiCWXfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 19:35:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6675390FDA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 16:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648078419; x=1679614419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kflzhk6cKRrHhEv2QAKqCRuyoY+8IdX0Nrn9UYyu+9Q=;
  b=muLfe4o5rDsxPFKPeXOz8hbO5CctM7gD8JWKt0v5r1KTmGq7JcVG0SOu
   4MsFJUGTinsMDbO9j8erNrxodiPcyI+qt6ecei+cOsMhvurpHjq6t9MyB
   3HFa6Kai3BY55rc+NDJezrb0Kyjme99nDiVgtPqkgB5vzMZWxvb/AtP2I
   CnMuVFh/CLdAgwoB4TUXXs+I/C2r2cb1CHRL5dy9fpkBTcji6sYG/OPtl
   M+kg0rg3LtH9Lv366jHOIDB/+I/VOrTWGE/H6XiFlFNAc3QWxnnYbWf3q
   CBGt+MKLyRzkI80N3V6ehsEdiP/LNAVEXgMXbyW1Eo/+35w0+vy6c5RFN
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="258202360"
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="258202360"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 16:33:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="583880288"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.212.130.166])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 16:33:38 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [RESEND PATCH v1 5/8] firmware_loader: Add sysfs nodes to monitor fw_upload
Date:   Wed, 23 Mar 2022 16:33:28 -0700
Message-Id: <20220323233331.155121-6-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220323233331.155121-1-russell.h.weight@intel.com>
References: <20220323233331.155121-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add additional sysfs nodes to monitor the transfer of firmware upload data
to the target device:

cancel: Write 1 to cancel the data transfer
error: Display error status for a failed firmware upload
remaining_size: Display the remaining amount of data to be transferred
status: Display the progress of the firmware upload

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v1:
  - Adapted to enums and filename changes. Otherwise no changes.
---
 .../ABI/testing/sysfs-class-firmware          |  45 +++++++
 .../driver-api/firmware/fw_upload.rst         |  19 ++-
 drivers/base/firmware_loader/sysfs.c          |   9 ++
 drivers/base/firmware_loader/sysfs_upload.c   | 121 ++++++++++++++++++
 drivers/base/firmware_loader/sysfs_upload.h   |   5 +
 5 files changed, 198 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-firmware b/Documentation/ABI/testing/sysfs-class-firmware
index a2e518f0bf8a..5653cb2d6e23 100644
--- a/Documentation/ABI/testing/sysfs-class-firmware
+++ b/Documentation/ABI/testing/sysfs-class-firmware
@@ -10,6 +10,30 @@ Description:	The data sysfs file is used for firmware-fallback and for
 		signal the lower-level driver that the firmware data is
 		available.
 
+What: 		/sys/class/firmware/.../cancel
+Date:		Mar 2022
+KernelVersion:	5.18
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Write-only. For firmware uploads, write a "1" to this file to
+		request that the transfer of firmware data to the lower-level
+		device be canceled. This request will be rejected (EBUSY) if
+		the update cannot be canceled (e.g. a FLASH write is in
+		progress) or (ENODEV) if there is no firmware update in progress.
+
+What: 		/sys/class/firmware/.../error
+Date:		Mar 2022
+KernelVersion:	5.18
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read-only. Returns a string describing a failed firmware
+		upload. This string will be in the form of <STATUS>:<ERROR>,
+		where <STATUS> will be one of the status strings described
+		for the status sysfs file and <ERROR> will be one of the
+		following: "hw-error", "timeout", "user-abort", "device-busy",
+		"invalid-file-size", "read-write-error", "flash-wearout". The
+		error sysfs file is only meaningful when the current firmware
+		upload status is "idle". If this file is read while a firmware
+		transfer is in progress, then the read will fail with EBUSY.
+
 What: 		/sys/class/firmware/.../loading
 Date:		Mar 2022
 KernelVersion:	5.18
@@ -22,6 +46,27 @@ Description:	The loading sysfs file is used for both firmware-fallback and
 		uploads, the zero value also triggers the transfer of the
 		firmware data to the lower-level device driver.
 
+What: 		/sys/class/firmware/.../remaining_size
+Date:		Mar 2022
+KernelVersion:	5.18
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read-only. For firmware upload, this file contains the size
+		of the firmware data that remains to be transferred to the
+		lower-level device driver. The size value is initialized to
+		the full size of the firmware image that was previously
+		written to the data sysfs file. This value is periodically
+		updated during the "transferring" phase of the firmware
+		upload.
+		Format: "%u".
+
+What: 		/sys/class/firmware/.../status
+Date:		Mar 2022
+KernelVersion:	5.18
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read-only. Returns a string describing the current status of
+		a firmware upload. The string will be one of the following:
+		idle, "receiving", "preparing", "transferring", "programming".
+
 What: 		/sys/class/firmware/.../timeout
 Date:		Mar 2022
 KernelVersion:	5.18
diff --git a/Documentation/driver-api/firmware/fw_upload.rst b/Documentation/driver-api/firmware/fw_upload.rst
index 2aaac9c70e41..00c8e19d99b7 100644
--- a/Documentation/driver-api/firmware/fw_upload.rst
+++ b/Documentation/driver-api/firmware/fw_upload.rst
@@ -9,7 +9,8 @@ persistent sysfs nodes to enable users to initiate firmware updates for
 that device.  It is the responsibility of the device driver and/or the
 device itself to perform any validation on the data received. Firmware
 upload uses the same *loading* and *data* sysfs files described in the
-documentation for firmware fallback.
+documentation for firmware fallback. It also adds additional sysfs files
+to provide status on the transfer of the firmware image to the device.
 
 Register for firmware upload
 ============================
@@ -98,3 +99,19 @@ failure:
 
 .. kernel-doc:: include/linux/firmware.h
    :identifiers: fw_upload_err
+
+Sysfs Attributes
+================
+
+In addition to the *loading* and *data* sysfs files, there are additional
+sysfs files to monitor the status of the data transfer to the target
+device and to determine the final pass/fail status of the transfer.
+Depending on the device and the size of the firmware image, a firmware
+update could take milliseconds or minutes.
+
+The additional sysfs files are:
+
+* status - provides an indication of the progress of a firmware update
+* error - provides error information for a failed firmware update
+* remaining_size - tracks the data transfer portion of an update
+* cancel - echo 1 to this file to cancel the update
diff --git a/drivers/base/firmware_loader/sysfs.c b/drivers/base/firmware_loader/sysfs.c
index 4beb0685d90a..dbfb61e144be 100644
--- a/drivers/base/firmware_loader/sysfs.c
+++ b/drivers/base/firmware_loader/sysfs.c
@@ -381,6 +381,12 @@ static struct bin_attribute firmware_attr_data = {
 
 static struct attribute *fw_dev_attrs[] = {
 	&dev_attr_loading.attr,
+#ifdef CONFIG_FW_UPLOAD
+	&dev_attr_cancel.attr,
+	&dev_attr_status.attr,
+	&dev_attr_error.attr,
+	&dev_attr_remaining_size.attr,
+#endif
 	NULL
 };
 
@@ -392,6 +398,9 @@ static struct bin_attribute *fw_dev_bin_attrs[] = {
 static const struct attribute_group fw_dev_attr_group = {
 	.attrs = fw_dev_attrs,
 	.bin_attrs = fw_dev_bin_attrs,
+#ifdef CONFIG_FW_UPLOAD
+	.is_visible = fw_upload_is_visible,
+#endif
 };
 
 static const struct attribute_group *fw_dev_attr_groups[] = {
diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
index 4c24f50d57e0..0b308fff65a9 100644
--- a/drivers/base/firmware_loader/sysfs_upload.c
+++ b/drivers/base/firmware_loader/sysfs_upload.c
@@ -11,6 +11,127 @@
  * Support for user-space to initiate a firmware upload to a device.
  */
 
+static const char * const fw_upload_prog_str[] = {
+	[FW_UPLOAD_PROG_IDLE]	      = "idle",
+	[FW_UPLOAD_PROG_RECEIVING]    = "receiving",
+	[FW_UPLOAD_PROG_PREPARING]    = "preparing",
+	[FW_UPLOAD_PROG_TRANSFERRING] = "transferring",
+	[FW_UPLOAD_PROG_PROGRAMMING]  = "programming"
+};
+
+static const char * const fw_upload_err_str[] = {
+	[FW_UPLOAD_ERR_NONE]	     = "none",
+	[FW_UPLOAD_ERR_HW_ERROR]     = "hw-error",
+	[FW_UPLOAD_ERR_TIMEOUT]	     = "timeout",
+	[FW_UPLOAD_ERR_CANCELED]     = "user-abort",
+	[FW_UPLOAD_ERR_BUSY]	     = "device-busy",
+	[FW_UPLOAD_ERR_INVALID_SIZE] = "invalid-file-size",
+	[FW_UPLOAD_ERR_RW_ERROR]     = "read-write-error",
+	[FW_UPLOAD_ERR_WEAROUT]	     = "flash-wearout",
+};
+
+static const char *fw_upload_progress(struct device *dev,
+				      enum fw_upload_prog prog)
+{
+	const char *status = "unknown-status";
+
+	if (prog < FW_UPLOAD_PROG_MAX)
+		status = fw_upload_prog_str[prog];
+	else
+		dev_err(dev, "Invalid status during secure update: %d\n", prog);
+
+	return status;
+}
+
+static const char *fw_upload_error(struct device *dev,
+				   enum fw_upload_err err_code)
+{
+	const char *error = "unknown-error";
+
+	if (err_code < FW_UPLOAD_ERR_MAX)
+		error = fw_upload_err_str[err_code];
+	else
+		dev_err(dev, "Invalid error code during secure update: %d\n",
+			err_code);
+
+	return error;
+}
+
+static ssize_t
+status_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct fw_upload_priv *fwlp = to_fw_sysfs(dev)->fw_upload_priv;
+
+	return sysfs_emit(buf, "%s\n", fw_upload_progress(dev, fwlp->progress));
+}
+DEVICE_ATTR_RO(status);
+
+static ssize_t
+error_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct fw_upload_priv *fwlp = to_fw_sysfs(dev)->fw_upload_priv;
+	int ret;
+
+	mutex_lock(&fwlp->lock);
+
+	if (fwlp->progress != FW_UPLOAD_PROG_IDLE)
+		ret = -EBUSY;
+	else if (!fwlp->err_code)
+		ret = 0;
+	else
+		ret = sysfs_emit(buf, "%s:%s\n",
+				 fw_upload_progress(dev, fwlp->err_progress),
+				 fw_upload_error(dev, fwlp->err_code));
+
+	mutex_unlock(&fwlp->lock);
+
+	return ret;
+}
+DEVICE_ATTR_RO(error);
+
+static ssize_t cancel_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct fw_upload_priv *fwlp = to_fw_sysfs(dev)->fw_upload_priv;
+	int ret = count;
+	bool cancel;
+
+	if (kstrtobool(buf, &cancel) || !cancel)
+		return -EINVAL;
+
+	mutex_lock(&fwlp->lock);
+	if (fwlp->progress == FW_UPLOAD_PROG_IDLE)
+		ret = -ENODEV;
+
+	fwlp->ops->cancel(fwlp->fw_upload);
+	mutex_unlock(&fwlp->lock);
+
+	return ret;
+}
+DEVICE_ATTR_WO(cancel);
+
+static ssize_t remaining_size_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct fw_upload_priv *fwlp = to_fw_sysfs(dev)->fw_upload_priv;
+
+	return sysfs_emit(buf, "%u\n", fwlp->remaining_size);
+}
+DEVICE_ATTR_RO(remaining_size);
+
+umode_t
+fw_upload_is_visible(struct kobject *kobj, struct attribute *attr, int n)
+{
+	static struct fw_sysfs *fw_sysfs;
+
+	fw_sysfs = to_fw_sysfs(kobj_to_dev(kobj));
+
+	if (fw_sysfs->fw_upload_priv || attr == &dev_attr_loading.attr)
+		return attr->mode;
+
+	return 0;
+}
+
 static void fw_upload_update_progress(struct fw_upload_priv *fwlp,
 				      enum fw_upload_prog new_progress)
 {
diff --git a/drivers/base/firmware_loader/sysfs_upload.h b/drivers/base/firmware_loader/sysfs_upload.h
index ca923265c62c..9afb1cfbc6f6 100644
--- a/drivers/base/firmware_loader/sysfs_upload.h
+++ b/drivers/base/firmware_loader/sysfs_upload.h
@@ -30,6 +30,11 @@ struct fw_upload_priv {
 };
 
 #ifdef CONFIG_FW_UPLOAD
+extern struct device_attribute dev_attr_status;
+extern struct device_attribute dev_attr_error;
+extern struct device_attribute dev_attr_cancel;
+extern struct device_attribute dev_attr_remaining_size;
+
 int fw_upload_start(struct fw_sysfs *fw_sysfs);
 umode_t fw_upload_is_visible(struct kobject *kobj, struct attribute *attr, int n);
 #else
-- 
2.25.1

