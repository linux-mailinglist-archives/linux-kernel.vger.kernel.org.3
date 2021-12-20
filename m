Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D7047AA1E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 14:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhLTNHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 08:07:02 -0500
Received: from smtp1.axis.com ([195.60.68.17]:17070 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232629AbhLTNHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 08:07:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1640005621;
  x=1671541621;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WaxVAs1ueWqebp9zPoOJfkKS0rODc9paXkK8rXkLlR4=;
  b=RYOAYm3aTTo93PYBnS/o9PQql4ahauq9I1GUso4u8I+NZBGwM8LrQqHl
   lcA8HZsOWp3CF0Ald+Ty00bRc+WVcXaQIuGAs3IZpjYvitEgpUISHbKc3
   FQUitevYVfWIDXN4U6wqrZIUcDvzUxM3rJ3d1k3HmVk2FhoJ6jWttvCUR
   J3aPfMs88T231KY5y5/5h+waYMEnaKtZbVbgEfSCQ8ZcP3Ap3HJfNey1J
   lIYTRyY6vCgTZR9TdZ7MvuE0+dVRZtKqXS1VvsmPW7RT5RtBQCIAXCUgN
   l00x0pvU1Kq0BChAeLVZba7bYG8wBwoEVc85yDMs3jNuKFhQJ3GYFBlPW
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Viresh Kumar <vireshk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>
CC:     <kernel@axis.com>, <mst@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <linux-gpio@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] gpio: virtio: remove timeout
Date:   Mon, 20 Dec 2021 14:06:56 +0100
Message-ID: <20211220130656.16900-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver imposes an arbitrary one second timeout on virtio requests,
but the specification doesn't prevent the virtio device from taking
longer to process requests, so remove this timeout to support all
systems and device implementations.

Fixes: 3a29355a22c0275fe86 ("gpio: Add virtio-gpio driver")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/gpio/gpio-virtio.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index 84f96b78f32a..9f4941bc5760 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -100,11 +100,7 @@ static int _virtio_gpio_req(struct virtio_gpio *vgpio, u16 type, u16 gpio,
 	virtqueue_kick(vgpio->request_vq);
 	mutex_unlock(&vgpio->lock);
 
-	if (!wait_for_completion_timeout(&line->completion, HZ)) {
-		dev_err(dev, "GPIO operation timed out\n");
-		ret = -ETIMEDOUT;
-		goto out;
-	}
+	wait_for_completion(&line->completion);
 
 	if (unlikely(res->status != VIRTIO_GPIO_STATUS_OK)) {
 		dev_err(dev, "GPIO request failed: %d\n", gpio);
-- 
2.33.1

