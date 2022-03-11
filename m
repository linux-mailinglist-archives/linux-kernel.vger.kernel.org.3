Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9F34D5918
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 04:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345988AbiCKDdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 22:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346407AbiCKDdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 22:33:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15403F68F9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 19:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646969474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=J0OLr2mkUgo8W4yOelSoWk9dmjDH+khiCra/4OvgbRE=;
        b=TPoofZQIN5w+GY76axxX9Zmt+6stqxTPDwFR6CC6aRocFLBPUD3BUC7E4cktvpPTtxE5MP
        Q8aTVu1zVf41A5mtWX4o/E18CF3HU2MMbdG7bZytzfkZO5JOCog2QbN30aModuVn1sqgty
        WfSalwD+9FR+542jcgxW1h/XTiSmHXk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-KBFFiQL5MBG4FwnqGoVZnw-1; Thu, 10 Mar 2022 22:31:13 -0500
X-MC-Unique: KBFFiQL5MBG4FwnqGoVZnw-1
Received: by mail-lf1-f72.google.com with SMTP id b7-20020a056512218700b0044869874779so1131746lft.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 19:31:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J0OLr2mkUgo8W4yOelSoWk9dmjDH+khiCra/4OvgbRE=;
        b=Mn7guVgDq8jXcyiOlTJeK5VKMCCd9fR+q+yKE4fZizJ8XyZxyPcUvVYzTqBKlosk3T
         n1cZysSG07Tqpv3iOlV/rXKvRtpWtoyzyOAKI+1CH+LvfRHYvO+UJbLqj2YDZxHTASl3
         VeToZK6YSJo/XQf9KPkHyGoZRlwxvJ8CuMXGoa9QCdQAYISJb1HgK6sHpohwtd4nNDIx
         hE56GQftluCKn/2QXJwlkgMBjPKguJJDzHvR0JboOHX9iomln3FfKlHTsXnX0q0bRlcP
         iCFXh/Pe3fHuaFH0cXqlvhKg2a/FzmIEm7vE7WANys8XBFiMyD921E5eP2fZ+PMcOG73
         NPJA==
X-Gm-Message-State: AOAM533ahhofdpMGvPCtqxbVikPik994RRCnteOZ4Gy09C5UJwXq1faB
        TdE+1899g0dBsWJIeASwnTiE16Abmlxaf/MtPpLFnUn4mJiH0cbp8QdNDS6Ip6A2TZDb8/r7l5t
        o5wC6dxZC0M7OpEqWAIJ3XNPLZ7K+p0i/LKyTAdxUjcsxtFCE5PDS0DlQbM0XpzxJHd/LfCB4ij
        s=
X-Received: by 2002:ac2:418c:0:b0:43e:8f98:98f0 with SMTP id z12-20020ac2418c000000b0043e8f9898f0mr5018275lfh.604.1646969471581;
        Thu, 10 Mar 2022 19:31:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwNNZCyTIcpfkdac1X8Afin/J2k3HiOknmksttd95PiayQnmesQwStiDBhOUm+oIs2H1NNosg==
X-Received: by 2002:ac2:418c:0:b0:43e:8f98:98f0 with SMTP id z12-20020ac2418c000000b0043e8f9898f0mr5018258lfh.604.1646969471310;
        Thu, 10 Mar 2022 19:31:11 -0800 (PST)
Received: from localhost.localdomain (91-145-109-188.bb.dnainternet.fi. [91.145.109.188])
        by smtp.gmail.com with ESMTPSA id u16-20020ac25190000000b004433b80c1d3sm1339700lfi.182.2022.03.10.19.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 19:31:10 -0800 (PST)
From:   mpenttil@redhat.com
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     apopple@nvidia.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
        jgg@ziepe.ca, vbabka@suse.cz,
        =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>
Subject: [PATCH v2] mm/hmm/test: simplify hmm test code: use miscdevice instead of char dev
Date:   Fri, 11 Mar 2022 05:30:50 +0200
Message-Id: <20220311033050.22724-1-mpenttil@redhat.com>
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

HMM selftests use an in-kernel pseudo device to emulate device private
memory. The pseudo device registers a major device range for two pseudo
device instances. User space has a script that reads /proc/devices in
order to find the assigned major number, and sends that to mknod(1),
once for each node.

This duplicates a fair amount of boilerplate that misc device can do
instead.

Change this to use misc device, which makes the device node names appear
for us. This also enables udev-like processing if desired.

Delete the /proc/devices parsing from the user-space test script, now
that it is unnecessary.

v2:
        - Cleanups per review comments from John Hubbard
        - Added Tested-by and Ccs

Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
Tested-by: Alistair Popple <apopple@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Vlastimil Babka <vbabka@suse.cz>
---
 lib/test_hmm.c                         | 40 ++++++++++++--------------
 tools/testing/selftests/vm/test_hmm.sh |  6 ----
 2 files changed, 19 insertions(+), 27 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 767538089a62..0e1488e1bad8 100644
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
@@ -25,18 +24,24 @@
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
 
@@ -82,7 +87,7 @@ struct dmirror_chunk {
  * Per device data.
  */
 struct dmirror_device {
-	struct cdev		cdevice;
+	struct miscdevice	miscdevice;
 	struct hmm_devmem	*devmem;
 
 	unsigned int		devmem_capacity;
@@ -118,7 +123,6 @@ static void dmirror_bounce_fini(struct dmirror_bounce *bounce)
 
 static int dmirror_fops_open(struct inode *inode, struct file *filp)
 {
-	struct cdev *cdev = inode->i_cdev;
 	struct dmirror *dmirror;
 	int ret;
 
@@ -127,12 +131,13 @@ static int dmirror_fops_open(struct inode *inode, struct file *filp)
 	if (dmirror == NULL)
 		return -ENOMEM;
 
-	dmirror->mdevice = container_of(cdev, struct dmirror_device, cdevice);
+	dmirror->mdevice = container_of(filp->private_data,
+					struct dmirror_device, miscdevice);
 	mutex_init(&dmirror->mutex);
 	xa_init(&dmirror->pt);
 
 	ret = mmu_interval_notifier_insert(&dmirror->notifier, current->mm,
-				0, ULONG_MAX & PAGE_MASK, &dmirror_min_ops);
+					0, ULONG_MAX & PAGE_MASK, &dmirror_min_ops);
 	if (ret) {
 		kfree(dmirror);
 		return ret;
@@ -1216,16 +1221,16 @@ static const struct dev_pagemap_ops dmirror_devmem_ops = {
 
 static int dmirror_device_init(struct dmirror_device *mdevice, int id)
 {
-	dev_t dev;
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
 	if (ret)
 		return ret;
 
@@ -1252,7 +1257,7 @@ static void dmirror_device_remove(struct dmirror_device *mdevice)
 		kfree(mdevice->devmem_chunks);
 	}
 
-	cdev_del(&mdevice->cdevice);
+	misc_deregister(&mdevice->miscdevice);
 }
 
 static int __init hmm_dmirror_init(void)
@@ -1260,11 +1265,6 @@ static int __init hmm_dmirror_init(void)
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
@@ -1277,8 +1277,7 @@ static int __init hmm_dmirror_init(void)
 err_chrdev:
 	while (--id >= 0)
 		dmirror_device_remove(dmirror_devices + id);
-	unregister_chrdev_region(dmirror_dev, DMIRROR_NDEVICES);
-err_unreg:
+
 	return ret;
 }
 
@@ -1288,7 +1287,6 @@ static void __exit hmm_dmirror_exit(void)
 
 	for (id = 0; id < DMIRROR_NDEVICES; id++)
 		dmirror_device_remove(dmirror_devices + id);
-	unregister_chrdev_region(dmirror_dev, DMIRROR_NDEVICES);
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

