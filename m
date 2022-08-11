Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC7958F930
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbiHKIgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbiHKIgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:36:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1CEAE792D6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660207002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bxa8o9Tbfqnk5UAsXfKTjPHNDbYRHlKkIXBkapUnTe8=;
        b=Jsx9V5UMKKzJIemgFfVG6rej/ShWav0ed0J+I53fv9XkshPwnPlFY66C/H1Uvu3gG3PDmy
        YbBvQn3srcibT8B4Tv33OPe+s3YUIkU9oShfX3DkrWPsQh7OYKKmViuZiTtgvGNDBJB+fs
        gpTCGHJktgpi9depi9tPWuKX+ePQFYQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-221-Lmnc7MFUNYq45huEabfSGA-1; Thu, 11 Aug 2022 04:36:41 -0400
X-MC-Unique: Lmnc7MFUNYq45huEabfSGA-1
Received: by mail-qv1-f70.google.com with SMTP id e12-20020ad4442c000000b004796bf5f82cso8166365qvt.20
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=bxa8o9Tbfqnk5UAsXfKTjPHNDbYRHlKkIXBkapUnTe8=;
        b=zLr8aJRtVUwvwtUI3NuvIzEnRs9buxw61zUYGtpJVFOk2rJFm7kh8aokTcgZYF5nCH
         PvBMyyxQrocNmbNvYLdx9mQJsVjkyGpSdIG7Ts/nDOAt5r3NmTXVlA9OX3IVrqhIX+EG
         b6VmUOfGOUdUsDZDXTJk6QPRtyMiPZRxw8sAJwdyLTXXcoW3JNIsQ7ftOEQI5G3MaOV7
         tGlL3KZFo2zkInsttC/wfUW0MZ2mDc5di/bY7ZvBcS5kyqvOq9z10qBAgHjsDxnPwguO
         MRuNlMDz5WBimX6HZTktgZl5OoRzNasWpAcuL4kbE65fEttzH7SDMTgOdE2sHkVbrpr0
         l98w==
X-Gm-Message-State: ACgBeo18sa5fYto1WEGjaWFqAF7CNNgsrgfZFm+rqjuBbkeXdW95inTQ
        6Cbbxi/Dvoh3l9DCXejymq0pDDrxMF9+ps91c6X2ANqKl9kFih4doZSfit3o95F4ATSAgyeAlOS
        EkU/Q/I7CVz8u5OBQJFhLeoL+
X-Received: by 2002:a05:620a:2615:b0:6b9:29a9:b734 with SMTP id z21-20020a05620a261500b006b929a9b734mr17656848qko.273.1660207000598;
        Thu, 11 Aug 2022 01:36:40 -0700 (PDT)
X-Google-Smtp-Source: AA6agR57hP3DZIXEgM1Y5p0tV6h36y995LYZumXLSlAhdlc1snP7yqGxy4qnrXwGh6eXY8qYNOBP7A==
X-Received: by 2002:a05:620a:2615:b0:6b9:29a9:b734 with SMTP id z21-20020a05620a261500b006b929a9b734mr17656841qko.273.1660207000404;
        Thu, 11 Aug 2022 01:36:40 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-178.retail.telecomitalia.it. [79.46.200.178])
        by smtp.gmail.com with ESMTPSA id ga25-20020a05622a591900b0034361fb2f75sm1343083qtb.22.2022.08.11.01.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 01:36:39 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 1/4] vdpa_sim_blk: check if sector is 0 for commands other than read or write
Date:   Thu, 11 Aug 2022 10:36:29 +0200
Message-Id: <20220811083632.77525-2-sgarzare@redhat.com>
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

VIRTIO spec states: "The sector number indicates the offset
(multiplied by 512) where the read or write is to occur. This field is
unused and set to 0 for commands other than read or write."

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index ba253f8bce32..69c9f4f36f9a 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -112,6 +112,15 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 	offset = sector << SECTOR_SHIFT;
 	status = VIRTIO_BLK_S_OK;
 
+	if (type != VIRTIO_BLK_T_IN && type != VIRTIO_BLK_T_OUT &&
+	    sector != 0) {
+		dev_dbg(&vdpasim->vdpa.dev,
+			"sector must be 0 for %u request - sector: 0x%llx\n",
+			type, sector);
+		status = VIRTIO_BLK_S_IOERR;
+		goto err_status;
+	}
+
 	switch (type) {
 	case VIRTIO_BLK_T_IN:
 		if (!vdpasim_blk_check_range(sector, to_push)) {
@@ -178,6 +187,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		break;
 	}
 
+err_status:
 	/* If some operations fail, we need to skip the remaining bytes
 	 * to put the status in the last byte
 	 */
-- 
2.37.1

