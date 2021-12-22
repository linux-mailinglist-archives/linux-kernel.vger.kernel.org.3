Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1176847D0E9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244631AbhLVLVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244619AbhLVLU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:20:58 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B0BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 03:20:58 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id j13so1667550plx.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 03:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=etVxAg24PbMV33+XjRe5XTnQKkvT/TEscqd9pcdp/aI=;
        b=h+ipK6wbKWsX8jDnN3tahSALHIKoxzk7eq2i8SXhqVIOpRP8dsLGnAcwfFT5NQuYsO
         rNNPfnJ00C9SOcvJWxpDFihOx7xY2/9btnNTya+RzqLu0gq0hDvDzqZ5hpEE2ZoGDdl0
         FAnONbsZjYQBKZ4V3iK8x3+oVO3aTQu3Vmz8JOihxie2ObGFUd8+ZK3rQ2OIO/4bw9sJ
         SSyYdBXdz311Yco2mYtUxwzFGXzNInaRYv9WrbiUN6nBAe5MriQ8+WSDhbmAR7S+8oNR
         MgsfHCwwMwYQUeaFE5+Ou99nkAsbjnj9V4KWd5yLUcKsVXSXuvut75dJPhAhvkwNeN+a
         XHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=etVxAg24PbMV33+XjRe5XTnQKkvT/TEscqd9pcdp/aI=;
        b=ZP4+3FrN1cgZ66ANfC9og7U3ZpGyulBY1cj6jfcaauC7lRKWvdQB4hgqZ0/vMqWh8E
         Ci36oF8xS6olrefDSJLhuG3xk3WEb7HDLwTSM4w5IWvpu5NJvGV/M/K2Dvu41glKw8uB
         8DEh+9kgvWvX7D3lmiZTUTnVRDJYpOHkAnRdWyJGmo0XbRW8YsXaz90ik7FkiZ0eo7Hi
         qX63bbyCgk6IFn4q87q12+bDVCRxxpZoKH8ellGMbuTSJpQG0K4S91tvxyoindbGOwpj
         o3wiV4sLAF+yeHBNf3F+y3JG14Bl/q1RpW7vvpTs7SrlJVtm+8TPoXusfy/JFeK1DpFa
         A/eQ==
X-Gm-Message-State: AOAM531pyzpvoiQ45I6SAdWAQ6M+b4Jxi8DLTRUyVPEu4ywlnk1GCira
        15OoKRtL+LeM+7+GHHMdd84=
X-Google-Smtp-Source: ABdhPJzu21Yb6LHxM2Lx95M/II9EMLVAmjoXIZBPjchD6a200mHm+45x4Nn3hrs9oYWKekMT5T7b0A==
X-Received: by 2002:a17:902:e884:b0:148:b91b:d7e2 with SMTP id w4-20020a170902e88400b00148b91bd7e2mr2312544plg.87.1640172057747;
        Wed, 22 Dec 2021 03:20:57 -0800 (PST)
Received: from FLYINGPENG-MB0.tencent.com ([103.7.29.30])
        by smtp.gmail.com with ESMTPSA id f4sm2579373pfj.61.2021.12.22.03.20.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Dec 2021 03:20:57 -0800 (PST)
From:   Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To:     jasowang@redhat.com, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH]  virtio/virtio_pci_legacy_dev: ensure the correct return value
Date:   Wed, 22 Dec 2021 19:20:14 +0800
Message-Id: <20211222112014.87394-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pci_iomap return NULL, the return value is zero.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 drivers/virtio/virtio_pci_legacy_dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_legacy_dev.c b/drivers/virtio/virtio_pci_legacy_dev.c
index 9b97680dd02b..677d1f68bc9b 100644
--- a/drivers/virtio/virtio_pci_legacy_dev.c
+++ b/drivers/virtio/virtio_pci_legacy_dev.c
@@ -45,8 +45,10 @@ int vp_legacy_probe(struct virtio_pci_legacy_device *ldev)
 		return rc;
 
 	ldev->ioaddr = pci_iomap(pci_dev, 0, 0);
-	if (!ldev->ioaddr)
+	if (!ldev->ioaddr) {
+		rc = -EIO;
 		goto err_iomap;
+	}
 
 	ldev->isr = ldev->ioaddr + VIRTIO_PCI_ISR;
 
-- 
2.27.0

