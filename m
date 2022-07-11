Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2808B56FFED
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiGKLOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiGKLOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:14:33 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F49528A3;
        Mon, 11 Jul 2022 03:31:36 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 9-20020a1c0209000000b003a2dfdebe47so1947647wmc.3;
        Mon, 11 Jul 2022 03:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y6nO1L8s7IyD/npCLQlL4keFwQMorziso5OVidifAQ8=;
        b=dxD9QOzlUqFSTlsHGgDPturxgPDNV0CByPxlFK1dCqdFRHPEOCW8Ahc0uVZ0dTMF3M
         Am4tgZB3ouvj8kCDQtH6O1Dy9Z902BaosZDNgJ7P8BHfQgpjrBiZG2/5KGps4dkwiEvA
         H6rpe3LTLjNLaaI2vRnD2EFHnMOb0Iy6Z4372meteNby5gHP1DwAj0SoGIFtG69/ys97
         0Up3ddn8eemznlMo09XNCmBptMJ1Wguwvh3u3UHnsTxsA89KQ5hdi/YnfDQlwCZbD1vw
         a/SfcdDQ3VE7dWrxzjbkDDANbNYzbjsdAGJQFwInvKADp+FjSpvTtiy1stlMyV0UpzKg
         G+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y6nO1L8s7IyD/npCLQlL4keFwQMorziso5OVidifAQ8=;
        b=m9KfFbCs8e8gmMThxvHMwBUdfv7kHyf2XAd1n5ZCV5Vml4qMgN5OTk5HKt+t/kLIzl
         xfr1dr8j9/+LzpJ5YfjW/FhmSvloHHrGfXKA9n7pIUAERVPHYeb2oCl3eMsBAkofJ3sf
         vZC+8s+TuzyqZHv095sMjf67eoyjn1AP1mCw+64duPqypxmZQJAOJpej1nJGtrajhr7n
         5kS8lTQPVvkG94ELfwHgjmahA+lIrdvXJ8zXQMNltslSsVXGCIKYrb6NegVXRCtBhC20
         3Awlb0gulcYTKc2ki0qz0domBawJ/wmNtcaqAjES0MF8akyAj+x7WytylHIhryjzhMMZ
         R4Cw==
X-Gm-Message-State: AJIora+zk1UBwUmf4kZNbIjlN7a1Hqjq3njpMpt+qqOrU6EVMlPUmY4Y
        teaF8IAqFRb7a9o4HtZo6dhNgDm0pfJ9wg==
X-Google-Smtp-Source: AGRyM1ttWu5MZXSycXeMb3rTeyWab15Ra7b9fv6uNceRN4kZtLFwv9X/zPGDis1hGFl4tFt+L8xJkA==
X-Received: by 2002:a7b:c354:0:b0:39c:6753:21f8 with SMTP id l20-20020a7bc354000000b0039c675321f8mr15456738wmj.113.1657535494570;
        Mon, 11 Jul 2022 03:31:34 -0700 (PDT)
Received: from localhost.localdomain (62-170-35.netrun.cytanet.com.cy. [62.228.170.35])
        by smtp.gmail.com with ESMTPSA id ay38-20020a05600c1e2600b003a2cf1ba9e2sm6473204wmb.6.2022.07.11.03.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 03:31:34 -0700 (PDT)
From:   Maxim Devaev <mdevaev@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     mdevaev@gmail.com, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, corbet@lwn.net, balbi@kernel.org,
        caihuoqing@baidu.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v5] usb: gadget: f_mass_storage: forced_eject attribute
Date:   Mon, 11 Jul 2022 13:29:57 +0300
Message-Id: <20220711102956.19642-1-mdevaev@gmail.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It allows to reset prevent_medium_removal flag and "eject" the image.
This can be useful to free the drive from a hunging host or if the host
continues to use the drive even after unmounting (Linux does this).
It's also a bit like using an unfolded paperclip on an optical drive.

Previously, the undocumented method of sending SIGUSR1 to a special
"file-storage" kernel thread could be used for these purposes,
but when using multiple storages there was no way to distinguish
one from the other, so we had to send a signal to everyone.

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Maxim Devaev <mdevaev@gmail.com>
---
 v4 -> v5: A more detailed description of the commit
 v3 -> v4: Added comment for fsg_store_forced_eject() internals
 v2 -> v3: Improved spelling
 v1 -> v2: Added documentation for the ABI and sysfs

 .../testing/configfs-usb-gadget-mass-storage  |  6 +++++
 Documentation/usb/gadget-testing.rst          |  6 +++++
 Documentation/usb/mass-storage.rst            |  9 +++++++
 drivers/usb/gadget/function/f_mass_storage.c  | 25 +++++++++++++++++++
 drivers/usb/gadget/function/storage_common.c  | 15 +++++++++++
 drivers/usb/gadget/function/storage_common.h  |  2 ++
 6 files changed, 63 insertions(+)

diff --git a/Documentation/ABI/testing/configfs-usb-gadget-mass-storage b/Documentation/ABI/testing/configfs-usb-gadget-mass-storage
index c86b63a7bb43..d899adb57e81 100644
--- a/Documentation/ABI/testing/configfs-usb-gadget-mass-storage
+++ b/Documentation/ABI/testing/configfs-usb-gadget-mass-storage
@@ -32,4 +32,10 @@ Description:
 				being a CD-ROM.
 		nofua		Flag specifying that FUA flag
 				in SCSI WRITE(10,12)
+		forced_eject	This write-only file is useful only when
+				the function is active. It causes the backing
+				file to be forcibly detached from the LUN,
+				regardless of whether the host has allowed it.
+				Any non-zero number of bytes written will
+				result in ejection.
 		===========	==============================================
diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
index c18113077889..15624c4fe633 100644
--- a/Documentation/usb/gadget-testing.rst
+++ b/Documentation/usb/gadget-testing.rst
@@ -333,6 +333,12 @@ In each lun directory there are the following attribute files:
 			being a CD-ROM.
 	nofua		Flag specifying that FUA flag
 			in SCSI WRITE(10,12)
+	forced_eject	This write-only file is useful only when
+			the function is active. It causes the backing
+			file to be forcibly detached from the LUN,
+			regardless of whether the host has allowed it.
+			Any non-zero number of bytes written will
+			result in ejection.
 	=============== ==============================================
 
 Testing the MASS STORAGE function
diff --git a/Documentation/usb/mass-storage.rst b/Documentation/usb/mass-storage.rst
index d181b47c3cb6..f399ec631599 100644
--- a/Documentation/usb/mass-storage.rst
+++ b/Documentation/usb/mass-storage.rst
@@ -181,6 +181,15 @@ sysfs entries
     Reflects the state of nofua flag for given logical unit.  It can
     be read and written.
 
+  - forced_eject
+
+    When written into, it causes the backing file to be forcibly
+    detached from the LUN, regardless of whether the host has allowed
+    it.  The content doesn't matter, any non-zero number of bytes
+    written will result in ejection.
+
+    Can not be read.
+
   Other then those, as usual, the values of module parameters can be
   read from /sys/module/g_mass_storage/parameters/* files.
 
diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index 6ad669dde41c..00cac2a38178 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -2520,10 +2520,21 @@ static ssize_t file_store(struct device *dev, struct device_attribute *attr,
 	return fsg_store_file(curlun, filesem, buf, count);
 }
 
+static ssize_t forced_eject_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct fsg_lun		*curlun = fsg_lun_from_dev(dev);
+	struct rw_semaphore	*filesem = dev_get_drvdata(dev);
+
+	return fsg_store_forced_eject(curlun, filesem, buf, count);
+}
+
 static DEVICE_ATTR_RW(nofua);
 /* mode wil be set in fsg_lun_attr_is_visible() */
 static DEVICE_ATTR(ro, 0, ro_show, ro_store);
 static DEVICE_ATTR(file, 0, file_show, file_store);
+static DEVICE_ATTR_WO(forced_eject);
 
 /****************************** FSG COMMON ******************************/
 
@@ -2677,6 +2688,7 @@ static struct attribute *fsg_lun_dev_attrs[] = {
 	&dev_attr_ro.attr,
 	&dev_attr_file.attr,
 	&dev_attr_nofua.attr,
+	&dev_attr_forced_eject.attr,
 	NULL
 };
 
@@ -3090,6 +3102,18 @@ static ssize_t fsg_lun_opts_inquiry_string_store(struct config_item *item,
 
 CONFIGFS_ATTR(fsg_lun_opts_, inquiry_string);
 
+static ssize_t fsg_lun_opts_forced_eject_store(struct config_item *item,
+					       const char *page, size_t len)
+{
+	struct fsg_lun_opts *opts = to_fsg_lun_opts(item);
+	struct fsg_opts *fsg_opts = to_fsg_opts(opts->group.cg_item.ci_parent);
+
+	return fsg_store_forced_eject(opts->lun, &fsg_opts->common->filesem,
+				      page, len);
+}
+
+CONFIGFS_ATTR_WO(fsg_lun_opts_, forced_eject);
+
 static struct configfs_attribute *fsg_lun_attrs[] = {
 	&fsg_lun_opts_attr_file,
 	&fsg_lun_opts_attr_ro,
@@ -3097,6 +3121,7 @@ static struct configfs_attribute *fsg_lun_attrs[] = {
 	&fsg_lun_opts_attr_cdrom,
 	&fsg_lun_opts_attr_nofua,
 	&fsg_lun_opts_attr_inquiry_string,
+	&fsg_lun_opts_attr_forced_eject,
 	NULL,
 };
 
diff --git a/drivers/usb/gadget/function/storage_common.c b/drivers/usb/gadget/function/storage_common.c
index b859a158a414..03035dbbe97b 100644
--- a/drivers/usb/gadget/function/storage_common.c
+++ b/drivers/usb/gadget/function/storage_common.c
@@ -519,4 +519,19 @@ ssize_t fsg_store_inquiry_string(struct fsg_lun *curlun, const char *buf,
 }
 EXPORT_SYMBOL_GPL(fsg_store_inquiry_string);
 
+ssize_t fsg_store_forced_eject(struct fsg_lun *curlun, struct rw_semaphore *filesem,
+			       const char *buf, size_t count)
+{
+	int ret;
+
+	/*
+	 * Forcibly detach the backing file from the LUN
+	 * regardless of whether the host has allowed it.
+	 */
+	curlun->prevent_medium_removal = 0;
+	ret = fsg_store_file(curlun, filesem, "", 0);
+	return ret < 0 ? ret : count;
+}
+EXPORT_SYMBOL_GPL(fsg_store_forced_eject);
+
 MODULE_LICENSE("GPL");
diff --git a/drivers/usb/gadget/function/storage_common.h b/drivers/usb/gadget/function/storage_common.h
index bdeb1e233fc9..0a544a82cbf8 100644
--- a/drivers/usb/gadget/function/storage_common.h
+++ b/drivers/usb/gadget/function/storage_common.h
@@ -219,5 +219,7 @@ ssize_t fsg_store_removable(struct fsg_lun *curlun, const char *buf,
 			    size_t count);
 ssize_t fsg_store_inquiry_string(struct fsg_lun *curlun, const char *buf,
 				 size_t count);
+ssize_t fsg_store_forced_eject(struct fsg_lun *curlun, struct rw_semaphore *filesem,
+			       const char *buf, size_t count);
 
 #endif /* USB_STORAGE_COMMON_H */
-- 
2.37.0

