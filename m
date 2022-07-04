Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B56565CB8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 19:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbiGDRR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 13:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbiGDRRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 13:17:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29B90E030
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 10:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656955065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3nCsnklBQ1UFm+gqm+qDZbbdiHHfrXIDqEIncE//uIk=;
        b=iJ2S7DijcJo0hLMndwCkOtavKYM4mWlhFJPlvfjftmO8y8uUpznD57JEHZ/jdaPi2aFiuk
        3/vF7BX1ZbxY2UeA2dED6Z/OBsffQmSAW7UISk4oagla4UOgUYRyuvx4UjBXOInkvXjeYT
        YVDa6oC3SYuF2FKBQqgK5Eqssv10I+s=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-IoNL84AAPmehhhwEzGuCKg-1; Mon, 04 Jul 2022 13:17:44 -0400
X-MC-Unique: IoNL84AAPmehhhwEzGuCKg-1
Received: by mail-qt1-f199.google.com with SMTP id cf8-20020a05622a400800b0031e80dcf14cso784437qtb.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 10:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3nCsnklBQ1UFm+gqm+qDZbbdiHHfrXIDqEIncE//uIk=;
        b=Aysg++84MUQk82LBn0yuLtWTXC2LyqopmyN48h1NlEOeqogrAN3C1ORUCCsDIZwFPD
         Khev+E0y41zjomgLIzquqRX0RMBUhCFrVNcdVJ0qekoBMKshr+9EYgcdA9CB7qLRl3h1
         NAEubU3Mpm1qKz820VYNhAXBtchANb/RUyXEt2I7PhB0FmnmoZkexqfqZP4/ReNBnIct
         0B0q1qLpbwuv5OpTbo9sZra/LBQ3Bxb4+K0apaLUrWX8TvN3rYQqo+Ez0XCF+md0TFSr
         c7b6ioj7le4MFkKig9nbdULcWdAiaz7CWoF/Bn5ZrWfPlgsRnEeZGcUfRZjoPVcESQd/
         rU5Q==
X-Gm-Message-State: AJIora8ra/qAwfF0zPgYJ+4ZApGiqlyZ7vhGujwwvqpkA5rna+ci4cgR
        zYrR5qTxvEruRVvg0yP8MqGuXG2YnAAwV9hOvPmbbJgEWl8ms+jaNKLqP8kKJkTPLF6AllHb3iC
        rkwsZv/mVCq1XYvx9zxE6/4iz
X-Received: by 2002:ad4:5ba8:0:b0:470:b3e3:c26c with SMTP id 8-20020ad45ba8000000b00470b3e3c26cmr28170977qvq.100.1656955063483;
        Mon, 04 Jul 2022 10:17:43 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vxa67c+kgQJXWIOpjBNWGDvw6ASPjM/9BByyML3sl34yEuM27wxzml2seWDnyfhSMzT5UPKQ==
X-Received: by 2002:ad4:5ba8:0:b0:470:b3e3:c26c with SMTP id 8-20020ad45ba8000000b00470b3e3c26cmr28170958qvq.100.1656955063179;
        Mon, 04 Jul 2022 10:17:43 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-206.retail.telecomitalia.it. [79.46.200.206])
        by smtp.gmail.com with ESMTPSA id y7-20020a37f607000000b006a75e8d920bsm10788838qkj.88.2022.07.04.10.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 10:17:42 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [RFC PATCH 6/6] vdpasim: add vdpa_sim_test module
Date:   Mon,  4 Jul 2022 19:17:01 +0200
Message-Id: <20220704171701.127665-7-sgarzare@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704171701.127665-1-sgarzare@redhat.com>
References: <20220704171701.127665-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a test module for vhost-vdpa infrastructure to be used
with virtio_test.

Intentionally not tied to kbuild to prevent people from installing
and loading it accidentally.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_test.c | 203 ++++++++++++++++++++++++++
 tools/virtio/vdpa_test/vdpa_test.c    |   1 +
 tools/virtio/Makefile                 |  32 +++-
 tools/virtio/vdpa_test/Makefile       |   3 +
 4 files changed, 234 insertions(+), 5 deletions(-)
 create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim_test.c
 create mode 100644 tools/virtio/vdpa_test/vdpa_test.c
 create mode 100644 tools/virtio/vdpa_test/Makefile

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_test.c b/drivers/vdpa/vdpa_sim/vdpa_sim_test.c
new file mode 100644
index 000000000000..17628b1a1cdd
--- /dev/null
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_test.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * VDPA simulator for virtio-test.
+ *
+ * Copyright (c) 2022, Red Hat Inc. All rights reserved.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/vringh.h>
+#include <linux/vdpa.h>
+
+#include "vdpa_sim.h"
+
+#define DRV_VERSION  "0.1"
+#define DRV_AUTHOR   "Stefano Garzarella <sgarzare@redhat.com>"
+#define DRV_DESC     "vDPA Device Simulator for virtio-test device"
+#define DRV_LICENSE  "GPL v2"
+
+#define VDPASIM_TEST_FEATURES	(VDPASIM_FEATURES)
+#define VDPASIM_TEST_VIRTIO_ID	0
+
+/* 1 virtqueues, 1 address spaces, 1 virtqueue groups */
+#define VDPASIM_TEST_VQ_NUM	1
+#define VDPASIM_TEST_AS_NUM	1
+#define VDPASIM_TEST_GROUP_NUM	1
+
+static bool vdpasim_test_handle_req(struct vdpasim *vdpasim,
+				    struct vdpasim_virtqueue *vq)
+{
+	int ret;
+
+	ret = vringh_getdesc_iotlb(&vq->vring, &vq->out_iov, &vq->in_iov,
+				   &vq->head, GFP_ATOMIC);
+	if (ret != 1)
+		return false;
+
+	if (vq->out_iov.used == 0 || vq->in_iov.used > 0) {
+		dev_dbg(&vdpasim->vdpa.dev, "Unexpected descriptor format - out_iov: %u in_iov %u\n",
+			vq->out_iov.used, vq->in_iov.used);
+		return false;
+	}
+
+	if (vringh_kiov_length(&vq->out_iov) == 0) {
+		dev_dbg(&vdpasim->vdpa.dev, "Unexpected 0 len for out buffer\n");
+		return false;
+	}
+
+	vringh_complete_iotlb(&vq->vring, vq->head, 0);
+
+	return true;
+}
+
+static void vdpasim_test_work(struct work_struct *work)
+{
+	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
+	bool reschedule = false;
+	int i;
+
+	spin_lock(&vdpasim->lock);
+
+	if (!(vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK))
+		goto out;
+
+	for (i = 0; i < VDPASIM_TEST_VQ_NUM; i++) {
+		struct vdpasim_virtqueue *vq = &vdpasim->vqs[i];
+		int reqs = 0;
+
+		if (!vq->ready)
+			continue;
+
+		while (vdpasim_test_handle_req(vdpasim, vq)) {
+			/* Make sure used is visible before rasing the interrupt. */
+			smp_wmb();
+
+			local_bh_disable();
+			if (vringh_need_notify_iotlb(&vq->vring) > 0)
+				vringh_notify(&vq->vring);
+			local_bh_enable();
+
+			if (++reqs > 4) {
+				reschedule = true;
+				break;
+			}
+		}
+	}
+out:
+	spin_unlock(&vdpasim->lock);
+
+	if (reschedule)
+		schedule_work(&vdpasim->work);
+}
+
+static void vdpasim_test_get_config(struct vdpasim *vdpasim, void *config)
+{
+	u64 *test_config = config;
+
+	*test_config = cpu_to_vdpasim64(vdpasim, 42);
+}
+
+static void vdpasim_test_mgmtdev_release(struct device *dev)
+{
+}
+
+static struct device vdpasim_test_mgmtdev = {
+	.init_name = "vdpasim_test",
+	.release = vdpasim_test_mgmtdev_release,
+};
+
+static int vdpasim_test_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
+				const struct vdpa_dev_set_config *config)
+{
+	struct vdpasim_dev_attr dev_attr = {};
+	struct vdpasim *simdev;
+	int ret;
+
+	dev_attr.mgmt_dev = mdev;
+	dev_attr.name = name;
+	dev_attr.id = VDPASIM_TEST_VIRTIO_ID;
+	dev_attr.supported_features = VDPASIM_TEST_FEATURES;
+	dev_attr.nvqs = VDPASIM_TEST_VQ_NUM;
+	dev_attr.ngroups = VDPASIM_TEST_GROUP_NUM;
+	dev_attr.nas = VDPASIM_TEST_AS_NUM;
+	dev_attr.config_size = sizeof(uint64_t);
+	dev_attr.get_config = vdpasim_test_get_config;
+	dev_attr.work_fn = vdpasim_test_work;
+	dev_attr.buffer_size = 0;
+
+	simdev = vdpasim_create(&dev_attr);
+	if (IS_ERR(simdev))
+		return PTR_ERR(simdev);
+
+	ret = _vdpa_register_device(&simdev->vdpa, VDPASIM_TEST_VQ_NUM);
+	if (ret)
+		goto put_dev;
+
+	return 0;
+
+put_dev:
+	put_device(&simdev->vdpa.dev);
+	return ret;
+}
+
+static void vdpasim_test_dev_del(struct vdpa_mgmt_dev *mdev,
+				 struct vdpa_device *dev)
+{
+	struct vdpasim *simdev = container_of(dev, struct vdpasim, vdpa);
+
+	_vdpa_unregister_device(&simdev->vdpa);
+}
+
+static const struct vdpa_mgmtdev_ops vdpasim_test_mgmtdev_ops = {
+	.dev_add = vdpasim_test_dev_add,
+	.dev_del = vdpasim_test_dev_del
+};
+
+static struct virtio_device_id id_table[] = {
+	{ VDPASIM_TEST_VIRTIO_ID, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+
+static struct vdpa_mgmt_dev mgmt_dev = {
+	.device = &vdpasim_test_mgmtdev,
+	.id_table = id_table,
+	.ops = &vdpasim_test_mgmtdev_ops,
+};
+
+static int __init vdpasim_test_init(void)
+{
+	int ret;
+
+	ret = device_register(&vdpasim_test_mgmtdev);
+	if (ret)
+		return ret;
+
+	ret = vdpa_mgmtdev_register(&mgmt_dev);
+	if (ret)
+		goto parent_err;
+
+	return 0;
+
+parent_err:
+	device_unregister(&vdpasim_test_mgmtdev);
+	return ret;
+}
+
+static void __exit vdpasim_test_exit(void)
+{
+	vdpa_mgmtdev_unregister(&mgmt_dev);
+	device_unregister(&vdpasim_test_mgmtdev);
+}
+
+module_init(vdpasim_test_init)
+module_exit(vdpasim_test_exit)
+
+MODULE_VERSION(DRV_VERSION);
+MODULE_LICENSE(DRV_LICENSE);
+MODULE_AUTHOR(DRV_AUTHOR);
+MODULE_DESCRIPTION(DRV_DESC);
diff --git a/tools/virtio/vdpa_test/vdpa_test.c b/tools/virtio/vdpa_test/vdpa_test.c
new file mode 100644
index 000000000000..779d2be2c9e5
--- /dev/null
+++ b/tools/virtio/vdpa_test/vdpa_test.c
@@ -0,0 +1 @@
+#include "vdpa_sim/vdpa_sim_test.c"
diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
index 1b25cc7c64bb..74a3e8d649a3 100644
--- a/tools/virtio/Makefile
+++ b/tools/virtio/Makefile
@@ -10,6 +10,7 @@ LDFLAGS += -pthread
 vpath %.c ../../drivers/virtio ../../drivers/vhost
 mod:
 	${MAKE} -C `pwd`/../.. M=`pwd`/vhost_test V=${V}
+	${MAKE} -C `pwd`/../.. M=`pwd`/vdpa_test V=${V}
 
 #oot: build vhost as an out of tree module for a distro kernel
 #no effort is taken to make it actually build or work, but tends to mostly work
@@ -18,26 +19,47 @@ mod:
 #resulting modules in production!
 OOT_KSRC=/lib/modules/$$(uname -r)/build
 OOT_VHOST=`pwd`/../../drivers/vhost
+OOT_VDPA=`pwd`/../../drivers/vdpa
 #Everyone depends on vhost
 #Tweak the below to enable more modules
 OOT_CONFIGS=\
 	CONFIG_VHOST=m \
+	CONFIG_VHOST_VDPA=m \
 	CONFIG_VHOST_NET=n \
 	CONFIG_VHOST_SCSI=n \
 	CONFIG_VHOST_VSOCK=n \
 	CONFIG_VHOST_RING=n
-OOT_BUILD=KCFLAGS="-I "${OOT_VHOST} ${MAKE} -C ${OOT_KSRC} V=${V}
+OOT_VDPA_CONFIGS=\
+	CONFIG_VDPA=m \
+	CONFIG_VDPA_SIM=m \
+	CONFIG_VDPA_SIM_NET=n \
+	CONFIG_VDPA_SIM_BLOCK=n \
+	CONFIG_VDPA_USER=n \
+	CONFIG_MLX5_VDPA=n \
+	CONFIG_MLX5_VDPA_NET=n \
+	CONFIG_IFCVF=n \
+	CONFIG_VP_VDPA=n \
+	CONFIG_ALIBABA_ENI_VDPA=n
+OOT_BUILD=KCFLAGS="-I "${OOT_VHOST}" -I "${OOT_VDPA}  ${MAKE} -C ${OOT_KSRC} V=${V}
 oot-build:
 	echo "UNSUPPORTED! Don't use the resulting modules in production!"
 	${OOT_BUILD} M=`pwd`/vhost_test
 	${OOT_BUILD} M=${OOT_VHOST} ${OOT_CONFIGS}
 
-oot-clean: oot-build
-oot: oot-build
+oot-vdpa-build: oot-build
+	echo "UNSUPPORTED! Don't use the resulting modules in production!"
+	${OOT_BUILD} M=`pwd`/vdpa_test
+	${OOT_BUILD} M=${OOT_VDPA} ${OOT_VDPA_CONFIGS}
+
+oot-clean: oot
+oot: oot-build oot-vdpa-build
 oot-clean: OOT_BUILD+=clean
 
-.PHONY: all test mod clean vhost oot oot-clean oot-build
-clean:
+.PHONY: all test mod clean vhost oot oot-clean oot-build oot-vdpa-build clean-vdpa
+clean-vdpa:
+	${RM} vdpa_test/*.o vdpa_test/.*.cmd vdpa_test/Module.symvers \
+              vdpa_test/modules.order
+clean: clean-vdpa
 	${RM} *.o vringh_test virtio_test vhost_test/*.o vhost_test/.*.cmd \
               vhost_test/Module.symvers vhost_test/modules.order *.d
 -include *.d
diff --git a/tools/virtio/vdpa_test/Makefile b/tools/virtio/vdpa_test/Makefile
new file mode 100644
index 000000000000..fce9f344d88f
--- /dev/null
+++ b/tools/virtio/vdpa_test/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-m += vdpa_test.o
+ccflags-y += -I$(srctree)/drivers/vdpa/
-- 
2.36.1

