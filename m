Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2B5553770
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353796AbiFUQJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353760AbiFUQJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:09:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FC0E2E081
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655827749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:  content-type:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+bAhmFC/hjGzAWfV3jJm6JhUFvDtTISGABduARBAGlA=;
        b=e6Ypuf3EsqI4IwKi4Fp1It6nDNcar9Z02vQugp/pUWnw1cPPTvsx4UHFThi4JVwe5FrAXV
        PGQq3HsblU5b96zkTGaBhKoNK2xyjORDU2uKMF99/BdQWqN7y2TUh2pvS9e21rRbdXPWGD
        LRQ7jeOwpUMdORJsexbKmqr5EEDE2Sk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-VRfi1tzjO0mxScI7HTA63w-1; Tue, 21 Jun 2022 12:09:08 -0400
X-MC-Unique: VRfi1tzjO0mxScI7HTA63w-1
Received: by mail-wm1-f69.google.com with SMTP id m23-20020a05600c3b1700b0039c6e3c169aso6596619wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+bAhmFC/hjGzAWfV3jJm6JhUFvDtTISGABduARBAGlA=;
        b=cBXlsuzTIzMr825OkDT70Xgnwue7+o13aw+k/ho1m9KTY9g25+rWcvxGhU33+Ah4xj
         QwM2/ov7HBeFchJ+M6T6heo5I5A77HrD+wJ3BbwHk8v4PCot+jsHA1qHKVBcX2Kkkce5
         osiP3/zdNKxP8oPObyLi1mLUKZTWquJGHfqM3z207/pXxCsiAPM3N+5D5ZF0NQJP5Wpo
         8tQtkoXR73XF+JI2DaFS7pWg7agHoC7+6XTFt3BT4bVEpEmMatCh0twhz1/oFXrTN5uc
         sVAyoGfPNzweyGmGjtaRjUNWBZS5gb5pobfCCLtQX/lJg0EMCzh9KnyaPXVrVDiCDl47
         6YNQ==
X-Gm-Message-State: AOAM533wD8BuqMcF1id8mGh6Lv5alpwt5uZIGdv7z/q0A6LwEisekMiP
        PgE7+w2RnyMjeHDadAwPdLdmGtyu66RhdTPBWr7qz/QrPBZXTmjoUAx7eJRSNNn70Z3gX17GATK
        JFD7oEJlqTCzdNdu17RLOoLvj
X-Received: by 2002:a05:600c:42c9:b0:39c:3808:5479 with SMTP id j9-20020a05600c42c900b0039c38085479mr41301674wme.4.1655827746250;
        Tue, 21 Jun 2022 09:09:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3l84ij+5Pi9MrXnI7nrsOXu5NGSIn7YSrgA1eUFOkpS4ItURWuYfMpqa4odA2HMkGBOrEKQ==
X-Received: by 2002:a05:600c:42c9:b0:39c:3808:5479 with SMTP id j9-20020a05600c42c900b0039c38085479mr41301654wme.4.1655827746039;
        Tue, 21 Jun 2022 09:09:06 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-40.retail.telecomitalia.it. [79.46.200.40])
        by smtp.gmail.com with ESMTPSA id ba7-20020a0560001c0700b0021b903a018bsm6531560wrb.92.2022.06.21.09.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 09:09:05 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Jason Wang <jasowang@redhat.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 2/3] vdpa_sim_blk: limit the number of request handled per batch
Date:   Tue, 21 Jun 2022 18:08:58 +0200
Message-Id: <20220621160859.196646-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621160859.196646-1-sgarzare@redhat.com>
References: <20220621160859.196646-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
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
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index a83a5c76f620..ac86478845b6 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -197,6 +197,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 static void vdpasim_blk_work(struct work_struct *work)
 {
 	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
+	bool reschedule = false;
 	int i;
 
 	spin_lock(&vdpasim->lock);
@@ -206,11 +207,15 @@ static void vdpasim_blk_work(struct work_struct *work)
 
 	for (i = 0; i < VDPASIM_BLK_VQ_NUM; i++) {
 		struct vdpasim_virtqueue *vq = &vdpasim->vqs[i];
+		bool vq_work = true;
+		int reqs = 0;
 
 		if (!vq->ready)
 			continue;
 
-		while (vdpasim_blk_handle_req(vdpasim, vq)) {
+		while (vq_work) {
+			vq_work = vdpasim_blk_handle_req(vdpasim, vq);
+
 			/* Make sure used is visible before rasing the interrupt. */
 			smp_wmb();
 
@@ -218,10 +223,18 @@ static void vdpasim_blk_work(struct work_struct *work)
 			if (vringh_need_notify_iotlb(&vq->vring) > 0)
 				vringh_notify(&vq->vring);
 			local_bh_enable();
+
+			if (++reqs > 4) {
+				vq_work = false;
+				reschedule = true;
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

