Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7EB565CB7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 19:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbiGDRSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 13:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbiGDRRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 13:17:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADB0E12A9D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 10:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656955062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YiY/8owB8tnVxNDq00B9edDJ5cOHJxj+7Raw9snQ9Fg=;
        b=XeSB6M4Fg0msAUjk+F3IulOyWbBM4uBisAXlYcZjIgZWgFcTxWeNxPvCt55UDA5d+64SYD
        s6eZJMMTsxY/YIXwBY8SeIIQGelPHammbwGhk0it/qCrh3Da3RMHNPSm/xMQiL993qMZsU
        kzxvyv5p3U17wOCi002kBp2PpAiu5PI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-OpF5weAeM5OiXLx2lnVJPQ-1; Mon, 04 Jul 2022 13:17:41 -0400
X-MC-Unique: OpF5weAeM5OiXLx2lnVJPQ-1
Received: by mail-qt1-f200.google.com with SMTP id k16-20020ac84790000000b0031d446a2d1eso4832880qtq.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 10:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YiY/8owB8tnVxNDq00B9edDJ5cOHJxj+7Raw9snQ9Fg=;
        b=iaRmvJGsvN9qKwRYn5T9DcPd6HcIcN74z2Jm8aUVAOuIqzV2SnF4VTSQRlSxYFUibX
         mL68Er7n/pWxZ4ETIptiOj/sIyCr0SsB61+lGnctm60te3cHOQv31kyJzHoRbGBOWn6c
         XsJ2+jgRlKXTYik9P33lZgd4S5cy5yinRAh6jRsXLWndWLn3mP/Y6d8Mk2RB19tCm894
         T8exzGvwsoU9IizCoR0SEJbi2JwfIRYRAx+pFeLzZrJlxgh/lRRxrOOdofDUCk/Ih+xj
         TJaTGYTVopWFgoK2xPaZB/cWYJGdPWqn5tpYNoKJkVnf80cJLU9ihbMIqkV6pwAuRA9d
         MsWg==
X-Gm-Message-State: AJIora+4NSCyYvEV1QsKv53+IWxYe6PdCvPIsZqBXLu9zNZzuTCh3NfA
        Ww9bGgXVmlx8t8QOJRZjNbpsvqf2S6UBLEWLFlAk1x2e5uBuFVe8NsC1IjxAFqR8PP82EmIAoIE
        qjeW5y37T9xz8KJyp9f9LwYHo
X-Received: by 2002:a05:620a:4048:b0:6af:ce0:cda8 with SMTP id i8-20020a05620a404800b006af0ce0cda8mr20623409qko.698.1656955060958;
        Mon, 04 Jul 2022 10:17:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tWJ/kP40tu6aNymBNyHUdElVqOxdIB+Q8MDadYWSEvofTZlOr7etlNSmUr6/ZU13avClULAw==
X-Received: by 2002:a05:620a:4048:b0:6af:ce0:cda8 with SMTP id i8-20020a05620a404800b006af0ce0cda8mr20623398qko.698.1656955060705;
        Mon, 04 Jul 2022 10:17:40 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-206.retail.telecomitalia.it. [79.46.200.206])
        by smtp.gmail.com with ESMTPSA id y7-20020a37f607000000b006a75e8d920bsm10788838qkj.88.2022.07.04.10.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 10:17:39 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [RFC PATCH 5/6] virtio_test: support vhost-vdpa device
Date:   Mon,  4 Jul 2022 19:17:00 +0200
Message-Id: <20220704171701.127665-6-sgarzare@redhat.com>
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

The new --vdpa parameter can be used to run virtio_test with
the new vdpa_sim_test.ko that implements the device.

The main differences with vhost_test are:
- control of status register
- dma map messages
- VHOST_SET_MEM_TABLE not supported by vhost-vdpa
- VHOST_TEST_RUN not supported by vhost-vdpa

The --reset option is not supported for now when using vhost-vdpa.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/virtio/virtio_test.c | 127 +++++++++++++++++++++++++++++++------
 1 file changed, 109 insertions(+), 18 deletions(-)

diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 2d8a3e881637..91f983266d86 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -44,6 +44,8 @@ struct vdev_info {
 	void *buf;
 	size_t buf_size;
 	struct vhost_memory *mem;
+	bool vdpa;
+	uint64_t backend_features;
 };
 
 static const struct vhost_vring_file no_backend = { .fd = -1 },
@@ -64,6 +66,36 @@ void vq_callback(struct virtqueue *vq)
 {
 }
 
+static void vdpa_add_status(struct vdev_info *dev, uint8_t status)
+{
+	uint8_t current_status;
+	int r;
+
+	r = ioctl(dev->control, VHOST_VDPA_GET_STATUS, &current_status);
+	assert(r >= 0);
+	current_status |= status;
+	r = ioctl(dev->control, VHOST_VDPA_SET_STATUS, &current_status);
+	assert(r >= 0);
+	r = ioctl(dev->control, VHOST_VDPA_GET_STATUS, &current_status);
+	assert(r >= 0);
+	assert((current_status & status) == status);
+}
+
+static void vdpa_dma_map(struct vdev_info *dev, uint64_t iova, uint64_t size,
+			 uint64_t uaddr, uint8_t perm)
+{
+	struct vhost_msg_v2 msg = {};
+	int r;
+
+	msg.type = VHOST_IOTLB_MSG_V2;
+	msg.iotlb.iova = iova;
+	msg.iotlb.size = size;
+	msg.iotlb.uaddr = uaddr;
+	msg.iotlb.perm = perm;
+	msg.iotlb.type = VHOST_IOTLB_UPDATE;
+	r = write(dev->control, &msg, sizeof(msg));
+	assert(r == sizeof(msg));
+}
 
 void vhost_vq_setup(struct vdev_info *dev, struct vq_info *info)
 {
@@ -76,6 +108,12 @@ void vhost_vq_setup(struct vdev_info *dev, struct vq_info *info)
 		.used_user_addr = (uint64_t)(unsigned long)info->vring.used,
 	};
 	int r;
+	if (dev->vdpa) {
+		vdpa_dma_map(dev, (uint64_t)(unsigned long)info->ring,
+			     vring_size(info->vring.num, 4096),
+			     (uint64_t)(unsigned long)info->ring,
+			     VHOST_ACCESS_RW);
+	}
 	state.num = info->vring.num;
 	r = ioctl(dev->control, VHOST_SET_VRING_NUM, &state);
 	assert(r >= 0);
@@ -90,6 +128,11 @@ void vhost_vq_setup(struct vdev_info *dev, struct vq_info *info)
 	file.fd = info->call;
 	r = ioctl(dev->control, VHOST_SET_VRING_CALL, &file);
 	assert(r >= 0);
+	if (dev->vdpa) {
+		state.num = 1;
+		r = ioctl(dev->control, VHOST_VDPA_SET_VRING_ENABLE, &state);
+		assert(r >= 0);
+	}
 }
 
 static void vq_reset(struct vq_info *info, int num, struct virtio_device *vdev)
@@ -121,33 +164,61 @@ static void vq_info_add(struct vdev_info *dev, int num)
 	dev->nvqs++;
 }
 
-static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
+static void vdev_info_init(struct vdev_info *dev, unsigned long long features,
+			   char *vdpa_dev)
 {
+	char *vhost_dev = "/dev/vhost-test";
 	int r;
 	memset(dev, 0, sizeof *dev);
 	dev->vdev.features = features;
+	if (vdpa_dev) {
+		dev->vdpa = true;
+		vhost_dev = vdpa_dev;
+	}
 	INIT_LIST_HEAD(&dev->vdev.vqs);
 	spin_lock_init(&dev->vdev.vqs_list_lock);
 	dev->buf_size = 1024;
 	dev->buf = malloc(dev->buf_size);
 	assert(dev->buf);
-        dev->control = open("/dev/vhost-test", O_RDWR);
+	dev->control = open(vhost_dev, O_RDWR);
 	assert(dev->control >= 0);
 	r = ioctl(dev->control, VHOST_SET_OWNER, NULL);
 	assert(r >= 0);
-	dev->mem = malloc(offsetof(struct vhost_memory, regions) +
-			  sizeof dev->mem->regions[0]);
-	assert(dev->mem);
-	memset(dev->mem, 0, offsetof(struct vhost_memory, regions) +
-                          sizeof dev->mem->regions[0]);
-	dev->mem->nregions = 1;
-	dev->mem->regions[0].guest_phys_addr = (long)dev->buf;
-	dev->mem->regions[0].userspace_addr = (long)dev->buf;
-	dev->mem->regions[0].memory_size = dev->buf_size;
-	r = ioctl(dev->control, VHOST_SET_MEM_TABLE, dev->mem);
-	assert(r >= 0);
+	if (!dev->vdpa) {
+		dev->mem = malloc(offsetof(struct vhost_memory, regions) +
+					   sizeof(dev->mem->regions[0]));
+		assert(dev->mem);
+		memset(dev->mem, 0, offsetof(struct vhost_memory, regions) +
+					   sizeof(dev->mem->regions[0]));
+		dev->mem->nregions = 1;
+		dev->mem->regions[0].guest_phys_addr = (long)dev->buf;
+		dev->mem->regions[0].userspace_addr = (long)dev->buf;
+		dev->mem->regions[0].memory_size = dev->buf_size;
+		r = ioctl(dev->control, VHOST_SET_MEM_TABLE, dev->mem);
+		assert(r >= 0);
+	} else {
+		uint8_t status = 0;
+
+		r = ioctl(dev->control, VHOST_GET_BACKEND_FEATURES,
+			  &dev->backend_features);
+		assert(r >= 0);
+		dev->backend_features &= 0x1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2;
+		assert(dev->backend_features);
+		r = ioctl(dev->control, VHOST_SET_BACKEND_FEATURES,
+			  &dev->backend_features);
+		assert(r >= 0);
+		r = ioctl(dev->control, VHOST_VDPA_SET_STATUS, &status);
+		assert(r >= 0);
+		vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
+				     VIRTIO_CONFIG_S_DRIVER);
+		vdpa_dma_map(dev, (uint64_t)(unsigned long)dev->buf,
+			     dev->buf_size, (uint64_t)(unsigned long)dev->buf,
+			     VHOST_ACCESS_RW);
+	}
 	r = ioctl(dev->control, VHOST_SET_FEATURES, &features);
 	assert(r >= 0);
+	if (dev->vdpa)
+		vdpa_add_status(dev, VIRTIO_CONFIG_S_FEATURES_OK);
 }
 
 /* TODO: this is pretty bad: we get a cache line bounce
@@ -177,8 +248,13 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
 	const bool random_batch = batch == RANDOM_BATCH;
 
 	__virtio_unbreak_device(&dev->vdev);
-	r = ioctl(dev->control, VHOST_TEST_RUN, &test);
-	assert(r >= 0);
+
+	if (!dev->vdpa) {
+		r = ioctl(dev->control, VHOST_TEST_RUN, &test);
+		assert(r >= 0);
+	} else {
+		vdpa_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
+	}
 	if (!reset_n) {
 		next_reset = INT_MAX;
 	}
@@ -268,8 +344,10 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
 		}
 	}
 	test = 0;
-	r = ioctl(dev->control, VHOST_TEST_RUN, &test);
-	assert(r >= 0);
+	if (!dev->vdpa) {
+		r = ioctl(dev->control, VHOST_TEST_RUN, &test);
+		assert(r >= 0);
+	}
 	fprintf(stderr,
 		"spurious wakeups: 0x%llx started=0x%lx completed=0x%lx\n",
 		spurious, started, completed);
@@ -323,6 +401,11 @@ const struct option longopts[] = {
 		.val = 'r',
 		.has_arg = optional_argument,
 	},
+	{
+		.name = "vdpa",
+		.val = 'V',
+		.has_arg = required_argument,
+	},
 	{
 	}
 };
@@ -336,6 +419,7 @@ static void help(void)
 		" [--delayed-interrupt]"
 		" [--batch=random/N]"
 		" [--reset=N]"
+		" [--vdpa=/dev/vhost-vdpa-N]"
 		"\n");
 }
 
@@ -347,6 +431,7 @@ int main(int argc, char **argv)
 	long batch = 1, reset = 0;
 	int o;
 	bool delayed = false;
+	char *vdpa_dev = NULL;
 
 	for (;;) {
 		o = getopt_long(argc, argv, optstring, longopts, NULL);
@@ -389,6 +474,10 @@ int main(int argc, char **argv)
 				assert(reset < (long)INT_MAX + 1);
 			}
 			break;
+		case 'V':
+			vdpa_dev = optarg;
+			features |= 1ULL << VIRTIO_F_ACCESS_PLATFORM;
+			break;
 		default:
 			assert(0);
 			break;
@@ -396,7 +485,9 @@ int main(int argc, char **argv)
 	}
 
 done:
-	vdev_info_init(&dev, features);
+	//TODO: support reset for vdpa
+	assert(vdpa_dev && !reset);
+	vdev_info_init(&dev, features, vdpa_dev);
 	vq_info_add(&dev, 256);
 	run_test(&dev, &dev.vqs[0], delayed, batch, reset, 0x100000);
 	return 0;
-- 
2.36.1

