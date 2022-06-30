Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5245623E5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 22:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237136AbiF3UIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 16:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237064AbiF3UIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:08:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1358645074
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 13:08:03 -0700 (PDT)
Received: from dimapc.. (109-252-118-164.nat.spd-mgts.ru [109.252.118.164])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D9A3F660198F;
        Thu, 30 Jun 2022 21:08:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656619681;
        bh=OQIxgpoWhcUtchUROpKKlYj3xDQCH7mCn7dt6yTFSNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RJqYssTHloREfETEr4/ELWVlz5ryzUQtRtsMFJ+BXtS78hxmCldhGjv2Ipo5HgsYE
         Ct5tNVNRiJfTN7OQNyyXTVZ3i9pK1N/a6TVpgICHhIFBxOYWDwStR3CrCjQiU/CV76
         yyzZtprEjw9PwR+xpJnr7vAM1Bfm+K5t8kzaNtI7pfOwY3Qfe291Gk3lBE56LNna9B
         yne5jORmoGDdOebYYXqzp2S7gKSIxyFvRvPIKLYnvNvToO6Uc3Hz/aNgo5a/39s0NO
         uy683g/KL/cWAUewtjfZC/YxIcOharIs17Au59m8lATHQ7QNlwC2ouUkZZq6YGUfWU
         GtVfLbcrZ/xBw==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas_os@shipmail.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com
Subject: [PATCH v7 8/9] drm/virtio: Use dev_is_pci()
Date:   Thu, 30 Jun 2022 23:07:25 +0300
Message-Id: <20220630200726.1884320-9-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220630200726.1884320-1-dmitry.osipenko@collabora.com>
References: <20220630200726.1884320-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use common dev_is_pci() helper to replace the strcmp("pci") used by driver.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 0141b7df97ec..0035affc3e59 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -87,7 +87,7 @@ static int virtio_gpu_probe(struct virtio_device *vdev)
 		return PTR_ERR(dev);
 	vdev->priv = dev;
 
-	if (!strcmp(vdev->dev.parent->bus->name, "pci")) {
+	if (dev_is_pci(vdev->dev.parent)) {
 		ret = virtio_gpu_pci_quirk(dev);
 		if (ret)
 			goto err_free;
-- 
2.36.1

