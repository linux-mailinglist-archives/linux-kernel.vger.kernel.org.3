Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9674E2CD4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347134AbiCUPvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346428AbiCUPvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:51:02 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4C95DA5F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:49:37 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id f18-20020adf9f52000000b00203d86759beso3226880wrg.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hNRenQ/lSqRsbNdjS1OJ6PrzHTYT9LS0Up7espxjzbo=;
        b=edYcZRvA6CGMSMA351q/P+wRqsya8LcD7GhAFvlkPB6/7XzeKQvj+wZZfRBmEu2pUn
         YDR3+qBC3ByfkclRlOEF3W9KMwBYf4m1MVscmBV0CgqPHIOKtAaY7d/XuUsHSnPAHiDY
         cxpM/R8F7wJFzW8ErZrbqZkpn0h6JAzl4cCsAjaGr01cyD8cnOyc+rlDm4L46c3ynkql
         67YhJJzl+yE6zRKSIrASHUSr7RS1vH9E8FsvciJLRITDoNQItL9c1mq9orZ9GfFjqJnb
         PFUEI5UBLoqzJ5JwXwiIiE6jI7LzUxmiFXoa2BfEl1hUqsSAddNuOW1RpymSLNtczr+R
         199w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hNRenQ/lSqRsbNdjS1OJ6PrzHTYT9LS0Up7espxjzbo=;
        b=BRhr3SRnJqn4TDNIvxqxvzI7V4SJk0L5AaXNhChoIHa21Qrs+tljUms4iD3PBb+j1+
         ZY/LB+hkn11Kzf/oFlOrHlUV2od6amMmTC5QFLuGDsso2gNk1dQRm63frBNQydN49hSN
         /JUNP6nIWujV/n67cnmmq1h+ClSzA8kTyexaHZhDQdqsFj8HaqIxDPRzdnz4EaaccSSj
         YlxRrIwBZOdxq5xCfuJuHp5imFkO5aiWCtTZYENcWKDBHq9NzxFaJRIzpHehtfkUweZG
         0AfdJEe5D1EQcwi6XRRd6k4jgwdcP7cGM+ern6+bg3Q46gLI3BoWqtfeVoHfsc6NnJ1w
         BVgw==
X-Gm-Message-State: AOAM5313cHB0aq9LhVY7F07/DJnrwfJ5Wmu8B8DYqlGU0Ap/Qr+7dtmr
        pvCTxVa0J61BMOA92IXHdjOFjqSeig==
X-Google-Smtp-Source: ABdhPJxlEJpdslm5zXqini+LFmrIjDXvzaNRghygrkSHxpVPZPydk8p9I4CLXTtDldJPZ2DGt/4JLHjuuQ==
X-Received: from keirf.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:29e7])
 (user=keirf job=sendgmr) by 2002:a05:600c:3594:b0:38c:adbc:4850 with SMTP id
 p20-20020a05600c359400b0038cadbc4850mr3124562wmq.30.1647877775759; Mon, 21
 Mar 2022 08:49:35 -0700 (PDT)
Date:   Mon, 21 Mar 2022 15:49:31 +0000
Message-Id: <20220321154931.859511-1-keirf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH] virtio: pci: Sanity check the bar index in find_shm_cap
From:   Keir Fraser <keirf@google.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     Keir Fraser <keirf@google.com>,
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

Signed-off-by: Keir Fraser <keirf@google.com>
---
 drivers/virtio/virtio_pci_modern.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

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
 
-- 
2.35.1.894.gb6a874cedc-goog

