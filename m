Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D32F4E37FD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 05:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236454AbiCVEh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 00:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236466AbiCVEh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 00:37:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACAC9C65
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 21:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647923759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=t3IGbOgUUewTBogYnzXEBJ4M/X0d13k762exbwwKFTM=;
        b=Mjs6IH3o8GOfPEtAFkP7RYZIXD2raLzzDVIVHaZtAWavevaWsObV4bUAjAD/dOCnxnbT3E
        6fNXby5m3WVDEHHVQCkBZkR1V7Zc0OOUNMfSDChTsuCrL1NYTWB653z4jgxNuy02Fai5T8
        6qeJ3bpzHZyXWm8SgeixSvW/kOya1as=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-410-e5SLrQTGPnW-c3lzq4QpCg-1; Tue, 22 Mar 2022 00:35:58 -0400
X-MC-Unique: e5SLrQTGPnW-c3lzq4QpCg-1
Received: by mail-lf1-f71.google.com with SMTP id s17-20020ac25ff1000000b0044877550d2aso4279882lfg.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 21:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t3IGbOgUUewTBogYnzXEBJ4M/X0d13k762exbwwKFTM=;
        b=jkqtXdIpqBeBCaLQ5aiPwMRrLAQNS6C30YCrXLBT3kfSuW+KDtI1fq2UaZ05miGdq8
         NhrD+KVe5FXD3o6/GnU2s54ZQOigAMPq7/s1Hy0IGEgI4z6J3BL/lsPPeSpvHvb3uEgs
         5+QpmLO2qWCb+hRcPCBsR3KU7vbUEwrSSK/J2UzdWnAAau7lHjttMvje+K6I4x9EZYYS
         iGp94+yVNcBGZHm0NWOx5Zs2rra0DMgNpP+j9TaigDHAgnCV4Eu2vNAqI3AgvvFNErQF
         VsuXTL87APi4zr1M18NneLu4bdfdwfqUsLdsGddc28CxUCCgnOxu7XdTYxDoUyCMhYJG
         8IGQ==
X-Gm-Message-State: AOAM532ABB84j6XNZqdSsC9DzpD0x4Zvw5IB47udw+QbWAlZMjjWXiIq
        qzo8bCg5rB8w9j24QkI3MfYcWJpyuFV5vuK6vnACNLfuzj2SuxAc/FXf5UMywMt3wMdZVVQxno+
        q5e8yZtGGYffCsSgsBKhFKMb2+5tnAA/BflbfieoghH0BxhNVUwNlYQ58ezSCvX3wJZFC4HxzhY
        k=
X-Received: by 2002:a05:6512:1151:b0:448:537b:1fab with SMTP id m17-20020a056512115100b00448537b1fabmr16553361lfg.422.1647923756728;
        Mon, 21 Mar 2022 21:35:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxw4cz+Q7IEwWixdY2LJo1ZUVa1g8ngSQfImYT4hIY0nJUFe1GrdHDFFwy+WgLk/ZMPYb0GPg==
X-Received: by 2002:a05:6512:1151:b0:448:537b:1fab with SMTP id m17-20020a056512115100b00448537b1fabmr16553346lfg.422.1647923756483;
        Mon, 21 Mar 2022 21:35:56 -0700 (PDT)
Received: from mjp-Z390-AORUS-MASTER.redhat.com (91-145-109-188.bb.dnainternet.fi. [91.145.109.188])
        by smtp.gmail.com with ESMTPSA id a13-20020a195f4d000000b00443a5302315sm2042069lfj.30.2022.03.21.21.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 21:35:56 -0700 (PDT)
From:   mpenttil@redhat.com
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     apopple@nvidia.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
        jgg@ziepe.ca, vbabka@suse.cz,
        =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>
Subject: [PATCH v5] mm/hmm/test: use char dev with struct device to get device node
Date:   Tue, 22 Mar 2022 06:35:43 +0200
Message-Id: <20220322043543.18424-1-mpenttil@redhat.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Change this to properly use cdev and struct device APIs.

Delete the /proc/devices parsing from the user-space test script, now
that it is unnecessary.

Also, deleted an unused field in struct dmirror_device: devmem.

Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Vlastimil Babka <vbabka@suse.cz>
---
v5:
        - fix whitespace
        . delete unused structure field     
v4:
        - fix commit log
v3:
        - use cdev_device_add() instead of miscdevice
v2:
        - Cleanups per review comments from John Hubbard
        - Added Tested-by and Ccs

 lib/test_hmm.c                         | 18 ++++++++++++++----
 tools/testing/selftests/vm/test_hmm.sh |  6 ------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 767538089a62..3c7f2a92b09e 100644
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
@@ -83,7 +89,7 @@ struct dmirror_chunk {
  */
 struct dmirror_device {
 	struct cdev		cdevice;
-	struct hmm_devmem	*devmem;
+	struct device		device;
 
 	unsigned int		devmem_capacity;
 	unsigned int		devmem_count;
@@ -1225,7 +1231,11 @@ static int dmirror_device_init(struct dmirror_device *mdevice, int id)
 
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
 
@@ -1252,7 +1262,7 @@ static void dmirror_device_remove(struct dmirror_device *mdevice)
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

