Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9824E1F26
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 03:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344227AbiCUCzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 22:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344229AbiCUCzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 22:55:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7618E5939B
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 19:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647831260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TY98zpyPJjrKTE23mA9lZxRQz88c3+rdB3CLIr1y+50=;
        b=D6VL7M+s0+Wn6z9bitzFl1y9b8NpiLD7EabS9aUAS7PFLHU9ilTo2a1kkaYsTMbELYJLMI
        T3lZ7au/ebMrhN2TWe3jr6iYrwSFBQ7Tv0KxLOUUOAo35bNORAxdcE/GoJrXp0j5XBStAB
        YlhcpkkaSp7NlkW/G7C26Hc3tEzXoy0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-pjtZpH8uOZm2ZaVefKw0oQ-1; Sun, 20 Mar 2022 22:54:18 -0400
X-MC-Unique: pjtZpH8uOZm2ZaVefKw0oQ-1
Received: by mail-lf1-f72.google.com with SMTP id w25-20020a0565120b1900b004489048b5d9so3406983lfu.8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 19:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TY98zpyPJjrKTE23mA9lZxRQz88c3+rdB3CLIr1y+50=;
        b=baaJNXIYVk4CtFlNo8Y/dDIpRMg+uUVahWD4MJ9/TBWDu0VU61E3phnqdy/m46Vdml
         Q3OChaxpmem+8F+DTzEQtudv1Gn1J/gmuXEdjEE1HjsD28hiChNL0fZ3A7btiWNCATvf
         wi0ZHUsEUWrmBL6FsgVB8mOURyACed+hEhsr3NJkbu76Y8nPZoVAvAja4mbjhT/JKMo3
         pJziKUGyoNChhls00KCbqUObkehh8ONg/zSOwhiispsGx56n+3OICiE9bT7ESd1kx0+W
         Y4uXdyQlSD7h0zagKwZvklKw5kBp5PjVGp6ttvXCD87gXasabbXE+VHPQ0pW7vsbo4vr
         J9LA==
X-Gm-Message-State: AOAM5306z/UFPQVUOzjQOwdnpIDW4sgfC7EqGdNOV+nHeK2uNE2vNCqJ
        uSaBp9bBcxCZe4neBLLuVnGj5ftjZ9RByEG4y1VUjAeCc18PqEgsDyQIGUAkXj/HDtDeduxMQnv
        VIOXw6pE5Ifl298jOSc/sOQnUgYLWQF4+vi+tfKEe0XCU+OXzJ+da6GpW3AKzngQh2VxHx5oVGM
        A=
X-Received: by 2002:a2e:2c16:0:b0:249:66b6:e33d with SMTP id s22-20020a2e2c16000000b0024966b6e33dmr9552004ljs.110.1647831255530;
        Sun, 20 Mar 2022 19:54:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPlD9DanXIioqDmkoSx1ZGhTEK3MfIzYvaL5XJttYEIwmmwaRaF4aT1WZPE6chFVlnm2Plmw==
X-Received: by 2002:a2e:2c16:0:b0:249:66b6:e33d with SMTP id s22-20020a2e2c16000000b0024966b6e33dmr9551989ljs.110.1647831255238;
        Sun, 20 Mar 2022 19:54:15 -0700 (PDT)
Received: from localhost.localdomain (91-145-109-188.bb.dnainternet.fi. [91.145.109.188])
        by smtp.gmail.com with ESMTPSA id p27-20020a056512313b00b0044a315f262csm39213lfd.102.2022.03.20.19.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 19:54:14 -0700 (PDT)
From:   mpenttil@redhat.com
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     apopple@nvidia.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
        jgg@ziepe.ca, vbabka@suse.cz,
        =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>
Subject: [PATCH v4] mm/hmm/test: use char dev with struct device to get device node
Date:   Mon, 21 Mar 2022 04:54:10 +0200
Message-Id: <20220321025410.21286-1-mpenttil@redhat.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
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

Change this to use proper use of cdev APIs and struct device.

Delete the /proc/devices parsing from the user-space test script, now
that it is unnecessary.

Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Vlastimil Babka <vbabka@suse.cz>
---
v4:
	- fix commit log
v3:
        - use cdev_device_add() instead of miscdevice
v2:
        - Cleanups per review comments from John Hubbard
        - Added Tested-by and Ccs

 lib/test_hmm.c                         | 25 ++++++++++++++++++-------
 tools/testing/selftests/vm/test_hmm.sh |  6 ------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 767538089a62..d247e9c0fe94 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -29,11 +29,17 @@
 
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
 static dev_t dmirror_dev;
@@ -74,7 +80,7 @@ struct dmirror {
  * ZONE_DEVICE pages for migration and simulating device memory.
  */
 struct dmirror_chunk {
-	struct dev_pagemap	pagemap;
+	struct dev_pagemap      pagemap;
 	struct dmirror_device	*mdevice;
 };
 
@@ -82,8 +88,9 @@ struct dmirror_chunk {
  * Per device data.
  */
 struct dmirror_device {
-	struct cdev		cdevice;
-	struct hmm_devmem	*devmem;
+	struct cdev             cdevice;
+	struct device           device;
+	struct hmm_devmem       *devmem;
 
 	unsigned int		devmem_capacity;
 	unsigned int		devmem_count;
@@ -132,7 +139,7 @@ static int dmirror_fops_open(struct inode *inode, struct file *filp)
 	xa_init(&dmirror->pt);
 
 	ret = mmu_interval_notifier_insert(&dmirror->notifier, current->mm,
-				0, ULONG_MAX & PAGE_MASK, &dmirror_min_ops);
+					0, ULONG_MAX & PAGE_MASK, &dmirror_min_ops);
 	if (ret) {
 		kfree(dmirror);
 		return ret;
@@ -1225,7 +1232,11 @@ static int dmirror_device_init(struct dmirror_device *mdevice, int id)
 
 	cdev_init(&mdevice->cdevice, &dmirror_fops);
 	mdevice->cdevice.owner = THIS_MODULE;
-	ret = cdev_add(&mdevice->cdevice, dev, 1);
+	device_initialize(&mdevice->device);
+	dev_set_name(&mdevice->device, "%s", dmirror_device_names[id]);
+	mdevice->device.devt = dev;
+
+	ret = cdev_device_add(&mdevice->cdevice, &mdevice->device);
 	if (ret)
 		return ret;
 
@@ -1252,7 +1263,7 @@ static void dmirror_device_remove(struct dmirror_device *mdevice)
 		kfree(mdevice->devmem_chunks);
 	}
 
-	cdev_del(&mdevice->cdevice);
+	cdev_device_del(&mdevice->cdevice, &mdevice->device);
 }
 
 static int __init hmm_dmirror_init(void)
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

