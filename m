Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5CB4E42DA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238495AbiCVPWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238426AbiCVPVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:21:46 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6158B6C5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 08:20:00 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id ga31-20020a1709070c1f00b006cec400422fso8867025ejc.22
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 08:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=IJFULH6pKDrAUy1ZQEAU8LTsS220SswLQoRQfxb9psg=;
        b=YFUn96dr37yG0lQeXq/lDO95znaH8jW2VOFdk+L86Mg83BObCFxjdq8YnJFleyb0pq
         cULhfsNu/0JB+CFnzxXxtV0VIMZQdSkyYRNulowbWsaeCvz8uPhL7B/et4Wizq0fCikK
         yTaw7DgW766ReatUBDQCTTChgqW9xD2Ynxx/GayEf9Agklkj2R5ERpGCy1n/qUjvbDzH
         TurXiH/dTM6/HuzX1m/e1l8CdAZzysLKZs/eDrZXxWbQ5LUIzqKHP2QDBIbkJ4L/a9yD
         gWd5c0WB/ayGXRmsmhbNt/Yky+Bk4Fc+hnVCMVJuYuVQPFLQHBeDPradPMyxEK+T5fMI
         xHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=IJFULH6pKDrAUy1ZQEAU8LTsS220SswLQoRQfxb9psg=;
        b=sFWIER2STfEIhIReojYYF0jZlp2WgEY+Vzg3bRJZAKcy6jESb4U5LnBe4VKUoiDChl
         UdcyKoTfWv84TeLDZLMmCPHI+zbYgM7Z64Kymb/D52ILsYiOgIsmY8MJ0BflwKgyPPoF
         c1lUaIwsMxWRnq/yY+Pp93r2ZLgH+ZEo8F4AOeUwpUFnmnQaxTW9Jw9sbCe8T/wO5mjX
         zqnm4yxvNHoDiLVYKwMv/RaIyUAqo6mgeWb8zGyiF1XkYuiDynDoI679w6Cpr42Bcsey
         yOKJ3bPpgRqVSHrsTptA2/DEnQe8sw4ETCJcKtkj2CQeKEU5ocx3dKQZeMoQ7raJ3G65
         GOaA==
X-Gm-Message-State: AOAM531k5l1rg3cBppV/VY45TQj16/WOiu0iRE9ZgvPK3pM8dixJWMpr
        e6EnPRaOk7NEhtSxf+5u8E3PGMf2Vw==
X-Google-Smtp-Source: ABdhPJxLeI2hnE89muaiQsoyzcHH44WDxqYrvusIyoe0uFU8N/jP01aruiXkOUGBs4/g8QolztLfnVbwEg==
X-Received: from keirf.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:29e7])
 (user=keirf job=sendgmr) by 2002:a17:906:99c3:b0:6df:a289:ed3a with SMTP id
 s3-20020a17090699c300b006dfa289ed3amr23196242ejn.660.1647962398266; Tue, 22
 Mar 2022 08:19:58 -0700 (PDT)
Date:   Tue, 22 Mar 2022 15:19:52 +0000
Message-Id: <20220322151952.2950143-1-keirf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH v2] virtio: pci: sanity check bar indexes
From:   Keir Fraser <keirf@google.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     kernel-team@android.com, Keir Fraser <keirf@google.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bar index is used as an index into the device's resource list
and should be checked as within range for a standard bar.

Also clean up an existing check to consistently use PCI_STD_NUM_BARS.

Signed-off-by: Keir Fraser <keirf@google.com>
---
 drivers/virtio/virtio_pci_modern.c     | 10 ++++++++--
 drivers/virtio/virtio_pci_modern_dev.c |  8 +++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 5455bc041fb6..84bace98dff5 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -293,7 +293,7 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
 
 	for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR); pos > 0;
 	     pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
-		u8 type, cap_len, id;
+		u8 type, cap_len, id, res_bar;
 		u32 tmp32;
 		u64 res_offset, res_length;
 
@@ -317,7 +317,12 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
 
 		/* Type, and ID match, looks good */
 		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
-							 bar), bar);
+							 bar), &res_bar);
+		if (res_bar >= PCI_STD_NUM_BARS) {
+			dev_err(&dev->dev, "%s: shm cap with bad bar: %d\n",
+				__func__, res_bar);
+			continue;
+		}
 
 		/* Read the lower 32bit of length and offset */
 		pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap,
@@ -337,6 +342,7 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
 						     length_hi), &tmp32);
 		res_length |= ((u64)tmp32) << 32;
 
+		*bar = res_bar;
 		*offset = res_offset;
 		*len = res_length;
 
diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index e8b3ff2b9fbc..a6911d1e212a 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -35,6 +35,12 @@ vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
 	pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap, length),
 			      &length);
 
+	if (bar >= PCI_STD_NUM_BARS) {
+		dev_err(&dev->dev,
+			"virtio_pci: bad capability bar %u\n", bar);
+		return NULL;
+	}
+
 	if (length <= start) {
 		dev_err(&dev->dev,
 			"virtio_pci: bad capability len %u (>%u expected)\n",
@@ -120,7 +126,7 @@ static inline int virtio_pci_find_capability(struct pci_dev *dev, u8 cfg_type,
 				     &bar);
 
 		/* Ignore structures with reserved BAR values */
-		if (bar > 0x5)
+		if (bar >= PCI_STD_NUM_BARS)
 			continue;
 
 		if (type == cfg_type) {
-- 
2.35.1.894.gb6a874cedc-goog

