Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF0C57DCE8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbiGVIvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbiGVIug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:50:36 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9FB3120F;
        Fri, 22 Jul 2022 01:50:33 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w7so4045846plp.5;
        Fri, 22 Jul 2022 01:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ceEYPzRSeSpxrJgH4dqtQc5ZKG3XNVZNdz1910Rs8+E=;
        b=HSLDQch/EhbwJQ6FNPDijFTX2F0ymRVo8ZZxJYr+dzvQb/35Mc2JgW/y/ik9o8ak3D
         /O+C85BjaJT92jdVmz8y65nNMMSIUaYKvOckIwdoxEb5kcaD0GTBCWohNpGw9LexUlaO
         GRUNr3h/BhzN5H4Ui1bDcBavy6lGUnBT01OhKxypZkXeQWH6lZEWjmkc6YC/ux2+QuD8
         ud3dnLy1lWG1Gkd18/IRKEjL04ItnhUB6/2xiI53VhrB6zIc/wUP4wqoLUIBz4T5Kogc
         RTqWh28WkNiB5xHFw33KOn9EjVHacQ+RwA7gGtrjaxwanaGDYcjXp6qcJIEZh3NeXAZ9
         BpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ceEYPzRSeSpxrJgH4dqtQc5ZKG3XNVZNdz1910Rs8+E=;
        b=CnyBhXjJFA6tSeABAqoOobWN9SawYhuWNqy5fLkIV+naSGuxA7bIz6KewAroRxQZR1
         R1SABI/U+AzBc/74B32XHyH+BPcm/TqNu/DXOTMMM9OmQQg4/qXJjY5f2/WLpJE5s5oS
         a0dTDSXwyfHYbNfQxw0rFYSoglzOW1TgqeVlDmmi1CkLTaQ7B8UyEBNPwUgZnSetc5MK
         tgRGNrU4SjIHYQkw6IVqJL7LSnGQp3WWLmxpI6QL3eGXBi8Mh82/xver4Cwo1CS0JC8h
         ZAx4sRShugoVuqy+ajyyh1ittVifgssqYfnJnshNPo9Lt2AGb47yOwE/ogiE4Cu9jIzV
         DMOg==
X-Gm-Message-State: AJIora+unEQ9Ofaio1WpgJQ2zlwzGhI/GJgBWQbFi+P9V0T/TbZ9A86x
        P8h5BoGsPwzyDeI/Lj4nis8=
X-Google-Smtp-Source: AGRyM1ul9sEqgoURfnWwdMVnDPgz0X76SFB0LjCpcfiAzhoTS0E3qWEj50ZWAxplHTLfuGDnazv6kQ==
X-Received: by 2002:a17:90b:3e89:b0:1f0:4233:b20e with SMTP id rj9-20020a17090b3e8900b001f04233b20emr3062372pjb.0.1658479833053;
        Fri, 22 Jul 2022 01:50:33 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-91.three.co.id. [180.214.233.91])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902654a00b0016d1e514ec5sm3081418pln.139.2022.07.22.01.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 01:50:32 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 954F6104983; Fri, 22 Jul 2022 15:50:23 +0700 (WIB)
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
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 2/8] Documentation: s390: use note directive for remaining notes
Date:   Fri, 22 Jul 2022 15:49:41 +0700
Message-Id: <20220722084946.22965-3-bagasdotme@gmail.com>
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

Convert remaining vfio-ap.rst notes to use note directive, while also
fix maximum sysfs notes being rendered as definition lists instead.

Fixes: cb269e0aba7c3f ("s390/vfio-ap: update docs to include dynamic config support")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/s390/vfio-ap.rst | 51 +++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/Documentation/s390/vfio-ap.rst b/Documentation/s390/vfio-ap.rst
index 7aea0afe2ef390..5bf15d117c4ba0 100644
--- a/Documentation/s390/vfio-ap.rst
+++ b/Documentation/s390/vfio-ap.rst
@@ -475,24 +475,29 @@ following CPU model features:
    guest. This facility can be made available to the guest only if it is
    available on the host (i.e., facility bit 65 is set).
 
-Note: If the user chooses to specify a CPU model different than the 'host'
-model to QEMU, the CPU model features and facilities need to be turned on
-explicitly; for example::
+   .. note::
 
-     /usr/bin/qemu-system-s390x ... -cpu z13,ap=on,apqci=on,apft=on,apqi=on
+      If the user chooses to specify a CPU model different than the 'host'
+      model to QEMU, the CPU model features and facilities need to be turned
+      on explicitly; for example::
 
-A guest can be precluded from using AP features/facilities by turning them off
-explicitly; for example::
+         /usr/bin/qemu-system-s390x ... -cpu z13,ap=on,apqci=on,apft=on,apqi=on
 
-     /usr/bin/qemu-system-s390x ... -cpu host,ap=off,apqci=off,apft=off,apqi=off
+      A guest can be precluded from using AP features/facilities by turning
+      them off explicitly; for example::
 
-Note: If the APFT facility is turned off (apft=off) for the guest, the guest
-will not see any AP devices. The zcrypt device drivers on the guest that
-register for type 10 and newer AP devices - i.e., the cex4card and cex4queue
-device drivers - need the APFT facility to ascertain the facilities installed on
-a given AP device. If the APFT facility is not installed on the guest, then no
-adapter or domain devices will get created by the AP bus running on the
-guest because only type 10 and newer devices can be configured for guest use.
+         /usr/bin/qemu-system-s390x ... -cpu host,ap=off,apqci=off,apft=off,apqi=off
+
+   .. note::
+
+      If the APFT facility is turned off (apft=off) for the guest, the guest
+      will not see any AP devices. The zcrypt device drivers on the guest that
+      register for type 10 and newer AP devices - i.e., the cex4card and
+      cex4queue device drivers - need the APFT facility to ascertain the
+      facilities installed on a given AP device. If the APFT facility is not
+      installed on the guest, then no adapter or domain devices will get
+      created by the AP bus running on the guest because only type 10 and
+      newer devices can be configured for guest use.
 
 Example
 =======
@@ -802,8 +807,10 @@ Securing the APQNs for our example
      ----------------unassign_control_domain
      ----------------unassign_domain
 
-   Note *****: The vfio_ap mdevs do not persist across reboots unless the
-               mdevctl tool is used to create and persist them.
+   .. note::
+
+      The vfio_ap mdevs do not persist across reboots unless the
+      mdevctl tool is used to create and persist them.
 
 4. The administrator now needs to configure the matrixes for the mediated
    devices $uuid1 (for Guest1), $uuid2 (for Guest2) and $uuid3 (for Guest3).
@@ -849,8 +856,10 @@ Securing the APQNs for our example
      higher than the maximum is specified, the operation will terminate with
      an error (ENODEV).
 
-     Note: The maximum adapter number can be obtained via the sysfs
-	   /sys/bus/ap/ap_max_adapter_id attribute file.
+     .. note::
+
+        The maximum adapter number can be obtained via the sysfs
+        /sys/bus/ap/ap_max_adapter_id
 
    * Each APQN derived from the Cartesian product of the APID of the adapter
      being assigned and the APQIs of the domains previously assigned:
@@ -875,8 +884,10 @@ Securing the APQNs for our example
      higher than the maximum is specified, the operation will terminate with
      an error (ENODEV).
 
-     Note: The maximum domain number can be obtained via the sysfs
-	   /sys/bus/ap/ap_max_domain_id attribute file.
+     .. note::
+
+        The maximum domain number can be obtained via the sysfs
+	/sys/bus/ap/ap_max_domain_id
 
     * Each APQN derived from the Cartesian product of the APQI of the domain
       being assigned and the APIDs of the adapters previously assigned:
-- 
An old man doll... just what I always wanted! - Clara

