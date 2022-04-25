Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3114E50D96C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 08:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbiDYGbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbiDYGau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:30:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04CD05C64F
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 23:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650868065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5Ogrdsii+6dWLb5V9VSJwUH4kCOo8+gJfoP2H8fYZIg=;
        b=IDC6EWzGkp40OSVGwhjPRAQROg1vcyMnRBgwpsWsftRPy2NszPZETl/tpxAe+DM8y4QlDp
        RQJiGxTidUUhWJkUNlgIB5DNdost2Tly+/v1me1UJLub4RtkRVkEkub5liHc4ocjUYhTDx
        sqRkboXFfzTufkkq3JVqZ+jJvTq58ho=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-i9gwxzNbOnCj5AGT82FGgQ-1; Mon, 25 Apr 2022 02:27:44 -0400
X-MC-Unique: i9gwxzNbOnCj5AGT82FGgQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F03C680B71C;
        Mon, 25 Apr 2022 06:27:43 +0000 (UTC)
Received: from server.redhat.com (ovpn-12-110.pek2.redhat.com [10.72.12.110])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B16F940C1421;
        Mon, 25 Apr 2022 06:27:41 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, lulu@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] vdpa: add the check for id_table in struct vdpa_mgmt_dev
Date:   Mon, 25 Apr 2022 14:27:33 +0800
Message-Id: <20220425062735.172576-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support the dynamic ids in vp_vdpa, we need to add the check for
id table. If the id table is NULL, will not set the device type

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/vdpa.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 1ea525433a5c..09edd92cede0 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -492,10 +492,13 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *m
 	if (err)
 		goto msg_err;
 
-	while (mdev->id_table[i].device) {
-		if (mdev->id_table[i].device <= 63)
-			supported_classes |= BIT_ULL(mdev->id_table[i].device);
-		i++;
+	if (mdev->id_table != NULL) {
+		while (mdev->id_table[i].device) {
+			if (mdev->id_table[i].device <= 63)
+				supported_classes |=
+					BIT_ULL(mdev->id_table[i].device);
+			i++;
+		}
 	}
 
 	if (nla_put_u64_64bit(msg, VDPA_ATTR_MGMTDEV_SUPPORTED_CLASSES,
-- 
2.34.1

