Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3543597996
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 00:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242203AbiHQWUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 18:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242198AbiHQWUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 18:20:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6939BAB1B2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 15:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660774801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tgD0w40ykfLq0hhWVAK/Qtzoj+JD36KjwjjFiVONT2U=;
        b=go2usxoMtEQ4Nx0F1Wp5Bw0b6WW1aQTUsQs8nmAXQN8k/OhB1tLm2SK/w+ZeZ4huEg7Sak
        zUtlioVje2ZDlwCW6XKGRLzmQb6L2QEcyM7umyjf4588y5y4GU1fCEIpqwUXhR55YeCja9
        5BTzILn0N59WWhoJXZFN5RnWVXj/JMc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-nPetUFiwNy-eSdFWlUC4Lg-1; Wed, 17 Aug 2022 18:19:59 -0400
X-MC-Unique: nPetUFiwNy-eSdFWlUC4Lg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F23C101A588;
        Wed, 17 Aug 2022 22:19:59 +0000 (UTC)
Received: from localhost (unknown [10.39.192.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1D16492C3B;
        Wed, 17 Aug 2022 22:19:58 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] Documentation: add basic information on vDPA
Date:   Wed, 17 Aug 2022 18:19:56 -0400
Message-Id: <20220817221956.1149183-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vDPA driver framework is largely undocumented. Add a basic page that
describes what vDPA is, where to get more information, and how to use
the simulator for testing.

In the future it would be nice to add an overview of the driver API as
well as comprehensive doc comments.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Documentation/driver-api/index.rst |  1 +
 Documentation/driver-api/vdpa.rst  | 40 ++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 Documentation/driver-api/vdpa.rst

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index d3a58f77328e..e307779568d4 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -103,6 +103,7 @@ available subsections can be seen below.
    switchtec
    sync_file
    tty/index
+   vdpa
    vfio-mediated-device
    vfio
    vfio-pci-device-specific-driver-acceptance
diff --git a/Documentation/driver-api/vdpa.rst b/Documentation/driver-api/vdpa.rst
new file mode 100644
index 000000000000..75c666548e1d
--- /dev/null
+++ b/Documentation/driver-api/vdpa.rst
@@ -0,0 +1,40 @@
+====================================
+vDPA - VIRTIO Data Path Acceleration
+====================================
+
+The vDPA driver framework can be used to implement VIRTIO devices that are
+backed by physical hardware or by software. While the device's data path
+complies with the VIRTIO specification, the control path is driver-specific and
+a netlink interface exists for instantiating devices.
+
+vDPA devices can be attached to the kernel's VIRTIO device drivers or exposed
+to userspace emulators/virtualizers such as QEMU through vhost.
+
+The driver API is not documented beyond the doc comments in <linux/vdpa.h>. The
+netlink API is not documented beyond the doc comments in <linux/uapi/vdpa.h>.
+The existing vDPA drivers serve as reference code for those wishing to develop
+their own drivers.
+
+See https://vdpa-dev.gitlab.io/ for more information about vDPA.
+
+Questions can be sent to the virtualization@lists.linux-foundation.org mailing
+list.
+
+Device simulators
+-----------------
+
+There are software vDPA device simulators for testing, prototyping, and
+development purposes. The simulators do not require physical hardware.
+
+Available simulators include:
+
+- `vdpa_sim_net` implements a virtio-net loopback device.
+- `vdpa_sim_blk` implements a memory-backed virtio-blk device.
+
+To use `vdpa_sim_blk` through vhost::
+
+  # modprobe vhost_vdpa
+  # modprobe vdpa_sim_blk
+  # vdpa dev add name vdpa-blk1 mgmtdev vdpasim_blk
+  ...use /dev/vhost-dev-0...
+  # vdpa dev del vdpa-blk1
-- 
2.37.2

