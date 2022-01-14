Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D4848F22E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 22:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiANV5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 16:57:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46675 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230001AbiANV5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 16:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642197449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L16b4DGvxyPb5nATXEM8DIgZjgXdywlPz0ryK6DeeCM=;
        b=BkjCaRmIUO636ZPtGKt18sGd8GVMVbAzKVbqf7Np5vcQsamgX8keP+NDi/ZeNgcbzefeTU
        83hCa5f+AY0J2v/Az1N3USl2pNTLjfXs/Gmy9oPNOHLhxzj73UBpyNtrSoD81ANesWfVbR
        /swPwKlYZUyxfZRv7cDK1oARChBzkMg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-439-cSLt-ZQ_M_SZfTI4Lc569g-1; Fri, 14 Jan 2022 16:57:28 -0500
X-MC-Unique: cSLt-ZQ_M_SZfTI4Lc569g-1
Received: by mail-ed1-f70.google.com with SMTP id z10-20020a05640235ca00b003f8efab3342so9313144edc.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 13:57:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L16b4DGvxyPb5nATXEM8DIgZjgXdywlPz0ryK6DeeCM=;
        b=opk8HRqnuhBthmgndoDiuJ0o1KNVkWd++mdXoQFfxGOAomibbBZM5fD3NfJnL15oKg
         /O2i+CISI3A4rvHe3pr37bHaRjy1WgqTX8655a4DMXGCZPjx5yRWh69whTxsTpvmGxfW
         gtJeHxcxK2P2jFCeOpFJvS7GXxm6ByNNvOl8HuRmAyn5ToAJPXHrjbaPkasg3BFRvEOU
         t2GvVWemHjne9Th/cuO9EXWiGL51eug57ojy/vf/F09QBK78fw/9804H8ddExSmY6LGH
         r8ozoyrPEXhHWOs2g+ugVspuvBWan/OiLMZykrLS3ZfGZtDyNHhlMYbyUDOPgz2hcH7d
         lHPQ==
X-Gm-Message-State: AOAM530iiWrA8qvX4zkDfcWLnK34HMIH5WVc32yRufQtCT2zsJkdRI5J
        emMAaSK7OyeEEUb8DZ8BpHlUag0syb4ALPWo3lXn1jsuu1g4kT8Inqw8rS83K8BduN2vl7ZvMvj
        MtMJFKFiRSfjBw1o94IAi3eoLFFhR/tpDggksI4QxsLtLaSnyVeiMNnqElJY4dP/ynLq9jA==
X-Received: by 2002:aa7:ce14:: with SMTP id d20mr8882139edv.234.1642197447022;
        Fri, 14 Jan 2022 13:57:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRf2UPE1rQiu4oDrmGOKJ5fch7iHEHP3P6A+VJ1Pk64gSLJydxmVYQaT6KOfiVjxBzt05taw==
X-Received: by 2002:aa7:ce14:: with SMTP id d20mr8882118edv.234.1642197446731;
        Fri, 14 Jan 2022 13:57:26 -0800 (PST)
Received: from redhat.com ([2.55.154.210])
        by smtp.gmail.com with ESMTPSA id c12sm2869794edx.80.2022.01.14.13.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 13:57:25 -0800 (PST)
Date:   Fri, 14 Jan 2022 16:57:24 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 1/3] virtio: document virtio_reset_device
Message-ID: <20220114215641.239984-2-mst@redhat.com>
References: <20220114215641.239984-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220114215641.239984-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like most callers get driver/device removal wrong.
Document what's expected of callers.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 2ed6e2451fd8..631a346a3aa6 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -201,6 +201,22 @@ static int virtio_finalize_features(struct virtio_device *dev)
 	return 0;
 }
 
+/**
+ * virtio_reset_device - quiesce device for removal
+ * @dev: the device to reset
+ *
+ * Prevents device from sending interrupts and accessing memory.
+ *
+ * Generally used for cleanup during driver / device removal.
+ *
+ * Once this has been invoked, caller must ensure that
+ * virtqueue_notify / virtqueue_kick are not in progress.
+ *
+ * Note: this guarantees that vq callbacks are not in progress, however caller
+ * is responsible for preventing access from other contexts, such as a system
+ * call/workqueue/bh.  Invoking virtio_break_device then flushing any such
+ * contexts is one way to handle that.
+ * */
 void virtio_reset_device(struct virtio_device *dev)
 {
 	dev->config->reset(dev);
-- 
MST

