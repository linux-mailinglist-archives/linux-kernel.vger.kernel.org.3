Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEC8554ED8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359256AbiFVPOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359138AbiFVPOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:14:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B5CE1706A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655910854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wGPNK+3CbuAdTkTsB3EwZQ5iFbUOR/MKa+csfzqSuVU=;
        b=W1RYIxCEFV12o5UsnZOYf5YCT7mAYuR+MEVGIw7QCB6fc1kFXPYf8hUmk2FpC1qlG/evjX
        5e0E+LCFb/t2JYKSMNIXrfJIO2sJBJx/PgJzm8AVUeNytBhpDZAKURyrT+ZvgNyrB+aGQK
        rIjoAn/PyPMZPBAbYRTOYgfJk0jCC2o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-cOrf-6MlPKCIGRd9qdlQVA-1; Wed, 22 Jun 2022 11:14:12 -0400
X-MC-Unique: cOrf-6MlPKCIGRd9qdlQVA-1
Received: by mail-wm1-f69.google.com with SMTP id ay28-20020a05600c1e1c00b0039c5cbe76c1so10206482wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wGPNK+3CbuAdTkTsB3EwZQ5iFbUOR/MKa+csfzqSuVU=;
        b=Y97o7efmHFRT9v3BqbTL1F5Hh/xbiC6G0icxfXWiTeeI8ofjIZ5MNNGsKu+sr5EOZ8
         /ZcuyI1DHhMGREictHaIgxK2qSs1kWpDyePmQnaOlC4h8EDmyilFr5Fvajg6q01KPAIl
         Io15PWAEx8LBxGNmKZjBWkVbNqn1msPLnE6rYMkT35G1e5eeQ+AB5hNFiZc5Vtl2bl5O
         wD7mps6+uq6A2U2e8kkDHktWGm0vxSuMvzY7Xgu+nI8kCi5Y96xlSO5VbdEeBqBo506F
         4uEyKR2jYL28c4RQA9ZjpX8YmgJQKDEH4uSDDSjTAErD54UoeClspBzmH/hM0M8oc286
         +SGw==
X-Gm-Message-State: AOAM531R4K5Q3pqipbP/h/fVty2cVYUiaLd1GqrtdTJWYvDK+yKYpM7d
        MHbQKyP+tBDMuPI7fF5LFbBJhqJHLTbh+8uWto/vSvTboYzqTqUiH6EPaBSZmk0YZyXLlSvsre/
        PgqrBKulUM61rzznE3u3RXt58
X-Received: by 2002:a05:600c:3508:b0:39c:8240:5538 with SMTP id h8-20020a05600c350800b0039c82405538mr46419577wmq.165.1655910849743;
        Wed, 22 Jun 2022 08:14:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEzFT4TFaMqQR0Ghk5VXNDtqjANOX/reNQn5bceF+MCQwu4Q10ypxVnyl4WOcDbkKlljFl6w==
X-Received: by 2002:a05:600c:3508:b0:39c:8240:5538 with SMTP id h8-20020a05600c350800b0039c82405538mr46419547wmq.165.1655910849466;
        Wed, 22 Jun 2022 08:14:09 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-40.retail.telecomitalia.it. [79.46.200.40])
        by smtp.gmail.com with ESMTPSA id z6-20020a7bc7c6000000b0039c63f4bce0sm25194613wmk.12.2022.06.22.08.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 08:14:08 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        Gautam Dawar <gautam.dawar@xilinx.com>, kvm@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] vhost-vdpa: call vhost_vdpa_cleanup during the release
Date:   Wed, 22 Jun 2022 17:14:07 +0200
Message-Id: <20220622151407.51232-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before commit 3d5698793897 ("vhost-vdpa: introduce asid based IOTLB")
we call vhost_vdpa_iotlb_free() during the release to clean all regions
mapped in the iotlb.

That commit removed vhost_vdpa_iotlb_free() and added vhost_vdpa_cleanup()
to do some cleanup, including deleting all mappings, but we forgot to call
it in vhost_vdpa_release().

This causes that if an application does not remove all mappings explicitly
(or it crashes), the mappings remain in the iotlb and subsequent
applications may fail if they map the same addresses.

Calling vhost_vdpa_cleanup() also fixes a memory leak since we are not
freeing `v->vdev.vqs` during the release from the same commit.

Since vhost_vdpa_cleanup() calls vhost_dev_cleanup() we can remove its
call from vhost_vdpa_release().

Fixes: 3d5698793897 ("vhost-vdpa: introduce asid based IOTLB")
Cc: gautam.dawar@xilinx.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 5ad2596c6e8a..23dcbfdfa13b 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1209,7 +1209,7 @@ static int vhost_vdpa_release(struct inode *inode, struct file *filep)
 	vhost_dev_stop(&v->vdev);
 	vhost_vdpa_free_domain(v);
 	vhost_vdpa_config_put(v);
-	vhost_dev_cleanup(&v->vdev);
+	vhost_vdpa_cleanup(v);
 	mutex_unlock(&d->mutex);
 
 	atomic_dec(&v->opened);
-- 
2.36.1

