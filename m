Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FB758E9FA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 11:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbiHJJp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 05:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbiHJJoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:44:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23BF06CF5F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660124661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k7/Qe+5eTUGxbNC+s2zlukeDJxV02+FkntfjhZmwiRA=;
        b=IHtYczn8yF9U6uDJYMiX7nKeO1jJX62iWHj65B06HVCPbLourgjfliH1b1zn07bCJA0Mw5
        ++jEtNG1iAbnLlb9uWSEV9nia2gfNXKh1Guip0MjSSExuufgn82glpT1yeKLUwwEJLDyYo
        vAlblbXmyFZtnYPfJ2d/mhrFZbILrk8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-510-Pw5ok0ipPw-NxEPFp_QvpQ-1; Wed, 10 Aug 2022 05:44:18 -0400
X-MC-Unique: Pw5ok0ipPw-NxEPFp_QvpQ-1
Received: by mail-wm1-f70.google.com with SMTP id f21-20020a1cc915000000b003a3551598a1so395762wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=k7/Qe+5eTUGxbNC+s2zlukeDJxV02+FkntfjhZmwiRA=;
        b=hDYai9toXeJOyIpPcgE1gZd2NqVDHuvFyX04yOQHv0OyHXEgxtrv135s3OSQ1ReWTv
         v9paLxqh/89Q8Q1JM3mWiEv6ZdKvlUv3Y8SvLhP0wYVbTrYVBeQ1TCvmBTQq46Jfx26u
         Cqbx6BCxnq4PTQw7GRhvawee+l+CsUHa5YSEj6WwzMTfxRmunh/Rlhtyc9p0U/nLLkDd
         XsvL6HEqZAxkLUnG0rc62qYzWnmxxd+rYoN4o04CLFxrMF1tM/B2+xCD03mgE+vkbzw4
         r3Z5udN53BcbwYnQaks3BWrdD0rEDJDUcko+W1BBlB3danu0t6Qj6fBVXMpL/xNoPIVe
         DPTg==
X-Gm-Message-State: ACgBeo2zGR3WDvqsIXS0gp+rfX1+QNLvrKwVbw2F6PbE3R/5GKuRmDyr
        0wU+y4avxywK8onP2PP281iYXb/61z5JfHfAliBNYbwhmjIM/cYB+CPGuhXtEwadU9AxJXwh+Vk
        44NXKhsBhPKmCf5o2nrO9lEv+
X-Received: by 2002:a05:6000:1542:b0:220:603d:ec93 with SMTP id 2-20020a056000154200b00220603dec93mr17536686wry.73.1660124657612;
        Wed, 10 Aug 2022 02:44:17 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6iclGAZJP+HWE3V0NXvbb7Pj7rFr6PGzc2/8kqTzVx9Xl8yB8UdjXdKIphvt2YtlzIaVYsVg==
X-Received: by 2002:a05:6000:1542:b0:220:603d:ec93 with SMTP id 2-20020a056000154200b00220603dec93mr17536672wry.73.1660124657375;
        Wed, 10 Aug 2022 02:44:17 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-178.retail.telecomitalia.it. [79.46.200.178])
        by smtp.gmail.com with ESMTPSA id t188-20020a1c46c5000000b003a327f19bf9sm1729195wma.14.2022.08.10.02.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 02:44:16 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 4/4] vdpa_sim_blk: add support for discard and write-zeroes
Date:   Wed, 10 Aug 2022 11:43:47 +0200
Message-Id: <20220810094347.20449-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220810094347.20449-1-sgarzare@redhat.com>
References: <20220810094347.20449-1-sgarzare@redhat.com>
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
index 1f18f336cf0c..db85df1d5073 100644
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
+	case VIRTIO_BLK_T_WRITE_ZEROES:
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
+		sector = vdpasim64_to_cpu(vdpasim, range.sector);
+		offset = sector << SECTOR_SHIFT;
+		num_sectors = vdpasim32_to_cpu(vdpasim, range.num_sectors);
+		flags = vdpasim32_to_cpu(vdpasim, range.flags);
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
+
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

