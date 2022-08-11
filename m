Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816AC58F936
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbiHKIg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbiHKIgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:36:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DEB2792D8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660207009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b2PRyz9SGjKoLZlYF6JLzg9mzaDVsgEeEMI7cjuKE+0=;
        b=ATwJz23I2FA5hnU3jt1WEVZYvoYe+YZ1baPsl1yy1zrHrOoKbS04V01MVsCqGvj2qY6jJT
        VEY/rkxD4ZDaDKBJ+qGdATCL3HQvlKmH13n/2fb8sW5AtbctvHCXkLMFWt0tphyYvjp4Bu
        ukS4oClV+6rb+qyM0Z4Tc/C7lLoO/Oo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-mXuKJcVIP4aKkQyPFnJk3g-1; Thu, 11 Aug 2022 04:36:46 -0400
X-MC-Unique: mXuKJcVIP4aKkQyPFnJk3g-1
Received: by mail-qt1-f199.google.com with SMTP id fy18-20020a05622a5a1200b0033e5b56f031so12753289qtb.15
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=b2PRyz9SGjKoLZlYF6JLzg9mzaDVsgEeEMI7cjuKE+0=;
        b=Lx4A6ZdHwsD9rYzfV6BKQr6ayB6+sWTY6BGg8SwhU+gxab2iFo8JqAyAZL76UTZ6kw
         FPZliSh3ngcfOAar717e9tW43+Zsg+u3J5igz1khUZNlj9QiJBcQ49s0BLaAsNR5peKz
         HGuxjmvH8R/HBl/TOM00jaH6SnepicDBhlZz9SkllXRd5nkwRLNRfrbRV4wodQ/h2Xq/
         lBBAFTgT6ZgofBmAvDeLGy7uWbg8ADTLOTs5XX32dEPQ5KpyRg/+Vz1+QZJtn14Ii5zW
         VylX/FsufGV5EOYLRWWrjp8KyKDRNmFsbSdgDR6OtrOjAT5Z5DhSYas8fnc72JIVGxUt
         r10Q==
X-Gm-Message-State: ACgBeo0zGOAaZmSwl5G2fMOj6kBX9fxarfIeWespqwrTPE8gvbe+v34h
        RpQ28+IyZ/oAt1Pte8yFVWl9Sof+2U3yyThgrUpokCpdpd8gnu1VrjqjDsc5C7LsliK4SWwpu+k
        wg8u4s5JQv/pSyWgcRQwIWwEi
X-Received: by 2002:a05:622a:54a:b0:343:5a1a:9acd with SMTP id m10-20020a05622a054a00b003435a1a9acdmr5424737qtx.194.1660207006117;
        Thu, 11 Aug 2022 01:36:46 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4RFzgc5ALPcjlt3FX7MEe3xJX2GOatlwsfQrEhnbVqaD+RWcWMD5dC4uSCC4mr/t0kzhgpuw==
X-Received: by 2002:a05:622a:54a:b0:343:5a1a:9acd with SMTP id m10-20020a05622a054a00b003435a1a9acdmr5424728qtx.194.1660207005928;
        Thu, 11 Aug 2022 01:36:45 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-178.retail.telecomitalia.it. [79.46.200.178])
        by smtp.gmail.com with ESMTPSA id ga25-20020a05622a591900b0034361fb2f75sm1343083qtb.22.2022.08.11.01.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 01:36:45 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 3/4] vdpa_sim_blk: add support for VIRTIO_BLK_T_FLUSH
Date:   Thu, 11 Aug 2022 10:36:31 +0200
Message-Id: <20220811083632.77525-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220811083632.77525-1-sgarzare@redhat.com>
References: <20220811083632.77525-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 24dd9cae6450..1f18f336cf0c 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -25,6 +25,7 @@
 #define DRV_LICENSE  "GPL v2"
 
 #define VDPASIM_BLK_FEATURES	(VDPASIM_FEATURES | \
+				 (1ULL << VIRTIO_BLK_F_FLUSH)    | \
 				 (1ULL << VIRTIO_BLK_F_SIZE_MAX) | \
 				 (1ULL << VIRTIO_BLK_F_SEG_MAX)  | \
 				 (1ULL << VIRTIO_BLK_F_BLK_SIZE) | \
@@ -188,6 +189,10 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		pushed += bytes;
 		break;
 
+	case VIRTIO_BLK_T_FLUSH:
+		/* nothing to do */
+		break;
+
 	default:
 		dev_dbg(&vdpasim->vdpa.dev,
 			"Unsupported request type %d\n", type);
-- 
2.37.1

