Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B446B4EB783
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 02:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241477AbiC3Ate (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 20:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiC3Atc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 20:49:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B89F182D80
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 17:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648601266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nAylo5IpwXAoPRELTx8+AnmsJ+Mgi0O7r60sCfc5+XY=;
        b=gpk1kAPjzB7bl7Wkw8IwDo0ezOtGPN58SjIHdBDyLj/u2x6jJ2oKZXAw1IItmIegG0miec
        8sZHD8LRjTJcgSXWYxpZvGVUo90cYPTFO+ZBy4iTOpgpUdElXeGZBO0HTk2I/llDHwxAUs
        YWeHh5BKusnw1vUmwGAUDcATYYVB4Vw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-Ta0Tss2ZObeKJ0-ZKV4TGA-1; Tue, 29 Mar 2022 20:47:44 -0400
X-MC-Unique: Ta0Tss2ZObeKJ0-ZKV4TGA-1
Received: by mail-lj1-f199.google.com with SMTP id q5-20020a2e9145000000b002497bf0eaa1so8062744ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 17:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nAylo5IpwXAoPRELTx8+AnmsJ+Mgi0O7r60sCfc5+XY=;
        b=WR9XLfE3UPZ9iyMpPtc1QUvKQ0kvH4pNbGlV97VlCceByZJ99NlfNkvVZGkn/3764a
         PTYwkJkSITQTt+SpdxJm2XWX4ZoaoQcclbykCJRb4p0ln14MsGjdv05sGzjP7a5dk/VG
         MCVwVjQyYu2xs07mUWR/cOb6fFRqfEUsI/55RNcAu9oi7jVnHPsOn3dCc17RL0EoiHv0
         gxCaxxZsD4In+STeiok7M0/oWR1kokF6Ki05Pe5cx+AaMs05vBxjjWECT3nUbfBhQBZ6
         Q4X1j9giEWSFUDKifluoht5hNvjZJpiiMF2Xu/4pDLEJB4rqbEMlg6Qji3TY+pmIbNyO
         zvnw==
X-Gm-Message-State: AOAM5312MdRasBFQIjrzMr78jyIwrImmGx5BQnUKKL8EbzQ4ZYC01qZU
        zZA1oX1mf+nfGIbnXyV06JvjG+DVrJdfzCm8EkECuzYAvSXJHoPgmZOBk4J2mg0iPbYdNsobZPy
        mmRbA7DkCmJ68ESMvEskXDs/a3Qf6rYUnYpy7/UhB8jzi+31f4FoU5GhjQ76DI18Jz0fuGzzKZg
        I=
X-Received: by 2002:ac2:4847:0:b0:44a:24b6:7e99 with SMTP id 7-20020ac24847000000b0044a24b67e99mr4826287lfy.279.1648601262857;
        Tue, 29 Mar 2022 17:47:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzO6TIz7tFG/OsyMvXsipWMnTwVVf/JV9vGBcN4ImwDDVo0wx4BipRownJSPkKzQEAqGyJDPw==
X-Received: by 2002:ac2:4847:0:b0:44a:24b6:7e99 with SMTP id 7-20020ac24847000000b0044a24b67e99mr4826273lfy.279.1648601262571;
        Tue, 29 Mar 2022 17:47:42 -0700 (PDT)
Received: from mjp-Z390-AORUS-MASTER.redhat.com (91-145-109-188.bb.dnainternet.fi. [91.145.109.188])
        by smtp.gmail.com with ESMTPSA id g12-20020a05651222cc00b0044a1065ca5fsm2146292lfu.304.2022.03.29.17.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 17:47:42 -0700 (PDT)
From:   mpenttil@redhat.com
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     apopple@nvidia.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
        jgg@ziepe.ca, vbabka@suse.cz,
        =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>
Subject: [PATCH v6] mm/hmm/test: use char dev with struct device to get device node
Date:   Wed, 30 Mar 2022 03:47:25 +0300
Message-Id: <20220330004725.13428-1-mpenttil@redhat.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
v6:
        - remove device names array
        - check return value of dev_set_name()
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


 lib/test_hmm.c                         | 13 ++++++++++---
 tools/testing/selftests/vm/test_hmm.sh |  6 ------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index cfe632047839..7d1f98bc9c9a 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -86,7 +86,7 @@ struct dmirror_chunk {
  */
 struct dmirror_device {
 	struct cdev		cdevice;
-	struct hmm_devmem	*devmem;
+	struct device		device;
 
 	unsigned int		devmem_capacity;
 	unsigned int		devmem_count;
@@ -1227,7 +1227,14 @@ static int dmirror_device_init(struct dmirror_device *mdevice, int id)
 
 	cdev_init(&mdevice->cdevice, &dmirror_fops);
 	mdevice->cdevice.owner = THIS_MODULE;
-	ret = cdev_add(&mdevice->cdevice, dev, 1);
+	device_initialize(&mdevice->device);
+	mdevice->device.devt = dev;
+
+	ret = dev_set_name(&mdevice->device, "hmm_dmirror%u", id);
+	if (ret)
+		return ret;
+
+	ret = cdev_device_add(&mdevice->cdevice, &mdevice->device);
 	if (ret)
 		return ret;
 
@@ -1254,7 +1261,7 @@ static void dmirror_device_remove(struct dmirror_device *mdevice)
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

