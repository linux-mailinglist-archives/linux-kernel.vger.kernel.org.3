Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8DD58F8E9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbiHKIRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbiHKIRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:17:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A27A61D62
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660205823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1OOrknk8wnSFx/n3LoSQep6GlbQsFGYPjQcITSJy2Bg=;
        b=Hat45ZAk4k5VCzEk9edlUyFnUVCPMHGKSgSTXQViDgmNMUA8sRwkXv1DmDIu1Xo6RFrSMk
        B5IO7iavx4NKsArDrR8n+qhB0Y8n6arobkmUP4uxV5X+FWsDKt8rFWVwbwInTNdCzfecfE
        Fz8ocb/2t1ttq9cSaK3HrgQYoTTyShU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-1-HEfxOP-VO4SXGIzdJmsp1w-1; Thu, 11 Aug 2022 04:17:01 -0400
X-MC-Unique: HEfxOP-VO4SXGIzdJmsp1w-1
Received: by mail-ej1-f70.google.com with SMTP id g18-20020a1709065d1200b0073082300e1fso5219556ejt.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=1OOrknk8wnSFx/n3LoSQep6GlbQsFGYPjQcITSJy2Bg=;
        b=ypBwd3SnoJC/5INFpeA5l5aL0AXZrKcwsz2w1YApwR8VU0z1b3jFv4dfNxtIwZDBjj
         T0GGJdYa4lLMwerP38Bb+iUtmIMYB3rJIdNyZCe/vGXBn9l5Bpis/KFXC41nZ5X/10bW
         bez1SrtGd/v7b+gGq3Jy6vVLKhMCsFsAm9glVAVK9sk6biB/Hd1Nx8r080H1EUUDnCjm
         2iKoBcdpFmI5uiXnAHwXg/y38D2fww2ACVG6IRh9lO3y1Rt3KWTCD99B6Z+2NiqLWJPg
         cgmp2OihozUnxMPBorcG7bjTdhFDWWRuRin4zTZavoL6LsQPlOdib/buGtxOeKs3JLva
         oMvA==
X-Gm-Message-State: ACgBeo2KGjfjTnNG59lEnLG2NL5RReg/8oYwS3Mp72oWgkWhpQS7+5z+
        l0rSthM8WIk/52e23v1fVvpLDtpwhq2nALmUtGcv7/9JVkN+UtYJ+tpZtD4U0sIimJnPW1sH6r3
        2JJ0PNBcfE/WoaOp5jxsYRM1iDQ3xsn2gRgsXufIr3cdMOfZNKnCELMFcw2/OQN9IHeDyhg==
X-Received: by 2002:a50:d0da:0:b0:43d:5f5f:32c3 with SMTP id g26-20020a50d0da000000b0043d5f5f32c3mr29851729edf.192.1660205820429;
        Thu, 11 Aug 2022 01:17:00 -0700 (PDT)
X-Google-Smtp-Source: AA6agR68vSw7W3x93NsUlsYejFUy4nOPkEvkd4PRrJxSCN/xe0+b7SG/AfUzQoWeUSQ4vt3B31T8MQ==
X-Received: by 2002:a50:d0da:0:b0:43d:5f5f:32c3 with SMTP id g26-20020a50d0da000000b0043d5f5f32c3mr29851709edf.192.1660205820200;
        Thu, 11 Aug 2022 01:17:00 -0700 (PDT)
Received: from redhat.com ([2.52.152.113])
        by smtp.gmail.com with ESMTPSA id f26-20020a170906139a00b0072b55713daesm3255618ejc.56.2022.08.11.01.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 01:16:59 -0700 (PDT)
Date:   Thu, 11 Aug 2022 04:16:57 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Hulk Robot <hulkci@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: virtio_bt: fix device removal
Message-ID: <20220811080943.198245-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device removal is clearly out of virtio spec: it attempts to remove
unused buffers from a VQ before invoking device reset. To fix, make
open/close NOPs and do all cleanup/setup in probe/remove.


NB: This is a hacky way to handle this - virtbt_{open,close} as NOP is
not really what a driver is supposed to be doing. These are transport
enable/disable callbacks from the BT core towards the driver. It maps to
a device being enabled/disabled by something like bluetoothd for
example. So if disabled, users expect that no resources/queues are in
use.  It does work with all other transports like USB, SDIO, UART etc.
There should be no buffer used if the device is powered off. We also
don’t have any USB URBs in-flight if the transport is not active.

The way to implement a proper fix would be using vq reset if supported,
or even using a full device reset.

The cost of the hack used here is a single skb wasted on an unused bt device.

NB2: with this fix in place driver still suffers from a race condition
if an interrupt triggers while device is being reset.  To fix, in the
virtbt_close() callback we should deactivate all interrupts.  To be
fixed.

Includes a squashed fixup: bluetooth: virtio_bt: fix an error code in probe()

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/bluetooth/virtio_bt.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 67c21263f9e0..f6d699fed139 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -50,8 +50,11 @@ static int virtbt_add_inbuf(struct virtio_bluetooth *vbt)
 
 static int virtbt_open(struct hci_dev *hdev)
 {
-	struct virtio_bluetooth *vbt = hci_get_drvdata(hdev);
+	return 0;
+}
 
+static int virtbt_open_vdev(struct virtio_bluetooth *vbt)
+{
 	if (virtbt_add_inbuf(vbt) < 0)
 		return -EIO;
 
@@ -61,7 +64,11 @@ static int virtbt_open(struct hci_dev *hdev)
 
 static int virtbt_close(struct hci_dev *hdev)
 {
-	struct virtio_bluetooth *vbt = hci_get_drvdata(hdev);
+	return 0;
+}
+
+static int virtbt_close_vdev(struct virtio_bluetooth *vbt)
+{
 	int i;
 
 	cancel_work_sync(&vbt->rx);
@@ -354,8 +361,15 @@ static int virtbt_probe(struct virtio_device *vdev)
 		goto failed;
 	}
 
+	virtio_device_ready(vdev);
+	err = virtbt_open_vdev(vbt);
+	if (err)
+		goto open_failed;
+
 	return 0;
 
+open_failed:
+	hci_free_dev(hdev);
 failed:
 	vdev->config->del_vqs(vdev);
 	return err;
@@ -368,6 +382,7 @@ static void virtbt_remove(struct virtio_device *vdev)
 
 	hci_unregister_dev(hdev);
 	virtio_reset_device(vdev);
+	virtbt_close_vdev(vbt);
 
 	hci_free_dev(hdev);
 	vbt->hdev = NULL;
-- 
MST

