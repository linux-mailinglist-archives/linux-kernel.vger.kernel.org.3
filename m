Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CB356D137
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 22:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiGJUQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 16:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGJUQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 16:16:39 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D8F11A35;
        Sun, 10 Jul 2022 13:16:37 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bu1so3463203wrb.9;
        Sun, 10 Jul 2022 13:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/w7JDJxF8jO/KsKgUOwEOwtZvjheCEOivfqjdOXPkNY=;
        b=KZPaktByD5qzokvlf0TyNenv83Ju3yme0c36Kqt3Fki9Aw8MrEFKniXdhCBLDJP80Q
         1jQykSihiQ1O5nrFUP2imnxGf/pww2Tlwvbz01tPg0nlDLE1S1eNJyCjDBOgluQ2hvEq
         ZBpCY1nRHZaGsH6kPTALUz/5qfmvhWSmwi3LUjusIEPovWdwgH1PxgFSJE5yMRFMz4hN
         R38izh+IL5YFNu5qotgyjsFzL7BVhz74nMIwtPiNfrEoU8jz9/7Z0PJjKxQbxpXcR0hd
         8vyb4/6M4sK9om6Cz6Wq0hJFO1UtZfQf9Ad99HbPkHwHdHJoh7UvALGIMoFmsmGWlnZC
         SRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/w7JDJxF8jO/KsKgUOwEOwtZvjheCEOivfqjdOXPkNY=;
        b=kfuSL1+kIVlIc8l4+armGPEpMtV5gkQYxrtTtHho+85AyiAuQf27vnVJiQzawVzIHi
         NMMoi/PivaJZS2iM2GBYteqdnIoSFORA/Y+XxiueBAbfc4vAb17pa7fOsLobJARvw2b/
         laGGPmKN62VYMhRCTktE6g3JkIX8pFQWVivDPHZThkL/zrDKxYWBNEh57YbEAVL2Q9ES
         qXJr9dn9TLpMY5z2ayNGY84y008vpuiocyZErIf5V2whMCZOQVv0jeyPiZ9kPBLJ/n0t
         5UJYBgtDNPVBVw3cY7CTBnhno7ZfThSGkH6SXSbwQarpFfFjSa13yNUZYclD+iP4J5bi
         YN6Q==
X-Gm-Message-State: AJIora8d+ObJjUpztGudo9R10l0m8DIJqIjrCGXCiMhsA7ddo+sW7rFQ
        Adv9H6fcwTUNnQi0pZv5CJ14P6vB/tGuYA==
X-Google-Smtp-Source: AGRyM1vo5EFac1r93IwzIvPZZpk8XU8OvXi4FlZ/F6iTGHphsLtALd2Bu9n2nLYH2Q3Y5XXNI4z9/g==
X-Received: by 2002:a5d:64ed:0:b0:21b:c8ea:54f8 with SMTP id g13-20020a5d64ed000000b0021bc8ea54f8mr13111093wri.541.1657484195805;
        Sun, 10 Jul 2022 13:16:35 -0700 (PDT)
Received: from localhost.localdomain (62-170-35.netrun.cytanet.com.cy. [62.228.170.35])
        by smtp.gmail.com with ESMTPSA id y5-20020adff6c5000000b0021d83071683sm4226059wrp.64.2022.07.10.13.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 13:16:35 -0700 (PDT)
From:   Maxim Devaev <mdevaev@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     mdevaev@gmail.com, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, corbet@lwn.net, balbi@kernel.org,
        caihuoqing@baidu.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v4] usb: gadget: f_mass_storage: forced_eject attribute
Date:   Sun, 10 Jul 2022 23:16:06 +0300
Message-Id: <20220710201605.211434-1-mdevaev@gmail.com>
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

The patch is a completely alternative implementation of the previously
proposed [1], the idea of which was born after the mentioned discussion.

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Maxim Devaev <mdevaev@gmail.com>
Link: https://lore.kernel.org/lkml/20220406092445.215288-1-mdevaev@gmail.com [1]
---
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

