Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687D15A2C1C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 18:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245728AbiHZQQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 12:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242917AbiHZQQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 12:16:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD66D87C4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 09:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661530582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lWsHL0asll7+sQVTnDDnQGqBJ+2RTdu1KghvmhpXusA=;
        b=BTdDasDixaWWD1mE8QuVQBDCidiLumeuudE5IZDJbZvUcSFSlaOtFioVIWBwNLeGATXjky
        RT5/Cjor+7oxUBQic4thy0kTLqIiJPNtmbfH+zoSQ0dRtkEc3IPN24ZvBf6Ni/U7Q0Yfwi
        LgCr7ElH83DU+EGqaoF47szDIvknXcU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-212-ABkY2D5QMqKeGM1glY7z_A-1; Fri, 26 Aug 2022 12:16:11 -0400
X-MC-Unique: ABkY2D5QMqKeGM1glY7z_A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B8A5811E76;
        Fri, 26 Aug 2022 16:16:10 +0000 (UTC)
Received: from max-t490s.redhat.com (unknown [10.39.208.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 219CCC15BBA;
        Fri, 26 Aug 2022 16:16:07 +0000 (UTC)
From:   Maxime Coquelin <maxime.coquelin@redhat.com>
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, elic@nvidia.com,
        guanjun@linux.alibaba.com, parav@nvidia.com,
        gautam.dawar@xilinx.com, dan.carpenter@oracle.com,
        xieyongji@bytedance.com, jasowang@redhat.com, mst@redhat.com
Cc:     Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH] vduse: prevent uninitialized memory accesses
Date:   Fri, 26 Aug 2022 18:16:05 +0200
Message-Id: <20220826161605.559317-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the VDUSE application provides a smaller config space
than the driver expects, the driver may use uninitialized
memory from the stack.

This patch prevents it by initializing the buffer passed by
the driver to store the config value.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 41c0b29739f1..35dceee3ed56 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -673,10 +673,15 @@ static void vduse_vdpa_get_config(struct vdpa_device *vdpa, unsigned int offset,
 {
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
 
-	if (offset > dev->config_size ||
-	    len > dev->config_size - offset)
+	/* Initialize the buffer in case of partial copy. */
+	memset(buf, 0, len);
+
+	if (offset > dev->config_size)
 		return;
 
+	if (len > dev->config_size - offset)
+		len = dev->config_size - offset;
+
 	memcpy(buf, dev->config + offset, len);
 }
 
-- 
2.37.1

