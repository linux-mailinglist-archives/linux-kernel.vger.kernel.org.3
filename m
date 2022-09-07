Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA6D5AFC19
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiIGGBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIGGB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:01:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5210883F3B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662530486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ovHoM9YpW21oT3aBioqYivK4mMYTlNS9bEeTyk27HO8=;
        b=VA+4qBfzbqSAw5gfWQXUN3AFNoKBPZFE8iHTL1260JjV9kSJL8iVZFITfufwK4jMpih3fC
        1nk7nEbxvGXEs4r5+tS+BihSGmq7tcCoALSzQj0OGLDhRzJtyXQ00ovcEPcdowdCzsva24
        CZSrZ6IHDhbcqkxaz8RAAzTDwBLqBng=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-sMpKTXSHNsGUx8QJsaujwA-1; Wed, 07 Sep 2022 02:01:15 -0400
X-MC-Unique: sMpKTXSHNsGUx8QJsaujwA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 351ED804191;
        Wed,  7 Sep 2022 06:01:15 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-171.pek2.redhat.com [10.72.13.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D441E4010FA1;
        Wed,  7 Sep 2022 06:01:12 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, elic@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vdpa: conditionally fill max max queue pair for stats
Date:   Wed,  7 Sep 2022 14:01:10 +0800
Message-Id: <20220907060110.4511-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the device without multiqueue feature, we will read 0 as
max_virtqueue_pairs from the config. So if we fill
VDPA_ATTR_DEV_NET_CFG_MAX_VQP with the value we read from the config
we will confuse the user.

Fixing this by only filling the value when multiqueue is offered by
the device so userspace can assume 1 when the attr is not provided.

Fixes: 13b00b135665c("vdpa: Add support for querying vendor statistics")
Cc: Eli Cohen <elic@nvidia.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index c06c02704461..bc328197263f 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -894,7 +894,6 @@ static int vdpa_fill_stats_rec(struct vdpa_device *vdev, struct sk_buff *msg,
 {
 	struct virtio_net_config config = {};
 	u64 features;
-	u16 max_vqp;
 	u8 status;
 	int err;
 
@@ -905,15 +904,15 @@ static int vdpa_fill_stats_rec(struct vdpa_device *vdev, struct sk_buff *msg,
 	}
 	vdpa_get_config_unlocked(vdev, 0, &config, sizeof(config));
 
-	max_vqp = __virtio16_to_cpu(true, config.max_virtqueue_pairs);
-	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, max_vqp))
-		return -EMSGSIZE;
-
 	features = vdev->config->get_driver_features(vdev);
 	if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES,
 			      features, VDPA_ATTR_PAD))
 		return -EMSGSIZE;
 
+	err = vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
+	if (err)
+		return err;
+
 	if (nla_put_u32(msg, VDPA_ATTR_DEV_QUEUE_INDEX, index))
 		return -EMSGSIZE;
 
-- 
2.25.1

