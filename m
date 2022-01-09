Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE427488997
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 14:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbiAINYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 08:24:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49524 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235686AbiAINYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 08:24:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641734678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AZlBRd0JMxq9ZctAhfgPWRyXb0BQdSnupf+1wrqOpX0=;
        b=e1ByI8QECwyHUUUG/z3tcqQYYm7Tcc+omDx6klHaJ9fPZSFmyf+LIGoFvLrpC9Zkg6IZoZ
        y9EoXNzblbZQtAJwRbSBJqjSypiKAMPVFhRoECeu9UR20z/Y1nC2aUbauYwTltUnAVyUJ7
        g4dA77ydMj7wNCtGfqkMzJvCQukLOxQ=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-ghvzuI7-Mre-lpOdgU-GaA-1; Sun, 09 Jan 2022 08:24:37 -0500
X-MC-Unique: ghvzuI7-Mre-lpOdgU-GaA-1
Received: by mail-oo1-f71.google.com with SMTP id z20-20020a4a8e54000000b002c632ba3a12so7593330ook.7
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 05:24:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AZlBRd0JMxq9ZctAhfgPWRyXb0BQdSnupf+1wrqOpX0=;
        b=uFmHlYo8NSpaZl/a1cziRd7yvLoU/9E+Rp6hA328H8RUfNh+1/bcFQ+rAd2+AHTBOs
         C8czbQopUetCE1ic0BYaqsIytrbqntAEFO5AuyeZRwcSvCBc/YG0QMK8sRdxwH96HwGZ
         oaDKatMMIKQGTDKfPIozsiRNbyCA3uANezq29b0+vLLYJpS8R41Ij3qINJNN4c3vcoQO
         29r8usktdvrZVb/81I2EabvCP1/jomattFkN3Je1AIkzf6uVxpnjO3/6TOBRnjXfxeAV
         oomjg/P8C4jF1XqF2XCeUL7jcP+uBH12cVegXmh78KEFJyLSqbjJ+AgoVDUPj0l5yfpS
         vn3w==
X-Gm-Message-State: AOAM533nPTt/qKd9vBZTqy/vElEZqrxjAaS1CweuHXe6+mQELbbXoKR4
        vPS3ucuccE049cdwV+ifFTyUvgerZ36g0OIPaqgKiRhFt1L0jqG0hzwzO9G9RAiq3iySqjK1u1r
        QJ/Ee9lZZMtPJNbfpSeUPJR4o
X-Received: by 2002:a05:6808:16a3:: with SMTP id bb35mr16188273oib.72.1641734676923;
        Sun, 09 Jan 2022 05:24:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRNNjtG5LHg2Okptt9Knjyucoxh60fPJHzQFLTjipnYG1hpu83IQxMw1yEfTI7lHDR08UpxA==
X-Received: by 2002:a05:6808:16a3:: with SMTP id bb35mr16188253oib.72.1641734676704;
        Sun, 09 Jan 2022 05:24:36 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id 4sm924228otl.26.2022.01.09.05.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 05:24:36 -0800 (PST)
From:   trix@redhat.com
To:     mst@redhat.com, jasowang@redhat.com, elic@nvidia.com,
        parav@nvidia.com, si-wei.liu@oracle.com, xieyongji@bytedance.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] vdpa/mlx5: simplfy error handler in mlx5_vdpa_dev_add()
Date:   Sun,  9 Jan 2022 05:24:22 -0800
Message-Id: <20220109132422.4047425-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The use of pfmdev is protected by two calls to is_zero_ether_add().
The second call in the error handler can be replaced by
checking if pfmdev was set as part of the earlier call.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 37220f6db7ad7..2d38b8fe9305e 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2530,7 +2530,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 {
 	struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct mlx5_vdpa_mgmtdev, mgtdev);
 	struct virtio_net_config *config;
-	struct mlx5_core_dev *pfmdev;
+	struct mlx5_core_dev *pfmdev = NULL;
 	struct mlx5_vdpa_dev *mvdev;
 	struct mlx5_vdpa_net *ndev;
 	struct mlx5_core_dev *mdev;
@@ -2654,7 +2654,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 err_res:
 	mlx5_vdpa_free_resources(&ndev->mvdev);
 err_mpfs:
-	if (!is_zero_ether_addr(config->mac))
+	if (pfmdev)
 		mlx5_mpfs_del_mac(pfmdev, config->mac);
 err_mtu:
 	mutex_destroy(&ndev->reslock);
-- 
2.26.3

