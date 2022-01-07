Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B74487400
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 09:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbiAGIOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 03:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbiAGIOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 03:14:08 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F513C061201
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 00:14:08 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1n5kNv-0001i6-O6; Fri, 07 Jan 2022 09:14:03 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1n5kNv-00Bog1-3v; Fri, 07 Jan 2022 09:14:03 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: adc: tsc2046: fix memory corruption by preventing array overflow
Date:   Fri,  7 Jan 2022 09:14:01 +0100
Message-Id: <20220107081401.2816357-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On one side we have indio_dev->num_channels includes all physical channels +
timestamp channel. On other side we have an array allocated only for
physical channels. So, fix memory corruption by ARRAY_SIZE() instead of
num_channels variable.

Fixes: 9374e8f5a38d ("iio: adc: add ADC driver for the TI TSC2046 controller")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/iio/adc/ti-tsc2046.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
index 91f6bd5effe7..8126084616e6 100644
--- a/drivers/iio/adc/ti-tsc2046.c
+++ b/drivers/iio/adc/ti-tsc2046.c
@@ -395,7 +395,7 @@ static int tsc2046_adc_update_scan_mode(struct iio_dev *indio_dev,
 	mutex_lock(&priv->slock);
 
 	size = 0;
-	for_each_set_bit(ch_idx, active_scan_mask, indio_dev->num_channels) {
+	for_each_set_bit(ch_idx, active_scan_mask, ARRAY_SIZE(priv->l)) {
 		size += tsc2046_adc_group_set_layout(priv, group, ch_idx);
 		tsc2046_adc_group_set_cmd(priv, group, ch_idx);
 		group++;
@@ -561,7 +561,7 @@ static int tsc2046_adc_setup_spi_msg(struct tsc2046_adc_priv *priv)
 	 * enabled.
 	 */
 	size = 0;
-	for (ch_idx = 0; ch_idx < priv->dcfg->num_channels; ch_idx++)
+	for (ch_idx = 0; ch_idx < ARRAY_SIZE(priv->l); ch_idx++)
 		size += tsc2046_adc_group_set_layout(priv, ch_idx, ch_idx);
 
 	priv->tx = devm_kzalloc(&priv->spi->dev, size, GFP_KERNEL);
-- 
2.30.2

