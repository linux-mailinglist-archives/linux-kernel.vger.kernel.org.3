Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D3058FA3D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 11:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbiHKJqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 05:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbiHKJqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 05:46:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8607C79A4D
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 02:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660211193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wpGpSji8gBrXT5CEn6I+LR4cIjiEl5zj4ICp8/ctfA0=;
        b=HttTp4amC18yr1DAs7OrKM1hd7X0+Kw4RtfytX7Yy8gnh4Jg/Dy7GBwFiEYvccVbfpqi0J
        2zXHxTkMx+RtSwFQ7pFsh94HSEaJjMoXRNPX1WGu8xbWH/YN/Rflt93l/+WEtfgwZoQbzi
        h2oyE2mYn+S//STkcEc/D0WId02Uow4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-183-mkI8FCJ_OWiW4uDCYJF2eQ-1; Thu, 11 Aug 2022 05:46:32 -0400
X-MC-Unique: mkI8FCJ_OWiW4uDCYJF2eQ-1
Received: by mail-ej1-f72.google.com with SMTP id g18-20020a1709065d1200b0073082300e1fso5287317ejt.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 02:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=wpGpSji8gBrXT5CEn6I+LR4cIjiEl5zj4ICp8/ctfA0=;
        b=o/fr1apEw+HHven50HP8DLpk3grAXu7fORDee37z/qAroJH2K61foherdYkd2B9rvz
         ZwLI4xZ8oPHm+Awh3i0/xqVYvOsujU5cxajFbhIAXJ7CN6uSksHoEOGJMcaVk0QbkCb4
         veXmK6fWfr/yIXRbTPpDhG3xi2YXAz7kVlT06tzGAoFsjAXcbxRG3sc8KfjxvvwoctqS
         54jsENWkvsNtd3fnb7e5ZfR7O7xKVgANoD/loiWxhsybOfb7NXidUBDNBhYsaheiLH+j
         evU6cxVulZhzwBCXqyr5P5BemomD67rUjIslVRLLsgjdHlRZvNoJJ3n8ALr2/3EPMic0
         Lwmw==
X-Gm-Message-State: ACgBeo33IhZp+SUYcqCtNGa0Own2tZDxP5u6YJJ53zK2QOtRu+gsaVoV
        yq+CaiqsiODGyUo7ExqQZDusWDynZEwHxNSCs94zpfE00sAp2KAFhUDyafKLvue+v4XiXjZPMip
        p2zuYaYRhT2TZRCkuzMM+jLbioGGK1tkZyoFyuhFLsj8mjd6geMWynJNiXQnX7Zdo+0Owhw==
X-Received: by 2002:a17:907:2c44:b0:731:85d9:786e with SMTP id hf4-20020a1709072c4400b0073185d9786emr10100028ejc.102.1660211191118;
        Thu, 11 Aug 2022 02:46:31 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7Fl6YqVMzFLUemyPIKrf7zMCiGLb3O/b0wMQ73HM1yz3tBhozOm4xiI4edvCjGj00XMZ76Aw==
X-Received: by 2002:a17:907:2c44:b0:731:85d9:786e with SMTP id hf4-20020a1709072c4400b0073185d9786emr10100013ejc.102.1660211190868;
        Thu, 11 Aug 2022 02:46:30 -0700 (PDT)
Received: from redhat.com ([2.52.152.113])
        by smtp.gmail.com with ESMTPSA id y2-20020aa7d502000000b00440ced0e117sm5334992edq.58.2022.08.11.02.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 02:46:30 -0700 (PDT)
Date:   Thu, 11 Aug 2022 05:46:27 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Hulk Robot <hulkci@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: virtio_bt: fix device removal
Message-ID: <20220811094542.268519-1-mst@redhat.com>
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

The cost of the hack is a single skb wasted on an unused bt device.

NB2: with this fix in place driver still suffers from a race condition
if an interrupt triggers while device is being reset.  To fix, in the
virtbt_close() callback we should deactivate all interrupts.  To be
fixed.

squashed fixup: bluetooth: virtio_bt: fix an error code in probe()

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20220811080943.198245-1-mst@redhat.com>
---

changes from v2:
	tkeaked commit log to make lines shorter
changes from v1:
	fixed error handling

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

