Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49FF4E1F1D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 03:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344120AbiCUCqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 22:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242162AbiCUCqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 22:46:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 982A711A3E
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 19:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647830703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6ubxP4hFPwWxxv0omchK9xVZybEAI/r5w17ak6c2HDo=;
        b=IDBxeE78TmUg1H13VXaJa3Q2XtvLh4lLUKDeTbHj6FjrPg5PsQocez743r8VnjKu1Pc0dm
        F0G9xw5muaNcy9wyVAvsm/vy/d+Cnh+7vpKndfiT50PpDV1VlYR/KoEE8jLjgnwlZhaHhp
        GJwbHxpDEg+G4lIYgxcGcgILjioJALk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-WmRqz3okM1asimgO9_G1LQ-1; Sun, 20 Mar 2022 22:45:02 -0400
X-MC-Unique: WmRqz3okM1asimgO9_G1LQ-1
Received: by mail-lf1-f70.google.com with SMTP id i17-20020a056512007100b0044879482376so3375419lfo.20
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 19:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6ubxP4hFPwWxxv0omchK9xVZybEAI/r5w17ak6c2HDo=;
        b=rie6ea16HJo2a6a4Fm2YtzLpDrrUuZspIrchm39AGPUv2E5OjqANXZ4ulsO3zVFKJM
         N7UfXGj0pXMfE/AnDeFQp2DrgJDoJL+eQZqNfYKTN1Ur2IARYS0sDg60uILjWDsX+UYO
         4Y37nL5lE/GIXfut65lsCl1yNMwDItf5c0HQBmMqHB4vyNQ1TmqG/PJTGrqNtMfvXJFs
         6XKWLe36ZLT1JlS6qOtJ+o9WJ1uqyrPo4kTkP1SZdS104WsrR7WtujW7MdAb0hmwztsg
         nECe+a453OQ2nnK6C9/mYbgVfwwIZ7GWpB9tEZOOgePjizRryfTbbAv0sItR/S1rQ4f4
         z4KQ==
X-Gm-Message-State: AOAM532TqNh/fsDDQfL8FjiA1XtrY4LXCKBqb4i4/c9in0725T1I2usB
        0Hn/vMUrskncoTl60BbjYP8V+x6pcgFynFosmo8N8olTSxN3zDT7Bkk6cBDimMlprX9zNhTFqLD
        sBMbZtQ4r1HN1gGrXxIJp0iRInom9em4AzyCTd2knphLCgvWPmCTVfgOzRRmhS1MifyAR1zs27I
        4=
X-Received: by 2002:a05:6512:220c:b0:44a:2e21:e35c with SMTP id h12-20020a056512220c00b0044a2e21e35cmr1450073lfu.107.1647830701135;
        Sun, 20 Mar 2022 19:45:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFXUogRW93Ntm/8FmIFnPfkQTaFd15JoOAVpUH6T8ISpe1VzIYS3//Es/xS4cbZxgGHbVESw==
X-Received: by 2002:a05:6512:220c:b0:44a:2e21:e35c with SMTP id h12-20020a056512220c00b0044a2e21e35cmr1450053lfu.107.1647830700856;
        Sun, 20 Mar 2022 19:45:00 -0700 (PDT)
Received: from localhost.localdomain (91-145-109-188.bb.dnainternet.fi. [91.145.109.188])
        by smtp.gmail.com with ESMTPSA id m8-20020a05651202e800b0044a2d45534fsm161250lfq.103.2022.03.20.19.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 19:45:00 -0700 (PDT)
From:   mpenttil@redhat.com
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     apopple@nvidia.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
        jgg@ziepe.ca, vbabka@suse.cz,
        =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>
Subject: [PATCH v3] mm/hmm/test: use char dev with struct device to get device node
Date:   Mon, 21 Mar 2022 04:44:00 +0200
Message-Id: <20220321024400.20956-1-mpenttil@redhat.com>
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

This duplicates a fair amount of boilerplate that misc device can do
instead.

Change this to use misc device, which makes the device node names appear
for us. This also enables udev-like processing if desired.

Delete the /proc/devices parsing from the user-space test script, now
that it is unnecessary.

Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Vlastimil Babka <vbabka@suse.cz>
---
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

