Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A88561F50
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbiF3Pcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235866AbiF3Pch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:32:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 853AD3E0E9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 08:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656603155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:  content-type:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YJ2kJ9M3J473925A1Sz+6DavMX+WtsWN9FnXUNFiskQ=;
        b=HKNvjVWLlf7aKwZqCy7lihLm0rTY86mSLzFhto+6KgXSrbJQMd7TTivOSAnRCyxMFUJ7H2
        e8XMDhnVvACV9A9lyn5y1hqUR5a6mkn6s7Pcc0JinHsdamhe1ZwUMlT2hjGT2t2s3Xm5aQ
        bt3M0vEc1DpgK/PkmfVFgjynvkc2r7s=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64--ctdSa9bO9GcFTH-5sRXTg-1; Thu, 30 Jun 2022 11:32:33 -0400
X-MC-Unique: -ctdSa9bO9GcFTH-5sRXTg-1
Received: by mail-qv1-f70.google.com with SMTP id j6-20020a05621419c600b004704e6665caso18676325qvc.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 08:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJ2kJ9M3J473925A1Sz+6DavMX+WtsWN9FnXUNFiskQ=;
        b=bj/qsDub7uXNif6wvd6J+QkXMEJ/C8PYPmhj9851tHvBYfGNiN1pYVVAoh486EFoXm
         IIMrHxMHwSDeSVmUqgpRsS/ChENjbLrIDn/rdcynvJs31QvC7hY+tdRx9XFlxAjHRz+m
         iR2ZRNsDKxYO5UqwHQ6waAI6tCGG4CmBpkGtXtned6VDfPjLuzxR7UTMG9tAC7bQt2/n
         +qXL/5D7P+q5GNON74DoZu50CSg0KIXyAirOXhQeEE4sJRmU3HqwIJU0C5Ago2AShfjf
         C+BG5nqzc35UF1lvWdZby/4CadFA8VNihnjXcQE7YtvRlc63t246XX5TnSbqOwNSEA3l
         R/xg==
X-Gm-Message-State: AJIora+EFAWyAVWjG3N+664quwcqLBloZb2NcG3dExhGqRtWMgkj6hU9
        s07nlLUOIrZ31dsBdeiL/OLSiW9zw833vRl/1XAoS8Cd1eN3PyG2U04gFiRoBZ3cVMepJXDNJut
        J8FQnR0SIsfDa+Yl6hyjS71yJ
X-Received: by 2002:a05:6214:2307:b0:46e:5fbc:3c30 with SMTP id gc7-20020a056214230700b0046e5fbc3c30mr12691619qvb.21.1656603152643;
        Thu, 30 Jun 2022 08:32:32 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1syyg6jTK7iMokKvzkf30z0DmBsGln/1Z2e4Epr35QPBJLcZ3UXJlIecbQRWimM+K/3INQ4BQ==
X-Received: by 2002:a05:6214:2307:b0:46e:5fbc:3c30 with SMTP id gc7-20020a056214230700b0046e5fbc3c30mr12691583qvb.21.1656603152249;
        Thu, 30 Jun 2022 08:32:32 -0700 (PDT)
Received: from step1.redhat.com (host-87-11-6-149.retail.telecomitalia.it. [87.11.6.149])
        by smtp.gmail.com with ESMTPSA id y20-20020a05620a44d400b006af0639f7casm16089325qkp.12.2022.06.30.08.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 08:32:31 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 2/3] vdpa_sim_blk: limit the number of request handled per batch
Date:   Thu, 30 Jun 2022 17:32:20 +0200
Message-Id: <20220630153221.83371-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220630153221.83371-1-sgarzare@redhat.com>
References: <20220630153221.83371-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Limit the number of requests (4 per queue as for vdpa_sim_net) handled
in a batch to prevent the worker from using the CPU for too long.

Suggested-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
- restored previous behaviour, exiting the loop immediately if the
  request is malformed [Jason]
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index a83a5c76f620..b2d75efec63a 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -197,6 +197,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 static void vdpasim_blk_work(struct work_struct *work)
 {
 	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
+	bool reschedule = false;
 	int i;
 
 	spin_lock(&vdpasim->lock);
@@ -206,6 +207,7 @@ static void vdpasim_blk_work(struct work_struct *work)
 
 	for (i = 0; i < VDPASIM_BLK_VQ_NUM; i++) {
 		struct vdpasim_virtqueue *vq = &vdpasim->vqs[i];
+		int reqs = 0;
 
 		if (!vq->ready)
 			continue;
@@ -218,10 +220,18 @@ static void vdpasim_blk_work(struct work_struct *work)
 			if (vringh_need_notify_iotlb(&vq->vring) > 0)
 				vringh_notify(&vq->vring);
 			local_bh_enable();
+
+			if (++reqs > 4) {
+				reschedule = true;
+				break;
+			}
 		}
 	}
 out:
 	spin_unlock(&vdpasim->lock);
+
+	if (reschedule)
+		schedule_work(&vdpasim->work);
 }
 
 static void vdpasim_blk_get_config(struct vdpasim *vdpasim, void *config)
-- 
2.36.1

