Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F76555359E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352452AbiFUPOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352467AbiFUPNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:13:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2C0C2AE02
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655824337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+Yc3piLjSOYJf8KyxbSuOZbWnM7+vW6XohmDJSSJEHM=;
        b=YBis6bdGK+xCr0IwBbwb4rAjuKNtVDBj1K4VD33XW2UutBz6dF6ClIrAGZoW0jNHQo/V/d
        69+bksdecJC8vCxNCGIugNAgXYMtAesLu8+6zSJiVp+JZsiT4eaJGgpxzkV9tLp2e0O8ys
        rd0CeVLLkZs90oMuIW1Ri2rOHadZaiY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-2exe9uYUOE-DBAG0L7gQqw-1; Tue, 21 Jun 2022 11:12:16 -0400
X-MC-Unique: 2exe9uYUOE-DBAG0L7gQqw-1
Received: by mail-qk1-f199.google.com with SMTP id az18-20020a05620a171200b006a708307e94so16723791qkb.14
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Yc3piLjSOYJf8KyxbSuOZbWnM7+vW6XohmDJSSJEHM=;
        b=guIbP391Av6oLYJ190JK5MCY8gnWJjtbdFv8Oh1QS2Al4QOxF1uS3KGMQ/80g61pIY
         VrwLkN8MPd+QAQoFqcneTgX9B6cD65quYyV5G0NzCtXgJBQxibwoDUPMxw5hXigNHuLD
         IJAD6v5qTPAerLYrOk1Z7rFhmkP+er3i2y1j2F97dYfCrlcmDIJ3M7E3msUDAud2i/rc
         Le1H5QWb1aUE3Xydd29TR55keTO0cVW8fA9nWJj2brOrNX5VIfdYd1mgg7gYmGyuhrwY
         H/ECaWeEhW2KwZlt8n3Ze1MeIzV2TVdRT9wUetCstFHfnnGX71uXz0ghFNn3IP1yky8Y
         HE5g==
X-Gm-Message-State: AJIora9pajq/YPZTqGULsXI4r3QqeQJDWQz1pL3TBTIa2D3TZbDIcbQC
        m/ffsxuVB/gADt9G5/d3t4INXthql9cRPe6VJpo9ZS6H1FzXCllSHJpqTsD8sQ+R/tTyxdV+avx
        7Uj4XlGB3Mu593ejH0oU4vIVC
X-Received: by 2002:a05:620a:2793:b0:6a7:44f0:c280 with SMTP id g19-20020a05620a279300b006a744f0c280mr20349729qkp.53.1655824333699;
        Tue, 21 Jun 2022 08:12:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uOo3vKWCa+TRKaTNYxloZSJewJ8mn+JceU1HnjH0/Zgr1kX0gDJMovGRyMPqtz+VsNgoSTNQ==
X-Received: by 2002:a05:620a:2793:b0:6a7:44f0:c280 with SMTP id g19-20020a05620a279300b006a744f0c280mr20349695qkp.53.1655824333313;
        Tue, 21 Jun 2022 08:12:13 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-40.retail.telecomitalia.it. [79.46.200.40])
        by smtp.gmail.com with ESMTPSA id u11-20020a05620a454b00b006a74da327fcsm14778324qkp.99.2022.06.21.08.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 08:12:12 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Gautam Dawar <gautam.dawar@xilinx.com>,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] vdpa_sim: use max_iotlb_entries as a limit in vhost_iotlb_init
Date:   Tue, 21 Jun 2022 17:12:08 +0200
Message-Id: <20220621151208.189959-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.36.1
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

Commit bda324fd037a ("vdpasim: control virtqueue support") changed
the allocation of iotlbs calling vhost_iotlb_init() for each address
space, instead of vhost_iotlb_alloc().

With this change we forgot to use the limit we had introduced with
the `max_iotlb_entries` module parameter.

Fixes: bda324fd037a ("vdpasim: control virtqueue support")
Cc: gautam.dawar@xilinx.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 0f2865899647..3e81532c01cb 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -33,7 +33,7 @@ MODULE_PARM_DESC(batch_mapping, "Batched mapping 1 -Enable; 0 - Disable");
 static int max_iotlb_entries = 2048;
 module_param(max_iotlb_entries, int, 0444);
 MODULE_PARM_DESC(max_iotlb_entries,
-		 "Maximum number of iotlb entries. 0 means unlimited. (default: 2048)");
+		 "Maximum number of iotlb entries for each address space. 0 means unlimited. (default: 2048)");
 
 #define VDPASIM_QUEUE_ALIGN PAGE_SIZE
 #define VDPASIM_QUEUE_MAX 256
@@ -291,7 +291,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
 		goto err_iommu;
 
 	for (i = 0; i < vdpasim->dev_attr.nas; i++)
-		vhost_iotlb_init(&vdpasim->iommu[i], 0, 0);
+		vhost_iotlb_init(&vdpasim->iommu[i], max_iotlb_entries, 0);
 
 	vdpasim->buffer = kvmalloc(dev_attr->buffer_size, GFP_KERNEL);
 	if (!vdpasim->buffer)
-- 
2.36.1

