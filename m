Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E18A5A201C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 07:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244711AbiHZFGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 01:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiHZFGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 01:06:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B81A5FF6D
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 22:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661490405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=j5L7U70XfB7JJbqKJpFjRNU09Ztqe5oeNdPnEjrEBQE=;
        b=PCESbTpeNxnqQbPiYsLEfp6xd3HnDXNoOrwdtGRGQ1V6ADX+j8c6bEegBv518/LJeoAF2A
        ZPhlTXauFXEntYo4ZLpADCctmXC4p7dlMMkNi+TKVJBvOLT8O7GHmcyK0vXV0Jn4eNAIEP
        f302TYB0/dFBFWDcJGQHHPS0ALuwVko=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-593-3qsgR1lXMfSE2gOlJWhz5g-1; Fri, 26 Aug 2022 01:06:43 -0400
X-MC-Unique: 3qsgR1lXMfSE2gOlJWhz5g-1
Received: by mail-lf1-f72.google.com with SMTP id w18-20020ac25d52000000b0048af13b6ef6so112369lfd.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 22:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=j5L7U70XfB7JJbqKJpFjRNU09Ztqe5oeNdPnEjrEBQE=;
        b=ukM05Cwoj1DRrsVy/mqQ7sqEkHusQ+yHcBWqXLA2w7REoIY5l9Aof78jqo/hsyPQ3T
         d+vVJLMxZr97W3f41xSLL/6FJ+nuA7v5vG2wqF3LQhcXKmLRZSSAr0j7gxWud24XH66Q
         V/J9NO8EjKleGB2ypy95u9qvm1dSA6OawO/Y3QvJ3M7CGPREFCJ2+iTe4Fn56Mcy7vE3
         /pADFVzioeIzxdwf6CBX1iY21O35U3+DaV5iUq472R7LGCwOV5nVdifcE1Tx+ElF7/wC
         AFBjaMAbBFKT+KAtX2QBIdJVagVaEE+iZO8ExeapzcFejooUqaAhjVM7+lgvXIEgmTRw
         3R6w==
X-Gm-Message-State: ACgBeo2FqE52ISI/4ToNU1MLSGRLtmHLIwmGwJM6zVyFQii3WF3gXwK1
        STHFFYQ9KuOKQYtfPID3gfIALauJB5ghCCutfB6A8GmEdExr46B2TIr6lbp+WMNl+yhpJ2kF6i4
        fdJcQg/YRXONZH3NykHQwJpO3Mk6AhdO98Cho8RX0mFSCSbqnC80rn8IUyJoQLjvbJCqVeMeOrN
        k=
X-Received: by 2002:a05:651c:550:b0:261:c6c8:72ef with SMTP id q16-20020a05651c055000b00261c6c872efmr1959831ljp.313.1661490401927;
        Thu, 25 Aug 2022 22:06:41 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7KhnNWZPdexwn2fqKJLP2Kf5/TOYnhw+PhVAFrvK1VpkotIkBy7Oo3f3JabcMtk7Fj4fUTag==
X-Received: by 2002:a05:651c:550:b0:261:c6c8:72ef with SMTP id q16-20020a05651c055000b00261c6c872efmr1959820ljp.313.1661490401685;
        Thu, 25 Aug 2022 22:06:41 -0700 (PDT)
Received: from mjp-Z390-AORUS-MASTER.redhat.com (91-145-109-188.bb.dnainternet.fi. [91.145.109.188])
        by smtp.gmail.com with ESMTPSA id o20-20020ac24e94000000b0048b193f677dsm219269lfr.178.2022.08.25.22.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 22:06:41 -0700 (PDT)
From:   mpenttil@redhat.com
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     apopple@nvidia.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
        jgg@ziepe.ca, vbabka@suse.cz,
        =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>
Subject: [PATCH v8] mm/hmm/test: use char dev with struct device to get device node
Date:   Fri, 26 Aug 2022 08:06:31 +0300
Message-Id: <20220826050631.25771-1-mpenttil@redhat.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mika Penttilä <mpenttil@redhat.com>

HMM selftests use an in-kernel pseudo device to emulate device
memory. The pseudo device registers a major device range for two or
four pseudo device instances. User space has a script that
reads /proc/devices in order to find the assigned major number,
and sends that to mknod(1), once for each node.

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
v8:
        - refresh for device coherent
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
 tools/testing/selftests/vm/test_hmm.sh | 10 ----------
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index e3965cafd27c..6a33f6b1b465 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -107,8 +107,8 @@ struct dmirror_chunk {
  */
 struct dmirror_device {
 	struct cdev		cdevice;
-	struct hmm_devmem	*devmem;
 	unsigned int            zone_device_type;
+	struct device		device;
 
 	unsigned int		devmem_capacity;
 	unsigned int		devmem_count;
@@ -1390,7 +1390,14 @@ static int dmirror_device_init(struct dmirror_device *mdevice, int id)
 
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
 
@@ -1416,7 +1423,7 @@ static void dmirror_device_remove(struct dmirror_device *mdevice)
 		kfree(mdevice->devmem_chunks);
 	}
 
-	cdev_del(&mdevice->cdevice);
+	cdev_device_del(&mdevice->cdevice, &mdevice->device);
 }
 
 static int __init hmm_dmirror_init(void)
diff --git a/tools/testing/selftests/vm/test_hmm.sh b/tools/testing/selftests/vm/test_hmm.sh
index 539c9371e592..46e19b5d648d 100755
--- a/tools/testing/selftests/vm/test_hmm.sh
+++ b/tools/testing/selftests/vm/test_hmm.sh
@@ -52,21 +52,11 @@ load_driver()
 			usage
 		fi
 	fi
-	if [ $? == 0 ]; then
-		major=$(awk "\$2==\"HMM_DMIRROR\" {print \$1}" /proc/devices)
-		mknod /dev/hmm_dmirror0 c $major 0
-		mknod /dev/hmm_dmirror1 c $major 1
-		if [ $# -eq 2 ]; then
-			mknod /dev/hmm_dmirror2 c $major 2
-			mknod /dev/hmm_dmirror3 c $major 3
-		fi
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

