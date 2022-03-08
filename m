Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C53C4D0DC2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 02:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344325AbiCHB6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 20:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbiCHB63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 20:58:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62A2CD63
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 17:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646704652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gYfNI0SlCX9BJv99j/ZRqXDOZZLf2eh0xV+TKVixGaM=;
        b=GcepaS74MlQ6p1f0efAuFJhmfaTbYj6ffQ0vzSxxG8JBp0GBpwJKHNkmov6xsNuQNfRy1A
        djYSYIroX8iKy/eYYZRuNMCflx83eUXRBUgyWsZbn4Tr72yxZfRHXW+59Il2ZSURrV3fIl
        //QHWTJwdOiLm8J459+nQ8frGwAH6os=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-426-K-zv0o85MqifRTje2SVfIw-1; Mon, 07 Mar 2022 20:57:31 -0500
X-MC-Unique: K-zv0o85MqifRTje2SVfIw-1
Received: by mail-lf1-f69.google.com with SMTP id d14-20020a05651233ce00b004475964142aso2714398lfg.21
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 17:57:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gYfNI0SlCX9BJv99j/ZRqXDOZZLf2eh0xV+TKVixGaM=;
        b=296g7PRoTd7k6WcmBca64LdFQ4JhRVERowwu+4T0nU3CxHrovxUJy4n/8PY2YgJOsg
         I+kGw6CxaijxwSZZX4K4R/5hxUVeFOvjEkijgfNk7/ZbK3DR09XG95sO/ygQ4OPxqT0c
         D4681bSsJcvSd8zAcilJgl1wSt47Kfp1XvBnPKuRgo/kzeG4eJiDNQli9zjLoQqz4jyB
         ZPIovL6tVaetOwhjWG/WBQGEVVj/oJ2OTDhNWiO6AozOB+x5P+TfkVulZH/o3AV0Z81G
         sePVJuXOnOnwkPiu+vDzsQylw/bWNAzhWPCG9Hlu4s70yaAl/hcI8pDPoYGdvaB9G6G8
         XSzg==
X-Gm-Message-State: AOAM5329+7mOb3N5o+CHSILfG2B+E96yduQgYr0CEwEd08wZFtFTN7wi
        hscD1E2YHtIq4fBkPJxlsA2mR4v7up9jEWzMR5qW+l0y4L/SHcs9c7m8RtnF9CUY8s1Xz2PYBjO
        LVAAY1e4VURVqGd0uKXPCwOiDNGpmA+WGh4g88CGm1Y1eQCHNXPDIyFZXx4iLl+deXsQZWCgJlO
        Q=
X-Received: by 2002:a05:6512:1585:b0:445:908b:ad71 with SMTP id bp5-20020a056512158500b00445908bad71mr9360475lfb.200.1646704649796;
        Mon, 07 Mar 2022 17:57:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxb2RXluRI1Hpj/9y4Y0GFufnMFAoHcfOUmQ8jV3BJTpXjAxd2/VxZ6/jn3y9OutltE4sLVNA==
X-Received: by 2002:a05:6512:1585:b0:445:908b:ad71 with SMTP id bp5-20020a056512158500b00445908bad71mr9360455lfb.200.1646704649490;
        Mon, 07 Mar 2022 17:57:29 -0800 (PST)
Received: from localhost.localdomain (91-145-109-188.bb.dnainternet.fi. [91.145.109.188])
        by smtp.gmail.com with ESMTPSA id p1-20020ac246c1000000b004482062656bsm1983758lfo.294.2022.03.07.17.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 17:57:29 -0800 (PST)
From:   mpenttil@redhat.com
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>
Subject: [PATCH] HMM selftests changes
Date:   Tue,  8 Mar 2022 03:57:05 +0200
Message-Id: <20220308015705.8424-1-mpenttil@redhat.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mika Penttilä <mpenttil@redhat.com>

HMM selftests use a in-kernel pseudo device to emulate device private memory.

For now, the pseudo device registers a major device range for two pseudo device instances.
User space has a script that goes figures out from /proc/devices the assigned major
and mknods the device nodes.

Change this use to a more standard device framework, like misc device,
which makes the device node names to appear right under any decent user space.
This also makes it possible for udev- like processing if wanted,
and the /proc/devices parsing is not needed any more.

Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
---
 lib/test_hmm.c                         | 46 +++++++++++++++-----------
 tools/testing/selftests/vm/test_hmm.sh |  6 ----
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 767538089a62..76f6129e1f1f 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -10,7 +10,6 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/cdev.h>
 #include <linux/device.h>
 #include <linux/mutex.h>
 #include <linux/rwsem.h>
@@ -25,18 +24,25 @@
 #include <linux/swapops.h>
 #include <linux/sched/mm.h>
 #include <linux/platform_device.h>
+#include <linux/miscdevice.h>
 #include <linux/rmap.h>
 
 #include "test_hmm_uapi.h"
 
-#define DMIRROR_NDEVICES		2
 #define DMIRROR_RANGE_FAULT_TIMEOUT	1000
 #define DEVMEM_CHUNK_SIZE		(256 * 1024 * 1024U)
 #define DEVMEM_CHUNKS_RESERVE		16
 
+
+static const char *dmirror_device_names[] = {
+	"hmm_dmirror0",
+	"hmm_dmirror1"
+};
+
+#define DMIRROR_NDEVICES ARRAY_SIZE(dmirror_device_names)
+
 static const struct dev_pagemap_ops dmirror_devmem_ops;
 static const struct mmu_interval_notifier_ops dmirror_min_ops;
-static dev_t dmirror_dev;
 
 struct dmirror_device;
 
@@ -82,7 +88,7 @@ struct dmirror_chunk {
  * Per device data.
  */
 struct dmirror_device {
-	struct cdev		cdevice;
+	struct miscdevice	miscdevice;
 	struct hmm_devmem	*devmem;
 
 	unsigned int		devmem_capacity;
@@ -118,16 +124,20 @@ static void dmirror_bounce_fini(struct dmirror_bounce *bounce)
 
 static int dmirror_fops_open(struct inode *inode, struct file *filp)
 {
-	struct cdev *cdev = inode->i_cdev;
+
+	struct dmirror_device *dd = container_of(filp->private_data,
+                                              struct dmirror_device, miscdevice
+		);
 	struct dmirror *dmirror;
 	int ret;
 
+
 	/* Mirror this process address space */
 	dmirror = kzalloc(sizeof(*dmirror), GFP_KERNEL);
 	if (dmirror == NULL)
 		return -ENOMEM;
 
-	dmirror->mdevice = container_of(cdev, struct dmirror_device, cdevice);
+	dmirror->mdevice = dd;
 	mutex_init(&dmirror->mutex);
 	xa_init(&dmirror->pt);
 
@@ -1216,16 +1226,18 @@ static const struct dev_pagemap_ops dmirror_devmem_ops = {
 
 static int dmirror_device_init(struct dmirror_device *mdevice, int id)
 {
-	dev_t dev;
+
 	int ret;
 
-	dev = MKDEV(MAJOR(dmirror_dev), id);
 	mutex_init(&mdevice->devmem_lock);
 	spin_lock_init(&mdevice->lock);
 
-	cdev_init(&mdevice->cdevice, &dmirror_fops);
-	mdevice->cdevice.owner = THIS_MODULE;
-	ret = cdev_add(&mdevice->cdevice, dev, 1);
+	mdevice->miscdevice.minor = MISC_DYNAMIC_MINOR;
+	mdevice->miscdevice.name = dmirror_device_names[id];
+	mdevice->miscdevice.fops = &dmirror_fops;
+
+	ret = misc_register(&mdevice->miscdevice);
+
 	if (ret)
 		return ret;
 
@@ -1252,7 +1264,7 @@ static void dmirror_device_remove(struct dmirror_device *mdevice)
 		kfree(mdevice->devmem_chunks);
 	}
 
-	cdev_del(&mdevice->cdevice);
+	misc_deregister(&mdevice->miscdevice);
 }
 
 static int __init hmm_dmirror_init(void)
@@ -1260,11 +1272,6 @@ static int __init hmm_dmirror_init(void)
 	int ret;
 	int id;
 
-	ret = alloc_chrdev_region(&dmirror_dev, 0, DMIRROR_NDEVICES,
-				  "HMM_DMIRROR");
-	if (ret)
-		goto err_unreg;
-
 	for (id = 0; id < DMIRROR_NDEVICES; id++) {
 		ret = dmirror_device_init(dmirror_devices + id, id);
 		if (ret)
@@ -1277,8 +1284,7 @@ static int __init hmm_dmirror_init(void)
 err_chrdev:
 	while (--id >= 0)
 		dmirror_device_remove(dmirror_devices + id);
-	unregister_chrdev_region(dmirror_dev, DMIRROR_NDEVICES);
-err_unreg:
+
 	return ret;
 }
 
@@ -1288,7 +1294,7 @@ static void __exit hmm_dmirror_exit(void)
 
 	for (id = 0; id < DMIRROR_NDEVICES; id++)
 		dmirror_device_remove(dmirror_devices + id);
-	unregister_chrdev_region(dmirror_dev, DMIRROR_NDEVICES);
+
 }
 
 module_init(hmm_dmirror_init);
diff --git a/tools/testing/selftests/vm/test_hmm.sh b/tools/testing/selftests/vm/test_hmm.sh
index 0647b525a625..69f5889f8575 100755
--- a/tools/testing/selftests/vm/test_hmm.sh
+++ b/tools/testing/selftests/vm/test_hmm.sh
@@ -41,17 +41,11 @@ check_test_requirements()
 load_driver()
 {
 	modprobe $DRIVER > /dev/null 2>&1
-	if [ $? == 0 ]; then
-		major=$(awk "\$2==\"HMM_DMIRROR\" {print \$1}" /proc/devices)
-		mknod /dev/hmm_dmirror0 c $major 0
-		mknod /dev/hmm_dmirror1 c $major 1
-	fi
 }
 
 unload_driver()
 {
 	modprobe -r $DRIVER > /dev/null 2>&1
-	rm -f /dev/hmm_dmirror?
 }
 
 run_smoke()
-- 
2.17.1

