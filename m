Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392AB4905DF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 11:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238566AbiAQKZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 05:25:22 -0500
Received: from aposti.net ([89.234.176.197]:49620 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235846AbiAQKZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 05:25:21 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: [PATCH 1/2] iio: imu: st_lsm6dsx: Limit requested watermark value to hwfifo size
Date:   Mon, 17 Jan 2022 10:25:11 +0000
Message-Id: <20220117102512.31725-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of returning an error if the watermark value is too high, which
the core will silently ignore anyway, limit the value to the hardware
FIFO size; a lower-than-requested value is still better than using the
default, which is usually 1.

Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 727b4b6ac696..5fd46bf1a11b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -54,6 +54,7 @@
 #include <linux/iio/sysfs.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/minmax.h>
 #include <linux/pm.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
@@ -1607,8 +1608,7 @@ int st_lsm6dsx_set_watermark(struct iio_dev *iio_dev, unsigned int val)
 	struct st_lsm6dsx_hw *hw = sensor->hw;
 	int err;
 
-	if (val < 1 || val > hw->settings->fifo_ops.max_size)
-		return -EINVAL;
+	val = clamp_val(val, 1, hw->settings->fifo_ops.max_size);
 
 	mutex_lock(&hw->conf_lock);
 
-- 
2.34.1

