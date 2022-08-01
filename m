Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382D5586F35
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbiHAREh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbiHAREc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:04:32 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9393336D;
        Mon,  1 Aug 2022 10:04:31 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w10so11065337plq.0;
        Mon, 01 Aug 2022 10:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=TkCavpnUSJ7vycAkcy6P7E6qdN3Z1ej/wDjztPEV1Xs=;
        b=mcZ6MXoEnw1JToD2hyRhIZ7pGnefjHTTti+cjwuy9wEhPI6rOCmXGKRxCCyNgpQVGQ
         8ESBynZewyeP+SZ1jLeB8wARO2Qg6Ez0lCcZ4hW5Ad8Ij6Gv9RiSk4lnu4tQPos6Vs8t
         Wvq0L05TVB+4rbq4F2Qbli+EVXlKvq50rJMQBYzqGnXZ4V7U37sqyIGaTCR+TY+fWwKF
         OOkDDbKQsUeSAysdawliNu53PRsS1Ms5xw86ZQOU9y+IdzyNh61KweuH7ZDuCKbTwsxq
         HD4OvuUg7ZP692EA+mU+yv7FDvEb1AXFoMHE+NNT9MVfirvSgmZL52BvG/lfo29jqZoD
         uHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=TkCavpnUSJ7vycAkcy6P7E6qdN3Z1ej/wDjztPEV1Xs=;
        b=5V9KOejNftjF02X6AyPWYfFXr2q47bCy2Rf4zHxq5DaJxAc9/EYMiZnhWzDGdC4zx9
         Vrscv6THvK138YETVwlsXaiCzaElmRplwOmVmPVEm/Xu3hF9RN4hc+dmdS3TFOO96haK
         e05tEA2yWRmP7Ej9osrbdusoItnj2s7XFHNDjyS4dYV/l/jZG/hMWmJvUyLkQHwlbLHF
         a8SQFByAnE0+6a/FgxIv2X0tsetKv5iylqpEkIo40h3mZTuSdi+5XuZcwqZbKsFoIWvK
         YqMjjkcBTOdOsKLr7yaH316G8dcTj5Vgmhi9I0dknYolNfA7kWquMAFlF7Mu6qAHPI7F
         c1pg==
X-Gm-Message-State: ACgBeo2Sqii70qw3+0C3rWNVrnz8CV9TrR0Qlt8MG3/h4MrgHMKPyPKe
        3FvcbOtOh+GX+mRs2a/wSOq9ZlIeoXI=
X-Google-Smtp-Source: AA6agR52MvgLOLsM9cuZ5dMaC0PMt05gnbIz5aCroJo5wVmxWfOtz0BXNBd1TvyuExGOeaD5YCdI6Q==
X-Received: by 2002:a17:903:22cb:b0:16e:e31f:5197 with SMTP id y11-20020a17090322cb00b0016ee31f5197mr7430704plg.23.1659373470488;
        Mon, 01 Aug 2022 10:04:30 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902ce8d00b0016d5626af4fsm10105279plg.21.2022.08.01.10.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 10:04:29 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>,
        linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/3] dma-buf: Add ioctl to query mmap info
Date:   Mon,  1 Aug 2022 10:04:55 -0700
Message-Id: <20220801170459.1593706-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220801170459.1593706-1-robdclark@gmail.com>
References: <20220801170459.1593706-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

This is a fairly narrowly focused interface, providing a way for a VMM
in userspace to tell the guest kernel what pgprot settings to use when
mapping a buffer to guest userspace.

For buffers that get mapped into guest userspace, virglrenderer returns
a dma-buf fd to the VMM (crosvm or qemu).  In addition to mapping the
pages into the guest VM, it needs to report to drm/virtio in the guest
the cache settings to use for guest userspace.  In particular, on some
architectures, creating aliased mappings with different cache attributes
is frowned upon, so it is important that the guest mappings have the
same cache attributes as any potential host mappings.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
v2. fix compiler warning

 drivers/dma-buf/dma-buf.c    | 26 ++++++++++++++++++++++++++
 include/linux/dma-buf.h      |  7 +++++++
 include/uapi/linux/dma-buf.h | 28 ++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 32f55640890c..87c52f080274 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -326,6 +326,29 @@ static long dma_buf_set_name(struct dma_buf *dmabuf, const char __user *buf)
 	return 0;
 }
 
+static long dma_buf_info(struct dma_buf *dmabuf, void __user *uarg)
+{
+	struct dma_buf_info arg;
+
+	if (copy_from_user(&arg, uarg, sizeof(arg)))
+		return -EFAULT;
+
+	switch (arg.param) {
+	case DMA_BUF_INFO_VM_PROT:
+		if (!dmabuf->ops->mmap_info)
+			return -ENOSYS;
+		arg.value = dmabuf->ops->mmap_info(dmabuf);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (copy_to_user(uarg, &arg, sizeof(arg)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static long dma_buf_ioctl(struct file *file,
 			  unsigned int cmd, unsigned long arg)
 {
@@ -369,6 +392,9 @@ static long dma_buf_ioctl(struct file *file,
 	case DMA_BUF_SET_NAME_B:
 		return dma_buf_set_name(dmabuf, (const char __user *)arg);
 
+	case DMA_BUF_IOCTL_INFO:
+		return dma_buf_info(dmabuf, (void __user *)arg);
+
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 71731796c8c3..6f4de64a5937 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -283,6 +283,13 @@ struct dma_buf_ops {
 	 */
 	int (*mmap)(struct dma_buf *, struct vm_area_struct *vma);
 
+	/**
+	 * @mmap_info:
+	 *
+	 * Return mmapping info for the buffer.  See DMA_BUF_INFO_VM_PROT.
+	 */
+	int (*mmap_info)(struct dma_buf *);
+
 	int (*vmap)(struct dma_buf *dmabuf, struct iosys_map *map);
 	void (*vunmap)(struct dma_buf *dmabuf, struct iosys_map *map);
 };
diff --git a/include/uapi/linux/dma-buf.h b/include/uapi/linux/dma-buf.h
index b1523cb8ab30..a41adac0f46a 100644
--- a/include/uapi/linux/dma-buf.h
+++ b/include/uapi/linux/dma-buf.h
@@ -85,6 +85,32 @@ struct dma_buf_sync {
 
 #define DMA_BUF_NAME_LEN	32
 
+
+/**
+ * struct dma_buf_info - Query info about the buffer.
+ */
+struct dma_buf_info {
+
+#define DMA_BUF_INFO_VM_PROT      1
+#  define DMA_BUF_VM_PROT_WC      0
+#  define DMA_BUF_VM_PROT_CACHED  1
+
+	/**
+	 * @param: Which param to query
+	 *
+	 * DMA_BUF_INFO_BM_PROT:
+	 *     Query the access permissions of userspace mmap's of this buffer.
+	 *     Returns one of DMA_BUF_VM_PROT_x
+	 */
+	__u32 param;
+	__u32 pad;
+
+	/**
+	 * @value: Return value of the query.
+	 */
+	__u64 value;
+};
+
 #define DMA_BUF_BASE		'b'
 #define DMA_BUF_IOCTL_SYNC	_IOW(DMA_BUF_BASE, 0, struct dma_buf_sync)
 
@@ -95,4 +121,6 @@ struct dma_buf_sync {
 #define DMA_BUF_SET_NAME_A	_IOW(DMA_BUF_BASE, 1, __u32)
 #define DMA_BUF_SET_NAME_B	_IOW(DMA_BUF_BASE, 1, __u64)
 
+#define DMA_BUF_IOCTL_INFO	_IOWR(DMA_BUF_BASE, 2, struct dma_buf_info)
+
 #endif
-- 
2.36.1

