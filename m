Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EAF5137E6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348909AbiD1PQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345202AbiD1PQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:16:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B92758E43
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651158767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=l7cbcgB7/LBI16VlALG4h+gnvPS9BXoCjSIEjFOAPWA=;
        b=M5UOkoeyttEfehGKA6D2dDoe7Q+Dbi7QUzJ+IHvCVix8UVFY+Q4j5njJiDD6W1+foaPJE1
        BOeufc3iEkVe97gCfyXw3IM2eoMQYXNLz/JShpb1qJYMtWZ8RB7Al8zLvRudxkTMmGuCUV
        qE5YqccgRRbwXwUCIBfErPcfcD0VfMY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-PUbRLBCwOfSRPINyRrhtPA-1; Thu, 28 Apr 2022 11:12:45 -0400
X-MC-Unique: PUbRLBCwOfSRPINyRrhtPA-1
Received: by mail-wr1-f72.google.com with SMTP id v29-20020adfa1dd000000b0020ad932b7c0so2051780wrv.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:12:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l7cbcgB7/LBI16VlALG4h+gnvPS9BXoCjSIEjFOAPWA=;
        b=1LmLmnDhN7b29WFdYxPR2/Y26KSXUc7HTjFEUgxGHVo3uczpC61BuUEZJGxsxO7Rg3
         q+E9Hftiu7H+3LJckUA7mwnMSOv7yt0OHuaGobBvMCYDiZ4TqoXDzdTOgZjhnDVXBpSR
         QWDoyOjY9GqkWu3znhAcMHwjhcmzrbKuEtXmP29JK3SJwgNd/nIYq95PhJFPGRLlLn3G
         lIl8Lzf5Ln+LbGNwlNrsJWzsekusINzmBKr/pDkQQYWUKr2Rk+cGk3qjBhzxeuJUYogQ
         K3jPllLp0g25T46xT9Tg5jiWWgxCXYFNKMIv3PZw19XURysvlXR41kh51zle5XxI8r6u
         BXaA==
X-Gm-Message-State: AOAM530FXL57elbc6T2yTdXnRwdxlgmY+Y8CcFmG9x4EJp+VmSTSULBV
        e6K0Uom1sXHr2NFotYR8I2qpijTcqvAkd8m+VwA+EtlXi2BcNSw1yQwrNFEp4po6+IcSqX0X3LU
        dFbwFmbmOqNdYLfHXA239vgWs
X-Received: by 2002:a5d:6a0f:0:b0:20a:ea3b:8d66 with SMTP id m15-20020a5d6a0f000000b0020aea3b8d66mr9037894wru.596.1651158764598;
        Thu, 28 Apr 2022 08:12:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfaU4IRUPaTfN+PSjDCPo8Z/R+YWvg+fh9A3dxgD17Ii0lPQiheZMVy1BW43wJWTvMDO7l8Q==
X-Received: by 2002:a5d:6a0f:0:b0:20a:ea3b:8d66 with SMTP id m15-20020a5d6a0f000000b0020aea3b8d66mr9037881wru.596.1651158764395;
        Thu, 28 Apr 2022 08:12:44 -0700 (PDT)
Received: from step1.redhat.com (host-87-11-6-234.retail.telecomitalia.it. [87.11.6.234])
        by smtp.gmail.com with ESMTPSA id y1-20020adfc7c1000000b0020ae65d2e91sm95612wrg.79.2022.04.28.08.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 08:12:43 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] vdpa_sim_blk: add support for VIRTIO_BLK_T_FLUSH
Date:   Thu, 28 Apr 2022 17:12:42 +0200
Message-Id: <20220428151242.213824-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simulator behaves like a ramdisk, so we don't have to do
anything when a VIRTIO_BLK_T_FLUSH request is received, but it
could be useful to test driver behavior.

Let's expose the VIRTIO_BLK_F_FLUSH feature to inform the driver
that we support the flush command.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 42d401d43911..a6dd1233797c 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -25,6 +25,7 @@
 #define DRV_LICENSE  "GPL v2"
 
 #define VDPASIM_BLK_FEATURES	(VDPASIM_FEATURES | \
+				 (1ULL << VIRTIO_BLK_F_FLUSH)    | \
 				 (1ULL << VIRTIO_BLK_F_SIZE_MAX) | \
 				 (1ULL << VIRTIO_BLK_F_SEG_MAX)  | \
 				 (1ULL << VIRTIO_BLK_F_BLK_SIZE) | \
@@ -166,6 +167,17 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		pushed += bytes;
 		break;
 
+	case VIRTIO_BLK_T_FLUSH:
+		if (sector != 0) {
+			dev_err(&vdpasim->vdpa.dev,
+				"A driver MUST set sector to 0 for a VIRTIO_BLK_T_FLUSH request - sector: 0x%llx\n",
+				sector);
+			status = VIRTIO_BLK_S_IOERR;
+			break;
+		}
+
+		break;
+
 	default:
 		dev_warn(&vdpasim->vdpa.dev,
 			 "Unsupported request type %d\n", type);
-- 
2.35.1

