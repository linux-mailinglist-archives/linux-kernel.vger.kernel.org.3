Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CE34FB181
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 03:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244315AbiDKBwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 21:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243358AbiDKBww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 21:52:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 880481087
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 18:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649641838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=p/2biTee5ymHX+ysegqA4Y0DC0Buk2p13tKUXAlQbkQ=;
        b=RFbj70rWypPFAy3Jz885UMRIEtFaaSaZHbymzyEKQzv7ODSu+DVQXzHb+R5ocWVafLcbGl
        zZFS22ZCQNv9sz3XyrC/e8vcwlZu+hcBnz19FAgfyf2AMvLsI8BLnhyr9cT6Gsh+p5v4Zl
        1ZnyX0nvZE/LJPNpi9f7JWnRMGzFyWk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-hOLKBhFTPUKi07o-0nmxnQ-1; Sun, 10 Apr 2022 21:50:37 -0400
X-MC-Unique: hOLKBhFTPUKi07o-0nmxnQ-1
Received: by mail-lj1-f200.google.com with SMTP id p19-20020a2e9ad3000000b0024b5b97bd71so1546443ljj.22
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 18:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p/2biTee5ymHX+ysegqA4Y0DC0Buk2p13tKUXAlQbkQ=;
        b=zlPi75Mq1UNuUwjKcrfl53Skv49j+9pdTQO1l4nYvclZPXyrA1wM7dYv1Qn3T1YbVQ
         dR3gh8W8Ps6frXCEgZEDUCsc8rd0OC7y7dGbI5avHa3Iuj14dh2732MrFPY59U/MwqVX
         6PfmKbVyAx82Jmt6nGR9r7AuozEWQRBOSdrlUbPUIF8lnpl5awNTtsutzG+TTx38Ep+s
         uKcntSM/ukgnWDG3yv1t9Pv4te7eigXDeyxICI3kZbKsmyo4uZ+HA9DLdPqlqCuF9OEM
         M9WS5wxlZgjg7vFfmq1x2/zngA8714rU+S7ewD+5zDgE5V1pefhfJNSjFnfFLJharuf0
         5fMg==
X-Gm-Message-State: AOAM531yV31e7hJdIz9klRBTMc09mbEpL49xLjjOD+Dg2nmcHBOdKGqT
        Q3AGEk3L52l/VEpOMJD0SB8SQ+N2xCFqC5RAEj7FkO3m3QA/4++j4cMjvG99yOgLN4jfCMs9e+x
        hwZRQj6bF1jGK5Sygtv3ObDzOfmwL9cNnJUy5G8diloy3XfjHWyQ7uy9qYSiPZMQJaqJ9rbVOG9
        k=
X-Received: by 2002:a05:651c:1543:b0:249:a2bd:4a74 with SMTP id y3-20020a05651c154300b00249a2bd4a74mr19099809ljp.375.1649641835527;
        Sun, 10 Apr 2022 18:50:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2XKDfuejW16YO+ipmsqqgRU/ZaK3idz6+CJWo+M6ZaMFFXOi4n2r7mCo70yirfrN7aftAXA==
X-Received: by 2002:a05:651c:1543:b0:249:a2bd:4a74 with SMTP id y3-20020a05651c154300b00249a2bd4a74mr19099799ljp.375.1649641835212;
        Sun, 10 Apr 2022 18:50:35 -0700 (PDT)
Received: from mjp-Z390-AORUS-MASTER.redhat.com (91-145-109-188.bb.dnainternet.fi. [91.145.109.188])
        by smtp.gmail.com with ESMTPSA id t12-20020a2e954c000000b0024b00cc7539sm2898321ljh.109.2022.04.10.18.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 18:50:34 -0700 (PDT)
From:   mpenttil@redhat.com
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v7] mm/hmm/test: use char dev with struct device to get device node
Date:   Mon, 11 Apr 2022 04:50:05 +0300
Message-Id: <20220411015005.23464-1-mpenttil@redhat.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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

Change this to properly use cdev and struct device APIs.

Delete the /proc/devices parsing from the user-space test script, now
that it is unnecessary.

Also, deleted an unused field in struct dmirror_device: devmem.

Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
---
v7:
        - collected more Review-by's
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

