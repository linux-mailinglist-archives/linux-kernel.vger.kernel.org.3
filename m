Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182B958F939
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbiHKIhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbiHKIhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:37:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B85A792F0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660207033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wxI8STE90R3MtFxd5bcngd81yGb5pFXt8S9v1lVULlg=;
        b=F4HuLqH2KMPn7CO5SYl9WtSKg7hXp7GhvmA8Anj0cTHAADjwRr7499YdkkMb0y0OakMCx6
        8l+vDY/hPdMLtdzr4JfktxMaU0KXhD2kMKNpioxg8vvwKkbpcOLBky0PEdz0mPaUcG1OCB
        rcOOzyvYPX7HlL43ytoKGtd9gre9kq4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-EhlN-XpXNO-QPZEIjir-rA-1; Thu, 11 Aug 2022 04:37:11 -0400
X-MC-Unique: EhlN-XpXNO-QPZEIjir-rA-1
Received: by mail-qv1-f72.google.com with SMTP id ea7-20020ad458a7000000b00476b8d9bfdcso9037419qvb.18
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=wxI8STE90R3MtFxd5bcngd81yGb5pFXt8S9v1lVULlg=;
        b=XITzQsDmTOrxUtyFW4arM/Jq//0hTUZfPBSBekwfZQPn8bxmNiDhgZ4fBYIpscmjwi
         eK9mHXmKOL/G7XATgrcYm+V9jRD9ctoQ+ocHXQDm1FmJJihDSVMASnl9VXTeSi3+jVmL
         dNpdwaYFFBurTsb4Ouz8Pyv1GDJLpCt9Lm+resupF7smTQsYYG7yYHZGTxA1Y9MgSgoa
         rWypnqRZxNTlcjVMZgeBzita3uSrrCANFsj6/ZiWxvG7qpZ/mL7Ws/e2q32z2DyA3Rsu
         PLnsO5V9Ld4DItNvnvSYKoqkITgt0rDDxDmFYQ8KczdoauipFdtftFrHCr9lZrqH68rO
         sQ9g==
X-Gm-Message-State: ACgBeo0W+/A6k8WrwUftuj0cH4+vpDUWrTuq8Ig0DszpI88sxWRZd6ld
        45Mzdjqkplyd+jiJbqC0d467j2pQI8FdtNbaqdtHRDfRmqOBYwz1fDi26/STSxnR9klD396bJqf
        I3GDNhnb9IomicSOvgcf4YvLt
X-Received: by 2002:a05:622a:1a01:b0:343:310d:fedf with SMTP id f1-20020a05622a1a0100b00343310dfedfmr9614049qtb.622.1660207031464;
        Thu, 11 Aug 2022 01:37:11 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7iG5hpVQZhHnEux2Ys32Xpb0iTat8U/eI0t5jz6ZCTF9Xjo89LNFBwu9MSbN4hXHLgOHdEhQ==
X-Received: by 2002:a05:622a:1a01:b0:343:310d:fedf with SMTP id f1-20020a05622a1a0100b00343310dfedfmr9614035qtb.622.1660207031241;
        Thu, 11 Aug 2022 01:37:11 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-178.retail.telecomitalia.it. [79.46.200.178])
        by smtp.gmail.com with ESMTPSA id i14-20020a05620a248e00b006b57b63a8ddsm1485774qkn.122.2022.08.11.01.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 01:37:10 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 4/4] vdpa_sim_blk: add support for discard and write-zeroes
Date:   Thu, 11 Aug 2022 10:36:32 +0200
Message-Id: <20220811083632.77525-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220811083632.77525-1-sgarzare@redhat.com>
References: <20220811083632.77525-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose VIRTIO_BLK_F_DISCARD and VIRTIO_BLK_F_WRITE_ZEROES features
to the drivers and handle VIRTIO_BLK_T_DISCARD and
VIRTIO_BLK_T_WRITE_ZEROES requests checking ranges and flags.

The simulator behaves like a ramdisk, so for VIRTIO_BLK_F_DISCARD
does nothing, while for VIRTIO_BLK_T_WRITE_ZEROES sets to 0 the
specified region.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 74 +++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 1f18f336cf0c..c8bfea3b7db2 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -30,11 +30,14 @@
 				 (1ULL << VIRTIO_BLK_F_SEG_MAX)  | \
 				 (1ULL << VIRTIO_BLK_F_BLK_SIZE) | \
 				 (1ULL << VIRTIO_BLK_F_TOPOLOGY) | \
-				 (1ULL << VIRTIO_BLK_F_MQ))
+				 (1ULL << VIRTIO_BLK_F_MQ)       | \
+				 (1ULL << VIRTIO_BLK_F_DISCARD)  | \
+				 (1ULL << VIRTIO_BLK_F_WRITE_ZEROES))
 
 #define VDPASIM_BLK_CAPACITY	0x40000
 #define VDPASIM_BLK_SIZE_MAX	0x1000
 #define VDPASIM_BLK_SEG_MAX	32
+#define VDPASIM_BLK_DWZ_MAX_SECTORS UINT_MAX
 
 /* 1 virtqueue, 1 address space, 1 virtqueue group */
 #define VDPASIM_BLK_VQ_NUM	1
@@ -193,6 +196,64 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		/* nothing to do */
 		break;
 
+	case VIRTIO_BLK_T_DISCARD:
+	case VIRTIO_BLK_T_WRITE_ZEROES: {
+		struct virtio_blk_discard_write_zeroes range;
+		u32 num_sectors, flags;
+
+		if (to_pull != sizeof(range)) {
+			dev_dbg(&vdpasim->vdpa.dev,
+				"discard/write_zeroes header len: 0x%zx [expected: 0x%zx]\n",
+				to_pull, sizeof(range));
+			status = VIRTIO_BLK_S_IOERR;
+			break;
+		}
+
+		bytes = vringh_iov_pull_iotlb(&vq->vring, &vq->out_iov, &range,
+					      to_pull);
+		if (bytes < 0) {
+			dev_dbg(&vdpasim->vdpa.dev,
+				"vringh_iov_pull_iotlb() error: %zd offset: 0x%llx len: 0x%zx\n",
+				bytes, offset, to_pull);
+			status = VIRTIO_BLK_S_IOERR;
+			break;
+		}
+
+		sector = le64_to_cpu(range.sector);
+		offset = sector << SECTOR_SHIFT;
+		num_sectors = le32_to_cpu(range.num_sectors);
+		flags = le32_to_cpu(range.flags);
+
+		if (type == VIRTIO_BLK_T_DISCARD && flags != 0) {
+			dev_dbg(&vdpasim->vdpa.dev,
+				"discard unexpected flags set - flags: 0x%x\n",
+				flags);
+			status = VIRTIO_BLK_S_UNSUPP;
+			break;
+		}
+
+		if (type == VIRTIO_BLK_T_WRITE_ZEROES &&
+		    flags & ~VIRTIO_BLK_WRITE_ZEROES_FLAG_UNMAP) {
+			dev_dbg(&vdpasim->vdpa.dev,
+				"write_zeroes unexpected flags set - flags: 0x%x\n",
+				flags);
+			status = VIRTIO_BLK_S_UNSUPP;
+			break;
+		}
+
+		if (!vdpasim_blk_check_range(vdpasim, sector, num_sectors,
+					     VDPASIM_BLK_DWZ_MAX_SECTORS)) {
+			status = VIRTIO_BLK_S_IOERR;
+			break;
+		}
+
+		if (type == VIRTIO_BLK_T_WRITE_ZEROES) {
+			memset(vdpasim->buffer + offset, 0,
+			       num_sectors << SECTOR_SHIFT);
+		}
+
+		break;
+	}
 	default:
 		dev_dbg(&vdpasim->vdpa.dev,
 			"Unsupported request type %d\n", type);
@@ -281,6 +342,17 @@ static void vdpasim_blk_get_config(struct vdpasim *vdpasim, void *config)
 	blk_config->min_io_size = cpu_to_vdpasim16(vdpasim, 1);
 	blk_config->opt_io_size = cpu_to_vdpasim32(vdpasim, 1);
 	blk_config->blk_size = cpu_to_vdpasim32(vdpasim, SECTOR_SIZE);
+	/* VIRTIO_BLK_F_DISCARD */
+	blk_config->discard_sector_alignment =
+		cpu_to_vdpasim32(vdpasim, SECTOR_SIZE);
+	blk_config->max_discard_sectors =
+		cpu_to_vdpasim32(vdpasim, VDPASIM_BLK_DWZ_MAX_SECTORS);
+	blk_config->max_discard_seg = cpu_to_vdpasim32(vdpasim, 1);
+	/* VIRTIO_BLK_F_WRITE_ZEROES */
+	blk_config->max_write_zeroes_sectors =
+		cpu_to_vdpasim32(vdpasim, VDPASIM_BLK_DWZ_MAX_SECTORS);
+	blk_config->max_write_zeroes_seg = cpu_to_vdpasim32(vdpasim, 1);
+
 }
 
 static void vdpasim_blk_mgmtdev_release(struct device *dev)
-- 
2.37.1

