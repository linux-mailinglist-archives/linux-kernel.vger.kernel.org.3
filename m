Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58A858F935
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbiHKIgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbiHKIgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:36:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CCA5792E5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660207004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=38oYZZo5oxfiL5gDqzJLWx2Nj0BFm9A6p9CXqcxwNdc=;
        b=GzkudejRbUEeg6ND5zXUodkrADc64N0Jzq8siGi0sTo+Ge3cqngHwWYeKQY1YhPzzu4lgq
        xrRv6e8ufOv2048K5gFbc8c/xG9SUuPk8rvL2PgVA8u40ASnEH2EleCTGzgkHwcoXyOKhy
        EpmeeNGgUlM+OtgGvadiG3DzfEKNdSk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-J7lNJf-4Os-eYwBY6qYdJA-1; Thu, 11 Aug 2022 04:36:43 -0400
X-MC-Unique: J7lNJf-4Os-eYwBY6qYdJA-1
Received: by mail-qk1-f200.google.com with SMTP id y17-20020a05620a25d100b006b66293d75aso14369764qko.17
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=38oYZZo5oxfiL5gDqzJLWx2Nj0BFm9A6p9CXqcxwNdc=;
        b=LdzdqQxVmYvmiZBdZrBbdOiEZtaJJHVFtlKF6N3DaumfNo7kKu1Ous83yyU2iIQrd0
         DkckoSsypksJmlCX9xHPiiFCNVxGj2eBWH5FRduiBS1HgW4vrYO1sleoO7HqpX/RAku8
         m4VLHoixZ0+PPehpguA5tUdYBDHVTuURvJiALLsXZiJZY1LzpCu7Fo2h/aNpgh1cZWlL
         P2pTTntR/iirvGK1Iiis4zYv7N+a/14Qt2Kkuq8cp7pyc0xUesTqpMVItJKCWBN0Wn+E
         2nT+uc0w5AzjkiYZ9SmpxZ7uryTKW0u0dRZ/rKCwc/vWDvt592xAFKHMzfXAX4qaan5q
         Rgiw==
X-Gm-Message-State: ACgBeo2BWRQVToUP9QbZArQxsumQjabi73slRERtSrtK9DHXTCjfPAlV
        cODhO6agWI1gaAZo/h8hsEOkLf84r2rXUusXDXHXvsiCXBNvUKCgncP0HzoxknbI23fH67fgGnX
        +QYY8aMjFksoKUYfn0CKycf0A
X-Received: by 2002:a05:620a:288c:b0:6b3:9d1:dbf1 with SMTP id j12-20020a05620a288c00b006b309d1dbf1mr23327371qkp.593.1660207003236;
        Thu, 11 Aug 2022 01:36:43 -0700 (PDT)
X-Google-Smtp-Source: AA6agR710n4edD3BI5O94vesCWGnN3jpA1lgY7qh5Pnj63dORRorlN4QFNOHDWfrAS62HS8gTf/NcA==
X-Received: by 2002:a05:620a:288c:b0:6b3:9d1:dbf1 with SMTP id j12-20020a05620a288c00b006b309d1dbf1mr23327364qkp.593.1660207002990;
        Thu, 11 Aug 2022 01:36:42 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-178.retail.telecomitalia.it. [79.46.200.178])
        by smtp.gmail.com with ESMTPSA id ga25-20020a05622a591900b0034361fb2f75sm1343083qtb.22.2022.08.11.01.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 01:36:42 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 2/4] vdpa_sim_blk: make vdpasim_blk_check_range usable by other requests
Date:   Thu, 11 Aug 2022 10:36:30 +0200
Message-Id: <20220811083632.77525-3-sgarzare@redhat.com>
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

Next patches will add handling of other requests, where will be
useful to reuse vdpasim_blk_check_range().
So let's make it more generic by adding the `max_sectors` parameter,
since different requests allow different numbers of maximum sectors.

Let's also print the messages directly in vdpasim_blk_check_range()
to avoid duplicate prints.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 38 +++++++++++++++++-----------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 69c9f4f36f9a..24dd9cae6450 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -42,18 +42,28 @@
 
 static char vdpasim_blk_id[VIRTIO_BLK_ID_BYTES] = "vdpa_blk_sim";
 
-static bool vdpasim_blk_check_range(u64 start_sector, size_t range_size)
+static bool vdpasim_blk_check_range(struct vdpasim *vdpasim, u64 start_sector,
+				    u64 num_sectors, u64 max_sectors)
 {
-	u64 range_sectors = range_size >> SECTOR_SHIFT;
-
-	if (range_size > VDPASIM_BLK_SIZE_MAX * VDPASIM_BLK_SEG_MAX)
-		return false;
+	if (start_sector > VDPASIM_BLK_CAPACITY) {
+		dev_dbg(&vdpasim->vdpa.dev,
+			"starting sector exceeds the capacity - start: 0x%llx capacity: 0x%x\n",
+			start_sector, VDPASIM_BLK_CAPACITY);
+	}
 
-	if (start_sector > VDPASIM_BLK_CAPACITY)
+	if (num_sectors > max_sectors) {
+		dev_dbg(&vdpasim->vdpa.dev,
+			"number of sectors exceeds the max allowed in a request - num: 0x%llx max: 0x%llx\n",
+			num_sectors, max_sectors);
 		return false;
+	}
 
-	if (range_sectors > VDPASIM_BLK_CAPACITY - start_sector)
+	if (num_sectors > VDPASIM_BLK_CAPACITY - start_sector) {
+		dev_dbg(&vdpasim->vdpa.dev,
+			"request exceeds the capacity - start: 0x%llx num: 0x%llx capacity: 0x%x\n",
+			start_sector, num_sectors, VDPASIM_BLK_CAPACITY);
 		return false;
+	}
 
 	return true;
 }
@@ -123,10 +133,9 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 
 	switch (type) {
 	case VIRTIO_BLK_T_IN:
-		if (!vdpasim_blk_check_range(sector, to_push)) {
-			dev_dbg(&vdpasim->vdpa.dev,
-				"reading over the capacity - offset: 0x%llx len: 0x%zx\n",
-				offset, to_push);
+		if (!vdpasim_blk_check_range(vdpasim, sector,
+					     to_push >> SECTOR_SHIFT,
+					     VDPASIM_BLK_SIZE_MAX * VDPASIM_BLK_SEG_MAX)) {
 			status = VIRTIO_BLK_S_IOERR;
 			break;
 		}
@@ -146,10 +155,9 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		break;
 
 	case VIRTIO_BLK_T_OUT:
-		if (!vdpasim_blk_check_range(sector, to_pull)) {
-			dev_dbg(&vdpasim->vdpa.dev,
-				"writing over the capacity - offset: 0x%llx len: 0x%zx\n",
-				offset, to_pull);
+		if (!vdpasim_blk_check_range(vdpasim, sector,
+					     to_pull >> SECTOR_SHIFT,
+					     VDPASIM_BLK_SIZE_MAX * VDPASIM_BLK_SEG_MAX)) {
 			status = VIRTIO_BLK_S_IOERR;
 			break;
 		}
-- 
2.37.1

