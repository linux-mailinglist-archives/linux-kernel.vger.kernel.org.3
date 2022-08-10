Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EAB58E9F7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 11:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbiHJJo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 05:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiHJJn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:43:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36E9451435
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660124636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=38oYZZo5oxfiL5gDqzJLWx2Nj0BFm9A6p9CXqcxwNdc=;
        b=ScIQAoz8opntk0i4mjwVMYcnXSeZ/JokK2r9/iIy5r29AlmHRvRvFaFMvUtFHM9+7XsuYl
        UYA6EJMlz/f4Yi6DyW0rXxzwdO7kZot/j0W+sUqYN64DMVlt1/xIp3CYNEIldLXYK+BClW
        J4iLVCUvFKefnLsxMkUCpVhOE0WkDG8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-NMfBaNX2PTKsIF1bHwHAMg-1; Wed, 10 Aug 2022 05:43:55 -0400
X-MC-Unique: NMfBaNX2PTKsIF1bHwHAMg-1
Received: by mail-wm1-f71.google.com with SMTP id j36-20020a05600c1c2400b003a540d88677so3619734wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=38oYZZo5oxfiL5gDqzJLWx2Nj0BFm9A6p9CXqcxwNdc=;
        b=SM2w7xJ5/kk/3aaSn+bJi4E84cNlQtbR8jwb6h1VcklN/B2boYI2/CXo6NKqTGH94Y
         K0NmDqLMRDvcn2DYYW6h0BLBtp9/q1sLPbsLhv1MSA4ihWrRvw7cnjsdrnDyCb7I4Ty/
         lV3xJyZam59GasZUQTXYQjQJREqaLKsCbKs6V5fBTGCOVDOvf1V0Q6ZxxjucMzO60ERr
         6xCBZ/aud3ftgxYaMgUkjCNxsVSSaMAgfOkYi+WcYNqodjuynDFcxEteszneHMZJAhgC
         moRVNfu75vkZkPkxBmtq79AMO2eFEE9tBBE/KH+ROhShiNgqOSviSgWCf9m/4rjMRVi9
         6d+w==
X-Gm-Message-State: ACgBeo0+HgVBOC9mrfp2WEzz5Zyo23VXlrBwAUQTJhJrkMtZlPp602X0
        Kxvj/94Cw9tOD2TOz+z/O5CCEbV7QTSOn4YBt0FKCnMmc8oAkCk4K8IcYKr1zR6IIdAuLZfQcqU
        b0WkHLQejemBDWGanO5/pOcu+
X-Received: by 2002:a05:600c:4fc9:b0:3a3:3537:1726 with SMTP id o9-20020a05600c4fc900b003a335371726mr1807910wmq.26.1660124633942;
        Wed, 10 Aug 2022 02:43:53 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6+x6w6khhisrJ7VVikYRvP5aWnDOo2jZbJ9hkj27Qmee0ul8zS76kXeQOyfuD1Ht+pNk6ezA==
X-Received: by 2002:a05:600c:4fc9:b0:3a3:3537:1726 with SMTP id o9-20020a05600c4fc900b003a335371726mr1807903wmq.26.1660124633749;
        Wed, 10 Aug 2022 02:43:53 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-178.retail.telecomitalia.it. [79.46.200.178])
        by smtp.gmail.com with ESMTPSA id q11-20020a5d658b000000b0021e4bc9edbfsm12921743wru.112.2022.08.10.02.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 02:43:52 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 2/4] vdpa_sim_blk: make vdpasim_blk_check_range usable by other requests
Date:   Wed, 10 Aug 2022 11:43:45 +0200
Message-Id: <20220810094347.20449-3-sgarzare@redhat.com>
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

