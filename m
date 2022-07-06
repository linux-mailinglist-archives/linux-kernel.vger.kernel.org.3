Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E60569104
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbiGFRrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiGFRrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:47:16 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C00B33B;
        Wed,  6 Jul 2022 10:47:15 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id k30so12088232edk.8;
        Wed, 06 Jul 2022 10:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WMGCefUtPu8UwO6ERml6n2ZI6wHVNjwGQiWTcNMaDt8=;
        b=XRzM2s5gsW+2XIeJx9zST87Dkr0yBh1JLoOgB7sEy/hLnoHYgASmLndmmwGBPbdWYx
         hSDdPh5gZmIUvzo/uHphQi1sSexVaCqkaQVgV0+3jHDKSaTVkAV4+EhLxtQ0OvGJR3d8
         SCe76l/dR66w58TmCgvZtENLXnYDIkPTC94JYmyIfMft0yECZRnRUFBc4MCiqsL9zWtk
         V5c8RFTjqBel8ffrGOouKqY+T8VJWuZ897hPSLoHDWYirLl1pxfst6fXZtWK+84+iYNl
         wQbfLCw5JthRZgc5HIrbBScEvbOCafgTcf7HGbHgc7s2CUQUHAlCQieT/s9BQXplxUGe
         iSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WMGCefUtPu8UwO6ERml6n2ZI6wHVNjwGQiWTcNMaDt8=;
        b=K+QXXouVyV4G7CyfRLw7THV1pQuLJv0sqqBc6ph7dWxU7T86PZ8Yj3fs8Dq8N1t8Or
         K2pZsgddJIZjQ5ggTbowv+u2pGUdfff/wl/IKl2l3q3NcvjhidvmMrQGzvWL5H18vJ/J
         eTD4CJEa8A5hbt16fmDFgmeO/BymceRA/dk7rmC/wMWmz5wGbAt327GjrGNhH/2RjaAV
         JAzYQh9Kc1fnolGcYsPv+98qSUJfA29A2YM1lNjAnRMb87RUh5y3KdO1dTtkFjCrYygs
         6HlIdzvgWE6Ef8MUwqG36TYjD3sUAM4+Szi1/1tW+t05PU05LbzyGdMCwu5huUJGdcw7
         78TQ==
X-Gm-Message-State: AJIora+j6vv8VU/IJVG0/n6/z7okGEXHRjIp8ctUQ+H7s8l4qHJmUQg+
        +pHie2KC/09cclb4k7624xqcIPl6rTWQcmMs
X-Google-Smtp-Source: AGRyM1siy18+UGvFM82oNCh1h17PbVkWfOI8tJwH3vSrS46mbZeFShaTA30dUZR6noxdbd8NecxUYQ==
X-Received: by 2002:a05:6402:4243:b0:437:618c:695a with SMTP id g3-20020a056402424300b00437618c695amr57133692edb.222.1657129633400;
        Wed, 06 Jul 2022 10:47:13 -0700 (PDT)
Received: from localhost.localdomain (87-168-253.netrunf.cytanet.com.cy. [87.228.168.253])
        by smtp.gmail.com with ESMTPSA id ev20-20020a056402541400b0043a20be7a33sm8627180edb.90.2022.07.06.10.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 10:47:12 -0700 (PDT)
From:   Maxim Devaev <mdevaev@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     stern@rowland.harvard.edu, balbi@kernel.org,
        gregkh@linuxfoundation.org, caihuoqing@baidu.com,
        mdevaev@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: f_mass_storage: forced_eject attribute
Date:   Wed,  6 Jul 2022 20:46:34 +0300
Message-Id: <20220706174634.20639-1-mdevaev@gmail.com>
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

Signed-off-by: Maxim Devaev <mdevaev@gmail.com>
Link: https://lore.kernel.org/lkml/20220406092445.215288-1-mdevaev@gmail.com [1]
---
 drivers/usb/gadget/function/f_mass_storage.c | 25 ++++++++++++++++++++
 drivers/usb/gadget/function/storage_common.c | 11 +++++++++
 drivers/usb/gadget/function/storage_common.h |  2 ++
 3 files changed, 38 insertions(+)

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
index b859a158a414..8cd95bf7831f 100644
--- a/drivers/usb/gadget/function/storage_common.c
+++ b/drivers/usb/gadget/function/storage_common.c
@@ -519,4 +519,15 @@ ssize_t fsg_store_inquiry_string(struct fsg_lun *curlun, const char *buf,
 }
 EXPORT_SYMBOL_GPL(fsg_store_inquiry_string);
 
+ssize_t fsg_store_forced_eject(struct fsg_lun *curlun, struct rw_semaphore *filesem,
+			       const char *buf, size_t count)
+{
+	int ret;
+
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

