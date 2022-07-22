Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E93957DCE5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbiGVIvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbiGVIuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:50:32 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA3B27CCF;
        Fri, 22 Jul 2022 01:50:31 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gn24so3814687pjb.3;
        Fri, 22 Jul 2022 01:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E/k5RCOqp4l8e/X8YSW8RAC7hl6FhMb1nEHkDDI4VqI=;
        b=NK8kP9v/27/rHyHa0CAOwc3ULlDg8vvHqkVCR6DCXkAV5cSCpvotRrSWd2P3GJSwdw
         hmwr2fabn/yDmMeaQZIFDY0G/wOcx/6SrsYsia77wH3Tp7llbhRnYiY5C3F22e45KZdf
         0xyXysOiuP/vI1sEbdygAb0hUM7j6rBx5r0TxyY2tFbYvuuyX59+zUalaGF47RxcIVF9
         mnfewKYci49PQPND/M9QeLC8w02ZZsXd+dl/XUvfl3BF5itnZSH08fYdMmFxa8RSA0hp
         sSQFTCLkpfKvW1biU461B+GAKr8B1K98BZdoPOrGYygnwqttKDk5K7pxoLvAvz7alY31
         ygRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E/k5RCOqp4l8e/X8YSW8RAC7hl6FhMb1nEHkDDI4VqI=;
        b=MP+VZf3Myu0A0QEiHA1ZbebwOm9ViCFIuwC084kNhnhj9shEyjnL8Ifk53lIp7CdGk
         GbpRwPxMy7LUWN15cWHarOEa+ZogWtnn8Q1/R3AA4ux1S2pM79ocr56P8EPt9xAXWavF
         AkGj+sqdxja2pu3Xhc/ZmCWidiGfE028j+D+2GMdLzYS/q9/wUzEce+Q+nk098K+jkbt
         8NWn+2ghxKWtAGu36yOJmpMPevFc0dUOVolVBevPOcgdrQ4LPuRfUG6GDzOKBw/Lmdz4
         NHM+LhJIbuRC1u+dz/5VPR7Ow/3DcaZkYDXSOgbVUXxYcoDl1sYp0W6wJLjXuGt183jA
         oL+g==
X-Gm-Message-State: AJIora8US209aEP8QWj+ogO/qLttXo8YUzrTqL0L8ylBwhD0qPfMdY4H
        m2SEhG0XSSjZGOtSFzYYyNM=
X-Google-Smtp-Source: AGRyM1vQhaO3jrrh+otrq6YcHEp2H/n0sVGK5hWk4mbXlwUC7VPwTqbEuErjW6ANBO88mC728LJMRA==
X-Received: by 2002:a17:902:da8f:b0:16d:1c82:624b with SMTP id j15-20020a170902da8f00b0016d1c82624bmr2497497plx.163.1658479831175;
        Fri, 22 Jul 2022 01:50:31 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-91.three.co.id. [180.214.233.91])
        by smtp.gmail.com with ESMTPSA id 22-20020a631556000000b003fd9b8b865dsm2999988pgv.0.2022.07.22.01.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 01:50:29 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id EEA7A104987; Fri, 22 Jul 2022 15:50:23 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Halil Pasic <pasic@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 5/8] Documentation: s390: use code block for structs
Date:   Fri, 22 Jul 2022 15:49:44 +0700
Message-Id: <20220722084946.22965-6-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722084946.22965-1-bagasdotme@gmail.com>
References: <20220722084946.22965-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vfio-ap-locking documentation, struct code samples aren't inside code
blocks, hence trigger many inline emphasis and definition list warnings.

Use code blocks for them.

Link: https://lore.kernel.org/linux-next/20220721201058.2a276286@canb.auug.org.au/
Fixes: e32d3827f3d5b2 ("s390/Docs: new doc describing lock usage by the vfio_ap device driver")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/s390/vfio-ap-locking.rst | 64 +++++++++++++++-----------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/Documentation/s390/vfio-ap-locking.rst b/Documentation/s390/vfio-ap-locking.rst
index c4e1eeec79a0f5..4194b78ace0e94 100644
--- a/Documentation/s390/vfio-ap-locking.rst
+++ b/Documentation/s390/vfio-ap-locking.rst
@@ -5,21 +5,23 @@ VFIO AP Locks Overview
 ======================
 This document describes the locks that are pertinent to the secure operation
 of the vfio_ap device driver. Throughout this document, the following variables
-will be used to denote instances of the structures herein described:
+will be used to denote instances of the structures herein described::
 
-struct ap_matrix_dev *matrix_dev;
-struct ap_matrix_mdev *matrix_mdev;
-struct kvm *kvm;
+   struct ap_matrix_dev *matrix_dev;
+   struct ap_matrix_mdev *matrix_mdev;
+   struct kvm *kvm;
 
 The Matrix Devices Lock (drivers/s390/crypto/vfio_ap_private.h)
 --------------------------------------------------------------
 
-struct ap_matrix_dev {
-	...
-	struct list_head mdev_list;
-	struct mutex mdevs_lock;
-	...
-}
+::
+
+   struct ap_matrix_dev {
+	   ...
+	   struct list_head mdev_list;
+	   struct mutex mdevs_lock;
+	   ...
+   }
 
 The Matrix Devices Lock (matrix_dev->mdevs_lock) is implemented as a global
 mutex contained within the single object of struct ap_matrix_dev. This lock
@@ -31,11 +33,13 @@ representing one of the vfio_ap device driver's mediated devices.
 The KVM Lock (include/linux/kvm_host.h)
 ---------------------------------------
 
-struct kvm {
-	...
-	struct mutex lock;
-	...
-}
+::
+
+   struct kvm {
+	   ...
+	   struct mutex lock;
+	   ...
+   }
 
 The KVM Lock (kvm->lock) controls access to the state data for a KVM guest. This
 lock must be held by the vfio_ap device driver while one or more AP adapters,
@@ -48,12 +52,14 @@ been attached to the KVM guest.
 The Guests Lock (drivers/s390/crypto/vfio_ap_private.h)
 -----------------------------------------------------------
 
-struct ap_matrix_dev {
-	...
-	struct list_head mdev_list;
-	struct mutex guests_lock;
-	...
-}
+::
+
+   struct ap_matrix_dev {
+	   ...
+	   struct list_head mdev_list;
+	   struct mutex guests_lock;
+	   ...
+   }
 
 The Guests Lock (matrix_dev->guests_lock) controls access to the
 matrix_mdev instances (matrix_dev->mdev_list) that represent mediated devices
@@ -89,14 +95,16 @@ resources, so only the matrix_dev->mdevs_lock needs to be held.
 The PQAP Hook Lock (arch/s390/include/asm/kvm_host.h)
 -----------------------------------------------------
 
-typedef int (*crypto_hook)(struct kvm_vcpu *vcpu);
+::
 
-struct kvm_s390_crypto {
-	...
-	struct rw_semaphore pqap_hook_rwsem;
-	crypto_hook *pqap_hook;
-	...
-};
+   typedef int (*crypto_hook)(struct kvm_vcpu *vcpu);
+
+   struct kvm_s390_crypto {
+	   ...
+	   struct rw_semaphore pqap_hook_rwsem;
+	   crypto_hook *pqap_hook;
+	   ...
+   };
 
 The PQAP Hook Lock is a r/w semaphore that controls access to the function
 pointer of the handler (*kvm->arch.crypto.pqap_hook) to invoke when the
-- 
An old man doll... just what I always wanted! - Clara

