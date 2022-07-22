Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBA357DCE2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbiGVIvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbiGVIue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:50:34 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9AF30F77;
        Fri, 22 Jul 2022 01:50:33 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t3-20020a17090a3b4300b001f21eb7e8b0so6994745pjf.1;
        Fri, 22 Jul 2022 01:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ZQ5kPkHtyDecpdBs3hMRWo2GqFD03eIO0NfZtVc+O4=;
        b=DVKLZm5X2YxI/hHtBVSmt5Myni1GZ/sy0ItyEQawn8DWmwBpC/+/diVmqnaUnVF8Zn
         Q86viinljGXvI+oe/fcBVa+5NGI3wdU8YiauOkshPf88zhnjTFpVCaLXpPaRks1W5Qx4
         CWrZf8zEnBvNtOo58LLdphc6Hml46aZ9BppOHKfosXSc5yMwtj6zMnQwQHYkTEO8p2hg
         4NfnZXAyg8BNln6Z5NE1RVxZ51EoIaONKwzkvwhfLksCRov3ZA2GZEIIFAlgUfIsoM78
         9yH5u4AKP3KRMytt5bX/QwvnOhRXzC9tWapeLjyX/YnLzsZMZTwa9WoKoZ4SNlYlLYyP
         Hdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ZQ5kPkHtyDecpdBs3hMRWo2GqFD03eIO0NfZtVc+O4=;
        b=xUccBKB9LinFrRyh0qmiXVy9sOfd3ViTWtvGbNu2bUyTUmC+UAngeWMJzF2IrtbUjL
         2kQ4YFhyR0r6P21iVrEslyETTFPcd0CpHhyuUfB0/FjPaomJSuYeHz5/kMT/5AFLx+5D
         yzGOEG/+a0XTsp2Jxwe6IoIALsWBJRP3OKWv8fEcK1xeBl5ZLOx8JYDiFVqQ9nBXSh+w
         YqVSQE9EIEUwxI86fn/oixG5vhItqfbCzy+az+Z3JPs1tn6k8eM53RDsc9X46Q45zPN6
         VQShs0bd+2MvoS99YE078jWLWiryFHE5987jUZp1J0htHcR5m/9gFzZek+Btnyo98OXm
         BVbQ==
X-Gm-Message-State: AJIora8vSHrmsqgzdrSjs0Zyg35XWdicdXGiG5Qm2pK3S5zIz8nyMqGk
        /pQuVA3peML8vrFIhwEdYqVT6enh/mk=
X-Google-Smtp-Source: AGRyM1v/n3N6pUtAoflXr4rbN4DXL8mbPl10cRpA9jhBTUyB0AUCiqNy6e4YumTRaBnfVvGJXmPHWQ==
X-Received: by 2002:a17:902:6a8c:b0:16d:1f3f:e184 with SMTP id n12-20020a1709026a8c00b0016d1f3fe184mr2384380plk.73.1658479833205;
        Fri, 22 Jul 2022 01:50:33 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-91.three.co.id. [180.214.233.91])
        by smtp.gmail.com with ESMTPSA id j7-20020a170903024700b0016c20d40ee7sm3213447plh.174.2022.07.22.01.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 01:50:32 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 7A339104980; Fri, 22 Jul 2022 15:50:23 +0700 (WIB)
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
Subject: [PATCH 4/8] Documentation: s390: use code blocks for virsh and qemu output
Date:   Fri, 22 Jul 2022 15:49:43 +0700
Message-Id: <20220722084946.22965-5-bagasdotme@gmail.com>
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

virsh and qemu output blocks are formatted with definition lists,
however Sphinx isn't happy with the formatting:

Documentation/s390/vfio-ap.rst:998: WARNING: Definition list ends without a blank line; unexpected unindent.
Documentation/s390/vfio-ap.rst:999: WARNING: Definition list ends without a blank line; unexpected unindent.
Documentation/s390/vfio-ap.rst:1038: WARNING: Definition list ends without a blank line; unexpected unindent.
Documentation/s390/vfio-ap.rst:1039: WARNING: Definition list ends without a blank line; unexpected unindent.

Use code blocks instead, which are more appropriate. While at it, also
describe virsh commands where --hmp flag is given.

Link:https://lore.kernel.org/linux-next/20220721205937.10043b5f@canb.auug.org.au/
Fixes: cb269e0aba7c3f ("s390/vfio-ap: update docs to include dynamic config support")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/s390/vfio-ap.rst | 88 ++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 40 deletions(-)

diff --git a/Documentation/s390/vfio-ap.rst b/Documentation/s390/vfio-ap.rst
index c0d76a959ed583..920d67ab7b06ff 100644
--- a/Documentation/s390/vfio-ap.rst
+++ b/Documentation/s390/vfio-ap.rst
@@ -995,70 +995,78 @@ the mdev is in use by a KVM guest. If the guest is being emulated by QEMU,
 its mdev can be hot unplugged from the guest in one of two ways:
 
 1. If the KVM guest was started with libvirt, you can hot unplug the mdev via
-   the following commands:
+   the following commands::
 
       virsh detach-device <guestname> <path-to-device-xml>
 
-      For example, to hot unplug mdev 62177883-f1bb-47f0-914d-32a22e3a8804 from
-      the guest named 'my-guest':
+   For example, to hot unplug mdev 62177883-f1bb-47f0-914d-32a22e3a8804 from
+   the guest named 'my-guest'::
 
-         virsh detach-device my-guest ~/config/my-guest-hostdev.xml
+      virsh detach-device my-guest ~/config/my-guest-hostdev.xml
 
-            The contents of my-guest-hostdev.xml:
+   The contents of my-guest-hostdev.xml:
 
-            <hostdev mode='subsystem' type='mdev' managed='no' model='vfio-ap'>
-              <source>
-                <address uuid='62177883-f1bb-47f0-914d-32a22e3a8804'/>
-              </source>
-            </hostdev>
+      .. code-block:: xml
 
+         <hostdev mode='subsystem' type='mdev' managed='no' model='vfio-ap'>
+           <source>
+             <address uuid='62177883-f1bb-47f0-914d-32a22e3a8804'/>
+           </source>
+         </hostdev>
+
+
+   To hot unplug the vfio_ap mediated device identified on the qemu command
+   line, use::
 
       virsh qemu-monitor-command <guest-name> --hmp "device-del <device-id>"
 
-      For example, to hot unplug the vfio_ap mediated device identified on the
-      qemu command line with 'id=hostdev0' from the guest named 'my-guest':
+   For example, to hot unplug the vfio_ap mediated device identified on the
+   qemu command line with 'id=hostdev0' from the guest named 'my-guest'::
 
-         virsh qemu-monitor-command my-guest --hmp "device_del hostdev0"
+      virsh qemu-monitor-command my-guest --hmp "device_del hostdev0"
 
 2. A vfio_ap mediated device can be hot unplugged by attaching the qemu monitor
-   to the guest and using the following qemu monitor command:
+   to the guest and using the following qemu monitor command::
 
       (QEMU) device-del id=<device-id>
 
-      For example, to hot unplug the vfio_ap mediated device that was specified
-      on the qemu command line with 'id=hostdev0' when the guest was started:
+   For example, to hot unplug the vfio_ap mediated device that was specified
+   on the qemu command line with 'id=hostdev0' when the guest was started::
 
-         (QEMU) device-del id=hostdev0
+      (QEMU) device-del id=hostdev0
 
 After live migration of the KVM guest completes, an AP configuration can be
 restored to the KVM guest by hot plugging a vfio_ap mediated device on the target
 system into the guest in one of two ways:
 
 1. If the KVM guest was started with libvirt, you can hot plug a matrix mediated
-   device into the guest via the following virsh commands:
+   device into the guest via the following virsh commands::
 
-   virsh attach-device <guestname> <path-to-device-xml>
+      virsh attach-device <guestname> <path-to-device-xml>
 
-      For example, to hot plug mdev 62177883-f1bb-47f0-914d-32a22e3a8804 into
-      the guest named 'my-guest':
+   For example, to hot plug mdev 62177883-f1bb-47f0-914d-32a22e3a8804 into
+   the guest named 'my-guest'::
 
-         virsh attach-device my-guest ~/config/my-guest-hostdev.xml
+      virsh attach-device my-guest ~/config/my-guest-hostdev.xml
 
-            The contents of my-guest-hostdev.xml:
+   The contents of my-guest-hostdev.xml:
 
-            <hostdev mode='subsystem' type='mdev' managed='no' model='vfio-ap'>
-              <source>
-                <address uuid='62177883-f1bb-47f0-914d-32a22e3a8804'/>
-              </source>
-            </hostdev>
+   .. code-block:: xml
 
+      <hostdev mode='subsystem' type='mdev' managed='no' model='vfio-ap'>
+           <source>
+             <address uuid='62177883-f1bb-47f0-914d-32a22e3a8804'/>
+           </source>
+      </hostdev>
 
-   virsh qemu-monitor-command <guest-name> --hmp \
-   "device_add vfio-ap,sysfsdev=<path-to-mdev>,id=<device-id>"
+   To hot plug vfio_ap mediated device, use::
 
-      For example, to hot plug the vfio_ap mediated device
-      62177883-f1bb-47f0-914d-32a22e3a8804 into the guest named 'my-guest' with
-      device-id hostdev0:
+      virsh qemu-monitor-command <guest-name> --hmp \
+      "device_add vfio-ap,sysfsdev=<path-to-mdev>,id=<device-id>"
+
+   For example, to hot plug the vfio_ap mediated device
+   ``62177883-f1bb-47f0-914d-32a22e3a8804`` into the guest named 'my-guest'
+   with device-id hostdev0::
 
       virsh qemu-monitor-command my-guest --hmp \
       "device_add vfio-ap,\
@@ -1066,14 +1074,14 @@ system into the guest in one of two ways:
       id=hostdev0"
 
 2. A vfio_ap mediated device can be hot plugged by attaching the qemu monitor
-   to the guest and using the following qemu monitor command:
+   to the guest and using the following qemu monitor command::
 
       (qemu) device_add "vfio-ap,sysfsdev=<path-to-mdev>,id=<device-id>"
 
-      For example, to plug the vfio_ap mediated device
-      62177883-f1bb-47f0-914d-32a22e3a8804 into the guest with the device-id
-      hostdev0:
+   For example, to plug the vfio_ap mediated device
+   ``62177883-f1bb-47f0-914d-32a22e3a8804`` into the guest with the device-id
+   hostdev0::
 
-         (QEMU) device-add "vfio-ap,\
-         sysfsdev=/sys/devices/vfio_ap/matrix/62177883-f1bb-47f0-914d-32a22e3a8804,\
-         id=hostdev0"
+      (QEMU) device-add "vfio-ap,\
+      sysfsdev=/sys/devices/vfio_ap/matrix/62177883-f1bb-47f0-914d-32a22e3a8804,\
+      id=hostdev0"
-- 
An old man doll... just what I always wanted! - Clara

