Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD9F49295E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 16:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241956AbiARPGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 10:06:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35187 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230115AbiARPGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 10:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642518401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6xo5lbFE9mVmkTmHb6sCJ+UU8tLWZ8QGadDUdtyAdg8=;
        b=MTkncmWuia2scEMRfd7C7qz+cSukD63R2gCheOF1fbX5GH8Z9BU2uriep6auxSH4HgEkxC
        wzCmzYN3oz2f8p5y9njaHTwxDOM3U1/r/q2fC7QllCylRcFbc7XtQF7/OPX3M54BZ9XTSe
        EkPHMoR8DsWbYECdc2mTy2+/xeE/1vI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-TJzkU-s5M8Gzvkz4qnlfWg-1; Tue, 18 Jan 2022 10:06:36 -0500
X-MC-Unique: TJzkU-s5M8Gzvkz4qnlfWg-1
Received: by mail-qv1-f71.google.com with SMTP id 6-20020ad45b86000000b0041a32b5b1c4so17095250qvp.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 07:06:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6xo5lbFE9mVmkTmHb6sCJ+UU8tLWZ8QGadDUdtyAdg8=;
        b=7VkeLPDqdXiFzeOkbLywrdfgjEzaaOk1Kh+GAJNa7G+9kpgllCIUGtKmlQTEDSTvj4
         hQkKrbqJFCSknEnJgAOfe61XgyCeseWUV59pCa23Ineg7Dr9jhQQetjZqJ7C33Dv2iL2
         sDYlTHcFtPVwGc5AQ/JTWeZAT/pSuQVWPBYJDATAxSsIyaRu2qEc4go1KTMp18aasVdj
         iEQry5RSH4jf59OgjiYc1M2stnKBfB+CtwHthRfWYN/IOPkW/eNGYSumsRbDGQq3ikdZ
         PLXll8jeFZ1rBDOEcZn/sqp+xNtD1pvlkFvokACQ0M8bxDyvpdAAGBSDqoHz35hxEp0R
         OoNg==
X-Gm-Message-State: AOAM531Lrmoce39FPfs/xgPU6YICRUZ7SS5blcsuocXVRr4kRZu3+HJt
        crBud8KlOLoILrEys8iQ8Mx51l5Zo0/N/JLxo2aReX+Xs/9MqYbIF9DzGWigJ2EsfxToQJqTYA1
        syOUptDOA0XU9hyLEKcMCdoKc
X-Received: by 2002:a05:620a:c41:: with SMTP id u1mr18228756qki.31.1642518395737;
        Tue, 18 Jan 2022 07:06:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXEcL4f7ANyD583jjp3XX8T3sNAL4m2po3Z93AidWiJto0LEpLibFjH30+TEsI2sEVNstxRw==
X-Received: by 2002:a05:620a:c41:: with SMTP id u1mr18228729qki.31.1642518395480;
        Tue, 18 Jan 2022 07:06:35 -0800 (PST)
Received: from steredhat.redhat.com (host-95-238-125-214.retail.telecomitalia.it. [95.238.125.214])
        by smtp.gmail.com with ESMTPSA id b140sm9127737qkg.113.2022.01.18.07.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 07:06:34 -0800 (PST)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] tools/virtio: fix virtio_test execution
Date:   Tue, 18 Jan 2022 16:06:31 +0100
Message-Id: <20220118150631.167015-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio_test hangs on __vring_new_virtqueue() because `vqs_list_lock`
is not initialized.

Let's initialize it in vdev_info_init().

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/virtio/virtio_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index cb3f29c09aff..23f142af544a 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -130,6 +130,7 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
 	memset(dev, 0, sizeof *dev);
 	dev->vdev.features = features;
 	INIT_LIST_HEAD(&dev->vdev.vqs);
+	spin_lock_init(&dev->vdev.vqs_list_lock);
 	dev->buf_size = 1024;
 	dev->buf = malloc(dev->buf_size);
 	assert(dev->buf);
-- 
2.31.1

