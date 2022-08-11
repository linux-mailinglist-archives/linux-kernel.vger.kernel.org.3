Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6141E58F97A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiHKIsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiHKIr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:47:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7780910B3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660207675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5AXFiHe2CmpDevMhSkIWn01i/EnbWuauw5G+9+V6hIc=;
        b=Z7FhgcsBavDlkTC7e3Oe5sFm3cI022WMCePkPaQ8oKUrbbuEKobuNpqWowMwudPi+dJh7g
        n0/KASgJegw6UgX4GO46wQA6lJzQDo/9mSalML0PUikIGZpsC1zRrsDvvDq5mq8Ip3WbAB
        KjF36/GxKiS82Ht4WTqyPmg7psEG8vI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-4Elf_qDrMnG6hTGIitkfMQ-1; Thu, 11 Aug 2022 04:47:54 -0400
X-MC-Unique: 4Elf_qDrMnG6hTGIitkfMQ-1
Received: by mail-qt1-f198.google.com with SMTP id a8-20020a05622a064800b00342240a9fccso12684406qtb.18
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=5AXFiHe2CmpDevMhSkIWn01i/EnbWuauw5G+9+V6hIc=;
        b=ewwBbWPH+6CgDzvZfXl1AiSh0LCTT/bh+ScYfKkUSdDzXbh9rzBBl63RXxk3vfHyLV
         EJ/6NItthQU29Xr9Vzrs118syHozwUhcrihrdtr3Qd3g1yJD+VOHQB6pMN33HPCQj+ja
         ZVv/+UMDgKw//ZJOevetmRzMKo0qMvNuaSXF5BXo/SSDmQ/qlyyi29tIIjZFB1nnZMuo
         iBJGIwBzVN8mOI7cYleTdbe/NtrOICfUMdMpKInfOafARjO1fgOAfFBFzaXHcTTLwrWj
         J6Kwmf/nJaWNi8MJ4uzIGFpL9nJ4jHnAoRYM2snpvyW/0jeGCHpm6aBDkE/9lLwIFxgx
         c7sQ==
X-Gm-Message-State: ACgBeo2MvL4KIOEgmSd1PSPZMPR7IxivyEI7Px6FcK/q4YKfGJQ58vTZ
        bD2SfvEjNKTxW5PWddsM+BSTyK9MbSIijktPt2+uM9m4kgdcm5qeoYmnEGqcbbOzuYJYCplhJNv
        65I4PZ8NhnDBBjujzZ4SEqKew
X-Received: by 2002:a05:620a:170d:b0:6b8:fd9c:da91 with SMTP id az13-20020a05620a170d00b006b8fd9cda91mr22778158qkb.683.1660207673883;
        Thu, 11 Aug 2022 01:47:53 -0700 (PDT)
X-Google-Smtp-Source: AA6agR44pcESFHkNdNM3Yf3jmpUmzHiMOEidvVu/fsIBlqr+kIf/Fux++cUEWpNdKhU50QGFjuV0EQ==
X-Received: by 2002:a05:620a:170d:b0:6b8:fd9c:da91 with SMTP id az13-20020a05620a170d00b006b8fd9cda91mr22778151qkb.683.1660207673670;
        Thu, 11 Aug 2022 01:47:53 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-178.retail.telecomitalia.it. [79.46.200.178])
        by smtp.gmail.com with ESMTPSA id q31-20020a05620a2a5f00b006a793bde241sm21508qkp.63.2022.08.11.01.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 01:47:52 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] vdpa: fix warning casts when building with C=2
Date:   Thu, 11 Aug 2022 10:47:49 +0200
Message-Id: <20220811084749.83809-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.37.1
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

Use __virtio16_to_cpu() to read `max_virtqueue_pairs` field in
virtio_net_config since its type is __virtio16.

This silences the following warning when building with `make C=2`:

    ../drivers/vdpa/vdpa.c:811:19: warning: cast to restricted __le16
    ../drivers/vdpa/vdpa.c:811:19: warning: cast from restricted __virtio16

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index c06c02704461..2466d5087478 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -808,7 +808,7 @@ static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
 	if ((features & BIT_ULL(VIRTIO_NET_F_MQ)) == 0)
 		return 0;
 
-	val_u16 = le16_to_cpu(config->max_virtqueue_pairs);
+	val_u16 = __virtio16_to_cpu(true, config->max_virtqueue_pairs);
 	return nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, val_u16);
 }
 
-- 
2.37.1

