Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44594E5400
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244675AbiCWOJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244666AbiCWOJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:09:23 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BEA7EA3D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 07:07:53 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id 9-20020a05600c240900b0038c99b98f6fso660675wmp.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 07:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jP0KzNHLjXL65QouGmxzUA6j72GCAzLFmydsbCQzK+c=;
        b=Flm092IOzhTpQM+6LgcrxMhqgwZbTmWFAZZTWrHWcfLI09EbGCm28p89SXLeDHVOZS
         XtiNt9NbY/5FqsVScIjk7vcu4lDoKN2tcVYJNvb8e9BeXA3lbrlq1z990IiOBlg5VHmW
         Nntmig7AMEY9acXWJDlGpBpDuUNHI2zVYczf0k1QdVInnxOGD5M7SS+DRhre9fSSN91e
         uclsMCn8+O5MVoJKKgVY41F/vThwsktwufXuPskq7nXIqveJR6vv1EVuXrEdCjdw+VCG
         te7jp8DRLWcvvjzdTD4rwltMMjGxIiCZDG7G8Z/vhQtYayovpexziGO6Y02KPhCskk2G
         0lMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jP0KzNHLjXL65QouGmxzUA6j72GCAzLFmydsbCQzK+c=;
        b=QRyFedDYOXSBkfPayF8mx/a8eIf3SmRXjqOi813+H7Umg7mfBV9kiLthA7Hu7M5yQn
         yPe4o1FtIzA5JgXhEQmyk65/by8ZBLLhl3h4G96U1iWvnXr4wt9i+pA2nuY8MoVznJag
         BgwPli0PHx0kk2Hs+JAoz72biZ12vK8lVMkzuhl0wgc3a/ezXI0ul77H+zvJkdISAoXB
         ZSSm7rDOkPfH0fYKrNj9hUHPTQUjrnuWqATH633ukVdsF3vCN4k+tKlSUAIooZA4PCt8
         snhX/88UIQNNPUQdCvmfWgn6diznR00yP625tmU/1ig3vuAIYfAUSAOmD3I55wsinZo9
         GBaA==
X-Gm-Message-State: AOAM531koHrdhABDVGsq1Xhhh4mcgLKRHH7+RPSkxbRvsStg6OVZneWX
        hX36cegEgY0/7C5rrU1S9G4OzA4Bvg==
X-Google-Smtp-Source: ABdhPJzS/U76tN3svbEdV1F5BCZa9h9w/aKT1XqvQDq7aU+26RjZ/vjQ7Zsm2udC86R1bqNevOwvW1Qk4g==
X-Received: from keirf.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:29e7])
 (user=keirf job=sendgmr) by 2002:a7b:c30d:0:b0:381:4bb9:eede with SMTP id
 k13-20020a7bc30d000000b003814bb9eedemr9406529wmj.74.1648044471463; Wed, 23
 Mar 2022 07:07:51 -0700 (PDT)
Date:   Wed, 23 Mar 2022 14:07:27 +0000
Message-Id: <20220323140727.3499235-1-keirf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH v3] virtio: pci: check bar values read from virtio config space
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

virtio pci config structures may in future have non-standard bar
values in the bar field. We should anticipate this by skipping any
structures containing such a reserved value.

The bar value should never change: check for harmful modified values
we re-read it from the config space in vp_modern_map_capability().

Also clean up an existing check to consistently use PCI_STD_NUM_BARS.

Signed-off-by: Keir Fraser <keirf@google.com>
---
 drivers/virtio/virtio_pci_modern.c     | 12 +++++++++---
 drivers/virtio/virtio_pci_modern_dev.c |  9 ++++++++-
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 5455bc041fb6..6adfcd0297a7 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -293,7 +293,7 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
 
 	for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR); pos > 0;
 	     pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
-		u8 type, cap_len, id;
+		u8 type, cap_len, id, res_bar;
 		u32 tmp32;
 		u64 res_offset, res_length;
 
@@ -315,9 +315,14 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
 		if (id != required_id)
 			continue;
 
-		/* Type, and ID match, looks good */
 		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
-							 bar), bar);
+							 bar), &res_bar);
+		if (res_bar >= PCI_STD_NUM_BARS)
+			continue;
+
+		/* Type and ID match, and the BAR value isn't reserved.
+		 * Looks good.
+		 */
 
 		/* Read the lower 32bit of length and offset */
 		pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap,
@@ -337,6 +342,7 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
 						     length_hi), &tmp32);
 		res_length |= ((u64)tmp32) << 32;
 
+		*bar = res_bar;
 		*offset = res_offset;
 		*len = res_length;
 
diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index e8b3ff2b9fbc..591738ad3d56 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -35,6 +35,13 @@ vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
 	pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap, length),
 			      &length);
 
+	/* Check if the BAR may have changed since we requested the region. */
+	if (bar >= PCI_STD_NUM_BARS || !(mdev->modern_bars & (1 << bar))) {
+		dev_err(&dev->dev,
+			"virtio_pci: bar unexpectedly changed to %u\n", bar);
+		return NULL;
+	}
+
 	if (length <= start) {
 		dev_err(&dev->dev,
 			"virtio_pci: bad capability len %u (>%u expected)\n",
@@ -120,7 +127,7 @@ static inline int virtio_pci_find_capability(struct pci_dev *dev, u8 cfg_type,
 				     &bar);
 
 		/* Ignore structures with reserved BAR values */
-		if (bar > 0x5)
+		if (bar >= PCI_STD_NUM_BARS)
 			continue;
 
 		if (type == cfg_type) {
-- 
2.35.1.894.gb6a874cedc-goog

