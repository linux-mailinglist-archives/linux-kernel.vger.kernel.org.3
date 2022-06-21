Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE785535A8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352703AbiFUPPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352393AbiFUPOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:14:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AF052CDE2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655824410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:  content-type:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=g+NJjQlOAcWg6eecPG318LXJkkwF2T/JikgaYlmjCB0=;
        b=SLadtdZo+8FmCPL9dpKpI/eBt/UXwBCywi/Eyv4dX/i8Dt279B+9FIwmcsJTpIotei2EtB
        7Oz8PrVFHOaC+SEpRuzmwNLgJqoteNjCx60MQ3md0AwhPulxhJtmYOTfXMvkGQF2cXC+bL
        oW193DvJRi6sU8G9Xs5n9DnbdOMrdog=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-202-jsuBXvaFMpaGcNfVXLOasQ-1; Tue, 21 Jun 2022 11:13:29 -0400
X-MC-Unique: jsuBXvaFMpaGcNfVXLOasQ-1
Received: by mail-qk1-f199.google.com with SMTP id r6-20020a05620a298600b006a98e988ba4so16742995qkp.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g+NJjQlOAcWg6eecPG318LXJkkwF2T/JikgaYlmjCB0=;
        b=EE8eZ85AU0KLwiZ6DbAzTmZXc+pV+f+8bpHm/R0B9T8Z7rOqgGswoj7gdclFnXaICm
         51lYQrhu8nZeHA+s5WG0jYapXLb1ANLi1jXQ/X6hNL5y25v/9c41DJGqM+FriXMqfS3R
         6e//EvG+ync6PwPBy4MnogGe+vz94hKDeJ3EkvnwFVn7Tq0GKcypxiqptt/a53GfS08q
         QlFN4MpaphSX9qBYzuanRFASiBcyXQrNokpe3+8QOU+goHFuyTINRtIUNQFD0UMR3B+Q
         ZY5Lwt6CEpnvjUlhON3/p4eyuuipQtg0ilq+1GvMl2ElQbd3uQ2lYzt5xEz5Mu0zJ5GY
         UtGw==
X-Gm-Message-State: AJIora8K6a/HJMy92ZXDHJEn5e5WsHt7wGz+Y4BexIIc4AIeKURy64nJ
        hQEkTMaDC8v/o18LcvLDO3KiMZr6Ir8+9NhHo2dY8WxuClTwDSlUHE8X83Xh7RS3UEpgJ69g1QR
        MJ+aKPA+fkS97se64f7IbHor/
X-Received: by 2002:ac8:5b50:0:b0:305:3275:b9bf with SMTP id n16-20020ac85b50000000b003053275b9bfmr24129985qtw.498.1655824408577;
        Tue, 21 Jun 2022 08:13:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sRyiOcUjGsF9W5x9EpD8vRzkOvogV2aC9PWkgpGX0OePdiWEiVSVq+pFjtElx+Cae1c1QL1Q==
X-Received: by 2002:ac8:5b50:0:b0:305:3275:b9bf with SMTP id n16-20020ac85b50000000b003053275b9bfmr24129957qtw.498.1655824408277;
        Tue, 21 Jun 2022 08:13:28 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-40.retail.telecomitalia.it. [79.46.200.40])
        by smtp.gmail.com with ESMTPSA id z13-20020a05622a060d00b00304eb8e880dsm14266895qta.23.2022.06.21.08.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 08:13:27 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Gautam Dawar <gautam.dawar@xilinx.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] vdpa_sim_blk: set number of address spaces and virtqueue groups
Date:   Tue, 21 Jun 2022 17:13:23 +0200
Message-Id: <20220621151323.190431-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit bda324fd037a ("vdpasim: control virtqueue support") added two
new fields (nas, ngroups) to vdpasim_dev_attr, but we forgot to
initialize them for vdpa_sim_blk.

When creating a new vdpa_sim_blk device this causes the kernel
to panic in this way:
    $ vdpa dev add mgmtdev vdpasim_blk name blk0
    BUG: kernel NULL pointer dereference, address: 0000000000000030
    ...
    RIP: 0010:vhost_iotlb_add_range_ctx+0x41/0x220 [vhost_iotlb]
    ...
    Call Trace:
     <TASK>
     vhost_iotlb_add_range+0x11/0x800 [vhost_iotlb]
     vdpasim_map_range+0x91/0xd0 [vdpa_sim]
     vdpasim_alloc_coherent+0x56/0x90 [vdpa_sim]
     ...

This happens because vdpasim->iommu[0] is not initialized when
dev_attr.nas is 0.

Let's fix this issue by initializing both (nas, ngroups) to 1 for
vdpa_sim_blk.

Fixes: bda324fd037a ("vdpasim: control virtqueue support")
Cc: gautam.dawar@xilinx.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 42d401d43911..03a28def8eee 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -34,7 +34,11 @@
 #define VDPASIM_BLK_CAPACITY	0x40000
 #define VDPASIM_BLK_SIZE_MAX	0x1000
 #define VDPASIM_BLK_SEG_MAX	32
+
+/* 1 virtqueue, 1 address space, 1 virtqueue group */
 #define VDPASIM_BLK_VQ_NUM	1
+#define VDPASIM_BLK_AS_NUM	1
+#define VDPASIM_BLK_GROUP_NUM	1
 
 static char vdpasim_blk_id[VIRTIO_BLK_ID_BYTES] = "vdpa_blk_sim";
 
@@ -260,6 +264,8 @@ static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	dev_attr.id = VIRTIO_ID_BLOCK;
 	dev_attr.supported_features = VDPASIM_BLK_FEATURES;
 	dev_attr.nvqs = VDPASIM_BLK_VQ_NUM;
+	dev_attr.ngroups = VDPASIM_BLK_GROUP_NUM;
+	dev_attr.nas = VDPASIM_BLK_AS_NUM;
 	dev_attr.config_size = sizeof(struct virtio_blk_config);
 	dev_attr.get_config = vdpasim_blk_get_config;
 	dev_attr.work_fn = vdpasim_blk_work;
-- 
2.36.1

